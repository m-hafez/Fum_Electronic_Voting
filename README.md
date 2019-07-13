# FUM-Electronic Voting
<i>By:</i>
   - <b>MohammadHafez Yari</b>
     - 9713430242 
   - <b>Maziar Baradaran Salmani</b>
     - 9713430082
     
<i>@</i> Ferdowsi University of Mashhad - 2019   
## Resources
We update our old Election-Manager code, and it now is fully compatible with 
Fum-electronic voting.
  - Source code of Fum-election-manager on GitHub
    - https://github.com/m-hafez/Election-Manager
  - Docker image of Fum-election-manager on DockerHub
    - https://hub.docker.com/r/mhafezyari/election-manager
## Dockerfile    
Our app Expose on 8080 port
## docker-compose
The images list needed for run Fum-election with docker-compose on a single node
1. https://hub.docker.com/r/ardalanfp/election_portal_db
2. https://hub.docker.com/r/ardalanfp/election_manager_db
3. https://hub.docker.com/r/mhafezyari/election-manager
4. https://hub.docker.com/r/ardalanfp/fum_election_electionportal
5. https://hub.docker.com/r/sayid/auth
6. https://hub.docker.com/r/sayid/election_ui
7. https://hub.docker.com/_/mongo
- For healthy run all containers must first run Database containers that some containers depend on. 
e.g ardalanfp/election_manager_db must run earliest than mhafezyari/election-manager.
so in docker-compose file, the mhafezyari/election-manager service declare as depend on ardalanfp/election_manager_db.
- For run all Containers with docker-compose use this command
    ```
    docker-compose up -d
    ```   
- Stop and remove containers, networks, images, and volumes  
    ```
    docker-compose down
    ```        
- List containers  
    ```
    docker-compose ps
    ```            
 - Ports
 
     | container| Expose Port |   Mapped Port     |
     | :---------| :--------: |:-----:|
     | mhafezyari/election-manager| 8080 |  8011   |
     | sayid/election_ui| 9090  |   8013  |
     | ardalanfp/fum_election_electionportal | 8090  |  8012   |
     | sayid/auth|2000   |  8010   |
   - Set Mapped Port is necessary for see UserInterface in browser. 
   - Other Mapped port just for test Apis
## docker-swarm
For run containers on cluster we use docker-swarm that is orchestration tool for 
manage and scheduling container on cluster.
initially we create 3 docker-machine with virtualbox on a laptop, and deployed the containers on 
docker-machines with docker stack. but it is very slow and lazy, also some containers never up.
so we clustering 2 laptop together and deployed the modified compose-file with 
docker-stack on it, this cluster work perfect.
- Deploy modified docker-compose with docker stack
    ```
    docker stack deploy --compose-file docker-compose-stack.yml mystack
    ```    
- Remove one or more stacks  
    ```
    docker stack rm [StackName]
    ```   
Also for monitoring the cluster we add visualizer container in modified docker-compose file.    
- https://hub.docker.com/r/dockersamples/visualizer
For meet fault tolerance and reliability and also realize the concept of Cloud, we up more than one some containers in cluster.

     | container|  Replicas |   
     | :--------- | :-------:|
     | mhafezyari/election-manager| 2 |  
     | sayid/election_ui| 2  |  
     | ardalanfp/fum_election_electionportal | 3  | 
     | sayid/auth|2   |  
     | dockersamples/visualizer|1   |
     | ardalanfp/election_manager_db|1   |
     | ardalanfp/election_portal_db|1   |
     | mongo|1   |
- Ports and replicas
 
     | container| Expose Port |   Mapped Port     |
     | :---------| :--------: |:-----:|
     | mhafezyari/election-manager| 8080 |  8011   |
     | sayid/election_ui| 9090  |   8013  |
     | ardalanfp/fum_election_electionportal | 8090  |  8012   |
     | sayid/auth|2000   |  8014   |
     | dockersamples/visualizer|2000   |  8010   |
   - Set Mapped Port is necessary for see UserInterface in browser. 
   - Other Mapped port just for test Apis  
