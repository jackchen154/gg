alter table laoshi add column laoshi_xingbie varchar(10) not null after laoshi_name; --添加列
ALTER  TABLE  chengjibiao  DROP  PRIMARY  KEY; --去除主键
drop table chengjibiao; --删除表
--更新操作
UPDATE chengjibiao SET kechenghao='6-166' WHERE xuehao='003';


-- 学生表
CREATE TABLE xueshengbiao(
	xuehao VARCHAR(20) PRIMARY KEY,-- 学号
	xingming VARCHAR(20) NOT NULL,-- 姓名
	xingbie VARCHAR(10) NOT NULL,-- 性别
	chushengriqi DATETIME ,-- 出生年月
	banji VARCHAR(20)-- 班级
	
);

INSERT INTO xueshengbiao VALUES('001','曾华','男','1990-05-11','2001');
INSERT INTO xueshengbiao VALUES('002','匡明','男','1989-07-16','2001');
INSERT INTO xueshengbiao VALUES('003','王丽','女','1994-02-22','2002');
INSERT INTO xueshengbiao VALUES('004','李军','男','1998-05-08','2002');
INSERT INTO xueshengbiao VALUES('005','王芳','女','1991-08-11','2003');
INSERT INTO xueshengbiao VALUES('006','陆军','男','1995-06-02','2003');
-- 课程表
CREATE TABLE kechengbiao (
	kechenghao VARCHAR(20) PRIMARY KEY,-- 课程号
	kechengmingcheng VARCHAR(20) NOT NULL,-- 课程名称
	laoshi_num VARCHAR(20) NOT NULL,-- 老师编号
	FOREIGN KEY (laoshi_num) REFERENCES laoshi(laoshi_no)
);
INSERT INTO kechengbiao VALUES('3-105','计算机导论','804');
INSERT INTO kechengbiao VALUES('3-245','操作系统','856');
INSERT INTO kechengbiao VALUES('6-166','数字电路','815');
INSERT INTO kechengbiao VALUES('9-888','高等数学','825');




-- 教师列表
CREATE TABLE laoshi(
	laoshi_no VARCHAR(10) PRIMARY KEY,-- 老师编号
	laoshi_name VARCHAR(20) NOT NULL,-- 老师名称
	laoshi_xingbie varchar(10) not null,
	laoshi_chusheng DATETIME , -- 老师出生年月
	laoshi_zhicheng VARCHAR(20) NOT NULL,-- 老师职称
	laoshi_bumen VARCHAR(20) NOT NULL-- 老师部门
	);

INSERT INTO laoshi VALUES('804','李成','男','1958-12-02','副教授','计算机系');	
INSERT INTO laoshi VALUES('856','张旭','男','1969-09-02','讲师','电子工程');
INSERT INTO laoshi VALUES('825','王萍','女','1972-03-02','助教','法律系');
INSERT INTO laoshi VALUES('815','刘冰','女','1977-06-02','助教','土木工程系');
-- 成绩表
CREATE TABLE chengjibiao(
	xuehao VARCHAR(20) NOT NULL,--学号
	kechenghao VARCHAR(20) NOT NULL,--课程号
	chengji DECIMAL ,--成绩
	FOREIGN KEY (xuehao) REFERENCES xueshengbiao(xuehao),
	FOREIGN KEY (kechenghao) REFERENCES kechengbiao(kechenghao)
	PRIMARY KEY (xuehao,kechenghao)--联合主键(学号加上课程号不重复即可，其他情况可以重复)
);

INSERT INTO `chengjibiao` VALUES ('001', '3-245', 66);
INSERT INTO `chengjibiao` VALUES ('001', '6-166', 98);
INSERT INTO `chengjibiao` VALUES ('002', '3-245', 55);
INSERT INTO `chengjibiao` VALUES ('003', '6-166', 98);
INSERT INTO `chengjibiao` VALUES ('004', '3-105', 22);
INSERT INTO `chengjibiao` VALUES ('005', '9-888', 44);
INSERT INTO `chengjibiao` VALUES ('006', '3-105', 32);
INSERT INTO `chengjibiao` VALUES ('007', '6-166', 57);
INSERT INTO `chengjibiao` VALUES ('008', '3-245', 88);


