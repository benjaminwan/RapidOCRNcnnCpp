#!/bin/bash
## script for 内存泄露检查
# ========== macOS ==========
# https://github.com/LouisBrunner/valgrind-macos
# brew tap LouisBrunner/valgrind
# brew install --HEAD LouisBrunner/valgrind/valgrind
# ========== linux ==========
# https://www.valgrind.org/
# apt install valgrind

NUM_THREADS=1

set OMP_NUM_THREADS=$NUM_THREADS

TARGET_IMG=images/1.jpg
if [ ! -f "$TARGET_IMG" ]; then
echo "找不到待识别的目标图片：${TARGET_IMG}，请打开本文件并编辑TARGET_IMG"
exit
fi

##### run test on MacOS or Linux
valgrind --tool=memcheck --leak-check=full --leak-resolution=med --track-origins=yes --vgdb=no --log-file=valgrind-memcheck.txt \
./build/BaiPiaoOcrNcnn --models models \
--det ch_ppocr_mobile_v2.0_det_infer \
--cls ch_ppocr_mobile_v2.0_cls_infer \
--rec ch_ppocr_server_v2.0_rec_infer \
--keys ppocr_keys_v1.txt \
--image $TARGET_IMG \
--numThread $NUM_THREADS \
--padding 0 \
--maxSideLen 1024 \
--boxScoreThresh 0.5 \
--boxThresh 0.3 \
--unClipRatio 1.5 \
--doAngle 1 \
--mostAngle 1
