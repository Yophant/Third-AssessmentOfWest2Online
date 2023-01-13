-- 创建班级表classes
CREATE TABLE classes(
	bjid INT PRIMARY KEY auto_increment COMMENT '主键',
	bjname VARCHAR(10) NOT NULL UNIQUE COMMENT '班级名称'
);

-- 创建课程表course
CREATE TABLE course(
	cid INT PRIMARY KEY auto_increment COMMENT '主键',
	cname VARCHAR(10) NOT NULL UNIQUE COMMENT '课程名称'
);

-- 创建学生表student
CREATE TABLE student(
	stuid INT PRIMARY KEY auto_increment COMMENT '主键',
	stuName VARCHAR(10) NOT NULL COMMENT '学生姓名',
	stuSex char(1) NOT NULL DEFAULT('男') COMMENT '性别',
	stuAge INT COMMENT '年龄' ,
	stuBirthday DATETIME COMMENT '出生日期',
	stuAddress VARCHAR(100) COMMENT '地址',
	stuMajor VARCHAR(20) COMMENT '专业',
	bjid INT COMMENT '班级id',
	FOREIGN KEY(bjid) REFERENCES classes(bjid) ON DELETE CASCADE ON UPDATE CASCADE) ENGINE=InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci; -- 外键对应数据被删除或者更新时，将关联数据完全删除或者相应地更新,设置表编码utf-8

-- 创建分数表 grade
CREATE TABLE grade(
	sccid INT PRIMARY KEY auto_increment COMMENT '主键',
	stuid INT COMMENT '学生id',
	cid INT COMMENT '课程id',
	score DOUBLE COMMENT '分数',
	FOREIGN KEY(stuid) REFERENCES student(stuid) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(cid) REFERENCES course(cid) ON DELETE CASCADE ON UPDATE CASCADE) ENGINE=INNODB CHARACTER SET utf8 COLLATE utf8_general_ci;

-- 在学生表中插入列:学生入学时间:
ALTER TABLE student 
ADD enrollTime DATETIME COMMENT '入学时间' ; 


-- 插入班级数据
INSERT INTO classes(
bjname
)VALUES ('一班'),('二班'),('三班');
-- 插入课程数据
INSERT INTO course(
cname
)VALUES('JAVA'),('C++'),('Python'
); 

-- SET foreign_key_checks = 0 ;
-- TRUNCATE TABLE student  ; 
-- SET foreign_key_checks = 1 ;
-- 插入学生数据
INSERT INTO student(
stuName,stuSex,stuAge,stuBirthday,stuAddress,stuMajor,bjid,enrollTime
) VALUES
('张珊','男',23,'1999-2-5','福州','计算机',3,'2018-9-1'),
('李芳','女',21,'2001-5-2','杭州','人工智能',1,'2020-9-1'),
('李华','女',22,'2000-3-6','苏州','大数据',2,'2019-9-1'),
('王涛','男',20,'2002-12-10','广州','软件工程',1,'2021-9-1'),
('小明','男',19,'2003-11-10','北京','信息安全',2,'2022-9-1'),
('小林','女',22,'2000-4-7','上海','计算机',1,'2019-9-1');

-- 插入一条学生数据
INSERT INTO student(
stuName,stuSex,stuAge,stuBirthday,stuAddress,stuMajor
)VALUES('小智','男',20,'2002-8-18','北京','计算机'
);

-- 插入成绩数据
INSERT INTO grade(
stuid,cid,score
)VALUES
(1,1,87),
(2,3,85),
(3,1,52),
(4,2,92),
(5,3,55),
(6,2,67);

-- 将计算机专业的福州的学生年龄改为24，姓名改为赵六
UPDATE student SET stuAge=24,stuName='赵六' 
WHERE stuMajor = '计算机' AND stuAddress = '福州' AND stuSex = '男';

-- 删除出生年份在2000年之前的学生
DELETE FROM  student s  
WHERE YEAR(s.stuBirthday)<2000 ; 

