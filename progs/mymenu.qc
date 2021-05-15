float SVC_CENTERPRINT = 26;
float GOLD_0 = 18;

void(float char) writeChar =
{
        WriteByte (MSG_ONE, char);
}

void(float f, float digits, float add, float padLeft) writeFloat3 =
{
        local float i = 0;
        local float divider = 1;

        if (f == 0) {
           if (!padLeft) {
             writeChar ('0' + add);
           }
           while (i < digits - 1) {
             writeChar (' ');
             i++;
           }
           if (padLeft) {
             writeChar ('0' + add);
           }
           return;
        }

        while (i < digits - 1) {
          divider *= 10;
          i++;
        }

        local float pads = 0;
        local float left = f;
        local float digit;
        i = 0;
        while (i < digits) {
          if (f >= divider) {
            digit = floor (left / divider);
            writeChar ('0' + digit + add);
            left -= digit * divider;
          } else {
            if (padLeft) {
              writeChar(' ');
            } else {
              pads++;
            }
          }
          divider /= 10;
          i++;
        }

        i = 0;
        while (i < pads) {
          writeChar(' ');
          i++;
        }
}
void(float f, float digits, float add) writeFloat2 =
{
        writeFloat3(f, digits, add, TRUE);
}
void(float f, float digits) writeFloat =
{
        writeFloat2(f, digits, 0);
}

void() printMoney =
{
        writeChar ('D');
        writeChar ('e');
        writeChar ('a');
        writeChar ('t');
        writeChar ('h');
        writeChar ('s');
        writeChar (':');
        writeChar (' ');
        writeFloat3 (getDeaths(), 5, 0, FALSE);
        writeChar (' ');
        writeChar ('M' + 128);
        writeChar ('o' + 128);
        writeChar ('n' + 128);
        writeChar ('e' + 128);
        writeChar ('y' + 128);
        writeChar (':' + 128);
        writeChar (' ');
        writeFloat2 (getMoney(), 9, 128);
        writeChar ('\n');
}

void() printMaxHealth =
{
        writeChar ('M');
        writeChar ('a');
        writeChar ('x');
        writeChar (' ');
        writeChar ('h');
        writeChar ('e');
        writeChar ('a');
        writeChar ('l');
        writeChar ('t');
        writeChar ('h');
        writeChar ('!');
        writeChar ('\n');
}
void() printBuyHealth =
{
        writeChar (GOLD_0 + 1);
        writeChar (':');
        writeChar (' ');
        writeChar ('H');
        writeChar ('e');
        writeChar ('a');
        writeChar ('l');
        writeChar ('t');
        writeChar ('h');
        writeChar (' ');
        writeChar (' ');
        writeChar (' ');
        writeChar (' ');
        writeChar ('(');
        writeFloat (getHealthLevel(), 3);
        writeChar (')');
        writeChar (' ');
        writeChar ('c');
        writeChar ('o');
        writeChar ('s');
        writeChar ('t');
        writeChar (':');
        writeChar (' ');
        writeFloat (getHealthArmorAmmoCost(getHealthLevel() + 1), 5);
        writeChar ('\n');
}

void() printMaxArmor =
{
        writeChar ('M');
        writeChar ('a');
        writeChar ('x');
        writeChar (' ');
        writeChar ('a');
        writeChar ('r');
        writeChar ('m');
        writeChar ('o');
        writeChar ('r');
        writeChar ('!');
        writeChar ('\n');
}
void() printBuyArmor =
{
        writeChar (GOLD_0 + 2);
        writeChar (':');
        writeChar (' ');
        writeChar ('A');
        writeChar ('r');
        writeChar ('m');
        writeChar ('o');
        writeChar ('r');
        writeChar (' ');
        writeChar (' ');
        writeChar (' ');
        writeChar (' ');
        writeChar (' ');
        writeChar ('(');
        writeFloat (getArmorLevel(), 3);
        writeChar (')');
        writeChar (' ');
        writeChar ('c');
        writeChar ('o');
        writeChar ('s');
        writeChar ('t');
        writeChar (':');
        writeChar (' ');
        writeFloat (getHealthArmorAmmoCost(getArmorLevel() + 1), 5);
        writeChar ('\n');
}

