/*
	정원혁 2020.10 for Oracle
*/
-- JOIN / 하위질의 subquery / 상관하위질의 correlated subquery / EXIST

select * from department;
select * from deptUnit;
-- INSERT department VALUES ( 'x', 'xxx', 'x', '2020-01-01');

ALTER TABLE department
	DROP FOREIGN KEY fk_dept_deptUnit;
DESC department;

INSERT department VALUES ( 'x', 'xxx', 'x', '2020-01-01');
select * from department;

INSERT deptUnit VALUES ( 'y', 'y본부');
select * from deptUnit;


-- JOIN
select * 
from deptUnit u JOIN department d ON u.deptUnitID = d.deptUnitID
;
select * 
from deptUnit u LEFT JOIN department d ON u.deptUnitID = d.deptUnitID
;
select * 
from deptUnit u RIGHT JOIN department d ON u.deptUnitID = d.deptUnitID
;


-- JOIN: deptUnit에 존재하는 모든 부서
select d.* 
from department d JOIN deptUnit u ON u.deptUnitID = d.deptUnitID
;

-- 일반 하위 쿼리
select d.* 
from department d 
where deptUnitID in (
		select deptUnitID	from deptUnit
	)
;


-- 상관 하위 쿼리
select d.* 
from department d 
where deptUnitID in (
		select deptUnitID	from deptUnit where deptUnitID = d.deptUnitID
	)
;

-- EXISTS 상관 하위 쿼리
select d.* 
from department d 
where EXISTS (
		select * from deptUnit where deptUnitID = d.deptUnitID
	)
;
