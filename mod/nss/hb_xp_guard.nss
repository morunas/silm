#include "inc_mysql"
#include "inc_cdb"


void AddGMXP(object oPlayer, object oGM, int nAmount);


void AddGMXP(object oPlayer, object oGM, int nAmount) {
	
	int nCID = GetCharacterID(oPlayer);
	if (!nCID)
		return;

	SQLQuery("insert into gm_xp (cid,xp) values( " + IntToString(nCID) + 
		", " + IntToString(nAmount) + " );");

}

void CheckXP(object oPC) {
	int nLastCheckedXP = GetLocalInt(oPC, "xpg_last_xp");
	int nOtherXPGiven = GetLocalInt(oPC, "xpg_other_xp");
	int nCurrentXP = GetXP(oPC);
	if (0 == nLastCheckedXP)
		nLastCheckedXP = nCurrentXP;
	
	nLastCheckedXP += nOtherXPGiven;

	SetLocalInt(oPC, "xpg_last_xp", nCurrentXP);
	SetLocalInt(oPC, "xpg_other_xp", 0);

	if (0 == nCurrentXP - nLastCheckedXP)
		return;



	AddGMXP(oPC, OBJECT_INVALID, nCurrentXP - nLastCheckedXP);
}

void main() {
	object oPC = OBJECT_SELF;
	if (!GetIsDM(oPC) && GetIsPC(oPC)) {
		CheckXP(oPC);
	}
}
