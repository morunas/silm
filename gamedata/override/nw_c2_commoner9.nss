///////////////////////////////////////////////////////////////////////////////
//:: Commoner Spawn In
//::
//:: [NW_C2_Commoner9.nss]
//::
//:: Copyright (c) 2000 Bioware Corp.
///////////////////////////////////////////////////////////////////////////////
/*   Stores the commoner's starting location.
*/
///////////////////////////////////////////////////////////////////////////////
//:: Created By: Aidan Scanlan   On: June 26,2001
///////////////////////////////////////////////////////////////////////////////
void main()
{
    SetListening(OBJECT_SELF,TRUE);
    SetListenPattern(OBJECT_SELF,"NW_I_WAS_ATTACKED");
    SetLocalLocation(OBJECT_SELF,"NW_L_GENERICCommonerStoreLocation",
                     GetLocation(OBJECT_SELF));
}
