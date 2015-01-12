# ************************************************************
# Sequel Pro SQL dump
# Version 4096
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.6.21)
# Database: swplanetgen
# Generation Time: 2015-01-12 02:52:28 +0000
# ************************************************************


# ************************************************************
# All text content is from Star Wars: Planets of the Galaxy,
# Volume 1. Copyright 1991, West End Games.
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table atmospheres
# ------------------------------------------------------------

DROP TABLE IF EXISTS `atmospheres`;

CREATE TABLE `atmospheres` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `atmospheres` WRITE;
/*!40000 ALTER TABLE `atmospheres` DISABLE KEYS */;

INSERT INTO `atmospheres` (`id`, `name`, `description`)
VALUES
	(1,'Type I (Breathable)','A Type I atmosphere has a proper mixture of oxygen, nitrogen and other gases so that humans and comparable races can breath it unassisted. These atmospheres may have contaminants that over the long term have a detrimental effect.\rPlanets with a Type I atmosphere will have life or at least had life recently.'),
	(2,'Type II (Breath Mask Suggested)','Type II atmospheres can support life without use of a breath mask, but either due to too much or too little atmospheric pressure or oxygen, or unusual gases or contaminants, it is recommended that a breath mask be worn. Without a breath mask, detrimental effects, such as slowed reactions, reduced brain activity, poisoning, or a myriad of other effects can begin to occur within just a few hours of exposure. Many alien races can comfortably breathe Type II atmospheres without having to resort to breath masks.\n\rPlanets with a Type II atmosphere will have life or at least had life recently.'),
	(3,'Type III (Breath Mask Required)','Type III atmospheres are unbreathable without a breath mask, again due to a number of possible characteristics. The atmosphere could be highly poisonous, or simply not have enough oxygen to breathe. Characters without breath masks can begin to suffer detrimental effects immediately. A small number of alien races (and certainly native creatures) will be able to breath these atmospheres unaided.\n\rType III atmosphere planets frequently support life.'),
	(4,'Type IV (Environment Suit Required)','Type N atmospheres are not only poisonous, but they are so reactive that they will cause injury to persons who are exposed to it. Environment suits, spacesuits or life-support equipment is required to venture through the atmosphere, or characters will suffer burns and other grievous injuries. If the planet is Frigid, a thermal suit may be necessary. These atmospheres may also be flammable or highly explosive. The gamemaster must customize the effects of the hostile atmosphere.');

/*!40000 ALTER TABLE `atmospheres` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table atmosphere_roll_map
# ------------------------------------------------------------

DROP TABLE IF EXISTS `atmosphere_roll_map`;

CREATE TABLE `atmosphere_roll_map` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `roll` int(11) DEFAULT NULL,
  `atmosphere_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `atmosphere_roll_map` WRITE;
/*!40000 ALTER TABLE `atmosphere_roll_map` DISABLE KEYS */;

INSERT INTO `atmosphere_roll_map` (`id`, `roll`, `atmosphere_id`)
VALUES
	(1,2,1),
	(2,3,1),
	(3,4,1),
	(4,5,1),
	(5,6,1),
	(6,7,1),
	(7,8,1),
	(8,9,1),
	(9,10,2),
	(10,11,3),
	(11,12,4);

/*!40000 ALTER TABLE `atmosphere_roll_map` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table categories
# ------------------------------------------------------------

DROP TABLE IF EXISTS `categories`;

CREATE TABLE `categories` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `order` int(11) DEFAULT NULL,
  `name` varchar(128) DEFAULT NULL,
  `table` varchar(128) DEFAULT NULL,
  `roll_type` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;

INSERT INTO `categories` (`id`, `order`, `name`, `table`, `roll_type`)
VALUES
	(1,1,'Planet Function','planet_functions','d6percentile'),
	(2,2,'Government','governments','d6percentile'),
	(3,3,'Planet Type','planet_types','2d6'),
	(4,4,'Terrain','terrains','d6percentile'),
	(5,5,'Temperature','temperatures','2d6');

/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table government_roll_map
# ------------------------------------------------------------

DROP TABLE IF EXISTS `government_roll_map`;

CREATE TABLE `government_roll_map` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `roll` int(11) DEFAULT NULL,
  `government_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `government_roll_map` WRITE;
/*!40000 ALTER TABLE `government_roll_map` DISABLE KEYS */;

INSERT INTO `government_roll_map` (`id`, `roll`, `government_id`)
VALUES
	(1,11,1),
	(2,12,2),
	(3,13,3),
	(4,14,3),
	(5,15,3),
	(6,16,3),
	(7,21,4),
	(8,22,4),
	(9,23,5),
	(10,24,5),
	(11,25,6),
	(12,26,7),
	(13,31,7),
	(14,32,8),
	(15,33,9),
	(16,34,9),
	(17,35,9),
	(18,36,9),
	(19,41,9),
	(20,42,9),
	(21,43,10),
	(22,44,10),
	(23,45,10),
	(24,46,1),
	(25,51,1),
	(26,52,1),
	(27,53,12),
	(28,54,13),
	(29,55,14),
	(30,56,15),
	(31,61,16),
	(32,62,17),
	(33,63,18),
	(34,64,18),
	(35,65,18),
	(36,66,18);

