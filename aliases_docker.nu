# ------------------------------------------------------------------------------
# Basic Docker Commands
# ------------------------------------------------------------------------------
alias dch = docker --help
alias dcv = docker version
alias dcinfo = docker info

# ------------------------------------------------------------------------------
# Container Management
# ------------------------------------------------------------------------------
alias dclsc = docker ps
alias dclsca = docker ps -a
alias dcstart = docker start
alias dcstop = docker stop
alias dcrestart = docker restart
alias dcrmc = docker rm
alias dcrmcf = docker rm -f
alias dctop = docker top
alias dcstats = docker stats

# ------------------------------------------------------------------------------
# Container Interaction
# ------------------------------------------------------------------------------
alias dcex = docker exec -it
alias dcatt = docker attach
alias dclogs = docker logs
alias dclogsf = docker logs -f
alias dclogst = docker logs -t
alias dcin = docker inspect
alias dcport = docker port
alias dccp = docker cp

# ------------------------------------------------------------------------------
# Image Management
# ------------------------------------------------------------------------------
alias dclsi = docker images
alias dclsia = docker images -a
alias dcb = docker build -t
alias dcbno = docker build --no-cache -t
alias dcpl = docker pull
alias dcps = docker push
alias dct = docker tag
alias dcrmi = docker rmi
alias dcrmif = docker rmi -f
alias dchist = docker history

# ------------------------------------------------------------------------------
# Running Containers
# ------------------------------------------------------------------------------
alias dcrn = docker run
alias dcrnit = docker run -it
alias dcrnd = docker run -d
alias dcrnp = docker run -p
alias dcrndp = docker run -d -p
alias dcrnv = docker run -v
alias dcrndv = docker run -d -v
alias dcrnrm = docker run --rm
alias dcrnrmit = docker run --rm -it

# ------------------------------------------------------------------------------
# Volume Management
# ------------------------------------------------------------------------------
alias dcvc = docker volume create
alias dclsv = docker volume ls
alias dcinv = docker volume inspect
alias dcrmv = docker volume rm
alias dcprunev = docker volume prune

# ------------------------------------------------------------------------------
# Network Management
# ------------------------------------------------------------------------------
alias dclsn = docker network ls
alias dcnetcr = docker network create
alias dcnetin = docker network inspect
alias dcnetrm = docker network rm
alias dcnetprune = docker network prune

# ------------------------------------------------------------------------------
# Docker System Management
# ------------------------------------------------------------------------------
alias dcdf = docker system df
alias dcprune = docker system prune
alias dcprunea = docker system prune -a

# ------------------------------------------------------------------------------
# Docker Compose
# ------------------------------------------------------------------------------
alias dccup = docker compose up
alias dccupd = docker compose up -d
alias dccupb = docker compose up --build
alias dccupdb = docker compose up -d --build
alias dccdown = docker compose down
alias dccdownv = docker compose down -v
alias dccb = docker compose build
alias dccbno = docker compose build --no-cache
alias dccstart = docker compose start
alias dccstop = docker compose stop
alias dccrestart = docker compose restart
alias dccrn = docker compose run
alias dccrnrm = docker compose run --rm
alias dccexec = docker compose exec
alias dcclogs = docker compose logs
alias dcclogsf = docker compose logs -f
alias dcclss = docker compose ps
alias dcctop = docker compose top
alias dccpl = docker compose pull
alias dccps = docker compose push
alias dccconfig = docker compose config
alias dccrm = docker compose rm
alias dccrmf = docker compose rm -f
alias dccwatch = docker compose watch
alias dclogin = docker login
alias dclogout = docker logout

# ==============================================================================
# Custom Commands (Better than aliases in Nushell)
# ==============================================================================

# Follow logs for a specific compose service
def dcclogsvc [service: string] {
    docker compose logs -f $service
}

# Smart shell access (tries bash, falls back to sh)
def dcsh [container: string] {
    try {
        docker exec -it $container bash
    } catch {
        docker exec -it $container sh
    }
}

# List containers with formatted output (using Nushell's table features)
def dclist [] {
    docker ps --format json | from json | select NAMES STATUS PORTS
}

# List all containers with formatted output
def dclistall [] {
    docker ps -a --format json | from json | select NAMES STATUS
}

# List images with formatted output
def dcimages [] {
    docker images --format json | from json | select Repository Tag ID CreatedAt Size
}

# Interactive container selection and shell access
def dcishi [] {
    let container = (docker ps --format json 
        | from json 
        | select ID NAMES 
        | input list "Select container: ")
    
    docker exec -it $container.ID bash
}
