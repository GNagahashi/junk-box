URL='https://www.asix.com.tw/en/support/download/file/1522'
FILENAME_BEFORE_EXTRACT=''
FILENAME_AFTER_EXTRACT=''

echo '>> Download USB-LAN adapter driver'
FILENAME_BEFORE_EXTRACT=$(curl -s -I ${URL} | awk '/attachment/ {print $3}' | sed -e 's/filename=//' -e 's/[\n\r]//g')
echo '   filename:' ${FILENAME_BEFORE_EXTRACT}
curl -s -o ${FILENAME_BEFORE_EXTRACT} ${URL}

echo '>> Extract file'
FILENAME_AFTER_EXTRACT=$(tar -jxvf ${FILENAME_BEFORE_EXTRACT} | awk 'NR == 1 {print $0}' | sed 's/\///')
echo '   filename:' ${FILENAME_AFTER_EXTRACT}

echo '>> Compile driver'
cd ${FILENAME_AFTER_EXTRACT}
make

echo '>> Install driver'
sudo make install

echo '>> Load driver'
sudo modprobe ax_usb_nic

echo '>> Remove files'
echo '-' ${FILENAME_BEFORE_EXTRACT}
rm ${FILENAME_BEFORE_EXTRACT}
echo '-' ${FILENAME_AFTER_EXTRACT}
rm -rf ${FILENAME_AFTER_EXTRACT}