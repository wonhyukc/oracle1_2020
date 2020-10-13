-- NULLIF(값1, 값2)
-- 값1 == 값2 면 NULL을 리턴

SELECT NULLif ( 3, 3);
-- NULL
SELECT NULLif ( 3, 2);
-- 3
select nullif(컬럼, '무응답') from 테이블;

-- 참/ 거짓
-- 1 = 참, TRUE
-- 0 = 거짓, FALSE

-- ISNULL(값1) 
-- 값1이 NULL 이면 1, 아니면 0 을 리턴
SELECT isNull ( 3) ;
-- 0
SELECT isNull ( NULL );
-- 1
select isnull(컬럼)  from 테이블;

-- IF ( 조건, 참일때값, 거짓일때값)
SELECT IF( 5 < 3, '맞다', '틀리다') ;
SELECT IF( 1 < 3, '맞다', '틀리다')  as 결과;


-- ISNULL 과 IF 를 같이 사용하면
-- IF ( ISNULL(값),  널일때값, 널아닐때값)

SELECT IF(  ISNULL('가') , '무응답', '가');
SELECT IF(  ISNULL(null) , '무응답', '가');