--查询操作//////////////////////////////////////////////////////////////////////////////////////////////////

select * from xueshengbiao;--星号表示所有字段,查询所有字段
+--------+----------+---------+---------------------+-------+
| xuehao | xingming | xingbie | chushengriqi        | banji |
+--------+----------+---------+---------------------+-------+
| 001    | 曾华     | 男      | 1990-05-11 00:00:00 | 2001  |
| 002    | 匡明     | 男      | 1989-07-16 00:00:00 | 2001  |
| 003    | 王丽     | 女      | 1994-02-22 00:00:00 | 2002  |
| 004    | 李军     | 男      | 1998-05-08 00:00:00 | 2002  |
| 005    | 王芳     | 女      | 1991-08-11 00:00:00 | 2003  |
| 006    | 陆军     | 男      | 1995-06-02 00:00:00 | 2003  |
+--------+----------+---------+---------------------+-------+

select xingming,banji,xuehao from xueshengbiao;--查询指定字段,只显示指定的列
+----------+-------+--------+
| xingming | banji | xuehao |
+----------+-------+--------+
| 曾华     | 2001  | 001    |
| 匡明     | 2001  | 002    |
| 王丽     | 2002  | 003    |
| 李军     | 2002  | 004    |
| 王芳     | 2003  | 005    |
| 陆军     | 2003  | 006    |
+----------+-------+--------+

mysql>  select DISTINCT banji from xueshengbiao; --使用DISTINCT可以排除掉重复的项
+-------+
| banji |
+-------+
| 2001  |
| 2002  |
| 2003  |
+-------+

--区间筛选
mysql>  select * from chengjibiao;--原始数据
+--------+------------+---------+
| xuehao | kechenghao | chengji |
+--------+------------+---------+
| 001    | 3-245      |      66 |
| 002    | 3-105      |      55 |
| 003    | 9-888      |      98 |
| 005    | 6-166      |      44 |
+--------+------------+---------+

mysql>  select * from chengjibiao where chengji between 55 and 66;--筛选出成绩在55-66之间的数据
+--------+------------+---------+
| xuehao | kechenghao | chengji |
+--------+------------+---------+
| 001    | 3-245      |      66 |
| 002    | 3-105      |      55 |
+--------+------------+---------+
mysql>  select * from chengjibiao where chengji >= 55 and chengji <= 66;--另外的一种方法使用运算符进行比较
+--------+------------+---------+
| xuehao | kechenghao | chengji |
+--------+------------+---------+
| 001    | 3-245      |      66 |
| 002    | 3-105      |      55 |
+--------+------------+---------+

mysql>  select * from chengjibiao where chengji in(66,98,44); --找出成绩是66 ，98 ，44的数据，指定某几个数据的查询
+--------+------------+---------+
| xuehao | kechenghao | chengji |
+--------+------------+---------+
| 001    | 3-245      |      66 |
| 003    | 9-888      |      98 |
| 005    | 6-166      |      44 |
+--------+------------+---------+
mysql>  select * from chengjibiao where xuehao='001' or chengji=44;--找出学号是001或成绩是44的数据，使用or或运算查询
+--------+------------+---------+
| xuehao | kechenghao | chengji |
+--------+------------+---------+
| 001    | 3-245      |      66 |
| 005    | 6-166      |      44 |
+--------+------------+---------+

--对数据进行升序和降序
mysql> select * from xueshengbiao order by banji desc; --对班级进行降序操作
+--------+----------+---------+---------------------+-------+
| xuehao | xingming | xingbie | chushengriqi        | banji |
+--------+----------+---------+---------------------+-------+
| 005    | 王芳     | 女      | 1991-08-11 00:00:00 | 2003  |
| 006    | 陆军     | 男      | 1995-06-02 00:00:00 | 2003  |
| 003    | 王丽     | 女      | 1994-02-22 00:00:00 | 2002  |
| 004    | 李军     | 男      | 1998-05-08 00:00:00 | 2002  |
| 001    | 曾华     | 男      | 1990-05-11 00:00:00 | 2001  |
| 002    | 匡明     | 男      | 1989-07-16 00:00:00 | 2001  |
+--------+----------+---------+---------------------+-------+

