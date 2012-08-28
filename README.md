webee.github.com
================

my blog based on github pages, powered by hyde.

分类：

* blog: 博客文章
* project: 项目信息
* tags: 标签云
* about: 关于我
* feed: rss订阅

实现：

* 分页
* 评论
* tag,tag-archive,tag-cloud

工具：
publish.sh: 生成，并发布
try.sh: 生成，并在本地运行
tools/run.sh：运行及代理
tools/src/proxy.c: 代理工具
tools/src/connect.c: 代理转换

TODO:

* 修改feed格式
* site-map
* blog
* just blog.
* local player:
    1. read files will use large memory.
       just read a file include filepath list.
    2. add url support.
