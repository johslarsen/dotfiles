:silent %s/#CLASS#/\=substitute(substitute(substitute(RPath("%:r"), "^\\(test\/\\)\\?\\(.*\\)Test$", "\\2", "g"), "+", "", "g"), "\/", "_", "g")/g
:silent %s/#SRCHEADER#/\=substitute(RPath("%:r"), "^\\(test\/\\)\\?\\(.*\\)Test$", "\\2", "g").".hpp"/g
:silent %s/#SRCNAMESPACE#/\=NamespaceUsing(substitute(RPath("%:h"), "^test\/", "", "g"))/g
#include <gtest/gtest.h>
#include "#SRCHEADER#"

#SRCNAMESPACE#
TEST(#CLASS#, #CURSOR#) {

}