ALTER TABLE grade DROP sccid ; -- 删除grade表中主键
ALTER TABLE grade ADD sccid INT NOT NULL PRIMARY KEY auto_increment FIRST; -- 恢复自增主键

-- 修改所有学生分数+5分
UPDATE grade SET score = score + 5;

-- 修改编号为3的班级名称为c999
UPDATE classes SET bjname = 'c999' WHERE bjid = 3;


-- 查询除了计算机专业以外的姓王的学生姓名,年龄,性别以及专业
SELECT stuName,stuAge,stuSex,stuMajor
FROM student
WHERE stuMajor NOT IN('计算机') AND stuName LIKE '王%';

-- 查询不及格的分数信息
SELECT sccid,stuid,cid,score
FROM grade
WHERE score < 60;

-- 查询所有的学生报考的哪些专业
SELECT stuName AS '姓名',stuMajor AS '专业'
FROM student;

-- 查询学生所有的专业(不能重复显示,NULL不显示)
SELECT DISTINCT stuMajor AS '专业名称'
FROM student
WHERE stuMajor is NOT NULL;

-- 查询所有的学生信息，根据年龄由小到大排列排序
SELECT stuid AS '学号',stuName AS '姓名', stuAge AS '年龄', stuMajor AS '专业' ,stuAddress AS '籍贯' 
FROM student 
ORDER BY stuAge ASC;

-- 统计年龄为20的学生的人数
SELECT COUNT(1) AS '总人数'
FROM student
WHERE  stuAge = 22;

-- 统计C++课程的学生最高分、最低分和平均分及总分
SELECT MAX(score) AS '最高分',MIN(score) AS '最低分',AVG(score) AS '平均分',SUM(score) AS '总分'
FROM course,grade
WHERE course.cid = grade.cid AND course.cname = 'C++' ;

-- 查询每门课程的最高分，显示课程编号和最高分,分数降序显示
SELECT cid AS '课程编号',MAX(score) AS '最高分' 
FROM grade
GROUP BY cid
ORDER BY 最高分 DESC;

-- 查询2-5条分数信息
SELECT sccid,stuid,cid,score
FROM grade
LIMIT 1,4;

-- 查询1班和2班的计算机专业的班级名称和学生姓名
SELECT c.bjname AS '班级名称', s.stuName AS '学生姓名' 
FROM classes c , student s 
WHERE c.bjid = s.bjid AND c.bjname IN('一班','二班') AND s.stuMajor = '计算机' ;

-- 查询c999的所有学生姓名和课程及分数
SELECT s.stuName,co.cname,g.score 
FROM classes c , student s ,course co, grade g 
WHERE c.bjid = s.bjid AND co.cid = g.cid AND s.stuid = g.stuid AND c.bjname = 'c999' ;

-- 查询所有学生分数，如果分数低于60返回不及格，大于等于60小于80返回及格，大于等于80返回优秀，否则未知
SELECT stuid,
			 (CASE 
					WHEN  score<60 THEN '不及格'
					WHEN  score >=60 AND score <80 THEN '及格'
					WHEN score >=80 THEN '优秀'
					ELSE '未知' END 
				)
FROM grade 

-- 查询没有成绩的学生信息
SELECT s.stuid,s.stuName,s.stuMajor
FROM student s
WHERE NOT EXISTS(SELECT 1 FROM grade g WHERE g.stuid = s.stuid);

-- 查询重复记录成绩的学生信息
SELECT s.stuid,s.stuName,COUNT(1) 'scoreCount'
FROM student s , grade g 
WHERE s.stuid = g.stuid 
GROUP BY s.stuid 
HAVING scoreCount >1;

-- 查询成绩从高到底的顺序按照科目分组列出学生基本信息
SELECT s.stuName,co.cid,co.cname,g.score
FROM student s, grade g ,course co 
WHERE s.stuid = g.stuid AND g.cid = co.cid 
ORDER BY co.cid,g.score DESC ;
