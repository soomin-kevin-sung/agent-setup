# Scripts

에이전트 환경 프로필을 동기화하고 적용하기 위한 자동화 스크립트를 보관합니다.

## 현재 스크립트

- `sync-codex-profile.ps1`: 현재 PC의 Codex 사용자 환경을 `profiles/codex/`에 반영합니다.
- `apply-codex-profile.ps1`: `profiles/codex/`를 현재 PC의 `$env:USERPROFILE\.codex`에 적용합니다.
- `playwright-edge.ps1`: Playwright CLI를 Microsoft Edge 기준으로 실행하는 Windows wrapper입니다.

## 사용 예시

현재 PC 상태를 프로필에 반영:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\sync-codex-profile.ps1
```

다른 PC에 프로필 적용:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\apply-codex-profile.ps1
```

Playwright를 Edge로 실행:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\playwright-edge.ps1 open https://example.com --headed
powershell -ExecutionPolicy Bypass -File scripts\playwright-edge.ps1 snapshot
powershell -ExecutionPolicy Bypass -File scripts\playwright-edge.ps1 screenshot
```

## 작성 기준

- 스크립트는 기본적으로 저장소 루트에서 실행한다고 가정합니다.
- 사용자 홈 경로는 `$env:USERPROFILE` 기준으로 계산합니다.
- 인증 파일, 세션, 로그, 캐시는 복사하지 않습니다.
- 삭제가 필요한 작업은 저장소 내부의 의도한 대상 또는 명시적으로 전달된 테스트 경로로 제한합니다.
