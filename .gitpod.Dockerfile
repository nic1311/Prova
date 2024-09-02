FROM gitpod/workspace-full

USER gitpod

# Install Android SDK dependencies
RUN sudo apt-get update && sudo apt-get install -y \
    lib32z1 \
    lib32ncurses6 \
    libbz2-1.0 \
    lib32stdc++6 \
    && sudo rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV ANDROID_HOME=/home/gitpod/android-sdk-linux
ENV PATH=${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools

# Install Android SDK
RUN mkdir -p ${ANDROID_HOME} && cd ${ANDROID_HOME} && \
    wget https://dl.google.com/android/repository/commandlinetools-linux-6858069_latest.zip && \
    unzip commandlinetools-linux-6858069_latest.zip -d cmdline-tools && \
    mkdir -p ${ANDROID_HOME}/cmdline-tools/latest && \
    mv cmdline-tools/* ${ANDROID_HOME}/cmdline-tools/latest/ && \
    yes | ${ANDROID_HOME}/cmdline-tools/latest/bin/sdkmanager --licenses && \
    ${ANDROID_HOME}/cmdline-tools/latest/bin/sdkmanager "platform-tools" "platforms;android-30" "build-tools;30.0.3"
