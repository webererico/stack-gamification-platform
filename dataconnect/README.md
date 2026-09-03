# Data Connect migration (WIP — not yet deployed)

This directory is a **draft** relational schema for migrating Stack Up's
backend off Firestore and onto [Firebase Data Connect](https://firebase.google.com/docs/data-connect)
(PostgreSQL via Cloud SQL). Firebase Authentication is unaffected — this
only replaces the three Firestore collections (`users`, `squads`,
`users/{uid}/skills`) with relational tables.

## Status

- [x] `schema/schema.gql` — `User`, `Squad`, `SkillRating` tables
- [x] `connector/queries.gql` / `connector/mutations.gql` — draft
      operations covering everything `UserRepository`, `SquadRepository`
      and `SkillRepository` currently do against Firestore
- [ ] **Not yet compiled/validated** against the real Data Connect
      toolkit — see below
- [ ] Cloud SQL instance not yet provisioned
- [ ] Dart SDK not yet generated
- [ ] `UserRepositoryImpl` / `SquadRepositoryImpl` / `SkillRepositoryImpl`
      not yet ported — the app still runs on Firestore today

## Why nothing has been provisioned yet

`firebase dataconnect:compile` / `:sql:setup` / `:sql:migrate` and
`firebase deploy --only dataconnect` all need Google Cloud **Application
Default Credentials** — a different, broader auth mechanism than the
`firebase login:ci` token used for the rest of this project's deploys
(hosting, Firestore). That needs a service account with the **Cloud SQL
Admin** and **Firebase Data Connect Admin** roles.

## Next steps (once credentials are available)

```bash
export GOOGLE_APPLICATION_CREDENTIALS=/path/to/service-account.json

# 1. Validate the schema/connector files compile.
firebase dataconnect:compile

# 2. Provision the Cloud SQL Postgres instance (one-time; takes a few
#    minutes and starts incurring Cloud SQL costs — this is NOT covered
#    by Firestore's free Spark-plan tier).
firebase dataconnect:sql:setup

# 3. Apply the schema to the database.
firebase dataconnect:sql:migrate

# 4. Generate the typed Dart client into lib/core/dataconnect_generated/.
firebase dataconnect:sdk:generate

# 5. Deploy the schema + connector to the Data Connect service.
firebase deploy --only dataconnect
```

After step 4 generates real code, the three repository implementations
get rewritten against it (replacing `cloud_firestore` calls) — that's
the bulk of the remaining work, and where the schema/connector drafts
above will likely need small fixes based on what the compiler actually
accepts.

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
  memberCount: Int

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
