DROP DATABASE IF EXISTS memberdb;
CREATE DATABASE memberdb CHARACTER SET UTF8 ;
USE memberdb ;
CREATE TABLE member(
   mid                  varchar(50) not null,
   name                 varchar(30),
   password             varchar(32),
   locked               int,
   CONSTRAINT pk_mid PRIMARY KEY (mid)
) engine='innodb';
CREATE TABLE role(
	rid					varchar(50) ,
	title				varchar(200) ,
	CONSTRAINT pk_rid PRIMARY KEY(rid)
) engine='innodb' ;
CREATE TABLE action(
	actid					varchar(50) ,
	title				varchar(200) ,
	rid					varchar(50) ,
	CONSTRAINT pk_actid PRIMARY KEY(actid) ,
	CONSTRAINT fk_rid1 FOREIGN KEY(rid) REFERENCES role(rid)
) engine='innodb' ;
CREATE TABLE member_role(
	mid				varchar(50) ,
	rid				varchar(50) ,
	CONSTRAINT fk_mid2 FOREIGN KEY(mid) REFERENCES member(mid),
	CONSTRAINT fk_rid2 FOREIGN KEY(rid) REFERENCES role(rid)
) engine='innodb' ;
-- 0表示活跃、1表示锁定
INSERT INTO member(mid,name,password,locked) VALUES ('admin','管理员','EAB62A7769F0313F8D69CEBA32F4347E',0) ;
INSERT INTO member(mid,name,password,locked) VALUES ('mldn','普通人','D6DBB9093F83091B1EB3109197659FDE',0) ;
INSERT INTO member(mid,name,password,locked) VALUES ('mermaid','美人鱼','EAB62A7769F0313F8D69CEBA32F4347E',1) ;
-- 定义角色信息
INSERT INTO role(rid,title) VALUES ('member','用户管理') ;
INSERT INTO role(rid,title) VALUES ('dept','部门管理') ;
INSERT INTO role(rid,title) VALUES ('news','新闻管理') ;
-- 定义权限信息
INSERT INTO action(actid,title,rid) VALUES ('member:add','用户追加','member') ;
INSERT INTO action(actid,title,rid) VALUES ('member:list','用户列表','member') ;
INSERT INTO action(actid,title,rid) VALUES ('member:edit','用户编辑','member') ;
INSERT INTO action(actid,title,rid) VALUES ('member:remove','用户删除','member') ;
INSERT INTO action(actid,title,rid) VALUES ('dept:list','部门列表','dept') ;
INSERT INTO action(actid,title,rid) VALUES ('dept:edit','部门编辑','dept') ;
INSERT INTO action(actid,title,rid) VALUES ('news:add','新闻追加','news') ;
INSERT INTO action(actid,title,rid) VALUES ('news:edit','新闻修改','news') ;
INSERT INTO action(actid,title,rid) VALUES ('news:audit','新闻审核','news') ;
INSERT INTO action(actid,title,rid) VALUES ('news:list','新闻列表','news') ;
-- 定义用户与角色的关系
INSERT INTO member_role(mid,rid) VALUES ('admin','member') ;
INSERT INTO member_role(mid,rid) VALUES ('admin','dept') ;
INSERT INTO member_role(mid,rid) VALUES ('admin','news') ;
INSERT INTO member_role(mid,rid) VALUES ('mldn','news') ;
INSERT INTO member_role(mid,rid) VALUES ('mermaid','dept') ;