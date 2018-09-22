:silent %s/#HEADER#/\=RPath('%:t:r').".hpp"/g
:silent %s/#CLASS#/\=NamespaceAndClass()/g
:silent %s/#LOGID#/\=substitute(RPath("%:r"), "\/", ".", "g")/g

#include "#HEADER#"

log4cxx::LoggerPtr #CLASS#::_logger(log4cxx::Logger::getLogger("#LOGID#"));

#CURSOR#
