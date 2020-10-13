/*
	정원혁 2014.11. 
	이장래 저 "SQL Server 2012 운영과 개발 : 이장래와 함께하는" 의 스크립트를 migration
	http://www.yes24.com/SearchCorner/Search?scode=032&ozsrank=1&author_yn=y&query=%c0%cc%c0%e5%b7%a1&domain=all
*/
-- 
--  6.7 결과 집합 병합하기
-- 


-- 1) UNION

USE HRDB
;

-- 2008년 입사한 직원
SELECT EmpID, EmpName, DeptID, HireDate, EMail, Salary
	FROM Employee
	WHERE HireDate BETWEEN TO_DATE('2008-01-01', 'YYYY-MM-DD') AND TO_DATE('2008-12-31', 'YYYY-MM-DD') 
;

-- 급여를 7,000 이상 받는 직원
SELECT EmpID, EmpName, DeptID, HireDate, EMail, Salary
	FROM Employee
	WHERE Salary >= 7000
;

-- 2008년에 입사 했거나 급여를 7,000 이상 받는 직원
-- UNION(중복 행 한번만 표시)
SELECT EmpID, EmpName, DeptID, HireDate, EMail, Salary
	FROM Employee
	WHERE HireDate BETWEEN TO_DATE('2008-01-01', 'YYYY-MM-DD') AND TO_DATE('2008-12-31', 'YYYY-MM-DD') 

UNION

SELECT EmpID, EmpName, DeptID, HireDate, EMail, Salary
	FROM Employee
	WHERE Salary >= 7000
;

-- UNION(중복 모두 표시)
SELECT EmpID, EmpName, DeptID, HireDate, EMail, Salary
	FROM Employee
	WHERE HireDate BETWEEN TO_DATE('2008-01-01', 'YYYY-MM-DD') AND TO_DATE('2008-12-31', 'YYYY-MM-DD') 

UNION ALL

SELECT EmpID, EmpName, DeptID, HireDate, EMail, Salary
	FROM Employee
	WHERE Salary >= 7000
;


-- 2) INTERSECT

-- 2008년에 입사했으며 급여를 7,000 이상 받는 직원
SELECT 
    EmpID, EmpName, DeptID, HireDate, EMail, Salary
FROM
    Employee
WHERE
    HireDate BETWEEN TO_DATE('2008-01-01', 'YYYY-MM-DD') AND TO_DATE('2008-12-31', 'YYYY-MM-DD')
        AND Salary >= 7000
;


-- 3) EXCEPT

-- 2008년에 입사했지만 급여을 7,000 이상 받으면 제외
SELECT EmpID, EmpName, DeptID, HireDate, EMail, Salary
	FROM Employee
	WHERE HireDate BETWEEN TO_DATE('2008-01-01', 'YYYY-MM-DD') AND TO_DATE('2008-12-31', 'YYYY-MM-DD') 
    AND EmpID NOT IN (
		SELECT EmpID
		FROM Employee
		WHERE Salary >= 7000
	)
;

SELECT EmpID, EmpName, DeptID, HireDate, EMail, Salary
	FROM Employee e
	WHERE HireDate BETWEEN TO_DATE('2008-01-01', 'YYYY-MM-DD') AND TO_DATE('2008-12-31', 'YYYY-MM-DD') 
    AND NOT EXISTS (
		SELECT EmpID
		FROM Employee
		WHERE Salary >= 7000
			AND empId = e.empID
	)
;