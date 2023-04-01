# Dokumentace k projektu SQL

## Vytvořené tabulky  

### Tabulka č.1  
Na tabulku czechia_payroll byly připojeny vedlejší tabulky czechia_payroll pro popis  
hodnot ve sloupcích a připojena tabulka cen ke každé průměrné mzdě pro možnost porovnání.  
Z tabulky mezd vybrány pouze údaje mezd. Ceny jsou zprůměrovány z hodnot za celou republiku.  
Z tabulky cen připojeno jméno položky, rok ceny a průměrná cena. Propojení tabulek mzdy  
a cen je přes rok sběru dat. Ve výsledné tabulce je uvedeno id zaměstnavatele, hodnota mzdy,  
jednotka mzdy, pojmenování průměrné hrubé mzdy, údaj o jakou mzdu jde, odvětví, rok odečtu,  
jméno produktu a průměrná cena v daném roce.  

### Tabulka č.2  
Na tabulku economies připojena tabulka countries a odstraněno jméno země z economies  
a přejmenována populace na populace v roce.  

# Výzkumné otázky  

### Výzkumná otázka č. 1 

**Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?**  
  
Tabulka je vytvořena, aby ukazovala, v kterém odvětví a roce došlo k poklesu mezd v ostatních  
nezobrazených údajích byla mzda na stejné úrovni nebo rostla. Vidíme, že nejvíce poklesu bylo  
v odvětví těžby a dobývání, a to hned ve čtyřech rocích. Otázku proč bychom zodpověděli, pokud  
bychom měli údaje o zaměstnancích a jejich ukončení/zahájení pracovního poměru.  
 
#### Odpověď:  
Nejvícekrát došlo ke snížení mzdy v oblasti těžby a dobívání. Co se týče let, tak nejhorší rok  
byl 2013, kdy se snižovalo v 11 odvětvích.  
 
### Výzkumná otázka č. 2 

**Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období  
v dostupných datech cen a mezd?**  
  
Tabulka je vytvořena, aby ukazovala, pro každé odvětví a v daných letech počet produktů, jež si  
je možné koupit za mzdu.   
 
#### Odpověď:  
Nejlépe jsou na tom odvětví Informační a komunikační činnosti a Peněžnictví a pojišťovnictví  
v obou vymezených letech, kde si mohou koupit chleba kolem cca 2 750 kusů a mléka cca 2 500 litů.  
Nejhůře je na tom oblast Ubytování, stravování a pohostinství, která si v daných letech mohlo  
dovolit koupit cca 750 kc chleba a cca 800-900 litrů mléka.

### Výzkumná otázka č. 3 

**Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuálně meziroční nárůst)?**  
  
Zde jsou připraveny dvě tabulky, a to pro oblast případného poklesu, tak čistě jen nárustu.  
V případě poklesu cen vidíme, kolik procentuálně stojí komodita s největším poklesem oproti  
předchozímu roku. Např. v roce 2008 stojí konzumní brambory 76,45% ceny z roku 2007. V případě,  
že nás zajímá zdražení, tak použijeme SQL pro druhou tabulku.  
 
#### Odpověď:  
Nejnižší nárůst byl v 2009 u Rostlinného roztiratelného tuku. Největší pokles ceny byl  
v roce 2007 u Rajských jablek červených kulatých.

### Výzkumná otázka č. 4 

**Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd  
(větší než 10 %)?**  
  
Nejprve je v každém roce vypočten nárůst cen potravin a ten je pro každý rok zprůměrován.  
Následně je porovnáno v každém roce nárůst platu každého odvětví a průmerný růst ceny potravin.  
Výsledná tabulka vypisuje rok a odvětví kdy ceny narostly o 10% a více. 

#### Odpověď:  
Ano existuje rok, kdy došlo k nárustu cen o 10 a více % minimálně vůči jednomu odvětví,  
a k tomu došlo v letech: 2008, 2010, 2011, 2013, 2017 a 2018.

### Výzkumná otázka č. 5 

**Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji  
v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce  
výraznějším růstem?**  
  
Připravena tabulka ve které jsou vyfiltrovány údaje HDP pro Českou Republiku z tabulky  
secondary a připojeny údaje s růstem cen a mezd z tabulky primary. Porovnávají se pouze  
roky kde jsou hodnoty ve všech sloupcích.   
 
#### Odpověď:  
Z generované tabulky můžeme vidět, že závislost na změně HDP a ve změnách mezd nebo potravin není.
