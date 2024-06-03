# Cloud project

## Configuration server
Configuration server requires your GitHub username as well as GitHub token with access to repositories.
Generate your token in your profile settings: https://github.com/settings/tokens 

To start the config server, two env variables need to be provided in the _config-server/src/main/resources/.env_ file in order to access the repository:
```
GITHUB_USERNAME=your_github_username
GITHUB_TOKEN=your_github_token
```

### Run using IntelliJ
Make sure to install all dependencies from all pom.xml files.

Order of running the services:
1. config-server
2. discovery
3. user-service
4. travel-service


### Run using Docker
In the provided env file (_config-server\src\main\resources.env_) file set the following environment variables:
```
GITHUB_USERNAME=your_github_username
GITHUB_TOKEN=your_github_token
```

Set correct variables in properties files:
- In config-server:
```spring.cloud.config.server.git.uri=https://github.com/Microarchitecturovisco/cloud-project-configurations-for-docker.git```
- - In user-service:
```spring.config.import=optional:configserver:http://config:8012```
- In travel-service:
```spring.config.import=optional:configserver:http://config:8012```

Then use the following command to build and run the services:
```
docker-compose up -d --build
```

## Using Docker swarm

Begin with running the instructions mentioned above (section "Run using Docker"). Next:

1. Build Docker image for each service:
```./build-images.sh```

2. Initialize Docker swarm:
```docker swarm init```

3. Run services defined in _docker-compose.yml_ file:
```docker stack deploy --compose-file docker-compose-swarm.yml cloud-project```

All the containers will start at the same time.
However, user and travel services will wait until the discovery service is available and then these application will start.
Number of replicas for each service can be specified in the _docker-compose-swarm.yml_ file.
In the current configuration there will be:
- 1 replica of config server
- 1 replica of discovery service
- 2 replicas of user service
- 2 replicas of travel service

4. Check the status of the services:
```docker service ls```

5. To stop current stack use:
```docker stack rm cloud-project```

6. To turn off the Docker swarm mode use this command:
```docker swarm leave --force```