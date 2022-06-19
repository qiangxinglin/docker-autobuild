FROM alpine:latest

# Update the base image
RUN apk -U upgrade

# Install impitool and curl
RUN apk add --no-cache ipmitool
RUN apk add --no-cache python3 

# Copy the entrypoint script into the container
COPY fanoverlord.py /

# Load the entrypoint script to be run later
ENTRYPOINT ["python3 /fanoverlord.py"]
