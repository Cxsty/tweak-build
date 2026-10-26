TARGET := iphone:clang:latest:15.0
ARCHS = arm64
INSTALL_TARGET_PROCESSES = SpaceflightSimulator

include $(THEOS)/makefiles/common.mk

LIBRARY_NAME = iGameGodBypass
iGameGodBypass_FILES = tweak.xm
iGameGodBypass_FRAMEWORKS = Foundation
iGameGodBypass_INSTALL_PATH = /usr/lib

include $(THEOS_MAKE_PATH)/library.mk