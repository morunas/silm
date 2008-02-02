#ifndef INLINE_H
#define INLINE_H

#define MODULE GetModule()

#define GetMinutesPerHour() MINUTES_PER_HOUR

#define GetPCName(o) (GetPCPlayerName(o)==""?GetLocalString(o,"player_name"):GetPCPlayerName(o))

#define StringToBool(s) (s=="true"||s=="yes"||s=="y"||s=="t"||StringToInt(s)!=0)

#define BoolToString(b)	(b>0?"true":"false")

#define exch(x,y) __EBLOCK(int tmp; tmp=x; x=y; y=tmp;)

#define xch(t,x,y) __EBLOCK(t tmp; tmp=x; x=y; y=tmp;)

#define clamp(n,min,max) (n > max ? max : ( n < min ? min : n ))

#define unsigned(i) i<0?0:i

#define atoi(s) StringToInt(s)
#define itoa(i) IntToString(i)
#define ftoa(f) FloatToString(f)
#define atof(s) StringToFloat(s)
#define ftoi(f) FloatToInt(f)
#define itof(i) IntToFloat(i)

#define otoa(o) "#" + ObjectToString(o) + "{" + GetResRef(o) + "," + GetTag(o) + "," + GetName(o) + "}"


#define strlen(str) GetStringLength(str)
#define substr(str,start,len) GetSubString(str,start,len)
#define strpos(str,find) FindSubString(str,find)
#define strlwr(s) GetStringLowerCase(s)
#define strupper(s) GetStringUpperCase(s)

#define lv_i(o,n) GetLocalInt(o,n)
#define slv_i(o,n,v) SetLocalInt(o,n,v)
#define dlv_i(o,n) DeleteLocalInt(o,n)

#endif


