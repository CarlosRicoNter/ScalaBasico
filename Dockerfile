# 1. Imagen base de Jupyter
FROM jupyter/base-notebook:latest

# Cambiamos a usuario root temporalmente para instalar dependencias del sistema
USER root

# 2. Instalamos Java 11 (requisito para Scala) y la herramienta curl
RUN apt-get update && \
    apt-get install -y openjdk-11-jre-headless curl && \
    apt-get clean

# Volvemos al usuario normal de Jupyter por seguridad
USER ${NB_USER}

# 3 y 4. Descargamos Coursier y lo usamos para instalar el kernel Almond (Scala 2.12)
RUN curl -Lo coursier https://git.io/coursier-cli && \
    chmod +x coursier && \
    ./coursier launch --fork almond:0.10.9 --scala 2.12.10 -- --install && \
    rm coursier
