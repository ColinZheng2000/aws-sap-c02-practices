# Scripts — AWS SAP-C02 Learning Material Maintenance

Automation scripts for maintaining the AWS SAP-C02 learning material ecosystem.

## Scripts

| Script | Purpose | Usage |
|---|---|---|
| `scan-new-questions.ps1` | Scan wrong-answer files, extract YAML metadata, generate chapter-grouped report | `.\scan-new-questions.ps1 [-NewerThan QID]` |
| `check-qref-consistency.ps1` | Compare wrong-answer QIDs against textbook Q Ref citations | `.\check-qref-consistency.ps1` |
| `sync-yaml-counts.ps1` | Auto-sync practice file YAML question counts with actual counts | `.\sync-yaml-counts.ps1 [-DryRun]` |

## Quick Start

```powershell
# Check for new questions (files with qid > 300)
.\scripts\scan-new-questions.ps1 -NewerThan 300

# Verify all Q Refs are consistent
.\scripts\check-qref-consistency.ps1

# Sync practice file YAML counts (dry run first)
.\scripts\sync-yaml-counts.ps1 -DryRun
.\scripts\sync-yaml-counts.ps1  # Actually update files
```

## Output

All scripts generate Markdown reports in the `scripts/` directory:
- `report-new-questions.md` — New question inventory by chapter
- `report-qref-mismatch.md` — Missing or stale Q Ref citations
- `report-yaml-sync.md` — Practice file YAML consistency report

## Typical Workflow (Adding New Wrong Answers)

1. Add new `.md` files to root (using standardized YAML frontmatter from `999. AI Prompt.md`)
2. Run `scan-new-questions.ps1 -NewerThan {last_known_qid}` to see what's new
3. Use the report to know which textbook chapters need updating
4. Use `<!-- UPDATE_MARKER -->` comments in the textbook to locate service sections
5. Update textbook + practice files
6. Run `check-qref-consistency.ps1` to verify no citations missed
7. Run `sync-yaml-counts.ps1 -DryRun` to see if practice YAML needs updating
8. Run `sync-yaml-counts.ps1` to fix YAML counts
