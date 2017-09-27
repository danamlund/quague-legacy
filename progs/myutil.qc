string array0, array1, array2, array3, array4, array5, array6, array7;
string array8, array9, array10, array11, array12, array13, array14, array15;
string array16, array17, array18, array19, array20, array21, array22, array23;
string array24, array25, array26, array27, array28, array29, array30, array31;
float arraySize;

void() array_clear =
{
        arraySize = 0;
}
float() array_size =
{
        return arraySize;
}
string(float i) array_get =
{
        if (i == 0) return array0;
        else if (i == 1) return array1;
        else if (i == 2) return array2;
        else if (i == 3) return array3;
        else if (i == 4) return array4;
        else if (i == 5) return array5;
        else if (i == 6) return array6;
        else if (i == 7) return array7;
        else if (i == 8) return array8;
        else if (i == 9) return array9;
        else if (i == 10) return array10;
        else if (i == 11) return array11;
        else if (i == 12) return array12;
        else if (i == 13) return array13;
        else if (i == 14) return array14;
        else if (i == 15) return array15;
        else if (i == 16) return array16;
        else if (i == 17) return array17;
        else if (i == 18) return array18;
        else if (i == 19) return array19;
        else if (i == 20) return array20;
        else if (i == 21) return array21;
        else if (i == 22) return array22;
        else if (i == 23) return array23;
        else if (i == 24) return array24;
        else if (i == 25) return array25;
        else if (i == 26) return array26;
        else if (i == 27) return array27;
        else if (i == 28) return array28;
        else if (i == 29) return array29;
        else if (i == 30) return array30;
        else if (i == 31) return array31;
        return "";
}
void (float i, string v) array_set =
{
        if (i == 0) array0 = v;
        else if (i == 1) array1 = v;
        else if (i == 2) array2 = v;
        else if (i == 3) array3 = v;
        else if (i == 4) array4 = v;
        else if (i == 5) array5 = v;
        else if (i == 6) array6 = v;
        else if (i == 7) array7 = v;
        else if (i == 8) array8 = v;
        else if (i == 9) array9 = v;
        else if (i == 10) array10 = v;
        else if (i == 11) array11 = v;
        else if (i == 12) array12 = v;
        else if (i == 13) array13 = v;
        else if (i == 14) array14 = v;
        else if (i == 15) array15 = v;
        else if (i == 16) array16 = v;
        else if (i == 17) array17 = v;
        else if (i == 18) array18 = v;
        else if (i == 19) array19 = v;
        else if (i == 20) array20 = v;
        else if (i == 21) array21 = v;
        else if (i == 22) array22 = v;
        else if (i == 23) array23 = v;
        else if (i == 24) array24 = v;
        else if (i == 25) array25 = v;
        else if (i == 26) array26 = v;
        else if (i == 27) array27 = v;
        else if (i == 28) array28 = v;
        else if (i == 29) array29 = v;
        else if (i == 30) array30 = v;
        else if (i == 31) array31 = v;
}
void(string item) array_add =
{
        array_set(arraySize, item);
        arraySize++;
}

float(float value, float bit) valueGetBit =
{
       local float mask = 1;
       local float i = 0;

       while (i < bit) {
         mask *= 2;
         i++;
       }
       return (value & mask) > 0;
}
float(float value, float bit, float boolean) valueSetBit =
{
       local float mask = 1;
       local float i = 0;

       while (i < bit) {
         mask *= 2;
         i++;
       }

       if (boolean && !(value & mask)) {
          return value + mask;
       } else if (!boolean && (value & mask)) {
          return value - mask;
       }
       return value;
}

float(float a, float b) xor =
{
        return (a | b) & (16777215 - (a & b));
}
float(float in) xorshift16 =
{
        local float out = in;
        out = out & 65535; // cast to 16-bit
        out = xor(out, out * 8192); // out ^= out << 13;
        out = out & 65535; // cast to 16-bit
        out = xor(out, floor(out / 512)); // out ^= out >> 9;
        out = out & 65535; // cast to 16-bit
        out = xor(out, out * 128); // out ^= out << 7;
        out = out & 65535; // cast to 16-bit
        return out;
}
float(float number, float modulo) mod =
{
        return number - floor(number / modulo) * modulo;
}

void(float random_uint16t) array_shuffle =
{
        local float i = array_size() - 1;
        local float rand = random_uint16t;
        while (i >= 1) {
          rand = xorshift16(rand);
          local float j = mod(rand, i);
          local string tmp = array_get(i);
          array_set(i, array_get(j));
          array_set(j, tmp);
          i--;
        }
}


void(string s1) MyPrint1 =
{
        sprint (self, s1);
}
void(string s1, string s2) MyPrint2 =
{
        MyPrint1(s1);
        MyPrint1(s2);
}
void(string s1, string s2, string s3) MyPrint3 =
{
        MyPrint2(s1, s2);
        MyPrint1(s3);
}
void(string s1, string s2, string s3, string s4) MyPrint4 =
{
        MyPrint3(s1, s2, s3);
        MyPrint1(s4);
}
void(string s1, string s2, string s3, string s4, string s5) MyPrint5 =
{
        MyPrint4(s1, s2, s3, s4);
        MyPrint1(s5);
}
void(string s1, string s2, string s3, string s4, string s5, string s6) MyPrint6 =
{
        MyPrint5(s1, s2, s3, s4, s5);
        MyPrint1(s6);
}

float(float high, float mid, float low) encode =
{
        return (high & 255) * 65536 + (mid & 255) * 256 + (low & 255);
}
float(float encoded) getHigh =
{
        return (encoded / 65536) & 255;
}
float(float encoded) getMid =
{
        return (encoded / 256) & 255;
}
float(float encoded) getLow =
{
        return encoded & 255;
}

float(float uint16t, float uint8t) encode16And8 =
{
        return (uint8t & 255) * 65536 + (uint16t & 65535);
}
float(float encoded) getUint16t =
{
        return encoded & 65535;
}
float(float encoded) getUint8t =
{
        return getHigh(encoded);
}
