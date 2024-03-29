<h1 align="center">User Processes 🔄 </h1>

This program is a personalized version of the "ps" command in Bash. It provides a list of the running processes for the current user.

<p  align="center" >
  <img width="600px"src="https://github.com/AlejandroDavidArzolaSaavedra/procesos-de-usuario/assets/90756437/ec70f535-d008-4b26-a881-b7ca843ff19e">
</p>

# 👥 Development Team (Ctrl + Click to view profiles)

[![GitHub](https://img.shields.io/badge/GitHub-Alejandro%20David%20Arzola%20Saavedra-blue?style=flat-square&logo=github)](https://github.com/AlejandroDavidArzolaSaavedra)

## How to Run the Program 🔍

Clone this repository to your local machine:
<img align="right" width="100px" src="https://github.com/AlejandroDavidArzolaSaavedra/User-Processes-Script/assets/90756437/19bd5b71-30a2-4398-8759-8bfe89414580">
```bash
git clone https://github.com/your_username/User-Processes-Script.git
```
Navigate to the project directory:
<img align="right" width="100px" src="https://github.com/AlejandroDavidArzolaSaavedra/User-Processes-Script/assets/90756437/913ab94d-7f23-4663-afe5-1c7f8dab38ed">
```bash
cd User-Processes-Script
```

Grant execution permissions to the program file:
<img align="right" width="100px" src="https://github.com/AlejandroDavidArzolaSaavedra/User-Processes-Script/assets/90756437/a459107b-6aff-416f-825f-eb0c48608c0b">
```bash
chmod +x custom_ps.sh
```

### Run the program:

For basic elements:

```bash
./custom_ps.sh <integer>
```

Example:

```bash
./custom_ps.sh 1
```

It will display information about the user who executed the program if it exceeds the threshold.

To run it with basic elements and a list of users:

```bash
./custom_ps.sh <integer> [List of users]
```

Example:

```bash
./custom_ps.sh 1 root pepe juan Suarez
```

The list will show users from the system exceeding the threshold, and those not part of the system due to user error will be displayed separately.

To run it with additional basic elements:

```bash
./custom_ps.sh <integer> <option> [List of users]
```

Options include:

- `-m` Total virtual memory
- `-t` Processes with tty
- `-T` Processes without tty

Example:

```bash
./custom_ps.sh 1 -Tmt root pepe juan Suarez
```

or

```bash
./custom_ps.sh 1 -mt
```

## Features ⚙️

Displays a list of running processes for the current user. It provides information such as the username, UID, total number of processes for that user, total number of threads for that user at the moment, the number of processes sleeping by default, and optionally the total virtual memory consumption, the total number of processes with tty, and the total number of processes without tty.

## Contributions 🤝
<img align="left" width="100px" src="https://github.com/AlejandroDavidArzolaSaavedra/User-Processes-Script/assets/90756437/dfcbc811-ea31-406d-b730-7fa4d1c24210">
<h3 align="center">Contributions are welcome, follow these steps</h3>

- Fork this repository.
- Create a branch for your new feature: `git checkout -b new-feature`
- Make necessary changes and commit: `git commit -am 'Add new feature'`
- Push your changes to your forked repository: `git push origin new-feature`
- Open a pull request in this repository.

<h1 align="center">Enjoy using the Custom PS! 🚀</h1>
