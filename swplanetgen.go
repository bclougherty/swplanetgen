package swplanetgen

import (
	"database/sql"
	"fmt"
	"log"
	"math/rand"
	"strings"

	// MySQL
	_ "github.com/go-sql-driver/mysql"
)

// Set the category enum values
const (
	_                = iota
	CategoryFunction = iota
	CategoryGovernment
	CategoryType
	CategoryTerrain
	CategoryTemperature
	CategoryGravity
	CategoryAtmosphere
	CategoryHydrosphere
	CategoryStarport
	CategoryTechlevel
)

// Category describes a category of planet generation
type Category struct {
	Ident    int
	Name     string
	Table    string
	MapTable string
	RollType string
}

// Planet is the full data representing a generated planet
type Planet struct {
	Function    *Result
	Government  *Result
	Type        *Result
	Terrain     *Result
	Temperature *Result
	Gravity     *Result
	Atmosphere  *Result
	Hydrosphere *Result
	Starport    *Result
	TechLevel   *Result
	HoursPerDay int
	DaysPerYear int
	Population  int
}

// Incompatibility includes all the data to describe an incompatible set of generation parameters
type Incompatibility struct {
	Category             int
	CategoryIdent        int
	IncompatibleCategory int
	IncompatibleIdent    int
	Description          string
}

// IncompatibilityDescription is a human-readable version of an incompatibility
type IncompatibilityDescription struct {
	Category             string
	Name                 string
	IncompatibleCategory string
	IncompatibleName     string
	Description          string
}

// Modifier indicates that a category choice impacts the roll for another category
type Modifier struct {
	Category            int
	CategoryIdent       int
	ModifiedCategory    int
	CategoryDescription string
	ModifierDirection   string
	Amount              int
}

// Result from sub-method
type Result struct {
	Ident             int
	Raw               int
	Name              string
	Description       string
	Modifiers         []Modifier
	Incompatibilities []Incompatibility
}

func d6() int {
	return rand.Intn(6) + 1
}

func twod6() int {
	return (rand.Intn(6) + 1) + (rand.Intn(6) + 1)
}

func d6percentile() int {
	return (d6() * 10) + d6()
}

func contains(s []int, e int) bool {
	for _, a := range s {
		if a == e {
			return true
		}
	}
	return false
}

// GeneratePlanet puts all the pieces together
func GeneratePlanet() (*Planet, error) {
	db, err := sql.Open("mysql", "swplanetgen:sqplanetgen!pass@database.aseriesoftub.es/swplanetgen")
	if err != nil {
		return nil, err
	}
	defer db.Close()

	// Open doesn't open a connection. Validate DSN data:
	err = db.Ping()
	if err != nil {
		return nil, err
	}

	var allCategories []Category
	var allIncompatibilities []Incompatibility
	var allModifiers []Modifier

	planet := &Planet{}

	allCategories, err = categories(db)

	for _, category := range allCategories {
		incompatibleRolls, err := incompatibleRolls(allIncompatibilities, category, db)
		if err != nil {
			return nil, err
		}

		roll := -1

		for roll < 0 {
			switch category.RollType {
			case "d6percentile":
				roll = modifiedRoll(d6percentile(), category, allModifiers)

				if roll < 11 {
					roll = 11
				}
				if roll > 66 {
					roll = 66
				}
			case "2d6":
				roll = modifiedRoll(twod6(), category, allModifiers)

				if roll < 2 {
					roll = 2
				}
				if roll > 12 {
					roll = 12
				}

			default:
				roll = 0
			}

			if contains(incompatibleRolls, roll) {
				roll = -1
			}
		}

		if roll > 0 {
			var result Result

			query := fmt.Sprintf("select `t`.`id`, `t`.`name`, `t`.`description` from `%s` `m` join `%s` `t` on `m`.`target_id` = `t`.`id` where `m`.`roll` = ?", category.MapTable, category.Table)

			err := db.QueryRow(query, roll).Scan(&result.Ident, &result.Name, &result.Description)
			if err != nil {
				return nil, err
			}

			result.Raw = roll

			result.Incompatibilities, err = categoryIncompatibilities(category.Ident, result.Ident, db)

			for _, i := range result.Incompatibilities {
				allIncompatibilities = append(allIncompatibilities, i)
			}

			result.Modifiers, err = categoryModifiers(category.Ident, result.Ident, db)

			for _, m := range result.Modifiers {
				allModifiers = append(allModifiers, m)
			}

			switch category.Ident {
			case CategoryFunction:
				planet.Function = &result
			case CategoryGovernment:
				planet.Government = &result
			case CategoryType:
				planet.Type = &result
			case CategoryTerrain:
				planet.Terrain = &result
			case CategoryTemperature:
				planet.Temperature = &result
			case CategoryGravity:
				planet.Gravity = &result
			case CategoryAtmosphere:
				planet.Atmosphere = &result
			case CategoryHydrosphere:
				planet.Hydrosphere = &result
			case CategoryStarport:
				planet.Starport = &result
			case CategoryTechlevel:
				planet.TechLevel = &result
			}
		}
	}

	planet.HoursPerDay = hoursPerDay()
	planet.DaysPerYear = daysPerYear()

	populationModifier := 0
	if planet.Type.Name == "Asteroid Belt" || planet.Type.Name == "Artificial" {
		populationModifier -= 2
	}

	if planet.Terrain.Name == "Barren" || planet.Terrain.Name == "Cave" || planet.Terrain.Name == "Volcanic" {
		populationModifier -= 2
	} else if planet.Terrain.Name == "Ocean" {
		populationModifier--
	} else if planet.Terrain.Name == "Urban" {
		populationModifier++
	}

	planet.Population = population(populationModifier)

	return planet, nil
}

