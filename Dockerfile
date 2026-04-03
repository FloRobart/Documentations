FROM python:slim-bookworm AS builder
WORKDIR /app

# Copy all files to the builder stage
COPY . .

# Install mkdocs and dependencies
RUN pip install mkdocs mkdocs-material mkdocs-awesome-pages-plugin

# Build the static site using mkdocs
RUN mkdocs build --site-dir /app/site

FROM nginx:stable-alpine AS runner

LABEL maintainer="floris"

# Remove default nginx website
RUN rm -rf /usr/share/nginx/html/* && rm -f /etc/nginx/conf.d/default.conf

# Copy site files from builder stage to nginx html directory
COPY --from=builder /app/site/ /usr/share/nginx/html/

# Optionnel : config nginx custom
COPY nginx.conf /etc/nginx/nginx.conf

# Ajout d'un utilisateur non-root avec UID/GID fixes
RUN addgroup -g 1800 -S docsgroup && adduser -u 1800 -S docsuser -G docsgroup \
    && mkdir -p /run/nginx /var/cache/nginx /var/run /var/log/nginx \
    && chown -R docsuser:docsgroup /var/cache/nginx /var/run /var/log/nginx /run/nginx \
    && chmod 0755 /run/nginx
USER docsuser
