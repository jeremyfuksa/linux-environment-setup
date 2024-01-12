# My Standard Linux Environment
When I'm not installing an app-specific OS distro, here's how I like my Raspberry Pi OS... or any Linux distro for that matter. This one's just tweaked to favor the Raspberry Pi.

After at least a decade of using oh-my-zsh, I had an ADHD-fueled desire to change the environment to the following:
* [Antigen](https://antigen.sharats.me)
* [Starship](https://starship.rs)

## Installation
Once you've logged into your new Raspberry Pi, run the following:
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/jeremyfuksa/linux-environment-setup/main/install.sh?token=GHSAT0AAAAAACMOIQXL327L43C7A4HWOOFYZNB2COA)"
```

## You Can't Mess Up!
Did you get your shell environment into a pickle? Start over! Just run this script and choose to reinstall. This will back up your current copy and install a fresh copy. You'll never brick a shell again!
