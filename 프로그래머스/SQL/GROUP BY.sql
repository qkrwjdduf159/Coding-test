-- ANIMAL_INS 테이블은 동물 보호소에 들어온 동물의 정보를 담은 테이블입니다. ANIMAL_INS 테이블 구조는 다음과 같으며, ANIMAL_ID, ANIMAL_TYPE, DATETIME, INTAKE_CONDITION, NAME, SEX_UPON_INTAKE는 각각 동물의 아이디, 생물 종, 보호 시작일, 보호 시작 시 상태, 이름, 성별 및 중성화 여부를 나타냅니다.
-- 동물 보호소에 들어온 동물 이름 중 두 번 이상 쓰인 이름과 해당 이름이 쓰인 횟수를 조회하는 SQL문을 작성해주세요. 이때 결과는 이름이 없는 동물은 집계에서 제외하며, 결과는 이름 순으로 조회해주세요.
SELECT NAME, COUNT(NAME) 
FROM ANIMAL_INS 
GROUP BY NAME
HAVING COUNT(NAME) >= 2
ORDER BY NAME;

-- ANIMAL_OUTS 테이블은 동물 보호소에서 입양 보낸 동물의 정보를 담은 테이블입니다. ANIMAL_OUTS 테이블 구조는 다음과 같으며, ANIMAL_ID, ANIMAL_TYPE, DATETIME, NAME, SEX_UPON_OUTCOME는 각각 동물의 아이디, 생물 종, 입양일, 이름, 성별 및 중성화 여부를 나타냅니다.
-- 보호소에서는 몇 시에 입양이 가장 활발하게 일어나는지 알아보려 합니다. 09:00부터 19:59까지, 각 시간대별로 입양이 몇 건이나 발생했는지 조회하는 SQL문을 작성해주세요. 이때 결과는 시간대 순으로 정렬해야 합니다.
SELECT hour(DATETIME) AS HOUR, COUNT(*) FROM ANIMAL_OUTS
WHERE hour(DATETIME) >= 9 AND hour(DATETIME) < 20
GROUP BY hour(DATETIME)
ORDER BY hour(DATETIME);

-- ANIMAL_OUTS 테이블은 동물 보호소에서 입양 보낸 동물의 정보를 담은 테이블입니다. ANIMAL_OUTS 테이블 구조는 다음과 같으며, ANIMAL_ID, ANIMAL_TYPE, DATETIME, NAME, SEX_UPON_OUTCOME는 각각 동물의 아이디, 생물 종, 입양일, 이름, 성별 및 중성화 여부를 나타냅니다.
-- 보호소에서는 몇 시에 입양이 가장 활발하게 일어나는지 알아보려 합니다. 0시부터 23시까지, 각 시간대별로 입양이 몇 건이나 발생했는지 조회하는 SQL문을 작성해주세요. 이때 결과는 시간대 순으로 정렬해야 합니다.

-- recursive 함수를 통해서 HOUR를 뽑아 낸 후 left join을 통해 데이터를 붙여 넣는다.
WITH RECURSIVE HOUR AS (
   SELECT 0 AS num
   UNION ALL
   SELECT num + 1 FROM HOUR WHERE num < 24
)

SELECT A.num AS 'HOUR', IFNULL(count(HOUR(B.DATETIME)),0) AS 'COUNT'
FROM HOUR A LEFT JOIN ANIMAL_OUTS B
on A.num=hour(B.DATETIME)
GROUP BY A.num
ORDER BY A.num
LIMIT 24;


-- REST_INFO 테이블에서 음식종류별로 즐겨찾기수가 가장 많은 식당의 음식 종류, ID, 식당 이름, 즐겨찾기수를 조회하는 SQL문을 작성해주세요. 이때 결과는 음식 종류를 기준으로 내림차순 정렬해주세요.
-- 처음엔 SELECT FOOD_TYPE, REST_ID, REST_NAME, MAX(FAVORITES) FROM REST_INFO 형식으로 작성을 했으나 문제는 REST_ID와 REST_NAME이 랜덤으로 나와서 정답이 나올 수가 없었다.
-- 담부터도 이렇게 지정을 해줘야 문제 없이 쿼리문을 작성할 수 있을 것 같다.
SELECT A.FOOD_TYPE, A.REST_ID, A.REST_NAME, A.FAVORITES 
FROM REST_INFO AS A 
INNER JOIN 
(SELECT FOOD_TYPE, MAX(FAVORITES) AS FAVORITES FROM REST_INFO GROUP BY FOOD_TYPE) AS B
ON A.FOOD_TYPE=B.FOOD_TYPE AND A.FAVORITES=B.FAVORITES
ORDER BY FOOD_TYPE DESC

