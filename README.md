# iOS 계산기 앱

## 주요 기능

- 기본 산술 연산 (+, -, ×, ÷)
- 초기화 기능 (AC)
- 반응형 UI
- 버튼 피드백
- 음수 지원

<br/>
<br/>

## 사용 기술

- Swift
- UIKit
- SnapKit (Auto Layout 구현)
- Then (깔끔한 초기화 구문을 위한 라이브러리)

<br/>
<br/>

## 주요 형태

### 뷰 레이어
- `CalculatorViewController`: UI와 사용자 상호작용을 처리하는 메인 뷰 컨트롤러
- `CalculatorButton`: 계산기 버튼을 위한 커스텀 UIButton 서브클래스
- `UIStyle`: UI 상수와 측정값을 관리하는 구조체

### 모델 레이어
- `CalculatorModel`: 핵심 계산 로직과 상태 관리
- `CalculatorOperator`: 수학 연산을 정의하는 열거형
- `State`: 계산기 상태를 관리하는 열거형

### 오류 처리
- `CalculatorInputErrorHandler`: 사용자 입력 유효성 검사
- `CalculatorInputError`: 입력 관련 오류 정의
- `CalculateError`: 계산 관련 오류 정의

<br/>
<br/>

## 주요 기능 구현

### UI
- 화면 크기에 따른 버튼 크기
- 버튼 터치 피드백

### 오류 처리
- 0으로 나누기
- 잘못된 입력
- 숫자 오버플로우/언더플로우
- 알 수 없는 계산 오류


<br/>
<br/>

## 사용 방법

### 기본 연산
1. 숫자 패드를 사용하여 숫자 입력 (음수를 위해 첫 글자는 -를 입력할 수 있습니다.)
2. 연산자 선택 (+, -, ×, ÷)
3. = 버튼을 눌러 결과 확인
4. AC 버튼을 눌러 초기화

### 오류 메시지
- "0으로 나눔"
- "연산 실패"
- "범위 초과"
- "알 수 없는 에러"

## 요구사항

- iOS 13.0 이상
- Xcode 12.0 이상
- Swift 5.0 이상

## 의존성

- SnapKit: 프로그래매틱 Auto Layout 구현
- Then: 깔끔한 초기화 구문 작성
