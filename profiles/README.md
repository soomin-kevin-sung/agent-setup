# Profiles

다른 PC에 동일하게 적용할 에이전트 실행 환경 프로필을 보관합니다.

## 역할

`profiles/`는 단순 백업 폴더가 아니라 에이전트 환경의 기준 설정입니다.

각 하위 폴더는 특정 에이전트의 실행 환경을 나타냅니다.

```text
profiles/
└─ codex/
   ├─ manifest.json
   ├─ config/
   ├─ skills/
   └─ plugins/
```

초기 상태의 프로필 디렉터리는 비어 있으며, Git 추적을 위해 `.gitkeep`만 포함합니다.

## 원칙

- 재사용 가능한 스킬, 플러그인, 비민감 설정만 포함합니다.
- 인증 정보, 세션, 로그, 캐시, SQLite 상태 파일은 포함하지 않습니다.
- 현재 PC 상태를 프로필에 반영할 때는 `scripts/sync-codex-profile.ps1`을 사용합니다.
- 다른 PC에 프로필을 적용할 때는 `scripts/apply-codex-profile.ps1`을 사용합니다.
