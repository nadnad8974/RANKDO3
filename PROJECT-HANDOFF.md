# Priority App — start here in the new Codex cloud page

Dan wants this existing Android app continued, not rebuilt from scratch.

## Authoritative files in this handoff

- `PriorityTasks-v2.1-Automation-Ready-PRIVATE.zip` — complete GitHub-safe source,
  tests, feature ledger, build instructions, and automation workflows.
- `PriorityTasks-v2.1.apk` — latest installed release for comparison and testing.
- `supabase-repair-tasks-completed-by.sql` — idempotent repair for the current
  Supabase relationship error.

Extract the source ZIP and place the contents of its
`PriorityTasks2-Automation/` directory at the root of the private GitHub
repository `nadnad8974/RANKDO3`.

## Identity that must not change

- User-facing app: **Priority Tasks 2** (Dan calls the project Priority App).
- GitHub repository name `RANKDO3` is internal only and must never replace the
  user-facing app name.
- Android package: `com.ghosttools.prioritytasks`.
- Current version: `2.1.0` (`versionCode 21`).
- Expected signing-certificate SHA-256:
  `c93c81b0c5104ff17ee0383575267f2a9ebe13c3fc17c1c120a18418abd665db`.
- Never commit or expose the release keystore or passwords. Signing material is
  intentionally absent from this GitHub-safe handoff.

## Mandatory working rules

1. Read `AGENTS.md`, `FEATURE-LEDGER.md`, `CODEX-HANDOFF.md`, `BUILD.md`, and
   `AUTOMATION-SETUP.md` before editing.
2. Preserve every feature in `FEATURE-LEDGER.md`; never rebuild from scratch.
3. Make the smallest compatible change and bump the version only for an APK
   change.
4. Run `npm ci`, `npm test`, the release build, APK verification, signature and
   certificate checks, ZIP integrity, 16-KB native-library alignment, and
   embedded Supabase-config checks before releasing.
5. Do not call an APK finished until all checks pass.

## Current problem to handle first

The installed v2.1 app displays:

> Using saved tasks: Could not find a relationship between 'tasks' and
> 'profiles' in the schema cache

The client requests the named relationship `tasks_completed_by_fkey` between
`public.tasks.completed_by` and `public.profiles.id`. The app currently falls
back to phone-saved tasks when Supabase cannot find that relationship. No task
deletion was observed.

First add the included SQL as the next timestamped Supabase migration and apply
it to the existing project `yejrnrbydvlwynjehuhp`. Do not create a new Supabase
project. Then verify shared tasks, employee finish names (including Melinda),
History/Undo, group chat, Realtime, widgets, and alarms.

For extra resilience, consider making the task loader retry without the optional
embedded `finisher:profiles!tasks_completed_by_fkey(...)` join when PostgREST
reports a missing relationship. The saved `completed_by_name` should remain the
primary byline so a schema-cache delay cannot block all shared tasks.

## Prepared automation

The source already contains GitHub workflows for regression checks, signed APK
releases, and ordered Supabase migrations. Fully automatic publishing still
requires the four encrypted repository secrets documented in
`AUTOMATION-SETUP.md`. Never ask Dan to paste secrets into a chat or commit them.

## First Codex instruction

Continue Priority App from this exact handoff. Import the source into the private
RANKDO3 repository, preserve every existing feature, repair the missing Supabase
relationship, run the complete verification suite, and only then prepare the
next signed APK.
