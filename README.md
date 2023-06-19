# Commit 규칙

### **Git Branch 사용법**

- 각자 생성한 브랜치에서만 작업합니다. (브랜치 생성은 Issue 사용법 참고)
- 브랜치 이름 구조는 <**본인이름_타입/#이슈번호**> 입니다. (ex. eugene_feat/#1)
- 작업이 끝나면 pull request를 통해 본인이 작업한 branch를 develop branch에 merge합니다.
- 코드 리뷰한 후 머지하기 (할 말 없으면 lgtm)

### **Git Issue 사용법**

- 작업할 기능에 대한 issue를 작성합니다.
- issue 제목은 **[타입] - 설명**으로 통일합니다. (ex. [Feat] - 바텀 네비게이션 구현)
- Assignees에는 작업을 맡은 사람을 태그합니다.
- Labels에는 해당 작업과 맞는 유형을 태그합니다.
- 설명란에는 어떤 작업을 할 예정인지, 관련된 이슈번호가 있는지 참고한 내용이 있는지 등 필요한 내용을 적습니다.
- 이렇게 issue를 생성하게 되면 #N의 이슈 번호가 생깁니다.

### **개인 작업하기**

- 기능 개발을 위해 작성한 이슈 번호를 사용하여 branch를 생성합니다. (ex. eugene_feat/#1 (git branch 사용법 참고))
- 작업 전에 develop branch를 반드시 pull하고 시작합니다. (git pull origin develop)
- commit은 컨벤션을 지켜 메세지를 적습니다.
- push은 해당 작업 branch에 합니다.
- pull request도 컨벤션을 지켜 생성합니다.
- 팀원들의 코드리뷰를 받았으면 merge 합니다.
- 꼭! 브랜치를 헷갈리지 않도록 합시다. 이슈번호 확인!

### **Pull Request 하기**

- 본인이 작업하던 branch를 develop branch로 merge 합니다.
- 절대 main으로 하지 않습니다!!
- base는 develop , compare는 본인 작업 브랜치 입니다!!
- PR제목은 **[타입] - 설명**으로 통일합니다.
- Reviewers에는 상대방을 태그합니다.
- Assignees에는 본인을 태그합니다.
- Labels에는 해당 작업과 맞는 유형을 태그합니다.
- 설명란에는 어떤 작업을 할 예정인지, 관련된 이슈번호가 있는지 참고한 내용이 있는지 등 필요한 내용을 적습니다.

### **PR 후 Merge 하기**

- 팀원들은 내용을 확인하고 코드리뷰 comment를 자유롭게 작성합니다.
- 모두의 comment를 받았으면 merge합니다.

### **Commit Convention**

### **commit type**

- Feat : 기능 구현
- Chore: 기능 변경 없는 코드 변경 사항
- Del : 코드 삭제
- Fix : 버그 수정
- Docs : 문서 수정
- Design : UI 추가 및 수정
- Refactor: 코드 리팩토링
- Test : 테스트 코드, 리팩토링 코드 추가
- Setting: 프로젝트 세팅

### **commit message**

- 모든 커밋 메세지 뒤에는 이슈번호를 태깅합니다.
- 커밋 메세지 영어로
- 모든 커밋 메세지는 { **[타입/#이슈번호] 메세지** } 로 작성합니다.
- ex) [Feat/#1] add splash screen

### **Projects 사용법**

- To do는 해야 할 일 = Issue
- In progress는 진행 중인 일 = PR
- Done은 끝난 일 = closed
- 이슈나 PR 상태를 open에서 closed로 변경하게 되면 Done으로 자동 이동됩니다.
- 프로젝트를 통해서 현재 개발 진행 상황을 쉽게 파악할 수 있습니다.
