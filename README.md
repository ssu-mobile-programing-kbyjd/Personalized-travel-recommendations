# Personalized-travel-recommendations

숭실대학교 미디어경영학과 모바일프로그래밍 팀 프로젝트

## 프로젝트 구조

```csharp

📂lib
├── 📂assets/                # 앱에서 사용하는 리소스(아이콘, 로고 등) 저장
│   ├── 📂icons/             # 아이콘 관련 폴더
│   │   ├── 📂Outline/       # 테마별 아웃라인 아이콘
│   │   └── 📂Solid/         # 테마별 솔리드 아이콘
│   └── 📂logos/             # 앱에서 사용하는 로고 이미지 저장
├── 📂theme/                 # 디자인 시스템 관련 파일
│   ├── 📄 app_colors.dart    # 앱의 색상 테마 정의
│   ├── 📄 app_icons.dart     # 아이콘 데이터 관리
│   ├── 📄 app_shadows.dart   # 그림자 스타일 관리 (DropShadow)
│   └── 📄 app_text_styles.dart # 텍스트 스타일 정의
├── 📂widget/                # 재사용 가능한 UI 컴포넌트
│   ├── 📄 custom_button.dart # 커스텀 버튼 컴포넌트
│   └── 📄 custom_card.dart   # 커스텀 카드 UI 컴포넌트
└── 📄 main.dart              # 앱의 진입점 (홈 화면)

```
