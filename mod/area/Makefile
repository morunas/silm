include ../Makefile.resource

minimaps:
	@create-minimap.sh $(addprefix -hak $(NWNHOME)/hak/, $(addsuffix .hak, $(shell nwn-dsl ../tools/get_haks.rb ../mod/module.ifo.yml))) *.are

clean-minimaps:
	-@rm *.png
