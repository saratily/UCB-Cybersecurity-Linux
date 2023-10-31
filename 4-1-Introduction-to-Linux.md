# 4.1:Introduction to Linux

- [4.1:Introduction to Linux](#41-introduction-to-linux)
  * [Overview](#overview)
  * [Linux:](#linux-)
    + [Linux History](#linux-history)
    + [ACTIVITY - 03 Distro Research](#activity---03-distro-research)
  * [Linux File System Structure](#linux-file-system-structure)
    + [DEMO - Navigating Linux File Structures](#demo---navigating-linux-file-structures)
    + [ACTIVITY - 06 Linux Landmarks](#activity---06-linux-landmarks)
  * [Introduction to Processes](#introduction-to-processes)
    + [Managing Processes](#managing-processes)
    + [SORTING](#sorting)
    + [Using the sort command](#using-the-sort-command)
    + [DEMO - Inspecting Malicious Files Demo](#demo---inspecting-malicious-files-demo)
    + [ACTIVITY - 10 Process Investigation](#activity---10-process-investigation)
      - [4. Bonus](#4-bonus)
  * [Installing Packages](#installing-packages)
    + [DEMO- Installing packages](#demo--installing-packages)
    + [ACTIVITY - 13 Installing Packages](#activity---13-installing-packages)

<small><i><a href='http://ecotrust-canada.github.io/markdown-toc/'>Table of contents generated with markdown-toc</a></i></small>

## Overview
- History of linux amd explore some Linux distributions.
- Navigate the Linux file structure using the command line.
- Manage processes with the top, ps, and kill commands.
- Install packages using apt.

## Linux:

-- Linux - 96.3%
-- Windows 1.9%, and
-- FreeBSD, 1.8%

An operating system (OS) - software that supports a computer’s basic functions, such as scheduling tasks, executing applications, and controlling peripherals.

Headless servers - command-line only machines,  without a desktop environment
e.g. Ubuntu, Fedora, Centos

Selecting Ubuntu Server Versions 
- choose the “Long Term Support” (LTS) version.
- The latest version will have continual updates and changes.
- The LTS version will remain stable and only change approximately once a year. 


SELinux is a built-in file permission security enhancement developed by the NSA.
CentOS and Fedora have it implemented by default. 
```
Subject --> SELinux Secure Server --> Permission granted --> Object/resource(file)
                |                           |
                |                           | No
            Policy server db            AVC Denied Message

```
### Linux History
```
Unix (1969–1970)
    |_Linux (1991 -FOSS - Free, Open Source Software)
    |_ Centos - 
        |_Redhat
        |_Fedora
    |_Debian 
        |_ Ubuntu -  most flexible , best suited for day-to-day, and administrative tasks
        |_Kali is designed specifically for security professionals. (pentesting)
```

### ACTIVITY - 03 Distro Research
```
most widely-used Linux desktop environment - Ubuntu
Web or data server - Ubuntu Server and Fedora Server, easy-to-configure web services.
                   - Debian or CentOS for more manual tasks
Central Data Server - Stores sensitive data, req secure distribution, Fedora or CentOS - uses SELinux by default
Public Web Server - runs quickly, with large traffic - Ubuntu and Fedora 
IT Audit Workstation - Kali Linux - designed for performing security assessments. 
User Workstation - Ubuntu - GUI + basic s/w, e.g. email client, browser, text editor, etc. 
```
## Linux File System Structure
```
/ (root)        The root directory that contains every other directory.
/home           Contains users’ private file.
/etc            Contains configs, defining how a machine runs and its usage
/etc/pwd        older versions have it, to store pwd 
/bin, /sbin     Contain main binary/program files.
                sbin - system executables
/var            Contains files that change over time.
/var/logs       file/system changes overtime.
/tmp            Contains files that are only needed for a short period of time.
                Erase all files when reboot
                CAUTION: a malicious code can be downloaded here
```

### DEMO - Navigating Linux File Structures
Let’s launch a terminal and walk through the Linux file system, starting at the top of the directory structure, the Root Directory.

```
1. Navigate to home dir
$ cd
OR 
$ cd ~

2. Go to root
$ cd /

3. List all users dir
$ cd /home
$ ls

4. Current user details
$ whoami
OR 
$ ID

5. sudo cat /etc/shadow
```

### ACTIVITY - 06 Linux Landmarks
- Most technical roles in cybersecurity require comfort with the command line and familiarity with the structure of a Linux file system.
- You will use this knowledge to navigate file systems when looking for suspicious activity or administering the machine.
- The next exercise will give you an opportunity to explore the file system and practice using the command line.

0. SETUP 
```
sudo bash /home/instructor/Documents/setup_scripts/instructor/landmarks_review.sh
```

1. Create a research directory in your home folder to place notes of your findings.
```
$ cd
$ mkdir research
```

2. Access the /var/log directory and check that the auth.log exists. You need this to check for suspicious logins.
```
$ ls /var/log/ | grep auth*
auth.log
auth.log.1
auth.log.2.gz
```

3. Access your personal home directory and check if you have a Desktop and Downloads directory.
```
$ ls | grep 'Desktop\|Downloads'
Desktop
Downloads

```

4. Access the binary directory and check if you can find cat and ps binary files.
```
$ ls /bin/cat 
/bin/cat
$ ls /bin/ps
/bin/ps
```

5. Check if there are any scripts in temporary directories, as those may be suspicious.
```
$ ls /tmp/ | grep .sh
burpsuite_community_linux_v2022_1_1.sh
ssh-y6vqkGiP9v7V
str.sh
vagrant-shell
```

6. Check that the only users with accounts in the /home directory are adam, billy, instructor, jane, john max, sally, student, sysadmin and vagrant. There should not be additional directories. Note any other users that you find.
```
$ ls /home/ | grep -Ev "adam|billy|instructor|jane|john|max|sally|student|sysadmin|vagrant"
http
jack
user.hashes
```


## Introduction to Processes
- process data and might change file system. 
- use resources, memory, CPU, etc

Memory is the space used by a process to save and manipulate data.
    |_ Random Access Memory (RAM)- runs code,  only used while running program. more processing -> more RAM
    (Moorse law: processing power doubles every 18 years)
    |_ Disk space - save data permanently, persist even after a process ends.

The Central Processing Unit (CPU) acts as the brain of the system, determining
how much work a process has to do, and how difficult that work is. 

### Managing Processes
Dynamic analysis is the process of running a potentially malicious script and monitoring its effects
```
top             List processes real time, updates every 3 sec 
ps              snapshot of all processes, args allow diff subset of processes
ps -axu         all effective users
ps -ef          every process, using standard syntax
kill <pid>      to stop process, finishes process before it shuts it down. 
                ATTACK: malware try to kill anti-virus/anti-malware
killall stress  All process having stress 
```

### SORTING
```
Column    Ascending Descending
Heading   Sort      Sort       Alternatives
===============================================
USER      user      -user
PID       pid       -pid
%CPU      pcpu      -pcpu      %cpu and -%cpu
%MEM      pmem      -pmem      %pmem and -%pmem
VSZ       vsz       -vsz
RSS       rss       -rss
TTY       tty       -tty
STAT      stat      -stat
START     start     -start
TIME      time      -time
COMMAND   comm      -comm
```

### Using the sort command
https://www.networkworld.com/article/3596800/how-to-sort-ps-output.html

### DEMO - Inspecting Malicious Files Demo
```
1. List all processes real time - similar to task manager
$ top

2. Zoombies/Orphan process - a processes doesn't have parent 

3. Run a maliciuos script
$ ./home/instructor/Documents/research/a9xk.sh 

4. get all the processes that have stress 
$ ps -ef | grep stess 

5. Instead of using ps and kill <pid>, kill all the process that have stress
$ sudo killall stress
```
### ACTIVITY - 10 Process Investigation
In this activity, you will monitor the system for processes that should
not be running.
- Your senior admin asked that you record snapshots of processes as well as review processes in real time.
- If you notice anything amiss, kill the process and add your findings to the report.

0. To get started with your activity, run
```
sudo bash /home/instructor/Documents/setup_scripts/instructor/processes.sh </dev/null &>/dev/null
```

1. During the last activity, you found a script file in a strange location on the system. Review the contents of this script file to get an idea of what commands you might be searching for.
- List all the running processes in real time.
```
$ top
```
- Review the help menu for this command and get a few ideas of what you want to investigate.
```
$ man top
```
- Highlight the column that you are sorting by. (by default %CPU)
```
top 
Press P: sort according to CPU utilization.
Press M: sort by memory usage.
Press T: sort by Time column.
Press N: sort by PID number.
```

2. To get an idea of how the system is currently running, answer these questions:
- How many tasks have been started on the host?
```
$ ps -axu | wc -l
264
$ top 
- have total process count at the top
```

- How many of these are sleeping?
```
$ ps h -eo s,pid | awk '{ if ($1 == "S") print $2; }'
OR
top 
- have sleeping process count at the top
```

- Which process uses the most memory
```
$ ps -axu --sort pmem | head
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         2  0.0  0.0      0     0 ?        S    11:22   0:00 [kthreadd]
root         3  0.0  0.0      0     0 ?        I<   11:22   0:00 [rcu_gp]
root         4  0.0  0.0      0     0 ?        I<   11:22   0:00 [rcu_par_gp]
root         6  0.0  0.0      0     0 ?        I<   11:22   0:00 [kworker/0:0H-kb]
```

3. Search all running processes for a specific user.
```
$ ps -u jack
  PID TTY          TIME CMD
 6054 pts/0    00:00:00 bash
 6055 pts/0    00:00:00 stress-ng
 6056 pts/0    00:27:27 stress-ng-matri
 6057 pts/0    00:27:27 stress-ng-matri

OR
$ pgrep -u {USERNAME} {processName}
OR 
$ top -u jack
OR
$ htop -u {userName}
```
- Review all the processes started by the root or sysadmin user.
```
$ ps -u root
$ ps -u sysadmin
```

- Sort by other users (e.g. jack) on the system that may be of interest.
```
$ ps -u jack
```
Hint: In the previous exercise, you found a home folder for a user who should not be on this system. Is that user running processes?

#### 4. Bonus

Next, take a static "snapshot" of all currently running processes, and save it to a file in your home directory with the name currently_running_processes.
```
ps -axu > ~/currently_running_processes
```

Use the flag to list all processes that have a TTY terminal.
```
ps -axu > ~/currently_running_processes
```

In the short list of output, do you notice any processes that seem suspicious?
```
top -u jack

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND    
 6056 jack      20   0   40680   1856   1436 R  77.2  0.0  43:13.75 stress-ng+ 
 6057 jack      20   0   40680   1856   1436 R  76.2  0.0  43:15.47 stress-ng+ 
 6054 jack      20   0   19996   3280   3044 S   0.0  0.1   0:00.00 bash       
 6055 jack      20   0   40488   5768   5452 S   0.0  0.1   0:00.00 stress-ng 
```

Identify the ID of any suspicious process. Stop that process with the kill command.
```
$ sudo kill 6056
```
Kill all processes launched by the user who started the command you just stopped.
```
$ sudo killall stress-ng
or 
$ sudo killall -u jack
```

Use Google and the man pages to identify a command and flag that will let you stop all processes owned by a specific user.
```
$ sudo killall -u jack
```

## Installing Packages
Linux searches db for <package name>. If found, it will be downloaded.
Personal Package Archives, or PPAs are repositories - are db, used tp store and distribute packages

```
sudo apt install <package name>
```

### DEMO- Installing packages
1. install emacs - traditional file editor.
```
sudo apt -y install emacs 
```

2. install cowsay - utility that takes in input, and displays a cow repeating it. 
```
sudo apt -y install cowsay
```

### ACTIVITY - 13 Installing Packages
In this activity, you will install and configure emacs, cowsay, and fortune. 

1- To install the packages emacs and cowsay, 
```
sudo apt -y install emacs
sudo apt -y install cowsay
sudo apt -y install sl
sudo apt 
```

2. Bonus - install both pkgs in one line
```
sudo apt -y install emacs cowsay
```
3. Run the following command:
```
cowsay "Linux is Fun!"
```