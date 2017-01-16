# -*- coding: UTF-8 -*-

from pdfminer.pdfinterp import PDFResourceManager, PDFPageInterpreter
from pdfminer.converter import TextConverter
from pdfminer.layout import LAParams
from pdfminer.pdfpage import PDFPage
from cStringIO import StringIO

def convert_pdf_to_txt(path, maxPages, firstPageNum  = 0):
    rsrcmgr = PDFResourceManager()
    retstr = StringIO()
    codec = 'utf-8'
    laparams = LAParams()
    device = TextConverter(rsrcmgr, retstr, codec=codec, laparams=laparams)
    fp = file(path, 'rb')
    interpreter = PDFPageInterpreter(rsrcmgr, device)
    password = ""
    maxpages = maxPages
    firstPage = firstPageNum
    caching = True
    pagenos=set()

    pages = [x for x in PDFPage.get_pages(fp, pagenos, maxpages=maxpages, password=password,caching=caching, check_extractable=True)]
        
    if (firstPage > len(pages)):
    	firstPage = len(pages)

    for i in range(firstPage, len(pages)):
        interpreter.process_page(pages[i])

    text = retstr.getvalue()

    fp.close()
    device.close()
    retstr.close()
    return text