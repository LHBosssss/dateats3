INSTALL_TARGET_PROCESSES = SpringBoard
THEOS_DEVICE_IP = 192.168.1.8
ARCHS = arm64e
DEBUG = 0
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = DateAtS3

DateAtS3_FILES = Tweak.xm
DateAtS3_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/aggregate.mk
