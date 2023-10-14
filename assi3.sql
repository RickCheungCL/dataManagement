use gbc_superstore;
Select * 
from product_order;

Select * 
from Product;

Select * from sub_category;

Select * from region;
Select SUM(Returned = 1) from orders;
Select * from orders;
Select * from postalcode;
Select * from city_in_state;
Select * from state;
Select * from region;
Select * from customers;
Select * from segment;


Select r.Region,seg.Segment,c.Category,Count(po.OrderPID) AS TotalOrders , SUM(o.Returned = 1) / Count(po.OrderPID) *100 AS OrderReturnPercentage, SUM(case when po.Discount > 0 then po.Quantity else 0 end) AS ProductsWithDiscount,
		SUM(po.Quantity) AS TotalQuantity,SUM(po.Sales) AS TotalSales,SUM(po.Profit) AS TotalProfit,SUM(po.Sales)/ Count(po.OrderPID) AS AverageTranscations 
from product_order po,
Product p,
sub_category sc,
category c,
orders o,
postalcode pc,
city_in_state cis,
state s,
region r,
customers cus,
segment seg
where po.ProductPID = p.ProductPID
AND sc.Sub_categoryID = p.Sub_categoryID
AND c.CategoryID = sc.CategoryID
AND o.OrderPID = po.OrderPID
AND pc.PostalCodeID = o.PostalCodeID
AND cis.CityID = pc.CityID
AND cis.StateID = s.StateID
AND r.RegionID = s.RegionID 
AND cus.CustomerID = o.CustomerID
AND cus.SegmentID = seg.SegmentID
AND o.OrderDate Between '2020-4-1' AND '2020-4-30'
Group by r.Region,seg.Segment,c.Category with ROLLUP;


Select IF(Grouping(r.Region),'GrandTotal',r.Region) as Region,IF(Grouping(seg.Segment),'Total',seg.Segment) AS Segment,IF(Grouping(c.Category),'Subtotal',c.Category) AS Category,Count(po.OrderPID) AS TotalOrders , SUM(o.Returned = 1) / Count(po.OrderPID) *100 AS OrderReturnPercentage, SUM(case when po.Discount > 0 then po.Quantity else 0 end) AS ProductsWithDiscount,
		SUM(po.Quantity) AS TotalQuantity,SUM(po.Sales) AS TotalSales,SUM(po.Profit) AS TotalProfit,SUM(po.Sales)/ Count(po.OrderPID) AS AverageTranscations 
from product_order po,
Product p,
sub_category sc,
category c,
orders o,
postalcode pc,
city_in_state cis,
state s,
region r,
customers cus,
segment seg
where po.ProductPID = p.ProductPID
AND sc.Sub_categoryID = p.Sub_categoryID
AND c.CategoryID = sc.CategoryID
AND o.OrderPID = po.OrderPID
AND pc.PostalCodeID = o.PostalCodeID
AND cis.CityID = pc.CityID
AND cis.StateID = s.StateID
AND r.RegionID = s.RegionID 
AND cus.CustomerID = o.CustomerID
AND cus.SegmentID = seg.SegmentID
AND o.OrderDate Between '2020-4-1' AND '2020-4-30'
Group by r.Region,seg.Segment,c.Category with ROLLUP;


Select * from`executive table_v2`;

select * from `operational table`
group by Category,Segment,Region with ROLLUP;


Select r.region as Region, SUM(case when o.OrderDate between '2019-01-01' AND '2019-3-30' then po.Profit else 0 end) AS Q1, SUM(case when o.OrderDate between '2019-04-01' AND '2019-6-30' then po.Profit else 0 end) AS Q2 
,  case when SUM(case when o.OrderDate between '2019-04-01' AND '2019-6-30' then po.Profit else 0 end) < 0 OR SUM(case when o.OrderDate between '2019-01-01' AND '2019-3-30' then po.Profit else 0 end) < 0 then SUM(case when o.OrderDate between '2019-04-01' AND '2019-6-30' then po.Profit else 0 end)/SUM(case when o.OrderDate between '2019-01-01' AND '2019-3-30' then po.Profit else 0 end) * -1 else SUM(case when o.OrderDate between '2019-04-01' AND '2019-6-30' then po.Profit else 0 end)/SUM(case when o.OrderDate between '2019-01-01' AND '2019-3-30' then po.Profit else 0 end) end AS Q2VSQ1
, 1.02 *  SUM(case when o.OrderDate between '2018-04-01' AND '2018-6-30' then po.Profit else 0 end) AS Target2019Q2
, SUM(case when o.OrderDate between '2019-04-01' AND '2019-6-30' then po.Profit else 0 end) / (1.02 *  SUM(case when o.OrderDate between '2018-04-01' AND '2018-6-30' then po.Profit else 0 end)) AS KPI2018vs2019Q2
, SUM(case when o.OrderDate between '2018-01-01' AND '2018-12-31' then po.Profit else 0 end) AS y2018, SUM(case when o.OrderDate between '2019-01-01' AND '2019-12-31' then po.Profit else 0 end) AS y2019 
,case when SUM(case when o.OrderDate between '2019-01-01' AND '2019-12-31' then po.Profit else 0 end) < 0 OR SUM(case when o.OrderDate between '2018-01-01' AND '2018-12-31' then po.Profit else 0 end) < 0 then SUM(case when o.OrderDate between '2019-01-01' AND '2019-12-31' then po.Profit else 0 end)/SUM(case when o.OrderDate between '2018-01-01' AND '2018-12-31' then po.Profit else 0 end) * -1 else SUM(case when o.OrderDate between '2019-01-01' AND '2019-12-31' then po.Profit else 0 end)/SUM(case when o.OrderDate between '2018-01-01' AND '2018-12-31' then po.Profit else 0 end) end AS vs20192018
, 1.02 *  SUM(case when o.OrderDate between '2018-01-01' AND '2018-12-31' then po.Profit else 0 end) AS Target2019
,SUM(case when o.OrderDate between '2019-01-01' AND '2019-12-31' then po.Profit else 0 end) / (1.02 *  SUM(case when o.OrderDate between '2018-01-01' AND '2018-12-31' then po.Profit else 0 end)) AS KPI2018vs2019
from product_order po,
Product p,
sub_category sc,
category c,
orders o,
postalcode pc,
city_in_state cis,
state s,
region r,
customers cus,
segment seg
where po.ProductPID = p.ProductPID
AND sc.Sub_categoryID = p.Sub_categoryID
AND c.CategoryID = sc.CategoryID
AND o.OrderPID = po.OrderPID
AND pc.PostalCodeID = o.PostalCodeID
AND cis.CityID = pc.CityID
AND cis.StateID = s.StateID
AND r.RegionID = s.RegionID 
AND cus.CustomerID = o.CustomerID
AND cus.SegmentID = seg.SegmentID
group by r.Region;

select * from exetable1;

select  'GrandTotal',SUM(Q1),SUM(Q2),SUM(Q2)/SUM(Q1) , SUM(Target2019Q2) , SUM(Q2)/SUM(Target2019Q2), SUM(y2018) ,SUM(y2019) , SUM(y2019)/SUM(y2018) , SUM(Target2019) ,  SUM(y2019)/ SUM(Target2019)
from exetable1;

select * from exetableforjoin;