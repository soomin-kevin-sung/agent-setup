# AGENTS.md

이 저장소는 Codex, Claude 등 에이전트 서비스에서 사용하는 설정 파일과 확장 구성을 관리합니다.

## 작업 원칙

- 저장소의 목적은 에이전트별 지침 파일, 공통 규칙, 스킬, 플러그인, 프롬프트 자산을 체계적으로 보관하는 것입니다.
- 실제 프로젝트에 복사해서 쓸 원본 파일은 `agent-files/` 아래에 둡니다.
- 서비스와 무관한 공통 규칙은 `agent-files/shared/common.md`에 먼저 정리합니다.
- Codex 전용 지침은 `agent-files/codex/AGENTS.md`에 작성합니다.
- Claude 전용 지침은 `agent-files/claude/CLAUDE.md`에 작성합니다.
- 스킬은 `skills/`, 플러그인은 `plugins/`, 재사용 프롬프트는 `prompts/`에 둡니다.
- 비밀값, 토큰, API 키, 개인 인증 정보는 저장소에 남기지 않습니다.

## 편집 기준

- 새로운 에이전트 서비스를 추가할 때는 `agent-files/<service-name>/` 디렉터리를 만들고 해당 서비스의 표준 지침 파일명을 사용합니다.
- 템플릿은 `_template/` 디렉터리에 두고, 실제 사용하는 파일과 구분합니다.
- 문서나 구조를 바꿀 때는 `README.md`와 `docs/structure.md`도 함께 갱신합니다.
