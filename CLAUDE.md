# CLAUDE.md

이 저장소는 에이전트 지침 파일, 스킬, 플러그인, 실행 환경 프로필을 관리하기 위한 저장소입니다.

## Repository Guidance

- 대상 프로젝트에 복사할 지침 파일은 `agent-files/`에서 관리합니다.
- Codex 환경 프로필은 `profiles/codex/`에서 관리합니다.
- 로컬 스킬 원본은 `skills/`에 둡니다.
- 로컬 플러그인 원본은 `plugins/`에 둡니다.
- 프로필 적용과 동기화는 `scripts/`의 PowerShell 스크립트를 사용합니다.
- 민감 정보, 인증 파일, 세션, 로그, 캐시는 커밋하지 않습니다.
- 구조를 바꾸면 `README.md`와 `docs/structure.md`를 함께 갱신합니다.
