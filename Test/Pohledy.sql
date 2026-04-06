USE wild_hobbymarket;
CREATE VIEW oddeleni_drahych_produktu (nazev, cena, oddeleni) AS
SELECT 
p.nazev, 
p.cena,
o.nazev
FROM produkt p
JOIN kategorie k ON k.idKategorie = p.idKategorie
JOIN oddeleni o ON o.idOddeleni = k.idOddeleni
WHERE cena >= 100;

CREATE VIEW pocet_zamestnancu_na_prodejnu (mesto, adresa, pocet) AS
SELECT
p.mesto, 
p.adresa,
COUNT(z.idZamestnanec)
FROM prodejna p, zamestnanec z
WHERE p.idProdejna = z.pracujeProdejna
GROUP BY p.adresa, p.mesto;