/*!40000 ALTER TABLE `government_roll_map` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table governments
# ------------------------------------------------------------

DROP TABLE IF EXISTS `governments`;

CREATE TABLE `governments` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `governments` WRITE;
/*!40000 ALTER TABLE `governments` DISABLE KEYS */;

INSERT INTO `governments` (`id`, `name`, `description`)
VALUES
	(1,'Alliance/Federation','Several different groups (tribes, nation-states, corporations or whatever else - you decide) have formed an alliance. The degree of cooperation and the vitality of the alliance differs from situation to situation. Typical purposes for alli- ance include an improved economy, mutual defense, or the arrival of a situation so compelling that the different groups can put aside their problems to accomplish \"a greater good.\" Be- trayal is always a possibility, especially if there are other competing alliances.'),
	(2,'Anarchy','Anarchists stand for the individual and his or her rights above all else, including government. Anarchist governments could conceivably be quite elaborate, but would exist only to insure that each individual has complete freedom.\n\rAnarchism is commonly perceived as a lack of law and order, and on many planets, that is indeed the truth.'),
	(3,'Competing States','Several nation-states, tribes or corporations are actively competing for control of the planet. The intensity and type of competition varies, and can range from economic competition to open war.'),
	(4,'Corporate Owned','This planet is owned by a corporation, trade guild or other large business interest. Most of these planets produce goods for use or resale by the parent corporation. Other Corporate planets are for the pleasure and relaxation of the execu- tives and employees - in essence, giant recre- ation planets. Residents are almost always employees of the corporation, and have strict guide- lines and rules to follow, such as having to pay rent on corporate housing, or being required to purchase goods only from corporate retailers.\n\rThe corporation is allowed to do whatever it likes (with the agreement of the Empire, of course). Conditions on planets are widely vari- able, from harsh and repressive to agreeable and comfortabie.'),
	(5,'Dictatorship','Dictatorships are commanded by a single indi- vidual, such as a charismatic military officer, or an insane politician who will execute anyone. Dictatorships are almost always repressive and intolerant of divergent political, philosophical and social views.'),
	(6,'Family','The most important social organization on the planet is the family. There are a variety of possible scenarios, including a pre-tribal state, where families have little or no technology and con- stantly engage in warfare with each other. At higher Tech Levels, a small group of elite families could control the government, either overtly or through behind the scenes manipulation of the government in power.'),
	(7,'Feudalism','A multi-structured social system, in which important officials (nobles or royalty) are en- trusted with a specific area of land. They must manage the territory, provide tax revenues to higher-level officials and make sure that the com- mands of these higher-level officials are carried out.'),
	(8,'Guild/Professional Organizations','The planet is controlled by a guild dedicated to the advancement of a particular occupation or philosophy. Many Trade planets are run by trade guilds (see Celanon). These guilds may also con- trol certain portions of the government, and subtly direct the kind of legislation and decisions that are made.'),
	(9,'Imperial Governor','This is a planet where the designated Imperial Governor has taken control, either due to civil unrest, sheer ego, or belief that the previous government was inept, disloyal or unresponsive.'),
	(10,'Military','Military planets are controlled by either the Imperial military or a local military organization. They tend to have governments which perpetuate only the military structure, ignoring the needs and desires of the civilian populations - martial law is a way of life. Harsh, brutal crackdowns can occur with only minor provocation. Civil rights take a low priority when compared to accom- plishing government goals.'),
	(11,'Monarchy','A type of government where absolute author- ity is granted to one individual, often called a king or queen. The leadership position is normally granted by heredity. Planets may have patriarchal (only male rulers) or matriarchal (only female rulers) societies.'),
	(12,'Organized Crime','A planetary or galaxy-wide criminal organization has established a government loyal to the criminal leaders. Organized crime planets are typically run so that only those who are unswervingly loyal to the criminal organization receive advancement and promotions; opponents are simply eliminated.\n\rOrganized crime may also covertly control a government by bribing or blackmailing officials, or threatening their families. These governments are typically oppressive.'),
	(13,'Participatory Democracy','Citizens vote directly on important issues (some advanced planets have citizens vote on virtually every proposed bill).'),
	(14,'Rebel Alliance','A government that supports the Rebel Alliance and its objectives. Few planets can risk openly supporting the Alliance (Alderaan is a painful example of what happens to openly rebellious worlds), but several planets secretly shuttle funds to Rebellion coffers, or offer safe passage for Rebel agents, supplies and weaponry. Hidden Rebel safe worlds also quaiify for this designation.'),
	(15,'Representative Democracy','Planets with a Representative Democracy have citizens choose officials, who are then charged with representing the \"public interest.\" These type of governments can experience radical shifts in goals and policy if the population is unsatisfied with performance and threatens to remove the representatives from office.'),
	(16,'Ruler by Selection/Rite','The ruler is chosen by a series of trials, physical, mental or both. While these governments are often found on more primitive planets, advanced civilizations may use complex testing methods to determine who is most fit to govern a planet, nation or locality.'),
	(17,'Theocracy','A government run by a religious organization. Typically, the citizens are required to participate in certain religious rites and profess faith in the tenets of the religion. Theocracies may be highly tolerant of divergent views, but some are also quite repressive.'),
	(18,'Tribal','Tribal governments seldom control more than a small portion of the planet. Tribes are groups of many families who have banded together for mutual survival, or who share common beliefs. Tribes are often precursors to city-states and nation-state governments, but many highly advanced and so- phisticated tribal governments are found on planets throughout the Star Wars universe. Tribes can be nomadic, depending almost entirely upon hunting and foraging for food, or they can settle, which indicates the development of agricuiture.');

