---
name: AI Feature Requirement (FR-AI)
about: Track one AI functional requirement
title: '[FR-AI-xx] AI Feature Name'
labels: 'functional-requirement, ai-feature'
assignees: ''
---

### AI Requirement Metadata

* **Requirement ID**: `FR-AI-xx`
* **Client Problem ID**: `P1 / P2`
* **AI Feature**: BoMI Scan / BoMI Insight
* **Module / Component**: AI Assistance
* **AI Tool / Endpoint**: Google Gemini API via Supabase Edge Functions
* **Priority (MoSCoW)**: Must-have / Should-have / Could-have
* **Estimated Hours**: (Planned hours from Form TASK)

### EARS Specification & Fallback Path

* **Input (Trigger)**: WHEN `<user performs an action that requires AI>`
* **Action (System Steps)**: THE SYSTEM SHALL `<send the required input to Supabase Edge Functions, call Gemini, and process the AI response>`
* **Output (Observable Response)**: AND `<display the extracted information or AI-generated insight to the user>`

* **Fallback Path**:
  IF `<AI API is unavailable, times out, or returns an error>`,
  THEN THE SYSTEM SHALL `<provide an appropriate error message and allow the user to continue with manual stock operations>`.

### AI Constraints & Acceptance Criteria

* **User Role**: `<Spa Staff / Branch Manager>`
* **Input Data**: `<Supplier invoice image / Calculated inventory statistics and stock history>`
* **Expected AI Output**: `<Extracted invoice details / Inventory insights and replenishment recommendations>`
* **Human Verification**: AI-generated stock entries must be reviewed and approved by staff before inventory records are updated.
* **Stock Modification**: BoMI Insight must not automatically modify inventory records.
* **Data Privacy**: Supplier invoices are processed only with client approval. Customer personal data must not be sent to the AI service.
* **API Key Security**: Gemini API key must be stored as a server-side secret in Supabase Edge Functions. Never expose it in the Flutter application or commit it to GitHub.
* **Acceptance Criteria**: `<Define measurable conditions for the specific AI feature>`

### Traceability

* **Traceability Chain**: `P-xx` → `FR-AI-xx` → `GitHub Issue #` → `lib/features/<module>/...` → `LOGTEST` / `LOGAI`
* **SRS Reference**: `SRS § 3.3.2 / 3.3.3 / 3.3.4`
* **Target Component / File**: `lib/features/<module>/<file>.dart`
* **LOGTEST Test ID**: `TC-xx`
* **LOGAI Entry ID**: `AI-xxx`
* **TSP Task Link**: `Form TASK Row #`

### Definition of Done (DoD)

- [ ] AI feature implemented according to its EARS specification.
- [ ] Required fallback path implemented with appropriate error and timeout handling.
- [ ] AI-generated output validated before being used by the application.
- [ ] Human review and approval implemented where stock entries are involved.
- [ ] API key securely stored server-side and not exposed in the mobile application or repository.
- [ ] Unit and integration tests written and passing.
- [ ] Tests cover successful AI responses and API failure / timeout scenarios.
- [ ] PR submitted with title starting with `[FR-AI-xx]`.
- [ ] At least one teammate reviewed and approved the PR.
- [ ] LOGAI entry completed with tool, prompt, target file, reviewer, and test status.
- [ ] LOGT, LOGD and LOGTEST updated.
- [ ] GitHub Issue number and test case linked in the Traceability Matrix.
