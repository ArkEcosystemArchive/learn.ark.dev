# Git Commit Guidelines

## Introduction <a id="introduction"></a>

These guidelines are based on [Angular's commit convention](https://github.com/conventional-changelog/conventional-changelog/tree/master/packages/conventional-changelog-angular) and should be followed as closely as possible, or your pull-request is subject to rejection.

#### TL;DR: <a id="tl-dr"></a>

Messages must be matched by the following regex:

#### Examples <a id="examples"></a>

Appears under "Features" header, `crypto` subheader:

Appears under "Bug Fixes" header, `crypto` subheader, with a link to issue \#28:

Appears under "Performance Improvements" header, and under "Breaking Changes" with the breaking change explanation:

The following commit and commit `7d1bbd2` do not appear in the changelog if they are under the same release. If not, the revert commit appears under the "Reverts" header.

### Full Message Format <a id="full-message-format"></a>

A commit message consists of a **header**, **body** and **footer**. The header has a **type**, **scope** and **subject**:

The **header** is mandatory and the **scope** of the header is optional.

### Revert <a id="revert"></a>

If the commit reverts a previous commit, it should begin with `revert:`, followed by the header of the reverted commit. In the body, it should say: `This reverts commit <hash>.`, where the hash is the SHA of the commit being reverted.

### Type <a id="type"></a>

If the prefix is `feat`, `fix` or `perf`, it will appear in the changelog. However, if there is any [BREAKING CHANGE](https://docs.ark.io/guidebook/contribution-guidelines/git-commit-guidelines.html#footer), the commit will always appear in the changelog.

Other prefixes are up to your discretion. Suggested prefixes are `docs`, `chore`, `style`, `refactor`, and `test` for non-changelog related tasks.

### Scope <a id="scope"></a>

The scope could be anything specifying the place of the commit change. For example `core`, `profile`, `crypto`, `database` etc...

### Subject <a id="subject"></a>

The subject contains a succinct description of the change:

* use the imperative, present tense: "change" not "changed" nor "changes"
* don't capitalize the first letter
* no dot \(.\) at the end

### Body <a id="body"></a>

Just as in the **subject**, use the imperative, present tense: "change" not "changed" nor "changes". The body should include the motivation for the change and contrast this with previous behavior.

The footer should contain any information about **Breaking Changes** and is also the place to reference GitHub issues that this commit **Closes**.

**Breaking Changes** should start with the word `BREAKING CHANGE:` with a space or two newlines. The rest of the commit message is then used for this.

