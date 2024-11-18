FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt-get -y install git make cmake wget curl gcc g++ clang llvm lld

# ------------------------------------------------------------------------------

# Force the cache to break if there have been new commits
ADD https://api.github.com/repos/Vast342/Clarity/git/refs/heads/main /.git-hashref

# ------------------------------------------------------------------------------

RUN clang++ --version

# Clone and build from main
RUN git clone --branch main --depth 1 https://github.com/Vast342/Clarity && \
    cd Clarity && \
    make -j EXE=clarity.bin

CMD [ "./Clarity/clarity.bin" ]