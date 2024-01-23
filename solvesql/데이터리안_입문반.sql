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

-- points 테이블에 쿼리를 수행해 quartet으로 구분되는 각 서브셋 데이터에 대해서 아래 통계량을 계산하는 쿼리를 작성해주세요. 계산된 값은 소수점 아래 셋째 자리에서 반올림 해야 합니다.
-- 결과 데이터에는 아래 5개의 컬럼이 존재 해야 합니다.
SELECT
  quartet,
  round(avg(x), 2) as x_mean,
  round(variance(x),2) as x_var,
  round(avg(y), 2) as y_mean,
  round(variance(y),2) as y_var
FROM
  points
group by
  quartet
  
-- 쿼리 결과에는 모든 컬럼이 출력되어야 합니다. 테이블 당 일행의 수는 size 컬럼에 들어있습니다. 예를 들어, 5명이서 방문한 테이블의 경우 size 컬럼의 값이 5입니다.
SELECT * FROM tips WHERE size%2==1

-- 2000년 이후 올림픽이 개최된 도시의 이름을 앞에서부터 3글자만 추출하는 쿼리를 작성해주세요. 쿼리 결과에는 올림픽 개최년도와 개최 도시만 출력되도록 하되, 도시 이름은 대문자로 출력되어야합니다.
-- 쿼리 결과에는 아래 두 개의 컬럼이 있어야하고, 결과는 최근에 개최된 도시부터 내림차순으로 정렬되어있어야 합니다.
SELECT
  year,
  upper(substr(city, 1, 3)) as city
FROM
  games
WHERE
  year >= 2000
ORDER BY
  1 DESC

-- 우리 플랫폼에서 상품을 많이 판매하고 있는 판매자가 누구인지 알고 싶습니다. 총 주문이 100건 이상 들어온 판매자 리스트를 출력하는 쿼리를 작성해주세요.
SELECT
  seller_id,
  count(distinct order_id) as orders
FROM
  olist_order_items_dataset
group by
  seller_id
having
  count(distinct order_id) >= 100

  -- 요일별로 팁 총액을 집계하고 팁이 가장 많았던 요일과 그날의 팁 총액을 출력하는 쿼리를 작성해주세요. 그날의 팁 총액은 소수점 셋째 자리에서 반올림하여 출력되도록 해주세요.
  SELECT
  day,
  round(sum(tip), 2) as tip_daily
FROM
  tips
GROUP BY
  day
ORDER BY
  2 DESC
limit
  1

-- 주문 일자를 나타내는 order_purchase_timestamp 컬럼을 통해 첫 주문 일자와 마지막 주문 일자를 알아보려고 합니다. 아래 두 컬럼을 포함하는 쿼리를 작성해주세요.
SELECT
  date(min(order_purchase_timestamp)) as first_order_date,
  date(max(order_purchase_timestamp)) as last_order_date
FROM
  olist_orders_dataset

-- tips 테이블에는 식사 금액, 팁, 결제자 성별, 요일, 시간대 등 어느 레스토랑의 테이블 당 결제에 관련된 데이터가 들어있습니다. 식사 금액이 테이블 당 평균 식사 금액보다 더 많은 경우를 모두 출력하는 쿼리를 작성해주세요. 결과에는 tips 테이블에 있는 모든 컬럼이 포함되어야 합니다.
SELECT
  *
FROM
  tips
where
  total_bill >= (
    SELECT
      avg(total_bill)
    FROM
      tips
  )