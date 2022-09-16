-- create database recipes;
-- use recipes;

-- -------------- 모든 테이블에 날짜형 넣기! --------------

create table member(
-- 회원테이블
	member_id varchar(20) not null primary key,
    member_pwd varchar(20) not null,
    member_name varchar(20) not null,
    member_email varchar(20) not null,
    member_gender varchar(4) not null,
    member_birth datetime(6) not null, -- 생일
    member_phone varchar(11) not null,
    member_joinDate datetime(6) not null,
    role varchar(10) not null -- 역할: 유저 / 관리자로 나뉨
);

-- 레시피 테이블 (레시피 등록 화면)
create table recipe(
	recipe_num int auto_increment primary key,
	recipe_title varchar(100) not null,
	recipe_introduce varchar(200),
	recipe_url varchar(40), -- 동영상 url
	recipe_rImagPath varchar(40), -- 대표 이미지 경로
	recipe_tag varchar(50),
	recipe_createDate datetime(6) not null,
	member_id varchar(20) not null,
    
    -- 레시피 카테고리
    category_kind varchar(20), -- 종류별
    category_theme varchar(20), -- 상황/테마별
    category_way varchar(20), -- 방법별
    category_ing varchar(20),  -- 재료별
    
    -- 레시피 요리정보
    information_person varchar(10), -- 인원
    information_time varchar(10), -- 시간
    information_level varchar(10), -- 난이도
    
    -- 레시피 요리완성 (이미지 4개)
    completion_imagePath1 varchar(40),
    completion_imagePath2 varchar(40),
    completion_imagePath3 varchar(40),
    completion_imagePath4 varchar(40),
    completion_tip varchar(200),
    
	foreign key(member_id) references member(member_id) -- member 테이블의 기본키인 member_id를 외래키로 삼음
);

-- 레시피 좋아요 테이블
create table recipe_like(
	member_id varchar(20),
    recipe_num int not null,
    l_like int,
    primary key(member_id, recipe_num), -- pk 복합키
	foreign key(member_id) references member(member_id),
    foreign key(recipe_num) references recipe(recipe_num)
);

-- 레시피 신고 테이블
create table recipe_report(
	member_id varchar(20),
    recipe_num int not null,
    l_report int,
    primary key(member_id, recipe_num), -- pk 복합키
    foreign key(member_id) references member(member_id),
    foreign key(recipe_num) references recipe(recipe_num)
);


create table recipe_ingredient(
-- 레시피 요리재료 테이블
	recipe_num int,
    ingredient_num int, -- 재료 번호 ex) 스테이크 소스 --> auto increment하면 다음 레시피의 번들의 번호가 1부터 시작하지 않음
    ingredient_bundle varchar(20),
    ingredient_bundle_ing varchar(20), -- 번들에 필요한 재료
    ingredient_bundle_amount varchar(20),
    primary key(recipe_num, ingredient_num),
    foreign key(recipe_num) references recipe(recipe_num)
);

create table recipe_order(
-- 레시피 요리순서 테이블
	recipe_num int,
    order_num int auto_increment,
    order_explain varchar(200),
    order_imagePath varchar(40),
    primary key(recipe_num, order_num),
    foreign key(recipe_num) references recipe(recipe_num)
);

-- 코멘트 테이블
create table comment(
	recipe_num int not null,
    comment_num int auto_increment primary key,
    comment_content varchar(255), -- 댓글 내용
    comment_imagePath varchar(40),
    
    member_id varchar(20) not null,
    comment_createDate datetime(6) not null,
    foreign key(member_id) references member(member_id),
    foreign key(recipe_num) references recipe(recipe_num)
);

-- 노하우 테이블
create table knowhow(
	knowhow_id int auto_increment primary key,
    member_id varchar(20) not null,
    knowhow_title varchar(100) not null,
    knowhow_content TEXT not null,
    knowhow_createDate datetime(6) not null,
    knowhow_imagePath varchar(40),
    foreign key(member_id) references member(member_id)
);

--  운영자 추천 레시피 테이블 (마이페이지)
create table recommendRecipe(
	recommend_num int auto_increment primary key,
    recommend_createDate datetime(6) not null,
    member_id varchar(20) not null,
    recipe_num int not null,
    foreign key(member_id) references member(member_id),
    foreign key(recipe_num) references member(recipe_num)
);

--  이벤트 테이블
create table recommendRecipe(
	event_num int auto_increment primary key,
    event_title varchar(100) not null,
    event_content TEXT,
    event_imagePath varchar(40),
    event_createDate datetime(6) not null,
    event_endDate datetime(6) not null,
    member_id varchar(20) not null,
    foreign key(member_id) references member(member_id)
);

-- 공지사항 테이블
create table notice(
	notice_num int auto_increment primary key,
    notice_title varchar(20) not null,
    notice_content TEXT,
    notice_createDate datetime(6) not null,
    member_id varchar(20) not null,
    foreign key(member_id) references member(member_id)
);