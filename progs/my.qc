void() printMenu;

float MyTriggeredNewLevel;
float MyShowingMenu;
float MyNextShowMenuTime;
float MyShowingWelcome;
float MyPrevHealthRotTime;
float MyJustKilledMonster;
float MyGotMapDoneMoney;

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
        precache_sound ("items/protect2.wav");
        precache_sound ("items/protect3.wav");
}

float() getMoney =
{
        return parm10;
}

void(float money) setMoney =
{
        parm10 = money;
}

float(float money) addMoney =
{
        parm10 = parm10 + money;
        return money;
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
float() getArmorMultiplier =
{
        return getArmorLevel() / 20;
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

float() getScavengeLevel =
{
        return getLow(parm13);
}
float() getScavenge =
{
        return 1.0 - getScavengeLevel() / 100;
}
void(float level) setScavengeLevel =
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
        local float cost = floor(level * 10 + floor(allLevels / 2));
        if (cost > 300) cost = 300;
        return cost;
}
float(float level) getWeaponCost =
{
        return floor(level * 100);
}

float(float v) getNails =
{
        return v * 2;
}

float(float v) getCells =
{
        return v * 2;
}

void() setStartGear =
{
        self.max_health = getMaxHealth();
        self.health = self.max_health;

        self.items = IT_AXE + IT_SHOTGUN;
        if (getWeaponLevel() >= 1) {
           self.items += IT_NAILGUN;
           self.ammo_nails = getNails(getMaxAmmo());
        }
        if (getWeaponLevel() >= 2) {
           self.items += IT_SUPER_SHOTGUN;
        }
        if (getWeaponLevel() >= 3) {
           self.ammo_rockets = getMaxAmmo();
           self.items += IT_GRENADE_LAUNCHER;
        }
        if (getWeaponLevel() >= 4) {
           self.items += IT_SUPER_NAILGUN;
        }
        if (getWeaponLevel() >= 5) {
           self.items += IT_ROCKET_LAUNCHER;
        }
        if (getWeaponLevel() >= 6) {
           self.ammo_cells = getCells(getMaxAmmo());
           self.items += IT_LIGHTNING;
        }

        self.ammo_shells = getMaxAmmo();

        if (getArmorLevel() > 0) {
          self.armorvalue = getArmorMultiplier() * 100;
          self.armortype = 0.3;
          self.items += IT_ARMOR1;
        }

        self.weapon = IT_SHOTGUN;
        self.currentammo = self.ammo_shells;
        W_SetCurrentAmmo ();
}

void() printProgressionStatus =
{
        local string money = ftos(getMoney());
        local string health = ftos(getHealthLevel());
        local string armor = ftos(getArmorLevel());
        local string ammo = ftos(getAmmoLevel());
        local string weapons = ftos(getWeaponLevel());
        local string powerup = ftos(getPowerLevel());
        local string scavenge = ftos(getScavengeLevel());

        MyPrint6("Money=", money, " Health=", health, " Armor=", armor);
        MyPrint6(" Ammo=", ammo, " Wpn=", weapons, " Power=", powerup);
        MyPrint3(" Scavenge=", scavenge, "\n");

        local string maxHealth = ftos(self.max_health);
        MyPrint3("Max stable health=", maxHealth, "\n");
        if (shuffledLevels()) {
          local string levelNumber = ftos(getShuffledIndex());
          addLevelsToArray();
          local string levelMax = ftos(array_size() + 1); // +1 for end
          MyPrint5("Shuffled level ", levelNumber, "/", levelMax, "\n");
        }
}

float() getScavengedAmmo =
{
        if (getScavengeLevel() <= 20) return 0;
        local float val = random() * (getScavengeLevel() - 20);
        local float decimals = val - floor(val);
        if (random() > decimals) val++;
        return floor(val);
}

void() validateMax =
{
        if (self.health > getMaxHealth()) self.health = getMaxHealth();
        if (self.ammo_shells > getMaxAmmo()) self.ammo_shells = getMaxAmmo();
        if (self.ammo_nails > getNails(getMaxAmmo())) self.ammo_nails = getNails(getMaxAmmo());
        if (self.ammo_rockets > getMaxAmmo()) self.ammo_rockets = getMaxAmmo();
        if (self.ammo_cells > getCells(getMaxAmmo())) self.ammo_cells = getCells(getMaxAmmo());
}

void(float impulse) MyImpulseCommands =
{
        if (MyShowingMenu || MyShowingWelcome) {
           local float cost;
           local string boughtType = "";
           local float boughtLevel = 0;
           cost = 0;
           if (impulse == 1 && getHealthLevel() < 255) {
              cost = getHealthArmorAmmoCost(getHealthLevel() + 1);
              if (getMoney() >= cost) {
                setHealthLevel(getHealthLevel() + 1);
                boughtType = "health";
                boughtLevel = getHealthLevel();
              }
           } else if (impulse == 2 && getArmorLevel() < 255) {
              cost = getHealthArmorAmmoCost(getArmorLevel() + 1);
              if (getMoney() >= cost) {
                setArmorLevel(getArmorLevel() + 1);
                boughtType = "armor";
                boughtLevel = getArmorLevel();
              }
           } else if (impulse == 3 && getAmmoLevel() < 255) {
              cost = getHealthArmorAmmoCost(getAmmoLevel() + 1);
              if (getMoney() >= cost) {
                setAmmoLevel(getAmmoLevel() + 1);
                boughtType = "ammo";
                boughtLevel = getAmmoLevel();
              }
           } else if (impulse == 4 && getPowerLevel() < 255) {
              cost = getHealthArmorAmmoCost(getPowerLevel() + 1);
              if (getMoney() >= cost) {
                setPowerLevel(getPowerLevel() + 1);
                boughtType = "powerup";
                boughtLevel = getPowerLevel();
              }
           } else if (impulse == 5 && getWeaponLevel() < 16) {
              cost = getWeaponCost(getWeaponLevel() + 1);
              if (getMoney() >= cost) {
                setWeaponLevel(getWeaponLevel() + 1);
                boughtType = "weapon";
                boughtLevel = getWeaponLevel();
              }
           } else if (impulse == 6 && getScavengeLevel() < 255) {
              cost = getHealthArmorAmmoCost(getScavengeLevel() + 1);
              if (getMoney() >= cost) {
                setScavengeLevel(getScavengeLevel() + 1);
                boughtType = "scavenge";
                boughtLevel = getScavengeLevel();
              }
           }

           if (cost > 0 && getMoney() >= cost) {
              setMoney(getMoney() - cost);
              setStartGear();
              printMenu();
              MyPrint5("Bought ", boughtType, " ", ftos(boughtLevel), "!\n");
           } else if (cost > 0 && getMoney() < cost) {
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

void() MyNewMap =
{
        MyGotMapDoneMoney = FALSE;
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
             return;
           }

           setStartGear();
           MyShowingMenu = TRUE;
           setShuffledLevels(FALSE);

           setDeaths(getDeaths() + 1);
           setResetMoneyNextLevel(TRUE);
        } else {
           printProgressionStatus();
           if (getScavengeLevel() > 0) {
             MyPrint3("You scavenged ", ftos(getScavengeLevel()*2), " health");
             MyPrint3(", ", ftos(getScavengeLevel()), " shells");
             MyPrint3(", ", ftos(getNails(getScavengeLevel())), " nails");
             MyPrint3(", ", ftos(getScavengeLevel()), " rockets");
             MyPrint3(", ", ftos(getCells(getScavengeLevel())), " cells");
             MyPrint1("\n");
             self.health += getScavengeLevel() * 2;
             self.ammo_shells += getScavengeLevel();
             self.ammo_nails += getNails(getScavengeLevel());
             self.ammo_rockets += getScavengeLevel();
             self.ammo_cells += getCells(getScavengeLevel());
             validateMax();
          }

          if (getPowerLevel() > 20) {
             local float powerTimeStart = floor(5 + (getPowerLevel() - 20)/2);
             self.super_time = 1;
             self.super_damage_finished = time + powerTimeStart;
             self.invincible_time = 1;
             self.invincible_finished = time + powerTimeStart;
             self.items = self.items | IT_QUAD | IT_INVULNERABILITY;
             SUB_UseTargets();
          }
        }
}

void() MyPlayerPostThink =
{
        local string money;
        local float scavenged;

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
          MyNewMap();
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
              MyPrevHealthRotTime = time;
           }
        }


        if (MyJustKilledMonster) {
           MyJustKilledMonster = FALSE;
           if (getArmorLevel() > 20) {
              if (self.armorvalue == 0) {
                 self.armorvalue = 0;
                 self.armortype = 0.3;
                 self.items += IT_ARMOR1;
              }
              if (self.armorvalue < getArmorLevel()) {
                self.armorvalue += floor((getArmorLevel() - 20) / self.armortype);
              }
           }

          if (getScavengeLevel() > 20) {
             local float randomValue = random();
             if (randomValue < 0.25) {
               scavenged = getScavengedAmmo();
               if (scavenged >= 1) {
                 self.ammo_shells += scavenged;
                 MyPrint3("You scavenge ", ftos(scavenged), " shells\n");
               }
             }
             else if (randomValue < 0.5) {
               scavenged = getNails(getScavengedAmmo());
               if (scavenged >= 1) {
                 self.ammo_nails += scavenged;
                 MyPrint3("You scavenge ", ftos(scavenged), " nails\n");
               }
             }
             else if (randomValue < 0.75) {
               scavenged = getScavengedAmmo();
               if (scavenged >= 1) {
                 self.ammo_rockets += scavenged;
                 MyPrint3("You scavenge ", ftos(scavenged), " rockets\n");
               }
             }
             else {
               scavenged = getCells(getScavengedAmmo());
               if (scavenged >= 1) {
                 self.ammo_cells += scavenged;
                 MyPrint3("You scavenge ", ftos(scavenged), " cells\n");
               }
             }
             validateMax();
          }
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
        } else if (monster == "shalrath") {
           value = 10;
        } else if (monster == "shambler") {
           value = 15;
        } else if (monster == "boss") {
           value = 20;
        } else if (monster == "oldone") {
           value = 10000;
        }

        addMoney(value);

        MyJustKilledMonster = TRUE;
}

