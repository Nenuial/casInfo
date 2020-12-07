# syntax=docker/dockerfile:1.0.0-experimental
FROM rocker/r-ver:4.0.3
RUN apt-get update && apt-get install -y pandoc libxt-dev && rm -rf /var/lib/apt/lists/*
RUN Rscript -e 'install.packages("remotes")'
RUN Rscript -e 'remotes::install_github("Nenuial/casInfo")'
RUN Rscript -e 'remotes::install_github("rstudio/learnr")'
RUN Rscript -e 'reticulate::install_miniconda()'
EXPOSE 8088
CMD  ["R", "-e", "casInfo::project1_tutorial()"]
