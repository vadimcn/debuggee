ifeq ($(WORKSPACE_ROOT),)
	WORKSPACE_ROOT=.
endif

MKDIR = mkdir -p
LINK = ln -s

$(WORKSPACE_ROOT)/out/%.cpp/target.exe: $(WORKSPACE_ROOT)/%.cpp
	@-$(MKDIR) out/$*.cpp
	clang++ -std=c++11 -pthread -g $(WORKSPACE_ROOT)/$*.cpp -O0 -S -emit-llvm -o $(WORKSPACE_ROOT)/out/$*.cpp/$*.ll
	clang++ -std=c++11 -pthread -g $(WORKSPACE_ROOT)/$*.cpp -O0 -S -o $(WORKSPACE_ROOT)/out/$*.cpp/$*.s
	clang++ -std=c++11 -pthread -g $(WORKSPACE_ROOT)/$*.cpp -O0 -o $(WORKSPACE_ROOT)/out/$*.cpp/target.exe

$(WORKSPACE_ROOT)/out/%.rs/target.exe: $(WORKSPACE_ROOT)/%.rs
	@-$(MKDIR) out/$*.rs
	rustc -g $(WORKSPACE_ROOT)/$*.rs --emit=llvm-ir,asm,link --out-dir $(WORKSPACE_ROOT)/out/$*.rs -L $(WORKSPACE_ROOT)
	@-rm $(WORKSPACE_ROOT)/out/$*.rs/target.exe 
	@$(LINK) $(WORKSPACE_ROOT)/out/$*.rs/$* $(WORKSPACE_ROOT)/out/$*.rs/target.exe 
