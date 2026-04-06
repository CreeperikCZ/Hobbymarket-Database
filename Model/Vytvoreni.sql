CREATE DATABASE Wild_HobbyMarket;
USE Wild_HobbyMarket;

CREATE TABLE Zakaznik (
	idZakaznik INT PRIMARY KEY AUTO_INCREMENT,
	jmeno VARCHAR(45) NOT NULL,
	prijmeni VARCHAR(45) NOT NULL,
	obec VARCHAR(45) NOT NULL,
	adresa VARCHAR(70) NOT NULL
)
ENGINE = INNODB
CHARACTER SET = UTF8
COLLATE = UTF8_CZECH_CI;

CREATE TABLE Objednavka(
	idObjednavka INT PRIMARY KEY AUTO_INCREMENT,
	datumObjednani DATE NOT NULL,
	stav VARCHAR(15) NOT NULL,
	idZakaznik INT NOT NULL,
	FOREIGN KEY (idZakaznik) REFERENCES Zakaznik(idZakaznik)
)
ENGINE = INNODB
CHARACTER SET = UTF8
COLLATE = UTF8_CZECH_CI;

CREATE TABLE Oddeleni(
	idOddeleni INT PRIMARY KEY AUTO_INCREMENT,
	nazev VARCHAR(45) NOT NULL
)
ENGINE = INNODB
CHARACTER SET = UTF8
COLLATE = UTF8_CZECH_CI;

CREATE TABLE Kategorie(
	idKategorie INT PRIMARY KEY AUTO_INCREMENT,
	nazev VARCHAR(45) NOT NULL,
	idOddeleni INT NOT NULL,
	FOREIGN KEY (idOddeleni) REFERENCES Oddeleni(idOddeleni)
)
ENGINE = INNODB
CHARACTER SET = UTF8
COLLATE = UTF8_CZECH_CI;

CREATE TABLE Produkt(
	idProdukt INT PRIMARY KEY AUTO_INCREMENT,
	nazev VARCHAR(45) NOT NULL,
	cena REAL NOT NULL,
	obrazek BLOB,
	EAN CHAR(13) NOT NULL,
	popis TEXT NOT NULL,
	idKategorie INT NOT NULL,
	FOREIGN KEY (idKategorie) REFERENCES Kategorie(idKategorie)
)
ENGINE = INNODB
CHARACTER SET = UTF8
COLLATE = UTF8_CZECH_CI;

CREATE TABLE Objednane_produkty(
	idProdukt INT,
	idObjednavka INT,
	PRIMARY KEY(idProdukt, idObjednavka),
	mnozstvi INT NOT NULL,
	FOREIGN KEY (idProdukt) REFERENCES Produkt(idProdukt),
	FOREIGN KEY (idObjednavka) REFERENCES Objednavka(idObjednavka)
)
ENGINE = INNODB
CHARACTER SET = UTF8
COLLATE = UTF8_CZECH_CI;



CREATE TABLE Prodejna(
	idProdejna INT PRIMARY KEY AUTO_INCREMENT,
	mesto VARCHAR(45) NOT NULL,
	adresa VARCHAR(75) NOT NULL
)
ENGINE = INNODB
CHARACTER SET = UTF8
COLLATE = UTF8_CZECH_CI;

CREATE TABLE Produkty_na_prodejnach(
	idProdukt INT,
	idProdejna INT,
	mnozstvi INT NOT NULL,
	PRIMARY KEY (idProdukt, idProdejna),
	FOREIGN KEY (idProdukt) REFERENCES Produkt(idProdukt),
	FOREIGN KEY (idProdejna) REFERENCES Prodejna(idProdejna)
)
ENGINE = INNODB
CHARACTER SET = UTF8
COLLATE = UTF8_CZECH_CI;

CREATE TABLE Oddeleni_na_prodejne (
	idOddeleni INT,
	idProdejna INT,
	vedouciOddNaPr INT,
	PRIMARY KEY (idOddeleni, idProdejna),
	FOREIGN KEY (idOddeleni) REFERENCES Oddeleni(idOddeleni),
	FOREIGN KEY (idProdejna) REFERENCES Prodejna(idProdejna)
)
ENGINE = INNODB
CHARACTER SET = UTF8
COLLATE = UTF8_CZECH_CI;

CREATE TABLE Zamestnanec(
	idZamestnanec INT PRIMARY KEY AUTO_INCREMENT,
	jmeno VARCHAR(45) NOT NULL,
	prijmeni VARCHAR(45) NOT NULL,
	rodne_cislo INT(10),
	pracujeOddeleni INT NOT NULL,
	pracujeProdejna INT NOT NULL,
	FOREIGN KEY (pracujeOddeleni) REFERENCES Oddeleni(idOddeleni),
	FOREIGN KEY (pracujeProdejna) REFERENCES Prodejna(idProdejna)
)
ENGINE = INNODB
CHARACTER SET = UTF8
COLLATE = UTF8_CZECH_CI;

ALTER TABLE Oddeleni_na_prodejne ADD 
FOREIGN KEY (vedouciOddNaPr) 
REFERENCES Zamestnanec(idZamestnanec)

