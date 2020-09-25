# 网页爬虫

## 思路

​	模拟浏览器访问网页，获取网页数据。

1. 用urllib访问网页，获取网页数据。
2. 用BeautifulSoup解析网页数据。
3. 用xlwt操作Excel保存数据。

## 用到的库

- BeautifulSoup：BeautifulSoup4是爬虫必学的技能，很强大。BeautifulSoup最主要的功能是从网页抓取数据，Beautiful Soup自动将输入文档转换为Unicode编码，输出文档转换为utf-8编码。
- re：正则。
- urllib：提供了一系列用于操作URL的功能。
- xlwt：进行Excel操作。
- sqlite3：进行SQLite数据库操作，本demo中没有实现。

