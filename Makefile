ifeq ($(WORKSPACE_ROOT),)
	WORKSPACE_ROOT=.
endif

out/%.cpp.exe: outdir $(WORKSPACE_ROOT)/%.cpp
	clang++ -std=c++11 -pthread -g $(WORKSPACE_ROOT)/$*.cpp -o $(WORKSPACE_ROOT)/out/$*.cpp.exe

out/%.rs.exe: outdir $(WORKSPACE_ROOT)/%.rs
	rustc -g $(WORKSPACE_ROOT)/$*.rs -Zorbit -o $(WORKSPACE_ROOT)/out/$*.rs.exe

outdir:
	mkdir -p $(WORKSPACE_ROOT)/out/