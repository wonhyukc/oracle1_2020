/*
	정원혁 2020.10 for Oracle
	정원혁 2014.11
	제 9장 연습3
	정원혁 / 99.5.1.
*/

-- 1.1
USE hrdb;

-- DROP TABLE caseTest;
CREATE TABLE caseTest (A VARCHAR2 (5));

INSERT INTO caseTest VALUES ('*');
INSERT INTO caseTest VALUES ('+');
INSERT INTO caseTest VALUES ('-');
INSERT INTO caseTest VALUES ('.');


SELECT a, CASE
             WHEN a = '*' THEN '곱하기'
             WHEN a = '+' THEN '더하기'
             WHEN a = '-' THEN '빼기'
             ELSE '모르는'
          END AS B
  FROM caseTest




-- 1.6 일반적인 case
select * from employee;
SELECT empName, 
	CASE 
		WHEN wages >= 8000 THEN "고액연봉자"
		WHEN wages >= 5000 THEN "보통연봉자"
		ELSE "저액연봉자"
	END as 연봉구분
FROM employee;







-- truncate table wages;
DROP TABLE wages;

-- CREATE GLOBAL TEMPORARY TABLE wages
CREATE TABLE wages
(
	id	int	GENERATED by default on null as IDENTITY
,	hourly int	NULL
,	monthly int	NULL
,	commission int	NULL
,	sales int	NULL
,	CONSTRAINT pk_wages  PRIMARY KEY (id)
)
;

-- 1.2
INSERT INTO wages VALUES(NULL, 10.00, NULL, NULL, NULL);
INSERT INTO wages VALUES(NULL, 20.00, NULL, NULL, NULL);
INSERT INTO wages VALUES(NULL, 30.00, NULL, NULL, NULL);

INSERT INTO wages VALUES(NULL, NULL, 10000.00, NULL, NULL);
INSERT INTO wages VALUES(NULL, NULL, 20000.00, NULL, NULL);
INSERT INTO wages VALUES(NULL, NULL, 30000.00, NULL, NULL);

INSERT INTO wages VALUES(NULL, NULL, NULL, 15000, 3);
INSERT INTO wages VALUES(NULL, NULL, NULL, 25000, 2);
INSERT INTO wages VALUES(NULL, NULL, NULL, 20000, 6);


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
    id,
    CASE
        WHEN hourly IS NOT NULL THEN hourly * 40 * 52
        WHEN monthly IS NOT NULL THEN monthly
        ELSE commission * sales
    END AS 연봉
FROM wages;


-- 1.5
SELECT 
    ID,
    COALESCE( 
		hourly * 40 * 52, 
        monthly, 
        commission * sales 
	)     AS 연봉
FROM
    wages;