void() printMaxAmmo =
{
        writeChar ('M');
        writeChar ('a');
        writeChar ('x');
        writeChar (' ');
        writeChar ('a');
        writeChar ('m');
        writeChar ('m');
        writeChar ('o');
        writeChar ('!');
        writeChar ('\n');
}
void() printBuyAmmo =
{
        writeChar (GOLD_0 + 3);
        writeChar (':');
        writeChar (' ');
        writeChar ('A');
        writeChar ('m');
        writeChar ('m');
        writeChar ('o');
        writeChar (' ');
        writeChar (' ');
        writeChar (' ');
        writeChar (' ');
        writeChar (' ');
        writeChar (' ');
        writeChar ('(');
        writeFloat (getAmmoLevel(), 3);
        writeChar (')');
        writeChar (' ');
        writeChar ('c');
        writeChar ('o');
        writeChar ('s');
        writeChar ('t');
        writeChar (':');
        writeChar (' ');
        writeFloat (getHealthArmorAmmoCost(getAmmoLevel() + 1), 5);
        writeChar ('\n');
}

void() printMaxPower =
{
        writeChar ('M');
        writeChar ('a');
        writeChar ('x');
        writeChar (' ');
        writeChar ('p');
        writeChar ('o');
        writeChar ('w');
        writeChar ('e');
        writeChar ('r');
        writeChar ('u');
        writeChar ('p');
        writeChar ('!');
        writeChar ('\n');
}
void() printBuyPower =
{
        writeChar (GOLD_0 + 4);
        writeChar (':');
        writeChar (' ');
        writeChar ('P');
        writeChar ('o');
        writeChar ('w');
        writeChar ('e');
        writeChar ('r');
        writeChar ('u');
        writeChar ('p');
        writeChar (' ');
        writeChar (' ');
        writeChar (' ');
        writeChar ('(');
        writeFloat (getPowerLevel(), 3);
        writeChar (')');
        writeChar (' ');
        writeChar ('c');
        writeChar ('o');
        writeChar ('s');
        writeChar ('t');
        writeChar (':');
        writeChar (' ');
        writeFloat (getHealthArmorAmmoCost(getPowerLevel() + 1), 5);
        writeChar ('\n');
}

void() printMaxWeapons =
{
        writeChar ('M');
        writeChar ('a');
        writeChar ('x');
        writeChar (' ');
        writeChar ('w');
        writeChar ('e');
        writeChar ('a');
        writeChar ('p');
        writeChar ('o');
        writeChar ('n');
        writeChar ('s');
        writeChar ('!');
        writeChar ('\n');
}
void() printBuyWeapons =
{
        writeChar (GOLD_0 + 5);
        writeChar (':');
        writeChar (' ');
        writeChar ('W');
        writeChar ('e');
        writeChar ('a');
        writeChar ('p');
        writeChar ('o');
        writeChar ('n');
        writeChar ('s');
        writeChar (' ');
        writeChar (' ');
        writeChar (' ');
        writeChar ('(');
        writeFloat (getWeaponLevel(), 3);
        writeChar (')');
        writeChar (' ');
        writeChar ('c');
        writeChar ('o');
        writeChar ('s');
        writeChar ('t');
        writeChar (':');
        writeChar (' ');
        writeFloat (getWeaponCost(getWeaponLevel() + 1), 5);
        writeChar ('\n');
}

void() printNewline =
{
        writeChar ('\n');
}

