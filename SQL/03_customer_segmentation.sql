-- ============================================
-- 고객 세그먼트 분석 (RFM 기반)
-- 목적: VIP/우수/일반/휴면 고객 분류 및 특성 파악
-- ============================================

SELECT 
    MIN(Total_Trans_Amt) AS 최소거래액,
    AVG(Total_Trans_Amt) AS 평균거래액,
    MAX(Total_Trans_Amt) AS 최대거래액,
    MIN(Total_Trans_Ct) AS 최소거래횟수,
    AVG(Total_Trans_Ct) AS 평균거래횟수,
    MAX(Total_Trans_Ct) AS 최대거래횟수
FROM customers;
-- 최대 거래수 139회 
-- 평균 거래 횟수 65회 

SELECT 
    고객등급,
    COUNT(*) AS 고객수,
    AVG(Total_Trans_Amt) AS 평균거래액,
    AVG(Total_Trans_Ct) AS 평균거래횟수
FROM (
    SELECT 
        CASE 
            WHEN Total_Trans_Amt >= 9000 
             AND Total_Trans_Ct >= 100 
             AND Months_Inactive_12_mon <= 1
            THEN 'VIP'
            
            WHEN Total_Trans_Amt >= 6500 
             AND Total_Trans_Ct >= 80
             AND Months_Inactive_12_mon <= 2
            THEN '우수고객'
            
            WHEN Months_Inactive_12_mon >= 3 
            THEN '휴면위험'
            
            ELSE '일반고객'
        END AS 고객등급,
        Total_Trans_Amt,
        Total_Trans_Ct,
        Months_Inactive_12_mon
    FROM customers
) AS 세그먼트
GROUP BY 고객등급
ORDER BY 평균거래액 DESC;

-- 인사이트
-- 1. 휴면위험 고객이 48% (4,817명) - 이탈 방지를 위한 방안
-- 2. VIP는 1.7%지만 평균 거래액 3.4배 높음
-- 3. 우수고객 557명을 VIP로 업그레이드 기회