# 4.2 Access Controls

- [4.2 Access Controls](#42-access-controls)
  * [Overview](#overview)
  * [Audit password](#audit-password)
    + [Cracking password](#cracking-password)
    + [DEMO / ACTIVITY - 03 Talk to John](#demo---activity---03-talk-to-john)
  * [Privileges, root, sudo, and](#privileges--root--sudo--and)
    + [DEMO su vs. sudo](#demo-su-vs-sudo)
    + [ACTIVITY - 06 Sudo Wrestling](#activity---06-sudo-wrestling)
    + [Bonus](#bonus)
  * [Users and Group](#users-and-group)
    + [DEMO - Users and Groups](#demo---users-and-groups)
    + [ACTIVITY - 10 Users and Groups](#activity---10-users-and-groups)

<small><i><a href='http://ecotrust-canada.github.io/markdown-toc/'>Table of contents generated with markdown-toc</a></i></small>

## Overview
- Audit password using john
- Elevate privilages using sudo and si
- Create and manage users and groups
- Inspect and set file permissions for sensitive files on the system.

## Audit password
A hash is a cryptographic function that takes data as input and translates it to a
string of different, seemingly random data.

- password hashes are stored in /etc/shadow
- The more random and lengthy the password, the longer it will take to crack. 
- Go to How Secure Is My Password? https://www.security.org/how-secure-is-my-password/

### Cracking password
    |_ Brute force
    |_ John the ripper - to crack password

### DEMO / ACTIVITY - 03 Talk to John
1. Make a copy of the /etc/shadow file in your /home/sysadmin directory.  Name the copy: "shadow_copy"
Note: Don't forget to use sudo!
```
sudo cp /etc/shadow /home/sysadmin/shadow_copy
```
2. Use nano to edit your "shadow_copy" file to leave only the rows for the following users to crack:
Jack, Adam, Billy, Sally, Max

```
sudo nano ~/shadow_copy
```

3. Run sudo john shadow_copy
Note: This command is all you need to crack passwords.
```
$ sudo john shadow_copy
```

4. This will take some time, but let John the Ripper run, and take note of any passwords you find.
```
123456           (sally)
football         (billy)
welcome          (adam)
welcome          (max)
lakers           (jack)

```

## Privileges, root, sudo, and 
- Every file/dir has permissions - defining access to the file
- Group - a collection of uses have same privileges
- Root (super user) have access to all files, can perform any task
ATTACKER - try to get root access
- sudo (super user do) is used by user to run a cmd as root


### DEMO su vs. sudo
- If our privileges do not allow us to do so, we will first use su to switch directly to the root user.
- We’ll show the dangers of working directly as the root user.
- Then, we’ll do the same updates by using sudo instead and show why this is the more secure option.

```
whoami                          Determines the current user
id                              more details(uid, gid, list of groups user is added to gid(groupname)
su                              Switches to another user, in this case the root user.
sudo                            Invokes the root user for one command only.
sudo -l                         Lists the sudo privileges for a user.
visudo                          Edits the sudoers file.
/etc/passwd                     List of all users
cat /etc/passwd | grep sally    Get sally info from passwd
usermod                         Modify user
```
### ACTIVITY - 06 Sudo Wrestling

1. Print the name of your current user to the terminal.
```
$ whoami
sysadmin
OR 
$ id
uid=1000(sysadmin) gid=1000(sysadmin) groups=1000(sysadmin),4(adm),24(cdrom),27(sudo),30(dip),46(plugdev),116(lpadmin),126(sambashare),1003(docker)

```

2. Determine what sudo privileges the sysadmin user has.
```
$ sudo -l
[sudo] password for sysadmin: 
Matching Defaults entries for sysadmin on UbuntuDesktop:
    env_reset, mail_badpass,
    secure_path=/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin\:/snap/bin,
    env_keep+="HTTP_PROXY HTTPS_PROXY FTP_PROXY NO_PROXY",
    env_keep+="http_proxy https_proxy ftp_proxy no_proxy"

User sysadmin may run the following commands on UbuntuDesktop:
    (ALL : ALL) ALL
```

3. In a text document inside your research folder, record what sudo access each of the users on the system has.
```
$ ls /home
adam   http        jack  john  sally    sysadmin     vagrant
billy  instructor  jane  max   student  user.hashes

$ sudo -lU adam
$ sudo -lU billy
$ sudo -lU instructor
$ sudo -lU jack
$ sudo -lU jane
$ sudo -lU john
$ sudo -lU max
$ sudo -lU sally
$ sudo -lU student
$ sudo -lU sysadmin
$ sudo -lU user.hashes
$ sudo -lU  vagrant
```

4. There is one user who has sudo access for the less command. Find that user and complete the following:
```
$ sudo -lU max
Matching Defaults entries for max on UbuntuDesktop:
    env_reset, mail_badpass,
    secure_path=/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin\:/snap/bin,
    env_keep+="HTTP_PROXY HTTPS_PROXY FTP_PROXY NO_PROXY",
    env_keep+="http_proxy https_proxy ftp_proxy no_proxy"

User max may run the following commands on UbuntuDesktop:
    (ALL : ALL) /usr/bin/less
```

5. Switch to that user by using the password found in the previous activity.
Verify the vulnerability by dropping from less into a root shell.
Exit back to the command line.
Exit that user.
```
$ cd /home/max/
sysadmin@UbuntuDesktop:/home/max$ sudo touch shopping_list.txt

sysadmin@UbuntuDesktop:/home/max$ su max
Password: 
max@UbuntuDesktop:~$ whoami
max
max@UbuntuDesktop:~$ id
uid=1006(max) gid=1008(max) groups=1008(max),1005(hax0rs)
max@UbuntuDesktop:~$ pwd
/home/max
max@UbuntuDesktop:~$ sudo less shopping_list.txt 
[sudo] password for max: 
root@UbuntuDesktop:~# whoami
root
root@UbuntuDesktop:~# id
uid=0(root) gid=0(root) groups=0(root)
root@UbuntuDesktop:~# exit
exit
!done  (press RETURN)
```

### Bonus
1. From the sysadmin user, switch to the root user.
```
$ sudo su
[sudo] password for sysadmin: 
root@UbuntuDesktop:/
```

2. Check the sudoers file to see if there are any users listed there with sudo privileges.
```
# grep less /etc/sudoers
max  ALL=(ALL:ALL) /usr/bin/less
```

3. Edit the sudoers file so that only the administrator user has access.
```
$ nano /etc/sudoer
or 
$ visudo
- Remove max line
```

4. Check that your changes to the sudoers file worked.
```
$ su max
$ sudo less shopping_list.txt
max is not in the sudoers file.  This incident will be reported.
```

## Users and Group
- users can be added or removed from Linux machine
- Only users in each group can access files owned by the group.
- Linux identify a user by i, not by username
- system user < 1000, standard user > 1000, root = 0

### DEMO - Users and Groups
- Mike left company and joseph join as junior developer

1. Get group info for the user mike. 
```
$ groups mike
mike : mike general
```
2. Lock Mike’s account to prevent him from logging in.
```
$ sudo passwd --status mike
mike P 10/21/2022 0 99999 7 -1

$ sudo usermod -L mike
[sudo] password for sysadmin: 

$ sudo passwd --status mike
mike L 10/21/2022 0 99999 7 -1
```
3.  Remove the user mike from the general group.
```
$ sudo gpasswd -d mike general
Removing user mike from group general

$ groups mike
mike : mike
```

4.  Delete the user mike.
```
$ sudo deluser --remove-home mike
$ groups mike
no such user
OR
$ cat /etc/passwd | grep mike
<No result>
```
5. Delete the general group.
```
# verify group
$ cat /etc/group | grep general

$ sudo delgroup general

$ cat /etc/group | grep general
<No result>
```
6. Create the user joseph. (add user, create hoe dir, with group)
Note /etc/skel - have skeleton folder structure for new user
```
$ sudo adduser joseph
Adding user `joseph' ...
Adding new group `joseph' (1014) ...
Adding new user `joseph' (1012) with group `joseph' ...
Creating home directory `/home/joseph' ...
Copying files from `/etc/skel' ...
Enter new UNIX password: 
Retype new UNIX password: 
passwd: password updated successfully
Changing the user information for joseph
Enter the new value, or press ENTER for the default
	Full Name []: 
	Room Number []: 
	Work Phone []: 
	Home Phone []: 
	Other []: 
Is the information correct? [Y/n]

$ groups joseph 
joseph : joseph
```

7. Create a developer group.
```
$ sudo addgroup developer
Adding group `developer' (GID 1015) ...
Done.

verify developer group
$ cat /etc/group | grep developer
developer:x:1015:
```

8. Add the user joseph to the developer group.
```
$ sudo usermod -aG developer joseph 

- Verify joseph is added to developer group
$ groups joseph 
joseph : joseph developer
```

### ACTIVITY - 10 Users and Groups
Your senior administrator has asked you to audit all the users
and groups on the system.
- You must create a new group for the standard users and remove users from the sudo group.
- In the previous activity, you found some malicious users. Now, you will remove them from the system entirely. 

1. Use a command to display your ID info.
```
$ id
uid=1000(sysadmin) gid=1000(sysadmin) groups=1000(sysadmin),4(adm),24(cdrom),27(sudo),30(dip),46(plugdev),116(lpadmin),126(sambashare),1003(docker)
```

2. Use the same command to display the ID info for each user on the system.
```
$ id max
uid=1006(max) gid=1008(max) groups=1008(max)
```

3. In case you forgot, how can you learn what these usernames are? Record the output from this series of commands to a new file in your research folder.
```
$ id max >> ~/research/id.txt
```
4. Print the groups that you and the other users belong to.
```
$ groups
sysadmin adm cdrom sudo dip plugdev lpadmin sambashare docker

$groups joseph
joseph : joseph developer
```

5. Record the output from this series of commands to a new file in your research folder.
```
$groups joseph >> ~/research/groups.txt
```

6. Document in your research folder anything suspicious related to any of the users.
Hint: Are there any users that shouldn't be there?
```
sudo usermod -G jack jack.
```

7. Make sure you have a copy of the home folder for any rogue users and then remove any users from the system that should not be there. Make sure to remove their home folders as well.
Hint: Remember from the first activity, the only standard users that should be on the system are: admin, adam, billy, sally and max.
```
sudo deluser --remove-home jack
```

6. Verify that all non-admin users are part of the group developers. If the developers group doesn't exist, create it and add the users.
```
Run: sudo addgroup developers and sudo usermod -G developers <username>
```

7. The users adam, billy, sally and max should only be members of the developers group and their own groups. If you find any groups other than this, document and remove it.
```
Run: sudo delgroup hax0rs
```