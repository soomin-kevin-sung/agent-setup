# agent-setup

Codex, Claude 같은 에이전트 서비스를 사용할 때 필요한 설정 파일, 지침 파일, 플러그인, 스킬, 프롬프트 조각을 한곳에서 관리하기 위한 저장소입니다.

이 저장소는 특정 프로젝트에 바로 복사해서 사용할 수 있는 `AGENTS.md`, `CLAUDE.md` 같은 에이전트별 지침 파일과, 여러 프로젝트에서 재사용할 수 있는 공통 규칙, 스킬, 플러그인 템플릿을 보관합니다.

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
├─ docs/
│  └─ structure.md
├─ plugins/
│  ├─ README.md
│  └─ _template/
│     ├─ README.md
│     └─ .codex-plugin/
│        └─ plugin.json
├─ prompts/
│  └─ README.md
├─ scripts/
│  └─ README.md
└─ skills/
   ├─ README.md
   └─ _template/
      └─ SKILL.md
```

## 사용 방식

1. `agent-files/shared/common.md`에 모든 에이전트가 공유할 기본 원칙을 작성합니다.
2. `agent-files/codex/AGENTS.md`, `agent-files/claude/CLAUDE.md`에 서비스별 차이를 반영합니다.
3. 프로젝트별로 필요한 파일만 복사하거나, 스크립트를 추가해 자동 배포합니다.
4. 반복해서 쓰는 기능은 `skills/`, 도구 묶음은 `plugins/`, 재사용 프롬프트는 `prompts/`에 보관합니다.

## 관리 원칙

- 공통 규칙은 한곳에 두고, 에이전트별 파일에는 서비스 차이만 적습니다.
- 실제 프로젝트에 배포 가능한 파일과 템플릿은 분리합니다.
- 개인 비밀값, API 키, 토큰은 저장소에 커밋하지 않습니다.
- 파일명은 각 서비스가 인식하는 표준 이름을 유지합니다.
