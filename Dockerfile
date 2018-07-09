# Base image https://hub.docker.com/u/rocker/
FROM rocker/shiny

# install requirements for googleway
RUN apt-get update && apt-get install -y libjq-dev

## Install extra R packages using requirements.R
## Specify requirements as R install commands e.g.
## 
## install.packages("<myfavouritepacakge>") or
## devtools::install("SymbolixAU/googleway")

## Copy requirements.R to container directory /tmp
COPY ./DockerConfig/requirements.R /tmp/requirements.R 
## install required libs on container
RUN Rscript /tmp/requirements.R

# create an R user
ENV USER rstudio

## Copy your working files over
## The $USER defaults to `rstudio` but you can change this at runtime
COPY ./shiny /srv/shiny-server
COPY ./env_vars/.Renviron /home/$USER/.Renviron





