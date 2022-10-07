select w.MetropolitanAreaId [MetropolitanAreaID],
	   w.Id 				[WarehouseID],
	   w.Name 				[Warehouse],
       pv.Id 				[PVID],
       pv.Name 				[Product],
	   Count(tr.SalePrice)  [Sales QTY],
	   Sum(tr.SalePrice) 	[Amount]

from ThingRequest tr
join Shipment s on s.Id = tr.ShipmentId 
join ProductVariant pv on pv.Id = tr.ProductVariantId 
join Warehouse w  on w.Id = s.WarehouseId 

where s.ReconciledOn is not null
and s.ReconciledOn >= '2021-04-03 00:00 +06:00'
and s.ReconciledOn < '2021-05-13 00:00 +06:00'
and tr.IsCancelled = 0
and tr.IsMissingAfterDispatch = 0
and tr.HasFailedBeforeDispatch = 0
and tr.IsReturned = 0
and s.ShipmentStatus not in (1,9,10)
and pv.ShelfType in (5,9)
and pv.Id in (	
	select pvcm.ProductVariantId
	from ProductVariantCategoryMapping pvcm 
	where pvcm.CategoryId in (11,12,25,1235)
)
Group by w.MetropolitanAreaId,
	     w.Id,
	     w.Name,
         pv.Id,
         pv.Name


--select c.Id,c.Name 
--from Category c
--where c.Name like 'Fresh Fruits'


--Vegetable = 12
--Meat = 25
--Fish = 1235
--Fruit = 11