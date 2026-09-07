CREATE VIEW income_statement_clean as
With Inc_st_CTE as (
	select
		company,
		tickersymbol as ticker,
		"Date",
		replace("TotalRevenues(Millions)",' ','')::NUMERIC as t_revenue,
		replace(costofsales,' ','')::NUMERIC as cogs,
		replace(grossprofit,' ','')::NUMERIC as g_profit,
		replace("SellingGeneral&AdministrativeExpenses",' ','')::NUMERIC as admin_exp,
		replace("Research&DevelopmentExpenses",' ','')::NUMERIC as rnd_exp,
		replace(NULLIF(trim(operatingprofit), '-'), ' ','')::NUMERIC as op_profit,
		replace(NULLIF(trim(consolidatednetincome), '-'), ' ','')::NUMERIC as net_income
	from income_statement
)
select *,
	Round((g_profit/t_revenue),4) as gross_margin_pct,
	Round((net_income/t_revenue),4) as net_margin_pct
from Inc_st_CTE;



CREATE VIEW balance_sheet_clean as 
	Select
	company,
	tickersymbol as ticker,
	"Date",
	replace(totalassets, ' ', '')::NUMERIC as t_assets,
	replace(totalcurrentliabilities, ' ', '')::NUMERIC as cur_liabilities,
	replace(totalliabilites, ' ', '')::NUMERIC as t_liabilities,
	replace(marketcap, ' ', '')::NUMERIC as market_cap
	from balance_sheet;



