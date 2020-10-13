/*
	제 9장 연습3
	정원혁 / 99.5.1.
*/

-- 1.1
USE hrdb;
DROP TABLE IF EXISTS wages ;

CREATE TEMPORARY TABLE wages
(
	사번	TINYINT	primary key AUTO_INCREMENT
,	시급 float	NULL
,	월급 float	NULL
,	수수료 float	NULL
,	판매량 int	NULL
)
;

-- 1.2
INSERT wages VALUES(NULL, 10.00, NULL, NULL, NULL);
INSERT wages VALUES(NULL, 20.00, NULL, NULL, NULL);
INSERT wages VALUES(NULL, 30.00, NULL, NULL, NULL);

INSERT wages VALUES(NULL, NULL, 10000.00, NULL, NULL);
INSERT wages VALUES(NULL, NULL, 20000.00, NULL, NULL);
INSERT wages VALUES(NULL, NULL, 30000.00, NULL, NULL);

INSERT wages VALUES(NULL, NULL, NULL, 15000, 3);
INSERT wages VALUES(NULL, NULL, NULL, 25000, 2);
INSERT wages VALUES(NULL, NULL, NULL, 20000, 6);


-- 1.3
SELECT * FROM wages;


/*
case
	when 조건 then 참일때
    when 조건 then 참일때
    else 앞선조건에해당안될때 
end 
*/
-- 1.4
SELECT 
    *,
    CASE
        WHEN 시급 IS NOT NULL THEN 시급 * 40 * 52
        WHEN 월급 IS NOT NULL THEN 월급
        ELSE 수수료 * 판매량
    END AS '연봉'
FROM
    wages;

-- 1.5
SELECT 
    사번,
    COALESCE( 
		시급 * 40 * 52, 
        월급, 
        수수료 * 판매량 
	)     AS '연봉'
FROM
    wages;


-- 1.6 일반적인 case
select * from employee;
SELECT empName, 
	CASE 
		WHEN Salary >= 8000 THEN "고액연봉자"
		WHEN Salary >= 5000 THEN "보통연봉자"
		ELSE "저액연봉자"
	END as 연봉구분
FROM employee;