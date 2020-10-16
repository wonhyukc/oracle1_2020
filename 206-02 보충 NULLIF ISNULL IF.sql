/*
	정원혁 2020.10 for Oracle 미완성
*/
-- NULLIF(값1, 값2)
-- 값1 == 값2 면 NULL을 리턴

SELECT NULLif ( 3, 3) FROM dual;
-- NULL
SELECT NULLif ( 3, 2)  FROM dual;
-- 3
--select nullif(컬럼, '무응답') from 테이블;

-- 참/ 거짓
-- 1 = 참, TRUE
-- 0 = 거짓, FALSE

-- ISNULL(값1) 
-- 값1이 NULL 이면 1, 아니면 0 을 리턴
SELECT NVL (1, 0)  FROM dual;
SELECT NVL ( NULL, 0 )  FROM dual;
--select NVL(컬럼)  from 테이블;

