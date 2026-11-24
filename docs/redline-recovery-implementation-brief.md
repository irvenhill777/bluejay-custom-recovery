# Bluejay Redline Recovery — implementation brief

## Goal

Build a Pixel 6a (`bluejay`) custom recovery with a distinctive red-and-black interface, using one recovery framework and selectively porting compatible features or design ideas from OrangeFox, PitchBlack Recovery Project (PBRP), RedWolf, and SHRP. This is a plan, not a claim that the recovery currently builds or works on hardware.

## Integration approach

These projects are separate recovery distributions, not plug-in modules. Do not copy all four trees together and expect them to build: their recovery forks, UI/resource changes, build assumptions, and licenses may conflict. The recommended architecture is one TWRP-derived framework as the base, with only individually reviewed and compatible features ported from the other projects. This is an architectural recommendation, not approval of any source revision. Preserve upstream notices and license terms; prefer supported configuration or narrowly scoped patches over maintaining a divergent fork.

The experimental candidate is the [TWRP-Test `twrp-16.0` manifest](https://github.com/TWRP-Test/platform_manifest_twrp_aosp/tree/twrp-16.0) with the Evolution X Bluejay `bka` device/vendor sources and the LineageOS GS-6.1 `lineage-23.2` kernel dependencies. A minimal TWRP product overlay, a GUI2 Labs patch against pinned recovery commit `a93a12ec107265ab9c3c7fe3e4f96c8740a01337`, and a manual GitHub Actions workflow are present. This is not a validated source set: the TWRP manifest is a community fork, the Evolution tree is ROM-oriented, and the kernel integration has not been tested with the recovery base.

The earlier `irvenhill777/android_device_google_bluejay` `twrp-android16` branch is not used as-is because its product metadata is stale and its board configuration has a `2099-12-31` security-patch override. The older linked Bluejay manifest is Android 13-era.

The validation workflow performs free source-level checks on a GitHub-hosted runner. Building `vendor_boot.img` is in a separate manual-only workflow whose `build_image` input defaults to `true`; dispatching it uses an ephemeral RunsOn AWS runner with 16 vCPU, 64 GB RAM, and a 600 GB volume, then checks for at least 500 GB free disk. RunsOn supports personal GitHub accounts, but requires its GitHub App and AWS stack to be set up and incurs AWS charges; review [its quickstart](https://runs-on.com/quickstart/) and [pricing](https://runs-on.com/pricing/) before dispatching.

## Functional specification

### Redline interface

- Use a near-black base, red accents, and readable white/gray text.
- Use large touch targets, clear labels, consistent navigation, and visible device/build identity.
- Distinguish warnings and success states using labels/icons as well as color.
- Make destructive actions visually distinct and require explicit confirmation.
- Keep theme resources separate from partition, mount, install, and security logic.

### Selective feature integration

- Consider features from OrangeFox, PBRP, RedWolf, and SHRP individually. Before porting, record the upstream source/revision, license, dependencies, and test evidence.
- Prefer compatible UI, usability, and recovery utilities over importing another project's full framework.
- Core recovery expectations include package installation, ADB sideload, backup/restore, wipe, mount controls, logs, and reboot, subject to the selected base and device validation.
- Do not advertise a feature as supported solely because a menu entry or configuration exists.

### Advanced tools and options

Organize advanced actions into a separate **Tools** screen so the main dashboard stays clear. Show an option only when the selected recovery base and device configuration support it; otherwise show a short unavailable reason rather than a nonfunctional control.

- **Device information (read-only):** model/codename, recovery build identity, active slot, partition and mount summary, and storage capacity. Do not expose slot switching as a routine shortcut.
- **Install and verification:** local package install and ADB sideload; show package name and available integrity/signature verification results before installation. Never imply verification succeeded when the base cannot verify it.
- **File browser:** browse internal or mounted external storage and copy files where supported. Require explicit confirmation before deletion or overwrite.
- **Storage manager:** inspect USB-C OTG detection, list mount state and capacity, mount/unmount supported removable media, and offer safe eject. Clearly label external SD-card access as USB-C reader support.
- **Backup and restore:** expose only partitions supported by the selected base; show the exact selection and destination before backup/restore. Do not promise encrypted-data backup or decryption without device testing.
- **Diagnostics:** view recovery logs and device status; optionally export a diagnostic bundle to a user-selected destination. Warn that logs may contain personal/device identifiers and require confirmation before export.
- **ADB controls:** show connection state and provide supported sideload/ADB controls. Clearly indicate when a host connection is unavailable; do not silently enable extra interfaces.
- **Display and accessibility:** brightness, screen timeout, supported rotation, text sizing, theme, and a touch-input test. These controls must not change recovery/device security behavior.
- **Reboot tools:** reboot to system, recovery, or bootloader when supported, with a confirmation and a concise explanation of the destination.

### Optional root management

Offer a separate, opt-in **Root** screen only after rooting is validated for the exact Bluejay Android build and recovery image. Do not bundle root ZIPs or manager APKs, auto-download them, or select a package on the user's behalf.

- **Install root ZIP:** let the user choose a local package from accessible storage, USB-C OTG, or ADB sideload. Show its filename, available version/device metadata, source/provenance when known, and any available integrity/signature-check results. Treat ZIP contents as privileged code; require explicit confirmation and warn that an incompatible package may modify boot-related partitions, prevent Android from booting, or affect updates and data. A file extension or successful checksum alone does not establish safety or compatibility.
- **Root manager APK:** let the user select an APK separately and display available package/version/signing-certificate details. Prefer staging it for installation after Android boots. Install it from recovery only if the chosen framework provides a supported, tested APK installation path; never silently place it in a privileged system location or bypass Android package-signature checks.
- Support cancellation and clear failure reporting. Keep root actions separate from Rescue; a root package is not a firmware restore or soft-brick repair.
- State that any required bootloader-unlock process is separate, may erase user data, and is not performed or bypassed by recovery. Do not offer bootloader unlocking, anti-rollback changes, unrestricted partition writes, or firmware restoration through this screen.

A privileged shell is excluded from the user-facing tools menu until its access model and risks can be specified and validated.

### Experimental options (Labs)

Keep prototypes in a separate **Labs** screen, disabled by default and visibly labeled **EXPERIMENTAL — NOT VALIDATED**. Opting in must be explicit per feature; it must not silently enable other Labs features or persist after a recovery restart. Every entry must state its prerequisites, known risks, whether it can write data, and how to cancel or return to the stable menu.

Potential experiments, subject to framework support and review:

- **OTG diagnostics:** read-only USB host/device and filesystem detection details; do not auto-mount or write to newly detected media.
- **Dynamic-partition viewer:** visualize logical partition/group sizes and free space without exposing write or resize actions.
- **Package preflight:** display package metadata and compatibility clues before install; clearly distinguish advisory checks from cryptographic verification.
- **Backup verification:** calculate and compare available checksums for completed backup files; do not claim a restore is possible just because a checksum passes.
- **Touch and display diagnostics:** input-point visualization, supported rotation preview, and theme/layout preview without changing partition or mount settings.
- **Expanded diagnostic bundle:** preview the files to be exported, redact supported identifiers where possible, and require confirmation because logs may contain sensitive information.
- **Recovery compatibility report:** summarize detected device/build properties and unsupported capabilities without changing device state.

These are proposal candidates, not promised features. Do not put an experiment in a release build until its owner, source revision, licensing, failure behavior, and device test results are recorded. Experiments involving firmware installation, boot/slot changes, security-policy changes, partition writes, filesystem repair, or unexplained data loss are excluded.

The current Labs patch is only a first, unbuilt integration: it reports visible USB devices and mapper nodes read-only, samples touch coordinates, reads selected build properties, and links to the existing installer/log-export screens. It does not implement a standalone backup checksum scan, logical-group free-space report, diagnostic preview/redaction, or a full touch-point visualization. Those entries state their limitations; do not describe them as complete.

### External storage

- The Pixel 6a has no internal microSD slot. “SD card” support means a card connected through a compatible USB-C OTG adapter/card reader.
- Expose removable USB storage only when host detection succeeds. Support safe unmount/eject and do not treat the data partition or an arbitrary USB device as an SD card.
- Validate detection, mount, directory listing, read, and safe unmount using known-good adapters and media. Test filesystem support and encryption behavior separately.
- A generic `auto vfat` fstab entry is not proof of working OTG support.

### Rescue option

- Provide a clearly labeled Rescue area for ADB sideload, recovery logs, and supported reboot choices.
- Add a separate, destructive **Restore Stock Firmware** flow for official Google Pixel 6a firmware only, subject to all gates below. Keep it visually distinct from routine rescue tools.
- Before enabling restore, verify that the exact official package and its install method are supported from this recovery. Google factory-image archives may require the bootloader/fastboot path rather than recovery installation; do not unpack or run factory scripts from recovery as a shortcut. If recovery installation is unsupported, leave the action unavailable and provide a guided handoff to Google's official restore process.
- Require exact `bluejay` device identity, trusted Google package provenance, available integrity/signature verification, supported build/partition layout, and anti-rollback compatibility. Reject mismatches and unsupported downgrades; never infer a partition target from a filename.
- Show the exact package/build and a plain-language data-loss/bootability warning before a separate, affirmative confirmation. Do not start on selection alone. Provide cancellation and report failures without claiming a successful restore.
- This option cannot repair a device that cannot boot into recovery. Do not describe it as a guaranteed soft-brick fix. Any supported in-recovery restore path must be tested on a dedicated test device before release.

## Build and release gates

1. Select one maintained Android 16-compatible framework and pin its manifest, device tree, kernel, and required vendor inputs to reviewed commits.
2. Verify licensing and provenance for each proposed feature port and retain required notices.
3. Confirm the Pixel 6a image format and target partition from verified device configuration and upstream documentation; never infer a flash target from an output filename.
4. Build on a suitably provisioned, controlled runner. Retain source revisions, logs, image size, and SHA-256 with each build.
5. Test boot without installing the image, then validate display, touch, screen blank/unblank, ADB, sideload, reboot paths, OTG storage, and data behavior on the target device.
6. Exercise each advanced action on-device, including unavailable-feature states, cancellation paths, confirmation prompts, and safe handling of diagnostic exports. If root support is enabled, test compatible and rejected packages, cancellation, failure reporting, and manager APK staging/installation. If stock restore is enabled, test package/device/build rejection, confirmation and cancellation, documented data-loss behavior, and recovery after an interrupted or failed restore.
7. Publish only the exact tested image with known limitations and test results. A build artifact alone is not hardware validation.

## Current status

No recovery image has been built or hardware-validated as part of this repository. The Labs UI patch has not been built or device-tested, and the listed limitations remain. Root, rescue, and stock-restore features are not implemented. See [the readiness record](bluejay-android16-readiness.md) before treating any build as usable.
