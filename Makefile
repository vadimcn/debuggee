ifeq ($(WORKSPACE_ROOT),)
	WORKSPACE_ROOT=.
endif

MKDIR = mkdir -p
MOVE = mv

$(WORKSPACE_ROOT)/out/%.cpp/target.exe: $(WORKSPACE_ROOT)/%.cpp
	@-$(MKDIR) out/$*.cpp
	clang++ -std=c++11 -pthread -g $(WORKSPACE_ROOT)/$*.cpp -O0 -S -emit-llvm -o $(WORKSPACE_ROOT)/out/$*.cpp/$*.ll
	clang++ -std=c++11 -pthread -g $(WORKSPACE_ROOT)/$*.cpp -O0 -o $(WORKSPACE_ROOT)/out/$*.cpp/target.exe

$(WORKSPACE_ROOT)/out/%.rs/target.exe: $(WORKSPACE_ROOT)/%.rs
	@-$(MKDIR) out/$*.rs
	rustc -g $(WORKSPACE_ROOT)/$*.rs --emit=llvm-ir,asm,link --out-dir $(WORKSPACE_ROOT)/out/$*.rs -Copt-level=0
	$(MOVE) $(WORKSPACE_ROOT)/out/$*.rs/$* $(WORKSPACE_ROOT)/out/$*.rs/target.exe 
