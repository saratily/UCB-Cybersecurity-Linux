# 6.1 Combining Commands

- [Overview](#overview)
- [1. Create compound cmd](#1-create-compound-cmd)
  * [Example](#example)
- [Operator used in creating compound cmd :](#operator-used-in-creating-compound-cmd--)
  * [1. Changing with > and >>](#1-changing-with---and---)
  * [2. Piping with |](#2-piping-with--)
  * [3. ; (semi-colon)](#3----semi-colon-)
  * [4. &&](#4---)
  * [Activity](#activity)
- [2. Creating Alias](#2-creating-alias)
  * [~/.bashrc](#--bashrc)
  * [Activity](#activity-1)
    + [Bonus](#bonus)
- [3. Variables](#3-variables)
  * [four types of variables](#four-types-of-variables)
  * [DEMO](#demo)
  * [Activity](#activity-2)
- [4. Custom cmd](#4-custom-cmd)
  * [DEMO](#demo-1)
  * [Activity](#activity-3)
    + [BONUS:](#bonus-)

<small><i><a href='http://ecotrust-canada.github.io/markdown-toc/'>Table of contents generated with markdown-toc</a></i></small>


## Overview
1. Construct command using && and | (pipe)
2. Create alias cmd and save it in ~/.bashrc
3. Edit $PATH to include custom ~/scripts dir
4. bash scripts - haivng list of cmd

## 1. Create compound cmd
- Combine several command linked together, and execute them (in one line) 

### Example
- find all files with txt ext and ignore all the error, if any 
```find / -iname '*.txt' 2> /dev/null ```

- assign output of find command to foo
```foo=$(find / -iname '*.txt' 2> /dev/null )```

- Create a list of files b4 saving it ro the desktop
``` file$(find / -iname '*.txt' 2> /dev/null) > ~/Desktop/text_files ```

- Display last 10 lines from file 
- Note: ; semi-colon is for newline, run multiple independent cmd
``` file$(find / -iname '*.txt' 2> /dev/null) > ~/Desktop/text_files ; tail ~/Desktop/text_files ```

## Operator used in creating compound cmd :
### 1. Changing with > and >> 
Corner case: > abc.txt - if no cmd to left, then abc.txt will be created but empty

### 2. Piping with |
Example:
```ls -l | grep *.txt ```
- Get susadmin path from /etc/passwd
``` cat /etc/passwd | grep sysadmin | awk -F ':' '{print $6}' ```

### 3. ; (semi-colon)
- Each cmd runs on its own, doesn't depend on previous cmd
- Usually used to condense code
```
mkdir dir
cd dir
touch file1
ls -l
```
OR
``` mkdir dir ; cd dir; touch file1; ls -l ```

ISSUE: if mkdir or cd fails, then later cmd will be executed in wrong dir, e.g.
``` mkdir dir ; cd dor; touch file1; ls -l ```
dor dir doesn't exist, that is why cd dor will fail and; touch and ls cmd will run in current directory

### 4. &&
- Short circuit
- Run next cmd only if previous runs successfully
``` mkdir dir && cd dor && touch file1 && ls -l ```
if cd fails, touch and ls will not be executed at all

### Activity
1- 
``` mkdir ~/research && cp -r /var/log /etc/shadow /etc/passswd /etc/host ~/research ```

2- 
``` sudo find /home -type f -perm 777 > lsit.txt```

3- 
``` ps aux -sort -%mem | awk '{print $1, $2, $3, $4, $11}' | head > ~/research/top_processor.txt ```

## 2. Creating Alias
- a shorthand to script or log cmd
```
Example
alias lh='ls -lah'
alias foo="ls -al"
```
- ore cmd represent another cmd (e.g. ls -> linux, dir -> windows) - to use it interchangeablely 
- ```alias dir=ls (in linux)```
- Aliases created in terminal are temporary, to create persistant alias, define them in .bashrc
- List all the available aliases: alias
- to remove alias: unalias foo

### ~/.bashrc 
- home directory of every user has ~/.bashrc, which will be executed when terminal app is started 
``` 
ls -al 
-rw-r--r--  1 sysadmin sysadmin   3885 Apr 17 22:54 .bashrc
```

- Good practice is to take backkup of bashrc before changing it
``` cp ~/.bashrc ~/.bashrc.BAK ```

- Make changes to .bashrc
``` nano ~/.bashrc ```

- add the followingline at the end
```alias foo='ls -al' ```

- To execute .bashrc changes, or restart terminal
``` source ~/.bashrc ```

### Activity
1. Create the following alias
``` 
$ alias a='ls -a'
$ alias docs='~/Documents'
$ alias dwn='~/Downloads'
$ alias etc='~/etc'
```
#### Bonus
```
$ alias bash='nano ~/.bashrc'
$ alias research='mkdir ~/research && cp /var/logs/* /etc/passwd /etc/shadow /etc/hosts ~/research'
```

## 3. Variables
- just like alias, if created via terminal then temporary
- TO have persistant variables, define in /.bashrc

### four types of variables
1. Basic variables
2. Build-in variables
3. Common expansion
4. Variables in scripts

### DEMO
```
$ echo $PWD         -> current location, same as pwd -> /home/sysadmin
$ echo $USER        ->  sysadmin
$ echo $HOME        -> /home/sysadmin
$ echo $HOSTNAME    -> UbuntuDesktop
$ echo $MACHTYPE    -> machine type , x86_64-pc-linux-gnu
$ echo $UID         -> same as uid -> 1000
$ echo $SHLVL       -> shell level , 1
$ echo $SHELL       -> default shell , /bin/bash

# List all the environment variable, system variable only, available in current session
$ env

# Execute cmd and store in var
foo=$(ls)
echo $foo

# Use variable while printing string
$ echo "List of files: $(ls)"

# To add a new line b/w string and variable, use escape chareters
$ echo -e "List of files: \n$(ls)"
-e -> for escaping char
\n -> new line, Windows has \r\n for newline
```

### Activity
```
#!/bin/bash

title="System Information"
now=$(date +'%m-%d-%y')
tme=$(date +'%T')

echo "$title - $now- $tme"
echo "------------------------------"
echo "Machine Information   : $(uname)"
echo "Hostname              : $(hostname)"

echo "Host IP               : $(hostname -I | awk '{print$2}')"
echo "                      : $(ip addr | grep inet | tail -2 | head -1)"
echo "                      : $(ifconfig | grep inet | head -1 |awk '{print $2}')"
echo -e "DNS Server:            \n$(cat /etc/resolv.conf) \n\n"
echo -e "Memory info:           \n$(free) \n\n"
echo -e "CPU info:              \n$(lscpu | grep CPU) \n\n"
echo -e "Disk usage:            \n$(df -H | head -2) \n\n"
echo -e "User info:             $UID"
echo -e "                       $USERNAME"
echo -e "$(who -a)"

echo -e "\nTop 10 Processes:   \n$(ps aux -m | awk {'print $1, $2, $3, $4, $11'} | head)"
# ignore permission denied error - takes really log to execute, around 1 minute 
echo -e "\nSUID Files:          \n$(find / -type f -perm /4000 2>/dev/null)"
```

## 4. Custom cmd
- Alternate of creating alias
- Add script path to $PATH built-in variable
- All paths within $PATH are separated by : (colon)
### DEMO
- Create a script, called ~/bin/sys_info.sh and add this script to $PATH
``` 
# Find sys_info.sh script
$ find -type f -iname sys_info.sh
./6/sys_info.sh

$ cd ~
$ mkdir bin 
# Add scripts to bin
 cp ./6/sys_info.sh bin/

$ echo $PATH
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin

# DONOT use it this way in terminal, add to bashrc instead
$ PATH=$PATH:/home/sysadmin/bin

$ echo $PATH
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/sysadmin/bin
```
Note: bin is for user binary, and sbin is for system binary

- Execute sys_info.sh from anywhere in VM, e.g. root 
```
/$ sys_info.sh
System Information - 04-18-23- 01:49:49
------------------------------
Machine Information   : Linux
Host IP               : 172.17.0.1
Hostname              : UbuntuDesktop

```
- Find info about sys_info.sh script (shows path to sys_info.sh))
```
which sys_info.sh
/home/sysadmin/bin/sys_info.sh
```
- which cmd goes to each path in $PATH, and search for the given script or cmd
```
$ which ls
/bin/ls

$ which cat
/bin/cat

$ which echo 
/bin/etc
```

### Activity

1. Add cmd to create ~/research
``` mkdir ~/research ```

2.  cmd for finding 777 files
```ls -l | grep 'rwxrwxrwx' ```

- cmd to find executables only
``` ls -l | grep '..x..x..x'```

3. cmd for find top 10 processes
```ps axu -m | head ```

4. Add above cmds to script and modify each cmd to write to ~/research/sys_info.txt 
```
research.sh                                                            

#!/bin/bash
mkdir ~/research
ls -l | grep 'rwxrwxrwx' > ~/research/sys_info.txt
ps axu -m | head >> ~/research/sys_info.txt
```

#### BONUS:
- manually create ~/scripts and copy above script
```
mkdir ~/scripts
mv ~/research.sh ~/scripts
```
- Add ~/scripts dir to PATH
```
nano ~/.bashrc

PATH=$PATH:/home/sysadmin/scripts
```
- Reload bashrc file
```source ~/.bashrc ```

- Run script from anywhere
``` research.sh ```
Note: run it as a cmd, not as a script i.e. have ./ before script name

- Open ~/research/sys_info.txt and verify output
