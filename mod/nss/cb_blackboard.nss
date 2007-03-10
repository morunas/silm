#include "_gen"
#include "inc_blackboard"
#include "inc_spelltools"

void main() {
	object oPC = GetLocalObject(OBJECT_SELF, "ConvList_PC");
	object oBlackBoard = GetLocalObject(OBJECT_SELF, "bb_board");

	int nMenuLevel0 = GetMenuLevel(oPC, "bb", 0);
	int nMenuLevel1 = GetMenuLevel(oPC, "bb", 1);
	int nSelected   = GetListSelection(oPC);
	int nBBEntry    = GetLocalInt(oPC, "bb_last_selected");

	object oPaper;
	struct BlackboardEntry r;
	int iSelectedNoteID = GetLocalInt(oPC, "bb_last_selected");

	// in entry?
	switch ( nMenuLevel0 ) {
		case 0:
			if (nSelected > 0) {
				SetMenuLevel(oPC, "bb", 0, nSelected);
			}
			break;

	}
	if (nMenuLevel0 > 0) {
		switch (nMenuLevel1) {
			case 1:
				SendMessageToPC(oPC, "Abnehmen: " + IntToString(nBBEntry));
				break;
			case 2:
				SendMessageToPC(oPC, "Abschreiben: " + IntToString(nBBEntry));
				break;
		}
		/*
		// listen for sub-options

		switch ( iSelection ) {
			case 1: // Remove note
				// fall through

			case 2: // duplicate note
				// XXX: need paper!
				ToPC("Noch nicht eingebaut, sorry.", oPC);
				break;

				oPaper = GetItemPossessedBy(oPC, "c_paper");
				if ( !GetIsObjectValid(oPaper) ) {
					Floaty("Ihr benoetigt ein leeres Pergament, um diese Notiz abzuschreiben.", oPC);
				}
				//oPaper = CreateItemOnObject("c_paper", oPC);
				// Set all the local vars
				SetLocalInt(oPaper, "paper_writecycles", 1);
				SetLocalString(oPaper, "paper_text_0", r.text);
				SetLocalInt(oPaper, "paper_cid_0", r.cid);
				FixPergamentName(oPaper);
				break;

			default:
				SendMessageToPC(oPC, "Unbekannte Option.");
				break;
		}

	} else {
		// Woah. Back to menue.
		SetLocalInt(oPC, "bb_sel", iSelection);
	}*/
	}

	MakeBlackBoardDialog(oPC, oBlackBoard);
}
