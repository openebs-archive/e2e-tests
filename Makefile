# Makefile for building Litmus and its tools
# Reference Guide - https://www.gnu.org/software/make/manual/make.html

#
# Internal variables or constants.
# NOTE - These will be executed when any make target is invoked.
#
IS_DOCKER_INSTALLED = $(shell which docker >> /dev/null 2>&1; echo $$?)

# list of playbooks which should be validated
PLAYBOOKS = $(shell find ./ -iname 'test.yml' -printf '%P\n')

.PHONY: all
all: all-tools ansible-syntax-check

.PHONY: help
help:
	@echo ""
	@echo "Usage:-"
	@echo "\tmake all   -- [default] builds the e2e containers"
	@echo ""

_build_check_docker:
	@if [ $(IS_DOCKER_INSTALLED) -eq 1 ]; \
		then echo "" \
		&& echo "ERROR:\tdocker is not installed. Please install it before build." \
		&& echo "" \
		&& exit 1; \
		fi;

.PHONY: deps
deps: _build_check_docker

.PHONY: all-tools
all-tools: ansible-runner-image

.PHONY: ansible-runner-image
ansible-runner-image:
	@echo "------------------"
	@echo "--> Build ansible-runner image" 
	@echo "------------------"
	sudo docker build . -f tools/ansible-runner/Dockerfile -t openebs/ansible-runner:ci
	REPONAME="openebs" IMGNAME="ansible-runner" IMGTAG="ci" ./hack/push

.PHONY: ansible-syntax-check
ansible-syntax-check:
	@echo "------------------"
	@echo "--> Check playbook syntax"
	@echo "------------------"
	rc_sum=0; \
	for playbook in $(PLAYBOOKS); do \
		sudo docker run --rm -ti --entrypoint=ansible-playbook openebs/ansible-runner:ci \
		$${playbook} --syntax-check -i /etc/ansible/hosts -v; \
		rc_sum=$$((rc_sum+$$?)); \
	done; \
	exit $${rc_sum}
