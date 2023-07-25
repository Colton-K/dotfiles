#!/bin/python3

import sys
import boto3
import os

# check if less than 2 argments
if len(sys.argv) < 2:
    print("usage: backup.py <item_name> (optional: <bucket_name>)")
    sys.exit(1)
elif len(sys.argv) < 3:
    bucket_name = "myawsstorage-colton"
else:
    bucket_name = sys.argv[2]

# take an input argument for the folder name
item_name = sys.argv[1]

# check if valid bucket
def check_bucket(bucket_name):
    s3 = boto3.client('s3')
    try:
        s3.head_bucket(Bucket=bucket_name)
    except:
        print(f"Bucket name {bucket_name} is invalid")
        sys.exit(1)

# upload files in folder
def upload_folder(root, bucket_name):
    s3 = boto3.client('s3')
    for file in os.listdir(root):
        # if directory, recurse
        if os.path.isdir(root + '/' + file):
            upload_folder(root + '/' + file, bucket_name)
            continue
        else:
            s3.upload_file(root + '/' + file, bucket_name, root + '/' + file)

    print(f'Done uploading files from {root}')

def upload_file(file, bucket_name):
    s3 = boto3.client('s3')

    s3.upload_file(file, bucket_name, file)

def download_folder(folder, bucket_name):
    s3 = boto3.client('s3')
    for file in s3.list_objects(Bucket=bucket_name)['Contents']:
        if file['Key'].startswith(folder):
            s3.download_file(bucket_name, file['Key'], file['Key'])

    print(f'Done downloading files from {bucket_name}')

def download_file(folder, file_name):
    s3 = boto3.client('s3')
    s3.download_file(file_name, file['Key'], file['Key'])

if __name__ == '__main__':
    check_bucket(bucket_name)

    # if folder exists, upload it, otherwise download it
    if not os.path.exists(item_name):
        if os.path.isfile(item_name):
            download_file(item_name, bucket_name)
        else:
            download_folder(item_name, bucket_name)
    else:
        if os.path.isfile(item_name):
            upload_file(item_name, bucket_name)
        else:
            upload_folder(item_name, bucket_name)
