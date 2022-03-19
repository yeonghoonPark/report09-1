-- --------------------------------------------------------------------
--                            2 번
-- --------------------------------------------------------------------
-- 영화정보 DB정의 및 DB관리자 생성, 권한 설정
DROP DATABASE IF EXISTS 영화정보_db;
CREATE DATABASE 영화정보_db;
DROP USER IF EXISTS movie_info@localhost;
CREATE USER movie_info@localhost IDENTIFIED WITH mysql_native_password BY 'qwer1234!';
GRANT ALL PRIVILEGES ON 영화정보_db.* TO movie_info@localhost WITH GRANT OPTION;
SHOW DATABASES;
USE 영화정보_db;

-- 장르 TABLE 생성
CREATE TABLE 장르(
	장르코드 VARCHAR(10) NOT NULL,
    장르명 VARCHAR(45) NOT NULL,
    PRIMARY KEY (장르코드)
);

-- 감독 TABLE 생성
CREATE TABLE 감독(
	등록번호 VARCHAR(10) NOT NULL,
    이름 VARCHAR(45) NOT NULL,
    성별 ENUM('남','여') NOT NULL,
    출생일 VARCHAR(45) NOT NULL,
    출생지 VARCHAR(45) NOT NULL,
    학력사항 VARCHAR(45),
    PRIMARY KEY (등록번호)
);

-- 배우 TABLE 생성
CREATE TABLE 배우(
	주민번호 VARCHAR(14) NOT NULL,
    이름 VARCHAR(45) NOT NULL,
    성별 ENUM('남','여') NOT NULL,
    출생일 VARCHAR(45) NOT NULL,
    출생지 VARCHAR(45) NOT NULL,
    키 VARCHAR(45) NOT NULL,
    몸무게 VARCHAR(45) NOT NULL,
    혈액형 ENUM('A', 'B', 'AB', 'O'),
    PRIMARY KEY (주민번호)
);

-- 영화 TABLE 생성
CREATE TABLE 영화(
	영화코드 VARCHAR(10) NOT NULL,
    장르_장르코드 VARCHAR(10) NOT NULL,
    제목 VARCHAR(45) NOT NULL,
    제작년도 VARCHAR(45) NOT NULL,
    상영시간 VARCHAR(45) NOT NULL,
    개봉일자 VARCHAR(45) NOT NULL,
    제작사 VARCHAR(45) NOT NULL,
    배급사 VARCHAR(45) NOT NULL,
    PRIMARY KEY (영화코드),
    CONSTRAINT fk_장르_장르코드 FOREIGN KEY (장르_장르코드) REFERENCES 장르(장르코드) ON UPDATE CASCADE ON DELETE CASCADE
);

-- 감독_has_영화 TABLE 생성
CREATE TABLE 감독_has_영화(
	감독_등록번호 VARCHAR(10) NOT NULL,
    영화_영화코드 VARCHAR(10) NOT NULL,
    PRIMARY KEY (감독_등록번호, 영화_영화코드),
    CONSTRAINT fk_감독_등록번호 FOREIGN KEY (감독_등록번호) REFERENCES 감독(등록번호) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT fk_영화_영화코드a FOREIGN KEY (영화_영화코드) REFERENCES 영화(영화코드) ON UPDATE CASCADE ON DELETE CASCADE 
);

-- 영화_has_배우 TABLE 생성
CREATE TABLE 영화_has_배우(
	영화_영화코드 VARCHAR(10) NOT NULL,
    배우_주민번호 VARCHAR(14) NOT NULL,
    PRIMARY KEY (영화_영화코드, 배우_주민번호),
    CONSTRAINT fk_영화_영화코드b FOREIGN KEY (영화_영화코드) REFERENCES 영화(영화코드) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT fk_배우_주민번호 FOREIGN KEY (배우_주민번호) REFERENCES 배우(주민번호) ON UPDATE CASCADE ON DELETE CASCADE 
);

SHOW TABLES;

-- --------------------------------------------------------------------
--                            3 번
-- --------------------------------------------------------------------
DESC 장르;
INSERT INTO 장르 VALUES ('101', '액션');
INSERT INTO 장르 VALUES ('102', 'SF');
INSERT INTO 장르 VALUES ('103', '누와르');
INSERT INTO 장르 VALUES ('104', '스릴러');
INSERT INTO 장르 VALUES ('105', 'Romantic comedy');
INSERT INTO 장르 VALUES ('106', '포르노');
SELECT * FROM 장르;

DESC 감독;
INSERT INTO 감독 VALUES ('2001', '스티븐 스필버그', '남', '1946년 12월 18일', '미국 오하이오 신시내티', 'Brookdale Community College');
INSERT INTO 감독 VALUES ('2002', '크리스토퍼 놀란', '남', '1970년 7월 30일', '영국 런던 웨스트민스터', 'University College London');
INSERT INTO 감독 VALUES ('2003', '박찬욱', '남', '1963년 8월 23일', '대한민국 서울특별시', '서강대학교');
INSERT INTO 감독 VALUES ('2004', '봉준호', '남', '1969년 9월 14일', '대한민국 대구광역시', '연세대학교');
INSERT INTO 감독 VALUES ('2005', '정인엽', '남', '1936년 9월 16일', '대한민국 부산광역시', NULL);
SELECT * FROM 감독;  

