from os import getcwd
import os.path as path
import scrapy # type:ignore


if (__cwd__ := getcwd()).endswith("src"):
    __cwd__ = path.normpath(__cwd__ + "/..")


class CPUCrawler(scrapy.Spider):
    name = ""
