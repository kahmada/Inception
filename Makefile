all :
		cd srcs && docker-compose up --build 
down :
		cd srcs && docker compose down --rmi all







re :	down all
