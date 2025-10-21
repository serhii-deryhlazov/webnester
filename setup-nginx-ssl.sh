# Remove default index.html and create index.php with system metrics
sudo rm -f /var/www/html/index.html
sudo bash -c 'cat > /var/www/html/index.php <<EOF
<?php
header("Content-Type: text/plain");
echo "System Metrics:\n";
echo "Hostname: ".gethostname()."\n";
echo "Uptime: ".shell_exec("uptime")."\n";
echo "Memory Usage: ".shell_exec("free -h")."\n";
echo "Disk Usage: ".shell_exec("df -h")."\n";
echo "CPU Load: ".shell_exec("top -b -n1 | grep 'Cpu(s)'")."\n";
?>
EOF'

# Restart nginx to apply changes
sudo systemctl restart nginx