/*!40000 ALTER TABLE `governments` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table gravities
# ------------------------------------------------------------

DROP TABLE IF EXISTS `gravities`;

CREATE TABLE `gravities` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `gravities` WRITE;
/*!40000 ALTER TABLE `gravities` DISABLE KEYS */;

INSERT INTO `gravities` (`id`, `name`, `description`)
VALUES
	(1,'Light','Planets with light gravity allow characters to lift heavier objects, but also throws off physical coor- dination. They also allow easier movement. There are few inhabited planets with light gravity.\n\rCharacters and creatures may take one speed action \"free,\" counting it as walking movement. Other speed actions reduce die codes as explained in The Star Wars Rules Companion. In very light gravities, the gamemaster may want to use the following optional modifiers: +1Dbonus to all Strength actions (except for resisting damage); -1D penalty for all Dexterity actions.'),
	(2,'Standard','Standard gravity is that which is most common on Imperial worlds, and therefore most comfortable for most races. Standard gravity includes several gradients of true gravitational pull, but is placed within this convenient grouping.'),
	(3,'Heavy','Heavy gravity planets have a much stronger pull than normal, the effects of which can be merely inconvenient or crippling. Planets with very heavy gravity may make a person\'s body so heavy that they cannot move. There are few planets with heavy gravity, and most of them are just barely beyond the Standard gravity classification. On these \"barely heavy\" gravity planets, even walking counts as a speed action (it is not \"free movement\").\n\rGamemasters can use the following optional modifiers for slightly heavier gravity planets: -ID to all Strength and Dexterity actions (except for resisting damage). Characters must make a mini- mum of a Moderate stamina check after every minute of heavy exertion, although checks may be made more difficult or frequent at the gamemaster\'s discretion. Characters who fail these stamina checks must rest for double the amount of time they were active or suffer a -3D penalty to all actions except resisting damage in combat. Additionally, when the character suffers damage from collisions or falling, increase the damage by a minimum of 1D.');

/*!40000 ALTER TABLE `gravities` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table gravity_roll_map
# ------------------------------------------------------------

DROP TABLE IF EXISTS `gravity_roll_map`;

CREATE TABLE `gravity_roll_map` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `roll` int(11) DEFAULT NULL,
  `gravity_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `gravity_roll_map` WRITE;
/*!40000 ALTER TABLE `gravity_roll_map` DISABLE KEYS */;

INSERT INTO `gravity_roll_map` (`id`, `roll`, `gravity_id`)
VALUES
	(1,2,1),
	(2,3,1),
	(3,4,1),
	(4,5,2),
	(5,6,2),
	(6,7,2),
	(7,8,2),
	(8,9,2),
	(9,10,2),
	(10,11,2),
	(11,12,3);

/*!40000 ALTER TABLE `gravity_roll_map` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table hydrospheres
# ------------------------------------------------------------

DROP TABLE IF EXISTS `hydrospheres`;

CREATE TABLE `hydrospheres` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table planet_function_roll_map
# ------------------------------------------------------------

DROP TABLE IF EXISTS `planet_function_roll_map`;

CREATE TABLE `planet_function_roll_map` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `roll` int(11) DEFAULT NULL,
  `planet_function_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `planet_function_roll_map` WRITE;
/*!40000 ALTER TABLE `planet_function_roll_map` DISABLE KEYS */;

INSERT INTO `planet_function_roll_map` (`id`, `roll`, `planet_function_id`)
VALUES
	(1,11,1),
	(2,12,2),
	(3,13,3),
	(4,14,4),
	(5,15,4),
	(6,16,4),
	(7,21,4),
	(8,22,5),
	(9,23,6),
	(10,24,7),
	(11,25,8),
	(12,26,8),
	(13,31,9),
	(14,32,10),
	(15,33,10),
	(16,34,11),
	(17,35,12),
	(18,36,12),
	(19,41,12),
	(20,42,13),
	(21,43,14),
	(22,44,14),
	(23,45,14),
	(24,46,14),
	(25,51,15),
	(26,52,15),
	(27,53,15),
	(28,54,15),
	(29,55,15),
	(30,56,16),
	(31,61,17),
	(32,62,18),
	(33,63,18),
	(34,64,19),
	(35,65,19),
	(36,66,19);

/*!40000 ALTER TABLE `planet_function_roll_map` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table planet_functions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `planet_functions`;

CREATE TABLE `planet_functions` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `planet_functions` WRITE;
/*!40000 ALTER TABLE `planet_functions` DISABLE KEYS */;

