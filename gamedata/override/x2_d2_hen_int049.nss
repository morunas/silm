//:://////////////////////////////////////////////////
//:: X2_D2_HEN_INT049
//:: Copyright (c) 2003
//:://////////////////////////////////////////////////
/*
    Does the henchman have this interjection set to say.

    RANDOM
 */
//:://////////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: August 2003
//:://////////////////////////////////////////////////

#include "x0_i0_henchman"

int StartingConditional()
{
    if (GetInterjectionSet(GetPCSpeaker()) == -049   )
        return TRUE;
    return FALSE;
}
