ifeq ($(WORKSPACE_ROOT),)
	WORKSPACE_ROOT=.
endif

out/%.cpp: outdir $(WORKSPACE_ROOT)/%.cpp
	g++ -std=c++11 -pthread -g $(WORKSPACE_ROOT)/$*.cpp -o $(WORKSPACE_ROOT)/out/$*.cpp

out/%.rs: outdir $(WORKSPACE_ROOT)/%.rs
	rustc -g $(WORKSPACE_ROOT)/$*.rs -Zorbit -o $(WORKSPACE_ROOT)/out/$*.rs

outdir:
	mkdir -p $(WORKSPACE_ROOT)/out/