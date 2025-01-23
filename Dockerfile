ARG CPPCHECK_PATH="/cppcheck"
ARG CPPCHECK_REPO="${CPPCHECK_PATH}/repo"
ARG CPPCHECK_INSTALL="${CPPCHECK_PATH}/install"
ARG BUILD_DIR="/build"
ARG ALPINE_IMAGE="docker.io/alpine:3.21"


FROM "${ALPINE_IMAGE}" AS builder

ARG CPPCHECK_REPO \
    CPPCHECK_INSTALL \
    BUILD_DIR

RUN apk add --no-cache git cmake make gcc g++

# build and install cppcheck
RUN git clone https://github.com/danmar/cppcheck.git "${CPPCHECK_REPO}"
RUN mkdir -p "${BUILD_DIR}"
WORKDIR "${BUILD_DIR}"
RUN cmake -DCMAKE_INSTALL_PREFIX="${CPPCHECK_INSTALL}" "${CPPCHECK_REPO}" && \
    cmake --build . && \
    make install


FROM "${ALPINE_IMAGE}" AS runner

ARG CPPCHECK_PATH \
    CPPCHECK_REPO \
    CPPCHECK_INSTALL
ENV CPPCHECK_REPO="${CPPCHECK_REPO}"
ENV CPPCHECK_INSTALL="${CPPCHECK_INSTALL}"

RUN apk add --no-cache python3

# include repo and compiled binaries
COPY --from=builder "${CPPCHECK_PATH}" "${CPPCHECK_PATH}"

# prepare analysis
WORKDIR "/src"
COPY --chmod=555 ./misra_compliance.sh /
ENTRYPOINT ["/misra_compliance.sh"]