INSERT INTO `planet_functions` (`id`, `name`, `description`)
VALUES
	(1,'Abandoned Colony','This is a planet that was settled by another planet, a company or some other wealthy instituion. Then, for some reason, the colony was left behind: the homeworld could have been struck by plague or war, or the company could have run out of money. The planet might have been evacuated (only leaving ruins), or supply ships just never arrived, in which case the cola- nists were on their own: they may have devolved into barbarism and anarchy.'),
	(2,'Academic','Educational institutions are what is most important to the economy of this planet. Academic worlds typically have many universities and col- leges, which may be private, corporate or state run.\n\nOptions for low Tech Level worlds are varied: the university was purposefully established to remove students from the temptations of mod- ern comforts. Or, the natives may have had some contact with free-traders, and have committed all of their efforts to unlocking the secrets of modern technology.\n\nThis result doesn\'t necessarily mean academic worktowardsadegree.Tradeschools,institutions dedicated to unlocking the secrets of the Force (these will always be well hidden since the Em- peror has made it a priority to kill Force users), and survival schools are possible options.'),
	(3,'Administrative/Government','This world is bureaucracy at its largest. The main industry is the orderly (or at least managed) operation of a government, business, or other large institution. Imperial Sector Capitals often qualify for this designation, but the homeworlds of major, galaxy-spanning corpora- tions and institutions such as BoSS (Bureaus of Ships and Services) may also be considered Ad- ministrative in nature. Low Tech Level planets could also be administrative, especially if the economy is directed entirely by the government'),
	(4,'Agriculture','This planet is dedicated to the production of food. The types of products can include grains, vegetables,fruits,meats,vitamins,dietary supplements, and water. Many ocean planets also rely on agriculture, through fishing or algae and vitamin farms.'),
	(5,'Colony','This planet has been established and sponsored by another, more developed planet or corporation. Colonies are generally dependent upon the sponsor for supplies, and typically are subservient to its dictates. Colony worlds aren\'t independent entities, although there may be a separatist movement. Colony planets generally produce goods only for consumption by the spon- sor, and thus are often prevented from developing a self-sufficient economy or acquiring significant wealth. Many colonies are devoted to Agri- culture and Mining.'),
	(6,'Disaster','Disaster planets have gone through cataclysmic changes that have dramatically altered the world\'s history. The event could have been a war that used atomic weapons, a plague, an industrial accident, a collision with a large stellar body (such as an asteroid) or a dramatic change in the nature of the system\'s star (such as when stars balloon into red giants, incinerating all of the inner planets and drastically changing the cli- mate of the surviving worlds).\n\rThe disaster could have occurred just a few years ago (generally making the world very dangerous), or it could have happened decades or eons ago (in which case the danger from the actual disaster may have passed, but the aftermath could be devastating).'),
	(7,'Entertainment','This planet\'s business is show business. Holovids, musical groups and the businesses that distribute their works to the general public are dominant here. Some planets specialize in sporting events (such as swoop races), amusement parks, gambling or tourism.'),
	(8,'Exploration','This planet, and the whole system for that matter, has seldom been visited, until now, when the characters have arrived. Exploration planets tend to have primitive technology levels (if there are even sentient races). There are few urban areas, with the emphasis on dangerous wilderness. Lost artifacts from past ages may be on these planets, or there may simply be wandering tribes of aliens who are eager to trade. These planets may be rich in natural resources.\n\rThere may be some hint of galactic civilization in these systems, or on the planet in question - perhaps a secretive trader has retired here, or fugitives may be hiding from the Empire. These locales are excellentfor hidden bases, or if near important trade routes, may be a convenient stopover for independent traders'),
	(9,'Hidden Base','There is a base on this planet that someone wants to keep a secret. This immediately sets up a conflict for the characters, since that someone will probably hunt them down to prevent anyone else from finding out about the base.\n\rAlliance and pirate bases are logical choices. Other options may include the Imperial military or corporate interests (possibly a weapons or biological engineering research facility). Wealthy individuals may have a private hideaway.'),
	(10,'Homeworld','This result means the planet is a homeworld for an established alien race. It could be Calamari (home of the Mon Calamari and the Quarren), Sullust (home of the Sullustans), or one of thousands of other homeworlds throughout the galaxy. Most of these planets have modern starports, a sophisticated trader network and a high level of technology. Almost all homeworlds of Atomic level or higher have already been subdued by the Empire unless the characters are in unexplored regions of space.'),
	(11,'Luxury Goods','The planet produces luxury goods, such as liquor, finished gemstones (such as the Garnib crystals), spices, art or other goods. This planet may be self-sufficient, or may be devoted exclusively to producing the luxury good (which would requiring importing everything else).'),
	(12,'Manufacturing/Processing','The inhabitants of this planet devote most of their time to manufacturing goods. The goods generally fit into three distinct categories: Low Tech, Mid Tech, and High Tech. These goods may be for consumption by the planet\'s own residents, or they may be for export to other planets. They may be finished items, which are shipped directly to markets, orthe planet may be an intermediary step, whereby the planet takes in raw materials from one planet, and then processes the material so that it can be used in the production of a finished good, which is manufac- tured someplace else.\n\rLow Tech\n\rLow-tech items are simple manufactured goods, such as handiworks, native crafts, furniture, basic medicines and woven cloth. Thegoods may be mass produced in factories, or may be made individually by skilled craftsmen.\n\rMid Tech\n\rMore complex items are produced on this planet. Textiles, mechanical weaponry (projectile weapons), pharmaceuticals, paper goods, vehicles, and primitive versions of high-tech goods, such as computers and plastics, can be manufactured on these planets. Assembly line factories are frequently necessary to produce these goods.\n\rHigh Tech\n\rModern computers, blaster weapons, superhard plastics and alloys like transparisteel, polymers, chemicals, bioengineered life forms, advanced bioimmunal medicines, cybernetics, medical equipment, Droids, vehicles and starships are all considered high-tech goods. High-tech goods almost always require advanced manufacturing methods.'),
	(13,'Military','This planet is an important Imperial military facility. It has one or several large bases. Sector capitals, planets near strategic trade routes, Imperial ship yards, and weapons manufacturing planets have huge military bases.'),
	(14,'Mining','Mining planets depend upon the minerals and metals locked beneath the ground. These planets truly drive the Imperial economy, because without the raw materials there would be no starships or vehicles. Blaster gases are also mined, but are taken from gas giants (such as the Tibanna gas mine on Bespin).'),
	(15,'Natural Resources','These planets utilize naturally occurring resources such as wood (for logging), animal skins, and glaciers (\"harvested\" for fresh water). Other products that could be harvested are raw materials for medicines and pharmaceuticals, and may be either plant or animal derived. This cat- egory differs from Agriculture because the products aren\'t food.'),
	(16,'Research','These planets are used for scientific and academic research. The world may have abundant resources, but the particular company or university may have an exclusive charter and is allowed to decide who develops the planet. Research may be for purely scientific or academic knowledge, but other planets, like Gorsh, are studied for new chemical compounds with practical applications.'),
	(17,'Service','Service planets tend to have a multi-classed social system and great wealth. The exclusive higher classes have control over the wealth and resources, and the lower classes provide services and goods to the wealthier individuals. Service planets tend toward direct sale to consumers, or may be devoted to banking, legal services, medical services, or financial markets.'),
	(18,'Subsistence','A planet with aSubsistence economy is working hard just to survive. There is little to send to other worlds to generate income, and if the planet has to import many goods, the debt could be staggering.\n\nAnother option is a planet that depended upon one product which has lost a great deal of its value, and as a result, unemployment and poverty have grown dramatically in recent times.'),
	(19,'Trade','Trade planets tend to be the most active and exciting planets in the Star Wars galaxy. They are blessed with being on a good trade route, and as a result, everyone stops here to sell goods, make deals and purchase goods for resale at other locations. Sector capitals, planets that produce many different products and planets with wealthy populations are often trade planets.');

