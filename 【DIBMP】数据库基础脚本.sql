-- 根据自己的实际情况进行有效的分库设计（有效与没效用过才知道）
-- 本次设计的数据库脚本只是在单数据库节点上的执行处理，设计的约束只有主键

DROP DATABASE mldn ;
CREATE DATABASE mldn CHARACTER SET UTF8 ;
USE mldn ;
-- 创建部门信息表，所拥有的权限与部门信息有关
CREATE TABLE dept (
   did                  bigint	AUTO_INCREMENT ,
   dname                varchar(50),
   mid			varchar(50),
   maxnum		int ,
   currnum		int ,
   CONSTRAINT pk_did1 primary key (did)
) engine='innodb';

-- 创建职位信息表，用于确定等级
CREATE TABLE level (
   lid                  int ,
   title                varchar(50),
   losal				double ,
   hisal				double ,
   CONSTRAINT pk_lid2 PRIMARY KEY (lid)
) engine='innodb';

-- 创建雇员信息（用户）表
CREATE TABLE member (
   mid                  varchar(50) not null,
   lid                  int,
   did                  bigint,
   name                varchar(50),
   salary		double ,
   phone                varchar(20),
   password             varchar(32),
   photo                varchar(200),
   note                 text,
   hiredate             date,
   inmid                varchar(50) ,
   locked		int default 0 ,
   CONSTRAINT pk_mid3 PRIMARY KEY (mid)
) engine='innodb';

-- 创建角色信息表
CREATE TABLE role (
   rid                  varchar(50) ,
   title                varchar(50),
   CONSTRAINT pk_rid4 PRIMARY KEY (rid)
) engine='innodb';

-- 创建权限信息表
CREATE TABLE action (
   actid                varchar(50),
   rid                  varchar(50),
   title                varchar(50),
   CONSTRAINT pk_actid5 PRIMARY KEY (actid) 
) engine='innodb';

-- 创建职务角色关系表
CREATE TABLE dept_role(
   did                  bigint,
   rid                  varchar(50)
) engine='innodb';

-- 仓储分类表
CREATE TABLE witem (
   wiid                  bigint  AUTO_INCREMENT ,
   title                varchar(50),
   CONSTRAINT pk_wiid PRIMARY KEY (wiid)
) engine='innodb';

-- 创建省份表
CREATE TABLE province (
   pid                  bigint AUTO_INCREMENT ,
   title                varchar(50) ,
   CONSTRAINT pk_pid PRIMARY KEY (pid)
) engine=innodb;

-- 创建城市表
CREATE TABLE city (
   cid                  bigint AUTO_INCREMENT ,
   pid                  bigint,
   title                varchar(50) ,
   CONSTRAINT pk_cid primary key (cid) 
) engine=innodb;

-- 仓库信息表
CREATE TABLE warehouse (
   wid			bigint AUTO_INCREMENT ,
   name			varchar(50) ,
   pid			bigint ,
   cid			bigint ,
   wiid			bigint ,
   address		varchar(50) ,
   area			double ,
   maximum		int ,
   currnum		int ,
   photo		varchar(200) ,
   note			text ,
   recorder		varchar(50) ,
   admin		varchar(50) ,
   CONSTRAINT pk_wid PRIMARY KEY(wid)
) engine=innodb ;


-- 商品子分类
CREATE TABLE subtype (
	stid	bigint	AUTO_INCREMENT ,
	title	varchar(50) ,
	wiid	bigint ,
	CONSTRAINT pk_stid PRIMARY KEY(stid)
) engine=innodb ;

-- 商品信息表
CREATE TABLE goods(
	gid		bigint auto_increment ,	
	name		bigint ,
	wiid		bigint ,
	stid		bigint ,
	price		double ,
	weight		double ,
	photo		varchar(200) ,
	note		text ,
	lastin		datetime ,
	stornum		int ,
	recorder	varchar(50) ,
	delflag		int ,
	CONSTRAINT pk_gid PRIMARY KEY(gid)
) engine=innodb ;

-- 定义客户等级表
CREATE TABLE citem (
	ciid	bigint auto_increment ,
	title	varchar(50) ,
	CONSTRAINT pk_ciid PRIMARY KEY(ciid)
) engine=innodb ;

-- 定义客户来源信息
CREATE TABLE csource(
	csid	bigint auto_increment ,
	title	varchar(50) ,
	CONSTRAINT pk_csid PRIMARY KEY(csid)
) engine=innodb ;


-- 定义客户联系类型表
CREATE TABLE critem (
	criid	bigint auto_increment ,
	title	varchar(50) ,
	constraint pk_crid primary key(criid)
) ;