-- USED_GOODS_BOARD와 USED_GOODS_USER 테이블에서 완료된 중고 거래의 총금액이 70만 원 이상인 사람의 회원 ID, 닉네임, 총거래금액을 조회하는 SQL문을 작성해주세요. 결과는 총거래금액을 기준으로 오름차순 정렬해주세요.
-- A와 B의 INNERJOIN을 진행했을 때 ON을 통해서 두 테이블의 조건을 맞춰주는 것이 중요하다.
SELECT B.USER_ID, B.NICKNAME, A.TOTAL_SALES 
FROM (SELECT WRITER_ID, SUM(PRICE) AS TOTAL_SALES FROM USED_GOODS_BOARD WHERE STATUS='DONE' GROUP BY WRITER_ID) AS A 
INNER JOIN (SELECT USER_ID, NICKNAME FROM USED_GOODS_USER) AS B 
ON A.WRITER_ID=B.USER_ID
WHERE A.TOTAL_SALES>=700000 ORDER BY TOTAL_SALES

-- PRODUCT 테이블에서 만원 단위의 가격대 별로 상품 개수를 출력하는 SQL 문을 작성해주세요.
-- 이때 컬럼명은 각각 컬럼명은 PRICE_GROUP, PRODUCTS로 지정해주시고 가격대 정보는 각 구간의 최소금액(10,000원 이상 ~ 20,000 미만인 구간인 경우 10,000)으로 표시해주세요. 결과는 가격대를 기준으로 오름차순 정렬해주세요.
SELECT FLOOR(PRICE/10000)*10000 AS PRICE_GROUP, COUNT(*) PRODUCT FROM PRODUCT GROUP BY PRICE_GROUP ORDER BY PRICE_GROUP

-- 상반기 동안 각 아이스크림 성분 타입과 성분 타입에 대한 아이스크림의 총주문량을 총주문량이 작은 순서대로 조회하는 SQL 문을 작성해주세요. 이때 총주문량을 나타내는 컬럼명은 TOTAL_ORDER로 지정해주세요.
SELECT INGREDIENT_TYPE, SUM(TOTAL_ORDER) AS TOTAL_ORDER FROM (FIRST_HALF AS A INNER JOIN ICECREAM_INFO AS B ON A.FLAVOR = B.FLAVOR) GROUP BY INGREDIENT_TYPE ORDER BY TOTAL_ORDER

-- CAR_RENTAL_COMPANY_CAR 테이블에서 '통풍시트', '열선시트', '가죽시트' 중 하나 이상의 옵션이 포함된 자동차가 자동차 종류 별로 몇 대인지 출력하는 SQL문을 작성해주세요. 
-- 이때 자동차 수에 대한 컬럼명은 CARS로 지정하고, 결과는 자동차 종류를 기준으로 오름차순 정렬해주세요.
SELECT CAR_TYPE, COUNT(*) AS CARS FROM CAR_RENTAL_COMPANY_CAR 
WHERE OPTIONS LIKE '%가죽시트%' OR OPTIONS LIKE '%열선시트%' OR OPTIONS LIKE '%통풍시트%'
GROUP BY CAR_TYPE ORDER BY CAR_TYPE

