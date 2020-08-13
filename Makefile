build:
	hugo

deploy: build
	rsync -avz -e ssh public/ vps-sing-web:/var/www/huytran.dev && \
	rsync -avz -e ssh Dockerfile vps-sing-web:/var/www/huytran.dev/ && \
	ssh vps-sing-web "nginx -s reload"

deploy-docker: delete deploy
	ssh vps-sing-web "cd /var/www/huytran.dev && docker build -t web . && docker run -d -p 8080:80 --name web web"
	ssh vps-sing-web "docker run -d -p 8080:80 --name web web"

test:
	hugo server -D

delete:
	ssh vps-sing-web "docker stop web && docker rm web"