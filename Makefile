# https://packages.gitlab.cn/#browse/browse
JIHU_VERSION := "17.2.9"

runtime:
	@PIP_ARGS="$(PIP_ARGS)" ./scripts/runtime.sh

prepare:
	@find ./scripts/src -name 'gitlab-jh*' -exec cp "{}" ./roles/prepare/files \;

deploy:
	@ansible-playbook -i ./inventory/hosts.ini ./deploy.yml -e JIHU_VERSION="$(JIHU_VERSION)"

e2e: 
	@cd ./tests/terraform && terraform init && terraform apply -auto-approve -no-color

download:
	@[ -f ./scripts/src/gitlab-jh_$(JIHU_VERSION)-jh.0_amd64.deb ] || wget https://packages.gitlab.cn/repository/debian-bullseye/pool/g/gitlab-jh/gitlab-jh_$(JIHU_VERSION)-jh.0_amd64.deb -O ./scripts/src/gitlab-jh_$(JIHU_VERSION)-jh.0_amd64.deb
	@[-f ./scripts/src/gitlab-jh-$(JIHU_VERSION)-jh.0.el7.x86_64.rpm ] || wget https://packages.gitlab.cn/repository/el/7/gitlab-jh-$(JIHU_VERSION)-jh.0.el7.x86_64.rpm -O ./scripts/src/gitlab-jh-$(JIHU_VERSION)-jh.0.el7.x86_64.rpm

rsync:
	@rsync -avz -e ssh --exclude "roles/prepare/files/*.deb" --exclude "roles/prepare/files/*.rpm" --exclude "tests/terraform/.terraform" --exclude "scripts/src/*.rpm" --exclude "scripts/src/*.deb" . ubuntu@42.194.179.45:/home/ubuntu/jihuctl