-- 定义客户信息表
CREATE TABLE customer(
	cuid	bigint auto_increment ,
	name	varchar(50) ,
	phone	varchar(50) ,
	pid	bigint ,
	cid	bigint ,
	address	varchar(200) ,
	indate	datetime ,
	connum	int ,
	ciid	bigint ,
	csid	bigint ,
	note	text ,
	recorder	varchar(50) ,
	CONSTRAINT pk_cuid PRIMARY KEY(cuid)
) engine=innodb ;

-- 定义客户联系记录表
CREATE TABLE customer_record(
	crid	bigint	auto_increment ,
	cmid	varchar(50) ,
	cdate	datetime ,
	criid	bigint ,
	note	text ,
	constraint pk_crid primary key(crid)
)  engine=innodb ;	

-- 定义商品入库申请单
CREATE TABLE storage_apply (
	said	bigint	auto_increment ,
	title	varchar(50) ,
	pid	bigint ,
	cid	bigint ,
	wiid	bigint ,
	wid	bigint ,
	note	text ,
	status	int ,
	appmid	varchar(50) ,
	CONSTRAINT pk_said PRIMARY KEY(said)
) engine=innodb ;

-- 定义入库申请单详情
CREATE TABLE storage_apply_details (
	sadid	bigint	auto_increment ,
	gid	bigint	,
	name	varchar(50) ,
	num	int ,
	price	double ,
	weight	double ,
	constraint pk_sadid PRIMARY KEY(sadid)
) engine=innodb ;

-- 定义入库记录信息
CREATE TABLE storage_record(
	srid	bigint	auto_increment ,
	said	bigint ,
	gid	bigint	,
	name	varchar(50) ,
	num	int ,
	price	double ,
	weight	double ,
	status	int ,
	inmid	varchar(50) ,
	constraint pk_srid PRIMARY KEY(srid)
) engine=innodb ;

-- 定义出库申请（出库商品保存在redis）
CREATE TABLE distribution (
	dsid	bigint	auto_increment ,
	title	varchar(50) ,
	pid	bigint ,
	cid	bigint ,
	gnum	int ,
	price	double ,
	status	int ,
	note	text ,
	constraint pk_dsid primary key(dsid)
) engine=innodb ;

-- 定义出库申请详情
CREATE TABLE distribution_details (
	dsdid	bigint	auto_increment ,
	gid	bigint ,
	name	varchar(50) ,
	num	int ,
	price	double ,
	status	int ,
	wid	bigint ,
	outmid	varchar(50) ,
	CONSTRAINT pk_dsdid PRIMARY KEY(dsdid)
) engine=innodb ;

INSERT INTO province (title) VALUES 
 ('其他'), ('北京'), ('重庆'), ('福建'), ('甘肃'), ('广东'),
 ('广西'), ('贵州'), ('海南'), ('河北'), ('黑龙江'), ('河南'),
 ('香港'), ('湖北'), ('湖南'), ('江苏'), ('江西'), ('吉林'),
 ('辽宁'), ('澳门'), ('内蒙古'), ('宁夏'), ('青海'), ('山东'),
 ('上海'), ('山西'), ('陕西'), ('四川'), ('台湾'), ('天津'),
 ('新疆'), ('西藏'), ('云南'), ('浙江'), ('安徽');

INSERT INTO city (pid,title) VALUES 
 (1,'其他'),(35,'合肥'), (35,'安庆'), (35,'蚌埠'), (35,'亳州'), (35,'巢湖'), (35,'滁州'),
 (35,'阜阳'), (35,'贵池'), (35,'淮北'), (35,'淮化'), (35,'淮南'), (35,'黄山'),
 (35,'九华山'), (35,'六安'), (35,'马鞍山'), (35,'宿州'), (35,'铜陵'), (35,'屯溪'),
 (35,'芜湖'), (35,'宣城'), (2,'北京'), (3,'重庆'), (4,'福州'), (4,'福安'),
 (4,'龙岩'), (4,'南平'), (4,'宁德'), (4,'莆田'), (4,'泉州'), (4,'三明'),
 (4,'邵武'), (4,'石狮'), (4,'永安'), (4,'武夷山'), (4,'厦门'), (4,'漳州'),
 (5,'兰州'), (5,'白银'), (5,'定西'), (5,'敦煌'), (5,'甘南'), (5,'金昌');

