# Используем официальный образ Nginx
FROM nginx:1.25.4

# Копируем статические файлы вашего проекта в директорию Nginx
COPY ./index.html /usr/share/nginx/html

# (Опционально) Копируем конфигурацию Nginx
COPY ./nginx.conf /etc/nginx/nginx.conf

# (Опционально) Открываем порт 80
EXPOSE 80

# Команда для запуска Nginx
CMD ["nginx", "-g", "daemon off;"]