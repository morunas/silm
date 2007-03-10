#include "_gen"
#include "inc_lists"

struct BlackboardEntry {
	int id;
	int cid;
	int unix_ts;
	string ts;
	string title;
	string text;
	int sigil;
	string sigil_text;
	string sigil_label;
	int explosive_runes;
	int sepia_snake_sigil;
};

const string BB_TABLE = "blackboard_entries";

int GetBlackBoardEntryCount(object oBlackBoard = OBJECT_SELF);

struct BlackboardEntry GetBlackBoardEntry(int nNth, object oBlackBoard = OBJECT_SELF);

void AddBlackBoardEntry(object oBlackBoard, struct BlackboardEntry bbEntry);

void DeleteBlackBoardEntry(object oBlackBoard, int nID);

void MakeBlackBoardDialog(object oPC, object oBlackBoard);
int GetIsBlackBoard(object oBB);

int GetIsBlackBoard(object oBB) {
	return GetLocalString(oBB, "bb_tag") != "";
}

string GetBlackBoardTag(object oBB) {
	return GetLocalString(oBB, "bb_tag");
}

//


int GetBlackBoardEntryCount(object oBlackBoard = OBJECT_SELF) {
	string sTag = GetBlackBoardTag(oBlackBoard);
	SQLQuery("select count(id) from " +
		BB_TABLE + " where blackboard = " + SQLEscape(sTag) + " order by ts desc;");
	SQLFetch();
	return StringToInt(SQLGetData(1));
}


void AddBlackBoardEntry(object oBlackBoard, struct BlackboardEntry bbEntry) {
	string sTag = GetBlackBoardTag(oBlackBoard);
	SQLQuery("insert into " +
		BB_TABLE +
		" (blackboard, cid, title, text) values(" +
		SQLEscape(sTag) +
		", " +
		IntToString(bbEntry.cid) + ", " + SQLEscape(bbEntry.title) + ", " + SQLEscape(bbEntry.text) + ");");
}


void DeleteBlackBoardEntry(object oBlackBoard, int nID) {
	string sTag = GetBlackBoardTag(oBlackBoard);
	SQLQuery("delete from " + BB_TABLE + " where id = " + IntToString(nID) + " limit 1;");
}

struct BlackboardEntry GetBlackBoardEntry(int nNth, object oBlackBoard = OBJECT_SELF) {
	struct BlackboardEntry r;
	string sTag = GetBlackBoardTag(oBlackBoard);

	SQLQuery("select id,ts,unix_timestamp(ts),cid,title,text,sigil,sigil_text,explosive_runes from " +
		BB_TABLE +
		" where blackboard = " + SQLEscape(sTag) + " order by ts desc limit " + IntToString(nNth) + ", 1;");
	if ( SQLFetch() ) {
		string
		sID = SQLGetData(1),
		sTS = SQLGetData(2),
		sUnixTS = SQLGetData(3),
		sCID = SQLGetData(4),
		sTitle = SQLGetData(5),
		sText = SQLGetData(6),
		sSigil = SQLGetData(7),
		sSigilText = SQLGetData(8);

		r.id = StringToInt(sID);
		r.cid = StringToInt(sCID);
		r.unix_ts = StringToInt(sUnixTS);
		r.ts = sTS;
		r.title = sTitle;
		r.text = sText;
		r.sigil = StringToInt(sSigil);
		r.sigil_text = sSigilText;
		r.explosive_runes = StringToInt(SQLGetData(9));

	}
	return r;
}


/* MenuLevel0
 * 0 -> Entries
 *   2 -> Remove this note
 *   3 -> Duplicate this note
 */
void MakeBlackBoardDialog(object oPC, object oBlackBoard) {
	ClearList(oPC, "bb");

	int nMenuLevel0 = GetMenuLevel(oPC, "bb", 0);
	int nSelected   = GetListSelection(oPC);
	int nBBEntry = 0;

	string sHeader = "UNDEF";
	struct BlackboardEntry r;


	// show all notes
	if (nMenuLevel0 == 0) {
		//show the complete listing
		int nCount = GetBlackBoardEntryCount(oBlackBoard);
		int i;
		for ( i = 0; i < nCount; i++ ) {
			r = GetBlackBoardEntry(i + 1, oBlackBoard);
			if ( r.id > 0 ) {
				AddListItem(oPC, "bb", r.title);
				SetListInt(oPC, "bb", r.id);
			} else {
				ToPC("Warning: found invalid database entry, cannot display.", oPC);
			}
		}
		sHeader = "";

		ResetConvList(oPC, oPC, "bb", 50000, "cb_blackboard", sHeader);
	
	// show note and display the entry options
	} else if (nMenuLevel0 > 0) {
		// show the contents of a specific item
		nBBEntry = GetListInt(oPC, "bb", nSelected); //GetLocalInt(oPC, "selected_bb");
		r = GetBlackBoardEntry(nBBEntry, oBlackBoard);

		if ( r.id == 0 ) {
			sHeader = "Diese Notiz wurde bereits entfernt ..";

		} else {
			SetLocalInt(oPC, "bb_last_selected", r.id);

			sHeader = "Angehangen am " + r.ts + ", " + r.text;
			if ( r.sigil ) {
				sHeader += "(Siegel: "  + r.sigil_text + ")";
			}

			AddListItem(oPC, "bb", "Diese Notiz abnehmen");
			SetListInt(oPC, "bb", 1);
			AddListItem(oPC, "bb", "Diese Notiz abschreiben (Schreibzeug und Pergament noetig!)");
			SetListInt(oPC, "bb", 2);
		}

		ResetConvList(oPC, oPC, "bb", 50000, "cb_blackboard", sHeader, "", "", "blackboard_b2m",
			"Zurueck zur Tafel");
	}

}