mysql> select * from xueshengbiao order by chushengriqi asc;--对出生日期进行升序操作
mysql> select * from xueshengbiao order by chushengriqi;--默认使用的是升序操作，可以不写asc
+--------+----------+---------+---------------------+-------+
| xuehao | xingming | xingbie | chushengriqi        | banji |
+--------+----------+---------+---------------------+-------+
| 002    | 匡明     | 男      | 1989-07-16 00:00:00 | 2001  |
| 001    | 曾华     | 男      | 1990-05-11 00:00:00 | 2001  |
| 005    | 王芳     | 女      | 1991-08-11 00:00:00 | 2003  |
| 003    | 王丽     | 女      | 1994-02-22 00:00:00 | 2002  |
| 006    | 陆军     | 男      | 1995-06-02 00:00:00 | 2003  |
| 004    | 李军     | 男      | 1998-05-08 00:00:00 | 2002  |
+--------+----------+---------+---------------------+-------+

--统计个数
mysql> select count(*) from xueshengbiao where banji='2001'; --统计2001班的学生有多少人
+----------+
| count(*) |
+----------+
|        2 |
+----------+

--查询最大值
mysql> select * from chengjibiao where chengji=(select max(chengji) from chengjibiao);--显示成绩为最高的条目
+--------+------------+---------+
| xuehao | kechenghao | chengji |
+--------+------------+---------+
| 003    | 9-888      |      98 |
+--------+------------+---------+

--数据的截取显示limit 起始位置，显示的数量; 起始从0开始
mysql> select * from xueshengbiao limit 2,2; --从第3个数据开始显示，共显示2个数据
+--------+----------+---------+---------------------+-------+
| xuehao | xingming | xingbie | chushengriqi        | banji |
+--------+----------+---------+---------------------+-------+
| 003    | 王丽     | 女      | 1994-02-22 00:00:00 | 2002  |
| 004    | 李军     | 男      | 1998-05-08 00:00:00 | 2002  |
+--------+----------+---------+---------------------+-------+
2 rows in set (0.00 sec)

mysql> select * from xueshengbiao limit 4;--只显示前4个数据
+--------+----------+---------+---------------------+-------+
| xuehao | xingming | xingbie | chushengriqi        | banji |
+--------+----------+---------+---------------------+-------+
| 001    | 曾华     | 男      | 1990-05-11 00:00:00 | 2001  |
| 002    | 匡明     | 男      | 1989-07-16 00:00:00 | 2001  |
| 003    | 王丽     | 女      | 1994-02-22 00:00:00 | 2002  |
| 004    | 李军     | 男      | 1998-05-08 00:00:00 | 2002  |
+--------+----------+---------+---------------------+-------+

--求平均值
mysql> select * from chengjibiao; --原始数据
+--------+------------+---------+
| xuehao | kechenghao | chengji |
+--------+------------+---------+
| 001    | 3-245      |      66 |
| 002    | 3-245      |      55 |
| 003    | 6-166      |      98 |
| 005    | 6-166      |      44 |
+--------+------------+---------+
mysql> select avg(chengji) from chengjibiao;--使用avg()求平均值
+--------------+
| avg(chengji) |
+--------------+
|      65.7500 |
+--------------+

mysql> select kechenghao, avg(chengji) from chengjibiao where kechenghao='6-166'; --查询6-166这个课程的平均成绩
+------------+--------------+
| kechenghao | avg(chengji) |
+------------+--------------+
| 6-166      |      71.0000 |
+------------+--------------+

--group by 分组
mysql> select kechenghao, avg(chengji) from chengjibiao group by kechenghao; --按课程号进行分组分别显示对应的平均值
+------------+--------------+
| kechenghao | avg(chengji) |
+------------+--------------+
| 3-245      |      60.5000 |
| 6-166      |      71.0000 |
+------------+--------------+

--找出成绩表中至少有两名学生选修，且以3开头的课程的平均分数//////////////////////////////////////////////////////////////
mysql> select * from chengjibiao;
+--------+------------+---------+
| xuehao | kechenghao | chengji |
+--------+------------+---------+
| 001    | 3-245      |      66 |
| 002    | 3-245      |      55 |
| 003    | 6-166      |      98 |
| 004    | 3-105      |      22 |
| 005    | 9-888      |      44 |
| 006    | 3-105      |      32 |
| 007    | 6-166      |      57 |
| 008    | 3-245      |      88 |
+--------+------------+---------+

