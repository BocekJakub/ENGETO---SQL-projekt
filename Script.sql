-- tabulka 1
CREATE OR REPLACE TABLE t_jakub_bocek_project_SQL_primary_final AS
	SELECT
		cp.id,
		cp.value,
		cpvt.name AS name_value,
		cpu.name AS name_unit,
		cpc.name AS name_calculation,
		cpib.name AS name_industry_branch,
		cp.payroll_year AS year_table,
		czp.name,
		czp.avg_price
	FROM czechia_payroll cp
	JOIN czechia_payroll_value_type cpvt
		ON cp.value_type_code = cpvt.code
	JOIN czechia_payroll_unit cpu
		ON cp.unit_code = cpu.code
	JOIN czechia_payroll_calculation cpc
		ON cp.calculation_code = cpc.code
	JOIN czechia_payroll_industry_branch cpib
		ON cp.industry_branch_code = cpib.code
	RIGHT JOIN (
		SELECT
			cpc.name, 
			round(avg(cp.value),2) AS avg_price, 
			YEAR(cp.date_from) AS all_year
			FROM czechia_price cp 
			JOIN czechia_price_category cpc 
				ON cp.category_code = cpc.code 
			WHERE region_code IS NULL 
			GROUP BY category_code, YEAR(date_from)
			ORDER BY category_code, date_from
			) czp
		ON cp.payroll_year = czp.all_year
	WHERE cp.value_type_code = 5958;


-- tabulka 2
CREATE OR REPLACE TABLE t_jakub_bocek_project_SQL_secondary_final AS 
	SELECT 
		c.*,
		e.`year`,
		e.GDP,
		e.population AS population_in_year,
		e.gini,
		e.taxes,
		e.fertility,
		e.mortaliy_under5
	FROM economies e 
	JOIN countries c 
		ON e.country = c.country 
		
		
-- otázka č. 1		
SELECT 
	all_table.year_compare,
	all_table.value_prev,
	all_table.value_compare,
	all_table.name_industry_branch
FROM 
	(SELECT 
		spf.year_table AS year_prev,
		spf2.year2 AS year_compare,
		round(avg(spf.value)) AS value_prev,
		round(avg(spf2.value)) AS value_compare,
		spf.name_industry_branch,
		CASE 
			WHEN round(avg(spf2.value)) > round(avg(spf.value)) THEN 1
			ELSE 0
		END AS 'compare_wage'
	FROM t_jakub_bocek_project_sql_primary_final spf 
	JOIN (
		SELECT 
			year_table AS year2,
			round(avg(value)) AS value,
			name_industry_branch
		FROM t_jakub_bocek_project_sql_primary_final 
		GROUP BY year_table, name_industry_branch 
		ORDER BY name_industry_branch, year_table 
		) spf2 
		ON spf.name_industry_branch = spf2.name_industry_branch
		AND spf.year_table + 1 = spf2.year2
	GROUP BY year_table, name_industry_branch 
	ORDER BY name_industry_branch, year_table) all_table
WHERE all_table.compare_wage = 0


-- otázka č. 2	
SELECT 
	year_table,
	round(avg(value)),
	name_industry_branch,
	name,
	avg_price,
	round((avg(value)) / avg_price,2) as quantity
FROM t_jakub_bocek_project_sql_primary_final tjbpspf 
WHERE (name LIKE 'mléko%' OR name LIKE 'chléb%') AND (year_table = (
	SELECT min(year_table) FROM t_jakub_bocek_project_sql_primary_final tjbpspf ) OR year_table = (
	SELECT max(year_table) FROM t_jakub_bocek_project_sql_primary_final tjbpspf ))
GROUP BY year_table, name_industry_branch, name 
ORDER BY quantity DESC 


-- otázka č. 3	
SELECT 
	com_year,
	name,
	min_price_percente
FROM 
	(SELECT 
		price_tab.year_table_2 AS com_year,
		name,	
		price_tab.grad AS min_price_percente,
		RANK() OVER(PARTITION BY com_year ORDER BY min_price_percente ASC) ranking
	FROM 
		(SELECT 
			tab1.year_table,
			tab2.year_table AS year_table_2,
			tab1.name,
			tab1.avg_price AS price1,
			tab2.avg_price AS price2,
			Round(tab2.avg_price/tab1.avg_price * 100, 2) AS grad
		FROM (SELECT year_table, name, avg_price 
			FROM t_jakub_bocek_project_sql_primary_final
			GROUP BY year_table, name) tab1	
		JOIN (SELECT year_table, name, avg_price 
			FROM t_jakub_bocek_project_sql_primary_final
			GROUP BY year_table, name) tab2
			ON tab1.year_table + 1 = tab2.year_table
			AND tab1.name = tab2.name
		GROUP BY tab1.year_table, name) price_tab
	GROUP BY com_year, name) tz
WHERE ranking = 1

