# Structure

이 문서는 `agent-setup` 저장소의 폴더 역할과 추가 기준을 정의합니다.

## Root

- `README.md`: 저장소 목적, 전체 구조, 기본 사용 방식.
- `AGENTS.md`: 이 저장소를 Codex로 작업할 때 적용할 루트 지침.
- `CLAUDE.md`: 이 저장소를 Claude로 작업할 때 적용할 루트 지침.

## agent-files/

프로젝트에 직접 복사해 사용할 에이전트별 지침 파일을 보관합니다.

- `agent-files/shared/`: 모든 에이전트에 공통으로 적용할 규칙.
- `agent-files/codex/`: Codex 전용 `AGENTS.md` 원본.
- `agent-files/claude/`: Claude 전용 `CLAUDE.md` 원본.

새 에이전트를 추가할 때는 `agent-files/<service-name>/` 형식으로 만들고, 해당 서비스가 기대하는 표준 파일명을 사용합니다.

## skills/

에이전트가 특정 작업 방식을 재사용할 수 있도록 만드는 스킬을 보관합니다.

- `_template/SKILL.md`: 새 스킬 작성용 기본 템플릿.
- 스킬 하나는 독립적인 폴더 하나로 관리합니다.
- 스킬 설명에는 사용 조건, 입력, 절차, 검증 방법을 포함합니다.

## plugins/

여러 스킬, 도구 설정, 리소스를 묶는 플러그인을 보관합니다.

- `_template/`: 새 플러그인 작성용 기본 구조.
- `.codex-plugin/plugin.json`: Codex 플러그인 메타데이터 예시.
- 플러그인은 실행 코드와 문서를 함께 포함할 수 있습니다.

## prompts/

반복해서 사용하는 프롬프트, 역할 정의, 작업 요청 템플릿을 보관합니다.

프롬프트는 특정 에이전트에 종속되지 않는 형태로 작성하고, 서비스별 차이가 있으면 `agent-files/`에 반영합니다.

## scripts/

설정 파일 복사, 동기화, 검증 같은 자동화 스크립트를 보관합니다.

예상 스크립트:

- 특정 프로젝트로 `AGENTS.md` 또는 `CLAUDE.md` 복사.
- 공통 규칙 변경 후 에이전트별 파일 동기화.
- 민감 정보 패턴 검사.
