TARGET := iphone:clang:latest:15.0
ARCHS = arm64
INSTALL_TARGET_PROCESSES = SpaceflightSimulator

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = iGameGodBypass
iGameGodBypass_FILES = tweak.xm
iGameGodBypass_FRAMEWORKS = Foundation

include $(THEOS_MAKE_PATH)/tweak.mk
