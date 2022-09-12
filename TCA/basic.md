# TCA arcitecture Basic
<br/>

**State** : 말 그대로 데이터 상태 - 즉 Domain(문제 영역) 상태   
**Action** : Domain 액션   
- 검색이라면 검색어 입력, 검색어 삭제 등   
- 할일 이라면 할일 삭제, 할일 추가 등   
  
**Store** : 상태, 액션을 가지고 있음 - 커맨드 센터와 같은 역할이다.   
**Reducer** : 액션과 상태를 연결시켜주는 역할
- 들어온 액션에 따라 상태를 변화시켜주는 역할
<br>
## MVVM과의 차이
- MVVM은 따로 관리
- Redux 관련 패턴은
  - Store에서 종합적으로 관리
  - Action을 주면 State를 받는 식

