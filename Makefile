all :
		cd srcs && docker-compose up --build -d
down :
		cd srcs && docker compose down --rmi all







re :	down all
