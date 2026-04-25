# Skills

에이전트가 특정 작업을 일관되게 수행하도록 돕는 스킬을 보관합니다.

## 작성 기준

- 스킬 하나는 독립적인 디렉터리 하나로 관리합니다.
- 각 스킬에는 `SKILL.md`를 둡니다.
- `SKILL.md`에는 사용 조건, 작업 절차, 필요한 파일, 검증 방법을 포함합니다.
- 범용 규칙은 스킬에 중복하지 말고 `agent-files/shared/common.md`에 둡니다.

## 예시

```text
skills/
├─ _template/
│  └─ SKILL.md
└─ code-review/
   └─ SKILL.md
```
