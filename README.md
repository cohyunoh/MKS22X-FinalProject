# MKS22X-FinalProject

# WELCOME TO NEOKNIGHT!!!!!

# HOW TO PLAY
NEOKNIGHT is a roguelike game where the player traverses through the world attempting to complete different objectives. To start the player must press the mouse and after that, they are free to explore, fight, or complete the stated objective.

INSTRUCTIONS

-**I** : Pressing 'I before starting allows you to read the instructions

-**R** : Pressing 'R' will restart the game.

-**E** : Pressing 'E' has two functions: Picking up items from the floor **and** Passing through open doors

-**Q** : In order to access the shop, the player must press the 'Q' key. Pressing this key in the shop will lead to the player exiting the shop.

 -**1-6** : In order to purchase the desired item, the player must press the corresponding number on their keyboard.

 -**Y** : After winning, if you decide you want to restart, press 'Y' to restart the game.

 -**C** : Displays the player's inventory

-**CLICKING** : Clicking the mouse allows you to use the item you are holding.

-**SCROLLING** : Scrolling the mouse allows you to go through the player's inventory.

-**ESC** : Pressing escape allows you to end the game.

# DEV LOG

DAY 1 5/20:
Connor:
Started the item class and the entity class
Tested a possible move method which lagged a bit but was able to move left and right
Attempted at displaying animations of an item; failed and needed to look up example .
Samson:  
Started the rooms class .
Attempted displaying array .

DAY 2 5/21:
Connor:
Got items to finally display after creating an animation class but had problems with the item copying over itself .
Samson:  
Tested random map generation but to no avail so switched to premade map for now .
Attempted a basic main menu and it was successful .

DAY 3 5/21:
Connor:
Figured out that the background command needs to be called after each animation but two animations can't be shown at the same
time
Made the entity constructor and its display method
Finally got the character to move around .    
Samson 5/22:    
Scratched the premade map and returned to random gen .
Created a class and attempted using an enum to help generate the map .
Added methods to both the classes .

DAY 4 5/23:
Connor:
Worked on smoothing out the animations so the character doesn't moonwalk. Realized that the character keeps walking once
stopped.
Helped Samson with rooms as Samson coded and Connor watched and spotted out errors.
Samson:  
Changed the constructor parameters and started untested room gen .
Reorganized code .
Able to display code by end of today .

DAY 5 5/24:
Connor:
Fixed the issue of two animations not being able to be shown
Realized that entities and items should have stored x and y values and have helper methods to alter and use those two floats
Working on a buffer for the keyboard .
Samson 5/25:  
Able to display the whole maps .
Stored valid coordinates of Rooms .
Able to display only the current room .

Day 6 5/26:  
Samson:  
Used Images for Room displays .
Switched from Images to letters .
Connor:
Worked and failed at buffer after trying so many methods like serials and stringbuffer, going to ask Mr. K the next day.
Also gave the entities more helper methods to access instance variables

Day 7 5/27:
Samson:  
Planned out how to properly display rooms .

Day 8 5/28:
Samson:
Redid most of the code based on plan .

Day 9 5/29:
Samson:
Able to display the rooms cleaner .
Added toString for rooms for display purposes .
Connor:
Got the buffer to work and the Player can now walk, run, and pick up items and store it in its inventory

Day 10 5/28:
Samson:
Able to display the current room of the player .
Messed around with character sizing in order to make rooms nicer to look at .
Connor:
Worked on displaying the HUD with the health, armor, and worked on the inventory display. Scrolling through the inventory is
giving problems

Day 11 5/29:
Samson:
Made Doors class in order to simplify transitions .
Created room constructor that takes in a door in order to make sure you can return .
Stored coordinates of door in order to display door location .
Stored doors in order to access later .
Connor:
Got the character to switch items
Made a sample enemy that chases the player while in radius

Day 12 5/30:
Samson:
Finished displaying rooms and placing doors
Connor:
Polished the chasing enemy making it stop while not in pursuit
Worked on the attack feature

Day 13 5/31
Samson:
Continued working on randomly displaying rooms and doors
Connor:
After merging the previous branches, the room is now able to be displayed
Camera moves with player
Failed to implement player

Day 14 6/1
Samson:
Finished placing doors in the map and worked on randomly placing a certain number of doors minimum
Connor:
Successfully displayed player in the middle of the screen
Successfully displayed enemies as they move with the room
Everything bounces back when hit
Successfully throws splashscreen
Somewhat the map to work at all times although it does take a bit sometimes

Day 15 6/2
Samson:
Before pair programming, worked on locked doors being created and displaying the same number of keys.
Keys sometimes didn't appear but the tile where they should've been did appear.
Worked on world traversal
Connor:
Did pair programming to work on locked Doors
Began work on arrows
Helped to finish first version of world traversal

Day 16 6/3
Samson:
Continued working on locked doors and world traversal
Began working on shops and getting them to display but was unsuccessful as shop teleported out of bounds
Connor:
Worked on world traversal to make it actually worked. (SUCCESS)
Worked on the constrains so everything stayed in bounds (SUCCESS)
Try to do projectiles and made them hurt enemies (SOMEWHAT SUCCESSFUL)
Got arrows to stay in bounds but could not rotate them properly
The Player can now hold and use all items in the game, just needs animations
Finished locked doors

Day 17 6/4
Samson:
Continued working on and finished shops
Shops display items as well as messages about how much money you are missing if you don't have enough
Purchased items go to player inventory after purchase
Cleaned up the menus
Added comments for legibility purposes
Added instructions on how to play
Added end Screen after you win
Able to display player's inventory
Can restart game when want to

Connor:
Finished arrows for the Player
Did the currency system
Made mercenaries that can roam freely
Made objectives work
Made enemies have certain items at certain times whether a player is in need of health or a weapon
Made potions disappear after use
Arrows disappear once they hit a wall
Bows use up arrows
Fixed Item error
Fixed potion error
