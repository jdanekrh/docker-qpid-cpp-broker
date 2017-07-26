FROM fedora:latest
ENV NAME=docker-qpid-cpp ARCH=x86_64 QPID_PROTON_VERSION="0.17.0" QPID_CPP_VERSION="1.36.0" QPID_PYTHON_VERSION="1.36.0"
LABEL maintainer="Irina Boverman <irina.boverman@gmail.com>" \
      summary="Docker image for Qpid C++ broker." \
      architecture="$ARCH" \
      name="irinabov/$NAME" \
      qpid_proton_version="$QPID_PROTON_VERSION" \
      qpid_cpp_version="$QPID_CPP_VERSION" \
      usage="docker run -d -p 5672:5672 irinabov/docker-qpid-cpp" \
      example1="Run docker as a daemon in a test container: docker run -d -p 5672:5672 --name test irinabov/docker-qpid-cpp" \
      example2="While this containter is running, look at qpidd options: docker exec -it test qpidd --help" \
      example3="Customize container execution using env variables: add QPID_ to any option shown above, use capital letters and replace dashes with underscores." \
      example4="For example, change tcp port and store directory: docker run -d -p 5672:6000 -e QPID_PORT=6000 -e QPID_DATA_DIR=/root/qpid_data -v /root/qpid_data:/root/qpid_data:Z --name test1 irinabov/docker-qpid-cpp"

# Install all dependencies, build from source, install qpid-cpp components
COPY ./*.sh ./*.txt /
RUN ./build_all.sh

EXPOSE 5671 5672
ENTRYPOINT /usr/local/sbin/qpidd
