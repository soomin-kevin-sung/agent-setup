# agent-setup

Codex, Claude 같은 에이전트 서비스를 여러 PC와 여러 프로젝트에서 일관되게 사용하기 위한 에이전트 환경 설정 저장소입니다.

이 저장소는 세 가지를 분리해서 관리합니다.

- 대상 프로젝트에 복사할 에이전트 지침 파일
- 현재 PC와 다른 PC에 적용할 에이전트 환경 프로필
- 직접 관리하는 스킬, 플러그인, 프롬프트, 자동화 스크립트

## 폴더 구조

```text
agent-setup/
├─ AGENTS.md
├─ CLAUDE.md
├─ README.md
├─ agent-files/
│  ├─ codex/
│  │  └─ AGENTS.md
│  ├─ claude/
│  │  └─ CLAUDE.md
│  └─ shared/
│     └─ common.md
├─ profiles/
│  ├─ README.md
│  └─ codex/
│     ├─ README.md
│     ├─ manifest.json
│     ├─ config/
│     │  └─ .gitkeep
│     ├─ skills/
│     │  └─ .gitkeep
│     └─ plugins/
│        └─ .gitkeep
├─ skills/
│  ├─ README.md
│  ├─ agent-setup-sync/
│  │  ├─ SKILL.md
│  │  └─ agents/
│  │     └─ openai.yaml
│  └─ _template/
│     └─ SKILL.md
├─ plugins/
│  ├─ README.md
│  └─ _template/
│     ├─ README.md
│     └─ .codex-plugin/
│        └─ plugin.json
├─ prompts/
│  └─ README.md
├─ scripts/
│  ├─ README.md
│  ├─ apply-codex-profile.ps1
│  ├─ playwright-edge.ps1
│  └─ sync-codex-profile.ps1
└─ docs/
   ├─ agent-setup-protocol.md
   ├─ codex-sync.md
   └─ structure.md
```

## 핵심 개념

`agent-files/`는 다른 프로젝트에 복사할 지침 파일의 원본입니다.

`profiles/`는 PC에 적용할 에이전트 실행 환경입니다. 예를 들어 `profiles/codex/skills/`는 다른 PC의 `~/.codex/skills`로 적용됩니다.

`skills/`와 `plugins/`는 이 저장소가 직접 관리하는 로컬 소스와 템플릿입니다. 외부에서 설치된 스킬의 적용본은 `profiles/codex/skills/`에 들어갑니다.

`scripts/`는 프로필 동기화와 적용을 수행하는 자동화 계층입니다.

초기 상태의 `profiles/codex/`는 비어 있습니다. 실제 스킬, 플러그인, 설정을 프로필에 반영하려면 `sync-codex-profile.ps1`을 실행합니다.

## 사용 흐름

현재 PC의 Codex 환경을 저장소 프로필에 반영:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\sync-codex-profile.ps1
```

다른 PC에 저장소 프로필 적용:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\apply-codex-profile.ps1
```

적용 후 Codex를 재시작합니다.

## 관리 원칙

- `profiles/codex/manifest.json`을 Codex 프로필의 단일 인벤토리로 사용합니다.
- `manifest.json`에는 `agent`, `schemaVersion`, 제외 규칙, 플러그인 목록, 독립 스킬과 플러그인 제공 스킬의 관계를 기록합니다.
- timestamp처럼 매번 바뀌는 값은 manifest에 넣지 않습니다.
- 인증 정보, 세션, 로그, 캐시, SQLite 상태 파일은 저장소에 포함하지 않습니다.
- `skills/`는 로컬 스킬 원본, `profiles/codex/skills/`는 적용 가능한 설치 프로필입니다.
