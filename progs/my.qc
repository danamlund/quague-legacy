void() printMenu;

float MyTriggeredNewLevel;
float MyShowingMenu;
float MyNextShowMenuTime;
float MyShowingWelcome;
float MyPrevHealthRotTime;

void() addLevelsToArray =
{
        array_clear();
        array_add("e1m1");
        array_add("e1m2");
        array_add("e1m3");
        array_add("e1m4");
        array_add("e1m5");
        array_add("e1m6");
        array_add("e1m7");
        array_add("e1m8");
        array_add("e2m1");
        array_add("e2m2");
        array_add("e2m3");
        array_add("e2m4");
        array_add("e2m5");
        array_add("e2m6");
        array_add("e2m7");
        array_add("e3m1");
        array_add("e3m2");
        array_add("e3m3");
        array_add("e3m4");
        array_add("e3m5");
        array_add("e3m6");
        array_add("e3m7");
        array_add("e4m1");
        array_add("e4m2");
        array_add("e4m3");
        array_add("e4m4");
        array_add("e4m5");
        array_add("e4m6");
        array_add("e4m7");
        array_add("e4m8");
}

void() MyWorldspawn =
{
        // cache quad sounds in case getPowerLevel() > 20
	precache_model ("progs/quaddama.mdl");
	precache_sound ("items/damage.wav");
	precache_sound ("items/damage2.wav");
	precache_sound ("items/damage3.wav");
}

float() getMoney =
{
        return parm10;
}

void(float money) setMoney =
{
        parm10 = money;
}

float() getHealthLevel =
{
        return getHigh(parm12);
}
float() getMaxHealth =
{
        return 50 + getHealthLevel() * 10;
}
float() getHealthMultiplier =
{
        if (getHealthLevel() <= 20) {
          return 1.0;
        }
        return 1.0 + (getHealthLevel() - 20) * 0.1;
}
void(float level) setHealthLevel =
{
        local float mid, low;
        mid = getMid(parm12);
        low = getLow(parm12);
        parm12 = encode(level, mid, low);
}

float() getArmorLevel =
{
        return getMid(parm12);
}
float() getMaxArmor =
{
        return 10 * getArmorLevel();
}
void(float level) setArmorLevel =
{
        local float high, low;
        high = getHigh(parm12);
        low = getLow(parm12);
        parm12 = encode(high, level, low);
}

float() getAmmoLevel =
{
        return getLow(parm12);
}
float() getMaxAmmo =
{
        return 20 + 4 * getAmmoLevel();
}
float() getAmmoMultiplier =
{
        if (getAmmoLevel() <= 20) {
           return 1.0;
        }
        return 1.0 + (getAmmoLevel() - 20) * 0.1;
}
void(float level) setAmmoLevel =
{
        local float high, mid;
        high = getHigh(parm12);
        mid = getMid(parm12);
        parm12 = encode(high, mid, level);
}

float() getWeaponLevel =
{
        return getHigh(parm13);
}
void(float level) setWeaponLevel =
{
        local float mid, low;
        mid = getMid(parm13);
        low = getLow(parm13);
        parm13 = encode(level, mid, low);
}

float() getPowerLevel =
{
        return getMid(parm13);
}
float() getPowerTimeStart =
{
        if (getPowerLevel() > 20) {
          return floor(getPowerLevel() / 5.0);
        }
        return 0;
}
float() getPowerTime =
{
        return 10 + getPowerLevel();
}
void(float level) setPowerLevel =
{
        local float high, low;
        high = getHigh(parm13);
        low = getLow(parm13);
        parm13 = encode(high, level, low);
}

float() getDiscountLevel =
{
        return getLow(parm13);
}
float() getDiscount =
{
        return 1.0 - getDiscountLevel() / 100;
}
void(float level) setDiscountLevel =
{
        local float high, mid;
        high = getHigh(parm13);
        mid = getMid(parm13);
        parm13 = encode(high, mid, level);
}

float() getDeaths =
{
        return parm14;
}
void(float deaths) setDeaths =
{
        parm14 = deaths;
}

float() resetMoneyNextLevel =
{
        return valueGetBit(parm11, 0);
}
void(float b) setResetMoneyNextLevel =
{
        parm11 = valueSetBit(parm11, 0, b);
}

float() firstTime =
{
        return !valueGetBit(parm11, 1);
}
void(float b) setFirstTime =
{
        parm11 = valueSetBit(parm11, 1, !b);
}

float() getShuffledIndex =
{
        return getUint8t(parm16);
}
float() getShuffledRandom =
{
        return getUint16t(parm16);
}
void(float i) setShuffledIndex =
{
        parm16 = encode16And8(getShuffledRandom(), i);
}
void(float rand) setShuffledRandom =
{
        parm16 = encode16And8(rand, getShuffledIndex());
}
float() shuffledLevels =
{
        return valueGetBit(parm11, 2);
}
void(float b) setShuffledLevels =
{
        if (b && !shuffledLevels()) {
          setShuffledIndex(0);
          setShuffledRandom(floor(random() * 65535) + 1);
        }
        parm11 = valueSetBit(parm11, 2, b);
}

