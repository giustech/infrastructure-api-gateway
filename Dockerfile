FROM hashicorp/terraform:1.1.4
ENV TZ="America/Sao_Paulo"
RUN apk update
RUN apk add --no-cache tzdata curl coreutils py-pip bash
RUN pip install awscli
RUN cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
WORKDIR /terraform-files

#COPY terraform .
