# Gerrit GitHub Plugin
<p align="center"><img src="https://lh4.googleusercontent.com/-_03bVFvmzzg/U0YvHJPBLCI/AAAAAAAAB4M/SSKXyOR_T3U/s0/diffymute-300x279.png"/></p>
<p align="center"><img src="https://assets-cdn.github.com/images/modules/logos_page/Octocat.png"/></p>

This plugin allows existing GitHub repositories to be integrated as Gerrit projects. This plugin works for Gerrit 2.12 and later versions. See the [original](https://github.com/GerritCodeReview/plugins_github) opensource project for more information.


#### Have a working instance of Gerrit 2.12
1. Download the **Gerrit 2.12 war file**.
2. Create a directory for Gerrit ```mkdir gerrit```
3. Place the ```gerrit.war``` file in your gerrit directory.
4. Run ```java -jar gerrit*.war init``` and configure.

#### Create Developer Application on GitHub
1. Visit [GitHub to Register a New Application](https://github.com/settings/applications/new) 
2. Copy Client ID and Client Secret. These will be needed for plugin configuration.

#### Download and Install Gerrit Github Plugins
1. Download the **github-oauth.jar** and **github-plugin.jar** Gerrit plugins
2. Rename oauth library to ```github-oauth.jar``` and place it in ```GERRIT_ROOT/lib```
3. Rename plugin to ```github-plugin.jar``` and place it in ```GERRIT_ROOT/plugins```
4. Run ```java -jar gerrit*.war init``` to reconfigure. See example ```gerrit.config``` below to help configure your instance with correct values. 
5. Run ```java -jar gerrit*.war reindex```
6. Start gerrit with ```GERRIT_ROOT/bin/gerrit.sh start```
7. Go to your Gerrit Home Page and test it out !
8. Checkout more details on [Oauth Token's scope](https://developer.github.com/v3/oauth/)

### Example gerrit.config
```
[gerrit]
        basePath = git
        canonicalWebUrl = http://<somewhere.company.com>:8080/  
[database]
        type = h2
        database = <gerrit_root_path>/db/ReviewDB
[index]
        type = LUCENE
[auth]
        type = HTTP
        httpHeader = GITHUB_USER
        logoutUrl = /oauth/reset
        httpExternalIdHeader = GITHUB_OAUTH_TOKEN
        loginUrl = /login
        loginText = Sign-in with GitHub
        registerPageUrl = "/#/register"
[receive]
        enableSignedPush = true
[sendemail]
        smtpServer = localhost
[container]
        user = <your_gerrit_user>
        javaHome = /usr/lib/jvm/jdk1.7.0_79/jre
[sshd]
        listenAddress = <somewhere.company.com>:29418
[httpd]
        listenUrl = http://<somewhere.company.com>:8080/
        filterClass = com.googlesource.gerrit.plugins.github.oauth.OAuthFilter
[cache]
        directory = cache
[github]
        url = https://github.com
        apiUrl = https://api.github.com
        clientId = <your_application_clientID>
        scopes = USER_EMAIL,REPO,READ_ORG  

```
### Sources and References
* [GitHub Plugin by Lucamilanesio](https://github.com/GerritCodeReview/plugins_github)
* [Java API for GitHub by Lucamilanesio](https://github.com/lucamilanesio/github-api)
* [Plugins and Libraries built by GerritForge](https://gerrit-ci.gerritforge.com/)
* [Gerrit Code Review Releases](http://gerrit-releases.storage.googleapis.com/index.html)