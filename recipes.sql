use dorecipe;

create table member( -- 회원테이블
    member_id varchar(20) not null primary key,
    member_pwd varchar(20) not null,
    member_name varchar(20) not null,
    member_email varchar(40) not null unique,
    member_gender varchar(4) not null,
    member_birth datetime(6) not null ,
    member_phone varchar(11) not null,
    member_imagePath varchar(200),
    member_joinDate datetime(6) not null,
    member_role varchar(10) not null -- 이용자 역할 : admin & user
);

create table recipe(  -- 레시피테이블
    recipe_num int auto_increment  primary key , -- 1 :레시피 번호 
    recipe_title varchar(100) not null,   -- 2: 레시피 제목
    recipe_savetype int, -- 3: 저장 타입 (저장 :0, 임시저장 : 1) 
    recipe_introduce varchar(1000), -- 4:레시피 소개
    recipe_url varchar(40), -- 5: 이미지 영상 url
    recipe_rpath varchar(200),   -- 6: 대표이미지 경로
    category_kind varchar(20) default '종류',   -- 8: 레시피 종류
    category_theme varchar(20) default '테마', -- 9 : 레시피 테마
    category_way varchar(20)  default '방법', -- 10 : 레시피 방법 
    category_ing varchar(20) default '재료', -- 11 : 레시피 재료
    information_person varchar(10) default '인원', -- 12 : 요리 정보 (인원)
    information_time varchar(10)  default '시간', -- 13: 요리 정보 (시간)
    information_level varchar(10) default '난이도', -- 14: 요리 정보 (난이도)
    completion_path1 varchar(200), -- 15: 완성 사진 경로1
    completion_path2 varchar(200), -- 16: 완성 사진 경로2
    completion_path3 varchar(200), -- 17: 완성 사진 경로3
    completion_path4 varchar(200), -- 18: 완성 사진 경로4
    completion_tip varchar(200), -- 19: 레시피 팁(요령)
    recipe_creDate datetime(6) not null, -- 20: 레시피 팁(요령)
    member_id varchar(20) not null, -- 21: 멤버 아이디 (fk)
    foreign key (member_id) 
    references member(member_id)
    -- 자동 변경/삭제
      ON UPDATE CASCADE
      ON DELETE CASCADE
);

create table r_like( -- 레시피좋아요테이블
   member_id varchar(20),
    recipe_num int not null,
    likes int,
    primary key(member_id,recipe_num),                
    foreign key (member_id) references member(member_id)
      ON UPDATE CASCADE
      ON DELETE CASCADE, 
    foreign key (recipe_num) references recipe(recipe_num)
      ON UPDATE CASCADE
      ON DELETE CASCADE
);

create table r_ingredient( -- 재료테이블
   recipe_num int,
    ing_num int,
    ing_ingredient varchar(40),
    ing_amount varchar(40),   
    primary key(recipe_num,ing_num),               
    foreign key (recipe_num) references recipe(recipe_num)
   ON UPDATE CASCADE
    ON DELETE CASCADE
);

create table r_order( -- 레시피요리순서테이블
   recipe_num int, -- 레시피 번호
    order_num int, -- 순서 번호 
    order_explain varchar(500), -- 설명
    order_path varchar(200), -- 이미지 경로
    primary key(recipe_num,order_num),                         
    foreign key (recipe_num) references recipe(recipe_num)
      ON UPDATE CASCADE
      ON DELETE CASCADE
);

create table comment( -- 코멘트테이블
   recipe_num int,
    comment_num int,
    comment_content varchar(255) not null,
    comment_path varchar(200),
    member_id varchar(20) not null,
    comment_creDate datetime(6) not null,
    primary key(recipe_num,comment_num),
    foreign key (member_id) references member(member_id)
       ON UPDATE CASCADE
    ON DELETE CASCADE
    ,
    foreign key (recipe_num) references recipe(recipe_num)
       ON UPDATE CASCADE
    ON DELETE CASCADE
);

create table knowhow(  -- 노하우테이블
   know_num int auto_increment primary key,
    member_id varchar(20) not null,
    know_title varchar(100) not null,
    know_content TEXT not null,
    know_creDate date not null,
    know_path varchar(200),
    foreign key (member_id) references member(member_id) 
       ON UPDATE CASCADE
    ON DELETE CASCADE
);

create table recommendrecipe( -- 운영자추천레시피테이블
   member_id varchar(20) not null,
   recipe_num int not null,
    reco_num int auto_increment primary key,
    reco_creDate date not null,
    foreign key (recipe_num) references recipe(recipe_num)
       ON UPDATE CASCADE
      ON DELETE CASCADE, 
    foreign key (member_id) references member(member_id)
       ON UPDATE CASCADE
      ON DELETE CASCADE
);

create table event( -- 이벤트테이블
   event_num int auto_increment primary key,
    member_id varchar(20) not null,
   event_title varchar(100) not null,
    event_content TEXT not null,
    event_path varchar(200),
    event_creDate date not null,
    event_finDate date not null,
    foreign key (member_id) references member(member_id) 
       ON UPDATE CASCADE
      ON DELETE CASCADE
);

create table notice( -- 공지사항테이블
   notice_num int auto_increment primary key,
    member_id varchar(20) not null,
    notice_title varchar(100) not null,
    notice_content TEXT not null,
    notice_creDate date not null,
    foreign key (member_id) references member(member_id) 
       ON UPDATE CASCADE
      ON DELETE CASCADE
);
