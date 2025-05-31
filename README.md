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
│   ├── 📄 custom_card.dart   # 커스텀 카드 UI 컴포넌트
│   ├── 📄 custom_divider.dart        # 디자인 시스템 기반 구분선 
│   ├── 📄 favorite_card.dart         # 찜한 아이템 카드 컴포넌트 (이미지, 타이틀, 평점 등 포함)
│   ├── 📄 feature_icon_button.dart   # 아이콘 + 텍스트 + 카운트로 구성된 기능 버튼 (예: 구매 상품, 찜한 목록)
│   ├── 📄 profile_header.dart        # 마이페이지 사용자 정보 헤더
│   ├── 📄 reusable_prompt_card.dart # 마이페이지(로그인전) 회원정보 남색 박스
│   ├── 📄 mypage_header.dart        # 마이페이지(로그인후)  회원정보 남색 박스
│   ├── 📄 section_title.dart         # 섹션 제목 위젯 (예: "찜한 목록" 타이틀)
│   ├── 📄 settings_list_item.dart    # 아이콘 + 텍스트 + > 화살표로 구성된 설정 메뉴 항목 (예: 공지사항, 고객센터)
│   ├── 📄 tab_bar_selector.dart      # 커스텀 탭바 위젯 (선택 탭 표시 및 탭 전환)
│   ├── 📄 tag_chip.dart              # 해시태그 형태의 태그 컴포넌트 (ex: #혼자여행)
└── 📄 main.dart              # 앱의 진입점 (홈 화면)

```
