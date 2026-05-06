FROM islasgeci/base:22.04
COPY . /workdir
RUN R -e "install.packages(c('janitor'), repos='http://cran.rstudio.com')"
