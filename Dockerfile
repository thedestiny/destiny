FROM centos
MAINTAINER destiny <wenchao.liang@acedata.com.cn>

ENV LANG en_US.UTF-8

RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN yum -y update \ 
    && yum install  -y firefox \ 
	    net-tools \
		nginx \ 
		openssh-server \
		python \ 
		gnome-themes-standard \
		dbus-x11 \ 
		libreoffice \  
		python-pip \


# tini for subreap                                   
ENV TINI_VERSION v0.9.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /bin/tini
RUN chmod +x /bin/tini

ADD image /
RUN pip install setuptools wheel && pip install -r /usr/lib/web/requirements.txt

EXPOSE 80
WORKDIR /root
ENV HOME=/home/  \
    SHELL=/bin/bash
ENTRYPOINT ["/startup.sh"]
