# Skills

이 저장소가 직접 관리하는 로컬 Codex 스킬 원본과 템플릿을 보관합니다.

## 역할

- `agent-setup-sync/`: 이 저장소의 Codex 프로필을 동기화하고 적용하는 로컬 스킬 원본.
- `_template/`: 새 스킬 작성용 기본 템플릿.

외부에서 설치한 스킬의 적용본은 `profiles/codex/skills/`에 보관합니다. `skills/`는 소스 관리 영역이고, `profiles/codex/skills/`는 다른 PC에 적용할 환경 프로필 영역입니다.

## 작성 기준

- 스킬 하나는 독립적인 디렉터리 하나로 관리합니다.
- 각 스킬에는 `SKILL.md`를 둡니다.
- 사용자에게 노출될 스킬은 가능하면 `agents/openai.yaml`도 둡니다.
- 스킬에 필요한 스크립트, 참고 자료, 자산은 해당 스킬 디렉터리 안에 둡니다.
- 범용 에이전트 지침은 스킬에 중복하지 말고 `agent-files/shared/common.md`에 둡니다.

## 구조

```text
skills/
├─ README.md
├─ agent-setup-sync/
│  ├─ SKILL.md
│  └─ agents/
│     └─ openai.yaml
└─ _template/
   └─ SKILL.md
```
