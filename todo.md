# TODO

프로젝트 최신화 작업 목록. 권장 순서: 1 → 2 → 3 → 4 → 5 → 6 → 7.

## 1. CI 수정

- [x] `.github/workflows/main.yml`: 실행 단계에 `bundle exec rspec` 추가 (현재는 `bundle exec rake`만 → rubocop만 돌고 RSpec이 실제로 안 돌고 있음)
- [x] `.github/workflows/main.yml`: `actions/checkout@v2` → `@v4`
- [x] `.github/workflows/main.yml`: 매트릭스 `[3.2, 3.3, 3.4, 4.0, head]`로 교체

## 2. 의존성 / 버전 정리

- [ ] `rubocop-greppable_rails.gemspec`: `required_ruby_version = ">= 2.7.0"` → 최소 3.1 또는 3.2 이상
- [ ] `rubocop-greppable_rails.gemspec`: `summary` 옛 이름(`rubocop/ReadableRails`) 교체, `description`도 의미 있게 다시
- [ ] `rubocop-greppable_rails.gemspec`: `add_dependency "rubocop"` (런타임 의존성) 추가
- [ ] `rubocop-greppable_rails.gemspec`: `add_dependency "lint_roller"` 추가 (3번 항목 전제)
- [ ] `rubocop-greppable_rails.gemspec`: `changelog_uri`를 실제 CHANGELOG.md를 가리키도록 수정
- [ ] `Gemfile`: `gem "rubocop", "~> 1.7"` 제약을 `~> 1.80` 정도로 갱신하거나 gemspec runtime으로 이동
- [ ] `.rubocop.yml`: `TargetRubyVersion: 2.7` → 위에서 올린 Ruby 버전과 일치시키기

## 3. RuboCop Plugin 시스템 (1.72+) 전환

- [ ] `lib/rubocop/greppable_rails/plugin.rb` 추가 (`LintRoller::Plugin` 상속)
- [ ] `lib/rubocop-greppable_rails.rb`에서 plugin 등록
- [ ] `default.yml`이 자동 로드되도록 plugin `about`/`rules` 정의
- [ ] README 사용법을 `require:` → `plugins:` 방식으로 갱신 (5번과 함께)

## 4. Cop 코드 리팩터링

- [ ] `dont_call_helper_in_controller.rb`와 `dont_include_in_helper.rb`의 `find_parent` 중복 제거 (공용 모듈 또는 `node.each_ancestor` 활용)
- [ ] 클래스/모듈 이름 추출을 `parent_node.children.first.children.last.to_s` → `parent_node.identifier` / `defined_module_name` 등 안전한 API로 교체 (네임스페이스, 익명 클래스 케이스 대응)
- [ ] `UseInlineAccessModifier`의 `RESTRICT_ON_SEND`와 `node.access_modifier?` 일관성 검토 (`public` 포함 여부 결정)
- [ ] cop 클래스 yardoc 주석 보강 (`DontCallHelperInController`, `UseInlineAccessModifier`에 설명 문장 추가)
- [ ] (선택) cop 이름을 `Don't...` 부정형 → `No...` 같은 RuboCop 컨벤션 형태로 변경 (0.x 시점에 결정)

## 5. README / 문서

- [ ] `README.md`의 `bundle gem` 템플릿 잔재(`TODO: Delete this...`, `TODO: Write usage`) 제거
- [ ] cop 3종 각각의 동작/예시 작성 (DontCallHelperInController, DontIncludeInHelper, UseInlineAccessModifier)
- [ ] `.rubocop.yml`에 등록하는 방법 (plugin / require) 안내
- [ ] `CHANGELOG.md` 신규 작성

## 6. 메타 파일 정리

- [ ] `.gitignore`에 `Gemfile.lock`이 있는데 lock이 추적 중인 상황 확인 → gem 프로젝트 관례대로 lock 미추적으로 정리할지 결정
- [ ] `CODE_OF_CONDUCT.md`의 contact email 확인/갱신

## 7. 릴리즈 준비

- [ ] `lib/rubocop/greppable_rails/version.rb` 버전 검토 (0.1.0 → 0.2.0 등)
- [ ] `default.yml`의 `VersionAdded` 일괄 점검
- [ ] 첫 RubyGems 배포 절차 정리 (gemspec `allowed_push_host` 주석 처리 그대로 둘지 결정)
