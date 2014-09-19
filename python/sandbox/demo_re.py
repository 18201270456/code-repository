# -*- coding: utf-8 -*-

import re


p = re.compile("i\d", re.IGNORECASE)



m = p.match("i12abci3aiiacdd")
if m:
    print m.group()
    print m.start()
    print m.end()
    print m.span()
else:
    print "no match"


a = p.findall("i12abci3aiiaI0cdd")
print a









