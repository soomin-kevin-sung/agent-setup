# Plugins

에이전트 기능을 확장하기 위한 플러그인과 플러그인 템플릿을 보관합니다.

## 작성 기준

- 플러그인 하나는 독립적인 디렉터리 하나로 관리합니다.
- Codex 플러그인은 `.codex-plugin/plugin.json` 메타데이터를 포함합니다.
- 플러그인에 포함된 스킬, MCP 서버, 앱, 리소스의 역할을 README에 명확히 적습니다.
- 실제 비밀값이나 로컬 전용 경로는 포함하지 않습니다.

## 예시

```text
plugins/
├─ _template/
│  ├─ README.md
│  └─ .codex-plugin/
│     └─ plugin.json
└─ browser-workflow/
   ├─ README.md
   └─ .codex-plugin/
      └─ plugin.json
```
