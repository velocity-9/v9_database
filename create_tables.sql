CREATE EXTENSION IF NOT EXISTS "pgcrypto";

DROP TYPE IF EXISTS STATUS_COLOR;
CREATE TYPE STATUS_COLOR AS ENUM ('green', 'orange', 'red', 'grey');

DROP TYPE IF EXISTS DEPLOYMENT_STATUS;
CREATE TYPE DEPLOYMENT_STATUS AS ENUM ('ready', 'paused');

DROP TABLE IF EXISTS users CASCADE;
CREATE TABLE users (
  user_id UUID DEFAULT gen_random_uuid(),
  email TEXT NOT NULL,
  github_token TEXT NOT NULL,
  github_username TEXT NOT NULL,
  PRIMARY KEY (user_id)
);

DROP TABLE IF EXISTS components CASCADE;
CREATE TABLE components (
  component_id UUID DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(user_id),
  github_repo TEXT NOT NULL,
  deployment_status DEPLOYMENT_STATUS NOT NULL,
  PRIMARY KEY(component_id)
);

DROP TABLE IF EXISTS workers CASCADE;
CREATE TABLE workers (
  worker_id UUID DEFAULT gen_random_uuid(),
  worker_name TEXT NOT NULL,
  PRIMARY KEY(worker_id)
);

DROP TABLE IF EXISTS stats CASCADE;
CREATE TABLE stats (
  stat_id UUID DEFAULT gen_random_uuid(),
  worker_id UUID REFERENCES workers(worker_id),
  component_id UUID REFERENCES components(component_id),
  received_time TIMESTAMPTZ NOT NULL,
  color STATUS_COLOR NOT NULL,
  stat_window_seconds DOUBLE PRECISION NOT NULL,
  hits DOUBLE PRECISION NOT NULL,
  avg_response_bytes DOUBLE PRECISION NOT NULL,
  avg_ms_latency DOUBLE PRECISION NOT NULL,
  ms_latency_percentiles JSONB NOT NULL,
  PRIMARY KEY (stat_id)
);

DROP TABLE IF EXISTS logs CASCADE;
CREATE TABLE logs (
  log_id UUID DEFAULT gen_random_uuid(),
  worker_id UUID REFERENCES workers(worker_id),
  component_id UUID REFERENCES components(component_id),
  execution_num INT NOT NULL,
  received_time TIMESTAMPTZ NOT NULL,
  log_text TEXT,
  log_error TEXT,
  PRIMARY KEY (log_id)
);
