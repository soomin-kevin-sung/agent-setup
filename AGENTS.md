# AGENTS.md

이 저장소는 Codex, Claude 같은 에이전트 서비스에서 사용하는 지침 파일, 스킬, 플러그인, 실행 환경 프로필을 관리합니다.

## 작업 원칙

- 이 저장소의 목적은 에이전트 환경을 여러 PC와 프로젝트에서 재현 가능하게 만드는 것입니다.
- 대상 프로젝트에 복사할 지침 파일은 `agent-files/`에 둡니다.
- PC에 적용할 에이전트 실행 환경은 `profiles/`에 둡니다.
- 이 저장소가 직접 관리하는 로컬 스킬 원본은 `skills/`에 둡니다.
- 이 저장소가 직접 관리하는 로컬 플러그인 원본은 `plugins/`에 둡니다.
- 자동화 스크립트는 `scripts/`에 둡니다.
- 비밀값, 토큰, API 키, 인증 파일, 세션, 로그, 캐시는 저장소에 포함하지 않습니다.

## 구조 기준

- `profiles/codex/manifest.json`을 Codex 프로필의 단일 인벤토리로 사용합니다.
- `manifest.json`에는 `agent`, `schemaVersion`, 제외 규칙, 플러그인 목록, 독립 스킬과 플러그인 제공 스킬 관계를 기록합니다.
- timestamp처럼 매번 바뀌는 값은 manifest에 넣지 않습니다.
- `skills/`는 로컬 스킬 소스입니다.
- `profiles/codex/skills/`는 실제 적용 가능한 Codex 스킬 프로필입니다.
- 초기 커밋에서는 `profiles/codex/`를 빈 프로필로 유지하고 `.gitkeep`만 둡니다.
- 구조를 바꿀 때는 `README.md`와 `docs/structure.md`를 함께 갱신합니다.