/*!40000 ALTER TABLE `planet_functions` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table planet_type_roll_map
# ------------------------------------------------------------

DROP TABLE IF EXISTS `planet_type_roll_map`;

CREATE TABLE `planet_type_roll_map` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `roll` int(11) DEFAULT NULL,
  `planet_type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `planet_type_roll_map` WRITE;
/*!40000 ALTER TABLE `planet_type_roll_map` DISABLE KEYS */;

INSERT INTO `planet_type_roll_map` (`id`, `roll`, `planet_type_id`)
VALUES
	(1,2,1),
	(2,3,1),
	(3,4,1),
	(4,5,1),
	(5,6,1),
	(6,7,1),
	(7,8,1),
	(8,9,1),
	(9,10,2),
	(10,11,3),
	(11,12,4);

/*!40000 ALTER TABLE `planet_type_roll_map` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table planet_types
# ------------------------------------------------------------

DROP TABLE IF EXISTS `planet_types`;

CREATE TABLE `planet_types` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `planet_types` WRITE;
/*!40000 ALTER TABLE `planet_types` DISABLE KEYS */;

INSERT INTO `planet_types` (`id`, `name`, `description`)
VALUES
	(1,'Terrestrial','The planet is a typical ball of rock and metals orbiting a sun. Most terrestrial planets have atmospheres, and many have developed life.'),
	(2,'Satellite (Normally Gas Giant)','This world is a moon orbiting a gas giant (much like Yavin IV as seen in Star Wars: A New Hope). Since there is a civilization here, it probably has a breathable atmosphere and supports life, or there were important resources too valuable to pass up. Satellites are almost always tide-locked to the gas giants they orbit.'),
	(3,'Asteroid Belt','Asteroid belts are either the remnants of planets shattered by collisions with large stellar bodies or merely portions of stellar material that never coalesced into a planet. Settled asteroid belts are often rich in minerals and metals, and their small size prevents them from supporting an atmosphere. Most asteroid belt civilizations are either subterranean or have sealed and probably domed buildings built on the surface. Since asteroids are naturally airless, civilizations require regulated environments.'),
	(4,'Artificial','Artificial results indicate orbiting space stations, domed cities built on planets with toxic atmospheres, and great floating complexes built in gas giants (such as Cloud City). All artificial settlements need some means of sustaining themselves (such as huge repulsor engines to keep Cloud City aloft, or sealed domes to keep the toxins out of the city).');