void(float sflags) setEpsCompleted =
{
        if (valueGetBit(sflags, 0)) {
          parm11 = valueSetBit(parm11, 3, TRUE);
        }
        if (valueGetBit(sflags, 1)) {
          parm11 = valueSetBit(parm11, 4, TRUE);
        }
        if (valueGetBit(sflags, 2)) {
          parm11 = valueSetBit(parm11, 5, TRUE);
        }
        if (valueGetBit(sflags, 3)) {
          parm11 = valueSetBit(parm11, 6, TRUE);
        }
}
float(float ep) isEpCompleted =
{
        return valueGetBit(parm11, 2 + ep);
}

float() isStartMap =
{
        if (world.model == "maps/start.bsp") {
           return TRUE;
        } else {
           return FALSE;
        }
}

float(float level) getHealthArmorAmmoCost =
{
        local float allLevels = getHealthLevel() + getArmorLevel() + getAmmoLevel() + getPowerLevel();
        return floor(getDiscount() * (level * 10 + floor(allLevels / 2)));
}
float(float level) getWeaponCost =
{
        return floor(getDiscount() * level * 100);
}

void() setStartGear =
{
        self.max_health = 20 + getHealthLevel() * 10;
        self.health = self.max_health;

        self.items = IT_AXE + IT_SHOTGUN;
        if (getWeaponLevel() >= 1) {
           self.items += IT_NAILGUN;
           self.ammo_nails = getMaxAmmo();
        }
        if (getWeaponLevel() >= 2) {
           self.items += IT_SUPER_SHOTGUN;
        }
        if (getWeaponLevel() >= 3) {
           self.ammo_rockets = floor(getMaxAmmo() / 4);
           self.items += IT_GRENADE_LAUNCHER;
        }
        if (getWeaponLevel() >= 4) {
           self.items += IT_SUPER_NAILGUN;
        }
        if (getWeaponLevel() >= 5) {
           self.items += IT_ROCKET_LAUNCHER;
        }
        if (getWeaponLevel() >= 6) {
           self.ammo_cells = floor(getMaxAmmo() / 2);
           self.items += IT_LIGHTNING;
        }

        self.ammo_shells = getMaxAmmo();

        if (getMaxArmor() > 0) {
          self.armorvalue = getMaxArmor();
          self.armortype = 0.6;
          self.items += IT_ARMOR2;
        }

        self.weapon = IT_SHOTGUN;
        self.currentammo = self.ammo_shells;
	W_SetCurrentAmmo ();

        if (getPowerTimeStart() > 0) {
           self.super_time = 1;
           self.super_damage_finished = time + getPowerTimeStart();
	   self.items = self.items | IT_QUAD;
	   SUB_UseTargets();
        }
}

void() printProgressionStatus =
{
        local string money = ftos(getMoney());
        local string health = ftos(getHealthLevel());
        local string armor = ftos(getArmorLevel());
        local string ammo = ftos(getAmmoLevel());
        local string weapons = ftos(getWeaponLevel());
        local string powerup = ftos(getPowerLevel());
        local string discount = ftos(getDiscountLevel());

        MyPrint6("Money=", money, " Health=", health, " Armor=", armor);
        MyPrint6(" Ammo=", ammo, " Wpn=", weapons, " Power=", powerup);
        MyPrint3(" Discount=", discount, "\n");

        local string maxHealth = ftos(self.max_health);
        MyPrint3("Max stable health=", maxHealth, "\n");
        if (shuffledLevels()) {
          local string levelNumber = ftos(getShuffledIndex());
          local string levelMax = ftos(array_size() + 1); // +1 for end
          MyPrint5("Shuffled level ", levelNumber, "/", levelMax, "\n");
        }
}

void(float impulse) MyImpulseCommands =
{
        if (MyShowingMenu || MyShowingWelcome) {
           local float cost;
           cost = 0;
           if (impulse == 1 && getHealthLevel() < 255) {
              cost = getHealthArmorAmmoCost(getHealthLevel() + 1);
              if (getMoney() >= cost) {
                setHealthLevel(getHealthLevel() + 1);
              }
           } else if (impulse == 2 && getArmorLevel() < 255) {
              cost = getHealthArmorAmmoCost(getArmorLevel() + 1);
              if (getMoney() >= cost) {
                setArmorLevel(getArmorLevel() + 1);
              }
           } else if (impulse == 3 && getAmmoLevel() < 255) {
              cost = getHealthArmorAmmoCost(getAmmoLevel() + 1);
              if (getMoney() >= cost) {
                setAmmoLevel(getAmmoLevel() + 1);
              }
           } else if (impulse == 4 && getPowerLevel() < 255) {
              cost = getHealthArmorAmmoCost(getPowerLevel() + 1);
              if (getMoney() >= cost) {
                setPowerLevel(getPowerLevel() + 1);
              }
           } else if (impulse == 5 && getWeaponLevel() < 6) {
              cost = getWeaponCost(getWeaponLevel() + 1);
              if (getMoney() >= cost) {
                setWeaponLevel(getWeaponLevel() + 1);
              }
           } else if (impulse == 6 && getDiscountLevel() < 80) {
              cost = getHealthArmorAmmoCost(getDiscountLevel() + 1);
              if (getMoney() >= cost) {
                setDiscountLevel(getDiscountLevel() + 1);
              }
           }

           if (cost > 0 && getMoney() >= cost) {
              setMoney(getMoney() - cost);
              setStartGear();
              printMenu();
           }
           if (cost > 0 && getMoney() < cost) {
              sprint(self, "Not enough money\n");
           }

           if (impulse == 7) {
              if (isEpCompleted(1) && isEpCompleted(2) && isEpCompleted(3) && isEpCompleted(4)) {
                changelevel("end");
              } else {
                sprint(self, "Complete all episodes\n");
              }
           }
           if (impulse == 8) {
             setShuffledLevels(TRUE);
             MyGotoNextMap();
           }

           if (impulse == 161) {
             setMoney(getMoney() + 1000000);
           }
        }
        if (impulse == 160) {
          printProgressionStatus();
        }
}

