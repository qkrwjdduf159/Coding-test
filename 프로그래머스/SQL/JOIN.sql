-- ANIMAL_INS 테이블은 동물 보호소에 들어온 동물의 정보를 담은 테이블입니다. ANIMAL_INS 테이블 구조는 다음과 같으며, ANIMAL_ID, ANIMAL_TYPE, DATETIME, INTAKE_CONDITION, NAME, SEX_UPON_INTAKE는 각각 동물의 아이디, 생물 종, 보호 시작일, 보호 시작 시 상태, 이름, 성별 및 중성화 여부를 나타냅니다.
-- ANIMAL_OUTS 테이블은 동물 보호소에서 입양 보낸 동물의 정보를 담은 테이블입니다. ANIMAL_OUTS 테이블 구조는 다음과 같으며, ANIMAL_ID, ANIMAL_TYPE, DATETIME, NAME, SEX_UPON_OUTCOME는 각각 동물의 아이디, 생물 종, 입양일, 이름, 성별 및 중성화 여부를 나타냅니다. ANIMAL_OUTS 테이블의 ANIMAL_ID는 ANIMAL_INS의 ANIMAL_ID의 외래 키입니다.
-- 천재지변으로 인해 일부 데이터가 유실되었습니다. 입양을 간 기록은 있는데, 보호소에 들어온 기록이 없는 동물의 ID와 이름을 ID 순으로 조회하는 SQL문을 작성해주세요.
SELECT ANIMAL_OUTS.ANIMAL_ID, ANIMAL_OUTS.NAME 
FROM ANIMAL_INS RIGHT JOIN ANIMAL_OUTS
ON ANIMAL_INS.ANIMAL_ID=ANIMAL_OUTS.ANIMAL_ID
WHERE ANIMAL_INS.ANIMAL_ID IS NULL
ORDER BY ANIMAL_OUTS.ANIMAL_ID;

-- ANIMAL_INS 테이블은 동물 보호소에 들어온 동물의 정보를 담은 테이블입니다. ANIMAL_INS 테이블 구조는 다음과 같으며, ANIMAL_ID, ANIMAL_TYPE, DATETIME, INTAKE_CONDITION, NAME, SEX_UPON_INTAKE는 각각 동물의 아이디, 생물 종, 보호 시작일, 보호 시작 시 상태, 이름, 성별 및 중성화 여부를 나타냅니다.
-- ANIMAL_OUTS 테이블은 동물 보호소에서 입양 보낸 동물의 정보를 담은 테이블입니다. ANIMAL_OUTS 테이블 구조는 다음과 같으며, ANIMAL_ID, ANIMAL_TYPE, DATETIME, NAME, SEX_UPON_OUTCOME는 각각 동물의 아이디, 생물 종, 입양일, 이름, 성별 및 중성화 여부를 나타냅니다. ANIMAL_OUTS 테이블의 ANIMAL_ID는 ANIMAL_INS의 ANIMAL_ID의 외래 키입니다.
-- 관리자의 실수로 일부 동물의 입양일이 잘못 입력되었습니다. 보호 시작일보다 입양일이 더 빠른 동물의 아이디와 이름을 조회하는 SQL문을 작성해주세요. 이때 결과는 보호 시작일이 빠른 순으로 조회해야합니다.
SELECT A.ANIMAL_ID, A.NAME 
FROM ANIMAL_INS A, ANIMAL_OUTS B 
WHERE A.ANIMAL_ID=B.ANIMAL_ID AND A.DATETIME > B.DATETIME
ORDER BY A.DATETIME ASC;

