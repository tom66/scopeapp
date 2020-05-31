%module armwave

%include "stdint.i"

%rename("%(strip:[armwave_])s") "";
%{
#define SWIG_FILE_WITH_INIT
#include "armwave.h"
%}

%include "armwave.h"
