FROM node:alpine as builder

WORKDIR '/app'

COPY package.json .
RUN npm install

COPY . .

# Build will be located in /app/build
RUN npm run build

# -------------------------------------------------- #

# "as runner" optional here, FROM statement begins new block by defualt
FROM nginx as runner

# Copy assets from the "builder" phase above to specified folder nginx defaults to
COPY --from=builder /app/build /usr/share/nginx/html

#nginx starts serving build by default
