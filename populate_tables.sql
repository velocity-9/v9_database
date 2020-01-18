INSERT INTO users(email, github_token, github_username)
VALUES('test@test.com', '12345', 'test');

INSERT INTO components(user_id, github_repo, deployment_status)
VALUES(1, 'test_repo', 'deployed');

INSERT INTO workers(name)
VALUES('Tatooine');