1.mysql> select kechenghao from chengjibiao group by kechenghao; --先将课程进行分组
+------------+
| kechenghao |
+------------+
| 3-105      |
| 3-245      |
| 6-166      |
| 9-888      |
+------------+

2.mysql> select kechenghao from chengjibiao group by kechenghao having count(kechenghao)>=2; --找出分组中人数为2的组
+------------+
| kechenghao |
+------------+
| 3-105      |
| 3-245      |
| 6-166      |
+------------+

--使用like进行模糊查询%为通配符代表任意值
3.mysql> select kechenghao from chengjibiao group by kechenghao having count(kechenghao)>=2 and kechenghao like '3%'; --找出分组人数为2，课程开头为3的
+------------+
| kechenghao |
+------------+
| 3-105      |
| 3-245      |
+------------+

--显示出数量和平均数
4.mysql> select kechenghao,avg(chengji),count(*) from chengjibiao group by kechenghao having count(kechenghao)>=2 and kechenghao like '3%';
+------------+--------------+----------+
| kechenghao | avg(chengji) | count(*) |
+------------+--------------+----------+
| 3-105      |      27.0000 |        2 |
| 3-245      |      69.6667 |        3 |
+------------+--------------+----------+
--////////////////////////////////////////////////////////////////////////////////////////////

--查询分数大于22，小于57的xuehao列////////////////////////////
1.mysql> select xuehao,chengji from chengjibiao where chengji>=22 and chengji <=57;
2.mysql> select xuehao,chengji from chengjibiao where chengji between 22 and 57;
+--------+---------+
| xuehao | chengji |
+--------+---------+
| 002    |      55 |
| 004    |      22 |
| 005    |      44 |
| 006    |      32 |
| 007    |      57 |
+--------+---------+
--/////////////////////////////////////////////////////////////



--多表查询相当于Excel的vlookup
--任务找出学生表和成绩表，按照学号这个关键字进行vlookup
1.mysql> select kechenghao,chengji from chengjibiao;--成绩表中的成绩和课程号
+------------+---------+
| kechenghao | chengji |
+------------+---------+
| 3-245      |      66 |
| 3-245      |      55 |
| 6-166      |      98 |
| 3-105      |      22 |
| 9-888      |      44 |
| 3-105      |      32 |
| 6-166      |      57 |
| 3-245      |      88 |
+------------+---------+
2.mysql> select xingming,banji from xueshengbiao;--学生表中的姓名和班级
+----------+-------+
| xingming | banji |
+----------+-------+
| 曾华     | 2001  |
| 匡明     | 2001  |
| 王丽     | 2002  |
| 李军     | 2002  |
| 王芳     | 2003  |
| 陆军     | 2003  |
| 王刚     | 2004  |
| 张小梅   | 2005  |
+----------+-------+
--通过学号将成绩表和学生表进行关联
3.mysql> select xingming,kechenghao,chengji,banji from xueshengbiao,chengjibiao where xueshengbiao.xuehao=chengjibiao.xuehao;
+----------+------------+---------+-------+
| xingming | kechenghao | chengji | banji |
+----------+------------+---------+-------+
| 曾华     | 3-245      |      66 | 2001  |
| 匡明     | 3-245      |      55 | 2001  |
| 王丽     | 6-166      |      98 | 2002  |
| 李军     | 3-105      |      22 | 2002  |
| 王芳     | 9-888      |      44 | 2003  |
| 陆军     | 3-105      |      32 | 2003  |
| 王刚     | 6-166      |      57 | 2004  |
| 张小梅   | 3-245      |      88 | 2005  |
+----------+------------+---------+-------+
--三表查询
kechengmingcheng => kechengbiao
xingming => xueshengbiao
chengji =>chengjibiao
--将三个表的姓名，成绩，课程名称归到一张表中
mysql> select xingming,chengji,kechengmingcheng from kechengbiao,xueshengbiao,chengjibiao where xueshengbiao.xuehao=chengjibiao.xuehao and
chengjibiao.kechenghao=kechengbiao.kechenghao; --通过共同字段的相等来进行归并
+----------+---------+------------------+
| xingming | chengji | kechengmingcheng |
+----------+---------+------------------+
| 李军     |      22 | 计算机导论       |
| 陆军     |      32 | 计算机导论       |
| 曾华     |      66 | 操作系统         |
| 匡明     |      55 | 操作系统         |
| 张小梅   |      88 | 操作系统         |
| 王丽     |      98 | 数字电路         |
| 王刚     |      57 | 数字电路         |
| 王芳     |      44 | 高等数学         |
+----------+---------+------------------+
mysql> select xueshengbiao.xuehao as 学号,xingming,chengji,kechengmingcheng from kechengbiao,xueshengbiao,chengjibiao where xueshengbiao.xu
ehao=chengjibiao.xuehao and chengjibiao.kechenghao=kechengbiao.kechenghao; --学号因为在学生表和成绩表中都有用xueshengbiao.xuehao进行指定
+------+----------+---------+------------------+
| 学号 | xingming | chengji | kechengmingcheng |
+------+----------+---------+------------------+
| 004  | 李军     |      22 | 计算机导论       |
| 006  | 陆军     |      32 | 计算机导论       |
| 001  | 曾华     |      66 | 操作系统         |
| 002  | 匡明     |      55 | 操作系统         |
| 008  | 张小梅   |      88 | 操作系统         |
| 003  | 王丽     |      98 | 数字电路         |
| 007  | 王刚     |      57 | 数字电路         |
| 005  | 王芳     |      44 | 高等数学         |
+------+----------+---------+------------------+

