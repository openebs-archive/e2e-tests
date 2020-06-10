---
name: Request for running E2e Pipeline
about: Request to run e2e pipeline with specific release tag
title: Run e2e pipeline for [ release tag ]
labels: release-checklist
assignees: gprasath, nsathyaseelan, shashank855, w3aman

---

Run OpenEBS E2e pipeline for [release tag or custom tag]

< Include the image tags for various openebs container images >
- Default tag 
- NDM 
- ZFS Local PV


- [ ] OpenShift Pipeline 
- [ ] Konvoy Pipeline 
- [ ] Native K8s Pipeline 
- Upgrade Pipelines to the release tag from: 
     - [ ]  1.0.0
     - [ ]  1.1.0
     - [ ]  1.2.0
     - [ ]  1.3.0
     - [ ]  1.4.0
     - [ ]  1.5.0
     - [ ]  1.6.0
     - [ ]  1.7.0
     - [ ]  1.8.0
     - [ ]  1.9.0
     - [ ]  1.10.0

- ZFS Upgrade Pipelines to latest tag from: 
     - [ ]  0.4
     - [ ]  0.4.1
     - [ ]  0.5
     - [ ]  0.6
     - [ ]  0.6.1
     - [ ]  0.7.0

- List of Manual Tests (if any) 
   - [ ] Jiva pre-load
   - [ ] > 50G Manual Backup and Restore

- In case of Release Candidate builds 
   - [ ] Test with Helm Chart
   - [ ] Dogfooding - Director Online Staging 
   - [ ] Dogfooding - Gitab E2e Infra 1.9.0 to 1.10.0
   - [ ] Dogfooding - Director Onprem from 1.9.0 to 1.10.0

Additional One-off tasks:
  - [ ] < if any >
