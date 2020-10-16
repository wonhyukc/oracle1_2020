/*
	정원혁 2020.10 for Oracle
	정원혁 2014.11. 
	이장래 저 "SQL Server 2012 운영과 개발 : 이장래와 함께하는" 의 스크립트를 migration
	http://www.yes24.com/SearchCorner/Search?scode=032&ozsrank=1&author_yn=y&query=%c0%cc%c0%e5%b7%a1&domain=all
*/
use HRDB;

-- 
--  6.4 데이터 집계
-- 

-- 
--  A. 기본적인 데이터 집계
-- 

-- 1) 집계 함수 사용
select * FROM Employee;

select sum(salary) FROM Employee;
select AVG(salary) FROM Employee;

select count(salary) FROM Employee;
select count(*) FROM Employee;
select count(RetireDate) FROM Employee;

-- 근무 중인 직원들의 급여의 합 구하기
SELECT SUM(Salary) AS Tot_Salary
	FROM Employee
	WHERE RetireDate IS NULL;

--  근무 중인 직원들의 급여의 최대값, 최소값, 최대값 - 최소값을 구하는 쿼리를 작성하자.

SELECT MAX(Salary) AS Max_Salary, MIN(Salary) AS  Min_Salary,
			 MAX(Salary) - MIN(Salary) AS  연봉격차, 
             count(*) as 갯수, avg(salary) as 평균연봉
	FROM Employee
	WHERE RetireDate IS NULL;



-- 2) 집계 함수와 NULL 값 예제
-- 모든 집계에서 NULL 은 제외된다. 

select * FROM Employee;

UPDATE Employee
	SET Salary = NULL
	WHERE EmpID = 'S0020';

SELECT COUNT(*) AS EmpCount
	FROM Employee
	WHERE RetireDate IS NULL --  16
;

SELECT COUNT(EmpID) AS EmpCount
	FROM Employee
	WHERE RetireDate IS NULL --  16
;
	
SELECT COUNT(Salary) AS EmpCount
	FROM Employee
	WHERE RetireDate IS NULL --  15
;


-- 근무 중인 직원들의 급여의 평균을 구하는 쿼리를 작성하고 있다. 
-- 다음 두 쿼리의 차이점을 설명하자.

SELECT SUM(Salary) / COUNT(EmpID) AS Avg_Salary
	FROM Employee
	WHERE RetireDate IS NULL --  5,681
;

SELECT SUM(Salary) / COUNT(Salary) AS Avg_Salary
	FROM Employee
	WHERE RetireDate IS NULL --  6,060
;

-- 참고 
SELECT AVG(Salary) AS Avg_Salary
	FROM Employee
	WHERE RetireDate IS NULL --  6,060
;
 

-- 3) 그룹별 집계: GROUP BY

-- 부서별 근무 중인 직원 수 구하기
SELECT DeptID, COUNT(*) AS Emp_Count
	FROM Employee
	WHERE RetireDate IS NULL
	GROUP BY DeptID
;

-- 오류
/*
SELECT DeptID, EmpName, COUNT(*) AS Emp_Count
	FROM Employee
	WHERE RetireDate IS NULL
	GROUP BY DeptID
    ORDER BY 1, 2
;
*/
SELECT DeptID, EmpName FROM Employee ORDER BY 1, 2;

-- 부서별 근무하는 직원의 급여의 합을 구하자.
SELECT DeptID, SUM(Salary) AS Tot_Salary
	FROM Employee
	WHERE RetireDate IS NULL
	GROUP BY DeptID 
;

-- 부서별 근무하는 직원의 최대값, 최소값, 최대값 - 최소값을 구하자
SELECT DeptID, MAX(Salary) AS Max_Salary, MIN(Salary) AS  Min_Salary,
			 MAX(Salary) - MIN(Salary) AS  Diff_Salary
	FROM Employee
	WHERE RetireDate IS NULL
	GROUP BY DeptID
;

--  부서별 근무하는 직원중 급여가 5000 이상인 직원의 수를구하자
SELECT DeptID, COUNT(EmpID) AS Max_Salary
	FROM Employee
	WHERE Salary > 5000
	GROUP BY DeptID;
;


-- 4) 그룹핑 결과에 대한 필터링: HAVING

SELECT DeptID, COUNT(*) AS Emp_Count
	FROM Employee
	GROUP BY DeptID
	HAVING COUNT(*) >= 3
;

