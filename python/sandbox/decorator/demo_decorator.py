# -*- coding: utf-8 -*-



def demo_decorator(*args, **kwargs):
    print ">>>> ", str(demo_decorator), " == start ==", args, kwargs
    
    def handle_func(func):
        print "===> ", str(handle_func), str(func)
        
        def handle_args(*args, **kwargs):
            print "---> ", str(handle_args), " -- start --"
            print "---> ", str(handle_args), str(func)
            func(*args, **kwargs)
            print "---> ", str(handle_args), " --  end  --"
        
        print "===> ", str(handle_func), str(handle_args)
        return handle_args
    
    print ">>>> ", str(demo_decorator), str(handle_func)
    
    print ">>>> ", str(demo_decorator), " ==  end  ==", args, kwargs
    return handle_func





print ""
print "#### define <demo_function> with <demo_decorator> ####"

@demo_decorator("decorator arg 1", "decorator arg 2")
def demo_function(*args, **kwargs):
    print "+++> ", str(demo_function), args, kwargs




print ""
print "#### run <demo_function> with arguments ####"

demo_function("function arg 1", "function arg 2")




print ""
print "#### run <demo_decorator::demo_function> directly ####"

def demo_function2(*args, **kwargs):
    print "+++> ", str(demo_function2), args, kwargs

demo_decorator("decorator arg 1", "decorator arg 2")(demo_function2)("function arg 1", "function arg 2")











