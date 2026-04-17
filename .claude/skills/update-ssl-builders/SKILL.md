---
name: update-ssl-builders
description: Twice-yearly workflow for bumping SSL builder images (OpenSSL, LibreSSL) to their latest series releases. Invoked via /update-ssl-builders.
disable-model-invocation: false
---

# Update SSL Builders

This repo publishes Docker builder images with OpenSSL and LibreSSL installed. Twice a year we bump each series to its latest upstream release. This skill walks through that process.

## Background

Always create new builders as multiplatform, using the `standard-builder-with-*` naming pattern.

Some x86-only builders (`x86-64-unknown-linux-builder-with-*`) exist from before multiplatform support was added. They are not being remade as multiplatform; they age out on their own schedule following the same rules as everything else. Do not create new x86-only builders.

**The 2-per-series rule**: Within each series (see Phase 3 for the definition of series), keep at most 2 versions available at any time. The prior version stays one cycle to give users time to migrate; the cycle after that it is dropped. The count includes both multiplatform and x86-only builders.

## Phase 1: Inventory

List all SSL builder directories and group them by library + series:
- `standard-builder-with-libressl-*` and `x86-64-unknown-linux-builder-with-libressl-*`
- `standard-builder-with-openssl-*` and `x86-64-unknown-linux-builder-with-openssl_*`

Note the mixed version separators: older folders sometimes use `_` (`openssl_3.4.1`); newer ones use `-` (`openssl-3.6.0`). Read exact folder names from the filesystem.

## Phase 2: Fetch upstream releases

- LibreSSL: https://www.libressl.org/releases.html
- OpenSSL: https://openssl-library.org/source/

For each library, find the highest version number available across all currently-supported upstream branches.

## Phase 3: Compute adds/drops and confirm

**Series definition (deliberate project policy)**: one major version line = one series. LibreSSL 3.x, LibreSSL 4.x, OpenSSL 1.x, OpenSSL 3.x are each a single series. This intentionally collapses OpenSSL's concurrently-supported 3.0/3.4/3.5/3.6 LTS branches into one series — a new release in any 3.x branch counts as "the latest of OpenSSL 3.x" for the 2-per-series rule.

For each series:
- If the upstream latest is newer than what we have, plan to **add** a new multiplatform builder for it.
- After the add, if the series would have more than 2 versions, plan to **drop** the oldest.
- If upstream is not newer, no changes for that series.

Present the plan to the user and wait for explicit confirmation before making any changes.

## Phase 4: Per-add workflow (one PR per add)

Each add gets its own PR.

1. Create a new branch.
2. Create a new folder named `standard-builder-with-<library>-<version>` using the `-` separator for the version.
3. Copy the four files from the most recent prior version in the same series:
   - `Dockerfile`
   - `build-and-push.bash`
   - `combine-images.bash`
   - `README.md`
4. Bump version references in each file. The simplest approach is to replace every occurrence of the old version string; specifically:
   - `Dockerfile`: download URL, tarball filename, and extracted directory (the version appears multiple times in the OpenSSL Dockerfile in particular)
   - `build-and-push.bash`: `BUILDER` and `NAME` variables
   - `combine-images.bash`: `NAME` variable
   - `README.md`: heading and description
