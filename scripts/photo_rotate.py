#!/usr/bin/env python3

import argparse

import piexif


def photo_rotate(img_path):
    exif_dict = piexif.load(img_path)

    # 3: 180度旋转
    # 6: 顺时针旋转90度
    # 8: 逆时针旋转90度
    exif_dict['0th'][piexif.ImageIFD.Orientation] = 8

    exif_bytes = piexif.dump(exif_dict)
    piexif.insert(exif_bytes, img_path)


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('img_paths', nargs='+')
    args = parser.parse_args()

    for img_path in args.img_paths:
        photo_rotate(img_path)