DESC 배우;
INSERT INTO 배우 VALUES ('620703-1000001', '탐 크루즈', '남', '1962년 7월 3일', '미국 뉴욕 시러큐스', '170cm', '73kg', 'O');
INSERT INTO 배우 VALUES ('620503-1000002', '최민식', '남', '1962년 5월 3일', '대한민국 서울특별시', '177cm', '83kg', 'B');
INSERT INTO 배우 VALUES ('670117-1000003', '송강호', '남', '1967년 11월 17일', '대한민국 김해시', '180cm', '79kg', 'B');
INSERT INTO 배우 VALUES ('660909-1000004', '애덤 샌들러', '남', '1966년 9월 9일', '미국 뉴욕 브루클린', '177cm', '86kg', 'AB');
INSERT INTO 배우 VALUES ('940223-2000001', '다코타 패닝', '여', '1994년 9월 23일', '미국 조지아 코니어스', '163cm', '47kg', 'AB');
INSERT INTO 배우 VALUES ('601105-2000002', '틸다 스윈튼', '여', '1960년 11월 5일', '영국 런던', '180cm', '65kg', 'AB');
INSERT INTO 배우 VALUES ('810210-2000003', '강혜정', '여', '1981년 2월 10일', '대한민국 서울특별시', '163cm', '48kg', 'A');
INSERT INTO 배우 VALUES ('750224-2000004', '드류 베리모어', '여', '1975년 2월 24일', '미국 캘리포니아 컬버시티', '163cm', '52kg', 'A');
SELECT * FROM 배우;

DESC 영화;
INSERT INTO 영화 VALUES ('300001', '102', '우주전쟁', '2005', '01:56:24', '2005-6-23', '파라마운트 픽쳐스', '앰블린 엔터테인먼트');
INSERT INTO 영화 VALUES ('300002', '101', '배트맨 다크나이트', '2008', '02:32:18', '2008-08-06', '워너 브라더스', '워너 브라더스');
INSERT INTO 영화 VALUES ('300003', '103', '올드보이', '2003', '02:01:59', '2003-11-21', '(주)에그필름', 'CJ 엔터테인먼트');
INSERT INTO 영화 VALUES ('300004', '106', '애마부인', '1982', '01:05:38', '1982-02-06', '연방영화(주)', '서울극장');
INSERT INTO 영화 VALUES ('300005', '101', '설국열차', '2013', '02:05:40', '2013-08-01', '모호필름', 'CJ 엔터테인먼트');
INSERT INTO 영화 VALUES ('300006', '101', '히트맨', '2020', '01:50:22', '2020-01-22', '베리굿 스튜디오(주)', '롯데 엔터테인먼트' );
INSERT INTO 영화 VALUES ('300007', '104', '반도', '2020', '01:55:31', '2020-07-15', '레드피터', '넥스트 엔터테인먼트 월드');
INSERT INTO 영화 VALUES ('300008', '105', '첫 키스만 50번째', '2004', '01:33:28', '2004-02-14', '해미 메디슨 프로덕션스', '콜롬비아 픽처스');
SELECT * FROM 영화;

DESC 감독_has_영화;
INSERT INTO 감독_has_영화 VALUES ('2002', '300001');
INSERT INTO 감독_has_영화 VALUES ('2001', '300002');
INSERT INTO 감독_has_영화 VALUES ('2003', '300003');
INSERT INTO 감독_has_영화 VALUES ('2005', '300004');
SELECT * FROM 감독_has_영화;

DESC 영화_has_배우;
INSERT INTO 영화_has_배우 VALUES('300001', '620703-1000001');
INSERT INTO 영화_has_배우 VALUES('300001', '940223-2000001');
INSERT INTO 영화_has_배우 VALUES('300003', '620503-1000002');
INSERT INTO 영화_has_배우 VALUES('300003', '810210-2000003');
INSERT INTO 영화_has_배우 VALUES('300005', '601105-2000002');
INSERT INTO 영화_has_배우 VALUES('300005', '670117-1000003');
INSERT INTO 영화_has_배우 VALUES('300008', '660909-1000004');
INSERT INTO 영화_has_배우 VALUES('300008', '750224-2000004');
SELECT * FROM 영화_has_배우;

-- --------------------------------------------------------------------
--                            4 번
-- --------------------------------------------------------------------
 SELECT 장르.장르명 AS 장르 , CONCAT(COUNT(*),' 편') AS 제작편수
 FROM 장르 JOIN 영화 ON 장르.장르코드=영화.장르_장르코드
 WHERE 영화.제작년도='2020'
 GROUP BY 장르.장르코드;
 
 
-- --------------------------------------------------------------------
--                            5 번
-- --------------------------------------------------------------------
SELECT 배우.이름
FROM 배우 JOIN 영화_has_배우 ON 배우.주민번호=영화_has_배우.배우_주민번호 JOIN 영화 ON 영화.영화코드=영화_has_배우.영화_영화코드
WHERE 영화.영화코드<>'300008';

-- --------------------------------------------------------------------
--                            6 번
-- --------------------------------------------------------------------
SELECT * FROM 장르;
SELECT * FROM 영화;

UPDATE 장르 SET 장르코드='000111', 장르명='로맨틱 코미디' WHERE 장르코드='105';

SELECT * FROM 장르;
SELECT * FROM 영화;

-- --------------------------------------------------------------------
--                            7 번
-- --------------------------------------------------------------------
SELECT * FROM 장르;
SELECT * FROM 영화;
SELECT * FROM 감독_has_영화;

DELETE FROM 장르 WHERE 장르명='포르노';
DELETE FROM 영화 WHERE 영화.장르_장르코드='106';
DELETE FROM 감독_has_영화 WHERE 감독_has_영화.영화_영화코드='300004';

SELECT * FROM 장르;
SELECT * FROM 영화;
SELECT * FROM 감독_has_영화;