float() MyGotoNextMap =
{
        local float moneyAdded;
        if (!MyGotMapDoneMoney) {
          MyGotMapDoneMoney = TRUE;
          moneyAdded = addMoney(20);
          MyPrint3("Got ", ftos(moneyAdded), " money for completing map\n");

          if (killed_monsters / total_monsters >= 0.9) {
             moneyAdded = addMoney(20);
             MyPrint3("Got ", ftos(moneyAdded), " money for killing 90 percent of monsters\n");
          }
          local float secretMoney = floor(20 * found_secrets / total_secrets);
          if (secretMoney > 0) {
             moneyAdded = addMoney(secretMoney);
             MyPrint3("Got ", ftos(moneyAdded), " money for finding secrets\n");
          }
        }

        if (shuffledLevels()) {
          local float shuffledIndex = getShuffledIndex();

          addLevelsToArray();
          if (shuffledIndex >= array_size() - 1) {
            changelevel("end");
          } else {
            array_shuffle(getShuffledRandom());
            changelevel(array_get(shuffledIndex));

            shuffledIndex++;
            setShuffledIndex(shuffledIndex);
          }
          return TRUE;
        }
        return FALSE;
}

void() MyW_Attack =
{
        if ((self.weapon == IT_AXE && getWeaponLevel() >= 7) || (self.weapon == IT_LIGHTNING && getWeaponLevel() >= 8)) {
          if (self.super_sound < time) {
            self.super_sound = time + 1;
            sound (self, CHAN_BODY, "items/damage3.wav", 1, ATTN_NORM);
          }
        }
}

