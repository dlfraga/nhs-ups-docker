FROM ubuntu:latest
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update
RUN apt install unzip tzdata -y
COPY ./nhsups_3.1.36_x86_64_eGLIBC_2.11.zip /tmp
RUN cd /tmp \
&& unzip ./nhsups_3.1.36_x86_64_eGLIBC_2.11.zip \
&& cd nhsups_3.1.36_x86_64_eGLIBC_2.11/ \
&& chmod +x install.sh \
&& ./install.sh \
&& chmod +x /usr/local/nhs/nhsupsserver \
&& rm -rfv nhsups_3.1.36_x86_64_eGLIBC_2.11/ nhsups_3.1.36_x86_64_eGLIBC_2.11.zip
EXPOSE 2001
WORKDIR /usr/local/nhs/
CMD /usr/local/nhs/nhsupsserver