--查询2001班学生每门成绩的平均分
1.mysql> select * from xueshengbiao where banji="2001";--查询2001班学生情况
+--------+----------+---------+---------------------+-------+
| xuehao | xingming | xingbie | chushengriqi        | banji |
+--------+----------+---------+---------------------+-------+
| 001    | 曾华     | 男      | 1990-05-11 00:00:00 | 2001  |
| 002    | 匡明     | 男      | 1989-07-16 00:00:00 | 2001  |
| 005    | 王芳     | 女      | 1991-08-11 00:00:00 | 2001  |
| 007    | 王刚     | 男      | 2020-02-03 17:56:04 | 2001  |
+--------+----------+---------+---------------------+-------+

2.mysql> select xuehao from xueshengbiao where banji="2001"; --将这个班级的学号取出
+--------+
| xuehao |
+--------+
| 001    |
| 002    |
| 005    |
| 007    |
+--------+

3.mysql> select * from chengjibiao where xuehao in( select xuehao from xueshengbiao where banji="2001");--从绩表取通过学号出成绩
+--------+------------+---------+
| xuehao | kechenghao | chengji |
+--------+------------+---------+
| 001    | 3-245      |      66 |
| 002    | 3-245      |      55 |
| 005    | 9-888      |      44 |
| 007    | 6-166      |      57 |
+--------+------------+---------+

4.mysql> select kechenghao, avg(chengji) from chengjibiao where xuehao in( select xuehao from xueshengbiao where banji="2001") group by keche
nghao; --对结果进行课程号分组以及求平均值
+------------+--------------+
| kechenghao | avg(chengji) |
+------------+--------------+
| 3-245      |      60.5000 |
| 9-888      |      44.0000 |
| 6-166      |      57.0000 |
+------------+--------------+  

--找出学号为001且选了3-245这门课的成绩，然后找出高于这个成绩的选修了6-166的所有同学
1.mysql> select chengji from chengjibiao where xuehao = "001" and kechenghao="3-245";
+---------+
| chengji |
+---------+
|      66 |
+---------+

2.mysql> select * from chengjibiao where chengji >(select chengji from chengjibiao where xuehao = "001" and kechenghao="3-245");
+--------+------------+---------+
| xuehao | kechenghao | chengji |
+--------+------------+---------+
| 001    | 6-166      |      98 |
| 003    | 6-166      |      98 |
| 008    | 3-245      |      88 |
+--------+------------+---------+

3.mysql> select * from chengjibiao where kechenghao= "6-166" and chengji >(select chengji from chengjibiao where xuehao = "001" and kechengha
o="3-245");
+--------+------------+---------+
| xuehao | kechenghao | chengji |
+--------+------------+---------+
| 001    | 6-166      |      98 |
| 003    | 6-166      |      98 |
+--------+------------+---------+


