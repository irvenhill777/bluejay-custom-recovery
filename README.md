# Bluejay custom recovery bring-up

Experimental build configuration and validation notes for the Google Pixel 6a (`bluejay`). The intended UI palette is red and black; credit `luhhcarrl2x` in derivative UI/build work.

> **Status: not yet Android 16-ready or device-validated.** This repository currently documents the target and required checks; it does not claim that a recovery image boots, supports touch, decrypts data, or mounts USB storage. Do not flash an image from this project until the validation checklist passes on a test device.

## Target

- Device: Google Pixel 6a
- Codename: `bluejay`
- Intended platform: Android 16
- Recovery UI: red and black
- Credits: `luhhcarrl2x`, upstream recovery and device-tree contributors

## Current source limitations

The currently referenced device tree is `irvenhill777/android_device_google_bluejay` on branch `bluejay_beta-user-UpsideDownCake-UPP2.230217.004-9663077-release-keys`. Its branch name indicates an Android 14-era base. Although its `BoardConfig.mk` sets `PLATFORM_VERSION := 16.1.0`, that value alone does not establish Android 16 compatibility. The tree also uses a prebuilt kernel and needs to be validated against the exact recovery source, vendor blobs, kernel, and boot image format.

The referenced `Tomatcree01/android_manifest_google_bluejay` branch `twrp-13` is an Android 13-era manifest. The available Custom Recovery Builder TWRP workflow offers `twrp-12.1`; neither is an Android 16 source baseline. Do not treat either as an Android 16 build configuration.

## Storage expectations

The Pixel 6a has no built-in microSD slot. “SD card” access can only mean a card connected through a compatible USB-C OTG adapter/card reader. USB OTG mounting must be separately tested; an `auto vfat` entry in `recovery.fstab` is not proof that the kernel, USB host mode, filesystem support, and recovery UI can use the device.

## Required validation before calling this working

- [ ] Select and pin an Android 16-compatible recovery manifest/branch and matching device tree, kernel, and vendor blobs.
- [ ] Confirm the boot/vendor_boot/recovery image target from the device's actual partition layout and board configuration; do not guess a flash target.
- [ ] Build successfully and record source commit IDs, build logs, output image hash, and image size.
- [ ] Boot the image using a device-appropriate, non-destructive test procedure before considering installation.
- [ ] Confirm touchscreen input is detected and all recovery controls are usable, including after screen blank/unblank.
- [ ] Confirm USB-C OTG host detection with a known-good adapter and USB storage device; test mounting, listing, reading, and safe unmounting.
- [ ] If SD-card-reader support is required, test a compatible USB-C reader and card; do not imply native microSD support.
- [ ] Verify data partition behavior and encryption/decryption separately; a successful build or storage mount does not prove decryption.
- [ ] Record tested device/build details and known limitations before publishing any image.

## Links

- Device tree: <https://github.com/irvenhill777/android_device_google_bluejay>
- Recovery builder: <https://github.com/irvenhill777/Custom-Recovery-Builder>
- Bluejay manifest: <https://github.com/Tomatcree01/android_manifest_google_bluejay>
- Recovery source branch: <https://github.com/irvenhill777/TWRP_OFOX_PBRP_SHRP_Recovery/tree/pixel6a-shrp>

## Credits

- `luhhcarrl2x`
- Team Win Recovery Project, OrangeFox, PitchBlack Recovery Project, SHRP, and all upstream device-tree and kernel contributors. Credit each upstream project according to its license and contribution terms.
