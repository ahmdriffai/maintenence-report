# Base image
FROM node:22-bullseye

# Set working directory
WORKDIR /app

# Environment variable
# Supaya Puppeteer tidak download Chromium sendiri
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true

# Install system dependencies + Google Chrome
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    ca-certificates \
    --no-install-recommends \
  && curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/google-linux-keyring.gpg \
  && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-linux-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main" \
     > /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update \
  && apt-get install -y google-chrome-stable --no-install-recommends \
  && rm -rf /var/lib/apt/lists/*

# Copy dependency files
COPY package*.json ./

# Install Node.js dependencies
RUN npm install

# Copy all source files
COPY . .

# Expose application port
EXPOSE 3000

# Start application
# - Generate Prisma client sesuai arsitektur Linux
# - Build Next.js
# - Start production server
CMD npx prisma generate && npm run build && npm start
