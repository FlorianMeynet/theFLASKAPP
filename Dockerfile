FROM python:latest
WORKDIR /code


COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0

COPY . .

RUN wget https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh -P /scripts
RUN chmod +x /scripts/wait-for-it.sh
ENTRYPOINT ["/scripts/wait-for-it.sh", "db:5432", "--"]

EXPOSE 5000

ADD . .

CMD ["python", "app.py", "runserver", "--hosty=0.0.0.0", "--threaded"]
