USE Wild_HobbyMarket;
INSERT INTO prodejna (mesto,adresa) VALUES
('Sokolov','Uhlárenská 348'),
('Aš','Holičská 903');

INSERT INTO oddeleni_na_prodejne VALUES
((SELECT idProdejna FROM prodejna WHERE mesto = "Sokolov" AND adresa LIKE '%Uhlárenská%'),3,7);

INSERT INTO oddeleni_na_prodejne VALUES
((SELECT idProdejna FROM prodejna WHERE mesto = "Aš" AND adresa LIKE '%Holičská%'),3,6);

UPDATE zamestnanec 
SET pracujeProdejna = (SELECT idProdejna FROM prodejna WHERE mesto = "Sokolov" AND adresa LIKE '%Uhlárenská%'),
	pracujeOddeleni = 3
WHERE idZamestnanec = 7;

UPDATE zamestnanec 
SET pracujeProdejna = (SELECT idProdejna FROM prodejna WHERE mesto = "Aš"  AND adresa LIKE '%Holičská%'),
	pracujeOddeleni = 3
WHERE idZamestnanec = 6;

INSERT INTO zamestnanec (jmeno,prijmeni,pracujeOddeleni,pracujeProdejna) VALUES
('Jan','Novák',3,(SELECT idProdejna FROM prodejna WHERE mesto = "Sokolov" AND adresa LIKE '%Uhlárenská%')),
('Čenda','Šelma',3,(SELECT idProdejna FROM prodejna WHERE mesto = "Sokolov"AND adresa LIKE '%Uhlárenská%')),
('Oskar','Favák',3,(SELECT idProdejna FROM prodejna WHERE mesto = "Sokolov"AND adresa LIKE '%Uhlárenská%')),
('Albert','Inch',2,(SELECT idProdejna FROM prodejna WHERE mesto = "Aš" AND adresa LIKE '%Holičská%')),
('Jakub','Svítidlo',1,(SELECT idProdejna FROM prodejna WHERE mesto = "Brno" AND adresa LIKE '%Obchodní%'));

DELETE FROM zamestnanec
WHERE prijmeni LIKE '%Němec%';