INSERT INTO city (pid,title) VALUES 
 (5,'酒泉'), (5,'临夏'), (5,'平凉'), (5,'天水'), (5,'武都'), (5,'武威'),
 (5,'西峰'), (5,'张掖'), (6,'广州'), (6,'潮阳'), (6,'潮州'), (6,'澄海'),
 (6,'东莞'), (6,'佛山'), (6,'河源'), (6,'惠州'), (6,'江门'), (6,'揭阳'),
 (6,'开平'), (6,'茂名'), (6,'梅州'), (6,'清远'), (6,'汕头'), (6,'汕尾'),
 (6,'韶关'), (6,'深圳'), (6,'顺德'), (6,'阳江'), (6,'英德'), (6,'云浮'),
 (6,'增城'), (6,'湛江'), (6,'肇庆'), (6,'中山'), (6,'珠海'), (7,'南宁');

INSERT INTO city (pid,title) VALUES 
 (7,'百色'), (7,'北海'), (7,'桂林'), (7,'防城港'), (7,'河池'), (7,'贺州'),
 (7,'柳州'), (7,'钦州'), (7,'梧州'), (7,'玉林'), (8,'贵阳'), (8,'安顺'),
 (8,'毕节'), (8,'都匀'), (8,'凯里'), (8,'六盘水'), (8,'铜仁'), (8,'兴义'),
 (8,'玉屏'), (8,'遵义'), (9,'海口'), (9,'儋县'), (9,'陵水'), (9,'琼海'),
 (9,'三亚'), (9,'五指山'), (9,'万宁'), (10,'石家庄'), (10,'保定'), (10,'北戴河'),
 (10,'沧州'), (10,'承德'), (10,'丰润'), (10,'邯郸'), (10,'衡水'), (10,'廊坊');

INSERT INTO city (pid,title) VALUES 
 (10,'南戴河'), (10,'秦皇岛'), (10,'唐山'), (10,'新城'), (10,'邢台'), (10,'张家口'),
 (11,'哈尔滨'), (11,'北安'), (11,'大庆'), (11,'大兴安岭'), (11,'鹤岗'), (11,'黑河'),
 (11,'佳木斯'), (11,'鸡西'), (11,'牡丹江'), (11,'齐齐哈尔'), (11,'七台河'), (11,'双鸭山'),
 (11,'绥化'), (11,'伊春'), (12,'郑州'), (12,'安阳'), (12,'鹤壁'), (12,'潢川'),
 (12,'焦作'), (12,'济源'), (12,'开封'), (12,'漯河'), (12,'洛阳'), (12,'南阳'), (12,'平顶山'),
 (12,'濮阳'), (12,'三门峡'), (12,'商丘'), (12,'新乡');

INSERT INTO city (pid,title) VALUES 
 (12,'信阳'), (12,'许昌'), (12,'周口'), (12,'驻马店'), (13,'香港'), (13,'九龙'),
 (13,'新界'), (14,'武汉'), (14,'恩施'), (14,'鄂州'), (14,'黄冈'), (14,'黄石'),
 (14,'荆门'), (14,'荆州'), (14,'潜江'), (14,'十堰'), (14,'随州'), (14,'武穴'), (14,'仙桃'),
 (14,'咸宁'), (14,'襄阳'), (14,'襄樊'), (14,'孝感'), (14,'宜昌'), (15,'长沙'), (15,'常德'),
 (15,'郴州'), (15,'衡阳'), (15,'怀化'), (15,'吉首'), (15,'娄底'), (15,'邵阳'), (15,'湘潭'),
 (15,'益阳'), (15,'岳阳'), (15,'永州');

INSERT INTO city (pid,title) VALUES 
 (15,'张家界'), (15,'株洲'), (16,'南京'), (16,'常熟'), (16,'常州'), (16,'海门'),
 (16,'淮安'), (16,'江都'), (16,'江阴'), (16,'昆山'), (16,'连云港'), (16,'南通'),
 (16,'启东'), (16,'沭阳'), (16,'宿迁'), (16,'苏州'), (16,'太仓'), (16,'泰州'),
 (16,'同里'), (16,'无锡'), (16,'徐州'), (16,'盐城'), (16,'扬州'), (16,'宜兴'),
 (16,'仪征'), (16,'张家港'), (16,'镇江'), (16,'周庄'), (17,'南昌'), (17,'抚州'),
 (17,'赣州'), (17,'吉安'), (17,'景德镇'), (17,'井冈山'), (17,'九江'), (17,'庐山');

INSERT INTO city (pid,title) VALUES 
 (17,'萍乡'), (17,'上饶'), (17,'新余'), (17,'宜春'), (17,'鹰潭'), (18,'长春'),
 (18,'白城'), (18,'白山'), (18,'珲春'), (18,'辽源'), (18,'梅河'), (18,'吉林'),
 (18,'四平'), (18,'松原'), (18,'通化'), (18,'延吉'), (19,'沈阳'), (19,'鞍山'),
 (19,'本溪'), (19,'朝阳'), (19,'大连'), (19,'丹东'), (19,'抚顺'), (19,'阜新'),
 (19,'葫芦岛'), (19,'锦州'), (19,'辽阳'), (19,'盘锦'), (19,'铁岭'), (19,'营口'),
 (20,'澳门'), (21,'呼和浩特'), (21,'阿拉善盟'), (21,'包头'), (21,'赤峰'), (21,'东胜');

