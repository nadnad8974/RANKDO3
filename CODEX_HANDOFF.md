# Priority Tasks 2 — Codex Handoff

## Current project
- GitHub repository: `nadnad8974/Priority-Tasks-2`
- Previous internal repository name: `RANKDO3`
- Android app name shown on the phone: **Priority Tasks 2**
- Android package: `com.ghosttools.prioritytasks`
- Current installed version confirmed by the user: **2.10.0**
- Supabase project: `yejrnrbydvlwynjehuhp`
- Preserve the existing Android signing identity. Never replace or commit signing keys or passwords.

## Last completed change
Version 2.10.0 was changed so that:
1. The app always opens in the compact layout.
2. The large first header remains hidden.
3. Phone-only page controls are available from the three-dot menu beside **All**.

## Next unfinished request
Move the entire top control/header area down slightly and adjust the title so **RAMSIERS** fits completely on one line across the top instead of wrapping as `RAMSIE` / `RS`.

Do not remove or shrink important controls unnecessarily. Keep the compact layout and three-dot menu behavior introduced in 2.10.0.

## Existing features that must remain
- Add task
- Tasks and History tabs
- Active and Finished sections
- Priority ordering and color-coded tasks
- Date Added and Priority sorting
- Multiple pages and left/right navigation
- Page controls in the three-dot menu
- Employee/group support
- Finished-by employee name preservation
- History restore behavior
- Supabase data and existing user tasks
- Existing Android package name and signing identity so the APK installs as an update

## Required workflow
1. Inspect the existing project before editing.
2. Identify the exact files responsible for the top header/title layout.
3. Make the smallest safe layout change needed.
4. Do not rebuild the app from scratch.
5. Do not delete or replace existing features.
6. Run available tests and build the APK.
7. Confirm the title displays as **RAMSIERS** on one line at the user's phone width.
8. Confirm the compact layout still opens by default.
9. Confirm the three-dot page controls still work.
10. Build the next version as an update to 2.10.0 and report the new version number, files changed, test results, and APK download location.

## Current status
No new source-code change has been made after 2.10.0 yet. The one-line **RAMSIERS** header adjustment is the next task.
