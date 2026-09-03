# Data Connect migration (WIP — not yet deployed)

This directory is the relational schema for migrating Stack Up's backend
off Firestore and onto [Firebase Data Connect](https://firebase.google.com/docs/data-connect)
(PostgreSQL via Cloud SQL). Firebase Authentication is unaffected — this
only replaces the three Firestore collections (`users`, `squads`,
`users/{uid}/skills`) with relational tables.

## Status

- [x] `schema/schema.gql` — `User`, `Squad`, `SkillRating` tables
- [x] `connector/queries.gql` / `connector/mutations.gql` — operations
      covering everything `UserRepository`, `SquadRepository` and
      `SkillRepository` currently do against Firestore
- [x] **Compiles cleanly** against the real Data Connect toolkit
      (`firebase dataconnect:compile`), no warnings
- [x] Cloud SQL instance provisioned — `stack-up-917a4-instance`
      (`us-east4`, Postgres 18) — this was auto-created when Data
      Connect was activated in the Firebase console
- [x] Postgres IAM users created for the Data Connect service and the
      `dataconnect-admin` service account (`firebase dataconnect:sql:setup`
      got this far)
- [x] Dart SDK generated into `lib/core/dataconnect_generated/`
      (`stack_up_connector`) — excluded from `flutter analyze` since it's
      generated, not hand-written
- [ ] **Blocked**: applying the schema to the live database
      (`firebase dataconnect:sql:migrate`, and the last step of
      `:sql:setup`) needs a direct Postgres connection through the Cloud
      SQL Auth Proxy (raw TCP, port 3307) — this sandboxed environment's
      network policy only proxies HTTPS, so this must be run from a
      machine with real network access (see below)
- [ ] `UserRepositoryImpl` / `SquadRepositoryImpl` / `SkillRepositoryImpl`
      not yet ported — the app still runs on Firestore today

## To finish provisioning (run locally, or in Cloud Shell)

```bash
export GOOGLE_APPLICATION_CREDENTIALS=/path/to/service-account.json  # the
  # dataconnect-admin@stack-up-917a4.iam.gserviceaccount.com key, or run
  # `gcloud auth application-default login` instead

# Finishes what got interrupted: grants the DB users their schema
# permissions. Safe to re-run — the two IAM Postgres users already exist.
firebase dataconnect:sql:setup

# Applies schema/schema.gql to the database.
firebase dataconnect:sql:migrate

# Publishes the schema + connector to the Data Connect service.
firebase deploy --only dataconnect
```

## Data model

```
User
  id: String (Firebase Auth uid)
  name, email, photoUrl
  totalXp: Int            # denormalized, recomputed on every assessment
  squad: Squad?

Squad
  id: UUID
  name, stack
  memberCount: Int         # not atomically incremented (see JoinSquad in
                            # connector/mutations.gql) — a known
                            # simplification vs. the old Firestore
                            # FieldValue.increment; fine for this app's
                            # low write-concurrency, worth revisiting if
                            # squads ever get large/contested

SkillRating (key: user + skillId)
  user: User
  skillId, name, rating: Int
  answersJson: String     # {questionId: "yes"|"no"|"unknown"} — the
                           # question set lives in Dart
                           # (core/gamification/skill_questions.dart), not
                           # the schema, so adding a question never needs
                           # a migration
  projectsCount: Int
```

## Generated Dart SDK

`lib/core/dataconnect_generated/` (package `stack_up_connector`) exposes
`DefaultConnector.instance.<operationName>(...).execute()` for one-shot
reads/writes, and, for queries, `.ref().subscribe()` which returns a real
`Stream<QueryResult<...>>` backed by a server-side WebSocket stream —
so the repository implementations can keep their existing
`Stream<AppUser?>`-shaped interfaces (`UserRepository.watchUser`, etc.)
when they get ported; only the implementation swaps from
`cloud_firestore` to this connector.
