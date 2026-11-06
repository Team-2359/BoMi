# 🌿 BoMI: Borneo Medispa Intelligence App

**AI-Integrated Inventory Management System**

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-Mobile%20App-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/Supabase-Backend-3FCF8E?style=for-the-badge&logo=supabase&logoColor=white" alt="Supabase">
  <img src="https://img.shields.io/badge/Google%20Gemini-AI-8A2BE2?style=for-the-badge" alt="Google Gemini">
  <img src="https://img.shields.io/badge/Status-In%20Development-F5A623?style=for-the-badge" alt="Status">
</p>

<p align="center">
  <b>Smart. Simple. Intelligent.</b><br>
  Simplifying inventory management through intelligent technology.
</p>

---

## 📖 About BoMI

**BoMI (Borneo Medispa Intelligence App)** is an AI-integrated inventory management application developed for **Borneo Medispa's Miri branch, Sarawak, Malaysia**.

The application aims to simplify inventory operations by helping Spa Staff and Branch Managers manage products, track stock movements, monitor inventory levels, and make informed restocking decisions.

By combining conventional inventory management with AI-powered features, BoMI aims to improve inventory visibility, reduce manual data entry, and support more efficient stock management.

## ✨ Key Features

### 📦 Inventory Management
- Add and update inventory products.
- Record stock-in and stock-out transactions.
- View and search current stock quantities.
- Set minimum stock levels.

### ⚠️ Stock Monitoring
- Identify low-stock items.
- Receive low-stock alerts.
- Track inventory movements and stock changes.

### 🧾 BoMI Scan
Uses AI to extract item and quantity details from supplier invoices and prepare draft stock-in entries for staff review and approval.

### 🤖 BoMI Insight
Uses AI to analyse stock usage trends and provide replenishment recommendations to help Branch Managers make informed restocking decisions.

### 📊 Inventory Reports
Allows Branch Managers to review inventory levels and stock-in and stock-out totals for a selected period.

### 🔐 Role-Based Access
Provides separate access permissions for Spa Staff and Branch Managers according to their responsibilities.

## 🎯 Project Objectives

- Centralise inventory information.
- Improve stock tracking and visibility.
- Reduce manual invoice data entry.
- Assist staff in identifying items requiring replenishment.
- Support inventory decisions through AI-powered insights.
- Improve inventory accountability and management efficiency.

## 🛠️ Technologies

- **Flutter & Dart** — Mobile application development.
- **Supabase** — Backend services and database management.
- **Google Gemini API** — AI-powered invoice extraction and inventory insights.
- **Git & GitHub** — Version control and collaboration.

## Git Branch Workflow

We use Git branches to organise our work and avoid changing the main project directly.

### Branches and Their Purposes

| Branch | Purpose |
|---|---|
| `main` | Contains the stable and final version of our project. |
| `develop` | Combines completed work from all team members. |
| `feature/flutter-setup` | Used to set up the Flutter project and its basic structure. |
| `feature/ci-workflow` | Used to set up GitHub Actions and automated testing. |
| `feature/docs` | Used to create and update project documentation. |
| `feature/<name>` | For future features, e.g. `feature/login`. Create a separate feature branch for each new feature. |
| `release/<version>` | For preparing and checking a version before release. (Future use) |
| `hotfix/<issue>` | For fixing urgent problems in the released version. (Future use) |

*Note: Some branches are planned for future use and do not need to be created yet.*

### Our Workflow

1. Create your feature branch from `develop`.
2. Work only on your assigned feature branch.
3. Commit and push your changes to GitHub.
4. Create a Pull Request (PR) from your feature branch into `develop`.
5. Ask at least one teammate to review and approve your PR.
6. Merge into `develop` after approval.
7. When the project is ready and stable, create a PR from `develop` into `main`.
8. Get at least one teammate's approval before merging into `main`.

### Important Rules

- Do not push directly to `main` or `develop`.
- Always use a feature branch for your assigned work.
- Always create a Pull Request before merging.
- Review your teammates' changes when requested.
- Keep your branch updated with the latest changes from `develop`.
- Put project documents in the `docs/` folder.

## 👥 Development Team

**Team 23:59**

Developed as part of the Software Engineering Lab project at Universiti Malaysia Sarawak (UNIMAS).

## 🎓 Academic Information

| | |
|---|---|
| **Course** | TMA3084 Software Engineering Lab |
| **Programme** | Universiti Malaysia Sarawak (UNIMAS) |
| **Semester** | Semester 1, 2026/2027 |
| **Project** | BoMI — Borneo Medispa Intelligence App |

## 🚧 Project Status

**Currently in Development**

BoMI is being developed to support inventory management at Borneo Medispa's Miri branch. Features and functionality are being developed and validated throughout the project.

---

<p align="center">
  <b>🌿 BoMI</b><br>
  Borneo Medispa Intelligence App<br>
  <i>Smart. Simple. Intelligent.</i>
</p>
