-- ============================================
-- 신용카드 고객 데이터 탐색적 분석
-- 작성자: Eunbi
-- 작성일: 2025-02-04
-- 목적: 고객 세그먼트별 이용 패턴 파악 및 신규 카드 기획
-- ============================================

USE credit_card_project;

-- [1] 전체 데이터 구조 확인
-- 목적: 데이터 품질 체크 및 주요 변수 파악
SELECT * FROM customers LIMIT 10;

-- [2] 카드 종류별 고객 현황
-- 인사이트: 어떤 카드가 가장 많이 사용되는지, 수익성은 어떤지 확인
SELECT 
    Card_Category,
    COUNT(*) AS 고객수,
    AVG(Customer_Age) AS 평균연령,
    AVG(Total_Trans_Amt) AS 평균거래금액,
    AVG(Total_Trans_Ct) AS 평균거래횟수
FROM customers
GROUP BY Card_Category
ORDER BY 고객수 DESC;

-- [3] 연령대별 소비 패턴 분석
-- 인사이트: 타겟 연령층 식별
SELECT 
    CASE 
        WHEN Customer_Age < 30 THEN '20대'
        WHEN Customer_Age < 40 THEN '30대'
        WHEN Customer_Age < 50 THEN '40대'
        WHEN Customer_Age < 60 THEN '50대'
        ELSE '60대 이상'
    END AS 연령대,
    COUNT(*) AS 고객수,
    AVG(Total_Trans_Amt) AS 평균거래금액,
    AVG(Total_Trans_Ct) AS 평균거래횟수,
    AVG(Avg_Utilization_Ratio) AS 평균카드사용률
FROM customers
GROUP BY 연령대
ORDER BY 평균거래금액 DESC;

-- [4] 소득구간별 신용카드 이용 행태
-- 인사이트: 소득과 카드 사용률의 상관관계 파악
SELECT 
    Income_Category,
    COUNT(*) AS 고객수,
    AVG(Total_Trans_Amt) AS 평균거래금액,
    AVG(Credit_Limit) AS 평균신용한도,
    AVG(Avg_Utilization_Ratio) AS 평균카드사용률
FROM customers
GROUP BY Income_Category
ORDER BY 평균거래금액 DESC;