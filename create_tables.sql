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
