# Codex Profile

Codex 사용자 환경을 여러 PC에 동일하게 적용하기 위한 기준 프로필입니다.

## 포함 대상

- `manifest.json`: 프로필 구성과 스킬/플러그인 관계를 기록하는 안정 메타데이터.
- `config/`: 비민감 Codex 설정 파일. 초기 상태에서는 `.gitkeep`만 포함합니다.
- `skills/`: `~/.codex/skills`에 적용할 사용자 설치 스킬.
- `plugins/`: `~/.codex/plugins`에 적용할 사용자 설치 플러그인.

## 제외 대상

- `auth.json`
- `sessions/`
- `history.jsonl`
- `*.sqlite`, `*.sqlite-shm`, `*.sqlite-wal`
- `log/`, `tmp/`, `.tmp/`
- `plugins/cache/`
- `skills/.system/`
- `skills/codex-primary-runtime/`

## 사용법

현재 PC 상태를 프로필에 반영:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\sync-codex-profile.ps1
```

다른 PC에 프로필 적용:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\apply-codex-profile.ps1
```

적용 후 Codex를 재시작합니다.

초기 커밋의 프로필은 비어 있습니다. 현재 PC의 실제 Codex 환경을 저장소에 반영하려면 sync 스크립트를 실행합니다.
