-- Non-destructive migration for ML/XAI support
-- Run this in phpMyAdmin after selecting database `osmun_htn`.

CREATE TABLE IF NOT EXISTS model_versions (
  id INT AUTO_INCREMENT PRIMARY KEY,
  model_name VARCHAR(120) NOT NULL,
  model_version VARCHAR(60) NOT NULL,
  algorithm VARCHAR(120),
  target_description VARCHAR(255),
  metrics_json LONGTEXT,
  trained_at DATETIME NOT NULL
);

CREATE TABLE IF NOT EXISTS ml_predictions (
  id VARCHAR(80) PRIMARY KEY,
  assessment_id VARCHAR(80),
  patient_id VARCHAR(60),
  model_version VARCHAR(60),
  prediction VARCHAR(80),
  probability DECIMAL(6,4),
  input_json LONGTEXT,
  created_at DATETIME NOT NULL,
  FOREIGN KEY (assessment_id) REFERENCES assessments(id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS ml_explanations (
  id INT AUTO_INCREMENT PRIMARY KEY,
  prediction_id VARCHAR(80) NOT NULL,
  feature_name VARCHAR(120) NOT NULL,
  feature_value DOUBLE,
  shap_value DOUBLE,
  created_at DATETIME NOT NULL,
  FOREIGN KEY (prediction_id) REFERENCES ml_predictions(id) ON DELETE CASCADE
);
