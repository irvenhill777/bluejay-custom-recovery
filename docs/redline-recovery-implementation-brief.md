# Bluejay Redline Recovery — implementation brief

## Goal

Build a Pixel 6a (`bluejay`) custom recovery with a distinctive red-and-black interface, combining compatible capabilities and design ideas from TWRP, OrangeFox, SHRP, and PitchBlack Recovery Project (PBRP). This is a plan, not a claim that the recovery currently builds or works on hardware.

## Integration approach

These projects are separate recovery distributions, not plug-in modules. Do not copy all four trees together and expect them to build: their recovery forks, UI/resource changes, build assumptions, and licenses may conflict. Select one Android 16-compatible recovery source as the foundation, then integrate only individually compatible features and UI assets, preserving upstream notices and license terms. Prefer upstream-supported configuration or narrowly scoped patches over maintaining a divergent fork.

Before implementation, pin and verify a matching source baseline for the recovery framework, `bluejay` device tree, kernel, vendor blobs, and firmware. The device-tree branch currently referenced by this repository is Android 13-era and is not evidence of Android 16 compatibility. The recovery source and exact build target also need confirmation.

## Proposed UI direction: Redline

- Near-black backgrounds with high-contrast red accents and readable white/gray text.
- Large touch targets, clear labels, consistent back/navigation controls, and a visible device/build identity.
- Avoid relying on color alone to convey warnings or success; use text and icons as well.
- Keep destructive actions visually distinct and require explicit confirmation.
- Treat themes as presentation only: a theme must not alter partition mappings, mount behavior, or security checks.

## Feature areas to evaluate

- Core recovery: install package, ADB sideload, backup/restore, wipe, mount, logs, reboot.
- Device-specific storage: USB-C OTG detection and safe mount/unmount. Pixel 6a has no internal microSD slot; an SD card requires a compatible USB-C reader.
- Usability: touch calibration/rotation if supported by the base, screen timeout, theme selection, and accessible text sizing.
- Optional upstream features: select only those that build cleanly, are license-compatible, and can be tested independently. Do not advertise decryption or filesystem support until verified on the target device.

## Milestones and release gates

1. **Source audit:** confirm licenses, upstream revisions, Android version support, device tree, kernel, vendor baseline, and image target.
2. **Minimal bring-up:** build the unmodified chosen base for `bluejay`; record exact commits, build command/environment, logs, output size, and SHA-256.
3. **Hardware validation:** test boot, touchscreen, display blank/unblank, ADB, reboot paths, OTG storage, and data decryption separately on a Pixel 6a.
4. **Feature integration:** add one feature at a time; build and retest after each change.
5. **Redline UI:** apply the theme and check readability, touch targets, warnings, and localization on-device.
6. **Release:** publish only after the exact image passes tests; document known limitations and upstream credits. Never infer a partition target or provide a generic flashing instruction.

## Current status

No recovery image has been built or hardware-validated as part of this repository. The Android 16 source baseline and device compatibility remain unresolved. See [the readiness record](bluejay-android16-readiness.md) before treating any build as usable.
