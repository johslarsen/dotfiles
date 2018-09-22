:silent %s/#CLASS#/\=substitute(substitute(substitute(RPath("%:r"), "^test\/", "", "g"), "+", "", "g"), "\/", "_", "g")/g
:silent %s/#GUARD#/\=toupper(substitute(substitute(RPath("%:r"), "\/", "_", "g"), "+", "P", "g"))."_HPP"/g
#ifndef #GUARD#
#define #GUARD#

#include "test/test.hpp"

class #CLASS# : public ::testing::Test
{
public:
protected:
	#CLASS#(void);
	virtual ~#CLASS#(void);
private:
};
#endif /* #GUARD# */
