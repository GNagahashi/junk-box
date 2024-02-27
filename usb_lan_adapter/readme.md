```
export FILENAME_BEFORE_EXTRACT=$(curl -s -I https://www.asix.com.tw/en/support/download/file/1522 | awk '/attachment/ {print $3}' | sed -e 's/filename=//' -e 's/[\n\r]//g')
```

```
curl -s -o $FILENAME_BEFORE_EXTRACT https://www.asix.com.tw/en/support/download/file/1522
```

```
export FILENAME_AFTER_EXTRACT=$(tar -jxvf $FILENAME_BEFORE_EXTRACT | awk 'NR == 1 {print $0}' | sed 's/\///')
```

```
cd $FILENAME_AFTER_EXTRACT
```

```
make && sudo make install
```

```
sudo modprobe ax_usb_nic
```

```
cd ../ && rm $FILENAME_BEFORE_EXTRACT && rm -rf FILENAME_AFTER_EXTRACT
```