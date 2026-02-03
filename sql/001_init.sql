create database taskflow;

use taskflow;

create table users(
	id int primary key auto_increment, 
	full_name varchar(255) not null, 
    email varchar(255) not null unique, 
    password_hash varchar(255) not null, 
    created_at timestamp DEFAULT CURRENT_TIMESTAMP, 
    updated_at timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);
    
desc users;

create table workspaces(
	id int primary key,
    name varchar(255),
    owner_user_id int not null,
    created_at timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    foreign key(owner_user_id) references users(id)
);

desc workspaces;

create table workspace_members(
	workspace_id int,
    user_id int,
    role enum('owner', 'admin', 'member') not null,
    joined_at timestamp default current_timestamp,
    foreign key(workspace_id) references workspaces(id) on delete cascade,
    foreign key(user_id) references users(id) on delete cascade,
    primary key(workspace_id, user_id)
);

create index user_id_idx on users(id);

create index workspace_user_id_idx on workspaces(owner_user_id);