INSERT INTO city (pid,title) VALUES 
 (21,'海拉尔'), (21,'集宁'), (21,'临河'), (21,'通辽'), (21,'乌海'), (21,'乌兰浩特'),
 (21,'锡林浩特'), (22,'银川'), (22,'固原'), (22,'石嘴山'), (22,'吴忠'), (23,'西宁'),
 (23,'德令哈'), (23,'格尔木'), (23,'共和'), (23,'海东'), (23,'海晏'), (23,'玛沁'),
 (23,'同仁'), (23,'玉树'), (24,'济南'), (24,'滨州'), (24,'兖州'), (24,'德州'),
 (24,'东营'), (24,'菏泽'), (24,'济宁'), (24,'莱芜'), (24,'聊城'), (24,'临沂'),
 (24,'蓬莱'), (24,'青岛'), (24,'曲阜'), (24,'日照'), (24,'泰安');

INSERT INTO city (pid,title) VALUES 
 (24,'潍坊'), (24,'威海'), (24,'烟台'), (24,'枣庄'), (24,'淄博'), (25,'上海'),
 (25,'崇明'), (25,'朱家角'), (26,'太原'), (26,'长治'), (26,'大同'), (26,'候马'),
 (26,'晋城'), (26,'离石'), (26,'临汾'), (26,'宁武'), (26,'朔州'), (26,'忻州'),
 (26,'阳泉'), (26,'榆次'), (26,'运城'), (27,'西安'), (27,'安康'), (27,'宝鸡'),
 (27,'汉中'), (27,'渭南'), (27,'商州'), (27,'绥德'), (27,'铜川'), (27,'咸阳'),
 (27,'延安'), (27,'榆林'), (28,'成都'), (28,'巴中'), (28,'达州'), (28,'德阳');

INSERT INTO city (pid,title) VALUES 
 (28,'都江堰'), (28,'峨眉山'), (28,'涪陵'), (28,'广安'), (28,'广元'), (28,'九寨沟'),
 (28,'康定'), (28,'乐山'), (28,'泸州'), (28,'马尔康'), (28,'绵阳'), (28,'眉山'),
 (28,'南充'), (28,'内江'), (28,'攀枝花'), (28,'遂宁'), (28,'汶川'), (28,'西昌'),
 (28,'雅安'), (28,'宜宾'), (28,'自贡'), (28,'资阳'), (29,'台北'), (29,'基隆'),
 (29,'台南'), (29,'台中'), (30,'天津'), (31,'乌鲁木齐'), (31,'阿克苏'), (31,'阿勒泰'),
 (31,'阿图什'), (31,'博乐'), (31,'昌吉'), (31,'东山'), (31,'哈密');

INSERT INTO city (pid,title) VALUES 
 (31,'和田'), (31,'喀什'), (31,'克拉玛依'), (31,'库车'), (31,'库尔勒'), (31,'奎屯'),
 (31,'石河子'), (31,'塔城'), (31,'吐鲁番'), (31,'伊宁'), (32,'拉萨'), (32,'阿里'),
 (32,'昌都'), (32,'林芝'), (32,'那曲'), (32,'日喀则'), (32,'山南'), (33,'昆明'),
 (33,'大理'), (33,'保山'), (33,'楚雄'), (33,'东川'), (33,'个旧'),
 (33,'景洪'), (33,'开远'), (33,'临沧'), (33,'丽江'), (33,'六库'), (33,'潞西'),
 (33,'曲靖'), (33,'思茅'), (33,'文山'), (33,'西双版纳'), (33,'玉溪');

INSERT INTO city (pid,title) VALUES 
 (33,'中甸'), (33,'昭通'), (34,'杭州'), (34,'安吉'), (34,'慈溪'), (34,'定海'),
 (34,'奉化'), (34,'海盐'), (34,'黄岩'), (34,'湖州'), (34,'嘉兴'), (34,'金华'),
 (34,'临安'), (34,'临海'), (34,'丽水'), (34,'宁波'), (34,'瓯海'), (34,'平湖'),
 (34,'千岛湖'), (34,'衢州'), (34,'江山'), (34,'瑞安'), (34,'绍兴'), (34,'嵊州'),
 (34,'台州'), (34,'温岭'), (34,'温州'), (34,'舟山') ;

