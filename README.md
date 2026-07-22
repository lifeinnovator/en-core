# En-Core 랜딩페이지 — 배포 안내

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
