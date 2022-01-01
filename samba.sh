sudo apt-get -y install samba
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.backup

sudo chown $USER:$USER /etc/samba/smb.conf
echo -e '[global]\nfollow symlinks = yes\nwide links = yes\nunix extensions = no\n[ftp]\ncomment = ftp\npath = /srv/samba/ftp\nbrowseable = yes\nvalid users = mslavov, YOURUSER, test, test1\nwrite list = mslavov, YOURUSER, test, test1\ncreate mask = 0775\nforce create mode = 0775\npublic = no\nguest only = no\ndirectory mask = 0775\nforce directory mode = 0775\nstore dos attributes = Yes\nhide unreadable = yes\nhide files = /examples.desktop\n[yoursharedfolder]\ncomment = yoursharedfolder\npath = /srv/samba/yoursharedfolder' > /etc/samba/smb.conf
#making directory to be readable and writable by all users
sudo mkdir -p /home/share
sudo chmod 777 /home/share
sudo chgrp sambashare /home/share
sudo useradd -M -d /home/share/Mharis -s /usr/sbin/nologin -G sambashare Mharis
sudo mkdir /home/share/Mharis
sudo chown Mharis:sambashare /home/share/Mharis
sudo chmod 2770 /home/share/Mharis
sudo smbpasswd -a Mharis
sudo smbpasswd -e Mharis

#appending user inside samba configuration
#chown $USER:$USER /etc/samba/smb.conf
echo -e '[Mharis]\npath = /home/share/Mharis\nreadonly = no\nBrowseable = no\nforce create mode = 0660\nforce directory mode = 2770\nvalid user = @Mharis @sambashare' >> /etc/samba/smb.conf
sudo systemctl restart smbd nmbd
sudo ufw allow samba

#Optional Simba Client
#sudo apt-get install samba-client cifs-utils
#smbclient //$(hostname -I)/Mharis -U Mharis
#sudo mkdir -p /mounts/shares
#sudo mnt -t cifs -o username=Mharis //$(hostname -I)/Mharis ~/mounts/shares
#df -h
echo "You have Successfully Configure sharing on Client machine"


#For Permanent
#sudo vim /etc/fstab
#Add the following line depending on your mount point.
#//192.168.100.77/Mharis  /mnt/shares cifs credentials=/.sambacreds 0 0
#Save the file and exit the create the credentials file.
#sudo vim /.sambacreds
#Add the credentials information

#username: user1
#password: yourpassword
#domain: WORKGROUP

#check if mounted(optional)

#sudo mkdir -p /mnt/shares 
# sudo mount -a 
#df -hT | grep cifs
