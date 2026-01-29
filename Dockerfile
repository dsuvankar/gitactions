# Use a specific version instead of just "22" for reproducibility
FROM node:22-alpine AS builder

# Add metadata
LABEL maintainer="dsuvankar23@gmail.com"
LABEL description="basic node js app"

# Set working directory
WORKDIR /app

# Copy only package files first (for better caching)
COPY package*.json ./

# Install dependencies
RUN npm ci --omit=dev --frozen-lockfile

# Copy source code
COPY . .

# --- Multi-stage build (optional but recommended) ---
FROM node:22-alpine

# Run as non-root user for security
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001

WORKDIR /app

# Copy only necessary files from builder stage
COPY --from=builder --chown=nodejs:nodejs /app .

# Switch to non-root user
USER nodejs

# Expose port
EXPOSE 8080

# ONLY ONE CMD - at the very end
CMD ["node", "index.js"]