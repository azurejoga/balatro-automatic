# Automatic Balatro

## About the Game

**Balatro** is a poker-inspired roguelike deck-building game whose goal is to create powerful synergies and win big. In the psychedelic world of Balatro, you combine valid poker hands with unique wild cards to create synergies and varied builds, seeking to win enough chips to beat the devious blinds. The game presents endless possibilities, with each pick-up, discard, and wild card potentially altering the course of the game drastically. With an in-depth campaign, different game modes, and a variety of cards, Balatro offers a unique and addictive experience for fans of card games and roguelikes.

## Balatro Features

- **Ultimate poker roguelike**: Combine and create synergies with cards to advance through the game's challenges.
- **Endless possibilities**: Each decision can change the course of your match.
- **Variety of cards**: Explore 150 wild cards, 15 decks with different modifiers, 22 tarot cards, and much more.
- **Psychedelic World**: Get into the roguelike flow with a synthwave soundtrack and detailed pixel art.
- **Detailed statistics**: Study your best hands and most used jokers.

## What the Script Does

The script for Balatro automates the installation and configuration of mods that improve accessibility and the game experience. It performs the following functions:

1. **Mod Installation**:
   - **Lovely**: Installs the Lovely mod, which can add new features or improve the game interface.
   - **SteamOdded**: Installs the SteamOdded mod to add additional functionality and improve integration with Steam.
   - **Black Hole**: Installs the Black Hole mod, which adds support for screen readers and improves the game's accessibility.
   - **Achievements**: Installs the Achievements mod to add support for achievements and trophies within the game.

2. **Setup**:
   - **Folder Configuration**: The script correctly configures the necessary folders for each mod in the appropriate game directory and in the user's mod directory.
   - **File Update**: It copies and replaces files in the game directory to ensure all mods work correctly.

3. **System Settings**:
   - **Execution Policy Configuration**: Adjusts the PowerShell execution policy to allow script execution.

## Installation Instructions

### Buy the Game

* You can buy the game available on the [Steam here](https://store.steampowered.com/app/2379780/Balatro/)

### 1. Prepare the Game

Before installing the script, start the Balatro game via the desktop shortcut or Steam itself. Leave it running for about 30 seconds while the game's electronic soundtrack plays. After this period, close the window with `Alt+F4`. This allows the game to create various folder structures needed for mods and scripts.

### 2. Install the Script

You can choose one of the following methods to install the script:

#### Using PowerShell Command

1. Open PowerShell as Administrator.
2. Configure the execution policy and run the script directly:

   ```powershell
   Set-ExecutionPolicy -Scope Process -ExecutionPolicy Unrestricted -Force ; Invoke-Expression (Invoke-WebRequest -Uri "https://github.com/azurejoga/balatro-automatic/raw/master/balatro-automatic.ps1" -UseBasicParsing).Content
   ```

#### Using the Executable

1. Download the latest version of the executable [here](https://github.com/azurejoga/balatro-automatic/raw/master/balatro-install.exe)
2. You can check the security of the executable at [VirusTotal](https://www.virustotal.com/gui/file/6a83d830c5fc363a5b0261909d9da1a281c018208c6336e3a84355144b485924?nocache=1)

#### Note

The mods is NVDA compatible on Windows using Tolk. Support for macOS may work but is not guaranteed.

## Guide for Beginners

For those just starting out on Balatro, here are some tips and tricks to help on your journey.

### Controls

**Controller (Xbox naming conventions)**:
- **DPad**: Move through UI elements.
- **X**: Hand Store/Re-role.
- **Y**: Start new race, discard in game or next round while in a store.
- **A**: Confirm, select the cards (Hold + DPad to rearrange the cards).
- **B**: Cancel, deselect all cards if you have any selected.
- **Start/menu**: Open options menu.
- **Left trigger**: Show deck preview.
- **Right trigger**: View of the open deck.
- **Left bumper**: Sell card.
- **Right bumper**: Buy card or use a consumable.
- **Back/View**: Open execution information.

**Keyboard**:
- **WASD**: Move through UI elements.
- **X**: Hand Store/Re-role.
- **C**: Start new race, discard in game or next round while in a store.
- **Space**: Confirm, select cards (Hold + WASD to rearrange cards).
- **Shift**: Cancel, deselect all cards if you have any selected.
- **Escape**: Open options menu.
- **P**: Show deck preview.
- **E**: View of the open deck.
- **Z**: Sell card.
- **V**: Buy card or use consumable.
- **Guide**: Open execution information.

### Tips

**Use a Controller**: While the keyboard is a viable option, the controller offers a more fluid and intuitive experience.

**Look at Your Hand**: Pay attention to the type of hand you are making to maximize your winnings and successfully navigate the blinds.

**Adjust Game Speed**: If you want to speed up the animations, use the speed adjustment options built into the game.

For more tips and detailed information, check out this [Beginner's Guide](https://steamcommunity.com/sharedfiles/filedetails/?id=3166504510)

## Support for macOS

**Note**: Support for macOS is not yet available. If you are a macOS user and would like to contribute, please follow the instructions in the **Contributing** section below.

## Installation Support for macOS Script

macOS users who wish to contribute can open an [issue](https://github.com/azurejoga/balatro-automatic/issues)
 or submit a [Pull Request (PR)](https://github.com/azurejoga/balatro-automatic/pulls) with support for macOS

## Contributing

If you want to contribute to development or improve support for macOS:

- Open an [Issue](https://github.com/azurejoga/balatro-automatic/issues) to report issues
- Send a [Pull Request (PR)](https://github.com/azurejoga/balatro-automatic/pulls) with your improvements

## Credits

- Documentation and installation script: **AzureJoga**.
- Review: **Sightless Kombat**. Check out Balatro's [review](https://reviews.sightlesskombat.com/Bal.shtml)
- Tester: **Matrheine** matrheine@gmail.com
