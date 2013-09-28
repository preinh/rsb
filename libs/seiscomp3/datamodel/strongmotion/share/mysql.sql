DROP TABLE IF EXISTS FilterParameter;
DROP TABLE IF EXISTS SimpleFilter;
DROP TABLE IF EXISTS SimpleFilterChainMember;
DROP TABLE IF EXISTS PeakMotion;
DROP TABLE IF EXISTS Record;
DROP TABLE IF EXISTS EventRecordReference;
DROP TABLE IF EXISTS Rupture;
DROP TABLE IF EXISTS StrongOriginDescription;

INSERT INTO Object(_oid) VALUES (NULL);
INSERT INTO PublicObject(_oid,publicID) VALUES (LAST_INSERT_ID(),'StrongMotionParameters');

CREATE TABLE FilterParameter (
	_oid INTEGER(11) NOT NULL,
	_parent_oid INTEGER(11) NOT NULL,
	_last_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	value_value DOUBLE NOT NULL,
	value_uncertainty DOUBLE UNSIGNED,
	value_lowerUncertainty DOUBLE UNSIGNED,
	value_upperUncertainty DOUBLE UNSIGNED,
	value_confidenceLevel DOUBLE UNSIGNED,
	name VARCHAR(255) NOT NULL,
	PRIMARY KEY(_oid),
	FOREIGN KEY(_oid)
	  REFERENCES Object(_oid)
	  ON DELETE CASCADE,
	FOREIGN KEY(_parent_oid)
	  REFERENCES Object(_oid)
	  ON DELETE CASCADE
) ENGINE=INNODB;

CREATE TABLE SimpleFilter (
	_oid INTEGER(11) NOT NULL,
	_parent_oid INTEGER(11) NOT NULL,
	_last_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	type VARCHAR(255) NOT NULL,
	PRIMARY KEY(_oid),
	FOREIGN KEY(_oid)
	  REFERENCES Object(_oid)
	  ON DELETE CASCADE,
	FOREIGN KEY(_parent_oid)
	  REFERENCES Object(_oid)
	  ON DELETE CASCADE
) ENGINE=INNODB;

CREATE TABLE SimpleFilterChainMember (
	_oid INTEGER(11) NOT NULL,
	_parent_oid INTEGER(11) NOT NULL,
	_last_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	sequenceNo INT UNSIGNED NOT NULL,
	simpleFilterID VARCHAR(255) NOT NULL,
	PRIMARY KEY(_oid),
	INDEX(simpleFilterID),
	FOREIGN KEY(_oid)
	  REFERENCES Object(_oid)
	  ON DELETE CASCADE,
	FOREIGN KEY(_parent_oid)
	  REFERENCES Object(_oid)
	  ON DELETE CASCADE,
	UNIQUE(_parent_oid,sequenceNo)
) ENGINE=INNODB;

CREATE TABLE PeakMotion (
	_oid INTEGER(11) NOT NULL,
	_parent_oid INTEGER(11) NOT NULL,
	_last_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	motion_value DOUBLE NOT NULL,
	motion_uncertainty DOUBLE UNSIGNED,
	motion_lowerUncertainty DOUBLE UNSIGNED,
	motion_upperUncertainty DOUBLE UNSIGNED,
	motion_confidenceLevel DOUBLE UNSIGNED,
	type VARCHAR(255) NOT NULL,
	period DOUBLE UNSIGNED,
	damping DOUBLE UNSIGNED,
	method VARCHAR(255),
	atTime_value DATETIME,
	atTime_value_ms INTEGER,
	atTime_uncertainty DOUBLE UNSIGNED,
	atTime_lowerUncertainty DOUBLE UNSIGNED,
	atTime_upperUncertainty DOUBLE UNSIGNED,
	atTime_confidenceLevel DOUBLE UNSIGNED,
	atTime_used TINYINT(1) NOT NULL DEFAULT '0',
	PRIMARY KEY(_oid),
	FOREIGN KEY(_oid)
	  REFERENCES Object(_oid)
	  ON DELETE CASCADE,
	FOREIGN KEY(_parent_oid)
	  REFERENCES Object(_oid)
	  ON DELETE CASCADE
) ENGINE=INNODB;

