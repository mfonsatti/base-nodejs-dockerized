FROM node:16
# Create app directory
WORKDIR /app
# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./
# Install options https://classic.yarnpkg.com/lang/en/docs/cli/install/
RUN yarn install --prod --frozen-lockfile
# Install VIM to manage merges into the terminal
RUN apt-get update && apt-get install -y vim
# Install git-bash-prompt https://github.com/magicmonty/bash-git-prompt
RUN git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1
RUN printf '\n\n# GitBashPrompt\n if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then\n GIT_PROMPT_ONLY_IN_REPO=1\n source $HOME/.bash-git-prompt/gitprompt.sh\n fi' >> ~/.bashrc
# Configure git autocompletion
RUN printf "\n\n# Git Autocompletion\n source /usr/share/bash-completion/completions/git" >> ~/.bashrc
# Bundle app source
COPY . .
EXPOSE 80
CMD [ "yarn", "start" ]
