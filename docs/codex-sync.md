# Codex Sync

이 문서는 `profiles/codex/` 프로필을 현재 PC와 다른 PC에 동기화하는 방법을 설명합니다.

## Sync Current PC

현재 PC의 Codex 사용자 환경을 저장소 프로필에 반영합니다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts\sync-codex-profile.ps1
```

결과는 `profiles/codex/`에 저장됩니다.

## Apply On Another PC

다른 PC에서 저장소를 clone 또는 pull 한 뒤 실행합니다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts\apply-codex-profile.ps1
```

적용 후 Codex를 재시작합니다.

## Synced Contents

- 사용자 설치 Codex 스킬
- 사용자 설치 Codex 플러그인
- 비민감 `config.toml`

초기 커밋의 `profiles/codex/`는 비어 있습니다. `sync-codex-profile.ps1`을 실행하기 전까지 `skills/`, `plugins/`, `config/`에는 구조 유지를 위한 `.gitkeep`만 있습니다.

## Excluded Contents

- `auth.json`
- `sessions/`
- `history.jsonl`
- `*.sqlite`, `*.sqlite-shm`, `*.sqlite-wal`
- `log/`, `tmp/`, `.tmp/`
- `plugins/cache/`
- `skills/.system/`
- `skills/codex-primary-runtime/`

## Manifest

`profiles/codex/manifest.json`은 프로필의 단일 인벤토리입니다.

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

`skills.standalone`은 `profiles/codex/skills/`에 직접 들어있는 스킬입니다. `skills.fromPlugins`는 플러그인에 포함되어 제공되는 스킬입니다.

timestamp처럼 매번 바뀌는 값은 manifest에 기록하지 않습니다.
