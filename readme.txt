Title    : Quague Legacy
Version  : 1.3
Date     : 2021-06-13
Author   : Dan Amlund
Email    : dan@danamlund.dk
Web site : https://github.com/danamlund/quague-legacy
Thanks   : Cellar Door Games for making Rogue Legacy
         : http://cellardoorgames.com/our-games/rogue-legacy/


---
Mod
---
Single player quake with a Rogue Legacy progression system.

You play the regular quake single player levels.
You start out very weak.
You get money by killing monsters, finishing level with many kills, and finding secrets.
When you die, you spawn back at start and can buy upgrades with your money.
When you start playing again you lose your remaining money (so spend it all).

Save-loading remembers your progress. Save-loading to avoid death is discouraged.
If you want to play other levels use "changelevel mylevel" ("map mylevel" deletes your progress).

I play by selecting difficulty, then pressing 8 to run through all
quake levels in randomized order, die, buy upgrades, and press 8
again. Repeating until I become powerful enough to finish all 32
levels without dying.


--------
Upgrades
--------
Picked up health is lost over time down to your max health.
Max health is the minimum health you have had during a run.
Max boosted health is two times your starting health.
After level 20 you get more health per pickup.

Ammo increases your starting and maximum ammo.
After level 20 you get more ammo per pickup.

Armor increases your starting and maximum armor.
After level 20 your gain armor when killing monster.

Powerup determines the time of power ups.
After level 20 you start levels with quad and pent for a short while.

Weapons is which weapons you start with. Additional weapons are quad axe, and multi shafts.

Scavenge gives ammo when completing maps.
After level 20 you get ammo when killing monsters.

Level 20 is about normal quake level. Max level is 255.


------------
Installation
------------
1. Unzip so you have 'quake/quaguelegacy/progs.dat'
2. Run 'quake/myquake.exe -game quaguelegacy'


-------
Impulse
-------
impulse 160 prints a status of your levels.
impulse 161 gives you one million money.


------------------------
Changelog 1.3 2021-06-13
------------------------
Fixed bug where health would not be saved between levels when having at least one scavenge level.
Fixed bug where powerups above level 20 would not activate on all new levels
Fixed bug with max ammo on ammo pickups

------------------------
Changelog 1.2 2021-05-15
------------------------
Change armor to be percentage of total armor based on level.
Change start armor to green.
Change ammo multipliers to default quake (100 max shells,rockets, 200 max nails,cells).
Add new weapon quad axe.
Add new weapon multi shafts.
Give money when completing level and extra with 90% kills and extra with secrets.
Remove discount and replace it with scavenge.

------------------------
Changelog 1.1 2017-09-28
------------------------
Updates after level 20

------------------------
Changelog 1.0 2017-09-27
------------------------
?
