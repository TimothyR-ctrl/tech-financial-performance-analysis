Create Table income_statement (
	Company TEXT,
	TickerSymbol TEXT,
	"Date" DATE,
    "TotalRevenues(Millions)" TEXT,
    CostofSales TEXT,
    GrossProfit TEXT,
    "SellingGeneral&AdministrativeExpenses" TEXT,
    "Research&DevelopmentExpenses" TEXT,
    OperatingProfit TEXT,
    ConsolidatedNetIncome TEXT
);


Create table balance_sheet (
	Company TEXT,
	TickerSymbol TEXT,
	"Date" DATE,
	TotalAssets TEXT,
	TotalCurrentLiabilities TEXT,
	TotalLiabilites TEXT,
	MarketCap TEXT
);
