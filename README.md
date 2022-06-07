# pacman_game
First attempt at making a game, written using Processing.

## Description
- I decided to allow the ghosts to pass through walls, as well as having much more ghosts than the original game, as I thought this allowed for more unpredictable behaviour from the ghosts and would make the game more interesting. 

- There is a working game menu with level selection and an exit button, as well as a reset (resets back to the first level), and menu button in both levels. There is also an element of randomness in the generation of the power pellets. Pellet positions are hardcoded, but each pellet has a small probability of being a power pellet. The level layouts are also hardcoded, as I wanted to have at least one of the levels be the same layout as the original Pac-Man game. The player has functional wall collision detection, and is drawn to fact the direction of travel, as well as having an animated mouth. The player’s remaining lives and score are displayed at the bottom of each level. Ghost movement is also random, as every 500 frames they will change to a random direction, so even if all ghosts start in the same area (like in level 1), they eventually scatter.

## Issues
- Although the wall collision detection for Pac-Man is functional and gives slightly more freedom to the player (can move around slightly within a path), the tendency to occasionally get caught on corners can be annoying (I tried to minimise this by allowing Pac-Man to partially clip into the wall to make turning more flexible). Next time, I would implement the movement system so that Pac-Man’s location is based around the cells of the maze to limit the player to only staying directly in the middle of the path, rather than having a separate coordinate system for the maze and player.