/*!40000 ALTER TABLE `planet_types` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table starport_roll_map
# ------------------------------------------------------------

DROP TABLE IF EXISTS `starport_roll_map`;

CREATE TABLE `starport_roll_map` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `roll` int(11) DEFAULT NULL,
  `starport_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `starport_roll_map` WRITE;
/*!40000 ALTER TABLE `starport_roll_map` DISABLE KEYS */;

INSERT INTO `starport_roll_map` (`id`, `roll`, `starport_id`)
VALUES
	(1,2,1),
	(2,3,2),
	(3,4,2),
	(4,5,2),
	(5,6,3),
	(6,7,3),
	(7,8,3),
	(8,9,4),
	(9,10,4),
	(10,11,4),
	(11,12,5);

/*!40000 ALTER TABLE `starport_roll_map` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table starports
# ------------------------------------------------------------

DROP TABLE IF EXISTS `starports`;

CREATE TABLE `starports` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `starports` WRITE;
/*!40000 ALTER TABLE `starports` DISABLE KEYS */;

INSERT INTO `starports` (`id`, `name`, `description`)
VALUES
	(1,'Landing Field','There may be a flat space on the ground for ships to land. There is no control tower (there may not even be other starships on the planet). Fueling and repair services are probably unavailable at any price.'),
	(2,'Limited Services','This is typically a simple landing field, but there is at least a control tower to prevent collisions between ships in the planet\'s airspace. There may be maintenance sheds for rent. There may be fuel for sale, but other important supplies are unavailable.'),
	(3,'Standard Class','The starport is fully-staffed and equipped. Restocking services are available, and there is a small shipyard for minor repairs and modifications. Prices for repairs and modifications can be up to double normal prices, and take twice as long to accomplish.'),
	(4,'Stellar Class','This type of starport can dock and service almost any class of ship. There are probably several shipyards in the immediate area, and they can handle major repalrs and modifications. There is almost always an Imperial Customs office on site.'),
	(5,'Imperial Class','Modern and luxurious ports with complete storage and maintenance facilities, and a large number of landing fields and docks. A complete menu of services and luxuries are available for the ship and its crew. Important merchants have offices at the starport. The shipyards are capable of rapid repairs and modifications. The Imperial Customs office is well staffed.');

/*!40000 ALTER TABLE `starports` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table tech_level_roll_map
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tech_level_roll_map`;

CREATE TABLE `tech_level_roll_map` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `roll` int(11) DEFAULT NULL,
  `tech_level_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `tech_level_roll_map` WRITE;
/*!40000 ALTER TABLE `tech_level_roll_map` DISABLE KEYS */;

INSERT INTO `tech_level_roll_map` (`id`, `roll`, `tech_level_id`)
VALUES
	(1,2,1),
	(2,3,2),
	(3,4,3),
	(4,5,4),
	(5,6,5),
	(6,7,5),
	(7,8,6),
	(8,9,6),
	(9,10,6),
	(10,11,6),
	(11,12,6);

/*!40000 ALTER TABLE `tech_level_roll_map` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table tech_levels
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tech_levels`;

CREATE TABLE `tech_levels` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `tech_levels` WRITE;
/*!40000 ALTER TABLE `tech_levels` DISABLE KEYS */;

INSERT INTO `tech_levels` (`id`, `name`, `description`)
VALUES
	(1,'Stone','Stone level civilizations have loosely-knit cultures and the basic social unit is likely to be the tribe. The society makes and uses stone tools and may have developed primitive agriculture. These people do not understand the concept of money, so trade will be by barter. There is no transportation network.'),
	(2,'Feudal','Feudal planets have a more complex social structure and have begun to produce primitive manufactured goods. They have learned primitive mining and ore-processing techniques. Transportation is normally by ship or caravan.'),
	(3,'Industrial','Industrial planets are beginning to understand mass production, and have established more complex political and social structures. Windmills, waterwheels, wood or coal furnaces will be used to generate energy. These planets typically want to acquire knowledge to help improve their technology. Motorized transportation, projectile weapons and the beginnings of mass communication are common.'),
	(4,'Atomic','Atomic planets have advanced, large-scale production of goods. They will be very interested in new technologies. More advanced alloys and plastics become available. Space travel is in its infancy. Established industries, such as transportation, communications, medicine, and business, quickly progress and grow.'),
	(5,'Information','Sophisticated communications, such as computers and satellites, become readily available. Industry becomes more ellicient, mechanization is very common, and the precursors of Droids appear. Energy weapons are beginning to be discovered, in-system space travel is common and colony ships to other planets are a distinct possibility. Repulsorlift may be developed. Natural resources may become scarce.'),
	(6,'Space','This is the stage of most planets within galactic civilization, and is characterized by hyper-space travel, Droids, blasters, and highly efficient industry. Planets at this level are often integrated into the galactic economy, and produce many goods for export, but also import many goods.');

