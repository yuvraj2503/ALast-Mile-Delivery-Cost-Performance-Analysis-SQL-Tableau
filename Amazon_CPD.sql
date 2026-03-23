--select *
--from amazon_delivery


--DELETE FROM amazon_delivery
--WHERE 
--    Store_Latitude = 0 
--    OR Store_Longitude = 0 
--    OR Drop_Latitude = 0 
--    OR Drop_Longitude = 0;

-- SELECT 
--    Order_ID,
--    Store_Latitude,
--    Store_Longitude,
--    Drop_Latitude,
--    Drop_Longitude,
--    Order_Date,
--    Order_Time,
--    Pickup_Time,
--    Delivery_Time,
--    Traffic,
--    Weather,
--    Vehicle,
--    Area,

--    -- Distance Calculation
--    6371 * ACOS(
--        COS(RADIANS(Store_Latitude)) 
--        * COS(RADIANS(Drop_Latitude)) 
--        * COS(RADIANS(Drop_Longitude) - RADIANS(Store_Longitude)) 
--        + SIN(RADIANS(Store_Latitude)) 
--        * SIN(RADIANS(Drop_Latitude))
--    ) AS delivery_distance_km

--INTO final_dataset
--FROM amazon_delivery;

--Delete from final_dataset
--where 
-- delivery_distance_km =0
-- or
-- delivery_distance_km >30
-- or 
-- Store_Longitude is NULL


--select COUNT(dp_type)
--From final_dataset
--where dp_type='3p'
--order by delivery_distance_km desc
 
--ALTER TABLE final_dataset
--ADD dp_type VARCHAR(5);

--UPDATE final_dataset
--SET dp_type = 
--    CASE 
--        WHEN ABS(CHECKSUM(NEWID())) % 5 < 2 THEN '1P'
--        ELSE '3P'
--    END;


ALTER TABLE final_dataset
ADD order_hour INT;

UPDATE final_dataset
SET order_hour = DATEPART(HOUR, Order_Time);

ALTER TABLE final_dataset
ADD is_peak INT;

UPDATE final_dataset
SET is_peak = 
    CASE 
        WHEN order_hour BETWEEN 12 AND 14 
             OR order_hour BETWEEN 18 AND 22 THEN 1
        ELSE 0
    END;

ALTER TABLE final_dataset
ADD speed_kmph FLOAT;

UPDATE final_dataset
SET speed_kmph = 
    CASE 
        WHEN Delivery_Time > 0 
        THEN (delivery_distance_km / Delivery_Time) * 60
        ELSE NULL
    END;


select * from 
final_dataset

SELECT 
    MIN(speed_kmph),
    MAX(speed_kmph),
    AVG(speed_kmph)
FROM final_dataset;


SELECT *
INTO final_dataset_filtered
FROM final_dataset
WHERE speed_kmph BETWEEN 1 AND 40;

SELECT *
FROM final_dataset_filtered;

ALTER TABLE final_dataset_filtered
ADD total_payout FLOAT;

UPDATE final_dataset_filtered
SET total_payout =
    CASE 
        WHEN dp_type = '1P' THEN 
            (20 + (delivery_distance_km * 4)) *
            CASE 
                WHEN is_peak = 1 THEN 1.2
                WHEN Traffic = 'Jam' THEN 1.1
                ELSE 1
            END

        ELSE 
            (25 + (delivery_distance_km * 6)) *
            CASE 
                WHEN is_peak = 1 THEN 1.5
                WHEN Traffic = 'Jam' THEN 1.2
                ELSE 1
            END
    END;
----COST PER DELIVERY ------
SELECT 
    COUNT(*) AS total_orders,
    SUM(total_payout) AS total_cost,
    SUM(total_payout) * 1.0 / COUNT(*) AS CPD
FROM final_dataset_filtered;

-------CPD BY DP TYPE ----
SELECT 
    dp_type,
    COUNT(*) AS orders,
    AVG(total_payout) AS CPD
FROM final_dataset_filtered
GROUP BY dp_type;

---- CPD by Peak Hours/ non peak hours----
SELECT 
    is_peak,
    AVG(total_payout) AS CPD
FROM final_dataset_filtered
GROUP BY is_peak;

----- CPD By Traffic----
SELECT 
    Traffic,
    AVG(total_payout) AS CPD
FROM final_dataset_filtered
GROUP BY Traffic
ORDER BY CPD DESC;


---Cost Per minute ---
SELECT 
    SUM(total_payout) / SUM(Delivery_Time) AS cost_per_min
FROM final_dataset_filtered;


--- Cost Per KM ------

SELECT 
    SUM(total_payout) / SUM(delivery_distance_km) AS cost_per_km
FROM final_dataset_filtered;

------Productivity-----
SELECT 
    COUNT(*) * 1.0 / SUM(Delivery_Time/60.0) AS orders_per_hour
FROM final_dataset_filtered;

SELECT 
    MIN(total_payout),
    MAX(total_payout),
    AVG(total_payout),
    AVG(delivery_distance_km),
    AVG(Delivery_Time)
FROM final_dataset_filtered;

SELECT 
    MIN(Delivery_Time),
    MAX(Delivery_Time),
    AVG(Delivery_Time)
FROM final_dataset_filtered;

SELECT 
    Delivery_Time,
    COUNT(*) AS count_orders
FROM final_dataset_filtered
GROUP BY Delivery_Time
ORDER BY Delivery_Time DESC;

SELECT 
    AVG(delivery_distance_km * 1.0 / Delivery_Time) AS efficiency_score
FROM final_dataset_filtered;

select * from final_dataset_filtered