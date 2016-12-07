# Diancai
基于sqlite数据库的ipad点菜项目

本系统使用sqlite数据库事项数据的存储，更改，删除等操作。根据饭店的实际要求设计了：主厨推荐和多个分类的点菜页面，选择座位功能，菜单显示，历史菜单等功能。

==========

###<div align = center>Autor:Haven</div>
###<div align = center>E-mail:HavenMailBox@163.com(欢迎骚扰)</div>

==========

##目录

* [GIF图片](#GIF图片)
* [首页](#首页)
* [主页](#主页)
* [点菜页](#点菜页)
* [详细页](#详细页)
* [我的点单页](#我的点单页)
* [送单页](#送单页)
* [历史菜单页](#历史菜单页)
* [数据库页](#数据库页)

==========

GIF图片
----------

![GIF图片](DC_Image/DC_canwei.png)

首页
----------

![首页](DC_Image/DC_souuye.png)

主页
----------

![主页](DC_Image/DC_zhuye.png)

点菜页
----------

分为主厨推荐页和其他选菜页。

![点菜页1](DC_Image/DC_diancaiye1.png)
![点菜页2](DC_Image/DC_diancaiye2.png)

详细页
----------

![详细页](DC_Image/DC_xiangxi.png)

我的点单页
----------

在这个页面上，显示了客人所点的菜名，单价，种类，份数，最下面还有计算好的总价，旁边可以添加一些备注。左滑可以显示删除按钮，对点单上的菜进行删除。

![我的点单页](DC_Image/DC_wodediandan.png)

送单页
----------

![送单页](DC_Image/DC_songdan.png)

![送单页](DC_Image/DC_sdSuccess.png)

历史菜单页
----------

![历史菜单页](DC_Image/DC_lishicaidan.png)

数据库页
----------

数据库使用的是xcode自带的sqliteManager进行数据的操作。一共创建了5个表，分别对菜单，图片，点单，历史菜单等数据进行交互。

![数据库页1](DC_Image/DC_sqlite1.png)
![数据库页2](DC_Image/DC_sqlite2.png)










