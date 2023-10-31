# Linux cheatsheet

```
Week 3:
Day 1:  pwd, ls, cd, mkdir, touch, cp, mv, rm, rmdir, cat
        head, tail, more, and less
Day 2:  man, find, grep, wc, | (pipes)
Day 3:  sed, awk, nano, chmod, script

Week 4:
Day 1:  file system, top, ps, kill, apt install
Day 2:  john, root, sudo, su, whoami, visudo, 
        groups, usermod, deluser, delgroup, adduser, addgroup
Day 3:  ls -l, chmod, chown

Week 5:
Day 1:  backups, tar, gzip
Day 2: crontab
Day 3: logs, journalctl , auditd

Week 6:
Day 1: ; , &&, |, > >>
        alias, ~/.bashrc, ~/scripts, custom cmd
Day 2:  #, if, if/else, &&, ||
        List & loop (for)
```
================================================================


### Week 3: Terminal-and-Bash

| command       |    Sample      | Description |
|:---------------|:---------------|:---------------------------|
| pwd           | pwd  | current working directory (print working directory). |
| ls            | ls  | List directories and files in the current directory. |
|               |  ls -l | all files under current directory with their details |
|               |  ls -a | list hidden files also |
|               |  ls -t | list files according to their modification date (descending)|
|               |  ls -h | human readable format |
|               |  ls -S | list files according to their size (largest first) |
|               | ls --help |
| cd            | cd <relative dir>  | Navigate into a directory (change directory). |
| cd            | cd /<absolute dir>  | |
| mkdir         | mkdir <dir>  | Make a directory. |
| touch         | touch <file>  | Create an empty file. |
| cp            | cp ~/original.txt backup/  | creates a copy of the file |
| mv            | mv original.txt file1.txt  | Rename a file |
|             | mv ~/original.txt backup/  | Move file to another location |
|clear          | clear  | Clear the terminal screen. |
| rm            | rm <filename> | Remove a file.|
|               | rm -rf <dir> | Remove a directory recursively.|
| rmdir         | rmdir <dir>  | Remove a directory - dir should be empty.|
| cat           | cat file1.txt  | Display file content|
|               | cat file1.txt file2.txt file2.txt  > file.txt | Concatenation multiple files|
|               | cat -n log.txt | -n argument - add line number to each line |
| head          | head <file>  | Displays the top 10 lines of a file. (by default 10 lines |
|               | head -n <file>  | Displays the top n lines of a file. |
| tail          | tail <file>  | Displays the bottom 10 lines of a file. |
|               | tail -n <file> |    |
| more          | more <file>  | View file page by page Space bar -> next page. |
| less          | less <file>  | more flexible than more. 
|               |   | scroll forward and backward one line at a time
|               |   | also supports horizontal scrolling. |
| man           | man <cmd>  | brief description about cmd, and its options |
|               | man ls     |   | 
| find          | find <location> -type <type> -name <filename/dir>  | runs for searching file names or dir |
|               | -iname | for name insensetive |
|command &>/dev/null|      |  |
| grep          | grep <options> <word> <file>  | <options> |
|               | grep -il Sallystealer *       | -i = case insensetive |
|               |                               | -l = list file name  |
|               |                               | -r or -R recursively, by default, not recursive |
|               |                               | <word> - search string |
|               |                               | <file> can use wildcard for file name, e.g. *, or *.txt |
| wc            |  wc  | lines or words inside of files. |
|               | wc -l |  line count | 
|               | wc -w |  word count | 
|\|  pipe       |   |  to combine multiple cmd |
| sed           | sed s/<old_value>/ /<new_value>/  | make substitute to a file |
|               |         | reads and edit text line by line - to match files |
| awk           | awk -F(delimiter) '{print $(field_number)}' <file> | isolate data points from a complex log file |
|               | awk '{print $3, $1}' <file> | delimiter - By default awk separate fields by space , could be comma, or semi-colon ; |
| nano/vi/vim/emac          | nano file.txt  | text editors  |
| script        | nano diskcleanup.sh  | edit script |
|               | #!/bin/bash | add shbang |
|               | chmod +x diskcleanup.sh | change file permissions to execute |
|               | ./diskcleanup.sh | execute file |
|               | ./diskcleanup.sh arg1 | script by passing arguments (e.g. IP lookup) | 
| xde-open      |   | to open image file from cmd line |

================================================================


### Week 4: Linux-SysAdmin-Fundamentals

| file system       |           description              |
|:--------------|:---------------------------------- |
|/ (root)        | The root directory that contains every other directory.
|/home           | Contains users’ private file. |
|/etc            | Contains configs, defining how a machine runs and its usage|
|/etc/pwd        | older versions have it, to store pwd |
|/bin, /sbin     | Contain main binary/program files. |
|                | sbin - system executables |
|/var            | Contains files that change over time. |
|/var/logs       | file/system changes overtime. |
|/tmp            | Contains files that are only needed for a short period of time. |
|                | Erase all files when reboot |
|                | CAUTION: a malicious code can be downloaded here |
                
| command       |    Sample      |       description         |
|:--------------|:---------------|---------------------------|
| top           | top | List processes real time, updates every 3 sec  |
|               | top -u jack | list all processes, running by jack |
|               | | Press P: sort according to CPU utilization. |
|               | | Press M: sort by memory usage. |
|               | | Press T: sort by Time column. |
|               | | Press N: sort by PID number. |
| ps            | ps  | snapshot of all processes, args allow diff subset of processes |
|               | ps -axu  | all effective users |
|               |  ps -ef | every process, using standard syntax |
|               | ps -ef \| grep stess | get all the processes that have stress |
|               | ps -axu --sort pmem \| head | process uses the most memory |
|               | ps -u jack | all running processes for jack |
|               | top -u jack | OR |
| kill          |  kill <pid> | to stop process, finishes process before it shuts it down.  |
| killall |  sudo killall stress-ng  | kill all process having stress |
|         | sudo killall -u jack | kill all processes, running by jack |
| apt install   | sudo apt install <package name>  |  |
| =============== | =============== | ========================= |
| john          | sudo john <file with pwd hash>  |  |
| su            | sudo su  | Switches to another user, in this case the root user. |
| sudo          | sudo <cmd>  | Invokes the root user for one command only. |
|               | sudo -l | Lists the sudo privileges for a user. |
|               | sudo -lU adam | List all privileges of adam     |
| whoami        | whoami  | Determines the current user |
| id            | id  | more details(uid, gid, list of groups user is added to gid(groupname)  |
|               |    |uid=1000(sysadmin) gid=1000(sysadmin) groups=1000(sysadmin),4(adm),24(cdrom),27(sudo),30(dip),46(plugdev),116(lpadmin),126(sambashare),1003(docker) |
| visudo        |   | Edits the sudoers file. equivalent to nano /etc/sudoer |
| /etc/passwd   |   | List of all users |
|               | cat /etc/passwd \| grep sally  |  Get sally info from passwd |
| =============== | =============== | ========================= |
| usermod       |  | Modify user |
| passwd        | sudo passwd --status mike | check mike status |
| usermod       | sudo usermod -L mike | Lock mike account |
| gpasswd       | sudo gpasswd -d mike general | Remove the user mike from the general group. |
| groups        | groups mike  | Get group info for the user mike. |
| deluser       | sudo deluser --remove-home mike  | Delete the user mike |
|               | cat /etc/group \| grep general | verify group |
| delgroup      | sudo delgroup general | Delete the general group. |
| adduser       | sudo adduser joseph  | Create the user joseph.  |
| addgroup      | sudo addgroup developer | Create a developer group. |
|               | sudo usermod -aG developer joseph  | Add the user joseph to the developer group |
|               | groups joseph  | Verify joseph is added to developer group |
| chmod         |   |  |
| chown         |   |  |

================================================================


#### ps sorting
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

================================================================


### Week 5: Archiving-and-Logging-Data

3 kinds of backups
1. Full backup
2. Incremental backup - diff b/w previous incremental backup and current state
3. Differential backup - diff b/w previous full backup and current state

| command       |    Sample      |       description         |
|---------------|:---------------|---------------------------|
| tar | tar [options] [archive_name] [objects to archive] | 
| compress/archive | $ tar cvvWf 20230410-epscript.tar epscript/ > 20230410-epscript.txt |  cmd to compress / archive a dir or file |
|   | $ tar cvf archive.tar ./Documents ./Downloads | Create tar of multiple dir |
| | cvvWf                       | compress, very verbose, verify archives after writing, archive filename  |
| | 20230410-epscript.tar       | archive name                    |
| | epscript/                   | dir to be archived              |
| | 20230410-epscript.txt       | save the output of tar cmd      |
||||
| extract |$ tar xvvf 20190814epscript.tar -C patient_search/ epscript/patients | extract epscript/patients insode .tar |
| | $ tar xvf 20190814epscript.tar -C patient_search/ --wildcards "*.csv" | extract csv files only using wildcards |
| | tar                   | command                           |
| | xvvf                  | extract, very verbose, flag for archive filename |
| | 20190814epscript.tar  | tar file we want to extract from  |
| | -C                    |  saves the indicated patient directory and its files |
| | patient_search/       |  dir where we want to extract files (dir should be created before use) |
| | epscript/patients     | extracting files from this dir from archive ONLY. |
||||
| view/verify tar content | tar tvvf epscript_back_sun.tar --incremental \| less | |
| | t -> listing only | |
||||
| Incremental backup | tar cvvWf full.tar --listed-incremental=epscript_backup.snar --level=0 testenvir | level 0 of testenvir dir |
| snar file format  | Y ->  Modified |  Types of record in snapshot files: Y, N & D|
| | D -> Deleted | | 
| | N -> No change | |
| | D indicates directories. | | 
| | Y indicates that these file are contained in the epscript_back_sun.tar archive. | |
||||
| | tar cvvWf inc1.tar --listed-incremental=epscript_backup.snar testenvir | increament # 1 -> backup ONLY the changes made since last backup |
| | tar cvvWf inc2.tar --listed-incremental=epscript_backup.snar testenvir | increament # 2 |
| Extract from incremental backups| tar xvvf full.tar  --increamental | extract full tar |
| | tar xvvf inc1.tar --increamental | extract increament # 1 on top of full |
| | tar xvvf inc2.tar --increamental | extract increament # 2 on top of full & increament # 1 |
||||
| gzip  | gzip archive.tar  | open source - to compress tar -> archive.tar.gz |
||||
| crontab       | MM HH DD MM Day [cmd] | MM -> minutes (0-59)\ HH -> Hour (0-23)\ DD -> Day of month (1-31)\ MM -> month(1-12)\ Day -> Day of Week(0-6, where 0=Sunday)| 
| | 36 2 * * 0 tar -zcf /var/backups/home.tar /home |  |
| Verify cron is running | $ sudo systemctl status cron | |
| Edit cron | $ crantab -e |  |without filters returns entire content of logs, hard to analyze them
| List cron jobs | $ crontab -l | to inspect user crontab  |
| List all cron files | $ sudo ls ./crontabs |
||||
| logs          | /var/logs  |  |
| | sudo systemctl restart systemd-journald | | 
| journalctl    | journalctl [options] [info being filtered]  | without filters returns entire content of logs, hard to analyze them |
| | sudo journalctl | List too much information |
| | sudo journalctl --list-boots | displays lines for individual boots | 
| | sudo journalctl -ef | -e -> display end of journal\ f -> gets updated with activities in terminal 2 |
| logrotate | /etc/logrotate.conf | | 
```sudo nano <service_name> 
/var/log/<service_name> {
	daily / weekly	- period
	rotate <n>	- interval  
	create		- new file while rotate
	notifempty	- donot rotate empty files
	dateext		- use date as a suffix
	compress	- compress backlog
	delaycompress	- except most recent backlog
	missingok - if missing, don't generate error
}
```
| command       |    Sample      |       description         |
|---------------|:---------------|---------------------------|
| auditd        | sudo auditd -l | List all rules  |
```
$ sudo nano /etc/audit/rules.d/audit.rules

-w /etc/shadow -p wa -k shadow
-p -> permission
wa -> write and 
-k -> key
```

================================================================

### Week 6
| command       |    Sample      |       description         |
|---------------|:---------------|---------------------------|
| >             | echo "Hello world" > hello.txt  | Overwrite hello.txt |
|  Corner case  | > abc.txt | if no cmd to left, then abc.txt will be created but empty| 
| >>            | echo "Hello world" > hello.txt  | Append to hello.txt |
| \|             |  ls -l \| grep *.txt  | Output of the first cmd, will be used in the second cmd |
| ;             | mkdir dir ; cd dir; touch file1; ls -l  | Combining cmd, Each cmd runs on its own, doesn't depend on previous cmd |
| | | Issue: if mkdir or cd fails, then later cmd will be executed in wrong dir|
| &&            | mkdir dir && cd dor && touch file1 && ls -l  |  if cd fails, touch and ls will not be executed at all |
| alias         | alias lh='ls -lah'  | lh represents 'ls -lah', Aliases created in terminal are temporary, to create persistant alias, define them in .bashrc |
| unalias | unalias lh | to remove alias |
| | | |
| ~/.bashrc     |  source ~/.bashrc | script in user home dir, runs when terminal starts  |
| ~/scripts     |  #!/bin/bash | shbang - path to bash compiler |
| | | |
|Variables |||
|1. Basic variables | |
|2. Built-in variables|| 
|3. Common expansion| |
|4. Variables in script 
||
| custom cmd    | home/sysadmin/bin/sys_info.sh  | - Create a script, which we want to add a scustom cmd |
|               |  PATH=$PATH:/home/sysadmin/bin   | Add script path to $PATH |
|| which sys_info.sh | |Find info about sys_info.sh script (shows path to sys_info.sh))|
||/home/sysadmin/bin/sys_info.sh ||
| | /$ sys_info.sh | Execute sys_info.sh from anywhere in VM, e.g. root |
| | | |
| #             | # This is a comment | This is a comment |
| if            | if [ 5 -gt 8 ] |if [ <condition> ] | | 
| | then | then |
| | echo “This doesn’t make sense!” | <run_this_command>
| | fi | fi |
| | | | 
| if/else       |   if [ 5 -gt 8 ] |if [ <condition> ] | | 
| | then | then |
| | echo “This doesn’t make sense!” | <run_this_command>
| | else | else |
| | echo “That is correct!” | <run_this_command> |
| | fi | fi |
| | | | 
| &&            | if [ <condition_1> ] && [ <condition_2> ] | if both condition met|
| \|\|          | if [ <condition_1> ] \|\| [ <condition_2> ] | if one condition met|
| | | | 
| | == | This string is equal to another. |
| | != | If two strings are not equal. |
| | -gt | If one integer is greater than another. |
| | -lt | If one integer is less than another. |
| | -d /path_to/directory | Checks for existence of a directory. |
| | -f /path_to/files | Checks for existence of a file. |
| | | |
| List          |  my_list=(a b c d e f) |  |
| | ${my_list[0]} | Output: a |
| | ${my_list[4]} | Output: e |
| | | |
| for loop      | for num in {0..5}; | for <item> in <list>;
| | do |do |
| | if [ $num = 1 ] || [ $num = 4 ] | <run_this_command> |
| | then | <run_this_command> |
| | echo $num | <run_this_command> |
| | fi | <run_this_command> |
| | done  | done | 
| | | | 

================================================================