CREATE TABLE Record (
	_oid INTEGER(11) NOT NULL,
	_parent_oid INTEGER(11) NOT NULL,
	_last_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	creationInfo_agencyID VARCHAR(64),
	creationInfo_agencyURI VARCHAR(255),
	creationInfo_author VARCHAR(128),
	creationInfo_authorURI VARCHAR(255),
	creationInfo_creationTime DATETIME,
	creationInfo_creationTime_ms INTEGER,
	creationInfo_modificationTime DATETIME,
	creationInfo_modificationTime_ms INTEGER,
	creationInfo_version VARCHAR(64),
	creationInfo_used TINYINT(1) NOT NULL DEFAULT '0',
	gainUnit CHAR(20),
	duration DOUBLE,
	startTime_value DATETIME NOT NULL,
	startTime_value_ms INTEGER NOT NULL,
	startTime_uncertainty DOUBLE UNSIGNED,
	startTime_lowerUncertainty DOUBLE UNSIGNED,
	startTime_upperUncertainty DOUBLE UNSIGNED,
	startTime_confidenceLevel DOUBLE UNSIGNED,
	owner_name VARCHAR(255),
	owner_forename VARCHAR(255),
	owner_agency VARCHAR(255),
	owner_department VARCHAR(255),
	owner_address VARCHAR(255),
	owner_phone VARCHAR(255),
	owner_email VARCHAR(255),
	owner_used TINYINT(1) NOT NULL DEFAULT '0',
	resampleRateNumerator INT UNSIGNED,
	resampleRateDenominator INT UNSIGNED,
	waveformID_networkCode CHAR(8) NOT NULL,
	waveformID_stationCode CHAR(8) NOT NULL,
	waveformID_locationCode CHAR(8),
	waveformID_channelCode CHAR(8),
	waveformID_resourceURI VARCHAR(255),
	waveformFile_creationInfo_agencyID VARCHAR(64),
	waveformFile_creationInfo_agencyURI VARCHAR(255),
	waveformFile_creationInfo_author VARCHAR(128),
	waveformFile_creationInfo_authorURI VARCHAR(255),
	waveformFile_creationInfo_creationTime DATETIME,
	waveformFile_creationInfo_creationTime_ms INTEGER,
	waveformFile_creationInfo_modificationTime DATETIME,
	waveformFile_creationInfo_modificationTime_ms INTEGER,
	waveformFile_creationInfo_version VARCHAR(64),
	waveformFile_creationInfo_used TINYINT(1) NOT NULL DEFAULT '0',
	waveformFile_class VARCHAR(255),
	waveformFile_type VARCHAR(255),
	waveformFile_filename VARCHAR(255),
	waveformFile_url VARCHAR(255),
	waveformFile_description VARCHAR(255),
	waveformFile_used TINYINT(1) NOT NULL DEFAULT '0',
	PRIMARY KEY(_oid),
	FOREIGN KEY(_oid)
	  REFERENCES Object(_oid)
	  ON DELETE CASCADE,
	FOREIGN KEY(_parent_oid)
	  REFERENCES Object(_oid)
	  ON DELETE CASCADE
) ENGINE=INNODB;

CREATE TABLE EventRecordReference (
	_oid INTEGER(11) NOT NULL,
	_parent_oid INTEGER(11) NOT NULL,
	_last_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	recordID VARCHAR(255) NOT NULL,
	campbellDistance_value DOUBLE,
	campbellDistance_uncertainty DOUBLE UNSIGNED,
	campbellDistance_lowerUncertainty DOUBLE UNSIGNED,
	campbellDistance_upperUncertainty DOUBLE UNSIGNED,
	campbellDistance_confidenceLevel DOUBLE UNSIGNED,
	campbellDistance_used TINYINT(1) NOT NULL DEFAULT '0',
	ruptureToStationAzimuth_value DOUBLE,
	ruptureToStationAzimuth_uncertainty DOUBLE UNSIGNED,
	ruptureToStationAzimuth_lowerUncertainty DOUBLE UNSIGNED,
	ruptureToStationAzimuth_upperUncertainty DOUBLE UNSIGNED,
	ruptureToStationAzimuth_confidenceLevel DOUBLE UNSIGNED,
	ruptureToStationAzimuth_used TINYINT(1) NOT NULL DEFAULT '0',
	ruptureAreaDistance_value DOUBLE,
	ruptureAreaDistance_uncertainty DOUBLE UNSIGNED,
	ruptureAreaDistance_lowerUncertainty DOUBLE UNSIGNED,
	ruptureAreaDistance_upperUncertainty DOUBLE UNSIGNED,
	ruptureAreaDistance_confidenceLevel DOUBLE UNSIGNED,
	ruptureAreaDistance_used TINYINT(1) NOT NULL DEFAULT '0',
	JoynerBooreDistance_value DOUBLE,
	JoynerBooreDistance_uncertainty DOUBLE UNSIGNED,
	JoynerBooreDistance_lowerUncertainty DOUBLE UNSIGNED,
	JoynerBooreDistance_upperUncertainty DOUBLE UNSIGNED,
	JoynerBooreDistance_confidenceLevel DOUBLE UNSIGNED,
	JoynerBooreDistance_used TINYINT(1) NOT NULL DEFAULT '0',
	closestFaultDistance_value DOUBLE,
	closestFaultDistance_uncertainty DOUBLE UNSIGNED,
	closestFaultDistance_lowerUncertainty DOUBLE UNSIGNED,
	closestFaultDistance_upperUncertainty DOUBLE UNSIGNED,
	closestFaultDistance_confidenceLevel DOUBLE UNSIGNED,
	closestFaultDistance_used TINYINT(1) NOT NULL DEFAULT '0',
	preEventLength DOUBLE,
	postEventLength DOUBLE,
	PRIMARY KEY(_oid),
	INDEX(recordID),
	FOREIGN KEY(_oid)
	  REFERENCES Object(_oid)
	  ON DELETE CASCADE,
	FOREIGN KEY(_parent_oid)
	  REFERENCES Object(_oid)
	  ON DELETE CASCADE
) ENGINE=INNODB;

