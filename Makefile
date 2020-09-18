IMAGE := discourse/ipmi_exporter
VERSION := v1.3.0
TAG := ${VERSION}-$(shell date -u +%Y%m%d.%H%M%S)

.PHONY: default
default: push
	@printf "${IMAGE}:${TAG} ready\n"

.PHONY: push
push: build
	docker push ${IMAGE}:${TAG}

.PHONY: build
build: ipmi_exporter
	git -C ipmi_exporter checkout ${VERSION}
	docker build --no-cache -t ${IMAGE}:${TAG} ipmi_exporter

.PHONY: clean
clean:
	rm -rf ipmi_exporter

ipmi_exporter:
	git clone https://github.com/soundcloud/ipmi_exporter

