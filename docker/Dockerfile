# Base image https://hub.docker.com/u/rocker/
FROM cedarscompbio/genavi:latest

RUN addgroup --system app \
    && adduser --system --ingroup app app

WORKDIR /home/app

COPY ./genavi_shiny_app . 

RUN chown app:app -R /home/app

USER app

EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('/home/app', host='0.0.0.0', port=3838)"]
