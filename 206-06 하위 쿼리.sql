/*
	정원혁 2020.10 for Oracle
	정원혁 2014.11. 
	이장래 저 "SQL Server 2012 운영과 개발 : 이장래와 함께하는" 의 스크립트를 migration
	http://www.yes24.com/SearchCorner/Search?scode=032&ozsrank=1&author_yn=y&query=%c0%cc%c0%e5%b7%a1&domain=all
*/
-- 
--  6.6 하위 쿼리 subquery
-- 


-- 1) 일반 하위 쿼리

-- 가장 많은 급여를 받는 직원 정보
USE HRDB
;

SELECT MAX(Salary) FROM Employee;	
-- 8500

SELECT EmpID, EmpName, Salary
   FROM Employee
   WHERE Salary = 8500;

SELECT EmpID, EmpName, Salary
   FROM Employee
   WHERE Salary = (SELECT MAX(Salary) FROM Employee)
;

-- 휴가를 간 적이 있는 직원 정보: JOIN
select e.* from vacation v
	join employee e on e.empid =  v.empid
;

select DISTINCT e.* from vacation v
	join employee e on e.empid =  v.empid
;

-- 하위 질의
SELECT EmpID FROM Vacation;
SELECT EmpID, EmpName, DeptID, EMail
   FROM Employee
   WHERE EmpID IN (
'S0019', 
'S0016', 
'S0014', 
'S0012', 
'S0011', 
'S0009', 
'S0003', 
'S0001', 
'S0001', 
'S0001')
;

SELECT EmpID, EmpName, DeptID, EMail
   FROM Employee
   WHERE EmpID IN (SELECT EmpID FROM Vacation)
;


-- 2) 상관 하위 쿼리

-- 부서 이름 가져오기
SELECT EmpID, EmpName, DeptID, Salary
    , (SELECT DeptName FROM Department 	  WHERE DeptID = e.DeptID) AS DeptName
   FROM Employee e
   WHERE Salary > 7000
;


-- 3) EXISTS

-- 휴가를 간 적이 있는 직원 정보
SELECT EmpID, EmpName, EMail
   FROM Employee e
   WHERE EXISTS(SELECT * 
                   FROM Vacation 
                   WHERE EmpID = e.EmpID);


-- 휴가를 간 적이 없는 직원 정보
SELECT EmpID, EmpName, EMail 
   FROM Employee e
   WHERE NOT EXISTS(SELECT * 
                      FROM Vacation 
                      WHERE EmpID = e.EmpID)
;