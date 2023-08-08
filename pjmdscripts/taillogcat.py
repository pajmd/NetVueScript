#!/usr/bin/python3

# This script parses the AndroidStudio logcat file obtained with the following command:
# From the AndroidStudio terminal:
# C:\Users\pjmd\AppData\Local\Android\Sdk\platform-tools\adb logcat > c:\temp\motog6.log
#
# The scripts extracts only the lines for Netvue PID (you need to find out what it is)
# - It ouputs these lines in a logcat.log file located in this script folder
# - It extracts all the Http GET requests made by Netvue and executes a curl command for these requests.

from os import environ as env
from sys import argv, exit
import subprocess


if __name__ == "__main__":
    count = len(argv)
    filename = ""
    pid = ""
    if count != 3 or count == 2 and argv[1] in ['-h', '--help']:
        print(f"Usage: {argv[0]} <file name> <pid>")
        exit(0)
    else:
        filename = argv[1]
        pid = argv[2]
    home = env.get('HOME')
    with open(f'{home}/{filename}', 'r', encoding='UTF-16LE') as f:
        header = []
        proc_args = ["/usr/bin/curl", "-i"]
        url = ""
        bStart = False
        with open('logcat.log', 'w') as fw:
            for count, line in enumerate(f, start=1):
                if f' {pid} ' in line:
                    # print(line, end="")
                    fw.write(line)
                    line = line[: -1]
                    if 'Request :' in line:
                        # print(line)
                        if '--> [GET]' in line and not bStart:
                            # print(f'found url in : {line}')
                            bStart = True
                            url = line[line.find('http'):]
                            # print(url)
                            continue
                        if bStart:
                            if '---' in line:
                                continue
                            if 'Request : --> [GET] END' in line:
                                bStart = False
                                # Print request
                                if header and url:
                                    curl_cmd = "/usr/bin/curl -i "
                                    curl_args = ""
                                    for hdr in header:
                                        curl_args = curl_args + hdr
                                    curl_args = curl_args + f' -X GET "{url}"'
                                    print(f"\n\n{curl_cmd}{curl_args}\n")
                                    # run curl
                                    proc_args.append("-X")
                                    proc_args.append('GET')
                                    proc_args.append(url)
                                    # for a in proc_args:
                                    #     print(a)
                                    subprocess.run(proc_args)
                                    # reinit
                                    header = []
                                    url = ""
                                    proc_args = ["/usr/bin/curl", "-i"]
                            else:
                                pos = line.find("Request : ")
                                length = len("Request : ")
                                header.append(f"-H '{line[pos + length : ]}' ")
                                proc_args.append("-H")
                                proc_args.append(f"'{line[pos + length : ]}'")

            
