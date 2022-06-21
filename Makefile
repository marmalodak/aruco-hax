VENV      := Aruco_Tracker-venv
ACTIVATE  := ${VENV}/bin/activate
REPO_NAME := Aruco_Tracker
REPO      := https://github.com/marmalodak/${REPO_NAME}.git

# REPO      := https://github.com/njanirudh/${REPO_NAME}.git

all: repo ${ACTIVATE} packages
run: all
	source ${ACTIVATE}
	python3 ${REPO_NAME}/aruco_tracker.py

repo: ${VENV}

${VENV}:
	git clone ${REPO}

venv: ${ACTIVATE}

${ACTIVATE}:
	python3 -m venv --system-site-packages ${VENV}
	source ${ACTIVATE}
	pip3 install --progress-bar --upgrade pip rich icecream

packages: cv2 numpy

cv2: ${ACTIVATE}
	source ${ACTIVATE}
	ifneq ($(python3 -c "import cv2; import cv2.aruco"), 0)
		pip3 install --progress-bar opencv-python opencv-contrib-python
	endif

numpy: ${ACTIVATE}
	source ${ACTIVATE}
	ifneq ($(python3 -c "import numpy"), 0)
		echo Sit back, this might take a while...
		pip3 install --progress-bar numpy
	endif
