#!/usr/bin/python3

# This script builds curl calls from a manually extracted extreact of logcat.
# Basically cut and paste a piece that starts with https up to the last header
# into a file and call this script with the file.
# It is not as automated as taillogcat.py


from os import environ as env
from sys import argv, exit


if __name__ == "__main__":
    count = len(argv)
    filename = ""
    if count != 2 or count == 2 and argv[1] in ['-h', '--help']:
        print(f"Usage: {argv[0]} <file name>")
        exit(0)
    else:
        filename = argv[1]
    home = env.get('HOME')
    with open(f'{home}/bin/{filename}', 'r') as f:
        header = []
        url = ""
        for count, line in enumerate(f, start=1):
            if count == 1:
                url = line[:-1]
                url = url[url.find('http'):]
            else :
                line = line.lstrip()[:-1].rstrip()
                if line == "---":
                    continue
                header.append(f"-H '{line}' ")
        curl_cmd = "curl -i "
        for hdr in header:
            curl_cmd = curl_cmd + hdr
        curl_cmd = curl_cmd + f' -X GET "{url}"'
        print(f"Building curl request from {filename}")
        print(curl_cmd)
