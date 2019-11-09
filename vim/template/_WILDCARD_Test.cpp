:silent %s/#SRCHEADER#/\=RPathSrc("%:r").".hpp"/g
#include <gtest/gtest.h>
#include "#SRCHEADER#"

TEST#SNIPPET_ACTIVE#
