use hrdb;
select *
from employee
;

select *
from department
;

-- 서버.데이터베이스.테이블이름.컬럼 이름

select *
from employee join department	on employee.deptID = department.deptID;

select employee.*, DeptName
from employee join department	on employee.deptID = department.deptID;

select  EmpName, Gender, hireDate, retireDate, salary ,DeptName
from employee join department	on employee.deptID = department.deptID;

-- on 조건 없으면? 두 테이블 곱집합 생성. 
select empName, DeptName
from employee join department	-- on employee.deptID = department.deptID
order by 1,2
;


-- 별칭
select  EmpName, Gender, hireDate, retireDate, salary, DeptName as 부서명
from employee as e join department	as d  	on e.deptID = d.deptID;
