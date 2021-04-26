upstream lb-subprint {
      ip_hash;
      server 192.241.180.249:3222 weight=10 max_fails=3 fail_timeout=30s; # Reverse proxy to machine-1
      server 192.241.241.152:3222 weight=10 max_fails=3 fail_timeout=30s; # Reverse proxy to machine-2
}

server {
      listen 80;

      server_name www.subprint.com subprint.com;

      access_log  /var/log/nginx/nginx.access.subprint.log;
      error_log  /var/log/nginx/nginx_error.subprint.log debug;

      location / {
        proxy_pass http://lb-subprint; # Load balance the URL location "/" to the upstream lb-subprint
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
      }

      error_page   500 502 503 504  /50x.html;
      location = /50x.html {
            root   /var/www/nginx-default;
      }
}