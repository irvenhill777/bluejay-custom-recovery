# Area51 Recovery — Pixel 6a (`bluejay`)

This directory contains initial Area51 branding assets for the experimental TWRP-based Pixel 6a recovery configuration.

## Identity and target

- Recovery branding: **Area51**
- Device: Google Pixel 6a
- Device codename and unchanged build target: `bluejay` / `twrp_bluejay-eng`
- Requested UI palette: near-black surfaces with lime-green (`#A4FF00`) accents and readable high-contrast text
- Requested icon: the original snake mark in `area51-snake.svg`

The product makefile sets the product brand to Area51 while preserving the `bluejay` device identity and `twrp_bluejay` lunch target. The SVG is a source branding asset; it is not yet packaged into the recovery image. Likewise, the lime palette is a design specification here, not a claim that the upstream TWRP GUI has been patched to use it.

## Build and validation status

This repository is still an experimental build scaffold. No recovery image has been built or boot-tested on a Pixel 6a. The existing build workflow is manual and uses a RunsOn runner that can incur AWS charges. Do not flash an artifact or treat this configuration as device-validated. Follow the build and hardware validation gates in the root README before distributing an image.
