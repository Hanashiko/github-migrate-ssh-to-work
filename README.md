## GitHub SSH Remote Migration Script

**Purpose:** Bulk-rewrite SSH remote URLs across multiple local Git repositories from the default `git@github.com:` host to a custom `git@github-work:` SSH alias.

**Use case:** When configuring a machine with multiple SSH keys (personal vs work), each GitHub account maps to a distinct SSH host alias defined in `~/.ssh/config`. This script migrates all repos under the current directory to use the work alias.

**Usage:**

```bash
# Dry run — preview changes without modifying anything
./github-migrate-to-work.sh -n

# Apply changes
./github-migrate-to-work.sh
```

**How it works:**
1. Finds all `.git` directories up to 2 levels deep
2. Reads the `origin` remote URL for each repo
3. If the URL starts with `git@github.com:`, rewrites it to `git@github-work:`
4. Skips repos with no remote or a non-matching URL

**Prerequisites:** A `github-work` host alias must be configured in `~/.ssh/config` pointing to `github.com` with the appropriate work SSH key.
