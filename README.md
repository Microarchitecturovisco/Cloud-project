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
In the provided docker-compose.yml file set the following environment variables:

```
    environment:
      - GITHUB_USERNAME=your_github_username
      - GITHUB_TOKEN=your_github_token
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