// IncompatibleConditions returns a human-readable version of the incompatibility map
func IncompatibleConditions() ([]IncompatibilityDescription, error) {
	db, err := sql.Open("mysql", "swplanetgen:sqplanetgen!pass@database.aseriesoftub.es/swplanetgen")
	if err != nil {
		return nil, err
	}
	defer db.Close()

	// Open doesn't open a connection. Validate DSN data:
	err = db.Ping()
	if err != nil {
		return nil, err
	}

	var retval []IncompatibilityDescription
	const query = "SELECT `c1`.`name`, `c1`.`table`, `c2`.`name`, `c2`.`table`, `ic`.`category_id`, `ic`.`incompatible_category_id`, `ic`.`description` FROM `incompatible_conditions` `ic` JOIN `categories` `c1` ON (`ic`.`category` = `c1`.`id`) JOIN `categories` `c2` ON (`ic`.`incompatible_category` = `c2`.`id`)"

	rows, err := db.Query(query)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	for rows.Next() {
		var name1, name2 string
		var table1, table2 string
		var id1, id2 int
		var type1, type2 string
		var description string

		if err := rows.Scan(&name1, &table1, &name2, &table2, &id1, &id2, &description); err != nil {
			log.Fatal(err)
		}

		subquery := "SELECT `name` FROM `%s` WHERE `id` = ?"
		db.QueryRow(fmt.Sprintf(subquery, table1), id1).Scan(&type1)
		db.QueryRow(fmt.Sprintf(subquery, table2), id2).Scan(&type2)

		incompatibility := IncompatibilityDescription{
			Category:             name1,
			Name:                 type1,
			IncompatibleCategory: name2,
			IncompatibleName:     type2,
			Description:          description,
		}

		retval = append(retval, incompatibility)
	}

	if err := rows.Err(); err != nil {
		return nil, err
	}

	return retval, nil
}

func categories(db *sql.DB) ([]Category, error) {
	const query = "SELECT `id`, `name`, `table`, `map_table`, `roll_type` FROM `categories` ORDER BY `order` ASC"

	var categories []Category

	rows, err := db.Query(query)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	for rows.Next() {
		category := Category{}
		if err := rows.Scan(&category.Ident, &category.Name, &category.Table, &category.MapTable, &category.RollType); err != nil {
			log.Fatal(err)
		}

		categories = append(categories, category)
	}

	if err := rows.Err(); err != nil {
		return nil, err
	}

	return categories, nil
}

func hoursPerDay() int {
	switch d6() {
	case 1, 2:
		return 10 + twod6()
	case 3, 4:
		return 20 + d6()
	case 5:
		return 25 + d6()
	case 6:
		return 30 + d6()
	}

	return 0
}

