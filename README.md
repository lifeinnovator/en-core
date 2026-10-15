# En·Core 랜딩페이지 — 배포 안내

## 현재 프로젝트 (2026-10-15 확인)

- 기획·개발: **Life Innovation Lab**, 생애설계 교육 프로그램 **En·Core(인코어)**.
- 현재 사이트 안내 기준(2026-10-15 사용자 수정 지시): **프로그램이 준비되어 있으며 기관 요청에 따라 운영 가능**. 교육 구성과 일정은 대상·목적에 맞춰 안내합니다. 이전의 개발 중·시범 운영 안내는 본문과 메타데이터에서 제거했습니다.
- 운영 주소: https://en-core-gold.vercel.app/
- 원본 저장소: https://github.com/lifeinnovator/en-core (`main`).
- 구성: HTML 2개 + 정적 이미지. 페이지 CSS·JavaScript는 HTML 내부에, 공통 로고 스타일·이미지는 `assets/brand/`에 있으며 패키지 설치나 빌드가 필요 없습니다.
- 배포: GitHub 커밋의 Vercel 상태에서 연결 프로젝트 `lifeinnovators-projects/en-core` 확인. 배포 후에는 반드시 운영 주소에서 내용을 검증합니다.
- 상세 점검·업데이트 배경·미확인 항목: [docs/2026-10-14-update.md](docs/2026-10-14-update.md).

### 브랜드 선택 (2026-10-15)

Life Innovation Lab은 Type 1, En·Core는 클래식 세리프 시안 1을 잠정 적용했습니다. 두 페이지의 브랜드 자산은 `assets/brand/`에 있으며 [브랜드 적용 기록](docs/2026-10-15-branding.md)에 원본과 표시 방법을 기록했습니다.

### 여기에서 수정하고 확인하기

`index.html`은 소개와 교육과정, `contact.html`은 문의 폼입니다. 문의 폼은 기존 FormSubmit 이메일 전송을 사용하며 별도 DB는 없습니다. `contact.html?program=C-1`처럼 연결하면 해당 과정이 선택됩니다.

```powershell
python -m http.server 8765 --bind 127.0.0.1
```

브라우저에서 `http://127.0.0.1:8765/` 확인. 데스크톱·모바일, 과정별 문의 연결, 필수 입력 검사를 확인하고 `git diff --check`를 실행합니다. 실제 문의 전송은 이메일 발송을 수반하므로 별도 테스트로 진행합니다.

수정은 작업 브랜치에서 검증 후 `main`에 반영합니다. 문제 발생 시 해당 변경 커밋을 revert하고 재배포를 검증합니다. 새로운 프레임워크나 빌드 시스템을 도입할 필요는 없습니다.

아래는 최초 구축 당시의 배포 안내입니다. 저장소와 프로젝트는 이미 생성되어 있으므로 현재 수정 작업에서 다시 만들지 않습니다.

## 폴더에 든 파일

| 파일 | 역할 | 이름 바꾸지 말 것 |
|---|---|---|
| `index.html` | 랜딩페이지 본체 (1뎁스) | ⚠️ 필수 |
| `contact.html` | 교육 문의 페이지 (2뎁스) | ⚠️ 필수 |
| `favicon.svg` | 브라우저 탭 아이콘 (기본) | ⚠️ 필수 |
| `favicon-32.png` | 탭 아이콘 (구형 브라우저용) | ⚠️ 필수 |
| `apple-touch-icon.png` | 아이폰 홈 화면 아이콘 | ⚠️ 필수 |
| `icon-512.png` | 고해상도 아이콘 (여분, 안 써도 무방) | |
| `og-image.png` | 카카오톡·SNS 공유 미리보기 이미지 | ⚠️ 필수 |
| `robots.txt` | 검색엔진 수집 허용 | |
| `sitemap.xml` | 검색엔진용 페이지 목록 | |

## 페이지 구조

