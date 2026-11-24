DEVICE_PATH := device/google/bluejay
VENDOR_PATH := vendor/google/bluejay
DEVICE_CODENAME := bluejay
TARGET_BOOTLOADER_BOARD_NAME := bluejay

include device/google/bluejay/bluejay/BoardConfig.mk
include vendor/twrp/config/BoardConfig.mk

TW_THEME := portrait_hdpi
TW_INPUT_BLACKLIST := "hbtp_vm"