/*!40000 ALTER TABLE `tech_levels` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table temperature_roll_map
# ------------------------------------------------------------

DROP TABLE IF EXISTS `temperature_roll_map`;

CREATE TABLE `temperature_roll_map` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `roll` int(11) DEFAULT NULL,
  `temperature_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `temperature_roll_map` WRITE;
/*!40000 ALTER TABLE `temperature_roll_map` DISABLE KEYS */;

INSERT INTO `temperature_roll_map` (`id`, `roll`, `temperature_id`)
VALUES
	(1,2,1),
	(2,3,2),
	(3,4,2),
	(4,5,3),
	(5,6,3),
	(6,7,3),
	(7,8,3),
	(8,9,3),
	(9,10,4),
	(10,11,4),
	(11,12,5);

/*!40000 ALTER TABLE `temperature_roll_map` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table temperatures
# ------------------------------------------------------------

DROP TABLE IF EXISTS `temperatures`;

CREATE TABLE `temperatures` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `temperatures` WRITE;
/*!40000 ALTER TABLE `temperatures` DISABLE KEYS */;

INSERT INTO `temperatures` (`id`, `name`, `description`)
VALUES
	(1,'Searing','Searing planets average 60 degrees Celsius or more, and are hostile to most life forms, although standing bodies of water are possible as long as the average temperature isn\'t near the boiling point (100 degrees Celsius). Most civilizations will tend to cluster near the more moderate polar regions or underground.'),
	(2,'Hot','Hot planets average between 30 and 56 degrees Celsius, and while generally uncomfortable, are not nearly as hostile as searing planets.'),
	(3,'Temperate','Temperate planets average between -5 and 29 degrees Celsius, and are in the most comfortable temperature bands for humans and other life forms.'),
	(4,'Cool','Cool planets average between -20 and -4 degrees Celsius. Most cool planets do not support a huge number of life forms, but life can still adapt to planetary conditions. Plant life may be common if it contains compounds that prevents vital water-based fluids from freezing.'),
	(5,'Frigid','Frigid planets average -21 degrees Celsius or less, and are often inhospitable. If the hydrosphere is Temperate, Moist, or Saturated, the planet may be covered with ice glaciers.');

/*!40000 ALTER TABLE `temperatures` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table terrain_roll_map
# ------------------------------------------------------------

DROP TABLE IF EXISTS `terrain_roll_map`;

CREATE TABLE `terrain_roll_map` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `roll` int(11) DEFAULT NULL,
  `terrain_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `terrain_roll_map` WRITE;
/*!40000 ALTER TABLE `terrain_roll_map` DISABLE KEYS */;

INSERT INTO `terrain_roll_map` (`id`, `roll`, `terrain_id`)
VALUES
	(1,11,1),
	(2,12,2),
	(3,13,2),
	(4,14,3),
	(5,15,4),
	(6,16,4),
	(7,21,5),
	(8,22,5),
	(9,23,5),
	(10,24,5),
	(11,25,6),
	(12,26,6),
	(13,31,7),
	(14,32,7),
	(15,33,8),
	(16,34,8),
	(17,35,9),
	(18,36,9),
	(19,41,9),
	(20,42,10),
	(21,43,10),
	(22,44,10),
	(23,45,11),
	(24,46,11),
	(25,51,12),
	(26,52,12),
	(27,53,13),
	(28,54,13),
	(29,55,13),
	(30,56,13),
	(31,61,13),
	(32,62,14),
	(33,63,14),
	(34,64,15),
	(35,65,15),
	(36,66,15);

/*!40000 ALTER TABLE `terrain_roll_map` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table terrains
# ------------------------------------------------------------

DROP TABLE IF EXISTS `terrains`;

CREATE TABLE `terrains` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `terrains` WRITE;
/*!40000 ALTER TABLE `terrains` DISABLE KEYS */;

