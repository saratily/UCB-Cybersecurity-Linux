# 3- Sysadmin Essentials: Monitor Log files
To prevent and detect suspecious activity

- [3- Sysadmin Essentials: Monitor Log files](#3--sysadmin-essentials--monitor-log-files)
  * [Overview](#overview)
  * [Log management includes:](#log-management-includes-)
    + [Investigate an issues:](#investigate-an-issues-)
    + [Size management:](#size-management-)
    + [Audit](#audit)
  * [Overview of logs](#overview-of-logs)
  * [Four Categories of log](#four-categories-of-log)
  * [Types of Filters awnt to use:](#types-of-filters-awnt-to-use-)
    + [DEMO](#demo)
  * [1. Introducing journalctl](#1-introducing-journalctl)
    + [jourald syntax](#jourald-syntax)
    + [DEMO](#demo-1)
    + [Activity](#activity)
  * [2. Perform log size mgmt through logrotate](#2-perform-log-size-mgmt-through-logrotate)
    + [Logrotate](#logrotate)
    + [Uses of logrotate](#uses-of-logrotate)
    + [Logrotate config](#logrotate-config)
    + [DEMO and Activity](#demo-and-activity)
  * [3. Install and config audit rules using auditd, write audit logs to disk](#3-install-and-config-audit-rules-using-auditd--write-audit-logs-to-disk)
    + [DEMO and Activity](#demo-and-activity-1)

<small><i><a href='http://ecotrust-canada.github.io/markdown-toc/'>Table of contents generated with markdown-toc</a></i></small>


## Overview 
- Use journalctl to filter cron and boot logs
- Perform log size mgmt through logrotate
- Install and config audit rules using auditd, write audit logs to disk

## Log management includes:
### Investigate an issues:
- log filtering, using grep, cat, ls, regex, etc.

### Size management:
- Filling up the logs just to fill up the disk space
- if not done properly, then attacker might fill log files, causing DOS attack or DDOS

### Audit
- audit system files
- records all activities like authenciation and modifications 

## Overview of logs
- Logs located in 

1. /var/log/audit.log
- stores authentication related event
- failed login attempts (too many failed login attempts indicates a possible brute force attack) e.g. 700 failed logins within a second

2. /var/log/cron.log
- stores cron related info, i.e. what cron jobs are running
- check if all crons are running wihout error


## Four Categories of log
1. Application logs
- alerts for software or apps
- web server vs text editor will eb different but capture app information
2. Event logs
- for security, 
- too many login attempts
- unauthorized user try to rn sudo
3. Service logs
- Daemon jobs, e.g. print 
4. System logs
- related to OS 
- kernel error
- file curruption
- hardware coonected logs

## Types of Filters awnt to use:

- Failed logins
- Successfull logins
- System startup
- Improper shutdown 
-- due to power outage, or kill VM 
- Print documents
- Cron job activity

### DEMO
- Mostly rotate logs are maintained in /var/log
``` cd /var/log ```
- These logs have thousands of lines, impossible to analyze using nano or grep

## 1. Introducing journalctl
- to filter large log files (alternative grep but journalctl can provide real time logs)

1. systemd
- A daemon
- when system starts it is runing 
- start services, stop services
- also handle logs system wide events and provide information to other tools
- Log information dispaly is not very reader friendly

2. journald
- service specific to logging
- also known as systemd-journald
- it uses journald cmd to access systemd-journald

### jourald syntax
``` journalctl [options] [info being filtered] ```
- without filters returns entire content of logs, hard to analyze them

```sudo journalctl --list-boots ```
- displays lines for individual boots

``` journalctl -ef ```
-- by default displays oldest logs first, which appears at the top
-e --> displays the end of the journal
-f --> follow mode to keep the journal screen open
       displaying real-time messages in order of occurrence.

journalctl _UID=[n]
monitor specific user activities, using uid

### DEMO

**1- Use journalctl to query the systemd journal.**

- open two terminals
Terminal 1: to monitor journalctl logs
Terminal 2: to perform some activity

``` sudo journalctl ``` 
- List too much information

``` sudo journalctl -ef ```
- display end of journal, and gets updated with activities in terminal 2

press ctrl+C to exit

**Edit /etc/systemd/journald.conf to establish persistent storage.**
- By default journald purges log one VM or server is powered off or systemd-journald is started

``` sudo vi /etc/systemd/journald.conf ``` 

Search for Storage (with cap S)
``` /Storage ``` 

Uncomment this lie
``` Storage=auto ``` 

Restart the service to get updated config
``` sudo systemctl restart systemd-journald ``` 

**Use -ef to displays real-time messages in order of occurrence.**
- open two terminals
Terminal 1: to monitor journalctl logs
Terminal 2: to perform some activity

In terminal 1, execute
``` journalctl -ef ``` 

In terminal 2, try to change to a user who does not exist:
``` sudo su badguy ``` 
- Observe log entries in terminal 1

**Use _UID= display journal data for specific users.**
- get uid from /etc/passwd
``` cat /etc/passwd | grep sara ``` 

### Activity
1- Same as demo 1

## 2. Perform log size mgmt through logrotate
- If log file is too large, then query would be daunting
- Could be filled up by an attacker, resulting in DoS attack

### Logrotate
- To avoid filling server mempry space with logs
- when a log file reaches certain size, then create a new one
- or set a schedule

### Uses of logrotate
1. Scheduling the creation of new log files.
2. Compress log, save hard drive space.
3. Executing cmd prior to and after a log is rotated.
4. Time stamping old logs and renaming them during rotation.
5. limit # backlog files.
6. Smaller archives, less transfer times. 

### Logrotate config
```/etc/logrotate.conf ```

```sudo nano <service_name>```
```
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
### DEMO and Activity

1. Check logrotate is installed
```sudo apt install logrotate```

2. Verify default config (make sure that the following configs are uncommented)
```sudo nano /etc/logrotate.conf```
weekly
rotate 4
create
notifempty
compress

3. List content of /etc/logrotate.d
``` ls -l /etc/logrotate.d ```

4. add config for the following:

``` sudo nano /etc/logrotate.d/auth ```
```/var/log/auth.log {
	daily
	rotate 180
	notifempty
	compress
	delaycompress
}
```
``` sudo nano /etc/logrotate.d/cron ```
```/var/log/corn.log {
	daily
	rotate 60
	notifempty
	compress
	delaycompress
}
```

``` sudo nano /etc/logrotate.d/boot ```
```/var/log/boot.log {
	daily
	rotate 30
	notifempty
	compress
	delaycompress
}
```
Bonus: Test the rotation by forcing logrotate to rotate the logs by verifying the dates.

``` sudo logrotate -vf /etc/logrotate.conf ```
Note: If log files in /var/log don't update, run the above command again
or
check for errors at the beginnig of output

## 3. Install and config audit rules using auditd, write audit logs to disk
- auditd - service that fills this gap by classifying logs (e.g. authentication, modification, etc.)
-  monitors system calls 
-  doesn't prevent users to do something 



ausearch - queries auditd
aureport - summarize various type of events
auditctl

### DEMO and Activity
1. Check if auditd is install, if not then install
sudo apt install auditd

2- Check if auditd is running
systenctl status auditd


3. 