void(float died) MyNewMap =
{
        if (resetMoneyNextLevel()) {
          setMoney(0);
          setResetMoneyNextLevel(FALSE);
          setStartGear();
        }
        if (isStartMap()) {
           if (!shuffledLevels()) {
             setEpsCompleted(serverflags);
           }
           if (serverflags > 0) {
             // clear runes so episodes are not closed off on start map
             serverflags = 0;
             changelevel("start");
           }

           setStartGear();
           MyShowingMenu = TRUE;
           setShuffledLevels(FALSE);
        } else {
           printProgressionStatus();
        }
        if (died) {
           setDeaths(getDeaths() + 1);
           setResetMoneyNextLevel(TRUE);
        }
}

void() MyPlayerPostThink =
{
        local string money;

        if (firstTime()) {
           setResetMoneyNextLevel(TRUE);
           MyTriggeredNewLevel = TRUE;
           setFirstTime(FALSE);
           MyShowingWelcome = TRUE;
           setStartGear();
        }

        if (MyShowingWelcome) {
           if (time < 10.0) {
             centerprint (self, "Welcome to Quague Legacy!\n\nQuake with Rogue Legacy progression:\nYou get money for killing monsters,\n you die,\n you buy upgrades,\n you go again.\n\nDont load, just die.");
           } else {
             MyShowingWelcome = FALSE;
             MyShowingMenu = TRUE;
           }
           return;
        }
        

        if (time > 2.0 && !MyTriggeredNewLevel) {
          if (isStartMap() && !serverflags && !shuffledLevels()) { // serverflags empty if no runes
            MyNewMap(TRUE);
          } else {
            MyNewMap(FALSE);
          }
          MyTriggeredNewLevel = TRUE;
        }

        if (MyShowingMenu) {
          if (!time || time > MyNextShowMenuTime) {
            printMenu();
            MyNextShowMenuTime = time + 1;
          }
        }

        if (time > 5 && MyPrevHealthRotTime < time - 2) {
           if (self.health > self.max_health) {
              self.health--;
           }
           if (getArmorLevel() > 20) {
              if (self.armorvalue == 0) {
                 self.armorvalue = 1;
                 self.armortype = 0.3;
                 self.items += IT_ARMOR1;
              }
              else if (self.armorvalue * self.armortype < (getArmorLevel() - 20) * 5) {
                   self.armorvalue++;
              }
           }
           MyPrevHealthRotTime = time;
        }
}

void() MyPlayerJump =
{
}

void(string monster) MyKilledMonster =
{
        local float value = 1;
        if (monster == "fish") {
           value = 1;
        } else if (monster == "dog") {
           value = 1;
        } else if (monster == "soldier") {
           value = 3;
        } else if (monster == "ogre") {
           value = 4;
        } else if (monster == "knight") {
           value = 3;
        } else if (monster == "enforcer") {
           value = 4;
        } else if (monster == "wizard") {
           value = 4;
        } else if (monster == "zombie") {
           value = 4;
        } else if (monster == "demon") {
           value = 6;
        } else if (monster == "tarbaby") {
           value = 7;
        } else if (monster == "hknight") {
           value = 6;
        } else if (monster == "shambler") {
           value = 10;
        } else if (monster == "shalrath") {
           value = 10;
        } else if (monster == "boss") {
           value = 100;
        } else if (monster == "oldone") {
           value = 10000;
        }
           
        parm10 += value;
}

float() MyGotoNextMap =
{
        if (shuffledLevels()) {
          local float shuffledIndex = getShuffledIndex();

          if (shuffledIndex >= array_size() - 1) {
            changelevel("end");
          } else {
            addLevelsToArray();
            array_shuffle(getShuffledRandom());
            changelevel(array_get(shuffledIndex));

            shuffledIndex++;
            setShuffledIndex(shuffledIndex);
          }
          return TRUE;
        }
        return FALSE;
}