#!/bin/bash
CHARTS_PATH="$1"
REGISTRY="$2"
CHARTS_VERSION="$3"

if [ -z "$CHARTS_PATH" ]; then
	CHARTS_PATH="mcm-3.1.1-amd64/charts"
	echo "No CHARTS_PATH provided! Using ${CHARTS_PATH}"
fi

if [ -z "$REGISTRY" ]; then
	REGISTRY="docker-registry.default.svc.cluster.local:5000"
	echo "No REGISTRY provided! Using ${REGISTRY}"
fi

if [ -z "$CHARTS_VERSION" ]; then
	CHARTS_VERSION="3.1.1"
	echo "No CHARTS_VERSION provided! Using ${CHARTS_VERSION}"
fi

function update_image() {
	IMAGE=$1
	VALUES_PATH=$2
	NAMESPACE="kube-system"

	sed -i '' "s/repository\: ${IMAGE}/repository\: ${REGISTRY}\/${NAMESPACE}\/${IMAGE}/g" ${VALUES_PATH}
}

# Untar PPA

# Untar Charts
tar -xvf ${CHARTS_PATH}/ibm-mcm-prod-${CHARTS_VERSION}.tgz -C ${CHARTS_PATH}
tar -xvf ${CHARTS_PATH}/ibm-mcmk-prod-${CHARTS_VERSION}.tgz -C ${CHARTS_PATH}

# Replace images in values.yaml file in ibm-mcm-prod
_mcm_images="\
mcm-klusterlet \
mcm-controller \
mcm-compliance \
etcd \
mcm-weave-scope \
mcm-mongodb \
mcm-api \
mcm-application \
mcm-ui \
mcm-ui-api \
platform-header \
icp-router \
mcm-openssl"

for i in ${_mcm_images}; do
	update_image $i "${CHARTS_PATH}/ibm-mcm-prod/values.yaml"
done

# Replace images in values.yaml file in ibm-mcmk-prod
_mcmk_images="\
mcm-klusterlet \
mcm-weave-scope \
icp-router \
mcm-compliance"

for i in ${_mcmk_images}; do
	update_image $i "${CHARTS_PATH}/ibm-mcmk-prod/values.yaml"
done

# Package charts
helm package ${CHARTS_PATH}/ibm-mcm-prod
helm package ${CHARTS_PATH}/ibm-mcmk-prod

# Build helm repo
mv ibm-mcm-prod-${CHARTS_VERSION}.tgz charts
mv ibm-mcmk-prod-${CHARTS_VERSION}.tgz charts
helm repo index charts --url=https://raw.github.ibm.com/CASE/mcm-openshift-charts/master/charts/

# Clean up
rm -rf ${CHARTS_PATH}/ibm-mcm-prod
rm -rf ${CHARTS_PATH}/ibm-mcmK-prod