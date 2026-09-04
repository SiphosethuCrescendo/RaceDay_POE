# RaceDay - Part 1: System Planning and Database

## System Description
RaceDay is a full-stack, API-driven event management platform built for South Africa's road running, 
walking, and cycling community. It allows **Event Organisers** to create and manage events, categories, routes, 
and results, while **Participants** can browse events, enter categories, track their personal result history,
and access live weather and route information ahead of the race day

This repository contains Part 1 of a three-part Portfolio of Evidence: system planning, including the Entity
Relationship Diagram, the API endpoint plan, and the SQL database script. No application code has been written yet — that begins in Part 2.

## Roles

- **Organiser** — creates, edits, and deletes events; manages event categories and routes; captures participant results; views all enrolments for their events.
- **Participant** — registers an account; browses events; enters an event by selecting a category; views their own enrolments; tracks their personal result history.

## Repository Structure

```
/docs
  RaceDay_ERD.png            - Entity Relationship Diagram
  API_Endpoint_Plan.md       - Full API endpoint specification
  RaceDay_Database.sql       - SQL Server database creation + seed script
.github/workflows/
  ci.yml                     - CI/CD workflow validating repo structure
README.md
```

## How to Run the SQL Script

1. Open SQL Server Management Studio (SSMS) on the cloud lab.
2. Connect to your local SQL Server instance.
3. Open `docs/RaceDay_Database.sql`.
4. Execute the script (F5). It will drop and recreate `RaceDayDB` if it already exists, create all six tables, and seed sample data (2 Organisers, 2 Participants, 3 Events, categories, routes, and enrolments).
5. Run the verification `SELECT` statements at the bottom of the script (uncomment them) to confirm the data loaded correctly.

## ERD Notes
The ERD (`docs/RaceDay_ERD.png`) contains six entities: Users, Events, Categories, Routes, Enrolments, and Results. The SQL script matches this ERD exactly — no deliberate deviations.

## CI/CD

[Insert screenshot ]

<img width="1445" height="428" alt="workflows" src="https://github.com/user-attachments/assets/c2591af9-845d-4651-983d-c96f02202bcf" />

