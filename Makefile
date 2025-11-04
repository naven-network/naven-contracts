include .env

deploy-%:
	$(eval CONTRACT := $(subst deploy-,,$@))
	@echo "Deploying $(CONTRACT)..."
	#forge script script/$(CONTRACT).s.sol:$(CONTRACT)Script --private-key ${PRIVATE_KEY} --broadcast --rpc-url ${RPC_URL} --legacy --verify --verifier-url https://api.etherscan.io/v2/api?chainid=999 --etherscan-api-key ${ETHERSCAN_API_KEY}
	forge script script/$(CONTRACT).s.sol:$(CONTRACT)Script --private-key ${PRIVATE_KEY} --broadcast --rpc-url ${RPC_URL} --legacy

invoke-%:
	$(eval TARGET := $(word 2, $(subst -, ,$@)))
	$(eval METHOD := $(word 3, $(subst -, ,$@)))
	@echo "Invoking $(TARGET) script with method $(METHOD)..."
	forge script script/$(TARGET).s.sol:$(TARGET)Script --sig "$(METHOD)()" $(COMMON_ARGS) --private-key ${PRIVATE_KEY} --broadcast --rpc-url ${RPC_URL} --legacy
