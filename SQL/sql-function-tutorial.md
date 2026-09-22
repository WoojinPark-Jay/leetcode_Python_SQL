# SQL Stored Function 정리

면접 준비하면서 MySQL 함수(Stored Function) 만들 때 자꾸 헷갈리는 부분들 정리함. `DECLARE`/`SET` 규칙, `OFFSET` 개념, 그리고 관련 문제 몇 개 + 더 나은 코드까지.

## 1. Stored Function이 뭔지

자주 쓰는 계산 로직을 이름 붙여서 저장해두고, `MAX()`, `COUNT()` 같은 내장 함수처럼 `SELECT` 안에서 불러 쓰는 것. 한 번 만들어두면 매번 복잡한 서브쿼리 새로 안 써도 됨.

## 2. 기본 뼈대

```sql
CREATE FUNCTION 함수이름(파라미터명 타입)
RETURNS 반환타입
BEGIN
    DECLARE 변수이름 타입;   -- 필요할 때만
    SET 변수이름 = 값;        -- 필요할 때만
    RETURN 결과;
END
```

## 3. 꼭 지켜야 하는 규칙들

### 규칙 1 — 대입은 `=`로

```sql
SET M = N - 1;   -- 맞음
SET M - N - 1;   -- 틀림, 이거 대입 아니고 뺄셈으로 오해됨
```

`-`랑 `=` 헷갈리면 함수 자체가 안 만들어짐. 실제로 한 번 이걸로 삽질함.

### 규칙 2 — `DECLARE`는 변수 필요할 때만

계산 중간값 저장해서 재사용해야 하면 `DECLARE` 필요하고, 고정된 숫자만 쓰는 거면 아예 안 써도 됨. `getSecondHighestSalary()`처럼 "2번째"가 고정값이면 변수 자체가 필요 없어서 DECLARE 없이 바로 감.

### 규칙 3 — 결과 없을 수 있는 서브쿼리는 한 번 더 감싸기

```sql
RETURN (
    SELECT (
        SELECT ... LIMIT 1 OFFSET M
    ) AS Result
);
```

안쪽 서브쿼리가 0개 반환해도, 바깥 SELECT가 그거 안전하게 `NULL`로 받아줌. 이거 안 감싸면 DB 따라 에러날 수 있어서 거의 관용구처럼 외워두기.

### 규칙 4 — `OFFSET`은 몇 개 건너뛸지, 0부터 셈

- OFFSET 0 → 안 건너뜀 → 1번째(최고값)
- OFFSET 1 → 1개 건너뜀 → 2번째
- OFFSET (N-1) → N번째

**중요**: OFFSET 필수 아님. 1번째(최고/최저)만 필요하면 그냥 `LIMIT 1`이나 `MAX()` 쓰면 됨. OFFSET은 "중간 순위"를 짚어야 할 때만 등장하는 옵션.

```sql
-- OFFSET 필요 없는 경우 (더 흔함)
SELECT DISTINCT salary FROM Employee ORDER BY salary DESC LIMIT 1;   -- 1등만
SELECT MAX(salary) FROM Employee;                                     -- 이것도 동일

-- OFFSET 필요한 경우 (2등, 3등, N등처럼 중간 짚을 때만)
SELECT DISTINCT salary FROM Employee ORDER BY salary DESC LIMIT 1 OFFSET 1;  -- 2등
```

### 규칙 5 — 조건문은 `IF ... THEN ... ELSE ... END IF;`로 반드시 닫기

```sql
IF N <= 0 THEN
    RETURN NULL;
ELSE
    ...
END IF;
```

## 4. 함수 호출 방법

```sql
SELECT 함수이름();          -- 파라미터 없는 함수
SELECT 함수이름(3);         -- 파라미터 있는 함수
SELECT name FROM Employee WHERE salary = 함수이름();  -- 다른 쿼리 안에서도 사용
```

