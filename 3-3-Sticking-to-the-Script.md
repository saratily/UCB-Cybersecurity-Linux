# 3.3: Sticking-to-the-Script

- [3.3: Sticking-to-the-Script](#33--sticking-to-the-script)
  * [Overview](#overview)
  * [Text processing](#text-processing)
  * [sed - substitutre editor](#sed---substitutre-editor)
    + [DEMO - sed](#demo---sed)
    + [ACTIVITY - 06 sed activity](#activity---06-sed-activity)
  * [awk - isolate fields](#awk---isolate-fields)
    + [DEMO -  awk for a Security Incident](#demo----awk-for-a-security-incident)
    + [ACTIVITY - 09 awk activity](#activity---09-awk-activity)
  * [Shell scripting](#shell-scripting)
  * [Text editors - nano, vi, vim, emac (vi and emac are competitors)](#text-editors---nano--vi--vim--emac--vi-and-emac-are-competitors-)
    + [DEMO - My First Shell Script](#demo---my-first-shell-script)
    + [ACTIVITY - 14 shell scripting](#activity---14-shell-scripting)
  * [Passing Arguments](#passing-arguments)
    + [ACTIVITY - 17 ip lookup activity](#activity---17-ip-lookup-activity)

<small><i><a href='http://ecotrust-canada.github.io/markdown-toc/'>Table of contents generated with markdown-toc</a></i></small>

## Overview
sed - make substitute to a file
awk - isolate data points from a complex log file
nano - content editor
shell script by passing arguments (e.g. IP lookup)

## Text processing
- analyzing app logs, server logs, configs and research security incidences
-- e.g date, username, phone number, etc
- We can use this data to 
-- Isolate attack signatures
-- Identify attack vectors
-- Identify timing of attacks

## sed - substitutre editor
- reads and edit text line by line
- When 2 files use different words for same thing, sed is useful to standardize both files
e.g. 1 app label login -> logged_in
another app label login -> access_accepted

```
sed s/<old_value>/ /<new_value>/
```

### DEMO - sed
- sed is a text processing utility that can help security professionals analyze data.
- The most basic sed capability is string replacement.
- This can help with research by making disparate data sources more consistent.

1. Navigate to /03-instructor/day3/sed_demonstration/
```
$ cd /03-instructor/day3/sed_demonstration/

$ ls -l
total 4
-rw-r--r-- 1 instructor instructor 24 Oct 21  2022 sed.txt

$ cat sed.txt 
The Dog Chased the Ball
```

2. Replace Ball with Cat
```
$ echo "I have a Ball" | sed s/Ball/Cat/
I have a Cat

$ cat sed.txt| sed s/Ball/Cat/
The Dog Chased the Cat

OR
$ sed s/Ball/Cat/ sed.txt
The Dog Chased the 

OR - if there is a space or number in word/phrase
sed s/"the Ball"/"a Cat"/ sed.txt 
The Dog Chased a Cat
```


### ACTIVITY - 06 sed activity
- You continue in your role as security analyst at Wonka Corp.
- Your manager suspects a new cybercriminal is attempting to log in to several administrative websites owned by Wonka.
- They provided you with the access logs for two different websites.
- You must combine the two access logs into a single file and use text processing to make the “failed login” data consistent.

1. Navigate to /03-student/day3/learning_sed
```
$ cd /03-student/day3/learning_sed
$ ls -l
total 44
-rw-r--r-- 1 sysadmin sysadmin  9903 Oct 21  2022 Admin_logA.txt
-rw-r--r-- 1 sysadmin sysadmin 10153 Oct 21  2022 Admin_logB.txt
-rw-r--r-- 1 sysadmin sysadmin 20056 Oct 21  2022 combined
```

2. Within this directory are two log files from different administrative websites.

Combine the two log files into a single log file called Combined_Access_logs.txt.
Note: Use the file named combined to check your work.
```
$ cat Admin_logA.txt Admin_logB.txt > Combined_Access_logs.txt
```

3. Failed logins are titled as ACCESS_DENIED or INCORRECT_PASSWORD.

Using sed, replace all instances of INCORRECT_PASSWORD with ACCESS_DENIED so the data is consistent.
```
$ sed s/INCORRECT_PASSWORD/ACCESS_DENIED/ Combined_Access_logs.txt 
```

4. Save the results to a new file called 
```
$ sed s/INCORRECT_PASSWORD/ACCESS_DENIED/ Combined_Access_logs.txt > Update1_Combined_Access_logs.txt
```


## awk - isolate fields
```
awk -F(delimiter) '{print $(field_number)}'
delimiter - By default awk separate fields by space , could be comma, or semi-colon ;
```

### DEMO -  awk for a Security Incident
In this demo, we’ll act as security analysts at ACME Corp, which just experienced an attack of a high volume of network requests. You received the logs of these network requests.

You must isolate out the IP addresses and time from these logs to determine which IP address appears most frequently. This IP likely belongs to the attacker

awk is a text processing utility like sed, but more robust. It can separate out fields with simple code.
Security professionals can use awk to isolate specific data points, like IP addresses. This info can help determine what IPs should be blocked.
The basic syntax of field separation with awk is:
awk -F(delimiter) '{print $(field_number)}'

1. Navigate to /03-instructor/day3/awk_demonstration/
```
$ cd /03-instructor/day3/awk_demonstration/
$ ls -l
total 40
-rw-r--r-- 1 instructor instructor 35363 Oct 21  2022 access_logs
-rw-r--r-- 1 instructor instructor    22 Oct 21  2022 awk.txt
```

2. Print Georgia using awk
```
$ cat awk.txt 
Atlanta, Georgia, USA

awk '{print $2}' awk.txt  --- if separate by space
Georgia,

$ awk -F , '{print $2}' awk.txt --- if separate by comma
Georgia
```
3. Isolate usename and time from access_log
```
$ head -1 access_logs 
41.33.233.87 [19/Jan/2019:11:25:11] JulieJones LOGIN 400 filestructure:/internaldirectory/ :http://www.bizbizCorp-wc.com/ Mozilla/5.0 (Windows NT 6.0; rv: 34.0) Gecko/20

$ awk '{print $3, $2}' access_logs
```

### ACTIVITY - 09 awk activity

- You continue in your role as security analyst at Wonka Corp.
- Your manager needs your help finding information on the cybercriminal attempting to log in to administrative websites owned by Wonka.
- You must isolate several fields from the log file to help determine the primary username attempting to log in.

1. Move Update1_Combined_Access_logs.txt into the directory /03-student/day3/learning_awk.
```
mv /03-student/day3/learning_sed/Update1_Combined_Access_logs.txt /03-student/day3/learning_awk

$ head -1 Update1_Combined_Access_logs.txt 
109.169.248.247 - - [12/Dec/2015:18:25:11] ACCESS_DENIED MikeJones  HTTP/1.1" 200 4263 "-" "Mozilla/5.0 (Windows NT 6.0; rv:34.0) Gecko/20100101 Firefox/34.0" "-"
```

2. Use the awk command to isolate the time and username fields out from this file.
```
$awk '{print $4, $6}' Update1_Combined_Access_logs.txt 
```

3. Use redirection to place these results into a new file called Update2_Combined_Access_logs.txt.
```
$ awk '{print $4, $6}' Update1_Combined_Access_logs.txt > Update2_Combined_Access_logs.txt
```

## Shell scripting
- efficiency, consistency, reusability
- Different shells
-- sh - oldest
-- bash - original - mostly used
-- zsh - for offensive testing
-- csh 

- always start a bash script with sh-bang or majic number - that is how linux know how to run this program
```
#!/bin/bash 
```

## Text editors - nano, vi, vim, emac (vi and emac are competitors)

### DEMO - My First Shell Script 
```
nano diskcleanup.sh

#!/bin/bash
cd log_directory
zip logfiles.zip Log*.txt
mv logfiles.zip ./archive_directory

chmod +x diskcleanup.sh
./diskcleanup.sh
```

### ACTIVITY - 14 shell scripting
You continue in your role as security analyst at Wonka.
- Your manager needs help creating a simple shell script to automate the awk and sed tasks you did today on your log file.
- This shell script will be provided to other security analysts so they can easily complete the same tasks.
- You are tasked with using nano to create a shell script with the awk and sed commands to analyze a log file.

1. navigate to  /03-student/day3/first_shell_script/
```
$ cd /03-student/day3/first_shell_script/

$ ls -l
total 20
-rw-r--r-- 1 sysadmin sysadmin 20056 Oct 21  2022 LogA.txt
```

2. Within this directory is a log file to analyze called LogA.txt. Use nano to create a script called Log_analysis.sh.
```
$ head -1 LogA.txt 
109.169.248.247 - - [16/DEC/2015:18:25:11] ACCESS_DENIED MikeJones  HTTP/1.1" 200 4263 "-" "Mozilla/5.0 (Windows NT 6.0; rv:34.0) Gecko/20100101 Firefox/34.0" "-"

$ nano Log_analysis.sh

```

3. Within this script, place the sed command and awk command used in the previous activities to analyze the LogA.txt file.
```
#!/bin/bash

```
4. When using your sed command from the previous activity, send the results to a new file named access_denied.txt.
```
sed s/INCORRECT_PASSWORD/ACCESS_DENIED/ LogA.txt > access_denied.txt
```

5. When using your awk command from the previous activity, send the results to a new file named filtered_logs.txt.
```
awk '{print $4, $6}' Update1_Combined_Access_logs.txt > filtered_logs.txt
```

6. Run the command to confirm the commands run as expected.
```
$ chmod +x Log_analysis.sh
./Log_analysis.sh
```

## Passing Arguments
- Provide argument at run time from the terminal
```
./diskcleanup.sh 0519
OR
sh diskcleanup.sh 0519
```
Note: $1 will be used to represent 0519 in the script
$0 will be use to represent ./diskcleanup.sh OR diskcleanup.sh respectively

### ACTIVITY - 17 ip lookup activity

In this activity, you continue in the role of security analyst at Wonka.
- Your manager needs to know where attacks are coming from so that they can block the country from accessing their network.
- Your manager is impressed with the great work you did on the last script and asked you to design a script to identify the countries of IP addresses found in the logs.


1. You have been provided a new command to look up details for an IP address: 
- To look up information on the IP of 104.223.95.86, you would run:
```
$ curl -s http://ipinfo.io/104.223.95.86
{
  "ip": "104.223.95.86",
  "hostname": "unassigned.quadranet.com",
  "city": "Atlanta",
  "region": "Georgia",
  "country": "US",
  "loc": "33.7525,-84.3888",
  "org": "AS8100 QuadraNet Enterprises LLC",
  "postal": "30303",
  "timezone": "America/New_York",
  "readme": "https://ipinfo.io/missingauth"
}

```
Hint: Read the man page of the curl command to learn more about what it can do.

2. Using  pipes, grep, and awk, modify the curl command to display only the country.
```
$ curl -s http://ipinfo.io/104.223.95.86 | grep country
  "country": "US",
```
Hints: Use grep to display only the line that contains the country.

3. Use awk to parse out the country from that line.
```
$ curl -s http://ipinfo.io/104.223.95.86 | grep country |awk -F : '{print $2}'
 "US",
```

4. Place the command into a new shell script called IP_lookup.sh.
```
$ nano IP_lookup.sh

#!/bin/bash
curl -s http://ipinfo.io/104.223.95.86 | grep country |awk -F : '{print $2}'
```

5. Modify the script so the IP address is an argument that can be passed into the script.
```
#!/bin/bash
curl -s http://ipinfo.io/$1 | grep country |awk -F : '{print $2}'
```

6. The following IP addresses were found in Wonka's log files. Run your new  IP_lookup.sh with these IP addresses as arguments to determine their countries:

IP 1: 133.18.55.255
```
$ ./IP_lookup.sh 133.18.55.255
 "JP",
```

IP 2: 41.34.55.255
```
$ ./IP_lookup.sh  41.34.55.255
 "EG",
```

IP 3: 187.54.23.8
```
$ ./IP_lookup.sh 187.54.23.8
 "BR",
```