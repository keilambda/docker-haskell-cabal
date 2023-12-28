FROM haskell:9.4.8-slim AS builder
WORKDIR /app

RUN cabal update

COPY abc.cabal /app/
RUN cabal build --only-dependencies

COPY . /app/
RUN cabal build

RUN mv $(cabal exec which abc | tail -n 1) /app/executable

FROM debian:buster-slim
ARG PORT
ENV PORT=${PORT}
WORKDIR /app
COPY --from=builder /app/executable /app/bin
CMD ["/app/bin"]
