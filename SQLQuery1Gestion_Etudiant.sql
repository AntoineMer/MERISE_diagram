use ECM;

CREATE TABLE ADRESSE
(
	ID_ADR INT IDENTITY (1, 1),
	NUM_ADR INT NOT NULL,
	RUE_ADR VARCHAR(64) NOT NULL,
	VILLE_ADR VARCHAR(64) NOT NULL,
	CP_ADR CHAR(5) NOT NULL,

	PRIMARY KEY(ID_ADR)
);

CREATE TABLE PROFESSEUR
(
	ID_PROF INT,
	NOM_PROF VARCHAR(64) NOT NULL,
	PRENOM_PROF VARCHAR(64) NOT NULL,
	DATE_EMB_PROF DATE NOT NULL,
	TEL_PROF CHAR(10) NOT NULL,

	PRIMARY KEY(ID_PROF)
);

CREATE TABLE TYPE_STAGE
(
	NUM_ORDRE_STAGE INT IDENTITY (1, 1),
	INTITULE_STAGE VARCHAR(32) NOT NULL,

	PRIMARY KEY(NUM_ORDRE_STAGE)
);

CREATE TABLE PROMO
(
	ID_PROMO INT IDENTITY (1, 1),
	ANNEE_EXAM_PROMO SMALLINT NOT NULL,
	NB_INSCRI_PROMO SMALLINT NOT NULL DEFAULT 0,
	NB_RECU_PROMO SMALLINT NULL,
	ID_PROF INT NOT NULL,

	PRIMARY KEY(ID_PROMO),
	FOREIGN KEY(ID_PROF) REFERENCES PROFESSEUR(ID_PROF)
);

CREATE TABLE ETUDIANT
(
	ID_ETU INT,
	NOM_ETU VARCHAR(64) NOT NULL,
	PRENOM_ETU VARCHAR(64) NOT NULL,
	DATE_NAISS_ETU DATE NOT NULL,
	GENRE_ETU CHAR(1) NOT NULL CHECK (GENRE_ETU IN('M', 'F')),
	TEL_ETU CHAR(10) NOT NULL,
	DATE_INSCRIT_ETU DATE NOT NULL,
	MENTION_ETU VARCHAR NULL,
	ID_PROMO INT NOT NULL,
	ID_ADR INT NOT NULL,

	PRIMARY KEY(ID_ETU),
	FOREIGN KEY(ID_PROMO) REFERENCES PROMO(ID_PROMO),
	FOREIGN KEY(ID_ADR) REFERENCES ADRESSE(ID_ADR)
);

CREATE TABLE COMPETENCE
(
	CODE_CPT INT,
	NOM_CPT VARCHAR(64) NOT NULL,
	NIVEAU_CPT TINYINT NOT NULL,
	DESCRIPTIF_CPT TEXT NOT NULL,
	NUM_ORDRE_STAGE INT NOT NULL,

	PRIMARY KEY(CODE_CPT),
	FOREIGN KEY(NUM_ORDRE_STAGE) REFERENCES TYPE_STAGE(NUM_ORDRE_STAGE)
);

CREATE TABLE ENTREPRISE
(
	SIREN_ENT CHAR(9),
	RAISON_SOC_ENT VARCHAR(64) NOT NULL,
	FORM_JURI_ENT VARCHAR(5) NOT NULL,
	TEL_ENT_STANDARD CHAR(10) NOT NULL,
	TEL_ENT_CONTACT CHAR(10) NOT NULL,
	ID_ADR INT NOT NULL,

	PRIMARY KEY(SIREN_ENT),
	FOREIGN KEY(ID_ADR) REFERENCES ADRESSE(ID_ADR)
);

CREATE TABLE TUTEUR
(
	ID_TUTEUR INT IDENTITY (1,1),
	TEL_TUTEUR CHAR(10) NOT NULL,
	NOM_TUTEUR VARCHAR(64) NOT NULL,
	PRENOM_TUTEUR VARCHAR(64) NOT NULL,
	PRESENCE_TUTEUR TINYINT NOT NULL,
	SIREN_ENT CHAR(9) NOT NULL,

	PRIMARY KEY(ID_TUTEUR),
	FOREIGN KEY(SIREN_ENT) REFERENCES ENTREPRISE(SIREN_ENT)
);

CREATE TABLE STAGE
(
	ID_STAGE INT IDENTITY (1, 1),
	DATE_DEB_STAGE DATE NOT NULL,
	DATE_FIN_STAGE DATE NOT NULL,
	CR_STAGE TEXT NULL,
	ID_ETU INT NOT NULL,
	NUM_ORDRE_STAGE INT NOT NULL,
	ID_TUTEUR INT NOT NULL,
	SIREN_ENT CHAR(9) NOT NULL,
	ID_PROF INT NOT NULL,

	PRIMARY KEY(ID_STAGE),
	FOREIGN KEY(ID_ETU) REFERENCES ETUDIANT(ID_ETU),
	FOREIGN KEY(NUM_ORDRE_STAGE) REFERENCES TYPE_STAGE(NUM_ORDRE_STAGE),
	FOREIGN KEY(ID_TUTEUR) REFERENCES TUTEUR(ID_TUTEUR),
	FOREIGN KEY(SIREN_ENT) REFERENCES ENTREPRISE(SIREN_ENT),
	FOREIGN KEY(ID_PROF) REFERENCES PROFESSEUR(ID_PROF)
);