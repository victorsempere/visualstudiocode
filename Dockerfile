FROM ubuntu:14.04

RUN sh -c 'echo "deb http://ppa.launchpad.net/git-core/candidate/ubuntu trusty main" > /etc/apt/sources.list.d/git.list'
RUN sh -c 'echo "deb-src http://ppa.launchpad.net/git-core/candidate/ubuntu trusty main" >> /etc/apt/sources.list.d/git.list'
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E1DD270288B4E6030699E45FA1715D88E1DF1F24
RUN apt-get update
RUN apt-get install -y git

RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
RUN mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
RUN sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
RUN apt-get install -y apt-transport-https
RUN apt-get update
RUN apt-get install -y code # or code-insiders

RUN curl -sL https://deb.nodesource.com/setup_8.x > /tmp/setup_node8.sh 
RUN chmod +x /tmp/setup_node8.sh
RUN /tmp/setup_node8.sh
RUN apt-get update
RUN apt-get install -y nodejs
RUN apt-get install -y build-essential 

RUN adduser develop
VOLUME /home/develop/repo
RUN chown -R develop:develop /home/develop/repo

USER develop
RUN mkdir /home/develop/.npm-global
ENV PATH=/home/develop/.npm-global/bin:$PATH
ENV NPM_CONFIG_PREFIX=/home/develop/.npm-global
RUN npm install -g @angular/cli@1.5.0

CMD /usr/bin/code --user-data-dir=/home/develop/repo --verbose