CREATE TABLE Rupture (
	_oid INTEGER(11) NOT NULL,
	_parent_oid INTEGER(11) NOT NULL,
	_last_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	width_value DOUBLE,
	width_uncertainty DOUBLE UNSIGNED,
	width_lowerUncertainty DOUBLE UNSIGNED,
	width_upperUncertainty DOUBLE UNSIGNED,
	width_confidenceLevel DOUBLE UNSIGNED,
	width_used TINYINT(1) NOT NULL DEFAULT '0',
	displacement_value DOUBLE,
	displacement_uncertainty DOUBLE UNSIGNED,
	displacement_lowerUncertainty DOUBLE UNSIGNED,
	displacement_upperUncertainty DOUBLE UNSIGNED,
	displacement_confidenceLevel DOUBLE UNSIGNED,
	displacement_used TINYINT(1) NOT NULL DEFAULT '0',
	riseTime_value DOUBLE,
	riseTime_uncertainty DOUBLE UNSIGNED,
	riseTime_lowerUncertainty DOUBLE UNSIGNED,
	riseTime_upperUncertainty DOUBLE UNSIGNED,
	riseTime_confidenceLevel DOUBLE UNSIGNED,
	riseTime_used TINYINT(1) NOT NULL DEFAULT '0',
	vt_to_vs_value DOUBLE,
	vt_to_vs_uncertainty DOUBLE UNSIGNED,
	vt_to_vs_lowerUncertainty DOUBLE UNSIGNED,
	vt_to_vs_upperUncertainty DOUBLE UNSIGNED,
	vt_to_vs_confidenceLevel DOUBLE UNSIGNED,
	vt_to_vs_used TINYINT(1) NOT NULL DEFAULT '0',
	shallowAsperityDepth_value DOUBLE,
	shallowAsperityDepth_uncertainty DOUBLE UNSIGNED,
	shallowAsperityDepth_lowerUncertainty DOUBLE UNSIGNED,
	shallowAsperityDepth_upperUncertainty DOUBLE UNSIGNED,
	shallowAsperityDepth_confidenceLevel DOUBLE UNSIGNED,
	shallowAsperityDepth_used TINYINT(1) NOT NULL DEFAULT '0',
	shallowAsperity TINYINT(1),
	literatureSource_title VARCHAR(255),
	literatureSource_firstAuthorName VARCHAR(255),
	literatureSource_firstAuthorForename VARCHAR(255),
	literatureSource_secondaryAuthors VARCHAR(255),
	literatureSource_doi VARCHAR(255),
	literatureSource_year INT UNSIGNED,
	literatureSource_in_title VARCHAR(255),
	literatureSource_editor VARCHAR(255),
	literatureSource_place VARCHAR(255),
	literatureSource_language VARCHAR(255),
	literatureSource_tome INT UNSIGNED,
	literatureSource_page_from INT UNSIGNED,
	literatureSource_page_to INT UNSIGNED,
	literatureSource_used TINYINT(1) NOT NULL DEFAULT '0',
	slipVelocity_value DOUBLE,
	slipVelocity_uncertainty DOUBLE UNSIGNED,
	slipVelocity_lowerUncertainty DOUBLE UNSIGNED,
	slipVelocity_upperUncertainty DOUBLE UNSIGNED,
	slipVelocity_confidenceLevel DOUBLE UNSIGNED,
	slipVelocity_used TINYINT(1) NOT NULL DEFAULT '0',
	length_value DOUBLE,
	length_uncertainty DOUBLE UNSIGNED,
	length_lowerUncertainty DOUBLE UNSIGNED,
	length_upperUncertainty DOUBLE UNSIGNED,
	length_confidenceLevel DOUBLE UNSIGNED,
	length_used TINYINT(1) NOT NULL DEFAULT '0',
	area_value DOUBLE,
	area_uncertainty DOUBLE UNSIGNED,
	area_lowerUncertainty DOUBLE UNSIGNED,
	area_upperUncertainty DOUBLE UNSIGNED,
	area_confidenceLevel DOUBLE UNSIGNED,
	area_used TINYINT(1) NOT NULL DEFAULT '0',
	ruptureVelocity_value DOUBLE,
	ruptureVelocity_uncertainty DOUBLE UNSIGNED,
	ruptureVelocity_lowerUncertainty DOUBLE UNSIGNED,
	ruptureVelocity_upperUncertainty DOUBLE UNSIGNED,
	ruptureVelocity_confidenceLevel DOUBLE UNSIGNED,
	ruptureVelocity_used TINYINT(1) NOT NULL DEFAULT '0',
	stressdrop_value DOUBLE,
	stressdrop_uncertainty DOUBLE UNSIGNED,
	stressdrop_lowerUncertainty DOUBLE UNSIGNED,
	stressdrop_upperUncertainty DOUBLE UNSIGNED,
	stressdrop_confidenceLevel DOUBLE UNSIGNED,
	stressdrop_used TINYINT(1) NOT NULL DEFAULT '0',
	momentReleaseTop5km_value DOUBLE,
	momentReleaseTop5km_uncertainty DOUBLE UNSIGNED,
	momentReleaseTop5km_lowerUncertainty DOUBLE UNSIGNED,
	momentReleaseTop5km_upperUncertainty DOUBLE UNSIGNED,
	momentReleaseTop5km_confidenceLevel DOUBLE UNSIGNED,
	momentReleaseTop5km_used TINYINT(1) NOT NULL DEFAULT '0',
	fwHwIndicator VARCHAR(64),
	ruptureGeometryWKT VARCHAR(255),
	faultID VARCHAR(255) NOT NULL,
	surfaceRupture_observed TINYINT(1),
	surfaceRupture_evidence VARCHAR(255),
	surfaceRupture_literatureSource_title VARCHAR(255),
	surfaceRupture_literatureSource_firstAuthorName VARCHAR(255),
	surfaceRupture_literatureSource_firstAuthorForename VARCHAR(255),
	surfaceRupture_literatureSource_secondaryAuthors VARCHAR(255),
	surfaceRupture_literatureSource_doi VARCHAR(255),
	surfaceRupture_literatureSource_year INT UNSIGNED,
	surfaceRupture_literatureSource_in_title VARCHAR(255),
	surfaceRupture_literatureSource_editor VARCHAR(255),
	surfaceRupture_literatureSource_place VARCHAR(255),
	surfaceRupture_literatureSource_language VARCHAR(255),
	surfaceRupture_literatureSource_tome INT UNSIGNED,
	surfaceRupture_literatureSource_page_from INT UNSIGNED,
	surfaceRupture_literatureSource_page_to INT UNSIGNED,
	surfaceRupture_literatureSource_used TINYINT(1) NOT NULL DEFAULT '0',
	surfaceRupture_used TINYINT(1) NOT NULL DEFAULT '0',
	PRIMARY KEY(_oid),
	INDEX(ruptureGeometryWKT),
	FOREIGN KEY(_oid)
	  REFERENCES Object(_oid)
	  ON DELETE CASCADE,
	FOREIGN KEY(_parent_oid)
	  REFERENCES Object(_oid)
	  ON DELETE CASCADE
) ENGINE=INNODB;

CREATE TABLE StrongOriginDescription (
	_oid INTEGER(11) NOT NULL,
	_parent_oid INTEGER(11) NOT NULL,
	_last_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	originID VARCHAR(255) NOT NULL,
	waveformCount INT UNSIGNED,
	creationInfo_agencyID VARCHAR(64),
	creationInfo_agencyURI VARCHAR(255),
	creationInfo_author VARCHAR(128),
	creationInfo_authorURI VARCHAR(255),
	creationInfo_creationTime DATETIME,
	creationInfo_creationTime_ms INTEGER,
	creationInfo_modificationTime DATETIME,
	creationInfo_modificationTime_ms INTEGER,
	creationInfo_version VARCHAR(64),
	creationInfo_used TINYINT(1) NOT NULL DEFAULT '0',
	PRIMARY KEY(_oid),
	INDEX(originID),
	FOREIGN KEY(_oid)
	  REFERENCES Object(_oid)
	  ON DELETE CASCADE,
	FOREIGN KEY(_parent_oid)
	  REFERENCES Object(_oid)
	  ON DELETE CASCADE
) ENGINE=INNODB;
