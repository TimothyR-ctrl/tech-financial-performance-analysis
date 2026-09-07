---cross check periods reported per company
select 
	inc.company,
	Max(inc."Date") as max_period,
	Min(inc."Date") as min_period
from income_statement_clean inc Left join balance_sheet_clean bs
	on inc.ticker = bs.ticker AND inc."Date" = bs."Date"
Group by inc.company;


--Consolidated view
Create View financial_performance as

With consolidated_cte as (
select 
	inc.Company,
	inc.ticker,
	inc."Date",
	Extract(YEAR from inc."Date") as year,
	EXTRACT(QUARTER from inc."Date") as quarter,
	TO_CHAR(inc."Date",'YYYY-"Q"Q') as reporting_period,
	inc.t_revenue,
	lag(inc.t_revenue) over(partition by inc.Company order by inc."Date" asc) as prvs_t_revenue,
	inc.cogs,
	lag(inc.cogs) over(partition by inc.Company order by inc."Date" asc) as prvs_cogs,
	inc.g_profit,
	lag(inc.g_profit) over(partition by inc.Company order by inc."Date" asc) as prvs_g_profit,
	admin_exp,
	lag(inc.admin_exp) over(partition by inc.Company order by inc."Date" asc) as prvs_admin_exp,
	inc.rnd_exp,
	lag(inc.rnd_exp) over(partition by inc.Company order by inc."Date" asc) as prvs_rnd_exp,
	inc.op_profit,
	lag(inc.op_profit) over(partition by inc.Company order by inc."Date" asc) as prvs_op_profit,
	inc.net_income,
	lag(inc.net_income) over(partition by inc.Company order by inc."Date" asc) as prvs_net_income,
	inc.gross_margin_pct,
	Round((inc.op_profit/inc.t_revenue),4) as operating_margin_pct,
	inc.net_margin_pct,
	bs.t_assets,
	lag(bs.t_assets) over(partition by bs.company Order by bs."Date") as prvs_t_assets,
	bs.cur_liabilities,
	lag(bs.cur_liabilities) over(partition by bs.company Order by bs."Date") as prvs_cur_liabilities,
	bs.t_liabilities,
	lag(bs.t_liabilities) over(partition by bs.company Order by bs."Date") as prvs_t_liabilities,
	bs.market_cap,
	lag(bs.market_cap) over(partition by bs.company Order by bs."Date") as prvs_market_cap
from income_statement_clean inc Left join balance_sheet_clean bs
	on inc.ticker = bs.ticker AND inc."Date" = bs."Date")

select
	company,
	ticker,
	"Date",
	"year",
	quarter,
	reporting_period,
--Growth rate computations
	t_revenue,
	Round(((t_revenue-prvs_t_revenue)
			/NULLIF(prvs_t_revenue,0)),4) as t_revenue_growth,
	cogs,
	Round(((cogs-prvs_cogs)
			/NULLIF(prvs_cogs,0)),4) as cogs_growth,
	g_profit,
	Round(((g_profit-prvs_g_profit)
			/NULLIF(prvs_g_profit,0)),4) as g_profit_growth,
	admin_exp,
	Round(((admin_exp-prvs_admin_exp)
			/NULLIF(prvs_admin_exp,0)),4) as admin_exp_growth,
	rnd_exp,
	Round(((rnd_exp-prvs_rnd_exp)
			/NULLIF(prvs_rnd_exp,0)),4) as rnd_exp_growth,
	op_profit,
	Round(((op_profit-prvs_op_profit)
			/NULLIF(prvs_op_profit,0)),4) as op_profit_growth,
	net_income,
	Round(((net_income-prvs_net_income)
			/NULLIF(prvs_net_income,0)),4) as net_income_growth,
	gross_margin_pct,
	operating_margin_pct,
	net_margin_pct,
	t_assets,
	Round(((t_assets-prvs_t_assets)
			/NULLIF(prvs_t_assets,0)),4) as t_assets_growth,
	cur_liabilities,
	Round(((cur_liabilities-prvs_cur_liabilities)
			/NULLIF(prvs_cur_liabilities,0)),4) as cur_liabilities_growth,
	t_liabilities,
	Round(((t_liabilities-prvs_t_liabilities)
			/NULLIF(prvs_t_liabilities,0)),4) as t_liabilities_growth,
	market_cap,
	Round(((market_cap-prvs_market_cap)
			/NULLIF(prvs_market_cap,0)),4) as market_cap_growth,

----Addition of Financial ratios
--R&D intensity
Round((rnd_exp
		/NULLIF(t_revenue,0)),4) as rnd_intensity_pct,

--SG&A ratio
Round((admin_exp
		/NULLIF(t_revenue,0)),4) as SGnA_ratio_pct,

--Debt ratio
Round((t_liabilities
		/NULLIF(t_assets,0)),4) as debt_ratio_pct,

--ROA ratio
Round((net_income
		/NULLIF((t_assets + prvs_t_assets)/2,0)),4) as ROA_pct,

--Asset Turnover ratio
Round((t_revenue
		/NULLIF((t_assets + prvs_t_assets)/2,0)),4) as asset_turnover_ratio

from consolidated_cte
where reporting_period between '2016-Q1' and '2025-Q4';



--ensure observations per company are equal to enable fair comparison
select
    company,
    COUNT(*) AS observations
from financial_performance
GROUP BY company;


