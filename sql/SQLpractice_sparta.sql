
### 5ÁÖÂ÷
select market, count(*) as cnt from tickers
group by market

select date, f.ticker, per, name
from fundamentals f 
inner join tickers t on f.ticker =t.ticker 
where date = curdate() - interval 1 DAY
and per >0 and per < 20
order by per desc

select m.date, p.ticker, p.close, p.change_rate, t.market, t.name, m.marketcap, f.ratio
from prices p 
inner join tickers t on p.ticker = t.ticker
inner join marketcaps m on m.ticker = p.ticker and m.date = p.date
inner join fstocks f on f.ticker = p.ticker and f.date = p.date
where m.date = CURDATE()  and change_rate between 10 and 15

select date, pn.ticker, open, close, round((close-open)/open*100,2) as change_rate from prices_nasdaq pn 
inner join tickers_nasdaq tn on pn.ticker = tn.ticker
where date = '2022-03-11'
order by change_rate desc




select * from fstocks f 

select * from tickers t 