# Dokumentace k projektu SQL

### Tabulka č.1  
Na tabulku czechia_payroll byly připojeny vedlejší tabulky czechia_payroll pro popis hodnot ve sloupcích a připojena tabulka cen ke každé průměrné mzdě pro možnost porovnání. Z tabulky mezd vybrány pouze údaje mezd. Ceny jsou zprůměrovány z hodnot za celou republiku. Z tabulky cen připojeno jméno položky, rok ceny a průměrná cena. Propojení tabulek mzdy a cen je přes rok sběru dat. Ve výsledné tabulce je uvedeno id zaměstnavatele, hodnota mzdy, jednotka mzdy, pojmenování průměrné hrubé mzdy, údaj o jakou mzdu jde, odvětví, rok odečtu, jméno produktu a průměrná cena v daném roce.  

### Tabulka č.2  
Na ta economies připojena tabulka countries a odstraněno jméno země z economies a přejmenována populace na populace v roce.  

### Výzkumná otázka č. 1  
Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?  
Tabulka je vytvořena, aby ukazovala, v kterém odvětví a roce došlo k poklesu mezd v ostatních nezobrazených údajích byla mzda na stejné úrovni nebo rostla. Vidíme, že nejvíce poklesu bylo v odvětví těžby a dobývání, a to hned ve čtyřech rocích. Otázku proč bychom zodpověděli, pokud bychom měli údaje o zaměstnancích a jejich ukončení/zahájení pracovního poměru. Co se týče let tak nejhorší rok byl 2013 kdy se snižovalo v nejvíce odvětvích.  
Odpověď:  


### Výzkumná otázka č. 2  
Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?  
Tabulka je vytvořena, aby ukazovala, pro každé odvětví a v daných letech počet produktů jež si je možné koupit za mzdu. Nejlépe jsou na tom odvětví Informační a komunikační činnosti a Peněžnictví a pojišťovnictví v obou vymezených letech. Nejhůře je na tom oblast Ubytování, stravování a pohostinství.  
Odpověď:  


### Výzkumná otázka č. 3  
Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuálně meziroční nárůst)?  
Zde jsou připraveny dvě tabulky, a to pro oblast případného poklesu tak čistě jen nárustu. V případě poklesu cen vidíme, kolik procentuálně stojí komodita s největším poklesem oproti předchozímu roku. Např. v roce 2008 stojí konzumní brambory 76,45% ceny z roku 2007. V případě že nás zajímá zdražení, tak použijeme SQL pro druhou tabulku.  
Odpověď:  


### Výzkumná otázka č. 4  
Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?  
Je vytvořena tabulka, která nám ukazuje v daném roce rozdíl o kolik narostla cena vůči mzdě. Tabulka je vytvořena pro každé odvětví a komoditu. Uvedený údaj je rozdíl nárůstu mzdy a cen potraviny.  
Odpověď:  


### Výzkumná otázka č. 5  
Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?  
Odpověď:
Z tabulky můžeme vidět, že závislost na změně HDP není ve změnách mezd nebo potravin vidět. Každá proměnná se mění jiným směrem.
