# 3-2:Commanding-the-Command-Line.md

  * [cmd format](#cmd-format)
  * [man pages](#man-pages)
  * [find](#find)
    + [DEMO - find](#demo---find)
    + [ACTIVITY - 09 finding your way](#activity---09-finding-your-way)
  * [grep](#grep)
    + [DEMO - grep](#demo---grep)
    + [ACTIVITY - 13 grep activity](#activity---13-grep-activity)
  * [wc to count](#wc-to-count)
    + [ACTIVITY - 06 learning new commands](#activity---06-learning-new-commands)
  * [Pipe operator](#pipe-operator)
    + [DEMO](#demo)
    + [ACTIVITY - 16 Gathering Evidence](#activity---16-gathering-evidence)

<small><i><a href='http://ecotrust-canada.github.io/markdown-toc/'>Table of contents generated with markdown-toc</a></i></small>

## Overview
- man pages - to explore cmd and its options
- find - to locate file based on search parameter 
- grep - search within file content
- wc - count lines or worfs
- pipe operator (|) -  to combine multiple cmd
- xde-open - to open image file from cmd line

## cmd format
```
<command> <arguments>
e.g. 
touch hello.txt
OR
ls -S    -> list files, sort by file size, large to small

<command> <option> <value/parameter> <filename>
e.g. head -n 4 logfile
cmd = head
option = -n
parameter = 4
```

## man pages
- brief description about cmd, and its options
``` man ls ```

## find 
runs for searching file names or dir

``` 
find <location> -type <type> -name <filename/dir>

location - by default current dir, can specify relative or abs path
type - f for file, d for dir
name - can use iname for case insensitive search
filename/dir - can use wildcard, enclosed in single quotes e.g. '*.txt'0
```

Note: file cmd can run on allowed folders, not in RESTRICTED. to avoid permission denied error
```
command &>/dev/null
```

### DEMO - find
- Your manager at ACME has tasked you with finding logs for a certain type of web server called Apache, for the date of October 13th.
- They told you that the directory should be named apache and the log files should have the date noted as 1013 in their file names.
- Since there are many directories, you will use the find command to complete these tasks.
```
cd /03-instructor/day2/find_demonstration

find -type d
.
./nginx
./apache
./IIS

find -type d -name logs


find -type d -iname logs

- find apache log for date 1013 in their file names. 
find -type f -iname '*1013*'
./apache/1013_backuplogs
./apache/apache_1013

$ find -iname '*apache*'
./apache
./apache/apache_1013
./apache/apache_1014
./apache/apache_1015

$ find -iname '*1013*'
./apache/1013_backuplogs
./apache/apache_1013


find /root/desktop -type d -iname logs
```


### ACTIVITY - 09 finding your way
- Your manager at Wonka Corp has tasked you with searching through the PeanutButtery.net server’s files and file directories to uncover secret recipes they believe are hidden in the file system.

1. Navigate into the PeanutButtery.net directory.
```
cd /03-student/day2/finding_your_way/PeanutButtery.net
```

2. Find all directories that have the word "secret" in their directory name.
```
find -type d -iname '*secret*'
./other/disregard/wonkasecretrecipes
```

3. Find all files that have the word "recipe" in their file name.
```
find -type f -iname '*recipe*'
./other/disregard/wonkasecretrecipes/recipe_peanutballs
./other/disregard/wonkasecretrecipes/recipe_yumbars
./other/disregard/wonkasecretrecipes/recipe_peanutsquares
./other/disregard/wonkasecretrecipes/recipe_crunchybars
```

4. Bonus:
Use a single command to find all the files that have the words "recipe" and "peanut" in their name.
```
$ find -iname '*recipe*' -iname '*peanut*'
./PeanutButtery.net/other/disregard/wonkasecretrecipes/recipe_peanutballs
./PeanutButtery.net/other/disregard/wonkasecretrecipes/recipe_peanutsquares
```

## grep
- global regular expression print
- search for data inside of files.
-  by default returns the entire line that the desired data is found in.
-  by default will only search for data in the current directory, not subdirectories.

``` 
grep <options> <word> <file>
<options>
    |_ -i = case insensetive
    |_ -l = list file name 
    |_ -r recursively, by default, not recursive
<word> - search string
<file> can use wildcard for file name, e.g. *, or *.txt
```

### DEMO - grep 
- Your manager has now asked for your help with a security investigation into an illegal money transfer that took place on May 17.
- The suspect, Sally Stealer, stated that she has never logged in to the company's banking website and that she definitely did not transfer any money on 0517.
- You must use the grep command to search the application logs to see if Sally Stealer logged in on that day and, if so, when she transferred funds.

1. Navigate to /03-instructor/day2/grep_demonstration
``` 
$ cd /03-instructor/day2/grep_demonstration
```

2. Find logs that have Sallystealer entries
```
$ grep -il Sallystealer *
banklogs0517
banklogs0519
```

3. List entries/ lines from logs that have Sallystealer
```
$ grep -i Sallystealer *
banklogs0517:87.169.99.232 - - [17/May/2015:10:05:59 +0000] "SALLYSTEALER : Login:  Bankingsite/mainpage/presentations/puppet-at-loggly/puppet-at-loggly.pdf.html HTTP/1.1" 200 24747 "https://www.google.de/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/32.0.1700.107 Safari/537.36"
banklogs0517:81.220.24.207 - - [17/May/2015:10:05:52 +0000] "SALLYSTEALER : Transfer funds : $1,000,754 from Company DDA 012  to Personal SAV 876:  
banklogs0519:89.182.254.89 - - [19/May/2015:11:05:04 +0000] "SALLYSTEALER : Login:  /favicon.ico HTTP/1.1" 200 3638 "-" "Mozilla/5.0 (X11; Linux x86_64; rv:25.0) Gecko/20100101 Firefox/25.0"
```

4. Find lines in logs that have transfer word in it
```
$ grep -i transfer banklogs0517
81.220.24.207 - - [17/May/2015:10:05:52 +0000] "SALLYSTEALER : Transfer funds : $1,000,754 from Company DDA 012  to Personal SAV 876:  

```
### ACTIVITY - 13 grep activity

1. Navigate back into the PeanutButtery.net directory that contained the secret recipes.
```
cd /03-student/day2/finding_your_way/PeanutButtery.net
```

2. Find all recipes that include the word "guavaberries" in their list of ingredients.
```
grep -ril guavaberries *
other/disregard/wonkasecretrecipes/recipe_peanutballs
other/disregard/wonkasecretrecipes/recipe_yumbars
other/disregard/wonkasecretrecipes/recipe_peanutsquares
other/disregard/wonkasecretrecipes/recipe_crunchybars

```


## wc to count
- lines or words inside of files.
```
man wc

wc -l 
```

### ACTIVITY - 06 learning new commands

```
cd /03-student/day2/learning_new_commands/
```

1. Within this directory are log files for each website. Within each log file is a list of IP addresses.

Each line represents an hour.
Each line includes the IP addresses connecting to the website during that hour.

Using manpages, research how to use the wc command to count the total number of IP addresses in each file.

```
$ wc -w Chocolateyfun.com 
157 Chocolateyfun.com
$ wc -w GummyGummy.com 
111 GummyGummy.com
$ wc -w PeanutButtery.net 
535 PeanutButtery.net
$ wc -w Stickytoffee.com 
131 Stickytoffee.com
$ wc -w SugaryGoodness.com 
115 SugaryGoodness.com

```

2. Run the command to determine which website had the most network connections and was therefore the likely target of the attack.
```
$ wc -w PeanutButtery.net 
535 PeanutButtery.net
```

3. Bonus - To run the word count command against all the files, you have to use a wildcard: *.
```
wc -w *
  157 Chocolateyfun.com
  111 GummyGummy.com
  535 PeanutButtery.net
  131 Stickytoffee.com
  115 SugaryGoodness.com
 1049 total
```

## Pipe operator

### DEMO

- Our manager at ACME Corp has tasked us with continuing the previous investigation against Sally Stealer. They believe she may have transferred other large amounts of money.
- Our manager created a single file, largetransfers.txt, containing all transfers over one million dollars.
- We must count how many of those transfers belong to Sally Stealer


$ cd /03-instructor/day2/grep_demonstration

$ ls -al
total 68
drwxr-xr-x 2 instructor instructor  4096 Oct 21  2022 .
drwxr-xr-x 7 instructor instructor  4096 Oct 21  2022 ..
-rw-r--r-- 1 instructor instructor 19028 Oct 21  2022 banklogs0517
-rw-r--r-- 1 instructor instructor  9630 Oct 21  2022 banklogs0517b
-rw-r--r-- 1 instructor instructor 26232 Oct 21  2022 banklogs0519


3. Count how many times Sallystealer appears in all the files
```
$ grep -i Sallys * | wc -l
3
```

4. Find 0517 log files, grep sallystealer and count 
```
 find -type f -iname '*0517*' | grep -i Sallys * | wc -l
3

```

### ACTIVITY - 16 Gathering Evidence

- Wonka Corp believes they have enough evidence to send to the authorities to have Slugworth Corp charged with a cyber crime.
- Your task is to gather several points of evidence from your file systems to provide to the authorities to prove Slugworth is stealing data.

```
cd /03-student/day2/Gathering_Evidence 
```


1. In the Gathering_Evidence folder, make a directory called Slugworth_evidence.
```
mkdir Slugworth_evidence
```

2. The email directory contains an archive of emails from the employees.
Place into a  new file called slugworth_email_evidence the following data:

List of emails referencing Slugworth.
``` 
$ grep -ril Slugworth * > slugworth_email_evidence
email/email5
email/email8
email/email7
 ```
Number of emails referencing Slugworth.
```
 grep -ril slugworth * |wc -l  >> slugworth_email_evidence

$ cat slugworth_email_evidence 
email/email5
email/email8
email/email7
0
3
```

Hint: Use the pipe and redirection command to append the additional data to this file.

3. The web_logs directory contains an archive of web log access by date for PeanutButtery.net. The IP of Slugworth, which is a numerical number that identifies an address on the network, is 13.16.23.234.

Place into a  new file called slugworth_web_evidence the following data:
```
cd web_log
```
Which web log file contains the IP address of Slugworth.
$ grep -il 13.16.23.234 * >> slugworth_web_evidence


The number of times Slugworth's IP is found in this file.
```
$ grep -i 13.16.23.234 * | wc -l >> slugworth_web_evidence
$ cat slugworth_web_evidence 
0518weblog
22

```

Move the two new evidence files into the directory Slugworth_evidence.
```
$ cd ..
$ mv web_logs/slugworth_web_evidence Slugworth_evidence/
$ mv slugworth_email_evidence Slugworth_evidence/

```

Combine them both into a single file into a file called Slugworth_evidence_for_authorities.

```
$ cd Slugworth_evidence/
$ cat slugworth_email_evidence slugworth_web_evidence > Slugworth_evidence_for_authorities

cat Slugworth_evidence_for_authorities
```
