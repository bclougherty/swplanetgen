package main

import (
	"database/sql"
	"fmt"
	"math/rand"
	"os"
	"strings"
	"time"

	_ "github.com/go-sql-driver/mysql"
)

// Planet is the full data representing a generated planet
type Planet struct {
	Function    *Result
	Government  *Result
	PlanetType  *Result
	Terrain     *Result
	Temperature *Result
	Gravity     *Result
	Atmosphere  *Result
	Starport    *Result
	TechLevel   *Result
	HoursPerDay int
	DaysPerYear int
}

func (p Planet) String() string {
	lines := []string{}
	lines = append(lines, fmt.Sprintf(" Planet Function: %s", p.Function.Name))
	// lines = append(lines, fmt.Sprintf("    Description: %s", p.Function.Description))

	lines = append(lines, fmt.Sprintf("      Government: %s", p.Government.Name))
	// lines = append(lines, fmt.Sprintf("    Description: %s", p.Government.Description))

	lines = append(lines, fmt.Sprintf("     Planet Type: %s", p.PlanetType.Name))
	// lines = append(lines, fmt.Sprintf("    Description: %s", p.PlanetType.Description))

	lines = append(lines, fmt.Sprintf("         Terrain: %s", p.Terrain.Name))
	// lines = append(lines, fmt.Sprintf("    Description: %s", p.Terrain.Description))

	lines = append(lines, fmt.Sprintf("     Temperature: %s", p.Temperature.Name))
	// lines = append(lines, fmt.Sprintf("    Description: %s", p.Temperature.Description))

	lines = append(lines, fmt.Sprintf("         Gravity: %s", p.Gravity.Name))
	// lines = append(lines, fmt.Sprintf("    Description: %s", p.Gravity.Description))

	lines = append(lines, fmt.Sprintf("      Atmosphere: %s", p.Atmosphere.Name))
	// lines = append(lines, fmt.Sprintf("    Description: %s", p.Atmosphere.Description))

	lines = append(lines, fmt.Sprintf("        Starport: %s", p.Starport.Name))
	// lines = append(lines, fmt.Sprintf("    Description: %s", p.Starport.Description))

	lines = append(lines, fmt.Sprintf("      Tech Level: %s", p.TechLevel.Name))
	// lines = append(lines, fmt.Sprintf("    Description: %s", p.TechLevel.Description))

	lines = append(lines, fmt.Sprintf("   Hours per Day: %d", p.HoursPerDay))
	lines = append(lines, fmt.Sprintf("   Days per Year: %d", p.DaysPerYear))

	return strings.Join(lines, "\n")
}

// Result from sub-method
type Result struct {
	Raw         int
	Name        string
	Description string
	Modifiers   map[int]string
}

