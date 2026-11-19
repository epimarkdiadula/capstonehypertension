-- OSMun-XAI Hypertension Diagnostic Support — MySQL schema
-- Import this file in phpMyAdmin (Database -> Import) after creating/selecting "osmun_htn".

CREATE DATABASE IF NOT EXISTS osmun_htn CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE osmun_htn;

CREATE TABLE IF NOT EXISTS users (
  id VARCHAR(40) PRIMARY KEY,
  name VARCHAR(120) NOT NULL,
  employee_id VARCHAR(60) NOT NULL UNIQUE,
  email VARCHAR(120) NOT NULL UNIQUE,
  role VARCHAR(40) NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL
);

CREATE TABLE IF NOT EXISTS assessments (
  id VARCHAR(80) PRIMARY KEY,
  patient_id VARCHAR(60),
  full_name VARCHAR(120),
  age INT,
  sex VARCHAR(10),
  encounter_at DATETIME,
  clinician VARCHAR(80),
  classification VARCHAR(40),
  risk_score DECIMAL(6,4),
  confidence DECIMAL(6,4),
  triage VARCHAR(20),
  input_json LONGTEXT,
  saved_at DATETIME NOT NULL
);
