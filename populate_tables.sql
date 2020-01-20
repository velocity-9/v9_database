INSERT INTO users(user_id, email, github_token, github_username)
VALUES('672fe56f-6b7b-4c43-8225-d297bf9cacbe', 'test@test.com', '12345', 'test');

INSERT INTO users(user_id, email, github_token, github_username)
VALUES('e9a987a3-9f6e-4cda-85fd-7a9bee801e61', 'test2@test.com', '12345', 'test2');

INSERT INTO users(user_id, email, github_token, github_username)
VALUES('6606e8c2-3993-4ab7-8fb0-65cd9c2240e2', 'test3@test.com', '12345', 'test3');

INSERT INTO users(user_id, email, github_token, github_username)
VALUES('6f099069-eeb8-4c32-974c-de520fa2b942', 'test4@test.com', '12345', 'test4');

INSERT INTO components(user_id, github_repo, deployment_status)
VALUES('672fe56f-6b7b-4c43-8225-d297bf9cacbe', 'test_repo', 'deployed');

INSERT INTO components(user_id, github_repo, deployment_status)
VALUES('672fe56f-6b7b-4c43-8225-d297bf9cacbe', 'test_repo2', 'paused');

INSERT INTO components(user_id, github_repo, deployment_status)
VALUES('672fe56f-6b7b-4c43-8225-d297bf9cacbe', 'test_repo3', 'deployed');

INSERT INTO workers(name)
VALUES('Tatooine');
