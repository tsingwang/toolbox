#!/usr/bin/env python3

import argparse
import shutil
from pathlib import Path

import exifread


def photo_classify(source_dir, destination_dir):
    source_dir = Path(source_dir)
    destination_dir = Path(destination_dir)
    for source_file in source_dir.rglob('*'):
        if not source_file.is_file():
            continue

        with open(source_file, 'rb') as f:
            tags = exifread.process_file(f)
        if 'EXIF DateTimeOriginal' not in tags:
            continue

        time = str(tags['EXIF DateTimeOriginal'])
        date = time.split(':')[0] + '-' + time.split(':')[1]
        destination_file = destination_dir / date / source_file.name
        if not destination_file.parent.exists():
            destination_file.parent.mkdir(parents=True, exist_ok=True)
        shutil.move(str(source_file), str(destination_file))


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('source_dir')
    parser.add_argument('destination_dir')
    args = parser.parse_args()

    photo_classify(args.source_dir, args.destination_dir)
