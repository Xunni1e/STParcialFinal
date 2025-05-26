FROM python:3.10-slim

WORKDIR /app

COPY webapp /app

# Instalar todas las dependencias necesarias del sistema
RUN apt-get update && apt-get install -y \
    build-essential \
    default-libmysqlclient-dev \
    libssl-dev \
    libffi-dev \
    gcc \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Instalar dependencias de Python
RUN pip install --no-cache-dir flask flask_sqlalchemy mysqlclient

EXPOSE 5000

ENV FLASK_APP=run.py

CMD ["flask", "run", "--host=0.0.0.0"]