void() printMaxScavenge =
{
        writeChar ('M');
        writeChar ('a');
        writeChar ('x');
        writeChar (' ');
        writeChar ('s');
        writeChar ('c');
        writeChar ('a');
        writeChar ('v');
        writeChar ('e');
        writeChar ('n');
        writeChar ('g');
        writeChar ('e');
        writeChar ('!');
        writeChar ('\n');
}
void() printBuyScavenge =
{
        writeChar (GOLD_0 + 6);
        writeChar (':');
        writeChar (' ');
        writeChar ('S');
        writeChar ('c');
        writeChar ('a');
        writeChar ('v');
        writeChar ('e');
        writeChar ('n');
        writeChar ('g');
        writeChar ('e');
        writeChar (' ');
        writeChar (' ');
        writeChar ('(');
        writeFloat (getScavengeLevel(), 3);
        writeChar (')');
        writeChar (' ');
        writeChar ('c');
        writeChar ('o');
        writeChar ('s');
        writeChar ('t');
        writeChar (':');
        writeChar (' ');
        writeFloat (getHealthArmorAmmoCost(getScavengeLevel() + 1), 5);
        writeChar ('\n');
}

void() printEnd =
{
        writeChar (GOLD_0 + 7);
        writeChar (':');
        writeChar (' ');
        writeChar ('E');
        writeChar ('n');
        writeChar ('d');
        writeChar (' ');
        writeChar ('E');
        writeChar ('1');
        writeChar (16);
        if (isEpCompleted(1)) {
          writeChar ('X' + 128);
        } else {
          writeChar (' ');
        }
        writeChar (17);
        writeChar (' ');
        writeChar ('E');
        writeChar ('2');
        writeChar (16);
        if (isEpCompleted(2)) {
          writeChar ('X' + 128);
        } else {
          writeChar (' ');
        }
        writeChar (17);
        writeChar (' ');
        writeChar ('E');
        writeChar ('3');
        writeChar (16);
        if (isEpCompleted(3)) {
          writeChar ('X' + 128);
        } else {
          writeChar (' ');
        }
        writeChar (17);
        writeChar (' ');
        writeChar ('E');
        writeChar ('4');
        writeChar (16);
        if (isEpCompleted(4)) {
          writeChar ('X' + 128);
        } else {
          writeChar (' ');
        }
        writeChar (17);
        printNewline();        
}

void() printShuffleLevels =
{
        writeChar (GOLD_0 + 8);
        writeChar (':');
        writeChar (' ');
        writeChar ('S');
        writeChar ('h');
        writeChar ('u');
        writeChar ('f');
        writeChar ('f');
        writeChar ('l');
        writeChar ('e');
        writeChar (' ');
        writeChar ('l');
        writeChar ('e');
        writeChar ('v');
        writeChar ('e');
        writeChar ('l');
        writeChar ('s');
        writeChar (' ');
        writeChar (' ');
        writeChar (' ');
        writeChar (' ');
        writeChar (' ');
        writeChar (' ');
        writeChar (' ');
        writeChar (' ');
        writeChar (' ');
        writeChar (' ');
        writeChar (' ');
        writeChar (' ');
        writeChar (' ');
        printNewline();
}

void() printMenu =
{
        local string money;

        money = ftos (getMoney());

        msg_entity = self;
        WriteByte (MSG_ONE, SVC_CENTERPRINT);

        printMoney();

        if (getHealthLevel() == 255) {
           printMaxHealth();
        } else {
           printBuyHealth();
        }

        if (getArmorLevel() == 255) {
           printMaxArmor();
        } else {
           printBuyArmor();
        }

        if (getAmmoLevel() == 255) {
           printMaxAmmo();
        } else {
           printBuyAmmo();
        }

        if (getPowerLevel() == 255) {
           printMaxPower();
        } else {
           printBuyPower();
        }

        if (getWeaponLevel() == 16) {
           printMaxWeapons();
        } else {
           printBuyWeapons();
        }

        if (getScavengeLevel() == 255) {
           printMaxScavenge();
        } else {
           printBuyScavenge();
        }

        printNewline();
        printEnd();
        printShuffleLevels();

        writeChar (0);
}