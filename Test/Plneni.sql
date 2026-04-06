USE Wild_HobbyMarket;

INSERT INTO zakaznik (jmeno,prijmeni,obec,adresa) VALUES
('Martin','Dvořák','Nadryby','Lesní cesta 7'),
('Jan','Sunek','Řáholec','Kostelní 340/34'),
('Tomáš','Kolčko','Brno','Revoluční 1');

INSERT INTO objednavka (datumObjednani,stav,idZakaznik)VALUES
(2025-05-05,'Ztraceno',3),
(2025-06-05,'Stornováno',2),
(2025-07-05,'Doručeno',2),
(2025-08-05,'Objednáno',1),
(2025-09-05,'V přepravě',2);

INSERT INTO oddeleni (nazev) VALUES
('Eshop'),
('Dekorace'),
('Vedení'),
('Sanita'),
('Zahrada');

INSERT INTO kategorie (nazev,idOddeleni) VALUES
("Plátna",2),
("Záchody",4),
('Sekačky',5),
('Zahradní rukavice',5),
('Substráty',5);

INSERT INTO produkt (nazev,cena,obrazek,EAN,popis,idKategorie) VALUES
('Malířské plátno 40x40',39.90,NULL,'1234567891011','Kvalitní malířské plátno z bavlny na dřevěném rámu',1),
('Kovová toaleta - VENDETA', 1399.87,NULL,'1111111111111', 'Toaletní mísa je tvořena z nerezového materiálu',2),
('Substrát pro kaktusy',78.90,NULL,'1111111111112','Vhodné pro jakékoliv sukulenty kromě kaktusů. Uchovávejte mimo dosah psů, koček a dětí',5),
('Porcelánová toaleta - ARNOŠT', 1699.87,NULL,'1111111111118', 'Toaletní mísa je vypálneá z kvalitní hlíny',2);

INSERT INTO objednane_produkty VALUES
(3,2,1),
(1,1,3),
(2,2,1),
(3,3,4),
(2,3,7);

INSERT INTO prodejna (mesto,adresa) VALUES
('Brno','Obchodní 7'),
('Plzeň', 'Magisterská 3');

INSERT INTO produkty_na_prodejnach VALUES
(3,2,60),
(3,1,34),
(1,2,32),
(1,1,0),
(2,2,3),
(2,1,101);

INSERT INTO oddeleni_na_prodejne VALUES
(3,1,NULL),
(1,2,NULL),
(2,1,NULL),
(2,2,NULL);

INSERT INTO zamestnanec 
(jmeno,prijmeni,rodne_cislo,pracujeOddeleni,pracujeProdejna) 
VALUES
('Jana','Nová',1234567890,3,1),
('Jan','Wild',1234567891,1,2),
('Žaneta','Smith',1234567892,2,2),
('Jean','Davidová',NULL,2,1),
('Hans','Němec',1234567897,1,2),
('Johan','Štraus',NULL,1,2),
('Johana','Plzeňská',1234567894,2,2);

UPDATE oddeleni_na_prodejne
SET vedouciOddNaPr = 3
WHERE idOddeleni = 3 AND idProdejna = 1;

UPDATE oddeleni_na_prodejne
SET vedouciOddNaPr = 1
WHERE idOddeleni = 1 AND idProdejna = 2;

UPDATE oddeleni_na_prodejne
SET vedouciOddNaPr = 2
WHERE idOddeleni = 2 AND idProdejna = 1;

UPDATE oddeleni_na_prodejne
SET vedouciOddNaPr = 3
WHERE idOddeleni = 2 AND idProdejna = 2;