func daysPerYear() int {
	var base = d6() * 15

	switch d6() {
	case 1:
		return base + 75
	case 2:
		return base + 150
	case 3, 4:
		return base + 225
	case 5:
		return base + 300
	case 6:
		return base + 375
	}

	return 0
}

func population(rollMod int) int {
	var population int

	magnitude := d6() + rollMod
	order := d6()
	number := d6()

	if magnitude < 1 {
		magnitude = 1
	}
	if magnitude > 6 {
		magnitude = 6
	}

	if number < 4 {
		population = rand.Intn(5) + 1
	} else {
		population = rand.Intn(4) + 6
	}

	switch order {
	case 3, 4:
		population *= 10
		break
	case 5, 6:
		population *= 100
		break
	}

	switch magnitude {
	case 1:
		return population
	case 2, 3:
		return population * 1000
	case 4, 5:
		return population * 1000000
	case 6:
		return population * 1000000000
	}

	return 0
}

func incompatibleRolls(incompatibilities []Incompatibility, category Category, db *sql.DB) ([]int, error) {
	var incompatibleRolls []int
	var incompatibleTargets []string

	for _, i := range incompatibilities {
		if i.IncompatibleCategory == category.Ident {
			incompatibleTargets = append(incompatibleTargets, fmt.Sprintf("%d", i.IncompatibleIdent))
		}
	}

	if len(incompatibleTargets) == 0 {
		return incompatibleRolls, nil
	}

	query := fmt.Sprintf("select `m`.`roll` from `%s` `m` where `m`.`target_id` IN (%s)", category.MapTable, strings.Join(incompatibleTargets, ", "))

	rows, err := db.Query(query)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	for rows.Next() {
		var roll int
		if err := rows.Scan(&roll); err != nil {
			log.Fatal(err)
		}

		incompatibleRolls = append(incompatibleRolls, roll)
	}

	if err := rows.Err(); err != nil {
		return nil, err
	}

	return incompatibleRolls, nil
}

func categoryIncompatibilities(categoryID int, resultID int, db *sql.DB) ([]Incompatibility, error) {
	subquery := "SELECT `category`, `category_id`, `incompatible_category`, `incompatible_category_id`, `description` FROM `incompatible_conditions` WHERE `category` = ? AND `category_id` = ?"

	rows, err := db.Query(subquery, categoryID, resultID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var incoms []Incompatibility

	for rows.Next() {
		incompatibility := Incompatibility{}
		if err := rows.Scan(&incompatibility.Category, &incompatibility.CategoryIdent, &incompatibility.IncompatibleCategory, &incompatibility.IncompatibleIdent, &incompatibility.Description); err != nil {
			return nil, err
		}

		incoms = append(incoms, incompatibility)
	}

	if err := rows.Err(); err != nil {
		return nil, err
	}

	return incoms, nil
}

func categoryModifiers(categoryID int, resultID int, db *sql.DB) ([]Modifier, error) {
	subquery := "SELECT `m`.`category`, `m`.`category_id`, `m`.`modified_category`, `c`.`name`, `m`.`modifier_direction`, `m`.`modifier` FROM `modifiers` `m` JOIN `categories` `c` ON (`m`.`modified_category` = `c`.`id`) WHERE `m`.`category` = ? AND `m`.`category_id` = ?"

	rows, err := db.Query(subquery, categoryID, resultID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var mods []Modifier

	for rows.Next() {
		mod := Modifier{}
		if err := rows.Scan(&mod.Category, &mod.CategoryIdent, &mod.ModifiedCategory, &mod.CategoryDescription, &mod.ModifierDirection, &mod.Amount); err != nil {
			return nil, err
		}

		mods = append(mods, mod)
	}

	if err := rows.Err(); err != nil {
		return nil, err
	}

	return mods, nil
}

func modifiedRoll(roll int, category Category, modifiers []Modifier) int {
	if len(modifiers) == 0 {
		return roll
	}

	moddedRoll := roll

	for _, mod := range modifiers {
		if mod.ModifiedCategory == category.Ident {
			if mod.ModifierDirection == "+" {
				moddedRoll = roll + mod.Amount
			} else {
				moddedRoll = roll - mod.Amount
			}
		}
	}

	return moddedRoll
}
