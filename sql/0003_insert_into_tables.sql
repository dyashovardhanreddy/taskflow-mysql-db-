use taskflow;

insert into users(full_name, email, password_hash) values('Alice Johnson','alice@taskflow.com','password123');
insert into users(full_name, email, password_hash) values('Bob Smith','bob@taskflow.com','password123');
insert into users(full_name, email, password_hash) values('Charlie Lee','charlie@taskflow.com','password123');
insert into users(full_name, email, password_hash) values('Diana Patel','diana@taskflow.com','password123');
insert into users(full_name, email, password_hash) values('Ethan Brown','ethan@taskflow.com','password123');

select * from users;

desc workspaces;

insert into workspaces(name,owner_user_id) values('Engineering Team', 1);
insert into workspaces(name,owner_user_id) values('Product Team', 2);

desc workspace_members;

insert into workspace_members(workspace_id,user_id,role) values(1, 1, 'owner');
insert into workspace_members(workspace_id,user_id,role) values(1, 2, 'admin');
insert into workspace_members(workspace_id,user_id,role) values(1, 3, 'member');
insert into workspace_members(workspace_id,user_id,role) values(1, 4, 'member');
insert into workspace_members(workspace_id,user_id,role) values(2, 2, 'owner');
insert into workspace_members(workspace_id,user_id,role) values(2, 3, 'admin');
insert into workspace_members(workspace_id,user_id,role) values(2, 5, 'member');

desc projects;

insert into projects(workspace_id, name, created_by) values(1, 'Backend Revamp', 1);
insert into projects(workspace_id, name, created_by) values(1, 'API Performance', 2);
insert into projects(workspace_id, name, created_by) values(2, 'Mobile App Launch', 2);
insert into projects(workspace_id, name, created_by) values(2, 'User Feedback System', 3);

select * from projects;

desc tasks;

insert into tasks(project_id,created_by,title,status,priority,assignee_id, due_date) values(1,1,'Design DB schema','done','high', 1,'2024-12-10 09:00:00');
insert into tasks(project_id,created_by,title,status,priority,assignee_id, due_date) values(1,1,'Implement auth service','in_progress','urgent', 2,'2026-2-20 09:00:00');
insert into tasks(project_id,created_by,title,status,priority,assignee_id, due_date) values(1,1,'Write migration scripts','todo','medium', NULL,'2026-2-20 09:00:00');
insert into tasks(project_id,created_by,title,status,priority,assignee_id, due_date) values(1,1,'Setup CI pipeline','blocked','medium', 3,'2025-12-10 09:00:00');

insert into tasks(project_id,created_by,title,status,priority,assignee_id, due_date) values(3,2,'Profile slow endpoints','done','high', 2,'2024-12-10 09:00:00');
insert into tasks(project_id,created_by,title,status,priority,assignee_id, due_date) values(3,2,'Add Caching Layer','in_progress','high', 4,'2026-2-20 09:00:00');
insert into tasks(project_id,created_by,title,status,priority,assignee_id, due_date) values(3,3,'Optimize DB queries','todo','urgent', NULL,'2026-2-20 09:00:00');
insert into tasks(project_id,created_by,title,status,priority,assignee_id, due_date) values(3,4,'Load Testing','todo','medium', 3, NULL);

insert into tasks(project_id,created_by,title,status,priority,assignee_id, due_date) values(4,2,'Design onboarding flow','done','medium', 5,'2024-12-10 09:00:00');
insert into tasks(project_id,created_by,title,status,priority,assignee_id, due_date) values(4,3,'Implement push alerts','in_progress','high', 2,'2026-2-20 09:00:00');
insert into tasks(project_id,created_by,title,status,priority,assignee_id, due_date) values(4,5,'App store checklist','todo','low', NULL,'2026-2-20 09:00:00');
insert into tasks(project_id,created_by,title,status,priority,assignee_id, due_date) values(4,2,'QA testing','blocked','high', 3,'2025-12-10 09:00:00');

insert into tasks(project_id,created_by,title,status,priority,assignee_id, due_date) values(5,3,'Design feedback schema','done','medium', 1,'2024-12-10 09:00:00');
insert into tasks(project_id,created_by,title,status,priority,assignee_id, due_date) values(5,2,'Build feedback API','in_progress','high', 4,'2026-2-20 09:00:00');
insert into tasks(project_id,created_by,title,status,priority,assignee_id, due_date) values(5,2,'Analytics dashboard','todo','medium', NULL,'2026-2-20 09:00:00');
insert into tasks(project_id,created_by,title,status,priority,assignee_id, due_date) values(5,5,'Notification rules','todo','low', 5,'2026-03-10 09:00:00');

select * from tasks;