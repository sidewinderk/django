# Relativley effective Docker recipe for personal Django web server
# based on https://siner308.github.io/
# COPY parts are removed.
# The prodcued Docker image can be used with mounted host volume.
# eg. docker run -d --mount type=bind,source="/YOUR/PATH/manage.py/PLACED",target=/app -p 8000:8000 --name YOUR_CONTAINER_NAME YOUR_IMAGE_NAME /app/start
FROM python:3.8

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       postgresql-client vim\
    && rm -rf /var/lib/apt/lists/*
RUN pip install \
    requests Pillow bootstrap4 \ 
    django django-bootstrap-modal-forms \
    django-tinymce django-bootstrap4 django-widget_tweaks
RUN mkdir /app
RUN echo -e "#!/bin/bash \npython manage.py makemigrations\npython manage.py migrate\npython manage.py runserver 0.0.0.0:8000" > /app/start
RUN chmod 755 /app/start
WORKDIR /app
EXPOSE 8000
