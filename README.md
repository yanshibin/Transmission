# Transmission  
#### 记录一些坑  
#### fork from https://www.moerats.com/archives/186/
    安装Transmission  
    测试系统为Debian 8 X64，运行命令：  
    `wget --no-check-certificate https://www.moerats.com/usr/down/debian-transmission.sh
sh debian-transmission.sh`  
![Alt text](https://github.com/yanshibin/Transmission/blob/master/Transmission(1).png "Optional title")

>设置Debian源:  
>echo "deb http://ftp.debian.org/debian/ sid main" >> /etc/apt/sources.list  
>echo "deb http://ftp.debian.org/debian/ experimental main" >> /etc/apt/sources.list  
>更新源和安装Transmission：  

>apt-get update  
>apt-get -t experimental install transmission-daemon -y  
>echo "APT::Default-Release \"stable\";" >> /etc/apt/apt.conf.d/71distro  
>上面最后第三行的意思是，让你在用APT安装其他软件包的时候，使用的是稳定版，而不是最新版。  


**由于脚本里有`echo "APT::Default-Release \"stable\";" >> /etc/apt/apt.conf.d/71distro  `所以在debian 8 使用此脚本后运行 apt update会更新不了 需要再运行一次`echo "APT::Default-Release \"jessie\";" >> /etc/apt/apt.conf.d/71distro  `**
>停止和启动Transmission：  

有些时候咱们不希望运行，或者，需要修改配置文件，则需要停止Transmission先，修改之后再启动。  

停止：`/etc/init.d/transmission-daemon stop`  
启动：`/etc/init.d/transmission-daemon start `   
>Transmission配置文件：


一个名为settings.json咱们非常熟悉的Transmission配置文件，路径为：  

`/var/lib/transmission-daemon/info/settings.json`  
修改其中的各个选项，例如dht-enabled，download-dir，rpc-password，rpc-port，rpc-whitelist-enabled等等。之后再启动Transmission。  

如果你觉得修改配置文件特别的麻烦，你特别的不爽。这里有个配置文件，如下操作：  

`/etc/init.d/transmission-daemon stop`  
`wget http://dadi.me/wp-content/uploads/dir/Transmission/settings.json`    
`mv -f settings.json /var/lib/transmission-daemon/info/`    
`/etc/init.d/transmission-daemon start`      
>唔，这样就可以了，再来写一下默认的用户名及端口等。    

端口为2012，可以通过ip地址，加上2012访问Web管理页面：ip:2012；  
默认的用户名及密码为：dadi.me。  
默认的文件下载目录为：/home/transmission/Downloads/  
创建文件目录，赋予权限：

>上面提到下载目录，所以要建立这个目录，如果你修改成其他目录的话，则替换：  


`mkdir -p /home/transmission/Downloads/`  
`chmod -R 777 /home/transmission/Downloads/`  
这样就可以了。  