-- APPOINTMENT 테이블에서 2022년 5월에 예약한 환자 수를 진료과코드 별로 조회하는 SQL문을 작성해주세요. 
-- 이때, 컬럼명은 '진료과 코드', '5월예약건수'로 지정해주시고 결과는 진료과별 예약한 환자 수를 기준으로 오름차순 정렬하고, 예약한 환자 수가 같다면 진료과 코드를 기준으로 오름차순 정렬해주세요.
-- ORDER BY에서 변수 명을 수정한다면 바뀌지 않는다 -> 숫자로 표현하는 연습이 필요
SELECT MCDP_CD AS '진료과코드', COUNT(APNT_NO) AS '5월예약건수' FROM APPOINTMENT WHERE MONTH(APNT_YMD)=5 AND YEAR(APNT_YMD)=2022 GROUP BY MCDP_CD ORDER BY 2,1

-- USER_INFO 테이블과 ONLINE_SALE 테이블에서 년, 월, 성별 별로 상품을 구매한 회원수를 집계하는 SQL문을 작성해주세요. 결과는 년, 월, 성별을 기준으로 오름차순 정렬해주세요. 
-- 이때, 성별 정보가 없는 경우 결과에서 제외해주세요.
SELECT B.YEAR,B.MONTH,A.GENDER, COUNT(DISTINCT(A.USER_ID)) AS USERS 
FROM (SELECT USER_ID, GENDER FROM USER_INFO WHERE GENDER IS NOT NULL) AS A 
INNER JOIN (SELECT USER_ID, YEAR(SALES_DATE) AS YEAR, MONTH(SALES_DATE) AS MONTH FROM ONLINE_SALE) AS B ON A.USER_ID=B.USER_ID 
GROUP BY YEAR,MONTH,GENDER ORDER BY 1,2,3

-- FOOD_PRODUCT 테이블에서 식품분류별로 가격이 제일 비싼 식품의 분류, 가격, 이름을 조회하는 SQL문을 작성해주세요. 
-- 이때 식품분류가 '과자', '국', '김치', '식용유'인 경우만 출력시켜 주시고 결과는 식품 가격을 기준으로 내림차순 정렬해주세요.
SELECT A.CATEGORY,MAX(A.PRICE) AS MAX_PRICE, B.PRODUCT_NAME 
FROM (SELECT CATEGORY,MAX(PRICE) AS PRICE,PRODUCT_NAME FROM FOOD_PRODUCT GROUP BY CATEGORY) AS A LEFT JOIN (SELECT CATEGORY, PRODUCT_NAME,PRICE FROM FOOD_PRODUCT) AS B 
ON A.CATEGORY=B.CATEGORY AND A.PRICE=B.PRICE 
WHERE A.CATEGORY IN ('과자','국','김치','식용유')
GROUP BY A.CATEGORY, B.PRODUCT_NAME ORDER BY 2 DESC


-- CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블에서 2022년 10월 16일에 대여 중인 자동차인 경우 '대여중' 이라고 표시하고, 대여 중이지 않은 자동차인 경우 '대여 가능'을 표시하는 컬럼(컬럼명: AVAILABILITY)을 추가하여 자동차 ID와 AVAILABILITY 리스트를 출력하는 SQL문을 작성해주세요.
-- 이때 반납 날짜가 2022년 10월 16일인 경우에도 '대여중'으로 표시해주시고 결과는 자동차 ID를 기준으로 내림차순 정렬해주세요.
SELECT A.CAR_ID,IFNULL(B.cnt,'대여 가능') AS AVAILABILITY 
FROM (SELECT DISTINCT(CAR_ID) FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY) AS A 
LEFT JOIN (SELECT CAR_ID,'대여중' AS cnt FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY WHERE (START_DATE) <= '2022-10-16' AND END_DATE >= '2022-10-16') AS B 
ON A.CAR_ID=B.CAR_ID 
ORDER BY A.CAR_ID DESC

-- 2022년 1월의 카테고리 별 도서 판매량을 합산하고, 카테고리(CATEGORY), 총 판매량(TOTAL_SALES) 리스트를 출력하는 SQL문을 작성해주세요.
-- 결과는 카테고리명을 기준으로 오름차순 정렬해주세요.
SELECT CATEGORY, SUM(SUM_SALES) AS TOTAL_SALES 
FROM (SELECT BOOK_ID, CATEGORY FROM BOOK) AS A 
INNER JOIN (SELECT BOOK_ID,SUM(SALES) AS SUM_SALES FROM BOOK_SALES WHERE YEAR(SALES_DATE)=2022 AND MONTH(SALES_DATE)=1 GROUP BY BOOK_ID) AS B 
ON A.BOOK_ID=B.BOOK_ID 
GROUP BY CATEGORY 
ORDER BY CATEGORY

-- CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블에서 대여 시작일을 기준으로 2022년 8월부터 2022년 10월까지 총 대여 횟수가 5회 이상인 자동차들에 대해서 해당 기간 동안의 월별 자동차 ID 별 총 대여 횟수(컬럼명: RECORDS) 리스트를 출력하는 SQL문을 작성해주세요.
-- 결과는 월을 기준으로 오름차순 정렬하고, 월이 같다면 자동차 ID를 기준으로 내림차순 정렬해주세요. 특정 월의 총 대여 횟수가 0인 경우에는 결과에서 제외해주세요.
SELECT MONTH(START_DATE) AS MONTH, CAR_ID, COUNT(*) AS RECORDS
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY 
WHERE MONTH(START_DATE) IN ('8','9','10') AND CAR_ID IN (SELECT CAR_ID FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY WHERE MONTH(START_DATE) IN (8,9,10) GROUP BY CAR_ID HAVING COUNT(*)>=5) 
GROUP BY MONTH(START_DATE),CAR_ID 
ORDER BY 1,2 DESC

-- 2022년 1월의 도서 판매 데이터를 기준으로 저자 별, 카테고리 별 매출액(TOTAL_SALES = 판매량 * 판매가) 을 구하여, 저자 ID(AUTHOR_ID), 저자명(AUTHOR_NAME), 카테고리(CATEGORY), 매출액(SALES) 리스트를 출력하는 SQL문을 작성해주세요.
-- 결과는 저자 ID를 오름차순으로, 저자 ID가 같다면 카테고리를 내림차순 정렬해주세요.
SELECT SALES_TABLE.AUTHOR_ID,AUTHOR_TABLE.AUTHOR_NAME,SALES_TABLE.CATEGORY, SUM(SALES_TABLE.TOTAL_SALES) TOTAL_SALES FROM (SELECT A.BOOK_ID,A.AUTHOR_ID,A.CATEGORY,A.PRICE*B.SALES AS TOTAL_SALES FROM (SELECT BOOK_ID, AUTHOR_ID, CATEGORY,PRICE FROM BOOK) AS A LEFT JOIN (SELECT BOOK_ID, SUM(SALES) AS SALES FROM BOOK_SALES WHERE MONTH(SALES_DATE)=1 AND YEAR(SALES_DATE)=2022 GROUP BY BOOK_ID) AS B ON A.BOOK_ID=B.BOOK_ID) AS SALES_TABLE 
LEFT JOIN AUTHOR AS AUTHOR_TABLE 
ON SALES_TABLE.AUTHOR_ID=AUTHOR_TABLE.AUTHOR_ID 
GROUP BY SALES_TABLE.AUTHOR_ID, SALES_TABLE.CATEGORY
ORDER BY 1 ASC,3 DESC

-- HR_DEPARTMENT, HR_EMPLOYEES, HR_GRADE 테이블에서 2022년도 한해 평가 점수가 가장 높은 사원 정보를 조회하려 합니다. 2022년도 평가 점수가 가장 높은 사원들의 점수, 사번, 성명, 직책, 이메일을 조회하는 SQL문을 작성해주세요.
2022년도의 평가 점수는 상,하반기 점수의 합을 의미하고, 평가 점수를 나타내는 컬럼의 이름은 SCORE로 해주세요.
SELECT B.SCORE, A.EMP_NO, A.EMP_NAME, A.POSITION, A.EMAIL 
FROM (SELECT EMP_NO, EMP_NAME, POSITION, EMAIL FROM HR_EMPLOYEES) AS A INNER JOIN (SELECT EMP_NO, SUM(SCORE) AS SCORE FROM HR_GRADE WHERE YEAR=2022 GROUP BY EMP_NO) AS B 
ON A.EMP_NO=B.EMP_NO 
ORDER BY 1 DESC 
LIMIT 1;

