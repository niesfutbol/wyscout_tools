FROM islasgeci/base:1.0.0
COPY . /workdir
RUN R -e "install.packages(c('janitor'), repos='http://cran.rstudio.com')"
