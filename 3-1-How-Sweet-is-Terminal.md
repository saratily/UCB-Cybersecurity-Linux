# 3.1: How-Sweet-is-Terminal

- [3.1:How-Sweet-is-Terminal](#31-how-sweet-is-terminal)
  * [Overview](#overview)
  * [Why Command line ONLY?](#why-command-line-only-)
  * [Basic cmd](#basic-cmd)
    + [DEMO](#demo)
    + [ACTIVITY - 04_takefive](#activity---04-takefive)
  * [Relative vs. Absolute Paths](#relative-vs-absolute-paths)
    + [DEMO](#demo-1)
  * [mv vs cp](#mv-vs-cp)
    + [ACTIVITY - 07_milkway](#activity---07-milkway)
  * [More Less Head and Tail](#more-less-head-and-tail)
    + [DEMO](#demo-2)
    + [ACTIVITY - 11_oh_henry](#activity---11-oh-henry)
  * [cat](#cat)
    + [DEMO / ACTIVITY - 14_kitcat](#demo---activity---14-kitcat)

<small><i><a href='http://ecotrust-canada.github.io/markdown-toc/'>Table of contents generated with markdown-toc</a></i></small>


## Overview
- Basic cmd - ls, cd, mkdir, touch, cp, mv, rm, rmdir, and cat 
- Navigate deeply nested folder structures using relative and absolute file paths.
- Cmd to preview files - head, tail, more, and less
- Combine cmd in seq to accomplish relevant IT tasks


## Why Command line ONLY?
- The only way to achieve a desired outcome.
- The fastest way to achieve a desired outcome.
- The most flexible way to achieve a desired outcome.

## Basic cmd
```
pwd     Display the current working directory (print working directory).
ls      List directories and files in the current directory.
cd      Navigate into a directory (change directory).
mkdir   Make a directory.
rmdir   Remove a directory.
touch   Create an empty file.
rm      Remove a file.
clear   Clear the terminal screen.
```

### DEMO
```
$ cd            -> Navigate to user home dir

$ pwd           -> Current location
/home/sysadmin

$ ls
Cybersecurity-Lesson-Plans  Documents  Music     Public  Templates
Desktop                     Downloads  Pictures  python  Videos

```

2. Create several directories to organize our investigations: Case1 and Case2.
``` 
$ mkdir Case1 Case2 
```

3. Put our directories in the already existing folder security_evidence.
```
$ mkdir security_evidence
$ mv Case1 Case2 security_evidence/
OR
$ mv Case* security_evidence/
```
4. Put an empty file in the Case1 folder titled case1_evidence. 
```
$ cd Case1/

$ touch case1_evidence

$ ls -l
total 0
-rw-r--r-- 1 sysadmin sysadmin 0 Apr 25 20:16 case1_evidence
```

### ACTIVITY - 04_takefive

1. Navigate to  /03-student/day1/take_5/:
```
$ cd /03-student/day1/take_5/
```

2. Create a folder called Internal_Investigation_Employee_A.
```
$ mkdir Internal_Investigation_Employee_A
```

3. Navigate into the Internal_Investigation_Employee_A folder.
```
$ cd Internal_Investigation_Employee_A
```

4. From within the Internal_Investigation_Employee_A folder, print the working directory to confirm you are in the correct place.
```
$ pwd
/03-student/day1/take_5/Internal_Investigation_Employee_A
```

5. Create three files inside the Internal_Investigation_Employee_A folder:
- email_evidence
- log_evidence
- web_evidence
```
$ touch email_evidence
$ touch log_evidence
$ touch web_evidence
```

6. Delete the file called web_evidence as you realized Wonka has no web logs captured.
```
$ rm web_evidence
```

7. Display (list) all the files created.
```
$ ls
OR
$ls -al
```

8. Clear the terminal window.
```
$ clear
```

Hint: Don't be afraid to ask your neighbor or TA for help if you're having trouble with a command.


## Relative vs. Absolute Paths
```
/                               root
~/                              user home dir
textfiles/Sallyfile.txt         relative path
/root/desktop                   absolute path

cd Desktop
cd Sallysfiles                  cd Desktop/Sallysfiles/textfiles/
cd textfiles
```

### DEMO 
1. Navigate to the directory /03-instructor/day1/pathnav_demonstration/security_evidence/Case2/.
```
$ cd /03-instructor/day1/pathnav_demonstration/security_evidence/Case2/
```

2. Create an empty file called case2_evidence.
```
$ touch case2_evidence
```

3. Navigate to the directory Case1 and create an empty file called Web_logs.
```
$ cd ../Case1
$ touch Web_logs
```

4. Navigate back to the home folder.
```
$ cd
```

## mv vs cp
cp (copy) creates a copy of the file and places it in a specified location.
mv - Unlike cp, the original file doesn’t remain. 

### ACTIVITY - 07_milkway

1. Navigate to /03-student/day1/take_5
```
$ cd /03-student/day1/take_5
```

2. Create an additional folder called Internal_Investigation_Employee_B.
```
$ mkdir Internal_Investigation_Employee_B
```

3. Using absolute paths, move the file email_evidence from Internal_Investigation_Employee_A to Internal_Investigation_Employee_B as you have been told there will not be email evidence for the first employee.
```
$ pwd
/03-student/day1/take_5/Internal_Investigation_Employee_A
mv /03-student/day1/take_5/Internal_Investigation_Employee_A/email_evidence /03-student/day1/take_5/Internal_Investigation_Employee_B
```

4. Using absolute paths, copy the file log_evidence from Internal_Investigation_Employee_A to Internal_Investigation_Employee_B, as you have been told there will likely be log evidence from both employees.
```
cp /03-student/day1/take_5/Internal_Investigation_Employee_A/log_evidence /03-student/day1/take_5/Internal_Investigation_Employee_B
```

5. Check your directories to confirm the files are all in the correct locations.
```
$ ls -R /03-student/day1/take_5
/03-student/day1/take_5:
Internal_Investigation_Employee_A  Internal_Investigation_Employee_B

/03-student/day1/take_5/Internal_Investigation_Employee_A:
log_evidence

/03-student/day1/take_5/Internal_Investigation_Employee_B:
email_evidence  log_evidence

```

## More Less Head and Tail
```
more    View file page by page Space bar -> next page.
less    more flexible than more. 
        scroll forward and backward one line at a time
        also supports horizontal scrolling.

To preview a file by a certain number of lines, use the head or tail commands.
head    Displays the top 10 lines of a file.
        head -50 hello.txt -> to display 50 lines
tail    Displays the bottom 10 lines of a file.
```

### DEMO
1. Navigate to /03-instructor/day1/preview_demonstration
```
$ cd /03-instructor/day1/preview_demonstration
```

2. Our manager provided a directory, evidence_directory, containing four files:
File1, File2, File3, File4.
```
evidence_directory
    |_ File1
    |_ File2
    |_ File3
    |_ File4
```
3. These files were pulled from a secret computer at Wonka. They should be access logs showing who has logged in to that computer.
```
$ head File4 
user	Date	Activity
Mike	10/13/19 04:33 PM	Login
Bob	10/14/19 04:33 PM	Login
Mike	10/15/19 04:33 PM	Login
Mike	10/16/19 04:33 PM	Login
Mike	10/17/19 04:33 PM	Login
Mike	10/18/19 04:33 PM	Login
Mike	10/19/19 04:33 PM	Login
Mike	10/20/19 04:33 PM	Login
Sally	10/21/19 04:33 PM	Login
```

4. We’ll use the preview commands to determine which files are actually access logs.

5. Once we determine which are access logs, we’ll document the last timestamp in the file
```
tail -2 File4
```

### ACTIVITY - 11_oh_henry

1. Navigate to /03-student/day1/oh_henry
```
cd /03-student/day1/oh_henry
```

2. There are two folders inside the /03-student/day1/oh_henry/ folder. One for files captured from Henry, and one for files captured from Ruth.
```
$ ls -l
total 8
drwxr-xr-x 2 sysadmin sysadmin 4096 Oct 21  2022 henry
drwxr-xr-x 2 sysadmin sysadmin 4096 Oct 21  2022 ruth

```

3. Use the preview commands to determine which of the files contain readable text data.
```
$ head do.txt 
user	Date	Directory Accessed
henry	10/13/19	Wonka/Secret_recipes/chocolate
henry	10/13/19	Wonka/Secret_recipes/candy
henry	10/13/19	Wonka/Secret_recipes/sweetdrinks
henry	10/13/19	Wonka/Secret_recipes/chocolate
henry	10/13/19	Wonka/Secret_recipes/chocolate
henry	10/13/19	Wonka/Secret_recipes/chocolate
henry	10/13/19	Wonka/Secret_recipes/candy
henry	10/13/19	Wonka/Secret_recipes/chocolate
henry	10/13/19	Wonka/Secret_recipes/chocolate

$ head sp.txt 
user	Date	Directory Accessed
henry	10/14/19	Wonka/Secret_recipes/chocolate
henry	10/14/19	Wonka/Secret_recipes/candy
henry	10/14/19	Wonka/Secret_recipes/sweetdrinks
henry	10/14/19	Wonka/Secret_recipes/chocolate
henry	10/14/19	Wonka/Secret_recipes/chocolate
henry	10/14/19	Wonka/Secret_recipes/chocolate
henry	10/14/19	Wonka/Secret_recipes/candy
henry	10/14/19	Wonka/Secret_recipes/chocolate
henry	10/14/19	Wonka/Secret_recipes/chocolate

$ head wp.txt 
user	Date	Directory Accessed
henry	10/15/19	Wonka/Secret_recipes/chocolate
henry	10/15/19	Wonka/Secret_recipes/candy
henry	10/15/19	Wonka/Secret_recipes/sweetdrinks
henry	10/15/19	Wonka/Secret_recipes/chocolate
henry	10/15/19	Wonka/Secret_recipes/chocolate
henry	10/15/19	Wonka/Secret_recipes/chocolate
henry	10/15/19	Wonka/Secret_recipes/candy
henry	10/15/19	Wonka/Secret_recipes/chocolate
henry	10/15/19	Wonka/Secret_recipes/chocolate

```

4. Remove the files that contain non-readable text data.
```
rm -v !("do.txt"|"sp.txt" | "wp.txt") 
```

5. Bonus - The files each have a timestamp at the bottom. Use the mv command to rename each file by adding the date found on the bottom of the file.
For example: File1 has a date of October 11, 2019. Rename it to file1-10_11_2019.
```
$ mv do.txt. File1-10_13_2019
$ mv sp.txt. File2-10_14_2019
$ mv wp.txt. File3-10_15_2019 
```

## cat 
- meanaing concatination
- '>' will overwrite a file
- '>>' will append to a file

```
cat file.txt                        Display file contents on stdout (in terminal)
cat 1.txt 2.txt > combined.txt      Combine 1.txt and 2.txt contents and output to comiine.txt
cat combine.txt | grep -i hello     Input to a cmd
cat -n log.txt                      -n - argument - add line number to each line
```

### DEMO / ACTIVITY - 14_kitcat

1. Go to the following student directory to complete the activity: find_kit_cat_burglar.  Within this directory are sub-directories for Ruth and Henry. Navigate through the these directories and find all the files that can be considered evidence of Henry and Ruth's crimes.
```
cd /03-student/day1/find_kit_cat_burglar
```

2. Make a new directory called Evidence_for_authorities within the find_kit_cat_burglar directory.
```
$ mkdir Evidence_for_authorities
```

3. Copy all the evidence files into the Evidence_for_authorities folder, then concatenate the files into a single file called Wonka-evidence.txt. This will be provided as evidence to the local authorities.
```
$ cd /03-student/day1/find_kit_cat_burglar
$ cp ruth/emails/emailA  Evidence_for_authorities
$ cp ruth/files/sd.txt Evidence_for_authorities
$ cp henry/emails/email1  Evidence_for_authorities
$ cp henry/emails/email4   Evidence_for_authorities
$ cp henry/logs/log1    Evidence_for_authorities
$ cp henry/logs/log2 Evidence_for_authorities
$ cp henry/other/top_secret/recipe_for_sugarplum Evidence_for_authorities
$ cp henry/other/top_secret/recipe_for_sweetum Evidence_for_authorities

$ cat  emailA sd.txt  email1 email4 log1 log2 recipe_for_sugarplum  recipe_for_sweetums > Wonka-evidence.txt
```


4. Bonus - Four of Ruth's TXT files are not actually a text files, but are secret pictures.
Find the files and change the file extensions to an image extension.
Hint: Preview the files to find the one you're looking for.
Open each file with an image program and note what's in the picture.

```
$ cd /03-student/day1/find_kit_cat_burglar/ruth/files

$ mv lp.txt  lp.jpg
$ mv dj.txt  dj.jpg
$ mv bb.txt  bb.jpg
$ mv b7.txt  b7.jpg
```