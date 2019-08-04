# Source code, build & devops tools tips & tricks

# Git

## Git general

```
git checkout -b testing (moves you to local branch testing)
git push origin testing -> makes remote at gitlab
git status
git add file_name
git commit -am "your message"
git commit --amend -s
git pull origin testing
git fetch -p

git reset --hard origin/master
git clean -fd

git branch -d the_local_branch
git branch -D the_local_branch (force mode)

git branch -r

GIT_SSH_COMMAND="ssh -v" git pull

git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D -> clenup

```

## Gerrit 
```
ide na master
git pull
przechodze na branch'a local
git rebase master
ide na master
git merge branchName --squash
git commit -am "opis jakis" -sq
git commit --amend 
git push origin HEAD:refs/for/master

```

# devops

## bash for Linux

```
grep -rnw '/path/to/somewhere/' -e 'pattern' 
fdisk <path-to-drive>

sudo dnf install docker
sudo dnf update/upgrade
sudo dnf clean all

du -xh / |grep '^\S*[0-9\.]\+G'|sort -rn
cat /etc/sudoers

MBR/GPT clenup
dd if=/dev/zero of=/dev/sdc bs=512 count=1

private/public keys
- transformation
1) set permission to 400
2) puttygen <file-name>.ppk -o <file-name>.pem -O private-openssh

```

## docker 

```
#docker usage
docker images
docker ps
docker logs -f CONTAINER_ID
docker system prune -a

docker ps -q -a | xargs docker stop
docker ps -q -a | xargs docker rm

docker ps -a | grep -v "decisco" | awk '{print $1}' | xargs docker stop
docker ps -a | grep -v "decisco" | awk '{print $1}' | xargs docker rm
docker ps -a | grep -v "decisco" | awk '{print $1}' | xargs docker rmi -f

# docker management
docker shutdown -t now
docker-machine ip
docker-machine env 
docker-machine ssh default
docker-machine regenerate-certs default
docker-machine restart default

```

```
Installation destinantion change:
systemctl stop docker
mv /var/lib/docker /data/
ln -s /data /var/lib/docker
systemctl daemon-reload
systemctl start docker

```

## docker-compose

```

sudo yum install epel-release
sudo yum install -y python-pip
sudo pip --proxy= http://host:port/ install docker-compose
sudo usermod -a -G docker $USER
sudo systemctl daemon-reload
sudo systemctl restart docker
sudo systemctl enable docker
~/.docker/config.json
/etc/systemd/system/docker.service.d/override.conf

Problems with certificates

yum check-update ca-certificates; (($?==100))
yum update ca-certificates
yum reinstall ca-certificates
update-ca-trust extract

```

# Build tools
## Gradle 5.x
```
gradle clean build 
gradle clean build -X test (exclude) 
gradle clean build test --continue
gradle clean build --build-cache

scopes
http://andresalmiray.com/maven-scopes-vs-gradle-configurations/

```

## Maven 3.6.x
```
set MAVEN_OPTS=-Xmx2000m -XX:MaxPermSize=2000m

mvn clean install [-T 4 - threads per build'a, 2C - 2 threads per Core ] [-o]
mvn versions:set -DnewVersion=2.0-SNAPSHOTKogut

junit: -Dsurefire.skipAfterFailureCount=1 -DskipTests

surefire-report:report 
cobertura:cobertura 
checkstyle:checkstyle 
pmd:pmd pmd:cpd 
findbugs:findbugs 
javadoc:javadoc 

versions:display-dependency-updates 
versions:display-plugin-updates

mvn clean install versions:display-dependency-updates versions:display-plugin-updates

enforcer:enforce

dependency:analyze-report => does nothing
dependency:analyze-dep-mgt => executes analysis
dependency:analyze-duplicate => searches duplicates
dependency:resolve-plugins
dependency:tree -> builds dependecy tree => good view to read as tree
dependency:tree -DoutputType=graphml -DoutputFile=dependency.graphml [-Dincludes=com.mossad.nac.debt]
dependency:go-offline
-fae
-P profile-1,profile-2

-rf, --resume-from, Resume reactor from specified project
-pl, --projects, Build specified reactor projects instead of all projects
-am, --also-make, If project list is specified, also build projects required by the list
-amd, --also-make-dependents, If project list is specified, also build projects that depend on projects on the list 

-------------------------------------------------------------------------------

Drawing dependencies between modules:

com.github.janssk1:maven-dependencygraph-plugin:1.0:graph  -DoutputType=graphml -DoutputFile=dependency.graphml 

1)
mvn clean install -Dmaven.test.skip=true com.googlecode.maven-overview-plugin:maven-overview-plugin:RELEASE:overview => complec view
mvn clean install -Dmaven.test.skip=true com.googlecode.maven-overview-plugin:maven-overview-plugin:RELEASE:overview -Dinludes=Dincludes=my.com.you.they -Dscopes=compile

2)
mvn dependency:tree -DoutputType=graphml -DoutputFile=dependency.graphml -Dincludes=my.package.ok.package
yEd Graph Editor 
By default yED will not format the graph, but it has many different formats that you can use. Two simple steps separates you from a nice graph:
a) Select Tools > Fit Note to Label > OK This should adjust the labels
b) Select Layout > Hierarchical > Orientation > Left to Right > OK 

3) mvn clean install -Dmaven.test.skip=true com.github.janssk1:maven-dependencygraph-plugin:1.2:graph -e

All in one example:
mvn clean install surefire-report:report cobertura:cobertura site checkstyle:checkstyle pmd:pmd pmd:cpd findbugs:findbugs javadoc:javadoc versions:display-dependency-updates versions:display-plugin-updates dependency:analyze-report dependency:analyze-dep-mgt dependency:analyze-duplicate dependency:resolve-plugins dependency:tree -DoutputType=graphml -DoutputFile=dependency.graphml

```