-- 增加仓库类型信息（同步商品类型）
INSERT INTO witem(title) VALUES ('服装') ;
INSERT INTO witem(title) VALUES ('电子') ;
INSERT INTO witem(title) VALUES ('图书') ;
INSERT INTO witem(title) VALUES ('家居') ;
INSERT INTO witem(title) VALUES ('家电') ;

-- 增加商品子分类信息
INSERT INTO subtype(title,wiid) VALUES ('帽子',1) ;
INSERT INTO subtype(title,wiid) VALUES ('鞋子',1) ;
INSERT INTO subtype(title,wiid) VALUES ('时装',1) ;
INSERT INTO subtype(title,wiid) VALUES ('主板',2) ;
INSERT INTO subtype(title,wiid) VALUES ('U盘',2) ;
INSERT INTO subtype(title,wiid) VALUES ('硬盘',2) ;
INSERT INTO subtype(title,wiid) VALUES ('手机',2) ;
INSERT INTO subtype(title,wiid) VALUES ('平板',2) ;
INSERT INTO subtype(title,wiid) VALUES ('编程图书',3) ;
INSERT INTO subtype(title,wiid) VALUES ('大学教材',3) ;
INSERT INTO subtype(title,wiid) VALUES ('数据库',3) ;
INSERT INTO subtype(title,wiid) VALUES ('大数据',3) ;
INSERT INTO subtype(title,wiid) VALUES ('沙发',4) ;
INSERT INTO subtype(title,wiid) VALUES ('椅子',4) ;
INSERT INTO subtype(title,wiid) VALUES ('桌子',4) ;
INSERT INTO subtype(title,wiid) VALUES ('冰箱',5) ;
INSERT INTO subtype(title,wiid) VALUES ('电视',5) ;
INSERT INTO subtype(title,wiid) VALUES ('洗衣机',5) ;


-- 增加客户等级信息表
INSERT INTO citem(title) VALUES ('潜在客户') ;
INSERT INTO citem(title) VALUES ('大单客户') ;
INSERT INTO citem(title) VALUES ('重要客户') ;
INSERT INTO citem(title) VALUES ('网站客户') ;

-- 增加客户来源信息
INSERT INTO csource(title) VALUES ('电话咨询') ;
INSERT INTO csource(title) VALUES ('上门访问') ;
INSERT INTO csource(title) VALUES ('网站购物') ;
INSERT INTO csource(title) VALUES ('推广渠道') ;
INSERT INTO csource(title) VALUES ('销售关系') ;
INSERT INTO csource(title) VALUES ('其它') ;

-- 定义客户联系类型信息
INSERT INTO critem(title) VALUES ('普通联系') ;
INSERT INTO critem(title) VALUES ('销售推荐') ;
INSERT INTO critem(title) VALUES ('客户回访') ;
INSERT INTO critem(title) VALUES ('业务合作') ;
INSERT INTO critem(title) VALUES ('其它') ;


-- 增加员工等级信息
INSERT INTO level(lid,title,losal,hisal) VALUES (0,'总裁',30001.00,99999.00) ;
INSERT INTO level(lid,title,losal,hisal) VALUES (1,'总监',15001.00,30000.00) ;
INSERT INTO level(lid,title,losal,hisal) VALUES (2,'部门经理',8001.00,15000.00) ;
INSERT INTO level(lid,title,losal,hisal) VALUES (3,'普通员工',3000.00,8000.00) ;

-- 增加部门信息
INSERT INTO dept (dname,maxnum,currnum) VALUES ('管理部',3,0) ;
INSERT INTO dept (dname,maxnum,currnum) VALUES ('人事部',3,0) ;
INSERT INTO dept (dname,maxnum,currnum) VALUES ('财务部',5,0) ;
INSERT INTO dept (dname,maxnum,currnum) VALUES ('市场部',10,0) ;
INSERT INTO dept (dname,maxnum,currnum) VALUES ('开发部',10,0) ;
INSERT INTO dept (dname,maxnum,currnum) VALUES ('营销部',10,0) ;
INSERT INTO dept (dname,maxnum,currnum) VALUES ('后勤部',20,0) ;
INSERT INTO dept (dname,maxnum,currnum) VALUES ('仓储部',50,0) ;


-- 增加员工信息
-- 管理部总裁，用户名：mldn-president / 密码：hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate) VALUES ('mldn-president',0,1,'老李','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-10-10') ;
-- 管理部总监，用户名：mldn-chief / 密码：hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate) VALUES ('mldn-chief',1,1,'老张','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-10-10') ;

-- 人事部经理，用户名：mldn-human / 密码：hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate) VALUES ('mldn-human',2,2,'老闽','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-10-11') ;

