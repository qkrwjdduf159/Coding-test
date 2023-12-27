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