5. Local sanity check: `docker buildx build <folder>`. Verifies the Dockerfile works on your host architecture. The PR CI job added in step 7 is the authoritative build verification; occasionally dependencies in the Dockerfile need adjustments for a newer upstream release.
6. Edit `.github/workflows/rebuild-ponyc-based-images.yml`. Use the existing `standard-builder-with-libressl_4_2_0-amd64`, `standard-builder-with-libressl_4_2_0-arm64`, and `merge-standard-builder-with-libressl_4_2_0` jobs as the reference pattern — copy their full structure including `actions/checkout@v6.0.2`, `docker/login-action@v4` login to ghcr.io, the build/merge step, and the Zulip failure-alert block. Adjust the following:
   - `<builder>-amd64` — `needs: [standard-builder]`, `runs-on: ubuntu-latest`, build step runs `bash <folder>/build-and-push.bash`.
   - `<builder>-arm64` — `needs: [standard-builder]`, `runs-on: ubuntu-24.04-arm`, build step runs the same script.
   - `merge-<builder>` — `needs: [<builder>-amd64, <builder>-arm64]`, `runs-on: ubuntu-latest`, merge step runs `bash <folder>/combine-images.bash`.
   - In job keys and `concurrency.group` fields, use underscores for version separators (e.g., `standard-builder-with-libressl_4_2_1-amd64`). Always write the arm64 concurrency group as `-arm64`, not `-arm` (one existing job uses `-arm` — that's an inconsistency; normalize new jobs to `-arm64`). The human-readable `name:` field keeps dots (`"Update standard-builder-with-libressl-4.2.1 on amd64"`).
   - Add the merge job to `send-builders-updated-event.needs`.
   - Add the image name (e.g., `shared-docker-ci-standard-builder-with-libressl-4.2.1`) to `prune-untagged-multiplatform-images.matrix.image`.
7. Edit `.github/workflows/pr.yml` — add a `validate-standard-builder-with-<library>-<version>-builds` job following the existing `validate-standard-builder-with-libressl-4_2_0-builds` pattern. This is what proves "it builds" at PR time; `rebuild-ponyc-based-images.yml` won't fire until the next ponyc nightly/release event. Use underscores for version separators in the job key; the name and file path use dots.
8. Commit, push, open PR. Commit message explains which builder is being added and why (new upstream release).
9. Wait for CI to pass — especially the new `validate-...-builds` job, which is the actual build verification. Squash-merge. The builder's first real tagged image on ghcr.io is published when the next ponyc nightly or release triggers `rebuild-ponyc-based-images.yml`.
10. Post the "Last Week in Pony" note to the current week's LWIP issue as soon as this PR merges — don't batch notes until the whole cycle is done. Announce the new builder, note which prior-version builder will be removed next cycle, and tell users they should migrate before that happens. If unsure where the current LWIP issue lives, ask the user.

Example phrasing:
> A new OpenSSL 3.6.2 builder image is now available. The prior OpenSSL 3.6.0 image will be removed during the next SSL builder update, so any project still using 3.6.0 should plan to migrate.

## Phase 5: Per-drop workflow (one PR per drop)

Each drop gets its own PR.

1. Create a new branch.
2. Delete the builder folder.
3. Edit `.github/workflows/rebuild-ponyc-based-images.yml`:
   - Remove the builder's job(s). x86-only drops remove one job; multiplatform drops remove three (amd64, arm64, merge).
   - Remove the entry from `send-builders-updated-event.needs`. For multiplatform drops the entry is `merge-<builder>`; for x86-only drops the entry is `<builder>` directly.
   - Remove the image name from the matching prune matrix: `prune-untagged-multiplatform-images.matrix.image` for multiplatform drops, `prune-untagged-builder-images.matrix.image` for x86-only drops. (Aside: the prune matrices may contain stale entries for previously-dropped builders that weren't fully cleaned up; issue #121 tracks current known drift.)
4. Edit `.github/workflows/pr.yml` — remove the corresponding `validate-<builder>-builds` job.
5. Commit, push, open PR.
6. Wait for CI to pass. Squash-merge.
7. Post the "Last Week in Pony" note to the current week's LWIP issue as soon as this PR merges — don't batch notes until the whole cycle is done. Note the builder is gone and will receive no further updates (builders only get rebuilt when a new ponyc nightly or release image triggers `rebuild-ponyc-based-images.yml`). If unsure where the current LWIP issue lives, ask the user.

Example phrasing:
> The OpenSSL 3.4.1 builder image has been removed and will receive no further updates. Any projects still using it should switch to a current builder.

Dropping is code-only. Existing tagged images on ghcr.io are left intact. They simply stop receiving updates — rebuilds only happen when a new ponyc nightly or release image triggers the workflow, and a dropped builder is no longer part of that flow.
