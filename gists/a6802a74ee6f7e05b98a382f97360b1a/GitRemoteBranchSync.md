# Git Remote Branch Sync

There are some folks who want to keep their **local** git branch list to be in sync with the 
branches available on the **remote**. This typically happens after a **Pull Request** on GitHub Enterprise,
when the remote branch is merged and removed, but the branch still exists locally.

To clean up the branches that no longer exist on the remote, there are a couple of options (as well as more
that are not listed here):

- **The quick way:**

    ```
    git branch --merged | grep -v "\*" | xargs -n 1 git branch -d
    ```
    
- **Make sure we keep master:**
    - You can ensure that `master`, or any other branch for that matter, doesn't get removed by greping for more. In that case you would go:

   ```
   git branch --merged | grep -v "\*" | grep -v "master" | xargs -n 1 git branch -d
   ```

- **If you want to keep multiple branches:**
    - So if we wanted to keep `master`, `develop` and `staging` for instance, we would use:
    
    ```
    git branch --merged | grep -v "\*" | grep -Ev "(\*|master|develop|staging)" | xargs -n 1 git branch -d
    ```

Reference: [Delete local Git branches after deleting them on the remote repo](http://stackoverflow.com/questions/17983068/delete-local-git-branches-after-deleting-them-on-the-remote-repo)