-- 财务部经理，用户名：mldn-finance / 密码：hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn-finance',2,3,'老王','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-10-12','mldn-human') ;

-- 市场部经理，用户名：mldn-market / 密码：hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn-market',2,4,'老林','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-10-13','mldn-human') ;

-- 开发部经理，用户名：mldn-dev / 密码：hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn-dev',2,5,'老赵','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-10-14','mldn-human') ;

-- 营销部经理，用户名：mldn-sale / 密码：hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn-sale',2,6,'老孙','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-10-15','mldn-human') ;

-- 后勤部经理，用户名：mldn-log / 密码：hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn-log',2,7,'老孙','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-10-16','mldn-human') ;

-- 仓储部经理，用户名：mldn-warehouse / 密码：hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn-warehouse',2,8,'老阿','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-10-16','mldn-human') ;


-- 增加部门经理信息
UPDATE dept SET mid='mldn-chief' WHERE did=1 ;
UPDATE dept SET mid='mldn-human' WHERE did=2 ;
UPDATE dept SET mid='mldn-finance' WHERE did=3 ;
UPDATE dept SET mid='mldn-market' WHERE did=4 ;
UPDATE dept SET mid='mldn-dev' WHERE did=5 ;
UPDATE dept SET mid='mldn-sale' WHERE did=6 ;
UPDATE dept SET mid='mldn-log' WHERE did=7 ;
UPDATE dept SET mid='mldn-warehouse' WHERE did=8 ;

-- 增加普通员工信息
-- 增加人事部普通员工：mldn1 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn1',3,2,'魔乐科技-1','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-11-11','mldn-human') ;

-- 增加人事部普通员工：mldn2 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn2',3,2,'魔乐科技-2','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-11-11','mldn1') ;

-- 增加财务部员工：mldn3 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn3',3,3,'魔乐科技-3','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-11-12','mldn1') ;

-- 增加财务部员工：mldn4 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn4',3,3,'魔乐科技-4','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-11-12','mldn1') ;

-- 增加财务部员工：mldn5 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn5',3,3,'魔乐科技-5','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-11-12','mldn1') ;

-- 增加财务部员工：mldn6 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn6',3,4,'魔乐科技-6','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-11-13','mldn1') ;

-- 增加财务部员工：mldn7 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn7',3,4,'魔乐科技-7','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-11-13','mldn1') ;

-- 增加市场部员工：mldn8 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn8',3,4,'魔乐科技-8','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-11-15','mldn1') ;

-- 增加市场部员工：mldn9 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn9',3,4,'魔乐科技-9','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-11-15','mldn1') ;

-- 增加市场部员工：mldn10 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn10',3,4,'魔乐科技-10','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-11-15','mldn1') ;

-- 增加市场部员工：mldn11 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn11',3,4,'魔乐科技-11','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-11-15','mldn1') ;

-- 增加市场部员工：mldn12 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn12',3,4,'魔乐科技-12','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-11-15','mldn1') ;


-- 增加开发部员工：mldn13 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn13',3,5,'魔乐科技-13','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-11-15','mldn2') ;

-- 增加开发部员工：mldn14 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn14',3,5,'魔乐科技-14','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-11-15','mldn2') ;

-- 增加开发部员工：mldn15 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn15',3,5,'魔乐科技-15','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-11-15','mldn2') ;

-- 增加开发部员工：mldn16 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn16',3,5,'魔乐科技-16','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-11-15','mldn2') ;

-- 增加开发部员工：mldn17 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn17',3,5,'魔乐科技-17','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-11-15','mldn2') ;

-- 增加营销部员工：mldn18 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn18',3,6,'魔乐科技-18','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-11-15','mldn2') ;

-- 增加营销部员工：mldn19 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn19',3,6,'魔乐科技-19','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-11-15','mldn2') ;

-- 增加营销部员工：mldn20 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn20',3,6,'魔乐科技-20','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-11-15','mldn2') ;

-- 增加营销部员工：mldn21 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn21',3,6,'魔乐科技-21','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-11-15','mldn2') ;

-- 增加营销部员工：mldn22 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn22',3,6,'魔乐科技-22','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-11-15','mldn2') ;

-- 增加营销部员工：mldn23 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn23',3,6,'魔乐科技-23','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-11-15','mldn2') ;

-- 增加营销部员工：mldn24 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn24',3,6,'魔乐科技-24','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-11-15','mldn2') ;

-- 增加营销部员工：mldn25 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn25',3,6,'魔乐科技-25','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-11-15','mldn2') ;

-- 增加后勤部员工：mldn26 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn26',3,7,'魔乐科技-26','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-12-16','mldn2') ;

