# Compile
FROM    rust:latest AS compiler

RUN     apt update -y
RUN     apt install cmake -y

RUN     git clone --single-branch --branch create-server-example https://github.com/qdequele/MeiliDB.git
WORKDIR /MeiliDB

RUN     cargo build --release --example http-server


# Run
FROM    debian

COPY    --from=compiler /MeiliDB/target/release/examples/http-server .
COPY    --from=compiler /MeiliDB/misc/fr.stopwords.txt .

EXPOSE  8080
ENV     RUST_LOG http_server

RUN     mkdir -p /var/data
CMD     ["./http-server", "/var/data", "--stop-words", "fr.stopwords.txt", "-l", "0.0.0.0:8080"]
