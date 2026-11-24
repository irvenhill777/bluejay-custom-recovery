# Bluejay custom recovery bring-up

Experimental build configuration and validation notes for the Google Pixel 6a (`bluejay`). The intended UI palette is red and black; credit `luhhcarrl2x` in derivative UI/build work.

> **Status: experimental build scaffold; no image has been built or device-validated.** The workflow targets a TWRP-based `vendor_boot.img` build on a large GitHub Actions runner. It does not claim that an image boots, supports touch, decrypts data, or mounts USB storage. Do not flash an image from this project until the validation checklist passes on a test device.

## Target

- Device: Google Pixel 6a
- Codename: `bluejay`
- Intended platform: Android 16
- Recovery UI: red and black
- Credits: `luhhcarrl2x`, upstream recovery and device-tree contributors

## Current source limitations

The recovery framework is fetched by the manual workflow; this repository keeps the Bluejay product overlay and a small GUI2 Labs patch applied to a pinned TWRP source commit. The current **experimental source candidates** are:

- Recovery framework: [TWRP-Test `twrp-16.0`](https://github.com/TWRP-Test/platform_manifest_twrp_aosp/tree/twrp-16.0), manifest commit `814b553116ceedde197f70389cff9661d81d8337`, based on AOSP `android16.0.0_r1`. This is a community manifest, not an official Team Win release, and its manifest needs compatibility review before use.
- TWRP GUI source: [TWRP-Test `android_bootable_recovery`](https://github.com/TWRP-Test/android_bootable_recovery/tree/a93a12ec107265ab9c3c7fe3e4f96c8740a01337), pinned at `a93a12ec107265ab9c3c7fe3e4f96c8740a01337`; the patch in `device/google/bluejay-twrp/patches/` adds the experimental Labs screen.
- Bluejay device/vendor configuration: [Evolution X `bka`](https://github.com/Evolution-X-Devices/device_google_bluejay/tree/bka), commit `c44661447ee6cabe0fa5980d897021ea56067d63`, with [vendor blobs `bka`](https://github.com/Evolution-X-Devices/vendor_google_bluejay/tree/bka). These are ROM sources, not a ready-made TWRP product tree.
- Kernel dependencies: [LineageOS GS-6.1 manifest `lineage-23.2`](https://github.com/LineageOS/android_kernel_google_gs-6.1_manifest/tree/lineage-23.2), commit `32530252adf8a4cff0f8520fa29616af6695bd1e`, and the Bluejay-specific dependencies declared by the device tree. Compatibility with the TWRP manifest still needs a build and device validation.

The previous `irvenhill777/android_device_google_bluejay` `twrp-android16` branch is not used as-is: its product metadata is stale and its board configuration contains a `2099-12-31` security-patch override. The `Tomatcree01/android_manifest_google_bluejay` `twrp-13` manifest is Android 13-era.

The candidate stack is **not yet a validated build baseline**. The manual workflow attempts a minimal recovery build and exports an unflashed `vendor_boot.img`; it does not install or flash the image. Its Labs screen is experimental and unvalidated: OTG and mapper reports are read-only, package preflight routes to TWRP's existing installer, touch testing samples a tap, and log export uses TWRP's existing controls. Standalone backup checksum scanning, logical-group free-space reporting, and diagnostic redaction/preview are unavailable and are labeled as such. AOSP's published full-source requirements are 400 GB free disk and at least 64 GB RAM. The workflow targets an ephemeral RunsOn AWS runner with 16 vCPU, 64 GB RAM, and a 600 GB gp3 volume; it checks for at least 500 GB free. RunsOn supports personal GitHub accounts, but requires installing its GitHub App and deploying its runner stack in an AWS account. AWS compute and storage charges apply, and no integration or build has been started yet.

## Recommendations

- Set up RunsOn using its [personal-account quickstart](https://runs-on.com/quickstart/), install its GitHub App, and deploy its AWS stack. The workflow requests an ephemeral 16-vCPU/64-GB runner with a 600-GB volume; review AWS billing and RunsOn's [pricing](https://runs-on.com/pricing/) before dispatching.
- Review the TWRP manifest's Android 17-tagged dependency for Android 16 compatibility before relying on a successful build.
- Keep backup verification, diagnostic redaction, and any feature that writes or mounts data unavailable until implemented and tested on a dedicated Bluejay device.

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
