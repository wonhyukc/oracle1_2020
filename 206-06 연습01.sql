--p.NAME 프로젝트명, m.name 마일스톤명, p.OWNER 프로젝트오너, m.owner 마일스톤오너, m.STATUS 
select p.NAME 프로젝트명, m.name 마일스톤명, p.OWNER 프로젝트오너, m.owner 마일스톤오너, m.STATUS 
from projects p 
    JOIN milestones m ON p.id = PROJECT_ID

--마일스톤이 없는 프로젝트 : outer join 
select p.NAME 프로젝트명, m.name 마일스톤명, p.OWNER 프로젝트오너, m.owner 마일스톤오너, m.STATUS 
from projects p 
    left JOIN milestones m ON p.id = m.PROJECT_ID
where m.PROJECT_ID is null;


--마일스톤이 없는 프로젝트 : in / exists

select p.NAME 프로젝트명, p.OWNER 프로젝트오너
from projects p
where NOT exists (select * from milestones m2 where m2.project_id = p.id)



--NAME, OWNER, milestones.STATUS URL

select p.NAME 프로젝트명, m.name 마일스톤명, p.OWNER 프로젝트오너, m.owner 마일스톤오너, m.STATUS, URL
from projects p 
    JOIN milestones m ON p.id = m.project_id
    JOIN links l ON p.id = l.project_id
    


-- action_items.STATUS, 
select p.NAME 프로젝트명, m.name 마일스톤명, p.OWNER 프로젝트오너, m.owner 마일스톤오너, m.STATUS, URL, a.STATUS
from projects p 
    JOIN milestones m ON p.id = m.project_id
    JOIN links l ON p.id = l.project_id
    JOIN action_items a ON p.id = a.project_id