-- ANIMAL_INS 테이블은 동물 보호소에 들어온 동물의 정보를 담은 테이블입니다. ANIMAL_INS 테이블 구조는 다음과 같으며, ANIMAL_ID, ANIMAL_TYPE, DATETIME, INTAKE_CONDITION, NAME, SEX_UPON_INTAKE는 각각 동물의 아이디, 생물 종, 보호 시작일, 보호 시작 시 상태, 이름, 성별 및 중성화 여부를 나타냅니다.
-- ANIMAL_OUTS 테이블은 동물 보호소에서 입양 보낸 동물의 정보를 담은 테이블입니다. ANIMAL_OUTS 테이블 구조는 다음과 같으며, ANIMAL_ID, ANIMAL_TYPE, DATETIME, NAME, SEX_UPON_OUTCOME는 각각 동물의 아이디, 생물 종, 입양일, 이름, 성별 및 중성화 여부를 나타냅니다. ANIMAL_OUTS 테이블의 ANIMAL_ID는 ANIMAL_INS의 ANIMAL_ID의 외래 키입니다.
-- 아직 입양을 못 간 동물 중, 가장 오래 보호소에 있었던 동물 3마리의 이름과 보호 시작일을 조회하는 SQL문을 작성해주세요. 이때 결과는 보호 시작일 순으로 조회해야 합니다.
SELECT A.NAME, A.DATETIME
FROM ANIMAL_INS A LEFT JOIN ANIMAL_OUTS B
ON A.ANIMAL_ID=B.ANIMAL_ID 
WHERE B.ANIMAL_ID IS NULL
ORDER BY A.DATETIME ASC
LIMIT 3;

-- ANIMAL_INS 테이블은 동물 보호소에 들어온 동물의 정보를 담은 테이블입니다. ANIMAL_INS 테이블 구조는 다음과 같으며, ANIMAL_ID, ANIMAL_TYPE, DATETIME, INTAKE_CONDITION, NAME, SEX_UPON_INTAKE는 각각 동물의 아이디, 생물 종, 보호 시작일, 보호 시작 시 상태, 이름, 성별 및 중성화 여부를 나타냅니다.
-- ANIMAL_OUTS 테이블은 동물 보호소에서 입양 보낸 동물의 정보를 담은 테이블입니다. ANIMAL_OUTS 테이블 구조는 다음과 같으며, ANIMAL_ID, ANIMAL_TYPE, DATETIME, NAME, SEX_UPON_OUTCOME는 각각 동물의 아이디, 생물 종, 입양일, 이름, 성별 및 중성화 여부를 나타냅니다. ANIMAL_OUTS 테이블의 ANIMAL_ID는 ANIMAL_INS의 ANIMAL_ID의 외래 키입니다.
-- 보호소에서 중성화 수술을 거친 동물 정보를 알아보려 합니다. 보호소에 들어올 당시에는 중성화1되지 않았지만, 보호소를 나갈 당시에는 중성화된 동물의 아이디와 생물 종, 이름을 조회하는 아이디 순으로 조회하는 SQL 문을 작성해주세요.
SELECT A.ANIMAL_ID, A.ANIMAL_TYPE, A.NAME
FROM ANIMAL_INS A LEFT JOIN ANIMAL_OUTS B
ON A.ANIMAL_ID=B.ANIMAL_ID
WHERE A.SEX_UPON_INTAKE!=B.SEX_UPON_OUTCOME
ORDER BY A.ANIMAL_ID

-- PRODUCT 테이블과 OFFLINE_SALE 테이블에서 상품코드 별 매출액(판매가 * 판매량) 합계를 출력하는 SQL문을 작성해주세요.
-- 결과는 매출액을 기준으로 내림차순 정렬해주시고 매출액이 같다면 상품코드를 기준으로 오름차순 정렬해주세요.
SELECT A.PRODUCT_CODE,(A.PRICE * B.CNT) AS SALES 
FROM PRODUCT AS A INNER JOIN (SELECT PRODUCT_ID, SUM(SALES_AMOUNT) AS CNT FROM OFFLINE_SALE GROUP BY PRODUCT_ID) AS B 
ON A.PRODUCT_ID=B.PRODUCT_ID 
ORDER BY SALES DESC,A.PRODUCT_CODE

