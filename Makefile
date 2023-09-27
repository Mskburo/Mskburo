up:
	docker compose -f ./docker-compose-prod.yaml --env-file .env.prod up --build -d

down:
	docker compose -f ./docker-compose-prod.yaml --env-file .env.prod down

restart:
	docker compose -f ./docker-compose-prod.yaml --env-file .env.prod restart