#!/bin/bash
#
# Import or update qcacld-3.0, qca-wifi-host-cmn and fw-api.
#

read -p "Please input the tag/branch name: " BRANCH
read -p "What do you want to do (import (i)/update (u)): " OPTION
read -p "Whether to use China mirror site (y/N): " SITE

if [ "${SITE}" = 'y' ]; then
    MIRROR="cn"
else
    MIRROR="org"
fi

QCACLD_REPO="https://source.codeaurora.${MIRROR}/quic/la/platform/vendor/qcom-opensource/wlan/qcacld-3.0.git"
QCA_REPO="https://source.codeaurora.${MIRROR}/quic/la/platform/vendor/qcom-opensource/wlan/qca-wifi-host-cmn.git"
FW_REPO="https://source.codeaurora.${MIRROR}/quic/la/platform/vendor/qcom-opensource/wlan/fw-api.git"

case "${OPTION}" in
    import | i)
        git subtree add --prefix=drivers/staging/qcacld-3.0 "${QCACLD_REPO}" "${BRANCH}"
        git subtree add --prefix=drivers/staging/qca-wifi-host-cmn "${QCA_REPO}" "${BRANCH}"
        git subtree add --prefix=drivers/staging/fw-api "${FW_REPO}" "${BRANCH}"
        echo "Done."
        ;;
    update | u)
        git subtree pull --prefix=drivers/staging/qcacld-3.0 "${QCACLD_REPO}" "${BRANCH}"
        git subtree pull --prefix=drivers/staging/qca-wifi-host-cmn "${QCA_REPO}" "${BRANCH}"
        git subtree pull --prefix=drivers/staging/fw-api "${FW_REPO}" "${BRANCH}"
        echo "Done."
        ;;
    *)
        echo "Your choose is error!"
        ;;
esac
