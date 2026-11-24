# Bluejay Android 16 readiness and test record

This file is a bring-up checklist, not evidence that hardware validation has already passed. Fill in the results only after testing the exact image on a Google Pixel 6a.

## Build provenance

| Item | Value |
| --- | --- |
| Recovery project and source branch | Candidate: TWRP-Test `twrp-16.0` (`814b553116ceedde197f70389cff9661d81d8337`), based on AOSP `android16.0.0_r1`; community manifest, not build-validated |
| Device-tree repository, branch, commit | Candidate: Evolution-X `device_google_bluejay` `bka` (`c44661447ee6cabe0fa5980d897021ea56067d63`); ROM tree, TWRP product not yet defined |
| Kernel repository, branch, commit | Candidate: LineageOS GS-6.1 manifest `lineage-23.2` (`32530252adf8a4cff0f8520fa29616af6695bd1e`); compatibility not validated |
| Vendor blobs / firmware baseline | Candidate: Evolution-X `vendor_google_bluejay` `bka` (`5e2b5c0832c7bfb077332691e0193be6ab8829ae`); hardware baseline not validated |
| Build target and resulting image | Candidate: `vendorbootimage` / `vendor_boot.img`; GS101 board configuration moves recovery resources to `vendor_boot`. Workflow added; not run or output-verified. |
| SHA-256 | Not available |

These sources are research candidates only. The TWRP-Test manifest is a community fork and its manifest includes at least one external project pinned to an Android 17 tag; review that dependency for Android 16 compatibility. Evolution X `bka` is a ROM device tree, so this repository now provides a small TWRP product overlay rather than claiming the upstream tree is already TWRP-ready. Do not present this source combination as buildable until the workflow syncs, builds, and the resulting image boots on a test device.

The previous `irvenhill777/android_device_google_bluejay` `twrp-android16` candidate is not used as-is: its product metadata is stale and its board configuration contains a `2099-12-31` security-patch override. The older `Tomatcree01/android_manifest_google_bluejay` `twrp-13` manifest is Android 13-era.

The manual workflow uses the GitHub larger-runner label `ubuntu-24.04-16core` and checks for at least 500 GB free disk, 64 GB RAM, and 16 CPU cores. The configured runner's availability and capacity have not yet been verified by a workflow run.

## Hardware validation

| Test | Result |
| --- | --- |
| Boots to recovery without modifying partitions | Not tested |
| Touchscreen input and recovery UI | Not tested |
| USB-C OTG host detection | Not tested |
| USB mass-storage mount/read/unmount | Not tested |
| USB card reader with SD card | Not tested (Pixel 6a has no internal microSD slot) |
| Data decryption | Not tested |
| Reboot to Android / bootloader | Not tested |
| Minimal recovery build and image boot | Not built / not tested |
| Rescue actions (sideload, logs, reboot) | Not implemented or tested |
| Official stock firmware restore from recovery | Proposed only; no supported package/install path validated |
| Restore package identity, integrity, and anti-rollback checks | Not implemented or tested |

## Release gate

Do not label or distribute a build as Android 16-compatible or fully working until the source baseline is confirmed and the tests above have been run. Never use a generic flashing command or infer a partition target from the output filename; follow the device- and image-specific instructions from the recovery maintainers.