로컬 MySQL에서 직접 실습할 때는 `BEGIN...END` 안에 세미콜론 있어서 구분자 잠깐 바꿔줘야 함:

```sql
DELIMITER $$

CREATE FUNCTION getSecondHighestSalary() RETURNS INT
BEGIN
    RETURN (
        SELECT (
            SELECT DISTINCT salary
            FROM Employee
            ORDER BY salary DESC
            LIMIT 1 OFFSET 1
        ) AS SecondHighestSalary
    );
END$$

DELIMITER ;

SELECT getSecondHighestSalary();
```

LeetCode 제출할 때는 이거 자동 처리해줘서 신경 안 써도 됨.

---

## 연습 문제 + 더 나은 코드

### 문제 1. N번째로 높은 연봉 구하기

`Employee(id, salary)` 테이블에서 정수 N 받아서 N번째로 높은 연봉 반환. 없으면 NULL.

**처음 짠 코드**: N이 0이거나 음수일 때 처리 안 해서 방어 로직 추가함.

```sql
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
    DECLARE M INT;
    SET M = N - 1;

    IF N <= 0 THEN
        RETURN NULL;
    END IF;

    RETURN (
        SELECT (
            SELECT DISTINCT salary
            FROM Employee
            ORDER BY salary DESC
            LIMIT 1 OFFSET M
        ) AS Result
    );
END
```

### 문제 2. 두 번째로 높은 연봉 구하기

`Employee(id, salary)`에서 파라미터 없이 두 번째로 높은 연봉 반환하는 함수.

**더 나은 코드**: 문제 1에서 만든 범용 함수 재사용하면 코드 짧아지고 유지보수 편함. "N번째 연봉 로직"이 한 곳에만 존재해서 나중에 수정할 때 한 함수만 고치면 됨.

```sql
CREATE FUNCTION getSecondHighestSalary() RETURNS INT
BEGIN
    RETURN getNthHighestSalary(2);
END
```

### 문제 3. 부서별 최고 연봉자 이름 조회

`Employee(id, name, salary, departmentId)`에서 부서별 최고 연봉자 이름/부서/연봉 조회.

**서브쿼리 방식** (동점자 다 나오지만, 부서 많으면 매 행마다 서브쿼리 재실행돼서 느릴 수 있음):

```sql
SELECT e.name, e.departmentId, e.salary
FROM Employee e
WHERE e.salary = (
    SELECT MAX(salary)
    FROM Employee
    WHERE departmentId = e.departmentId
);
```

**더 나은 코드**: `RANK()` 윈도우 함수 쓰면 더 명확하고 효율적. 동점자 처리도 동일하게 보장됨.

```sql
SELECT name, departmentId, salary
FROM (
    SELECT
        name,
        departmentId,
        salary,
        RANK() OVER (PARTITION BY departmentId ORDER BY salary DESC) AS rnk
    FROM Employee
) ranked
WHERE rnk = 1;
```

`PARTITION BY departmentId`는 부서별로 나눠서 순위 매기라는 뜻, `RANK() ... ORDER BY salary DESC`는 그 부서 안에서 연봉 높은 순으로 순위 매김.

---

## 검증 결과

연봉 데이터 (2000, 3000, 4000, 4500, 5000, 5000)로 `getNthHighestSalary` 로직 검증:

| N | 결과 |
|---|---|
| 1 | 5000 |
| 2 | 4500 |
| 3 | 4000 |
| 4 | 3000 |
| 5 | 2000 |
| 10 | NULL (해당 연봉 없음) |
| 0 | NULL (방어 로직 작동) |
| -1 | NULL (방어 로직 작동) |

N=0, N=-1에서 NULL 나오는 거 확인함 — `IF N <= 0 THEN RETURN NULL; END IF;` 방어 로직 실제로 작동. 원래 코드(방어 로직 없음)였으면 N=0일 때 `OFFSET -1`돼서 에러났을 부분.
