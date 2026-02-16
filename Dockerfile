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

# Remove default nginx config and use our secure config
COPY nginx.conf /etc/nginx/nginx.conf

# Copy site files from builder stage to nginx html directory
COPY --from=builder /app/site/ /usr/share/nginx/html/

# Ensure nginx user owns the content (nginx: in the base image)
RUN chown -R nginx:nginx /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]
