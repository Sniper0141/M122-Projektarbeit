# M122-Projektarbeit

## About this project

This project works as follows: 
- A shell script starts multiple subshells to listen to all files inside the folders registered in the `config` file.
- If the respective backup folder doesn't exist yet, the program creates it for you.
- These subshells copy the folder's contents into the respective backup folders *live*.

> [!NOTE]  
> Version control is not included in this program.

## How to set up your project

1. Clone the repository with `git clone https://github.com/Sniper0141/M122-Projektarbeit` or just use feature GitHub provides.
> [!IMPORTANT] 
> **DO NOT clone it into ANY folders containing spaces in their names!!!** 
> For example: &nbsp;**O N E D R I V E**&nbsp; folders!
2. Enter `chmod +x setup.sh` in the **root folder** of the repository.
3. Execute the `setup.sh` file with bash.
    - The script will now automatically start every time you boot your device.
    - To **manually start the program**, execute the `startup.sh`
4. Edit the `config` file and add your paths with the following pattern: 
`example-folder/subfolder|backup-folder-path/subfolder`
    - Both paths are **relative** to the **root directory**.
