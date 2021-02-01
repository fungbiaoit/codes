/*
SQLyog Ultimate v12.08 (64 bit)
MySQL - 5.5.59 : Database - ssm_test
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`ssm_test` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `ssm_test`;

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `age` int(11) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `sex` char(1) DEFAULT NULL,
  `city` varchar(10) DEFAULT NULL,
  `birthday` datetime DEFAULT NULL,
  `typeId` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8;

/*Data for the table `user` */

insert  into `user`(`id`,`username`,`age`,`password`,`sex`,`city`,`birthday`,`typeId`) values (22,'admin',23,'236ce00ee199c5154a20394513846831','男','武汉','2021-01-21 00:00:00',1),(26,'李四',33,'111','女','上海','2021-01-21 00:00:00',2),(51,'22',22,NULL,'男','11','2021-01-22 00:00:00',2),(52,'张三',222,NULL,'女','河北','2021-01-22 00:00:00',5),(53,'呵呵',222,NULL,'女','河北','2021-01-23 00:00:00',5),(64,'赵六',22,NULL,'男','武汉','2021-01-31 00:00:00',3);

/*Table structure for table `usertype` */

DROP TABLE IF EXISTS `usertype`;

CREATE TABLE `usertype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `usertype` */

insert  into `usertype`(`id`,`name`) values (1,'管理员'),(2,'超级会员'),(3,'会员'),(4,'普通用户'),(5,'游客');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
