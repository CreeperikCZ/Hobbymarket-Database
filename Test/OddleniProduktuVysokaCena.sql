USE wild_hobbymarket;

INSERT INTO produkt (nazev,cena,EAN,popis,idKategorie) VALUES
('Traktorová sekačka',19900,1122334455667,'Červený traktůrek určený pro pomoc na zahradě, vybaven tažným zařízením',3),
('AKU Sekačka',14900.50,1122334455677,'Bateriová sekačka, výdrž 8 hodin při vypnutém motoru',3),
('Substrát pro stromy',799.9,1122334955667,'BlaBlaBla',5),
('Plátno - GIGA',1200,1122334955667,'BlaBlaBla',1);

UPDATE produkt
SET cena = 70000
WHERE nazev LIKE '%ARNOŠT%';

UPDATE produkt
SET cena = 70
WHERE nazev LIKE '%VENDETA%';