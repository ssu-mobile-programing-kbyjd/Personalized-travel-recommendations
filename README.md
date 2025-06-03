# TripBlock (Personalized Travel Recommendations)

숭실대학교 미디어경영학과 모바일프로그래밍 팀 프로젝트

---

## 📱 프로젝트 소개

이 프로젝트는 Flutter 기반의 여행 추천 앱입니다.

---

## 📂 폴더 구조

```plaintext
lib/
├── core/                # 앱 전역에서 사용하는 공통 코드 (유틸, 테마, 상수 등)
│   ├── constants/
│   ├── exceptions/
│   ├── network/
│   ├── theme/
│   └── utils/
├── data/                # 데이터 계층 (API, DB, 모델 등)
│   ├── datasources/
│   ├── models/
│   ├── repositories/
│   └── services/
├── domain/              # 비즈니스 로직 계층 (엔티티, 유즈케이스 등)
│   ├── entities/
│   ├── repositories/
│   └── usecases/
├── presentation/        # UI 계층 (화면, 위젯, 라우팅 등)
│   ├── pages/
│   │   ├── calendar/
│   │   ├── home/
│   │   ├── mypage/
│   │   └── main_screen.dart
│   ├── widgets/
│   └── routes/
├── l10n/                # 다국어 지원 리소스
├── main.dart            # 앱 진입점 (앱 실행만 담당)
└── app.dart             # 앱 설정(MaterialApp, 라우팅 등)
```

---

## 🏗️ 구조 변경 및 설계 이유

- **클린 아키텍처 적용**: core/data/domain/presentation으로 계층 분리하여 유지보수와 확장성 강화
- **공통 코드(core)**: 테마, 유틸, 상수 등 앱 전체에서 재사용되는 코드 분리
- **데이터 계층(data)**: 외부 데이터 소스와의 통신, 모델 정의 등 데이터 관련 코드 집중
- **비즈니스 로직(domain)**: 엔티티, 유즈케이스 등 핵심 로직 분리
- **UI 계층(presentation)**: 화면, 위젯, 라우팅 등 UI 관련 코드 집중
- **main.dart와 app.dart 분리**: main.dart는 앱 실행만, app.dart는 앱 설정 및 라우팅 담당

---

## ✨ 기여 및 문의

- 구조, 코드, 기능 관련 사항은 반드시 이슈 또는 PR로 남겨주세요.
