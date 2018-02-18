# Transmission  
#### 记录一些坑  
#### fork from https://www.moerats.com/archives/186/
    安装Transmission  
    测试系统为Debian 8 X64，运行命令：  
    `wget --no-check-certificate https://www.moerats.com/usr/down/debian-transmission.sh
sh debian-transmission.sh`
>设置Debian源:  
>echo "deb http://ftp.debian.org/debian/ sid main" >> /etc/apt/sources.list  
>echo "deb http://ftp.debian.org/debian/ experimental main" >> /etc/apt/sources.list  
>更新源和安装Transmission：  

>apt-get update  
>apt-get -t experimental install transmission-daemon -y  
>echo "APT::Default-Release \"stable\";" >> /etc/apt/apt.conf.d/71distro  
>上面最后第三行的意思是，让你在用APT安装其他软件包的时候，使用的是稳定版，而不是最新版。  
#### 由于脚本里有`echo "APT::Default-Release \"stable\";" >> /etc/apt/apt.conf.d/71distro  `所以在debian 8 使用此脚本后运行 apt update会更新不了 需要再运行一次`echo "APT::Default-Release \"jessie\";" >> /etc/apt/apt.conf.d/71distro  `  