-- 增加后勤部员工：mldn27 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn27',3,7,'魔乐科技-27','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-12-16','mldn2') ;

-- 增加后勤部员工：mldn28 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn28',3,7,'魔乐科技-28','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-12-16','mldn2') ;

-- 增加后勤部员工：mldn29 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn29',3,7,'魔乐科技-29','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-12-16','mldn2') ;

-- 增加后勤部员工：mldn30 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn30',3,7,'魔乐科技-30','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-12-16','mldn2') ;

-- 增加后勤部员工：mldn31 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn31',3,7,'魔乐科技-31','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-12-16','mldn2') ;

-- 增加后勤部员工：mldn32 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn32',3,7,'魔乐科技-32','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-12-16','mldn2') ;

-- 增加后勤部员工：mldn33 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn33',3,7,'魔乐科技-33','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-12-16','mldn2') ;

-- 增加后勤部员工：mldn34 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn34',3,7,'魔乐科技-34','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-12-16','mldn2') ;

-- 增加后勤部员工：mldn35 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn35',3,7,'魔乐科技-35','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-12-16','mldn2') ;

-- 增加后勤部员工：mldn36 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn36',3,7,'魔乐科技-36','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-12-16','mldn2') ;

-- 增加后勤部员工：mldn37 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn37',3,7,'魔乐科技-37','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-12-16','mldn2') ;

-- 增加后勤部员工：mldn38 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn38',3,7,'魔乐科技-38','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-12-16','mldn2') ;

-- 增加后勤部员工：mldn39 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn39',3,7,'魔乐科技-39','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-12-16','mldn2') ;

-- 增加后勤部员工：mldn40 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn40',3,7,'魔乐科技-40','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-12-16','mldn2') ;

-- 增加仓储部员工：mldn50 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn50',3,8,'魔乐科技-50','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-12-16','mldn2') ;

-- 增加仓储部员工：mldn51 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn51',3,8,'魔乐科技-51','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-12-16','mldn2') ;

-- 增加仓储部员工：mldn52 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn52',3,8,'魔乐科技-52','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-12-16','mldn2') ;

-- 增加仓储部员工：mldn53 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn53',3,8,'魔乐科技-53','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-12-16','mldn2') ;

-- 增加仓储部员工：mldn54 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn54',3,8,'魔乐科技-54','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-12-16','mldn2') ;

-- 增加仓储部员工：mldn55 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn55',3,8,'魔乐科技-55','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-12-16','mldn2') ;

-- 增加仓储部员工：mldn56 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn56',3,8,'魔乐科技-56','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-12-16','mldn2') ;

-- 增加仓储部员工：mldn57 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn57',3,8,'魔乐科技-57','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-12-16','mldn2') ;

-- 增加仓储部员工：mldn58 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn58',3,8,'魔乐科技-58','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-12-16','mldn2') ;

-- 增加仓储部员工：mldn59 / hello
INSERT INTO member (mid,lid,did,name,phone,password,photo,note,hiredate,inmid) VALUES ('mldn59',3,8,'魔乐科技-59','01051283346','EAB62A7769F0313F8D69CEBA32F4347E','nophoto.png','很好的员工','2010-12-16','mldn2') ;

-- 更新部门对应人数
UPDATE dept SET currnum=2 WHERE did=1 ;
UPDATE dept SET currnum=3 WHERE did=2 ;
UPDATE dept SET currnum=4 WHERE did=3 ;
UPDATE dept SET currnum=8 WHERE did=4 ;
UPDATE dept SET currnum=6 WHERE did=5 ;
UPDATE dept SET currnum=9 WHERE did=6 ;
UPDATE dept SET currnum=16 WHERE did=7 ;
UPDATE dept SET currnum=10 WHERE did=8 ;

-- 增加角色信息
INSERT INTO role(rid,title) VALUES ('dept','【人事部】部门信息管理') ;
INSERT INTO role(rid,title) VALUES ('member','【人事部】雇员信息管理') ;
INSERT INTO role(rid,title) VALUES ('chief','【管理部】查看信息') ;
INSERT INTO role(rid,title) VALUES ('storageaudit','【财务部】入库审核') ;
INSERT INTO role(rid,title) VALUES ('goods','【市场部】商品管理') ;
INSERT INTO role(rid,title) VALUES ('salegoods','【营销部】商品销售') ;
INSERT INTO role(rid,title) VALUES ('storage','【营销部】入库管理') ;
INSERT INTO role(rid,title) VALUES ('customer','【营销部】客户管理') ;
INSERT INTO role(rid,title) VALUES ('distribution','【营销部】出库管理') ;
INSERT INTO role(rid,title) VALUES ('warehouse','【仓储部】仓库管理') ;
INSERT INTO role(rid,title) VALUES ('manage','【仓储部】仓储管理') ;

