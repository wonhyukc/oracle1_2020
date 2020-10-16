/*
	정원혁 2020.10 for Oracle
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
   FROM Department d
   JOIN deptUnit u ON d.deptUnitID = u.deptUnitID
;

-- OUTER JOIN의 경우
SELECT d.DeptID, d.DeptName, d.deptUnitID, u.deptUnitName
   FROM Department d    LEFT  JOIN deptUnit u ON d.deptUnitID = u.deptUnitID
   -- FROM deptUnit u right JOIN Department d    ON d.deptUnitID = u.deptUnitID
;


-- FULL OUTER JOIN (잘 안쓰이는)
SELECT * FROM deptUnit;
INSERT INTO deptUnit VALUES ('D', '제0본부');

SELECT *       
   FROM Department d
   LEFT JOIN deptUnit u ON d.deptUnitID = u.deptUnitID

UNION

SELECT *       
   FROM Department d
   RIGHT JOIN deptUnit u ON d.deptUnitID = u.deptUnitID
;   

SELECT *       
   FROM Department d
   FULL OUTER JOIN deptUnit u ON d.deptUnitID = u.deptUnitID
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
