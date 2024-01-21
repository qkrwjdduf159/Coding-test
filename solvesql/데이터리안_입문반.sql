-- points 테이블에 있는 모든 데이터를 조회하는 쿼리를 작성해주세요.
SELECT * FROM POINTS

-- points 테이블에서 quartet 컬럼의 값이 I인 데이터만 조회하되, y 컬럼의 값을 기준으로 오름차순 정렬이 되도록 쿼리를 작성해주세요.
SELECT * FROM POINTS WHERE quartet='I' ORDER BY y

-- points 테이블에 있는 모든 데이터의 x, y 컬럼을 조회하는 쿼리를 작성해주세요.
SELECT x,y FROM POINTS

-- 레스토랑이 무슨 요일에 영업을 하는지 궁금합니다. tips 테이블에 들어있는 요일 데이터를 중복없이 보여주는 쿼리를 작성해주세요.
-- 요일은 tips 테이블의 day 컬럼에 들어있습니다. 결과 컬럼의 이름은 day_of_week로 표시해주세요.
SELECT distinct day as day_of_week FROM tips

-- 고객이 Olist 상점에서 신용카드로 주문한 내역을 할부 개월 수 별로 나누어 살펴보려고 합니다. 할부 개월 수 별로 주문 수, 최소 결제 금액, 최대 결제 금액, 평균 결제 금액을 집계해주세요. 결과 데이터에는 5개의 컬럼이 들어가야 합니다.
-- payment_installments - 할부 개월 수
-- order_count - 주문 수
-- min_value - 최소 결제 금액
-- max_value - 최대 결제 금액
-- avg_value - 평균 결제 금액
SELECT
  payment_installments,
  count(distinct order_id) as order_count,
  min(payment_value) as min_value,
  max(payment_value) as max_value,
  avg(payment_value) as avg_value
FROM
  olist_order_payments_dataset
WHERE
  payment_type='credit_card'
GROUP BY
  payment_installments

-- US E-Commerce Records 2020 데이터셋은 미국 이커머스 웹사이트의 판매 데이터 입니다. records 테이블은 주문 번호, 주문 날짜, 주문 지역, 카테고리 등 주문의 상세 정보를 담고 있습니다. 이 데이터를 이용하여 미국의 각 지역별로 어떤 카테고리의 상품이 많이 판매되는지 알아보려고 합니다. region, category 별 주문량을 계산해 출력하는 쿼리를 작성해주세요.
-- 결과 데이터의 각 컬럼은 다음과 같은 의미를 갖습니다.
-- Region - 주문 지역
-- Furniture - 해당 지역 내 가구(’Furniture’) 주문 수
-- Office Supplies - 해당 지역 내 오피스 물품(’Office Supplies’) 주문 수
-- Technology - 해당 지역 내 전자기기(’Technology’) 주문 수
SELECT region as Region,
count(distinct(case when category='Furniture' THEN order_id end)) as Furniture,
count(distinct(case when category='Office Supplies' THEN order_id end)) as 'Office Supplies',
count(distinct(case when category='Technology' THEN order_id end)) as Technology 
FROM records
group by region
ORDER BY 1