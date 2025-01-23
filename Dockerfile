FROM alpine:3.21

ENV CPPCHECK_PATH="/cppcheck"
ARG BUILD_DIR="/build"

RUN apk add --no-cache git cmake make gcc g++ python3

# build and install cppcheck
RUN git clone https://github.com/danmar/cppcheck.git "${CPPCHECK_PATH}"
RUN mkdir -p "${BUILD_DIR}"
WORKDIR "${BUILD_DIR}"
RUN cmake "${CPPCHECK_PATH}" && \
    cmake --build . && \
    make install

# prepare analysis
WORKDIR "/src"
RUN rm -rf "${BUILD_DIR}"
COPY --chmod=555 ./misra_compliance.sh /
ENTRYPOINT ["/misra_compliance.sh"]
