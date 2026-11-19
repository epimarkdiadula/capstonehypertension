# OSMun Heart Guard — plain HTML / CSS / JavaScript version

This is the same app as the original React project, rewritten with **only HTML, CSS and JavaScript**.
No Node.js, no `npm install`, no build step.

## How to run

1. Open this folder in **VS Code**.
2. Right-click `index.html` → **Open with Live Server**.

(You can also just double-click `index.html`. Live Server is nicer because the page refreshes when you save.)

## What is in the folder

```
index.html        Assessment page  (form + AI results)
dashboard.html    Dashboard page   (numbers, charts, queues)
records.html      Records page     (BP trend chart + searchable log)
favicon.ico

css/
  styles.css      ALL the styling. Colours are at the top (:root).

js/               (the order they are loaded in the HTML matters)
  engine.js       The "brain": classification, risk score, SHAP-style contributions, recommendations
  data.js         Sample patients and pre-made records
  store.js        Remembers data between pages (browser storage)
  ui.js           Shared helpers: header, footer, icons, toast, tooltip
  assessment.js   Code for index.html
  dashboard.js    Code for dashboard.html
  records.js      Code for records.html
```

## Where do I change things?

| I want to…                         | Edit this                                   |
| ---------------------------------- | ------------------------------------------- |
| Change colours                     | `css/styles.css` → the `:root { ... }` block |
| Change sample patients             | `js/data.js`                                |
| Change the BP thresholds / advice  | `js/engine.js`                              |
| Change the header or menu links    | `js/ui.js` → `renderHeader()`               |
| Change the page layout / text      | the `.html` file of that page               |

## Good to know

- Assessments you click **Save assessment** on are stored in your browser (`localStorage`), so they
  stay after you close the tab. To wipe them: open DevTools → Application → Local Storage → delete
  `osmun-xai-records-v1`.
- The patient currently open in the form is kept while you move between pages in the same tab
  (`sessionStorage`).
- Charts are drawn with plain HTML/SVG, so there is no chart library to install.
- The Google Fonts link needs internet. Without it the page still works with a fallback font.

## User Login / Registration

The project now includes `login.html`, `register.html`, and `2fa.html`.
- Create a clinical user account from **Create a user account**.
- Sign in using Employee ID or email + password + selected clinical role.
- Complete the prototype two-factor step with code **123456**.
- Assessment, Dashboard, and Records require a signed-in session.
- Use **Sign out** in the header to end the session.

**Important:** this is a browser-only authentication prototype using localStorage/sessionStorage. It is not suitable for real patient data or production authentication. For the actual capstone deployment, connect the login to a PHP/MySQL backend (for example through XAMPP), store passwords with server-side `password_hash()`, and validate sessions on the server.

## Running with a PHP/MySQL backend (XAMPP)
1. Install XAMPP and start **Apache** and **MySQL**.
2. Copy this project folder into `C:\\xampp\\htdocs\\` (e.g. `C:\\xampp\\htdocs\\osmun-heart-guard-html`).
3. Open `http://localhost/phpmyadmin`, create a database named `osmun_htn`, then **Import** `database.sql`.
4. Open `http://localhost/osmun-heart-guard-html/` (not the file:// path) so PHP and MySQL are used.
5. The `api/` folder contains PHP endpoints; assessment records sync automatically when served over http://localhost.

## Machine Learning / SHAP Integration
1. Install Python packages:
   `pip install -r ai/requirements.txt`
2. Train the model (optional, pre-trained files are included):
   `cd ai/src`
   `python preprocess.py`
   `python train.py`
3. Start the ML API:
   `cd ai`
   `python -m uvicorn api.main:app --host 127.0.0.1 --port 8000`
4. Import `database_ml_migration.sql` in phpMyAdmin if you want ML prediction storage.
5. Open `http://localhost/osmun-heart-guard-html/`.

The result page calls the ML service through PHP and displays a screening prediction plus SHAP feature contributions. This is decision support only, not a medical diagnosis.
