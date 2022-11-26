# Docker image for springboot file run
# 基础镜像使用java
FROM java:8

# VOLUME 指定了临时文件目录为/tmp。
# 其效果是在主机 /var/lib/docker 目录下创建了一个临时文件，并链接到容器的/tmp
# 由于 Spring Boot 使用内置的Tomcat容器，Tomcat 默认使用/tmp作为工作目录
VOLUME /tmp

# 将jar包添加到容器中并更名为app.jar
#ADD demo-0.0.1-SNAPSHOT.jar app.jar 
ADD dap-cloud-b2o-web.jar dap-cloud-b2o-web.jar

#centos
ENV TIME_ZONE=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TIME_ZONE /etc/localtime && echo $TIME_ZONE > /etc/timezone

#Ubuntu
#RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# 运行jar包
RUN bash -c 'touch /dap-cloud-b2o-web.jar'
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom -server -Xmx2g -Xms2g -Xmn256m -Xss512k -XX:+DisableExplicitGC -XX:+UseConcMarkSweepGC -XX:+CMSParallelRemarkEnabled -XX:+UseCMSCompactAtFullCollection -XX:LargePageSizeInBytes=128m -XX:+UseFastAccessorMethods -XX:+UseCMSInitiatingOccupancyOnly -XX:CMSInitiatingOccupancyFraction=70","-jar","/dap-cloud-b2o-web.jar"]'
#-Djava.security.egd=file:/dev/./urandom jdk默认的是读取/dev/random文件产生强随机数，但是如果不是为了产生加密随机数，我们可以设置jdk读取/dev/urandom产生随机数，从而生成随机uuid

#服务器docker打包的命令为 docker build -t dap-cloud-b2o-web .
# 运行docker的命令  docker run -di -p 8085:8085 --name=dap-cloud-b2o-web dap-cloud-b2o-web
# 通过传递参数的方式传递宿主机器ip docker run -di -p 8085:8085 --name=dap-cloud-b2o-web -e "docker.ip=10.114.10.219" dap-cloud-b2o-web 
#-di 后台启动
#-p 将宿主机的端口映射到docker容器的端口
# --name=xxxx 命名
# --expose=8085 暴露端口号 好像不配置也可以
# -e 传递参数，这个参数会更新application中配置的信息

#停止docker的命令 docker stop dap-cloud-b2o-web
#查看docker正在运行的images docker ps -n 5
#进入docker容器内部 docker exec -it dap-cloud-b2o-web bash

#删除一个容器 docker rm dap-cloud-b2o-web bash

#删除<none>镜像 docker rmi $(docker images -f "dangling=true" -q)