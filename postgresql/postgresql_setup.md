# PostgreSQL Setup on DGX / Ubuntu 24.04 (ARM64)

This guide documents how to install and configure PostgreSQL on an NVIDIA DGX running **Ubuntu 24.04 (noble)** on **ARM64**, and how to connect to it using **DBeaver**.

It covers:

- Adding the official PostgreSQL APT repository (with proper GPG key handling)
- Installing PostgreSQL
- Creating an admin user and database
- Installing DBeaver (ARM64 tarball)
- Connecting DBeaver to the local PostgreSQL instance

Tested on: `Ubuntu 24.04.3 LTS (noble)` on DGX Spark (ARM64).

## 1. Update APT package lists

```bash
sudo apt update
sudo apt upgrade -y
```

## 2. Add PostgreSQL APT repository

```bash
sudo apt install -y wget ca-certificates gnupg
sudo mkdir -p /usr/share/keyrings
wget -qO- https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
  sudo gpg --dearmor -o /usr/share/keyrings/postgresql.gpg
sudo chmod 644 /usr/share/keyrings/postgresql.gpg
echo "deb [signed-by=/usr/share/keyrings/postgresql.gpg] http://apt.postgresql.org/pub/repos/apt noble-pgdg main" | \
  sudo tee /etc/apt/sources.list.d/pgdg.list
sudo apt update
```

## 3. Install PostgreSQL

```bash
sudo apt install -y postgresql postgresql-contrib
sudo systemctl status postgresql
```

## 4. Create admin role and database

```bash
sudo -i -u postgres
psql
CREATE ROLE ninja WITH LOGIN PASSWORD 'CHOOSE_A_PASSWORD';
ALTER ROLE ninja SUPERUSER;
CREATE DATABASE sparkdb OWNER ninja;
\du
\l
\q
exit
```

## 5. Test connection

```bash
psql -h localhost -U ninja -d sparkdb
```

## 6. Install DBeaver (ARM64 tarball)

```bash
sudo apt install -y openjdk-17-jre
cd ~
wget https://dbeaver.io/files/25.2.5/dbeaver-ce-25.2.5-linux.gtk.aarch64.tar.gz
sudo mkdir -p /opt/dbeaver-ce
cd /opt/dbeaver-ce
sudo tar -xzf ~/dbeaver-ce-25.2.5-linux.gtk.aarch64.tar.gz --strip-components=1
sudo ln -s /opt/dbeaver-ce/dbeaver /usr/local/bin/dbeaver
dbeaver
```

## 7. Connect DBeaver to PostgreSQL

Use:

- Host: 127.0.0.1  
- Port: 5432  
- Database: sparkdb  
- User: ninja  
- Password: your password  

Test connection → Finish.