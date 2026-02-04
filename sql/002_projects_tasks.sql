use taskflow;

create table projects(
	id int primary key auto_increment,
    workspace_id int not null,
    name varchar(255) not null,
    created_by int not null,
    created_at timestamp default current_timestamp not null,
    updated_at timestamp default current_timestamp on update current_timestamp not null,
	foreign key(workspace_id) references workspaces(id) on delete cascade,
    foreign key(created_by) references users(id) on delete restrict,
    unique(workspace_id, name)
);

create table tasks(
	id int primary key auto_increment,
    project_id int not null,
    created_by int not null,
    assignee_id int null,
    title varchar(255) not null,
    description TEXT,
    status enum('todo','in_progress','blocked','done') default ('todo') not null,
    priority enum('low','medium','high','urgent') default ('low') not null,
    due_date datetime,
    created_at timestamp default current_timestamp not null,
    updated_at timestamp default current_timestamp on update current_timestamp not null,
    foreign key(project_id) references projects(id) on delete cascade,
    foreign key(created_by) references users(id) on delete restrict,
    foreign key(assignee_id) references users(id) on delete set null,
    INDEX idx_tasks_project_id (project_id),
	INDEX idx_tasks_assignee_id (assignee_id),
	INDEX idx_tasks_project_status (project_id, status)
);

SHOW CREATE TABLE tasks;
    

    