-- HR_DEPARTMENT와 HR_EMPLOYEES 테이블을 이용해 부서별 평균 연봉을 조회하려 합니다. 부서별로 부서 ID, 영문 부서명, 평균 연봉을 조회하는 SQL문을 작성해주세요. 평균연봉은 소수점 첫째 자리에서 반올림하고 컬럼명은 AVG_SAL로 해주세요.
-- 결과는 부서별 평균 연봉을 기준으로 내림차순 정렬해주세요.
SELECT B.DEPT_ID, A.DEPT_NAME_EN,ROUND(B.AVG_SAL) AS AVG_SAL 
FROM (SELECT DEPT_ID, DEPT_NAME_EN FROM HR_DEPARTMENT) AS A INNER JOIN (SELECT DEPT_ID, AVG(SAL) AS AVG_SAL FROM HR_EMPLOYEES GROUP BY DEPT_ID) AS B 
ON A.DEPT_ID=B.DEPT_ID 
ORDER BY 3 DESC

-- FISH_NAME_INFO에서 물고기의 종류 별 물고기의 이름과 잡은 수를 출력하는 SQL문을 작성해주세요. 물고기의 이름 컬럼명은 FISH_NAME, 잡은 수 컬럼명은 FISH_COUNT로 해주세요. 결과는 잡은 수 기준으로 내림차순 정렬해주세요.
SELECT A.NUM AS FISH_COUNT, B.FISH_NAME 
FROM (SELECT FISH_TYPE, COUNT(*) AS NUM FROM FISH_INFO GROUP BY FISH_TYPE) AS A 
LEFT JOIN FISH_NAME_INFO AS B 
ON A.FISH_TYPE=B.FISH_TYPE 
ORDER BY 1 DESC

-- HR_DEPARTMENT, HR_EMPLOYEES, HR_GRADE 테이블을 이용해 사원별 성과금 정보를 조회하려합니다. 평가 점수별 등급과 등급에 따른 성과금 정보가 아래와 같을 때, 사번, 성명, 평가 등급, 성과금을 조회하는 SQL문을 작성해주세요.
-- 평가등급의 컬럼명은 GRADE로, 성과금의 컬럼명은 BONUS로 해주세요. 결과는 사번 기준으로 오름차순 정렬해주세요.
SELECT A.EMP_NO, A.EMP_NAME,
CASE
WHEN B.SCORE>=96 THEN 'S'
WHEN (B.SCORE>=90) AND (B.SCORE<96) THEN 'A'
WHEN (B.SCORE>=80) AND (B.score<90) THEN 'B'
WHEN (B.SCORE<80) THEN 'C'
END AS GRADE,
CASE
WHEN B.SCORE>=96 THEN SAL*0.2
WHEN (B.SCORE>=90) AND (B.SCORE<96) THEN SAL*0.15
WHEN (B.SCORE>=80) AND (B.score<90) THEN SAL*0.1
WHEN (B.SCORE<80) THEN 0
END AS BONUS
FROM (SELECT EMP_NO, EMP_NAME, SAL FROM HR_EMPLOYEES) AS A 
LEFT JOIN (SELECT EMP_NO, AVG(SCORE) AS SCORE FROM HR_GRADE GROUP BY EMP_NO) AS B 
ON A.EMP_NO=B.EMP_NO
ORDER BY EMP_NO

-- 월별 잡은 물고기의 수와 월을 출력하는 SQL문을 작성해주세요. 잡은 물고기 수 컬럼명은 FISH_COUNT, 월 컬럼명은 MONTH로 해주세요. 결과는 월을 기준으로 오름차순 정렬해주세요.
-- 단, 월은 숫자형태 (1~12) 로 출력하며 9 이하의 숫자는 두 자리로 출력하지 않습니다. 잡은 물고기가 없는 월은 출력하지 않습니다.
SELECT COUNT(*) AS FISH_COUNT, MONTH(TIME) AS MONTH 
FROM FISH_INFO 
GROUP BY MONTH(TIME) 
ORDER BY 2

