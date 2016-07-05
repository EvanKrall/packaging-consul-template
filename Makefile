VERSION ?= 0.15.0
PACKAGE_PATH = dist/consul-template_$VERSION_amd64.deb

itest_trusty: $(PACKAGE_PATH)
	true

$(PACKAGE_PATH):
	docker rmi blurp; docker build -t blurp .
	docker rm blurp; docker run --name blurp -d blurp
	docker cp blurp:/dist/ ./
	docker rm blurp; docker rmi blurp

bintray.json: bintray.json.in Makefile
	jq 'setpath(["version", "name"]; "$(VERSION)")' $< > $@
