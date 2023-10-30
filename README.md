
# Automated backups 


## Usage Guideline 

### 1. Preconditions&Recommendations
- **Ensure that you have** one of the *compression tools* **(tar, zip)**
- Use **absolute paths** during configuration process 
- Check **script permissions**:
- **Ensure that each script itself has the execute permission.** You can use the chmod command to grant execute permissions to your script:

```bash
chmod +x your_script.sh
```

- **Ensure File and Directory Permissions:**
**Ensure that the you have the required permissions to read or write files in the directories that you will specify in script configurations**. You can adjust the permissions using the chmod command or by changing the ownership of the files or directories.

### 2. Setting up configurations
- **Open your terminal , navigate to project directory and run following command** 
```bash 
./set_config.sh
```
- **Then fill in all inputs with valid information _(use absolute paths)_**
<It will create your config file>


### 3.  Automation via _cron_
- **Open your terminal and run following command** 
**[Cron jobs guide](https://phoenixnap.com/kb/set-up-cron-job-linux)**
```bash
crontab -e 
```

- **In the end of opened file add customised version of the following line:**
```bash
 * * * * *  absolute/path/to/your/backup.sh/file
```
**_Exit and save_ this file**