```
index.html   (홈)
  └─ 하단 "교육 문의하기" 버튼 클릭
       ↓
contact.html (문의 폼, 2뎁스)
  └─ 상단 "← 처음으로" 링크로 복귀
```

문의 폼은 `contact.html`에만 있습니다.
홈의 상단 메뉴 "교육 문의", 하단 "교육 문의하기" 버튼,
푸터 "문의" 링크가 모두 이 페이지로 연결됩니다.

---

## 1단계 · GitHub에 올리기

1. [github.com](https://github.com) 가입 후 로그인
2. 우측 상단 **`+` → New repository**
3. 설정
   - Repository name: `en-core` (원하는 이름)
   - **Public** 선택
   - **Add README: Off** (이 폴더의 README.md와 이름이 겹칩니다)
   - 나머지는 그대로 두고 **Create repository**
4. 만들어진 화면에서 **uploading an existing file** 클릭
5. **이 폴더 안의 파일 전부**(9개)를 끌어다 놓기
6. 아래 **Commit changes** 클릭

> 폴더째로 올리지 말고, **파일들만** 올려야 합니다.
> `index.html`이 최상위에 있어야 주소가 깔끔합니다.

---

## 2단계 · Vercel로 배포하기

1. [vercel.com](https://vercel.com) 접속 → **Continue with GitHub** 로 가입
2. **Add New... → Project**
3. 방금 만든 `en-core` 저장소 옆 **Import**
4. 설정 화면이 나오면 **아무것도 건드리지 말고** **Deploy**
5. 1분 정도 뒤 주소가 나옵니다 → `https://en-core-xxxx.vercel.app`

---

## 3단계 · 주소를 파일에 반영하기 ⚠️ 중요

배포 주소가 정해지면 **`index.html`과 `contact.html` 두 파일 모두에서**
아래 주소를 찾아 바꿔야 카카오톡 공유 미리보기가 정상으로 뜹니다.

```
찾기:  https://en-core.vercel.app
바꾸기: (Vercel이 준 실제 주소)
```

`robots.txt`와 `sitemap.xml` 안의 주소도 같이 바꿔주세요.

바꾼 뒤 GitHub에 다시 올리면 **자동으로 재배포**됩니다.

---

## 4단계 · 문의 폼 활성화 ⚠️ 필수

배포된 `contact.html` 페이지에서 **딱 한 번** 직접 문의를 보내야 합니다.

1. `주소/contact.html` 접속 → 문의 폼에 아무 내용이나 입력 → **문의 보내기**
2. `life_innovator@naver.com` 으로 **FormSubmit 인증 메일** 도착
3. 메일 안의 **활성화 링크 클릭**

이 과정을 건너뛰면 이후 문의가 오지 않습니다.
메일이 없으면 **스팸함**을 확인하세요.

---

## 앞으로 수정할 때

1. GitHub 저장소에서 수정할 파일(`index.html` 또는 `contact.html`) 클릭
2. 연필 아이콘(Edit) 클릭 후 수정
3. **Commit changes**
4. Vercel이 **자동으로 다시 배포** (1분 이내)

---

## 나중에 해두면 좋은 것

**자체 도메인 연결**
`en-core.kr` 같은 주소를 쓰면 학교·공공기관 제안 시 신뢰도가 올라갑니다.
가비아·후이즈 등에서 연 1~2만 원이면 구입할 수 있고,
Vercel 프로젝트의 **Settings → Domains** 에서 연결합니다.

**이메일 주소 감추기**
현재 `contact.html` 소스에 이메일이 노출되어 있습니다.
FormSubmit 활성화 후 발급되는 **암호화 주소**로 바꾸면 감출 수 있습니다.

**검색 등록**
네이버 서치어드바이저, 구글 서치콘솔에 `index.html` 주소를 등록하면
검색 결과에 노출됩니다. `contact.html`은 `noindex`로 설정되어 있어
검색 결과에는 나타나지 않습니다(의도된 설정입니다).
