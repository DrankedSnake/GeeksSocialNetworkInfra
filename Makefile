pull_changes:
	echo "Syncronizing infra repo..."
	git pull
	echo "Infra repo syncronized"
	cd ../GeeksSocialNetworkUI
	echo "Syncronizing ui repo..."
	git pull
	echo "UI repo syncronized"
	cd ../social-network
	echo "Syncronizing rest api repo..."
	git pull
	echo "Rest api repo syncronized"

deploy:
	docker compose up --build