-- v případě když chci vědět jen zdražování nikoliv zlevňvání
SELECT 
	com_year,
	name,
	min_price_percente
FROM (SELECT 
		price_tab.year_table_2 AS com_year,
		name,	
		price_tab.grad AS min_price_percente,
		RANK() OVER(PARTITION BY com_year ORDER BY min_price_percente ASC) ranking
	FROM 
		(SELECT 
			tab1.year_table,
			tab2.year_table AS year_table_2,
			tab1.name,
			tab1.avg_price AS price1,
			tab2.avg_price AS price2,
			tab2.avg_price/tab1.avg_price AS grad
		FROM (SELECT year_table, name, avg_price 
			FROM t_jakub_bocek_project_sql_primary_final
			GROUP BY year_table, name) tab1	
		JOIN (SELECT year_table, name, avg_price 
			FROM t_jakub_bocek_project_sql_primary_final
			GROUP BY year_table, name) tab2
			ON tab1.year_table + 1 = tab2.year_table
			AND tab1.name = tab2.name
		GROUP BY tab1.year_table, name) price_tab
		WHERE price_tab.grad >= 1 -- přidaný řádek
	GROUP BY com_year, name) tz
WHERE ranking = 1


-- otázka č. 4	
SELECT 
	w_year, 
	name_industry_branch,
	difference,
	name
FROM (SELECT 
		tpf2.year_table AS w_year, 
		tpf.name_industry_branch,
		food_tab.incr_price - round((tpf2.value/tpf.value *100 - 100),2) AS difference,
		food_tab.name,
		CASE
			WHEN (food_tab.incr_price - round((tpf2.value/tpf.value *100 - 100),2))	> 10 THEN 1
			ELSE 0
		END AS more_than_10p
	FROM ( 
		SELECT 
			year_table, value, name_industry_branch
		FROM t_jakub_bocek_project_sql_primary_final
		GROUP BY year_table, name_industry_branch) tpf 
	JOIN ( 
		SELECT 
			year_table, value, name_industry_branch
		FROM t_jakub_bocek_project_sql_primary_final
		GROUP BY year_table, name_industry_branch) tpf2
		ON tpf.year_table + 1 = tpf2.year_table 
		AND tpf.name_industry_branch = tpf2.name_industry_branch 
	JOIN (SELECT 
			tpf4.year_table AS f_year, 
			tpf3.name,
			round((tpf4.avg_price/tpf3.avg_price * 100 - 100),2) AS incr_price
		FROM (SELECT 
				year_table,
				name,
				avg_price 
			FROM t_jakub_bocek_project_sql_primary_final
			GROUP BY year_table, name) tpf3 
		JOIN (SELECT 
				year_table,
				name,
				avg_price 
			FROM t_jakub_bocek_project_sql_primary_final
			GROUP BY year_table, name) tpf4
			ON tpf3.year_table + 1 = tpf4.year_table 
			AND tpf3.name = tpf4.name
		ORDER BY tpf3.year_table, tpf3.name) food_tab
		ON food_tab.f_year = tpf2.year_table) tab
WHERE more_than_10p = 1

-- otázka č. 5
SELECT 
	tsf.country,
	tsf.`year`,
	round(tsf.GDP/tsf2.GDP*100-100,2) AS inc_HDP,
	food_tab.inc_price_food,
	wage_tab.inc_wage
FROM t_jakub_bocek_project_sql_secondary_final tsf 
JOIN (SELECT 
		country,
		`year`,
		GDP 
	FROM t_jakub_bocek_project_sql_secondary_final
	WHERE country LIKE ('%czech%')) tsf2
	ON tsf.`year` = tsf2.`year`+1
JOIN (
	SELECT 
		tpf.year_table,
		tpf.name,
		round(sum(tpf.avg_price)/next_year.suma*100-100,2) AS inc_price_food
	FROM t_jakub_bocek_project_sql_primary_final tpf 
	JOIN (SELECT 
			year_table,
			name,
			sum(avg_price) AS suma  
		FROM t_jakub_bocek_project_sql_primary_final
		GROUP BY year_table) next_year
		ON tpf.year_table = next_year.year_table + 1
	GROUP BY tpf.year_table) food_tab
	ON tsf.`year` = food_tab.year_table
JOIN (
	SELECT 
		tpf.year_table,
		tpf.name,
		round(sum(tpf.value)/next_year.suma*100-100,2) AS inc_wage
	FROM t_jakub_bocek_project_sql_primary_final tpf 
	JOIN (SELECT 
			year_table,
			name_industry_branch,
			sum(value) AS suma  
		FROM t_jakub_bocek_project_sql_primary_final
		GROUP BY year_table) next_year
		ON tpf.year_table = next_year.year_table + 1
	GROUP BY tpf.year_table) wage_tab
	ON tsf.`year` = wage_tab.year_table
WHERE tsf.country LIKE ('%czech%')
ORDER BY `year`	


