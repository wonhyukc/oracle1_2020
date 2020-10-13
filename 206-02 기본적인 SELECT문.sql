/*
	정원혁 2014.11. 
	이장래 저 "SQL Server 2012 운영과 개발 : 이장래와 함께하는" 의 스크립트를 migration
	http://www.yes24.com/SearchCorner/Search?scode=032&ozsrank=1&author_yn=y&query=%c0%cc%c0%e5%b7%a1&domain=all
	
	https://github.com/wonhyukc/mySQL
*/
-- 
--  6.2 기본적인 SELECT 문
-- 

use HRDB;
-- 
--  A. 기본적인 SELECT 문
-- 
-- 1) 테이블의 전제 데이터 가져오기
SELECT *	FROM Employee;


-- 2) 특정 컬럼의 데이터만 가져오기

SELECT EmpID, EmpName, HireDate, EMail
FROM Employee;


-- 3) 특정 행의 데이터만 가져오기

SELECT *
FROM Employee
WHERE EmpID = 'S0005';


-- 4) 특정 열의 특정 행만 가져오기

SELECT EmpID, EmpName, HireDate, EMail
	FROM Employee
	WHERE EmpID = 'S0005';


-- 5) 비교 연산자 사용

SELECT EmpID, EmpName, HireDate, EMail
	FROM Employee
	WHERE EmpID = 'S0005';


SELECT EmpID, EmpName, HireDate, EMail
	FROM Employee
	WHERE Salary >= 8000;

SELECT EmpID, EmpName, HireDate, EMail
	FROM Employee
	WHERE HireDate < TO_DATE('2007-01-01', 'YYYY-MM-DD');


-- 6) 문자열 비교: LIKE

SELECT EmpID, EmpName, HireDate, EMail
	FROM Employee
	WHERE EmpName = '홍길동';

SELECT EmpID, EmpName, HireDate, EMail
	FROM Employee
	WHERE EmpName LIKE '김%';


-- 7) 논리 연산자 사용: AND, OR, NOT

SELECT EmpID, EmpName, HireDate, EMail, Salary
	FROM Employee
	WHERE HireDate >= TO_DATE('2008-01-01', 'YYYY-MM-DD') AND Salary >= 6000;

SELECT EmpID, EmpName, HireDate, EMail, Salary
	FROM Employee
	WHERE HireDate >= TO_DATE('2008-01-01', 'YYYY-MM-DD') OR Salary >= 6000;

SELECT EmpID, EmpName, HireDate, EMail, Salary
	FROM Employee
	WHERE HireDate >= TO_DATE('2008-01-01', 'YYYY-MM-DD') AND NOT  Salary >= 6000;


-- 8) 범위 조건 지정: BETWEEN

SELECT EmpID, EmpName, HireDate, EMail, Salary
	FROM Employee
	WHERE Salary BETWEEN 6000 AND 8000;

SELECT EmpID, EmpName, HireDate, EMail, Salary
	FROM Employee
	WHERE Salary >= 6000 AND Salary <= 8000;


-- 9) 리스트 조건 지정: IN

SELECT EmpID, EmpName, HireDate, DeptID, EMail, Salary
	FROM Employee
	WHERE DeptID IN ('SYS', 'MKT', 'HRD');

SELECT EmpID, EmpName, HireDate, DeptID, EMail, Salary
	FROM Employee
	WHERE DeptID = 'SYS' OR DeptID = 'MKT' OR DeptID = 'HRD';



-- 
--  B. NULL 값에 대한 비교
-- 


-- 1) IS NULL

SELECT EmpID, EmpName, HireDate, EMail, Salary, Gender, RetireDate
   FROM Employee
   WHERE Gender = 'F' AND RetireDate IS NULL;


-- 2) NULL과 관련된 함수

-- NULL관련 함수 기능 확인을 위해 데이터 변경
UPDATE Employee
	SET Salary = NULL
	WHERE EmpID = 'S0020';

-- NVL()
SELECT EmpID, EmpName, NVL(Salary,0) as Salary
   FROM Employee
   WHERE HireDate >= TO_DATE('2009-01-01', 'YYYY-MM-DD') ;

-- NULLIF()
SELECT EmpID, EmpName, NULLIF(DeptID, 'SYS') AS DeptID, HireDate, EMail
   FROM Employee
   WHERE DeptID IN ('SYS', 'MKT') ;


-- COALESCE()
SELECT EmpID, EmpName, HireDate, EMail, COALESCE(round(Salary/12, 0), 100) as Bonus
   FROM Employee
   WHERE HireDate >= TO_DATE('2009-01-01', 'YYYY-MM-DD') ;




-- 
--  C. 결과 집합의 형태 변경
-- 


-- 1) 데이터 정렬: ORDER BY

SELECT EmpID, EmpName, HireDate, Salary
   FROM Employee
   WHERE DeptID = 'SYS'
   ORDER BY Salary DESC;


-- 2) 중복 생략

SELECT DISTINCT DeptID 
	FROM Employee;


-- 3) 별칭: AS
SELECT EmpID AS 사번, EmpName AS 이름, Gender AS 성별, HireDate AS 입사일, RetireDate AS 퇴사일
	FROM Employee
	WHERE RetireDate IS NOT NULL;


-- 4) 열에 대한 계산식 사용

SELECT EmpID, EmpName, concat(EmpName , EmpID) AS EmpName, Gender, EMail 
	FROM Employee
	WHERE DeptID = 'MKT';


/*
SELECT EmpID, EmpName, CAST(HireDate as CHARACTER ) AS 'HireDate', Gender, EMail
	FROM Employee
	WHERE DeptID  = 'SYS';

SELECT EmpID, EmpName, HireDate, Gender, EMail
	FROM Employee
	WHERE DeptID  = 'SYS';
*/