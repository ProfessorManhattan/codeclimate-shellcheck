FROM koalaman/shellcheck-alpine:stable AS codeclimate

WORKDIR /work

COPY local/engine.json ./
COPY local/codeclimate-shellcheck /usr/local/bin/codeclimate-shellcheck

RUN adduser --uid 9000 --gecos "" --disabled-password app \
  && apk --no-cache add \
  jq \
  && VERSION="$(shellcheck --version | grep version: | sed 's/version: //')" \
  && jq --arg version "$VERSION" '.version = $version' > /engine.json < ./engine.json \
  && rm ./engine.json

USER app

VOLUME /code
WORKDIR /code

CMD ["codeclimate-shellcheck"]

ARG BUILD_DATE
ARG REVISION
ARG VERSION

LABEL maintainer="Megabyte Labs <help@megabyte.space>"
LABEL org.opencontainers.image.authors="Brian Zalewski <brian@megabyte.space>"
LABEL org.opencontainers.image.created=$BUILD_DATE
LABEL org.opencontainers.image.description="A slim Shellcheck standalone linter and a CodeClimate engine for GitLab CI"
LABEL org.opencontainers.image.documentation="https://github.com/ProfessorManhattan/codeclimate-shellcheck/blob/master/README.md"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.revision=$REVISION
LABEL org.opencontainers.image.source="https://gitlab.com/megabyte-labs/docker/codeclimate/hadolint.git"
LABEL org.opencontainers.image.url="https://megabyte.space"
LABEL org.opencontainers.image.vendor="Megabyte Labs"
LABEL org.opencontainers.image.version=$VERSION
LABEL space.megabyte.type="codeclimate"

FROM codeclimate AS shellcheck

USER root

WORKDIR /work

RUN mv "$(which shellcheck)" /usr/local/bin/shellcheck_original \
  && rm /engine.json /usr/local/bin/codeclimate-shellcheck

COPY local/shellcheck /usr/local/bin/shellcheck

CMD ["--version"]
ENTRYPOINT ["shellcheck"]

LABEL space.megabyte.type="linter"
