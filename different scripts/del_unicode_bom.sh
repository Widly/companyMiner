#!/bin/bash
cd '/home/igor/Документы/fias_xml'
for file in `ls -1 *XML`;
do
	echo $file;
	sed -i '1,1s/\xef\xbb\xbf//' $file;
done

exit 0