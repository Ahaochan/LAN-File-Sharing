# LAN File Sharing
基于Tomcat的简单的局域网文件共享

- [English Wiki](https://github.com/Ahaochan/LANFileSharing/wiki/English-Wiki)
- [中文Wiki](https://github.com/Ahaochan/LANFileSharing/wiki/%E4%B8%AD%E6%96%87Wiki)

# 介绍

本项目的主要用于手机访问电脑文件, 将需要共享的文件放置在本项目下即可.

**(注意不可放入WEB-INF文件夹下)**

主要用于手机在线播放电脑视频等大存储文件.

# 需要软件
1. [Tomcat(服务器)](http://tomcat.apache.org/)
2. [Java环境(JDK)](http://www.oracle.com/technetwork/java/javase/downloads/index.html)
3. [MX Player视频播放器](https://www.baidu.com/s?wd=MXPlayer)

# 使用说明
1. clone本项目到本地Tomcat
2. [配置Tomcat和Java的环境变量](https://www.baidu.com/s?wd=tomcat%20配置环境)
3. [关闭防火墙](https://www.baidu.com/s?wd=关闭防火墙)
4. 将需要共享的文件放入本项目下, 运行Tomcat/bin目录下的startup.bat
5. 在浏览器的地址栏输入本机局域网ip, 复制视频的链接到MX Player, 选择网络流媒体播放即可.

# 许可证
GNU General Public License v3.0
