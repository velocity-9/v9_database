CREATE EXTENSION IF NOT EXISTS "pgcrypto";

DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS components CASCADE;
DROP TABLE IF EXISTS deploying CASCADE;
DROP TABLE IF EXISTS workers CASCADE;
DROP TABLE IF EXISTS stats CASCADE;
DROP TABLE IF EXISTS logs CASCADE;

DROP TYPE IF EXISTS STATUS_COLOR;
CREATE TYPE STATUS_COLOR AS ENUM ('green', 'orange', 'red', 'grey');

DROP TYPE IF EXISTS DEPLOYMENT_INTENTION;
CREATE TYPE DEPLOYMENT_INTENTION AS ENUM ('active', 'paused');

DROP TYPE IF EXISTS DEPLOYMENT_REASON;
CREATE TYPE DEPLOYMENT_REASON AS ENUM ('initial_deployment', 'scaling');

CREATE TABLE users
(
  user_id UUID DEFAULT gen_random_uuid(),
  github_username TEXT NOT NULL,
  -- user email is optional
  email TEXT DEFAULT NULL,
  UNIQUE (github_username),
  PRIMARY KEY (user_id)
);

CREATE TABLE components
(
  component_id UUID DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(user_id),
  github_repo TEXT NOT NULL,
  deployment_intention DEPLOYMENT_INTENTION NOT NULL,
  UNIQUE (user_id, github_repo),
  PRIMARY KEY(component_id)
);

CREATE TABLE deploying
(
    component_id UUID REFERENCES components(component_id),
    deployment_start_time TIMESTAMPTZ NOT NULL DEFAULT now(),
    deployment_reason DEPLOYMENT_REASON NOT NULL,
    PRIMARY KEY(component_id)
);

CREATE TABLE workers
(
  worker_id UUID DEFAULT gen_random_uuid(),
  worker_name TEXT NOT NULL,
  -- We control the `worker_name`, so it can be unique
  UNIQUE(worker_name),
  PRIMARY KEY(worker_id)
);

CREATE TABLE stats
(
  stat_id UUID DEFAULT gen_random_uuid(),
  worker_id UUID REFERENCES workers(worker_id),
  component_id UUID REFERENCES components(component_id),
  received_time TIMESTAMPTZ NOT NULL DEFAULT now(),
  color STATUS_COLOR NOT NULL,
  stat_window_seconds DOUBLE PRECISION NOT NULL,
  hits DOUBLE PRECISION NOT NULL,
  avg_response_bytes DOUBLE PRECISION NOT NULL,
  avg_ms_latency DOUBLE PRECISION NOT NULL,
  ms_latency_percentiles JSONB NOT NULL,
  PRIMARY KEY (stat_id)
);

CREATE TABLE logs
(
  log_id UUID DEFAULT gen_random_uuid(),
  worker_id UUID REFERENCES workers(worker_id),
  component_id UUID REFERENCES components(component_id),
  execution_num INT NOT NULL,
  received_time TIMESTAMPTZ NOT NULL DEFAULT now(),
  log_text TEXT,
  log_error TEXT,
  PRIMARY KEY (log_id)
);

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO v9_sys;