-- '경제' 카테고리에 속하는 도서들의 도서 ID(BOOK_ID), 저자명(AUTHOR_NAME), 출판일(PUBLISHED_DATE) 리스트를 출력하는 SQL문을 작성해주세요.
-- 결과는 출판일을 기준으로 오름차순 정렬해주세요.
SELECT A.BOOK_ID,B.AUTHOR_NAME,DATE_FORMAT(A.PUBLISHED_DATE,'%Y-%m-%d') AS PUBLISHED_DATE 
FROM BOOK AS A LEFT JOIN AUTHOR AS B 
ON A.AUTHOR_ID=B.AUTHOR_ID 
WHERE CATEGORY='경제' 
ORDER BY PUBLISHED_DATE

-- 7월 아이스크림 총 주문량과 상반기의 아이스크림 총 주문량을 더한 값이 큰 순서대로 상위 3개의 맛을 조회하는 SQL 문을 작성해주세요.
SELECT SUB_TABLE.FLAVOR FROM (SELECT A.FLAVOR, A.TOTAL_ORDER+B.TOTAL_ORDER AS TOTAL_ORDER FROM (SELECT FLAVOR, SUM(TOTAL_ORDER) AS TOTAL_ORDER FROM JULY GROUP BY FLAVOR) AS A INNER JOIN (SELECT FLAVOR, SUM(TOTAL_ORDER) AS TOTAL_ORDER FROM FIRST_HALF GROUP BY FLAVOR) AS B ON A.FLAVOR=B.FLAVOR ORDER BY 2 DESC) AS SUB_TABLE LIMIT 3

-- MEMBER_PROFILE와 REST_REVIEW 테이블에서 리뷰를 가장 많이 작성한 회원의 리뷰들을 조회하는 SQL문을 작성해주세요. 
-- 회원 이름, 리뷰 텍스트, 리뷰 작성일이 출력되도록 작성해주시고, 결과는 리뷰 작성일을 기준으로 오름차순, 리뷰 작성일이 같다면 리뷰 텍스트를 기준으로 오름차순 정렬해주세요.
SELECT B.MEMBER_NAME, A.REVIEW_TEXT, DATE_FORMAT(A.REVIEW_DATE, '%Y-%m-%d') 
FROM (SELECT MEMBER_ID, REVIEW_TEXT, REVIEW_DATE FROM REST_REVIEW WHERE MEMBER_ID=(SELECT MEMBER_ID FROM REST_REVIEW GROUP BY MEMBER_ID ORDER BY COUNT(*) DESC LIMIT 1)) AS A LEFT JOIN (SELECT MEMBER_ID, MEMBER_NAME FROM MEMBER_PROFILE) AS B 
ON A.MEMBER_ID=B.MEMBER_ID ORDER BY 3,2

-- FOOD_PRODUCT와 FOOD_ORDER 테이블에서 생산일자가 2022년 5월인 식품들의 식품 ID, 식품 이름, 총매출을 조회하는 SQL문을 작성해주세요. 
-- 이때 결과는 총매출을 기준으로 내림차순 정렬해주시고 총매출이 같다면 식품 ID를 기준으로 오름차순 정렬해주세요.
SELECT A.PRODUCT_ID, B.PRODUCT_NAME,A.PRODUCT_NUM*B.PRICE AS TOTAL_SALES 
FROM (SELECT PRODUCT_ID,SUM(AMOUNT) AS PRODUCT_NUM FROM FOOD_ORDER WHERE PRODUCE_DATE BETWEEN '2022-05-01' AND '2022-05-31' GROUP BY PRODUCT_ID) AS A 
INNER JOIN (SELECT PRODUCT_ID, PRODUCT_NAME,PRICE FROM FOOD_PRODUCT) AS B 
ON A.PRODUCT_ID=B.PRODUCT_ID 
ORDER BY 3 DESC,1

