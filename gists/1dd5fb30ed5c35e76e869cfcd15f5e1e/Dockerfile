FROM node:7

RUN apt-get update &&\
    apt-get install -y libgtk2.0-0 libgconf-2-4 \
    libasound2 libxtst6 libxss1 libnss3 xvfb

# Exposing port 5000 (micro)
EXPOSE 5000

WORKDIR /app

# copy project
ADD . /app
RUN rm -rf node_modules/*
RUN npm install

COPY start-services.sh /
RUN chmod +x /start-services.sh
ENTRYPOINT ["/start-services.sh"]

CMD ["npm", "start"]