-- 增加权限信息
INSERT INTO action(actid,rid,title) VALUES ('dept:list','dept','部门列表') ;
INSERT INTO action(actid,rid,title) VALUES ('dept:edit','dept','部门编辑') ;
INSERT INTO action(actid,rid,title) VALUES ('dept:add','dept','部门增加') ;
INSERT INTO action(actid,rid,title) VALUES ('member:list','member','雇员列表') ;
INSERT INTO action(actid,rid,title) VALUES ('member:add','member','雇员增加') ;
INSERT INTO action(actid,rid,title) VALUES ('member:edit','member','雇员编辑') ;
INSERT INTO action(actid,rid,title) VALUES ('member:delete','member','雇员删除') ;
INSERT INTO action(actid,rid,title) VALUES ('member:get','member','雇员查看') ;

INSERT INTO action(actid,rid,title) VALUES ('warehouse:add','warehouse','增加仓库') ;
INSERT INTO action(actid,rid,title) VALUES ('warehouse:edit','warehouse','修改仓库') ;
INSERT INTO action(actid,rid,title) VALUES ('warehouse:list','warehouse','仓库列表') ;

INSERT INTO action(actid,rid,title) VALUES ('goods:add','goods','增加商品') ;
INSERT INTO action(actid,rid,title) VALUES ('goods:edit','goods','修改商品') ;
INSERT INTO action(actid,rid,title) VALUES ('goods:list','goods','商品列表') ;

INSERT INTO action(actid,rid,title) VALUES ('customer:add','customer','增加客户') ;
INSERT INTO action(actid,rid,title) VALUES ('customer:edit','customer','修改客户') ;
INSERT INTO action(actid,rid,title) VALUES ('customer:list','customer','客户列表') ;
INSERT INTO action(actid,rid,title) VALUES ('customer:record','customer','客户联系记录') ;

INSERT INTO action(actid,rid,title) VALUES ('storage:add','storage','创建入库申请单') ;
INSERT INTO action(actid,rid,title) VALUES ('storage:edit','storage','编辑入库申请单') ;
INSERT INTO action(actid,rid,title) VALUES ('storage:list','storage','入库申请单列表') ;
INSERT INTO action(actid,rid,title) VALUES ('storage:details','storage','入库申请单详情') ;
INSERT INTO action(actid,rid,title) VALUES ('storage:apply','storage','入库申请单提交') ;

INSERT INTO action(actid,rid,title) VALUES ('storageaudit:check','storageaudit','入库单审核') ;
INSERT INTO action(actid,rid,title) VALUES ('storageaudit:prepare','storageaudit','待审核入库单列表') ;
INSERT INTO action(actid,rid,title) VALUES ('storageaudit:history','storageaudit','入库单列表') ;

INSERT INTO action(actid,rid,title) VALUES ('distribution:add','distribution','创建分销申请') ;
INSERT INTO action(actid,rid,title) VALUES ('distribution:apply','distribution','提交分销申请') ;
INSERT INTO action(actid,rid,title) VALUES ('distribution:cancel','distribution','取消分销申请') ;

INSERT INTO action(actid,rid,title) VALUES ('manage:storage','manage','入库处理') ;
INSERT INTO action(actid,rid,title) VALUES ('manage:distribution','manage','出库处理') ;

INSERT INTO action(actid,rid,title) VALUES ('salegoods:list','salegoods','商品列表') ;
INSERT INTO action(actid,rid,title) VALUES ('salegoods:prepare','salegoods','待出库商品') ;

-- 管理部角色
INSERT INTO dept_role(did,rid) VALUES (1,'chief') ;
-- 人事部角色
INSERT INTO dept_role(did,rid) VALUES (2,'dept') ;
INSERT INTO dept_role(did,rid) VALUES (2,'member') ;
-- 财务部角色
INSERT INTO dept_role(did,rid) VALUES (3,'storageaudit') ;
-- 市场部角色
INSERT INTO dept_role(did,rid) VALUES (4,'goods') ;
-- 营销部角色
INSERT INTO dept_role(did,rid) VALUES (6,'salegoods') ;
INSERT INTO dept_role(did,rid) VALUES (6,'customer') ;
INSERT INTO dept_role(did,rid) VALUES (6,'storage') ;
INSERT INTO dept_role(did,rid) VALUES (6,'distribution') ;
-- 仓储部角色
INSERT INTO dept_role(did,rid) VALUES (8,'manage') ;
INSERT INTO dept_role(did,rid) VALUES (8,'warehouse') ;



COMMIT ;
