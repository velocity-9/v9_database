DROP TABLE IF EXISTS logs CASCADE;
DROP TABLE IF EXISTS stats CASCADE;
DROP TABLE IF EXISTS workers CASCADE;
DROP TABLE IF EXISTS components CASCADE;
DROP TABLE IF EXISTS users CASCADE;

CREATE TABLE users (
    user_id INT PRIMARY KEY          NOT NULL,
    email           VARCHAR(100)  NOT NULL,
    github_token    VARCHAR(100)  NOT NULL,
    github_username VARCHAR(100)  NOT NULL
);

CREATE TABLE components (
    component_id INT PRIMARY KEY          NOT NULL,
    user_id INT REFERENCES users(user_id),
    github_repo     VARCHAR(100)  NOT NULL,
    deployment_status  VARCHAR(100) NOT NULL
);

CREATE TABLE workers (
    worker_id INT PRIMARY KEY NOT NULL,
    worker_name VARCHAR(50) NOT NULL
);

CREATE TABLE stats (
    stat_id INT PRIMARY KEY NOT NULL,
    worker_id INT REFERENCES workers(worker_id),
    component_id INT REFERENCES components(component_id),
    received_time TIMESTAMP NOT NULL,
    color VARCHAR(20) NOT NULL,
    stats_field VARCHAR(200) NOT NULL
);

CREATE TABLE logs (
    log_id INT PRIMARY KEY NOT NULL,
    worker_id INT REFERENCES workers(worker_id),
    component_id INT REFERENCES components(component_id),
    execution_num INT NOT NULL,
    received_time TIMESTAMP NOT NULL,
    log_text VARCHAR(400)
);