INSERT INTO `terrains` (`id`, `name`, `description`)
VALUES
	(1,'Barren','Barren planets are typically Arid, possibly with hostile atmospheres.The ground is extremely hard, dry and is hostile to most forms of life. There may be large rocks on the surface or embedded in the rock hard ground. Minerals and metals may be found. Barren planets are predisposed to unbreathable atmospheres.'),
	(2,'Cave','The planet is dominated by an immense network of caves running throughout the crust. These caves are often caused by volcanic activity, and if the activity is ongoing, areas can quickly become dangerous as lava and toxic gases return to fill the caves they created. Cave planets almost always have Type II atmospheres.'),
	(3,'Crater Field','Crater fields can occur in virtually any other type of terrain, and they are the result of continuous impacts from meteorites, resulting in huge cratered areas on the planet. The impacts could have ended millions of years ago, or they may still be ongoing. Large enough meteors could cause significant climate changes on a planet by throwing huge clouds of soil into the air or causing earthquakes. Planets with light gravities are favorable for crater fields.'),
	(4,'Desert','Deserts are typically found on dry and arid planets, and support only a minimum of life due to a lack of moisture. Deserts can be found in any temperature zone. Warm desert areas can be very dangerous because travelers can easily become dehydrated (an exposure suit will prevent dehydration).'),
	(5,'Forest','Forests occur most commonly in temperate zones, but they can also occur in very cold or warm areas. If they receive a great deal of precipitation in tropical areas, they are called rain forests. Forests may be active year round, or may be seasonal (most of the plants go into hibernation during cooler seasons). They generally receive ample rainfall.'),
	(6,'Glacier','Glaciers are huge, frozen sheets of ice that can be several kilometers thick. Icebergs are chunks of glaciers that have been broken off and now float in oceans. Glaciers grind the land beneath them, constantly reforming it. Glaciers can occur on land, or above ocean.'),
	(7,'Jungle','Jungles are any area overgrown by plant life, and often include low-lying wetlands that support many forms of plant and animal life. They are often warm at least a substantial portion of the local year. The ground can be moist or dry. They are excellent incubators for life, from plants to insects and animals. They require ample water, but can be warm or cool.'),
	(8,'Mountain','Mountainous planets have been (or still are) home to a great deal of geologic activity. The mountains can range from small hills (under a kilometer tall) to huge peaks several kilometers tall. Depending upon the planet\'s atmosphere, plant life, and soil, mountain areas can support a variety of plant forms from trees to grasses. Peaks of mountains on temperate and cold plan- ets may be snow capped. Snow capped mountains can be quite dangerous because of avalanches.'),
	(9,'Ocean','Ocean planets are dominated by huge bodies of water or other liquid. The oceans can be very deep, or merely large and shallow, depending upon whether or not geologic activity has created great mountainous regions (islands are often the peaks of small mountains that emanate from the ocean\'s floor). These planets may be searing to frigid, although frigid oceans will often be covered by huge glacial sheets of ice.'),
	(10,'Plain','Plains areas are simply huge, flat expanses of life, typically supporting grasses and bushes as primary forms of plant life. Grasslands can be found in virtually any hydrosphere and temperature range, but they are most common in tropical and temperate dry regions. Very cold, dry grasslands are often called tundra, and very warm, dry grasslands are often called savannahs.'),
	(11,'Plateau','Plateaus are large sections of mostly flat land that are elevated above other portions of nearby land. They typically occur in the interior of continents. On a plateau, virtually any type of terrain can be found.'),
	(12,'Urban','This result means that most of the planet is covered by artificial constructions, typically huge city sprawls. This is indicative of a very high population, and most so-called urban planets concentrate on trade, manufacturing or administration. Agriculture can sometimes be conducted in huge hydroponics factories, or beneath the surface if the plants don\'t require sunlight (typical of mosses and fungi). Urban terrains can be layered on top of most other terrain conditions such as plateaus, mountains, and plains. fn addition to habitable cities, urban results may indi- cate huge factories and refining facilites.\n\rAside from buildings, many Urban settings will have extensive cultivated areas for agriculture. This classification can include any developed area that isn\'t wilderness.'),
	(13,'Wetlands','Wetlands are moist low-lying wet areas, and play a vital role in most ecosystems. They can take the form of ponds, marshes, or swamps, and support bushes, trees, grasses and many different forms of life.'),
	(14,'Volcanic','Volcanoes and lava pools cover the planet, indicating a very high level of geologic activity. Volcanic planets often have high levels of ash and toxic gases in the atmosphere, and the lava, of course, is very dangerous. However, these planets often have high quality metals in their crust. Volcanic planets often have hazardous atmospheres.'),
	(15,'Special Terrain','These are unusual terrains that demonstrate the incredible versatility of the Star Wars universe. These terrain types can also explain seem- ingly contradictory terrain rolls. What follows are some examples:\n\r• Crystal forests and fields. The crystals may be immensely valuable, or merely scenic. They may also be a hazard il they magnify incoming sunlight, possibly blinding careless travelers.\n\r• Planets with ammonia oceans, where the land masses are actually rock-solid ice fields. This type of condition requires very low temperatures and often has a Type IV atmosphere.\n\r• Underground forests, found in great subterranean caverns. The trees and bushes derive most of their energy from the geothermal energy re- leased by the interior of the planet.\n\r• Huge canyons cover the planet.\n\r• A planet where most of the water is trapped on high plateaus, and the lowest sections of the planet are actually parched deserts.\n\r• Planets like Kashyyyk, with several distinct \"bio-Ievels,\" where the type of creature and its behaviors is distinctly different based on the altitude. This can be accomplished through use of mountains, huge trees, or even planets where there are many lighter than air gases and many flying and gliding creatures have internal bladders for constant lift.\n\r• Planets that are covered with toxic and radioactive pools. They may have been mining planets that were just tapped out and converted to waste dumps. Whole new lifeforms (and hardy ones at that) could evolve in these conditions.\n\r• A planet with an unusual substance that mixes with water, turning into a jellied goo at temperatures up to 80 degrees Celsius. In warmer seasons, there are huge flowing oceans of the muck, while in winter, the goo hardens, expands and covers much of the planet (much like a hot-weather glacier).');

/*!40000 ALTER TABLE `terrains` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
