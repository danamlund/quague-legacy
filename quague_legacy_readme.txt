Title    : Quague Legacy
Version  : 1.0
Date     : 2017-09-24
Author   : Dan Amlund
Email    : dan@danamlund.dk
Web site : ...
Thanks   : Cellar Door Games for making Rogue Legacy
         : http://cellardoorgames.com/our-games/rogue-legacy/


---
Mod
---
Single player quake with a Rogue Legacy progression system.

You play the regular quake single player levels.
You start out very weak.
Killing monsters gives money.
When you die, you spawn back at start and can buy upgrades with your money.
When you start playing again you loose your remaining money (so spend it all).

Save-loading remembers your progress. Save-loading to avoid death is discouraged.
If you want to play other levels use "changelevel mylevel" ("map mylevel" deletes your progress).


--------
Upgrades
--------
Picked up health is lost over time down to your max health.
Max health is the minimum health you have had during a run.
Max boosted health is two times your starting health.

Ammo increases your starting and maximum ammo.

Armor increases your starting and maximum armor.

Weapons is which weapons you start with.

Powerup determines the time of power ups.
After many levels you also start levels with quad damage for a short while.

Discount reduces prices down to 20%.

Level 10 is about normal quake level. Max level is 255 (80 for discount).


------------
Installation
------------
1. Unzip so you have 'quake/quague_legacy/progs.dat'
2. Run 'quake/myquake.exe -game quague_legacy'


-------
Impulse
-------
impulse 160 prints a status of your levels.
impulse 161 gives you one million money.
