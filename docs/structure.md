# Structure

이 문서는 `agent-setup` 저장소의 폴더 역할과 추가 기준을 정의합니다.

## Root

- `README.md`: 저장소 목적, 전체 구조, 기본 사용 흐름.
- `AGENTS.md`: 이 저장소를 Codex로 작업할 때 적용할 루트 지침.
- `CLAUDE.md`: 이 저장소를 Claude로 작업할 때 적용할 루트 지침.

## agent-files/

대상 프로젝트에 직접 복사해서 사용할 에이전트별 지침 파일을 보관합니다.

- `agent-files/shared/common.md`: 여러 에이전트가 공유할 공통 지침.
- `agent-files/codex/AGENTS.md`: 대상 프로젝트용 Codex 지침 원본.
- `agent-files/claude/CLAUDE.md`: 대상 프로젝트용 Claude 지침 원본.

새 에이전트를 추가할 때는 `agent-files/<agent-name>/` 아래에 해당 에이전트가 인식하는 표준 파일명을 사용합니다.

## profiles/

다른 PC에 동일하게 적용할 에이전트 실행 환경 프로필을 보관합니다.

`profiles/codex/`는 Codex의 적용 가능한 프로필입니다.

- `manifest.json`: 프로필 구성과 스킬/플러그인 관계. timestamp는 기록하지 않습니다.
- `config/`: 비민감 Codex 설정. 초기 상태에서는 `.gitkeep`만 둡니다.
- `skills/`: `~/.codex/skills`에 적용할 사용자 스킬.
- `plugins/`: `~/.codex/plugins`에 적용할 사용자 플러그인.

인증 파일, 세션, 로그, 캐시, SQLite 상태 파일은 프로필에 포함하지 않습니다.

## skills/

이 저장소가 직접 관리하는 로컬 스킬 소스와 템플릿을 보관합니다.

- `skills/agent-setup-sync/`: 이 저장소의 Codex 프로필을 동기화하고 적용하는 로컬 스킬 원본.
- `skills/_template/SKILL.md`: 새 스킬 작성용 기본 템플릿.

외부에서 설치된 스킬의 적용본은 `profiles/codex/skills/`에 보관합니다. `skills/`와 `profiles/codex/skills/`를 같은 역할로 사용하지 않습니다.

## plugins/

이 저장소가 직접 관리하는 로컬 플러그인 소스와 템플릿을 보관합니다.

- `plugins/_template/`: 새 Codex 플러그인 작성용 기본 구조.
- `plugins/_template/.codex-plugin/plugin.json`: Codex 플러그인 메타데이터 예시.

사용자 환경에 적용할 플러그인은 `profiles/codex/plugins/`에 들어갑니다.

## prompts/

반복해서 사용하는 프롬프트, 역할 정의, 작업 요청 템플릿을 보관합니다.

## scripts/

프로필 동기화, 프로필 적용, 도구 wrapper 같은 자동화 스크립트를 보관합니다.

- `sync-codex-profile.ps1`: 현재 PC의 Codex 환경을 `profiles/codex/`에 반영.
- `apply-codex-profile.ps1`: `profiles/codex/`를 현재 PC의 `~/.codex`에 적용.
- `playwright-edge.ps1`: Playwright CLI를 Microsoft Edge 기준으로 실행하는 Windows wrapper.

## docs/

구조, 동기화 절차, 운영 규칙을 문서화합니다.

- `agent-setup-protocol.md`: 저장소 구조와 manifest 규칙의 기준 문서.
- `codex-sync.md`: Codex 프로필 동기화와 적용 방법.
- `structure.md`: 폴더별 역할과 추가 기준.
