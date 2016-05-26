ifeq ($(WORKSPACE_ROOT),)
	WORKSPACE_ROOT=.
endif

debuggee_cpp: outdir $(WORKSPACE_ROOT)/debuggee.cpp
	g++ -std=c++11 -pthread -g $(WORKSPACE_ROOT)/debuggee.cpp -o $(WORKSPACE_ROOT)/out/debuggee_cpp

debuggee_rs: outdir $(WORKSPACE_ROOT)/debuggee.rs
	rustc -g $(WORKSPACE_ROOT)/debuggee.rs -o $(WORKSPACE_ROOT)/out/debuggee_rs

stepover_cpp: outdir $(WORKSPACE_ROOT)/debuggee.cpp
	g++ -std=c++11 -pthread -g $(WORKSPACE_ROOT)/stepover.cpp -o $(WORKSPACE_ROOT)/out/stepover_cpp

stepover_rs: outdir $(WORKSPACE_ROOT)/debuggee.rs
	rustc -g $(WORKSPACE_ROOT)/stepover.rs -o $(WORKSPACE_ROOT)/out/stepover_rs

outdir:
	mkdir -p $(WORKSPACE_ROOT)/out/