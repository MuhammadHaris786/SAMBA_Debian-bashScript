# Author:Muhammad Haris
#https://github.com/MuhammadHaris786
#!/bin/bash
sudo apt-get -y install samba
#adding user 1 and user 2
sudo adduser user1
sudo smbpasswd -a user1
sudo smbpasswd -e user1

sudo adduser user2
sudo smbpasswd -a user2
sudo smbpasswd -e user2
#making a backup file and appending in new "smb.conf" file
sudo mv /etc/samba/smb.conf /etc/samba/smbold.conf
#allow access
sudo touch /etc/samba/smb.conf
sudo chown $USER:$USER /etc/samba/smb.conf
echo -e '[global]\nfollow symlinks = yes\nwide links = yes\nunix extensions = no\n' >> /etc/samba/smb.conf
#adding folder "OS-Fl" private mode
echo -e '[OS-Fl]\n\npath = /home/haris/Desktop/OS-Fl\nbrowseable = yes\nvalid users = user1, user2\nwrite list =user1\ncreate mask = 0775\nforce create mode = 0775\npublic = no\nguest only = no\ndirectory mask = 0775\nforce directory mode = 0775\nstore dos attributes = Yes\nhide unreadable = yes\nhide files = /examples.desktop\n' >> /etc/samba/smb.conf
#adding folder "FA19-BCS-181" public mode
echo -e '[FA19-BCS-181]\n\npath = /home/haris/Desktop/FA19-BCS-181\nbrowseable = yes\nvalid users = user1, user2\nwrite list =user1\ncreate mask = 0775\nforce create mode = 0775\npublic = yes\nguest only = yes\ndirectory mask = 0775\nforce directory mode = 0775\nstore dos attributes = Yes\nhide unreadable = yes\nhide files = /examples.desktop\n' >> /etc/samba/smb.conf
sudo systemctl enable smbd
sudo systemctl restart smbd
sudo ufw allow samba

echo -e "Samba with \"OS-Fl\" and \"FA19-BCS-181\" has been configured.\nYour server ip is : $echo $(hostname -I)"
#firefox $echo 'http:\\smb://localhost''
