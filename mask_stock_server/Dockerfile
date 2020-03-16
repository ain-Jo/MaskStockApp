# 리눅스 환경의 go언어
FROM golang:1.12.5-alpine3.9

# container 내부에 위치할 app디렉토리에 위치
WORKDIR /app
COPY . .

# go모듈은 기본적으로 깃헙을 사용하기에 git설치하고 reflex라이브러리, echo라이브러리 설치
RUN apk update && \
    apk add git && \
    go get github.com/cespare/reflex && \
    go get github.com/labstack/echo && \
    go get github.com/labstack/echo/middleware

# container가 open할 포트 설정
# EXPOSE 3000

# container 시작을 위한 명령어들
CMD ["reflex", "-c", "reflex.conf"]