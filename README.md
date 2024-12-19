# Project Zomboid Server with Nginx Proxy Manager

This repository contains a Docker-based setup for running a Project Zomboid dedicated server with mod support and Nginx Proxy Manager for secure access management.

## Prerequisites

- Docker installed on your system
- Docker Compose installed on your system
- A domain name (if you plan to use SSL)
- Ports 80, 443, and 81 available on your host machine

## Quick Start

1. Clone this repository:
```bash
git clone <repository-url>
cd project-zomboid-server
```

2. Create the necessary files:
   - Dockerfile
   - docker-compose.yml
   - entrypoint.sh

3. Make the entrypoint script executable:
```bash
chmod +x entrypoint.sh
```

4. Start the services:
```bash
docker-compose up -d
```

## Nginx Proxy Manager Setup

1. Access the Nginx Proxy Manager admin interface:
   - URL: `http://your-server-ip:81`
   - Default login credentials:
```
Email:    admin@example.com
Password: changeme
```
   - You'll be prompted to change these on first login

2. Configure Stream Proxy Hosts:
   - Go to "Streams" → "Add Stream"
   - For the game port:
```
Frontend Port: 16261
Backend Server:
  pzserver:16261 (UDP)
```
   - For the query port:
```
Frontend Port: 16262
Backend Server:
  pzserver:16262 (UDP)
```

## Server Management

### View server logs:
```bash
# All logs
docker-compose logs -f

# Just PZ server logs
docker-compose logs -f pzserver
```

### Access server console:
```bash
docker exec -it pzserver ./pzserver console
```

### Server commands:
```bash
# Stop the server
docker-compose stop

# Start the server
docker-compose start

# Restart the server
docker-compose restart

# Destroy the server (keeps volume data)
docker-compose down

# Destroy everything including volumes
docker-compose down -v
```

## Adding Mods

1. Find the mod's Workshop ID from the Steam Workshop
2. Access the server configuration:
```bash
cd volumes/pz_data/Server
```
3. Edit the server configuration file (servertest.ini or your custom named .ini)
4. Add mod IDs to the Mods= line
5. Restart the server:
```bash
docker-compose restart pzserver
```

## Backup

To backup your server data, copy the following directories:
- `volumes/pz_data`
- `volumes/steam_data`
- `volumes/workshop_data`
- `volumes/npm_data`
- `volumes/npm_letsencrypt`

## Troubleshooting

### Server won't start:
1. Check logs:
```bash
docker-compose logs -f pzserver
```
2. Verify permissions:
```bash
ls -la volumes/
```
3. Ensure all ports are available:
```bash
netstat -tulpn | grep -E '16261|16262|80|443|81'
```

### Can't connect to server:
1. Check if containers are running:
```bash
docker-compose ps
```
2. Verify Nginx Proxy Manager streams are configured correctly
3. Check your firewall settings

## Security Considerations

1. Change the admin password in docker-compose.yml
2. Use strong passwords for Nginx Proxy Manager
3. Keep your containers updated:
```bash
docker-compose pull
docker-compose up -d
```
4. Regularly backup your data
5. Use SSL certificates when possible

## File Structure
```
.
├── Dockerfile
├── docker-compose.yml
├── entrypoint.sh
└── volumes/
    ├── pz_data/
    ├── steam_data/
    ├── workshop_data/
    ├── npm_data/
    └── npm_letsencrypt/
```

## Contributing

Feel free to submit issues and enhancement requests!

## License

This project is licensed under the MIT License - see the LICENSE file for details.