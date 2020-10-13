/*
	정원혁 2014.11. 
	이장래 저 "SQL Server 2012 운영과 개발 : 이장래와 함께하는" 의 스크립트를 migration
	http://www.yes24.com/SearchCorner/Search?scode=032&ozsrank=1&author_yn=y&query=%c0%cc%c0%e5%b7%a1&domain=all
*/
-- 
--  6.5 조인(JOIN)
-- 


USE HRDB
;


-- 1) INNER JOIN
SELECT e.EmpID, e.EmpName, e.DeptID, d.DeptName
   FROM Employee e
   INNER JOIN Department d ON e.DeptID = d.DeptID
;

-- 부서 이름을 포함해서 직원 정보 표시
SELECT e.EmpID, e.EmpName, e.DeptID, d.DeptName
   FROM Employee e
   INNER JOIN Department d ON e.DeptID = d.DeptID
   WHERE e.DeptID IN ('GEN', 'HRD', 'ACC') 
		AND RetireDate IS NULL
;


-- 2) OUTER JOIN

-- INNER JOIN의 경우
SELECT d.DeptID, d.DeptName, d.deptUnitID, u.deptUnitName
   FROM Department AS d
   JOIN deptUnit AS u ON d.deptUnitID = u.deptUnitID
;

-- OUTER JOIN의 경우
SELECT d.DeptID, d.DeptName, d.deptUnitID, u.deptUnitName
   FROM Department AS d    LEFT  JOIN deptUnit AS u ON d.deptUnitID = u.deptUnitID
   -- FROM deptUnit AS u right JOIN Department AS d    ON d.deptUnitID = u.deptUnitID
;


-- 3) 여러 테이블간의 조인
ALTER TABLE Vacation ADD Duration INT GENERATED ALWAYS AS (DATEDIFF(EndDate, BeginDate)+1);

-- 휴가를 사용한 직원들의 휴가 사용 현황 얻기
SELECT *       
   FROM Employee e
   INNER JOIN Vacation v ON e.EmpID = v.EmpID
   ORDER BY e.EmpID ASC
;

SELECT *       
   FROM Employee e
   left JOIN Vacation v ON e.EmpID = v.EmpID
   ORDER BY e.EmpID ASC
;

-- 휴가를 사용한 직원들의 휴가 사용 현황 얻기
SELECT e.EmpID, e.EmpName, d.DeptName, u.deptUnitName, 
       v.BeginDate, v.EndDate, v.Duration
   FROM Employee e
   INNER JOIN Department d ON e.DeptID = d.DeptID
   LEFT OUTER JOIN deptUnit u ON d.deptUnitID = u.deptUnitID
   INNER JOIN Vacation v ON e.EmpID = v.EmpID
   ORDER BY e.EmpID ASC
;

-- 모든 직원들의 휴가 사용 현황 얻기
SELECT e.EmpID, e.EmpName, d.DeptName, u.deptUnitName, 
       v.BeginDate, v.EndDate, v.Duration
   FROM Employee e
   INNER JOIN Department d ON e.DeptID = d.DeptID
   LEFT OUTER JOIN deptUnit u ON d.deptUnitID = u.deptUnitID
   LEFT OUTER JOIN Vacation v ON e.EmpID = v.EmpID
   ORDER BY e.EmpID ASC
;

-- FULL OUTER JOIN (잘 안쓰이는)
SELECT * FROM deptUnit;
INSERT deptUnit VALUES ('D', '제0본부');

SELECT *       
   FROM Department d
   LEFT JOIN deptUnit u ON d.deptUnitID = u.deptUnitID

UNION

SELECT *       
   FROM Department d
   RIGHT JOIN deptUnit u ON d.deptUnitID = u.deptUnitID
;   
-- 4) Non-Equi 조인 (머리아프면 나중에 공부)

-- 'S0004', 'S0005' 직원보다 더 많은 급여를 받는 직원의 정보와 급여 차

SELECT e1.EmpID, e1.EmpName, e1.Salary, e2.EmpName, 
       e2.Salary, e2.Salary - e1.Salary AS 'Salary_diff'
   FROM Employee e1
   JOIN Employee e2 ON e1.Salary < e2.Salary
   WHERE e1.EmpID <> e2.EmpID AND e1.EmpID  IN ('S0004', 'S0005')
   ORDER BY e1.EmpID ASC, Salary_diff DESC
;


-- 휴가를 안간 직원
select e.* from vacation v
	right join employee e on e.empid =  v.empid
where vacationid is null
;

-- deptUnit 배정이 안된 부서
select d.* 
from department d
	left join deptUnit u on u.deptUnitid = d.deptUnitid
where u.deptUnitid is null
    ;