float() MyGetAxeDamage =
{
        float dmg = 20;
        if (getWeaponLevel() >= 7) {
           dmg *= 4;
        }
        return dmg;
}

void() MyW_FireLightning =
{

        if (getWeaponLevel() < 8)
          return;
        local float shafts = 2 + getWeaponLevel() - 8;

        local float i, mul;
        local entity tempEntity;
        local vector org;
        org = self.origin + '0 0 16';

        i = 0;
        while (i+1 < shafts) {
          tempEntity = spawn();
          org = self.origin;
          mul = 1 + floor(i/2);
          if ((i % 2) == 0) mul *= -1;
          traceline (org, org + '0 0 16' + v_forward*600 + v_right*50*mul, TRUE, self);
          WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
          WriteByte (MSG_BROADCAST, TE_LIGHTNING2);
          WriteEntity (MSG_BROADCAST, tempEntity);
          WriteCoord (MSG_BROADCAST, org_x);
          WriteCoord (MSG_BROADCAST, org_y);
          WriteCoord (MSG_BROADCAST, org_z);
          WriteCoord (MSG_BROADCAST, trace_endpos_x);
          WriteCoord (MSG_BROADCAST, trace_endpos_y);
          WriteCoord (MSG_BROADCAST, trace_endpos_z);
          LightningDamage (org, trace_endpos + v_forward*4 + v_right*50*mul, self, 30);
          remove(tempEntity);
          i++;
        }
}
