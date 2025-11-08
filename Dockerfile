# ---- STAGE 1: Build ----
FROM node:20-alpine AS builder

WORKDIR /app

# Salin dependency info
COPY package*.json ./

# Install semua dependency (termasuk dev)
RUN npm install

# Salin semua source code
COPY . .

# Generate Prisma Client
# RUN npx prisma generate

# Build Next.js
RUN npm run build


# ---- STAGE 2: Production ----
FROM node:20-alpine AS runner

WORKDIR /app

ENV NODE_ENV=production

# Copy only necessary files
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/prisma ./prisma

# Prisma needs this to run migrations on deploy
# RUN npx prisma generate

# Default port
EXPOSE 3000

# Tambahkan ke CMD:
CMD ["sh", "-c", "npx prisma generate && npm start"]