USE credit_card_project;
SELECT * FROM customers LIMIT 100;

-- 연령대별 카드 현황
SELECT 
    CASE 
        WHEN Customer_Age < 30 THEN '20대'
        WHEN Customer_Age < 40 THEN '30대'
        WHEN Customer_Age < 50 THEN '40대'
        WHEN Customer_Age < 60 THEN '50대'
        ELSE '60대 이상'
    END AS 연령대,
    Card_Category,
    COUNT(*) AS 고객수
FROM customers
GROUP BY 연령대, Card_Category
ORDER BY 연령대;

SELECT 
   CASE 
        WHEN Customer_Age < 30 THEN '20대'
        WHEN Customer_Age < 40 THEN '30대'
        WHEN Customer_Age < 50 THEN '40대'
        WHEN Customer_Age < 60 THEN '50대'
        ELSE '60대 이상'
        END AS 연령대,
    Card_Category,
    COUNT(*) AS 고객수,
    AVG(Total_Trans_Amt) AS 평균거래금액,
    MAX(Total_Trans_Amt) AS 최대거래금액
FROM customers
GROUP BY 연령대, Card_Category
ORDER BY 연령대;


-- Gold/Platinum 고객들이 Blue도 같이 가지고 있나?
-- (Total_Relationship_Count로 확인)

SELECT 
    Card_Category,
    AVG(Total_Relationship_Count) AS 평균보유상품수,
    AVG(Total_Trans_Amt) AS 평균거래금액
FROM customers
GROUP BY Card_Category;
--       Platinum이 상품수 가장 적음 (2.3개)
--       Blue가 상품수 가장 많음 (3.8개)
--       → 고등급 카드가 오히려 은행 충성도 낮음

-- 소득별로 보면?
-- 혹시 고소득자들이 Blue 쓰나?

SELECT 
    Income_Category,
    Card_Category,
    COUNT(*) AS 고객수,
    AVG(Total_Trans_Amt) AS 평균거래금액
FROM customers
GROUP BY Income_Category, Card_Category
ORDER BY Income_Category, 평균거래금액 DESC;