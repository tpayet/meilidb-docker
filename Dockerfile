# Compile
FROM    rust:latest AS compiler

RUN     apt update -y
RUN     apt install cmake -y

RUN     git clone https://github.com/meilisearch/meili-http.git
WORKDIR /meili-http

RUN     cargo build --release


# Run
FROM    debian:latest

COPY    --from=compiler /meili-http/target/release/meili-http .
COPY    --from=compiler /meili-http/misc/fr.stopwords.txt .

EXPOSE  8080
ENV     RUST_LOG http_server

RUN     mkdir -p /var/data
CMD     ["./meili-http", "/var/data", "--stop-words", "fr.stopwords.txt", "-l", "0.0.0.0:8080"]
