FROM continuumio/miniconda3

# Set a working directory
WORKDIR /app

RUN apt-get update && apt-get install libgl1 -y \
    openssh-server \
    && rm -rf /var/lib/apt/lists/*

# ENV SSH_PASSWD "root:dockui"

# Configure SSH for remote access
# Set up SSH to accept connections, use a safer configuration if production use
RUN mkdir /var/run/sshd
RUN echo "root:dockui" | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd

# Expose port 22 for SSH access
EXPOSE 22

# Adding environment YAML files for conda
ADD dl_environment.yml /tmp/dl_environment.yml
ADD dp_environment.yml /tmp/dp_environment.yml

# Create conda environments
RUN conda clean -afy && conda clean --packages && conda env create -f /tmp/dl_environment.yml 
RUN conda clean -afy && conda clean --packages && conda env create -f /tmp/dp_environment.yml

# Clean up and initialize conda for all shell types
RUN conda clean -afy && conda init

# Add the entire application directory
ADD . /AidUI

# Ensure script permissions
RUN chmod +x /AidUI/model_setup.sh

# Start SSHD on container start
CMD ["/usr/sbin/sshd", "-D"]


