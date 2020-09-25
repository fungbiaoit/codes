from bs4 import BeautifulSoup  # 网页解析，获取数据
import re  # 正则表达式，进行文字匹配
import urllib.request, urllib.error  # 制定URL，获取网页数据
import xlwt  # 进行Excel操作
import sqlite3  # 进行SQLite数据库操作


def main():
    baseurl = "https://movie.douban.com/top250?start=0"
    # 爬取网页
    datalist = getData(baseurl)
    # 解析数据
    # 保存数据
    savepath = r"./豆瓣电影top250.xls"
    saveData(datalist, savepath)


# 影片详细链接的规则
findLink = re.compile(r'<a href="(.*?)">')  # 创建正则表达式对象，表示规则（字符串模式）
# 影片片名
findName = re.compile(r'<span class="title">(.*?)</span>', re.S)
# 影片图片
findImg = re.compile(r'<img.*src="(.*?)"', re.S)  # re.S让换行符包含在字符中
# 影片评分
findScore = re.compile(r'<span class="rating_num" property="v:average">(.*?)</span>')
# 评价人数
findJuge = re.compile(r'<span>(\d*)人评价</span>')
# 概况
findInq = re.compile(r'<span class="inq">(.*)</span>')


# 爬取网页
def getData(baseurl):
    datalist = []
    for i in range(0, 10):  # 循环发送请求，获取分页数据
        url = baseurl + str(i * 25)
        html = askURL(url)
        # 逐一解析数据
        soup = BeautifulSoup(html, "html.parser")
        for item in soup.find_all("div", class_="item"):  # 查找符合要求的字符串，形成列表
            data = []  # 保存一部电影的所有信息
            item = str(item)
            name = re.findall(findName, item)
            link = re.findall(findLink, item)[0]  # re库用来通过正则表达式查找指定的字符串
            img = re.findall(findImg, item)[0]
            score = findScore.findall(item)[0]  # re另一种使用方式
            juge = findJuge.findall(item)[0]
            inq = findInq.findall(item)

            if len(name) != 1:
                data.append(name[0])
                data.append(name[1].replace("\xa0", "").replace("/", ""))
            else:
                data.append(name[0])
                data.append(" ")  # 没有外文名，留空

            data.append(link)
            data.append(img)
            data.append(score)
            data.append(inq)
            data.append(juge+"人评分")
            datalist.append(data)
    return datalist


# 得到指定一个url的网页内容
def askURL(url):
    head = {  # 模拟浏览器头部信息，向豆瓣服务器发送消息，部分网站会有反爬虫检测
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36"
    }
    request = urllib.request.Request(url=url, headers=head)
    try:
        response = urllib.request.urlopen(request)
        html = response.read().decode("utf-8")
    except Exception as result:
        print(result)

    return html


# 保存数据
def saveData(datalist, savepath):
    book = xlwt.Workbook(encoding="utf-8")
    sheet = book.add_sheet("豆瓣电影top250", cell_overwrite_ok=True)
    col = ("影片中文名", "影片外文名", "电影详细链接", "图片链接", "评分", "概述", "评分人数")
    for i in range(0, 7):
        sheet.write(0, i, col[i])  # 列名
    for i in range(0, 250):
        print("第{}条".format(i + 1))
        data = datalist[i]
        for j in range(0, 7):
            sheet.write(i + 1, j, data[j])
    book.save(savepath)


if __name__ == '__main__':
    main()
