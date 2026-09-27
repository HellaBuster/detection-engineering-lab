# Detection Engineering Lab

**AI-guided, mastery-gated training in browser systems, telemetry, machine learning, fraud detection, and anti-abuse engineering.**

[English](#english) · [Русский](#русский)

> This repository is both a learning system and a public proof-of-work portfolio.  
> Progress is not based on completed lessons. It is based on demonstrated mastery.

---

<a id="english"></a>

## 🇬🇧 English

### 🧭 What is this?

Detection Engineering Lab is a long-term engineering curriculum built around one principle:

**understanding must be demonstrated, not declared.**

The program combines:

- browser architecture and runtime behavior
- Playwright and browser automation
- HTTP, DNS, TCP, TLS, WebSocket
- telemetry and event data
- Python and SQL
- probability and statistics
- classical machine learning
- fraud and anti-abuse detection
- production detection systems
- false-positive analysis, drift, and monitoring

The curriculum is AI-guided, but the AI is not used as a shortcut around learning.

It acts as:

- instructor
- evaluator
- lab designer
- reviewer
- debugging partner
- curriculum controller

The learner may use AI-generated code, hints, and even full solutions.  
However, **AI-provided reasoning does not count as mastery**.

A topic is unlocked only after the learner demonstrates ownership of the underlying reasoning.

---

## 🎯 Why this repository exists

Modern engineering increasingly involves AI-assisted implementation.

Typing every line manually is becoming less important.

What remains critical is the ability to:

- understand unfamiliar systems
- form hypotheses
- choose the right evidence
- inspect real behavior
- debug incorrect assumptions
- reason about data
- evaluate models
- recognize false positives and false negatives
- make technical trade-offs
- direct AI without outsourcing judgment

This repository is designed around those skills.

---

## 🔒 Mastery-gated progression

Every required topic has a state:

```text
LOCKED
  ↓
ACTIVE
  ↓
PROVISIONAL
  ↓
PASSED
```

A previously passed topic may also become:

```text
NEEDS_REVIEW
```

if later work exposes a real gap.

The learner cannot self-approve a topic.

Statements such as:

```text
"I understand."
"Let's skip this."
"Just mark it done."
"I'll learn it later."
```

do not unlock progression.

The evaluator requires evidence.

Typical mastery evidence includes:

- explaining the concept in your own words
- reconstructing a mental model
- predicting an experiment before running it
- inspecting real evidence
- explaining the observed result
- solving a related but unseen task
- distinguishing the concept from common misconceptions
- connecting it to previous layers

---

## 🤝 Assistance is allowed

The system does **not** punish asking for help.

Assistance can range from:

```text
INDEPENDENT
LIGHT_HINT
STRONG_HINT
PARTIAL_SOLUTION
FULL_SOLUTION
```

A full solution is allowed when needed.

But:

> **FULL_SOLUTION ≠ PASSED**

After a complete worked solution, the learner must later solve a new unseen task that tests the same underlying concept.

The system tracks who performed the important reasoning — not who typed the code.

---

## 🌍 Real-world first

Labs prefer real evidence whenever practical.

Priority:

1. `REAL_PUBLIC_DATA`
2. `REAL_PERMITTED_SITE`
3. `REAL_OWN_LOGS`
4. `CONTROLLED_OPEN_SOURCE_ENV`
5. `SYNTHETIC`

Synthetic data is a fallback, not the default.

When synthetic data is used, the lab should explain:

- why real data was unsuitable
- what was simulated
- what may fail to transfer to production

---

## 🧪 Learning workflow

The physical notebook is the learner's primary thinking surface.

The computer is the laboratory.

```text
Notebook
  ↓
question / hypothesis
  ↓
AI-guided explanation
  ↓
experiment / code / DevTools / SQL / ML
  ↓
observation
  ↓
Notebook
  ↓
explanation / conclusion
  ↓
mastery evaluation
  ↓
repository state update
```

The learner does not copy large code listings by hand.

The notebook is used for:

- diagrams
- formulas
- hypotheses
- confusion matrices
- predictions
- mistakes
- causal chains
- final conclusions

---

## 🗂️ Repository structure

```text
detection-engineering-lab/
│
├── README.md
├── AGENTS.md
├── REPOSITORY_STRUCTURE.md
│
├── curriculum/
│   ├── ROADMAP.md
│   ├── MASTERY_GATE_POLICY.md
│   ├── ASSISTANCE_POLICY.md
│   ├── LEARNING_CONTRACT.md
│   ├── NOTEBOOK_PROTOCOL.md
│   ├── SESSION_PROTOCOL.md
│   ├── ASSESSMENT.md
│   ├── AI_CODE_POLICY.md
│   ├── REAL_WORLD_DATA_POLICY.md
│   ├── CONTEXT_STRATEGY.md
│   └── CAREER_EVIDENCE.md
│
├── progress/
│   ├── CURRENT.md
│   ├── MASTERY.md
│   ├── PROGRESS.md
│   ├── OPEN_QUESTIONS.md
│   └── DECISIONS.md
│
├── labs/
├── projects/
├── case-studies/
├── datasets/
└── assets/
```

### What each section means

| Path | Purpose |
|---|---|
| `AGENTS.md` | Operating contract for the AI instructor |
| `curriculum/` | Stable learning rules and roadmap |
| `progress/` | Current state and authoritative mastery record |
| `labs/` | Focused experiments and technical evidence |
| `projects/` | Larger engineering systems |
| `case-studies/` | Investigations, trade-offs, and decisions |
| `datasets/` | Data provenance and permitted datasets |
| `assets/` | Diagrams, screenshots, selected notebook pages |

---

## 🧠 Target engineering model

The curriculum gradually builds an end-to-end mental model:

```text
User
 ↓
Browser
 ├─ DOM
 ├─ JavaScript / runtime
 ├─ browser state
 └─ events
 ↓
Network
 ├─ DNS
 ├─ TCP
 ├─ TLS
 └─ HTTP
 ↓
Backend
 ↓
Telemetry / events
 ↓
Data / SQL
 ↓
Features
 ↓
Rules + ML
 ↓
Risk score
 ↓
Allow / Challenge / Block
 ↓
Monitoring / feedback
```

The goal is to understand every transition — not merely recognize the technology names.

---

## 🛠️ Target portfolio

Over time, the repository should contain evidence such as:

- browser and network labs
- Playwright experiments
- SQL investigations
- real-world dataset analysis
- statistical exercises
- fraud model evaluation
- threshold selection studies
- false-positive investigations
- telemetry pipelines
- risk-scoring services
- browser anti-abuse lab
- production-style case studies

The final portfolio should demonstrate both implementation and reasoning.

---

## 🤖 AI transparency

AI assistance is not hidden.

This project explicitly uses an:

> **AI-guided, mastery-gated, self-directed engineering curriculum**

The value of the repository is not that AI was avoided.

The value is that the learner's understanding is continuously tested through:

- experiments
- unseen tasks
- debugging
- real evidence
- case studies
- mastery gates
- Git history

---

## 🛡️ Defensive scope

Fraud, anti-abuse, automation, telemetry, and detection are studied in defensive, research, testing, and controlled educational contexts.

Practical work should use:

- owned systems
- public datasets
- permitted APIs
- official demo environments
- controlled open-source applications
- local labs

The repository is not intended as a toolkit for bypassing third-party protections.

---

## 🚧 Status

**Work in progress.**

This repository is expected to evolve continuously as topics are mastered, labs are completed, and larger systems are built.

The authoritative learning state is stored in:

```text
progress/MASTERY.md
progress/CURRENT.md
```

---

<a id="русский"></a>

# 🇷🇺 Русский

### 🧭 Что это?

Detection Engineering Lab — долгосрочная инженерная программа обучения, построенная вокруг одного принципа:

**понимание нужно доказать, а не просто заявить.**

Программа объединяет:

- архитектуру браузеров
- Playwright и browser automation
- HTTP, DNS, TCP, TLS, WebSocket
- телеметрию и событийные данные
- Python и SQL
- вероятность и статистику
- классический ML
- fraud / anti-abuse detection
- production detection systems
- false positives, drift и monitoring

Обучение ведёт AI-агент, но AI не используется как способ проскочить материал.

Он выполняет роли:

- преподавателя
- экзаменатора
- автора лабораторных
- ревьюера
- помощника при debugging
- контроллера учебной программы

Ученик может использовать сгенерированный код, подсказки и даже полные решения.

Но **рассуждение, выполненное AI, не считается доказательством освоения темы**.

---

## 🎯 Зачем создан этот репозиторий

Современная инженерная работа всё сильнее становится AI-assisted.

Способность вручную быстро печатать большие объёмы кода постепенно теряет часть своей ценности.

При этом остаются критически важными способности:

- понимать незнакомые системы
- формулировать гипотезы
- выбирать нужные данные
- проверять реальное поведение системы
- находить неправильные предположения
- анализировать данные
- оценивать ML-модели
- понимать false positives и false negatives
- принимать инженерные решения
- управлять AI, не отдавая ему собственное мышление

На этих навыках и построена программа.

---

## 🔒 Жёсткие mastery gates

Каждая обязательная тема имеет статус:

```text
LOCKED
  ↓
ACTIVE
  ↓
PROVISIONAL
  ↓
PASSED
```

Если позднее обнаруживается реальный пробел, ранее закрытая тема может получить:

```text
NEEDS_REVIEW
```

Ученик не может самостоятельно поставить себе зачёт.

Фразы:

```text
"Я понял."
"Давай скипнем."
"Просто поставь галочку."
"Потом разберусь."
```

не открывают следующую тему.

Нужны доказательства понимания.

Обычно это:

- объяснение своими словами
- восстановление схемы без копирования
- предсказание результата эксперимента
- проверка на реальных данных или поведении системы
- объяснение результата
- новая похожая, но не идентичная задача
- проверка типичных заблуждений
- связь с предыдущими темами

---

## 🤝 Помощь разрешена

Просить помощь можно сколько угодно.

Уровни помощи:

```text
INDEPENDENT
LIGHT_HINT
STRONG_HINT
PARTIAL_SOLUTION
FULL_SOLUTION
```

Даже полное решение разрешено.

Но:

> **FULL_SOLUTION ≠ PASSED**

После полного решения тема остаётся открытой.

Позже ученик получает новую unseen-задачу на тот же принцип.

Оценивается не то, кто набрал код, а то, **кто выполнил ключевое рассуждение**.

---

## 🌍 Реальные данные прежде всего

Приоритет лабораторных:

1. `REAL_PUBLIC_DATA`
2. `REAL_PERMITTED_SITE`
3. `REAL_OWN_LOGS`
4. `CONTROLLED_OPEN_SOURCE_ENV`
5. `SYNTHETIC`

Synthetic data используется только тогда, когда реальные данные плохо подходят для конкретного эксперимента.

---

## 🧪 Как проходит обучение

Главный инструмент мышления — физическая тетрадь.

Компьютер — лаборатория.

```text
Тетрадь
  ↓
вопрос / гипотеза
  ↓
объяснение AI
  ↓
код / DevTools / SQL / ML / эксперимент
  ↓
наблюдение
  ↓
Тетрадь
  ↓
объяснение результата
  ↓
mastery check
  ↓
обновление состояния репозитория
```

В тетрадь не нужно переписывать большие листинги кода.

Туда идут:

- схемы
- формулы
- гипотезы
- confusion matrix
- предсказания
- ошибки
- причинно-следственные связи
- итоговые выводы

---

## 🛠️ Что должно появиться в репозитории со временем

- browser/network labs
- эксперименты с Playwright
- SQL-исследования
- работа с реальными datasets
- задачи по статистике
- оценка fraud-моделей
- исследования threshold
- разборы false positives
- telemetry pipelines
- risk-scoring services
- browser anti-abuse lab
- production-style case studies

Таким образом GitHub становится не просто журналом обучения, а **доказательством инженерного развития**.

---

## 🤖 Прозрачность использования AI

AI не скрывается.

Проект честно описывается как:

> **AI-guided, mastery-gated, self-directed engineering curriculum**

Доказательством навыков являются не заявления и не сертификаты, а:

- лабораторные
- эксперименты
- unseen-задачи
- debugging
- реальные данные
- case studies
- mastery history
- Git history

---

## 🛡️ Область применения

Fraud, anti-abuse, browser automation и detection изучаются в defensive / research / testing контексте.

Практика выполняется на:

- собственных системах
- публичных datasets
- разрешённых API
- официальных demo environments
- контролируемых open-source приложениях
- локальных лабораториях

Репозиторий не предназначен для обхода защит сторонних сервисов.

---

## 🚧 Текущий статус

**Work in progress.**

Репозиторий будет изменяться по мере прохождения mastery gates, лабораторных и проектов.

Текущее состояние обучения хранится в:

```text
progress/MASTERY.md
progress/CURRENT.md
```

---

## 📄 License

MIT
