//::///////////////////////////////////////////////
//:: Check Charisma Low and Int Low
//:: NW_D2_CHRHO_L
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Check if the character has a low charisma and
    low intelligence
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Sept 18, 2001
//:://////////////////////////////////////////////
#include "NW_I0_PLOT"

int StartingConditional()
{
    if (CheckIntelligenceLow())
    {
        return CheckCharismaLow();
    }
    return FALSE;
}

