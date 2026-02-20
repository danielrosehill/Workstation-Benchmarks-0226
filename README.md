# Workstation Benchmark Report

**Date:** 20-02-2026
**System:** Intel Core i7-12700F / AMD Radeon RX 7700 XT / 64 GB DDR5 / Ubuntu 25.10

Open-source benchmarks of Daniel Rosehill's desktop workstation, with full system inventory and hardware photos.

## System Summary

This is a mid-tower desktop workstation built around Intel's 12th Gen Alder Lake platform. It combines a 12-core/20-thread hybrid CPU with an AMD RDNA 3 GPU, 64 GB of DDR5 memory, and a 5-drive all-SSD btrfs RAID5 storage pool totalling 4.5 TiB. The system runs Ubuntu 25.10 with KDE Plasma 6 on Wayland, and is used for AI/ML workloads (ROCm), software development, technical communications, and media processing. All four GPU display outputs are occupied across three 1080p monitors and one mini display.

## System Overview

| Component | Details |
|-----------|---------|
| **CPU** | Intel Core i7-12700F — 12 cores / 20 threads (8P + 4E), 4.9 GHz turbo |
| **GPU** | AMD Radeon RX 7700 XT (Sapphire Pulse) — 12 GB GDDR6, amdgpu + Mesa 25.2.8 |
| **RAM** | 64 GB DDR5-4800 (4x16 GB Kingston) |
| **Storage** | 5-drive btrfs RAID5 pool (~4.5 TiB) — see details below |
| **Motherboard** | MSI PRO B760M-A WIFI (LGA 1700, Intel B760) |
| **PSU** | Seasonic Focus GX-850 (850W, 80+ Gold, fully modular) |
| **CPU Cooler** | Thermalright Peerless Assassin 120 SE V3 (250W+ rated) |
| **Case** | Be Quiet Pure Base 500 (mid-tower) |
| **Displays** | 3x 1920x1080 + 1x 1024x600 (all 4 GPU outputs used) |
| **OS** | Ubuntu 25.10 "Questing Quokka", KDE Plasma 6.4.5, Wayland |
| **Kernel** | 6.14.0-15-generic (PREEMPT_DYNAMIC) |
| **Networking** | Realtek RTL8125 2.5GbE (wired) + Intel Wi-Fi 6E |
| **Audio** | PipeWire 1.4.7, FiiO K11 USB DAC |

## Storage & Btrfs RAID

All 5 SSDs are pooled into a single btrfs filesystem spanning the NVMe and 4 SATA drives:

| Device | Model | Capacity | Interface |
|--------|-------|----------|-----------|
| nvme0n1p3 | Crucial CT1000P3SSD8 | 930.0 GB | NVMe PCIe Gen 4 |
| sda | SanDisk SSD PLUS 1000GB | 931.5 GB | SATA 3.2 |
| sdb | Kingston SA400S37 | 894.3 GB | SATA |
| sdc | SanDisk SSD PLUS | 931.5 GB | SATA |
| sdd | SanDisk SSD PLUS | 931.5 GB | SATA |

### RAID Configuration

| Profile | Level | Total | Used |
|---------|-------|-------|------|
| Data | **RAID5** | 2.86 TiB | 2.73 TiB (95.6%) |
| Metadata | **RAID1** | 63.0 GiB | 55.8 GiB (88.5%) |
| System | **RAID1** | 32.0 MiB | 208 KiB |

- **Total capacity:** 4.51 TiB across 5 devices
- **Usable (estimated):** ~798 GiB free
- **Data ratio:** 1.25 (RAID5 — one drive of parity, 80% usable)
- **Metadata ratio:** 2.00 (RAID1 — mirrored across 2 devices)
- **Mount options:** `rw,noatime,compress=zstd:3,ssd,discard=async,space_cache=v2`
- **Health:** Zero I/O errors on all 5 devices

### Subvolume Layout

| Subvolume | Mount Point |
|-----------|-------------|
| @ | / (root) |
| @home | /home |
| @snapshots | /.snapshots |

## Benchmark Results

### CPU & Memory

![CPU and Memory Benchmarks](charts/page-09.png)

- **CPU (single-thread):** 1,399 events/sec (sysbench)
- **CPU (multi-thread, 20T):** 15,677 events/sec (sysbench) — 11.2x scaling
- **CPU (stress-ng):** 27,029 bogo ops/s across all methods
- **Memory (single-thread):** 34,644 MiB/s
- **Memory (multi-thread, 20T):** 128,309 MiB/s

### Disk I/O (fio)

![Disk I/O Benchmarks](charts/page-10.png)

| Test | Bandwidth | IOPS |
|------|-----------|------|
| Sequential Read (1M) | 9,636 MiB/s | 9,635 |
| Sequential Write (1M) | 8,483 MiB/s | 8,483 |
| Random Read (4K) | 12.7 GiB/s | 3,335,000 |
| Random Write (4K) | 5,335 MiB/s | 1,366,000 |

> **Note:** btrfs internally converts O_DIRECT to buffered I/O in many code paths, so even with `direct=1` and `drop_caches`, fio results reflect kernel buffer + zstd compression performance rather than raw disk throughput. See the btrfs scrub rate below for actual disk speed.

### Btrfs RAID5 Filesystem Benchmarks

| Test | Result | Notes |
|------|--------|-------|
| **Scrub throughput (initial)** | 490 MiB/s | Burst rate at 5s |
| **Scrub throughput (sustained)** | 135 MiB/s | Stable rate at 60s, with parity verification |
| **Scrub errors** | 0 | Clean across all 5 devices |
| **Snapshot creation** | 0.680s | Readonly snapshot of root subvolume |
| **Snapshot deletion** | 0.015s | Instant (no-commit) |

The sustained scrub rate of ~135 MiB/s represents real physical read throughput across the RAID5 array with parity computation — this is the true disk performance figure. Snapshot operations are near-instant due to btrfs copy-on-write.

### GPU (OpenGL)

![GPU Benchmarks](charts/page-11.png)

**glmark2 Score: 9,809**

Top scenes: texture 13,361 FPS, build (VBO) 12,409 FPS, shading 12,353 FPS.

### Summary

![Summary](charts/page-12.png)

## Tools Used

| Tool | Version | Purpose |
|------|---------|---------|
| sysbench | 1.0.20 | CPU and memory benchmarks |
| stress-ng | system | CPU stress / bogo-ops |
| fio | 3.39 | Disk I/O benchmarks |
| glmark2-wayland | 2023.01 | OpenGL GPU benchmark |
| btrfs scrub | kernel 6.14 | RAID5 real-disk throughput |
| Typst | 0.13.1 | Report generation (PDF) |

## Files

- **[report.pdf](report.pdf)** — Full benchmark report with photos and raw data appendices
- **[report.typ](report.typ)** — Typst source
- **[pics/](pics/)** — Hardware photos
- **[charts/](charts/)** — Extracted chart pages

## Test Conditions

- Normal desktop workload (KDE Plasma, browser, terminal running)
- Kernel: 6.14.0-15-generic (PREEMPT_DYNAMIC)
- CPU governor: default (schedutil)
- No special tuning applied (no CPU pinning, no governor override, no drop_caches)