func (r Result) String() string {
	return fmt.Sprintf("RESULT - raw: %d, name: %s, description: %s", r.Raw, r.Name, r.Description)
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

// GeneratePlanet puts all the pieces together
func GeneratePlanet() (*Planet, error) {
	db, err := sql.Open("mysql", "swplanetgenapp:sqplanetgenapp!pass@/swplanetgen")
	if err != nil {
		return nil, err
	}
	defer db.Close()

	// Open doesn't open a connection. Validate DSN data:
	err = db.Ping()
	if err != nil {
		return nil, err
	}

	functionResult, err := planetFunction(db)
	governmentResult, err := government(db)
	planetTypeResult, err := planetType(db)
	terrainResult, err := terrain(db)
	temperatureResult, err := temperature(db)
	gravityResult, err := gravity(db)
	atmosphereResult, err := atmosphere(db)
	starportResult, err := starport(db)
	techLevelResult, err := techLevel(db)

	return &Planet{
		Function:    functionResult,
		Government:  governmentResult,
		PlanetType:  planetTypeResult,
		Terrain:     terrainResult,
		Temperature: temperatureResult,
		Gravity:     gravityResult,
		Atmosphere:  atmosphereResult,
		Starport:    starportResult,
		TechLevel:   techLevelResult,
		HoursPerDay: hoursPerDay(),
		DaysPerYear: daysPerYear(),
	}, nil
}

func planetFunction(db *sql.DB) (*Result, error) {
	var roll = d6percentile()
	var result Result
	const query = "select `t`.`name`, `t`.`description` from `planet_function_roll_map` `m` join `planet_functions` `t` on `m`.`planet_function_id` = `t`.`id` where `m`.`roll` = ?"

	err := db.QueryRow(query, roll).Scan(&result.Name, &result.Description)

	result.Raw = roll

	return &result, err
}

func government(db *sql.DB) (*Result, error) {
	var roll = d6percentile()
	var result Result
	const query = "select `t`.`name`, `t`.`description` from `government_roll_map` `m` join `governments` `t` on `m`.`government_id` = `t`.`id` where `m`.`roll` = ?"

	err := db.QueryRow(query, roll).Scan(&result.Name, &result.Description)

	result.Raw = roll

	return &result, err
}

func planetType(db *sql.DB) (*Result, error) {
	var roll = twod6()
	var result Result
	const query = "select `t`.`name`, `t`.`description` from `planet_type_roll_map` `m` join `planet_types` `t` on `m`.`planet_type_id` = `t`.`id` where `m`.`roll` = ?"

	err := db.QueryRow(query, roll).Scan(&result.Name, &result.Description)

	result.Raw = roll

	return &result, err
}

func terrain(db *sql.DB) (*Result, error) {
	var roll = d6percentile()
	var result Result
	const query = "select `t`.`name`, `t`.`description` from `terrain_roll_map` `m` join `terrains` `t` on `m`.`terrain_id` = `t`.`id` where `m`.`roll` = ?"

	err := db.QueryRow(query, roll).Scan(&result.Name, &result.Description)

	result.Raw = roll

	return &result, err
}

func temperature(db *sql.DB) (*Result, error) {
	var roll = twod6()
	var result Result
	const query = "select `t`.`name`, `t`.`description` from `temperature_roll_map` `m` join `temperatures` `t` on `m`.`temperature_id` = `t`.`id` where `m`.`roll` = ?"

	err := db.QueryRow(query, roll).Scan(&result.Name, &result.Description)

	result.Raw = roll

	return &result, err
}

func gravity(db *sql.DB) (*Result, error) {
	var roll = twod6()
	var result Result
	const query = "select `t`.`name`, `t`.`description` from `gravity_roll_map` `m` join `gravities` `t` on `m`.`gravity_id` = `t`.`id` where `m`.`roll` = ?"

	err := db.QueryRow(query, roll).Scan(&result.Name, &result.Description)

	result.Raw = roll

	return &result, err
}

func atmosphere(db *sql.DB) (*Result, error) {
	var roll = twod6()
	var result Result
	const query = "select `t`.`name`, `t`.`description` from `atmosphere_roll_map` `m` join `atmospheres` `t` on `m`.`atmosphere_id` = `t`.`id` where `m`.`roll` = ?"

	err := db.QueryRow(query, roll).Scan(&result.Name, &result.Description)

	result.Raw = roll

	return &result, err
}

func starport(db *sql.DB) (*Result, error) {
	var roll = twod6()
	var result Result
	const query = "select `t`.`name`, `t`.`description` from `starport_roll_map` `m` join `starports` `t` on `m`.`starport_id` = `t`.`id` where `m`.`roll` = ?"

	err := db.QueryRow(query, roll).Scan(&result.Name, &result.Description)

	result.Raw = roll

	return &result, err
}

func techLevel(db *sql.DB) (*Result, error) {
	var roll = twod6()
	var result Result
	const query = "select `t`.`name`, `t`.`description` from `tech_level_roll_map` `m` join `tech_levels` `t` on `m`.`tech_level_id` = `t`.`id` where `m`.`roll` = ?"

	err := db.QueryRow(query, roll).Scan(&result.Name, &result.Description)

	result.Raw = roll

	return &result, err
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

func main() {
	rand.Seed(time.Now().UTC().UnixNano())

	planet, err := GeneratePlanet()
	if err != nil {
		fmt.Printf("ERROR: %s\n", err.Error())
		os.Exit(1)
	}

	fmt.Printf("===Planet===\n%s\n", planet)
}
