#!/bin/bash
cd '/home/igor/Документы/fias_HOUSE_divided_csv'
for file in `ls -1 *csv`;
do
	echo $file;
	sed -i '1d' $file;
done

exit 0