-- 부서별로 현재 근무 중인 직원의 평균 급여를 얻는 쿼리를 작성하자.
SELECT DeptID, AVG(Salary) AS Avg_Salary
	FROM Employee
	WHERE RetireDate IS NULL
	GROUP BY DeptID
;

-- 위에서 얻은 부서 평균 급여가 전사 평균 급여보다 많은 부서의 평균 급여는?
SELECT DeptID, AVG(Salary) AS Avg_Salary
	FROM Employee
	WHERE RetireDate IS NULL
	GROUP BY DeptID
	HAVING AVG(Salary) > (SELECT AVG(Salary) FROM Employee WHERE RetireDate IS NULL)
;



-- 5) ROLLUP

SELECT DeptID, AVG(Salary) AS 평균연봉
FROM Employee
GROUP BY DeptID
;

SELECT Gender, AVG(Salary) AS 평균연봉
FROM Employee
GROUP BY Gender
;

SELECT Gender, DeptID, AVG(Salary) AS 평균연봉
FROM Employee
WHERE RetireDate IS NULL
GROUP BY Gender, DeptID
ORDER BY Gender, DeptID
;

SELECT Gender, DeptID, AVG(Salary) AS 평균연봉,
	GROUPING(DeptID), 
    GROUPING(Gender)
FROM Employee
WHERE RetireDate IS NULL
GROUP BY ROLLUP (Gender, DeptID)
ORDER BY Gender, DeptID
;

SELECT Gender, DeptID, AVG(Salary) AS 평균연봉,
	GROUPING(DeptID), 
    GROUPING(Gender)
FROM Employee
WHERE RetireDate IS NULL
GROUP BY CUBE (Gender, DeptID)
ORDER BY Gender, DeptID
;

SELECT DeptID, Gender, AVG(Salary) AS 평균연봉
FROM Employee
WHERE RetireDate IS NULL
GROUP BY CUBE (Gender, DeptID)
ORDER BY DeptID, Gender
;

-- 
--  B. 순위 구하기
-- 


-- 1) 순위 표시: RANK
-- 전체 순위

SELECT EmpID, EmpName, Gender, Salary, rank() over (order by Salary)  순위
FROM Employee e
WHERE DeptID IN ('SYS', 'MKT') AND RetireDate IS NULL;

-- 영역별 순위
SELECT EmpID, EmpName, Gender, Salary, 
	RANK() OVER(PARTITION BY Gender ORDER BY Salary DESC) AS Rnk
   FROM Employee
   WHERE DeptID IN ('SYS', 'MKT') AND RetireDate IS NULL
;




-- 2) 순위 표시: DENSE_RANK


-- 전체 순위
SELECT EmpID, EmpName, Gender, Salary,  DENSE_RANK() OVER(ORDER BY Salary DESC) AS Rnk
   FROM Employee
   WHERE DeptID IN ('SYS', 'MKT') AND RetireDate IS NULL
;

-- 영역별 순위
SELECT EmpID, EmpName, Gender, Salary, 
	DENSE_RANK() OVER(PARTITION BY Gender ORDER BY Salary DESC) AS Rnk
   FROM Employee
   WHERE DeptID IN ('SYS', 'MKT') AND RetireDate IS NULL
;


-- 3) 번호 표시: ROW_NUMBER

-- 전체 번호
SELECT ROW_NUMBER() OVER(ORDER BY EmpName DESC) AS Num,
			 EmpName, EmpID, Gender, Salary
	FROM Employee
	WHERE DeptID IN ('SYS', 'MKT') AND RetireDate IS NULL
;

-- 영역별 번호
SELECT ROW_NUMBER() OVER(PARTITION BY DeptID
			 ORDER BY EmpName DESC) AS Num,
			 DeptID, EmpName, Empid, Gender, Salary
	FROM Employee
	WHERE DeptID IN ('SYS', 'MKT') AND RetireDate IS NULL
;


-- 4) 범위 표시: NTILE

-- 전체 범위
SELECT EmpID, EmpName, Gender, Salary, NTILE(3) OVER(ORDER BY Salary DESC) AS Band
	FROM Employee
	WHERE DeptID IN ('SYS', 'MKT') AND RetireDate IS NULL
;

-- 영역별 범위
SELECT EmpID, EmpName, Gender, Salary, 
			 NTILE(3) OVER(PARTITION BY Gender ORDER BY Salary DESC) AS Band
	FROM Employee
	WHERE DeptID IN ('SYS', 'MKT') AND RetireDate IS NULL
;


