/* How many members in the dataset? */

SELECT COUNT (DISTINCT member_id)
FROM cloverhealth.hw_phx c

/* How many males and females are in the dataset */

SELECT SUM(t2.males) AS total_males,
       SUM(t2.females) AS total_females
FROM (SELECT t1.gender,
       CASE WHEN t1.gender = 'Male'
       THEN 1 ELSE 0 END AS males,
       CASE WHEN t1.gender = 'Female'
       THEN 1 ELSE 0 END AS females
FROM (SELECT DISTINCT c.member_id,
      c.gender
      FROM cloverhealth.hw_phx c) t1) t2

/* Which doctor id created the most claims */

SELECT prescribing_doctor_id as doctor_id,
       COUNT (DISTINCT claim_number)
  FROM cloverhealth.hw_phx
GROUP BY 1
ORDER BY 2 DESC

/* Youngest vs oldest member on the site */

SELECT MIN(age),
       MAX(age)
  FROM cloverhealth.hw_phx

/* Age correlation with health risk score */

SELECT age,
       AVG(member_health_risk_assesment_score) AS average_health_risk_score
FROM cloverhealth.hw_phx
GROUP BY 1
ORDER BY 2 DESC

/* Gender correlation with average age and average health risk */

SELECT gender,
       AVG(age) AS avg_age,
       AVG(member_health_risk_assesment_score) AS health_risk
  FROM cloverhealth.hw_phx
GROUP BY 1

/* 30 day refills vs 90 day refills */

SELECT SUM(tb1.thirty) AS thirty_day_rx,
       SUM(tb1.ninety) AS ninety_day_rx
FROM (SELECT
    CASE WHEN days_supply = 90
    THEN 1 ELSE 0 END AS ninety,
    CASE WHEN days_supply = 30
    THEN 1 ELSE 0 END AS thirty
  FROM cloverhealth.hw_phx) tb1

/* Member with the most claims */

SELECT member_id,
       COUNT(claim_number) AS claims
  FROM cloverhealth.hw_phx
GROUP BY 1
ORDER BY 2 DESC
LIMIT 3

/* Information about the member with the most claims */

SELECT *
  FROM cloverhealth.hw_phx
WHERE member_id = '1633082115999'

/* Most claims in month */

SELECT
  DATE_TRUNC('month', day_filled),
  COUNT(day_filled)
  FROM cloverhealth.hw_phx
GROUP BY 1
ORDER BY 2 DESC

/* Who has the highest health risk */

SELECT member_id,
       member_health_risk_assesment_score
FROM cloverhealth.hw_phx
GROUP BY 1, 2
ORDER BY 2 DESC
LIMIT 1

/* Highest health risk score among gender */

SELECT
       DISTINCT (c.member_id),
       c.gender,
       c.age,
       c.member_health_risk_assesment_score AS max_health_risk
FROM cloverhealth.hw_phx c
INNER JOIN
( SELECT
       DISTINCT (member_id),
       gender,
       MAX(age) AS max_age,
       MAX(member_health_risk_assesment_score) AS max_health_score
  FROM cloverhealth.hw_phx
GROUP BY 1,2) t1

ON c.member_id = t1.member_id AND c.gender = t1.gender AND c.age = t1.max_age

ORDER BY 4 DESC
