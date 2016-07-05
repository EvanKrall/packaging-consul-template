VERSION ?= 0.15.0
PACKAGE_PATH = dist/consul-template_$(VERSION)_amd64.deb

itest_%: $(PACKAGE_PATH)
	true

$(PACKAGE_PATH):
	docker rmi blurp; docker build -t blurp --build-arg VERSION="$(VERSION)" .
	docker rm blurp; docker run --name blurp -d blurp
	docker cp blurp:/dist/ ./
	docker rm blurp; docker rmi blurp

bintray.json: bintray.json.in Makefile itest_trusty itest_xenial
	jq 'setpath(["version", "name"]; "$(VERSION)")' $< > $@
