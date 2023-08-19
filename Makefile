SHELL=/bin/bash

# define standard colors
ifneq (,$(findstring xterm,${TERM}))
	BLACK        := $(shell tput -Txterm setaf 0)
	RED          := $(shell tput -Txterm setaf 1)
	GREEN        := $(shell tput -Txterm setaf 2)
	YELLOW       := $(shell tput -Txterm setaf 3)
	LIGHTPURPLE  := $(shell tput -Txterm setaf 4)
	PURPLE       := $(shell tput -Txterm setaf 5)
	BLUE         := $(shell tput -Txterm setaf 6)
	WHITE        := $(shell tput -Txterm setaf 7)
	RESET := $(shell tput -Txterm sgr0)
else
	BLACK        := ""
	RED          := ""
	GREEN        := ""
	YELLOW       := ""
	LIGHTPURPLE  := ""
	PURPLE       := ""
	BLUE         := ""
	WHITE        := ""
	RESET        := ""
endif

# set target color
TARGET_COLOR := $(BLUE)

POUND = \#

.PHONY: no_targets__ info help build deploy doc
	no_targets__:

.DEFAULT_GOAL := help

colors: ## show all the colors
	@echo "${BLACK}BLACK${RESET}"
	@echo "${RED}RED${RESET}"
	@echo "${GREEN}GREEN${RESET}"
	@echo "${YELLOW}YELLOW${RESET}"
	@echo "${LIGHTPURPLE}LIGHTPURPLE${RESET}"
	@echo "${PURPLE}PURPLE${RESET}"
	@echo "${BLUE}BLUE${RESET}"
	@echo "${WHITE}WHITE${RESET}"

pull_changes:  ## Syncrozie local UI REST and INFRA repos
	@echo "${GREEN}Syncronizing infra repo...${RESET}"
	git pull
	@echo "${GREEN}Infra repo syncronized${RESET}"
	cd ../GeeksSocialNetworkUI
	@echo "${GREEN}Syncronizing ui repo...${RESET}"
	git pull
	@echo "${GREEN}UI repo syncronized${RESET}"
	cd ../GeeksSocialNetworkAPI
	@echo "${GREEN}Syncronizing rest api repo...${RESET}"
	git pull
	@echo "${GREEN}Rest api repo syncronized${RESET}"

push_changes:  ## Syncrozie remote UI REST and INFRA repos
	@echo "${GREEN}Syncronizing infra repo...${RESET}"
	git push
	@echo "${GREEN}Infra repo syncronized${RESET}"
	cd ../GeeksSocialNetworkUI
	@echo "${GREEN}Syncronizing ui repo...${RESET}"
	git push
	@echo "${GREEN}UI repo syncronized${RESET}"
	cd ../GeeksSocialNetworkAPI
	@echo "${GREEN}Syncronizing rest api repo...${RESET}"
	git push
	@echo "${GREEN}Rest api repo syncronized${RESET}"


deploy: ## Deploy UI, REST appliations by means of docker compose
	@echo "${GREEN}Start building services in cluster...{RESET}"
	docker compose up --build

pull_and_deploy:  ## Syncronize repos and deploy UI and REST in containers by means of docker compose
	make pull_changes
	make deploy

help:
	@echo ""
	@echo "    ${BLACK}:: ${RED}Available make scenarious${RESET} ${BLACK}::${RESET}"

	@echo "${BLACK}-----------------------------------------------------------------${RESET}"
	@grep -E '^[a-zA-Z_0-9%-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "${TARGET_COLOR}%-30s${RESET} %s\n", $$1, $$2}'
