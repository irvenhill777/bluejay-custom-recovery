# Bluejay Android 16 readiness and test record

This file is a bring-up checklist, not evidence that hardware validation has already passed. Fill in the results only after testing the exact image on a Google Pixel 6a.

## Build provenance

| Item | Value |
| --- | --- |
| Recovery project and source branch | Not selected / Android 16-compatible source required |
| Device-tree repository, branch, commit | Not Android 16-validated |
| Kernel repository, branch, commit | Not confirmed |
| Vendor blobs / firmware baseline | Not confirmed |
| Build target and resulting image | Not built |
| SHA-256 | Not available |

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

## Release gate

Do not label or distribute a build as Android 16-compatible or fully working until the source baseline is confirmed and the tests above have been run. Never use a generic flashing command or infer a partition target from the output filename; follow the device- and image-specific instructions from the recovery maintainers.
