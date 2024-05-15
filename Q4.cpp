// Included the string class
#include <string>
// Assumed that the class functions were declared in a header file
// Lets the files be handled in the preprocessing stage instead of the compile stage
#include "Game.h"
#include "IOLoginData.h"
#include "Item.h"

// Used the std namespace to remove std:: out of preference
using namespace std;

// Seems to send the target player a new item to their inbox based on itemId
// Removed the class for the addItemToPlayer function because I included it in the header
void addItemToPlayer(const string& recipient, uint16_t itemId) {
    // Replaced the original value to move what was in the if-condition out
    // Checking for the player twice seems redundant when you can load them this way
    Player* player = new Player(nullptr);

    // Removed the class for the loadPlayerByName function because I included the header
    if (!loadPlayerByName(player, recipient)) {
        return;
    }

    // This section seems to try to create a new item using itemId and
    // returns if the itemId doesn't exist
    // Removed the class for the CreateItem function because I included the header
    Item* item = CreateItem(itemId);
    if (!item) {
        return;
    }

    // Adds the item to the players inbox
    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    // Saves the player data if they're offline
    if (player->isOffline()) {
        // Removed the class for the savePlayer function because I included the header
        savePlayer(player);
    }
}