--查询和学号为008,003同学出生同年的学号，姓名，出生列
1.mysql> select * from xueshengbiao where xuehao in("003","008");
+--------+----------+---------+---------------------+-------+
| xuehao | xingming | xingbie | chushengriqi        | banji |
+--------+----------+---------+---------------------+-------+
| 003    | 王丽     | 女      | 1990-02-22 00:00:00 | 2002  |
| 008    | 张小梅   | 女      | 2020-02-25 17:56:46 | 2005  |
+--------+----------+---------+---------------------+-------+

2.mysql> select year(chushengriqi) from xueshengbiao where xuehao in("003","008");
+--------------------+
| year(chushengriqi) |
+--------------------+
|               1990 |
|               2020 |
+--------------------+

3.mysql> select xuehao,xingming,chushengriqi from xueshengbiao where year(chushengriqi) in (select year(chushengriqi) from xueshengbiao where
 xuehao in("003","008")); --因为这里的年份数据有两个所以匹配多个用in 单个用”=“
+--------+----------+---------------------+
| xuehao | xingming | chushengriqi        |
+--------+----------+---------------------+
| 001    | 曾华     | 1990-05-11 00:00:00 |
| 003    | 王丽     | 1990-02-22 00:00:00 |
| 005    | 王芳     | 1990-08-11 00:00:00 |
| 007    | 王刚     | 2020-02-03 17:56:04 |
| 008    | 张小梅   | 2020-02-25 17:56:46 |
+--------+----------+---------------------+

--查询王萍老师任课的学生成绩(多层嵌套的子查询)
1.mysql> select laoshi_no from laoshi where laoshi_name="王萍"; --找出该老师的老师号
+-----------+
| laoshi_no |
+-----------+
| 825       |
+-----------+

2.mysql> select kechenghao,kechengmingcheng from kechengbiao where laoshi_num=(select laoshi_no from laoshi where laoshi_name="王萍");
--通过老师号查出她教的课程和课程号
+------------+------------------+
| kechenghao | kechengmingcheng |
+------------+------------------+
| 9-888      | 高等数学         |
+------------+------------------+

3.mysql> select * from chengjibiao where kechenghao=(select kechenghao from kechengbiao where laoshi_num=(select laoshi_no from laoshi where
laoshi_name="王萍"));
+--------+------------+---------+
| xuehao | kechenghao | chengji |
+--------+------------+---------+
| 005    | 9-888      |      44 |
| 008    | 9-888      |      65 |
| 009    | 9-888      |      89 |
+--------+------------+---------+


--查询选修课程人数大于等于3个的教师名称
1.mysql> select count(*),kechenghao from chengjibiao group by kechenghao; --分组统计人数
+----------+------------+
| count(*) | kechenghao |
+----------+------------+
|        2 | 3-105      |
|        3 | 3-245      |
|        5 | 6-166      |
|        3 | 9-888      |
+----------+------------+

2.mysql> select count(*),kechenghao from chengjibiao group by kechenghao having count(*)>=3;--筛出大于等于3
+----------+------------+
| count(*) | kechenghao |
+----------+------------+
|        3 | 3-245      |
|        5 | 6-166      |
|        3 | 9-888      |
+----------+------------+

3.mysql> select laoshi_num,kechenghao from kechengbiao where kechenghao in(select kechenghao from chengjibiao group by kechenghao having coun
t(*)>=3); --通过成绩表的课程号得到课程表对应的老师名称
+------------+------------+
| laoshi_num | kechenghao |
+------------+------------+
| 815        | 6-166      |
| 825        | 9-888      |
| 856        | 3-245      |
+------------+------------+

4.mysql> select laoshi_num,kechenghao,laoshi_name from kechengbiao,laoshi where kechenghao in(select kechenghao from chengjibiao group by kec
henghao having count(*)>=3) and kechengbiao.laoshi_num=laoshi.laoshi_no; --显示老师的名称
+------------+------------+-------------+
| laoshi_num | kechenghao | laoshi_name |
+------------+------------+-------------+
| 815        | 6-166      | 刘冰        |
| 825        | 9-888      | 王萍        |
| 856        | 3-245      | 张旭        |
+------------+------------+-------------+

