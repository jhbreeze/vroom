# :pushpin: vroom
>KTX, 고속버스 통합 예매시스템


</br>

## 1. 제작 기간 & 참여 인원
- 2022.10.14 ~ 2022.11.4
- 팀 프로젝트(5명)

</br>

## 2. 사용 기술
#### 
  - JAVA 1.8
  - Servlet & JSP
  - Javascript
  - jQuery, AJAX  
  - HTML5, CSS
  - Oracle 18C
  - Bootstrap 5.2
  - Apache Tomcat 9.0

</br>

## 3. ERD 설계
<img src="https://user-images.githubusercontent.com/103633968/216342886-8b18cd08-e562-4223-9110-f190e2a9fe00.png" width="800" height="400"/>


## 4. 핵심 기능
✔️ 가상으로 KTX, 고속버스 좌석을 <b>예매하고 결제, 조회</b>까지 가능하도록 구현했습니다.

<img src="https://user-images.githubusercontent.com/103633968/216350959-fcd735a8-5678-4f9d-897e-51c10fecb322.jpg" width="900" height="500"/>

<details>
<summary><b>프로젝트 구조</b></summary>
<div markdown="1"> 

### 4.1. Class Diagram
<img src="https://user-images.githubusercontent.com/103633968/216351491-c602a447-e035-4c9a-92ab-1fbf56a12bdf.jpg" width="900" height="500"/>

### 4.2. Use-Cases Diagram
<img src="https://user-images.githubusercontent.com/103633968/216351729-8108dc1d-2072-43cd-9ab2-dc64322a8694.jpg" width="900" height="500"/>

</div>
</details>

</br>

## 5. 프로젝트 담당 부분
#### 
  - 전체 템플릿 디자인, 스토리보드 설계, 데이터베이스 모델링<br>
  - 요구사항 분석<br>
  - 로그인, 로그아웃, 회원가입 기능 구현<br>
  - 회원, 비회원 session 처리 <br>
  - 마이페이지(정보 수정, 회원 탈퇴) <br>
  - 예매 취소 기능 구현 <br>
  - API를 활용한 카카오페이 결제 기능 구현 <br>

<details>
<summary><b>주요 개발내용</b></summary>
<div markdown="1">
  <br>
  
  ✔️<b>로그인&마이페이지</b>
  
    - DB에 저장된 정보와 입력받은 정보를 비교하여 로그인 처리를 합니다.
    - 로그인 성공 시, 세션에 접속한 클라어언트의 정보를 저장합니다.
    - 세션은 최대 1시간 유지되며, 작동이 없을 시 자동 로그아웃을 하여 보안을 강화했습니다.
<img src="https://user-images.githubusercontent.com/103633968/216352709-e4c24073-951f-4eec-9547-c07c60ec797d.png" width="900" height="500"/>
  
  ✔️<b>회원가입</b>
    
    - 회원 정보 입력 칸은 모두 정규 표현식을 활용하여 유효성 검사를 합니다. 
    - 아이디 중복검사를 통해 회원 정보 데이터 무결성을 유지했습니다. 
  
<img src="https://user-images.githubusercontent.com/103633968/216352364-3b136524-735a-4518-94e9-9553a17f7f12.png" width="900" height="500"/>

  ✔️<b>예매 취소</b>
  
<img src="https://user-images.githubusercontent.com/103633968/216353512-517d4253-bc92-4bc3-8b39-142e41768f99.png" width="900" height="500"/>
  
  ✔️<b>결제</b>
  
    - API를 활용하여 (가상으로) 카카오페이 결제가 가능합니다.

<img src="https://user-images.githubusercontent.com/103633968/216350110-dc6ba2e0-24ac-4f1b-9b42-28dc9847d573.png" width="900" height="500"/>
  
  ✔️<b>회원정보 조회</b>
  
    - 검색 조건 설정과 페이징 처리를 통해 쉽게 회원 정보를 파악할 수 있습니다.
  
<img src="https://user-images.githubusercontent.com/103633968/216362681-376292bd-8a25-4976-969a-3f2c2915eb05.png" width="900" height="500"/>

</div>
</details>

