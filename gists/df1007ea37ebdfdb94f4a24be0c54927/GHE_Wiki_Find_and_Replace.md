# Perform a Mass Find-and-Replace in a GitHub Enterprise Wiki

If you have a need to update text/string in your GitHub Enterprise wiki, and you 
have many wikis where manual find-and-replace can be tedious, one way to perform 
a mass update is to clone your wiki (as a git repository) to a local workspace 
and perform find-and-replace.

Here is an example of using the Unix-based `sed` command to perform a find-and-replace:

1. Access your repository's wiki site. Example: https://github.company.com/OWNER/REPO/wiki

2. On the right-side of the wiki, you will see **Clone this wiki locally**. Use this URL to clone the wiki to your local workspace. The clone command will look similar to:

    ```
    git clone https://github.company.com/OWNER/REPO.wiki.git
    ```

3. Navigate into the cloned repository and run the below `for...sed` command to perform the find and replace from **OLDVALUE** to **NEWVALUE**:

    ```
    cd REPO.wiki
    for i in `ls -1`; do sed -i 's/OLDVALUE/NEWVALUE/g' $i; done
    ```

4. At this point the find-and-replace is completed and you can view what was changed by running:

    ```
    git diff
    ```

5. Finally if the changes are acceptable, you can use the following to commit and push your changes to the server:

    ```
    git add --all
    git commit -m "Performed a full find-and-replace from OLDVALUE to NEWVALUE"
    git push origin master
    ```