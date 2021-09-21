# Linux4Work

Para cada cliente existem inumeras configurações e personalizações de SHELL e Credenciais. Com este simples Docker é possivel ter um terminal/sistema para cada um isoladamente sem que uma credencial ou configuração não interfira no outro. 
Feio para rodar e ter seu sistema inteiro multiplataforma. 

# Configure

Existems variaveis ARG no arquivo Dockerfile, que devem ser persoanlizadas para seu projeto. Antes de rodar fique a vontade em altera-las. Outro ponto importante é que este repositorio é colaborativo, se tiver alguma ideia ou sugestão para melhoria é totalente bem vindo e motivado. 

### Install

```bash
git clone git@github.com:andreabreu76/docker-linuxHost-cliente.git clientFolder
```
```bash
cd clientFolder/
```
Edit `Dockerfile` and `docker-composer.yml` for define arguments with your criteria.

```bash
docker-composer up --build -d
```
Now enter in our container and do some commands.

```bash
docker exec -it nameOfContainer /bin/bash
```
```bash
sudo cp -R /etc/skel/.* . && sudo chwon -R $USER:$USER .
```





