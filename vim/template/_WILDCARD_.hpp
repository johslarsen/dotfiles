:silent %s/#CLASS#/\=RPath("%:t:r")/g
:silent %s/#NAMESPACECLASS#/\=NamespaceAndClass()/g
:silent %s/#NAMESPACEDECL#\n/\=NamespaceDeclaration()/g
#pragma once

#NAMESPACEDECL#

class #NAMESPACECLASS#
{
public:
	#CLASS#() = default;
	~#CLASS#() = default;

	#CLASS#(const #CLASS#&) = default;
	#CLASS#& operator=(const #CLASS#&) = default;
protected:
private:
	#CURSOR#
};
