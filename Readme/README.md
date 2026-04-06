  
**Hobby market s e-shopem**

1. ## KIV/DB1 – Semestrální práce

![][image2]

# 

# Popis

Databáze řeší problematiku relační databáze pro správu obchodního řetězce a jeho e-shopu. Ukládá důležitá data, které mohou být v interním systému a pomáhat             s řízením obchodu, ale zároveň zobrazovat tyto data na webu zákazníkům. Databáze má tyto entitní množiny: Zakaznik, Objednavka, Produkt, Kategorie, Oddeleni, Prodejna, Zamestnanec. A další tři asociační tabulky pro vazbu M:N. 

# Pohledy

## Drahé produkty a jejich oddělení

Tento pohled vypisuje název produktu, jeho cenu a na jakém oddělení se vyskytuje, ale vypisuje pouze dražší produkty (nejnižší vypisovaná cena je momentálně nastavena na 100 Kč). Přidání oddělení je vytvořeno pomocí Joinu na kategorii a následně druhým spojením s množinou oddělením. 

To vše lze využít pro to aby se vědělo, že se na tento produkt má přidat bezpečnostní štítek, který zapříčiní spuštění alarmu při krádeži, a aby věděli zaměstnanci, na kterém oddělení tento produkt hledat.

CREATE VIEW oddeleni\_drahych\_produktu (nazev, cena, oddeleni) AS  
SELECT p.nazev, p.cena, o.nazev  
FROM produkt p  
JOIN kategorie k ON k.idKategorie \= p.idKategorie  
JOIN oddeleni o ON o.idOddeleni \= k.idOddeleni  
WHERE cena \>= 100;

![Pohled 1][image3]

## Počet zaměstnanců na prodejnu

Druhý pohled vypisuje kolik lidí pracuje na jednotlivých prodejnách, tudíž vypíše město a adresu prodejny a její počet zaměstnanců. Počítá kolik ID zaměstnanců nalezne, kde se shoduje ID prodejny s ID prodejny na které nalezne uložené zaměstnance. 

Tento pohled mohou využít analytici nebo personální oddělení a zjistit kde si mohou dovolit nabírat lidi.

CREATE VIEW pocet\_zamestnancu\_na\_prodejnu (mesto, adresa, pocet) AS  
SELECT p.mesto, p.adresa, COUNT(z.idZamestnanec)  
FROM prodejna p, zamestnanec z  
WHERE p.idProdejna \= z.pracujeProdejna  
GROUP BY p.adresa, p.mesto;

# Testovací scénáře

## Scénář produkty

Uživatel přidal 4 produkty s vysokou cenou, následně upravil u dvou produktů ceny, jednu zvýšil, druhou snížil pod cenovou výši 100 Kč. Tím se změní pohled drahých produktů a jejich oddělení.

INSERT INTO produkt (nazev,cena,EAN,popis,idKategorie) VALUES  
('Traktorová sekačka',19900,1…,'Červený tra…',3),  
('AKU Sekačka',14900.50,1…,'Bateriová s…',3),  
('Substrát pro stromy',799.9,1…,'B…',5),  
('Plátno \- GIGA',1200,1122334955667,'B…',1);  
***\-- Vložení 	4 produktů s názvem, cenou, artiklem, popisem a ketegorií.***  
***\-- (I když mají jinou kategorii, tak mají stejné oddělení)***

UPDATE produkt  
SET cena \= 70000  
WHERE nazev LIKE '%ARNOŠT%';  
***\-- Upravení ceny v produktu, kde název obsahuje “ARNOŠT”***

UPDATE produkt  
SET cena \= 70  
WHERE nazev LIKE '%VENDETA%';  
***\-- Upravení ceny v produktu, kde název obsahuje “VENDETA”***

Co se změnilo: Toaleta VENDETA již v tabulce není, ARNOŠT je dražší a přibili nové 4 produkty.   
![][image4]

## Scénář zaměstnanci

Uživatel přidá 2 prodejny, následně přidá na prodejny oddělení a jejich vedoucí. Změní dvoum zaměstnanců pracoviště. Následně zaměstnal 5 nových lidí. A vyhodí jednoho zaměstnance. Po tomto bude pohled počtu zaměstnanců vypadat takto:   
(Kód je zkrácen, ale pouze datově.)

INSERT INTO prodejna (mesto,adresa) VALUES  
('Sokolov','Uhlárenská 348'),  
('Aš','Holičská 903');  
***\-- Přidání prodejen***

INSERT INTO oddeleni\_na\_prodejne VALUES(  
(SELECT idProdejna FROM prodejna   
WHERE mesto \= "Sokolov" adresa LIKE '%Uhlárenská%'),  
3,7);  
***\--Přidání oddělení do prodejen s vedoucím***  
***\-- Předpokládá se že aplikace zná ID Oddělení***  
***\-- Vnitřní select (subselect) vyhledá id podle města a ulice***

UPDATE zamestnanec  
SET pracujeProdejna \= ( \*stejný select jako výše uveden\* ),  
    pracujeOddeleni \= 3  
WHERE idZamestnanec \= 7;  
***\-- Přesun zaměstnance na novou prodejnu a oddělení*** 

INSERT INTO zamestnanec  
(jmeno,prijmeni,pracujeOddeleni,pracujeProdejna) VALUES  
('Jan','Novák',3,( \*stejný select jako výše uveden\* ));  
***\-- Přidání zaměstnance (nez rodného čísla) na prodejnu***

DELETE FROM zamestnanec  
WHERE prijmeni LIKE '%Němec%';  
**\-- Výpověď pro všechny zaměstnance s příjmením, které obsahuje “Němec”**

Co se změnilo: Úbytek 3 pracovníků v Plzni, protože 2 byli přesunuti a jeden vyhozen. V Brně přibil zaměstnanec. A jsou přidány dvě prodejny a jsou nabráni nový zaměstnanci.  
![][image5]

# Závěr

Databázi jsem vytvořil ručně psaným SQL kódem v prostředí MyPhpAdmin, kde jsem měl databázi uloženou u sebe na počítači. Použitý software na hostování databáze byl XAMPP. Vždy jsem kód psal po částech. Moje poznatky z toho, jak navrhnout databázi jsem nasbíral v jednom hobbymarketu nedaleko naší fakulty. Jinak zkušenosti mám ze střední školy s databázemi. Jediný View pro mě byl nový (nebo jsem úplně zapomněl, že existuje, protože jsem tuto funkci nikdy nevyužil) a moje mozková kapacita nejspíš nestačí na logiku Joinů, naštěstí u mě to nebylo obtížné. Se SubSelectem jsem měl trochu problém aby mi fungoval   
Tato databáze je nejkomplexnější, kterou jsem kdy dělal, myslím že se mi celkem povedla, ale že by šla rovnou použít v obchodě si nemyslím. Při psaní dokumentace my došlo, že by se nedali dělat slevy, nebo že uživatel nemá jak prokázat, že je ten za koho se vydává, zapomněl jsem na email nebo nějaký login s heslem. Což není tak obtížné zařídit a zároveň to není nutně potřeba.  
A asi bych nedokázal vymyslet co udělat jinak. Alespoň jsem si ve většině zopakoval co již umím.   
Když mi vyskočila chyba a už jsem byl zoufalí kde je problém, tak jsem se zeptal AI a většina chyb byla zapomenutá čárka, či špatné pořadí příkazů. Ten druhý případ byl se SubSelectem, že mi vrátil více hodnot, což se SQL nelíbilo.  

