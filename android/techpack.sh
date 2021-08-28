#!/bin/bash
#
# Import or update techpack drivers.
#

read -p "Please input the tag/branch name: " BRANCH
read -p "What do you want to do (import (i)/update (u)): " OPTION
read -p "Whether to use China mirror site (y/N): " SITE

if [ "${SITE}" = 'y' ]; then
    MIRROR="cn"
else
    MIRROR="org"
fi

VERSION="$(grep -m 1 'VERSION =' ./Makefile | awk '{print $3}')"
PATCH_LEVEL="$(grep -m 1 'PATCHLEVEL =' ./Makefile | awk '{print $3}')"

AUDIO_REPO="https://source.codeaurora.${MIRROR}/quic/la/platform/vendor/opensource/audio-kernel.git"
CAMERA_REPO="https://source.codeaurora.${MIRROR}/quic/la/platform/vendor/opensource/camera-kernel.git"
DATA_REPO="https://source.codeaurora.${MIRROR}/quic/la/platform/vendor/qcom-opensource/data-kernel.git"
DISPLAY_REPO="https://source.codeaurora.${MIRROR}/quic/la/platform/vendor/opensource/display-drivers.git"
VIDEO_REPO="https://source.codeaurora.${MIRROR}/quic/la/platform/vendor/opensource/video-driver.git"

case "${OPTION}" in
    import | i)
        git subtree add --prefix=techpack/audio "${AUDIO_REPO}" "${BRANCH}"
        if [ "${VERSION}" -ge 4 ]; then
            if [ "${PATCH_LEVEL}" -eq 19 -o "${VERSION}" -ge 5 ]; then
                git subtree add --prefix=techpack/camera "${CAMERA_REPO}" "${BRANCH}"
                git subtree add --prefix=techpack/data "${DATA_REPO}" "${BRANCH}"
                git subtree add --prefix=techpack/display "${DISPLAY_REPO}" "${BRANCH}"
                git subtree add --prefix=techpack/video "${VIDEO_REPO}" "${BRANCH}"
            fi
        fi
        echo "Done."
        ;;
    update | u)
        git subtree pull --prefix=techpack/audio "${AUDIO_REPO}" "${BRANCH}"
        if [ "${VERSION}" -ge 4 ]; then
            if [ "${PATCH_LEVEL}" -eq 19 -o "${VERSION}" -ge 5 ]; then
                git subtree pull --prefix=techpack/camera "${CAMERA_REPO}" "${BRANCH}"
                git subtree pull --prefix=techpack/data "${DATA_REPO}" "${BRANCH}"
                git subtree pull --prefix=techpack/display "${DISPLAY_REPO}" "${BRANCH}"
                git subtree pull --prefix=techpack/video "${VIDEO_REPO}" "${BRANCH}"
            fi
        fi
        echo "Done."
        ;;
    *)
        echo "Your choose is error!"
        ;;
esac