-- CAR_RENTAL_COMPANY_CAR 테이블과 CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블과 CAR_RENTAL_COMPANY_DISCOUNT_PLAN 테이블에서 자동차 종류가 '세단' 또는 'SUV' 인 자동차 중 2022년 11월 1일부터 2022년 11월 30일까지 대여 가능하고 30일간의 대여 금액이 50만원 이상 200만원 미만인 자동차에 대해서 자동차 ID, 자동차 종류, 대여 금액(컬럼명: FEE) 리스트를 출력하는 SQL문을 작성해주세요.
-- 결과는 대여 금액을 기준으로 내림차순 정렬하고, 대여 금액이 같은 경우 자동차 종류를 기준으로 오름차순 정렬, 자동차 종류까지 같은 경우 자동차 ID를 기준으로 내림차순 정렬해주세요.
SELECT TOTAL_FEE.CAR_ID, TOTAL_FEE.CAR_TYPE, TOTAL_FEE.FEE 
FROM (SELECT A.CAR_ID, A.CAR_TYPE, ROUND(30*A.DAILY_FEE*(1-DISCOUNT_RATE*0.01)) AS FEE FROM (SELECT CAR_ID, CAR_TYPE, DAILY_FEE FROM CAR_RENTAL_COMPANY_CAR WHERE CAR_TYPE IN ('세단','SUV') AND CAR_ID NOT IN (SELECT CAR_ID FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY WHERE END_DATE>='2022-11-01' AND START_DATE<='2022-11-30')) AS A 
      INNER JOIN (SELECT CAR_TYPE, DISCOUNT_RATE FROM CAR_RENTAL_COMPANY_DISCOUNT_PLAN WHERE DURATION_TYPE='30일 이상') AS B 
      ON A.CAR_TYPE=B.CAR_TYPE) AS TOTAL_FEE 
WHERE TOTAL_FEE.FEE BETWEEN 500000 AND 2000000 ORDER BY 3 DESC, 2, 1 DESC

-- USER_INFO 테이블과 ONLINE_SALE 테이블에서 2021년에 가입한 전체 회원들 중 상품을 구매한 회원수와 상품을 구매한 회원의 비율(=2021년에 가입한 회원 중 상품을 구매한 회원수 / 2021년에 가입한 전체 회원 수)을 년, 월 별로 출력하는 SQL문을 작성해주세요. 
-- 상품을 구매한 회원의 비율은 소수점 두번째자리에서 반올림하고, 전체 결과는 년을 기준으로 오름차순 정렬해주시고 년이 같다면 월을 기준으로 오름차순 정렬해주세요.
SELECT A.USER_YEAR, A.USER_MONTH, A.PUR_NUM AS PUCHASED_USERS,ROUND(A.PUR_NUM/(SELECT COUNT(*) FROM USER_INFO WHERE YEAR(JOINED)=2021),1) AS PUCHASED_RATIO 
FROM (SELECT YEAR(SALES_DATE) AS USER_YEAR, MONTH(SALES_DATE) AS USER_MONTH,COUNT(DISTINCT(USER_ID)) AS PUR_NUM FROM ONLINE_SALE WHERE USER_ID IN (SELECT USER_ID FROM USER_INFO WHERE YEAR(JOINED)=2021) GROUP BY USER_YEAR, USER_MONTH) AS A 
ORDER BY 1, 2

-- DEVELOPERS 테이블에서 Front End 스킬을 가진 개발자의 정보를 조회하려 합니다. 조건에 맞는 개발자의 ID, 이메일, 이름, 성을 조회하는 SQL 문을 작성해 주세요.
-- 결과는 ID를 기준으로 오름차순 정렬해 주세요.
SELECT DISTINCT(ID), EMAIL, FIRST_NAME, LAST_NAME 
FROM DEVELOPERS D, (SELECT CATEGORY,CODE FROM SKILLCODES WHERE CATEGORY='Front End') S
WHERE (D.SKILL_CODE&S.CODE) > 0 
ORDER BY ID


