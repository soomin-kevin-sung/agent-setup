# Agent Setup Protocol

이 문서는 `agent-setup` 저장소가 따라야 하는 구조와 동기화 규칙을 정의합니다.

## 목적

`agent-setup` 저장소는 에이전트 환경을 여러 PC와 여러 프로젝트에서 재현 가능하게 만들기 위한 기준 저장소입니다.

저장소는 다음 세 영역을 분리합니다.

- 대상 프로젝트에 복사할 에이전트 지침 파일
- PC에 적용할 에이전트 실행 환경 프로필
- 저장소가 직접 관리하는 스킬, 플러그인, 프롬프트, 자동화 스크립트

## 표준 구조

```text
agent-setup/
├─ agent-files/
├─ profiles/
│  └─ codex/
│     ├─ manifest.json
│     ├─ config/
│     ├─ skills/
│     └─ plugins/
├─ skills/
├─ plugins/
├─ prompts/
├─ scripts/
└─ docs/
```

## 역할

`agent-files/`는 대상 프로젝트에 복사할 지침 파일 원본입니다.

`profiles/`는 다른 PC에 적용할 실행 환경 프로필입니다. `profiles/codex/skills/`는 `~/.codex/skills`에, `profiles/codex/plugins/`는 `~/.codex/plugins`에 대응합니다.

`skills/`는 이 저장소가 직접 관리하는 로컬 스킬 소스입니다. 외부에서 설치한 스킬의 적용본은 `profiles/codex/skills/`에 둡니다.

`plugins/`는 이 저장소가 직접 관리하는 로컬 플러그인 소스와 템플릿입니다. 적용 대상 플러그인은 `profiles/codex/plugins/`에 둡니다.

`scripts/`는 프로필 동기화와 적용을 수행합니다.

## Manifest

`profiles/codex/manifest.json`은 Codex 프로필의 단일 인벤토리입니다.

```json
{
  "agent": "codex",
  "schemaVersion": 1,
  "plugins": [],
  "skills": {
    "standalone": [],
    "fromPlugins": []
  }
}
```

규칙:

- `tool`이 아니라 `agent`를 사용합니다.
- timestamp처럼 매번 바뀌는 값은 기록하지 않습니다.
- `skills.standalone`은 프로필에 직접 포함된 스킬입니다.
- `skills.fromPlugins`는 플러그인이 제공하는 스킬입니다.
- 플러그인이 있으면 `.codex-plugin/plugin.json`을 기준으로 관계를 기록합니다.

## 제외 대상

다음 항목은 저장소에 포함하지 않습니다.

- `auth.json`
- `sessions/`
- `history.jsonl`
- `*.sqlite`, `*.sqlite-shm`, `*.sqlite-wal`
- `log/`, `tmp/`, `.tmp/`
- `plugins/cache/`
- `skills/.system/`
- `skills/codex-primary-runtime/`

## 빈 프로필

초기 커밋은 빈 프로필 상태를 유지합니다.

- `profiles/codex/skills/`는 `.gitkeep`만 포함합니다.
- `profiles/codex/plugins/`는 `.gitkeep`만 포함합니다.
- `profiles/codex/config/`는 `.gitkeep`만 포함합니다.
- `manifest.json`의 `plugins`, `skills.standalone`, `skills.fromPlugins`는 빈 배열입니다.

현재 PC 상태를 프로필에 반영하려면 `scripts/sync-codex-profile.ps1`을 실행합니다.
