FROM google/dart

WORKDIR /app

ADD pubspec.* /app/
RUN pub get --no-precompile
ADD . /app/
RUN pub get --offline --no-precompile
RUN pub global activate webdev
# RUN pub global run webdev build

EXPOSE 8080

ENTRYPOINT ["pub", "global", "run", "webdev", "serve"]

