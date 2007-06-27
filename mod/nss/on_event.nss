#include "inc_nwnx_events"
#include "inc_amask"
#include "inc_target"

void EventUseItem(object oPC, object oItem, object oTarget, location lTarget);

void main() {
    int nEventType = GetEventType();
	
	object oPC = OBJECT_SELF;
	object oItem = GetEventItem();
	object oTarget = GetActionTarget();
	vector vTarget = GetEventPosition();
	location lTarget = Location(GetArea(oPC), vTarget, GetFacing(oPC));
    
	// WriteTimestampedLogEntry("NWNX Event fired: "+IntToString(nEventType)+", '"+GetName(OBJECT_SELF)+"'");
/*
    switch(nEventType) {
        case EVENT_PICKPOCKET:
            oPC = OBJECT_SELF;
            oTarget = GetActionTarget();
            WriteTimestampedLogEntry(GetName(oPC)+" tried to steal from "+GetName(oTarget));
            FloatingTextStringOnCreature("You're trying to steal from "+GetName(oTarget), oPC, FALSE);
            break;

        case EVENT_ATTACK:
            oPC = OBJECT_SELF;
            oTarget = GetActionTarget();
            WriteTimestampedLogEntry(GetName(oPC)+" attacked "+GetName(oTarget));
            FloatingTextStringOnCreature("Attacking "+GetName(oTarget), oPC, FALSE);
            break;

        case EVENT_USE_ITEM:
            oPC = OBJECT_SELF;
            oTarget = GetActionTarget();
            oItem = GetEventItem();
            vector vTarget = GetEventPosition();
            WriteTimestampedLogEntry(GetName(oPC)+" used item '"+GetName(oItem)+"' on "+GetName(oTarget));
            FloatingTextStringOnCreature("Using item '"+GetName(oItem)+"' on "+GetName(oTarget), oPC, FALSE);
            SendMessageToPC(oPC, "Location: "+FloatToString(vTarget.x)+"/"+FloatToString(vTarget.y)+"/"+FloatToString(vTarget.z));
            if(d2()==1) {
                BypassEvent();
                WriteTimestampedLogEntry("The action was cancelled");
                FloatingTextStringOnCreature("The action was cancelled", oPC, FALSE);
            }
            break;
    }*/

	switch (nEventType) {
		case EVENT_USE_ITEM:
			EventUseItem(oPC, oItem, oTarget, lTarget);
			break;
	}
}


void EventUseItem(object oPC, object oItem, object oTarget, location lTarget) {
	
	string sTag = GetTag(oItem);

	if ("choose_target" == sTag) {
		if ( !amask(oPC, AMASK_GM) &&
			!amask(oPC, AMASK_FORCETALK) &&
			!amask(oPC, AMASK_GLOBAL_FORCETALK)
		) {
			SendMessageToPC(oPC, "Ich mag dich nicht.  PAFF!");
			DestroyObject(oItem);
			return;
		}

		int nSlot = TARGET_DEFAULT_SLOT;
		if ( GetName(oItem) == "Zielwahl: 1" )
			nSlot = 1;
		if ( GetName(oItem) == "Zielwahl: 2" )
			nSlot = 2;
		if ( GetName(oItem) == "Zielwahl: 3" )
			nSlot = 3;
		if ( GetName(oItem) == "Zielwahl: 4" )
			nSlot = 4;
		if ( GetName(oItem) == "Zielwahl: 5" )
			nSlot = 5;
		if ( GetName(oItem) == "Zielwahl: 6" )
			nSlot = 6;
		if ( GetName(oItem) == "Zielwahl: 7" )
			nSlot = 7;
		if ( GetName(oItem) == "Zielwahl: 8" )
			nSlot = 8;
		if ( GetName(oItem) == "Zielwahl: 9" )
			nSlot = 9;
		if ( GetName(oItem) == "Zielwahl: 10" )
			nSlot = 10;

		if ( GetIsObjectValid(oTarget) ) {
			SetTarget(oTarget, nSlot, oPC);
		} else {
			SetTargetLocation(lTarget, nSlot, oPC);
		}

		BypassEvent();
	}

	if ("move_target_1" == sTag) {
		ExecuteScript("ii_move_target_1");
	}
}
