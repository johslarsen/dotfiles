:silent %s/#HEADER#/\=RPath('%:t:r').".hpp"/g
:silent %s/#LOGID#/\=substitute(RPath("%:r"), "\/", ".", "g")/g
:silent %s/#NAMESPACE#\n/\=NamespaceUsing(RPath("%:h"))/g
#include <log4cxx/logger.h>
#include "#HEADER#"

#NAMESPACE#
static auto logger = log4cxx::Logger::getLogger("#LOGID#");

#CURSOR#
