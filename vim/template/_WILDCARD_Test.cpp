:silent %s/#CLASS#/\=substitute(substitute(substitute(RPath("%:r"), "^test\/", "", "g"), "+", "", "g"), "\/", "_", "g")/g
:silent %s/#LOGID#/\=substitute(RPath("%:r"), "\/", ".", "g")/g
:silent %s/#HEADER#/\=RPath("%:t:r").".hpp"/g
:silent %s/#SRCHEADER#/\=substitute(RPath("%:r"), "^test\/\\(.*\\)Test$", "\\1", "g").".hpp"/g
:silent %s/#SRCNAMESPACE#/\=NamespaceUsing(substitute(RPath("%:h"), "^test\/", "", "g"))/g
#include <#SRCHEADER#>
#include "#HEADER#"

MEOS_SET_TEST_PATH;

#SRCNAMESPACE#
static auto logger = log4cxx::Logger::getLogger("#LOGID#");

#CLASS#::#CLASS#()
{
}

#CLASS#::~#CLASS#()
{
}

TEST_F(#CLASS#, #CURSOR#)
{
}
