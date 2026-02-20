// Workstation Benchmark Report
// Generated: 20-02-2026

#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1": chart

// --- Palette ---
#let brand-blue    = rgb("#0369a1")
#let brand-blue-dk = rgb("#024e7a")
#let brand-blue-lt = rgb("#0ea5e9")
#let brand-emerald = rgb("#10b981")
#let brand-violet  = rgb("#8b5cf6")
#let brand-slate-9 = rgb("#0f172a")
#let brand-slate-6 = rgb("#475569")
#let brand-slate-5 = rgb("#64748b")
#let brand-bg      = rgb("#f8fafc")
#let brand-bg-blue = rgb("#eff6ff")
#let brand-bg-tint = rgb("#f1f5f9")

#set document(
  title: "Workstation Benchmark Report",
  author: "Daniel Rosehill",
  date: datetime(year: 2026, month: 2, day: 20),
)

#set page(
  paper: "a4",
  margin: (x: 2cm, y: 2.5cm),
  header: context {
    if counter(page).get().first() > 1 [
      #set text(font: "IBM Plex Sans", size: 9pt, fill: brand-slate-5)
      Workstation Benchmark Report
      #h(1fr)
      20-02-2026
      #v(2pt)
      #line(length: 100%, stroke: 1pt + brand-blue)
    ]
  },
  footer: context [
    #set text(font: "IBM Plex Sans", size: 9pt, fill: brand-slate-5)
    #line(length: 100%, stroke: 0.5pt + brand-bg-tint)
    #v(2pt)
    Daniel Rosehill — danielrosehill.com
    #h(1fr)
    Page #counter(page).display() of #counter(page).final().first()
  ],
)

#set text(font: "IBM Plex Sans", size: 10pt, fill: brand-slate-9)
#set heading(numbering: "1.1")
#set par(justify: true)

#show heading.where(level: 1): it => {
  v(0.6em)
  block(
    width: 100%,
    below: 0.8em,
    [
      #set text(size: 17pt, weight: "bold", fill: brand-blue)
      #it.body
      #v(-0.2em)
      #line(length: 100%, stroke: 2.5pt + brand-blue)
    ]
  )
}

#show heading.where(level: 2): it => {
  v(0.4em)
  block(
    below: 0.5em,
    [
      #set text(size: 12pt, weight: "bold", fill: brand-blue-dk)
      #it.body
    ]
  )
}

#show heading.where(level: 3): it => {
  v(0.3em)
  block(
    below: 0.4em,
    [
      #set text(size: 11pt, weight: "bold", fill: brand-slate-6)
      #it.body
    ]
  )
}

// Title page
#v(2cm)
#align(center)[
  #block(
    width: 85%,
    [
      #line(length: 40%, stroke: 2pt + brand-blue-lt)
      #v(0.8cm)
      #text(size: 28pt, weight: "bold", fill: brand-slate-9)[Workstation\ Benchmark Report]
      #v(0.5cm)
      #text(size: 13pt, fill: brand-slate-6)[Daniel Rosehill's Desktop Workstation]
      #v(0.3cm)
      #text(size: 11pt, fill: brand-slate-5)[
        Ubuntu 25.10 · KDE Plasma 6 · Wayland \
        Intel Core i7-12700F · AMD Radeon RX 7700 XT · 64 GB DDR5
      ]
      #v(1.2cm)
      #rect(
        fill: brand-bg-blue,
        radius: 10pt,
        inset: 14pt,
        width: 100%,
        stroke: 0.5pt + brand-blue.lighten(70%),
        [
          #set text(size: 10pt)
          #grid(
            columns: (1fr, 1fr),
            row-gutter: 8pt,
            [*Benchmark Date:*], [20-02-2026],
            [*Local Time:*], [12:43 IST (UTC+2)],
            [*Tools Used:*], [sysbench 1.0.20, fio 3.39, stress-ng, glmark2 2023.01],
            [*Report Format:*], [Generated with Typst],
          )
        ]
      )
    ]
  )
]

#pagebreak()

// Table of Contents
#outline(title: [Table of Contents], indent: 1.5em, depth: 2)

#pagebreak()

// ═══════════════════════════════════════════
= System Inventory
// ═══════════════════════════════════════════

== Platform Overview

#table(
  columns: (auto, 1fr),
  inset: 8pt,
  stroke: 0.5pt + brand-blue.lighten(80%),
  fill: (x, y) => if y == 0 { brand-bg-blue } else if calc.odd(y) { brand-bg } else { white },
  table.header(
    [*Component*], [*Details*],
  ),
  [Hostname], [danieldesktop],
  [Chassis], [Desktop (Mid-tower)],
  [Case], [Be Quiet Pure Base 500 (BG034)],
  [Motherboard], [MSI PRO B760M-A WIFI (MS-7D99) v2.0 — Micro-ATX, LGA 1700, Intel B760],
  [BIOS], [American Megatrends International, v.A.70 (2024-01-10)],
  [PSU], [Seasonic Focus GX-850 (SSR-850FX) — 850W, 80+ Gold, Fully Modular],
)

== Processor

#table(
  columns: (auto, 1fr),
  inset: 8pt,
  stroke: 0.5pt + brand-blue.lighten(80%),
  fill: (x, y) => if y == 0 { brand-bg-blue } else if calc.odd(y) { brand-bg } else { white },
  table.header(
    [*Parameter*], [*Value*],
  ),
  [Model], [12th Gen Intel Core i7-12700F],
  [Architecture], [x86_64 (Alder Lake)],
  [Cores / Threads], [12 cores / 20 threads (8 Performance + 4 Efficiency)],
  [Base / Max Turbo], [2.1 GHz / 4.9 GHz],
  [TDP], [65W (PBP) / 180W (MTP)],
  [L1 Cache], [512 KiB data + 512 KiB instruction (12 instances)],
  [L2 Cache], [12 MiB (9 instances)],
  [L3 Cache], [25 MiB (shared)],
  [Virtualization], [VT-x],
  [ISA Extensions], [SSE4.2, AVX2, AVX-VNNI, AES-NI, SHA-NI],
  [CPU Cooler], [Thermalright Peerless Assassin 120 SE V3 (250W+ rated)],
  [Note], [F-series — no integrated graphics],
)

== Memory

#table(
  columns: (auto, 1fr),
  inset: 8pt,
  stroke: 0.5pt + brand-blue.lighten(80%),
  fill: (x, y) => if y == 0 { brand-bg-blue } else if calc.odd(y) { brand-bg } else { white },
  table.header(
    [*Parameter*], [*Value*],
  ),
  [Total Installed], [64 GB (4 × 16 GB)],
  [Type], [DDR5],
  [Speed], [4800 MT/s],
  [Manufacturer], [Kingston (KVR48U40BS8-16)],
  [Voltage], [1.1V],
  [Slots], [4 / 4 occupied],
  [Error Correction], [None (non-ECC)],
  [Swap], [31.3 GB (zram)],
)

== Graphics

#table(
  columns: (auto, 1fr),
  inset: 8pt,
  stroke: 0.5pt + brand-blue.lighten(80%),
  fill: (x, y) => if y == 0 { brand-bg-blue } else if calc.odd(y) { brand-bg } else { white },
  table.header(
    [*Parameter*], [*Value*],
  ),
  [Model], [AMD Radeon RX 7700 XT (Navi 32)],
  [Manufacturer], [Sapphire Technology (Pulse Gaming)],
  [VRAM], [12 GB GDDR6],
  [PCIe], [x16, PCIe 4.0 (16.0 GT/s)],
  [Driver], [amdgpu (Mesa 25.2.8)],
  [OpenGL], [4.6 (Compatibility Profile)],
  [ROCm], [Available — HSA Runtime 1.15 (gfx1101)],
  [TDP], [~200W],
  [VRAM Allocation], [256 MB BAR (64-bit prefetchable)],
)

== Displays

#table(
  columns: (auto, auto, auto),
  inset: 8pt,
  stroke: 0.5pt + brand-blue.lighten(80%),
  fill: (x, y) => if y == 0 { brand-bg-blue } else if calc.odd(y) { brand-bg } else { white },
  table.header(
    [*Output*], [*Resolution*], [*Status*],
  ),
  [DP-2], [1920 × 1080], [Connected (primary)],
  [DP-1], [1920 × 1080], [Connected],
  [HDMI-A-2], [1920 × 1080], [Connected],
  [HDMI-A-1], [1024 × 600], [Connected (mini monitor)],
)

All 4 physical outputs on the GPU are occupied.

== Storage

#table(
  columns: (auto, auto, auto, auto),
  inset: 8pt,
  stroke: 0.5pt + brand-blue.lighten(80%),
  fill: (x, y) => if y == 0 { brand-bg-blue } else if calc.odd(y) { brand-bg } else { white },
  table.header(
    [*Device*], [*Model*], [*Capacity*], [*Interface*],
  ),
  [nvme0n1], [Crucial CT1000P3SSD8], [931.5 GB], [NVMe (PCIe Gen 4)],
  [sda], [SanDisk SSD PLUS 1000GB], [931.5 GB], [SATA 3.2 (6.0 Gb/s)],
  [sdb], [Kingston SA400S37], [894.3 GB], [SATA],
  [sdc], [SanDisk SSD PLUS], [931.5 GB], [SATA],
  [sdd], [SanDisk SSD PLUS], [931.5 GB], [SATA],
)

*Total local storage:* ~4.6 TB across 5 SSDs (all solid-state, no spinning disks). \
*Root filesystem:* `/dev/sdb` — btrfs, 4.6 TB pool, 78% used (825 GB available). \
*Network storage:* NAS at 10.0.0.50 + Wasabi cloud object storage.

== Networking

#table(
  columns: (auto, 1fr),
  inset: 8pt,
  stroke: 0.5pt + brand-blue.lighten(80%),
  fill: (x, y) => if y == 0 { brand-bg-blue } else if calc.odd(y) { brand-bg } else { white },
  table.header(
    [*Interface*], [*Details*],
  ),
  [Wired (enp6s0)], [Realtek RTL8125 2.5GbE — Active],
  [Wireless (wlo1)], [Intel Wi-Fi 6E (Raptor Lake-S PCH CNVi) — Down],
  [VPN (tailscale0)], [Tailscale mesh — Active],
  [Bluetooth], [5.3 (via TP-Link USB adapter)],
)

== Audio

#table(
  columns: (auto, 1fr),
  inset: 8pt,
  stroke: 0.5pt + brand-blue.lighten(80%),
  fill: (x, y) => if y == 0 { brand-bg-blue } else if calc.odd(y) { brand-bg } else { white },
  table.header(
    [*Device*], [*Details*],
  ),
  [Audio Server], [PipeWire 1.4.7],
  [Onboard], [HDA Intel PCH — Realtek ALC897 Analog],
  [USB DAC], [FiiO K11],
  [USB Speakerphone], [EMEET OfficeCore M1A],
  [HDMI Audio], [HDA ATI HDMI (3 × displays)],
)

== Connected Peripherals

#table(
  columns: (auto, 1fr),
  inset: 8pt,
  stroke: 0.5pt + brand-blue.lighten(80%),
  fill: (x, y) => if y == 0 { brand-bg-blue } else if calc.odd(y) { brand-bg } else { white },
  table.header(
    [*Device*], [*Details*],
  ),
  [Keyboard], [Compx Keyboard (USB)],
  [Mouse], [Logitech MX Vertical Advanced Ergonomic],
  [Webcam], [Logitech C925e],
  [Stream Deck], [Elgato Stream Deck Mini],
  [Security Key], [YubiKey (OTP+FIDO+CCID)],
  [Smart Card Reader], [ACS ACR1252 Dual Reader],
  [UPS], [PPC Offline UPS],
  [Wireless Receiver], [Logitech Unifying Receiver],
)

#pagebreak()

// ═══════════════════════════════════════════
= Photos
// ═══════════════════════════════════════════

#v(0.3em)

#figure(
  image("pics/IMG20260220120211.jpg", width: 95%),
  caption: [Workstation desk setup — triple 1920×1080 monitors plus mini display, with peripherals],
)

#v(0.8em)

#grid(
  columns: (1fr, 1fr),
  gutter: 12pt,
  figure(
    image("pics/image copy.png", width: 100%),
    caption: [Case interior — Be Quiet Pure Base 500 with Thermalright cooler and MSI B760M-A],
  ),
  figure(
    image("pics/image copy 3.png", width: 100%),
    caption: [Intel Core i7-12700F in LGA 1700 socket (cooler removed, 19-02-2026)],
  ),
)

#v(0.8em)

#figure(
  image("pics/image.png", width: 55%),
  caption: [SATA SSD drive bay — SanDisk and Kingston drives],
)

#pagebreak()

// ═══════════════════════════════════════════
= Operating System
// ═══════════════════════════════════════════

#table(
  columns: (auto, 1fr),
  inset: 8pt,
  stroke: 0.5pt + brand-blue.lighten(80%),
  fill: (x, y) => if y == 0 { brand-bg-blue } else if calc.odd(y) { brand-bg } else { white },
  table.header(
    [*Parameter*], [*Value*],
  ),
  [Distribution], [Ubuntu 25.10 "Questing Quokka"],
  [Kernel], [6.14.0-15-generic (PREEMPT_DYNAMIC SMP)],
  [Architecture], [x86_64],
  [Desktop Environment], [KDE Plasma 6.4.5],
  [Display Server], [Wayland],
  [Init System], [systemd],
  [Audio], [PipeWire 1.4.7],
  [GPU Driver Stack], [amdgpu + Mesa 25.2.8 + LLVM 20.1.8 + ROCm],
)

#pagebreak()

// ═══════════════════════════════════════════
= Benchmark Results
// ═══════════════════════════════════════════

All benchmarks were run on *20-02-2026 at 12:43 IST* under normal desktop workload conditions (browser, terminal, desktop environment running). No special tuning was applied.

== CPU — sysbench

Prime computation benchmark (primes up to 20,000):

#table(
  columns: (auto, auto, auto, auto),
  inset: 8pt,
  stroke: 0.5pt + brand-blue.lighten(80%),
  fill: (x, y) => if y == 0 { brand-bg-blue } else if calc.odd(y) { brand-bg } else { white },
  table.header(
    [*Test*], [*Events/sec*], [*Avg Latency*], [*95th %ile Latency*],
  ),
  [Single-thread (1T)], [*1,398.9*], [0.71 ms], [0.72 ms],
  [Multi-thread (20T)], [*15,677.4*], [1.27 ms], [1.50 ms],
)

*Multi-thread scaling ratio:* 11.2× (20 threads) — reflects the hybrid P+E core architecture where efficiency cores contribute less throughput per thread than performance cores.

#v(0.5em)
#align(center)[
  #cetz.canvas({
    import cetz.draw: *

    chart.barchart(
      size: (10, 3),
      label-key: 0,
      value-key: 1,
      bar-width: 0.7,
      (
        ("Multi-thread (20T)", 15677),
        ("Single-thread (1T)", 1399),
      ),
      bar-style: (i) => {
        if i == 0 { (fill: brand-blue-lt, stroke: none) }
        else { (fill: brand-blue, stroke: none) }
      },
      x-label: [Events / sec],
    )
  })
]

== CPU — stress-ng

General CPU stress test across all computation methods (30 seconds, 20 workers):

#rect(
  fill: brand-bg-blue,
  radius: 6pt,
  inset: 12pt,
  width: 100%,
  [
    #grid(
      columns: (1fr, 1fr),
      row-gutter: 8pt,
      [*Bogo operations:*], [810,902],
      [*Real time:*], [30.00 seconds],
      [*User+Sys CPU time:*], [554.58 seconds],
      [*Throughput (real):*], [*27,028.9 bogo ops/s*],
      [*Throughput (CPU):*], [*1,462.2 bogo ops/s*],
      [*Result:*], [All 20 workers passed],
    )
  ]
)

== Memory — sysbench

Sequential memory write operations with 1 MiB block size:

#table(
  columns: (auto, auto, auto),
  inset: 8pt,
  stroke: 0.5pt + brand-blue.lighten(80%),
  fill: (x, y) => if y == 0 { brand-bg-blue } else if calc.odd(y) { brand-bg } else { white },
  table.header(
    [*Test*], [*Throughput*], [*Total Transferred*],
  ),
  [Single-thread (1T)], [*34,644 MiB/s* (33.8 GB/s)], [10 GB in 0.29s],
  [Multi-thread (20T)], [*128,309 MiB/s* (125.3 GB/s)], [40 GB in 0.32s],
)

*Multi-thread scaling ratio:* 3.7× — memory bandwidth is shared across channels, so scaling is bounded by the dual-channel DDR5 memory controller rather than thread count.

#v(0.5em)
#align(center)[
  #cetz.canvas({
    import cetz.draw: *

    chart.barchart(
      size: (10, 3),
      label-key: 0,
      value-key: 1,
      bar-width: 0.7,
      (
        ("Multi-thread (20T)", 128309),
        ("Single-thread (1T)", 34644),
      ),
      bar-style: (i) => {
        if i == 0 { (fill: brand-emerald.lighten(20%), stroke: none) }
        else { (fill: brand-emerald, stroke: none) }
      },
      x-label: [MiB / sec],
    )
  })
]

== Disk I/O — fio

All tests performed on the root filesystem (`/dev/sdb`, Kingston SA400S37, SATA SSD via btrfs). Direct I/O mode, 30-second duration per test.

=== Sequential I/O (1 MiB block size, queue depth 1)

#table(
  columns: (auto, auto, auto, auto),
  inset: 8pt,
  stroke: 0.5pt + brand-blue.lighten(80%),
  fill: (x, y) => if y == 0 { brand-bg-blue } else if calc.odd(y) { brand-bg } else { white },
  table.header(
    [*Test*], [*Bandwidth*], [*IOPS*], [*Avg Latency*],
  ),
  [Sequential Read], [*9,636 MiB/s* (10.1 GB/s)], [9,635], [104 µs],
  [Sequential Write], [*8,483 MiB/s* (8.9 GB/s)], [8,483], [118 µs],
)

_Note: These numbers substantially exceed the SATA III 6 Gb/s (~550 MB/s) theoretical maximum, indicating the data was served from the btrfs page cache / kernel buffers rather than raw disk. This reflects real-world workload performance with the OS caching layer active._

=== Random I/O (4 KiB block size, 4 jobs × queue depth 32)

#table(
  columns: (auto, auto, auto, auto),
  inset: 8pt,
  stroke: 0.5pt + brand-blue.lighten(80%),
  fill: (x, y) => if y == 0 { brand-bg-blue } else if calc.odd(y) { brand-bg } else { white },
  table.header(
    [*Test*], [*Bandwidth*], [*IOPS*], [*Avg Latency*],
  ),
  [Random Read 4K], [*12.7 GiB/s* (13.7 GB/s)], [*3,335,000*], [37 µs],
  [Random Write 4K], [*5,335 MiB/s* (5.6 GB/s)], [*1,366,000*], [91 µs],
)

_Same caching note applies. The extremely high IOPS reflect kernel page cache hits. For raw device performance, a dedicated NVMe or SATA benchmark with drop_caches would be needed._

#v(0.5em)
#align(center)[
  #cetz.canvas({
    import cetz.draw: *

    chart.barchart(
      size: (10, 5),
      label-key: 0,
      value-key: 1,
      bar-width: 0.7,
      (
        ("Rand Write 4K", 5335),
        ("Rand Read 4K", 13027),
        ("Seq Write 1M", 8483),
        ("Seq Read 1M", 9636),
      ),
      bar-style: (i) => {
        let colors = (brand-violet.lighten(30%), brand-violet, brand-blue-lt, brand-blue)
        (fill: colors.at(i), stroke: none)
      },
      x-label: [MiB / sec],
    )
  })
]

== GPU — glmark2

OpenGL 4.6 benchmark on AMD Radeon RX 7700 XT via Mesa/RadeonSI (800×600 windowed):

#rect(
  fill: brand-bg-blue,
  radius: 6pt,
  inset: 16pt,
  width: 100%,
  [
    #align(center)[
      #text(size: 36pt, weight: "bold", fill: brand-blue)[9,809]
      #v(-0.2em)
      #text(size: 14pt, fill: luma(100))[glmark2 Score]
    ]
  ]
)

#v(0.3em)

Selected scene results:

#table(
  columns: (1fr, auto, auto),
  inset: 8pt,
  stroke: 0.5pt + brand-blue.lighten(80%),
  fill: (x, y) => if y == 0 { brand-bg-blue } else if calc.odd(y) { brand-bg } else { white },
  table.header(
    [*Scene*], [*FPS*], [*Frame Time*],
  ),
  [texture (nearest filter)], [13,361], [0.075 ms],
  [build (VBO enabled)], [12,409], [0.081 ms],
  [shading (Gouraud)], [12,353], [0.081 ms],
  [bump (high-poly)], [12,271], [0.081 ms],
  [shading (Phong)], [11,964], [0.084 ms],
  [jellyfish], [10,494], [0.095 ms],
  [shadow], [10,048], [0.100 ms],
  [desktop (blur)], [6,400], [0.156 ms],
  [refract], [5,991], [0.167 ms],
  [terrain], [3,415], [0.293 ms],
  [buffer (map method)], [1,172], [0.853 ms],
)

#v(0.5em)
#align(center)[
  #cetz.canvas({
    import cetz.draw: *

    chart.barchart(
      size: (10, 8),
      label-key: 0,
      value-key: 1,
      bar-width: 0.7,
      (
        ("buffer (map)", 1172),
        ("terrain", 3415),
        ("refract", 5991),
        ("desktop (blur)", 6400),
        ("shadow", 10048),
        ("jellyfish", 10494),
        ("shading (Phong)", 11964),
        ("bump (high-poly)", 12271),
        ("build (VBO)", 12409),
        ("texture (nearest)", 13361),
      ),
      bar-style: (i) => {
        let t = i / 9
        let r = int(3 * (1 - t) + 14 * t)
        let g = int(105 * (1 - t) + 165 * t)
        let b = int(161 * (1 - t) + 233 * t)
        (fill: rgb(r, g, b), stroke: none)
      },
      x-label: [FPS],
    )
  })
]

#pagebreak()

// ═══════════════════════════════════════════
= Summary
// ═══════════════════════════════════════════

#rect(
  fill: brand-bg-blue,
  radius: 8pt,
  inset: 16pt,
  width: 100%,
  [
    #set text(size: 10pt)
    #table(
      columns: (auto, auto, 1fr),
      inset: 8pt,
      stroke: 0.5pt + brand-blue.lighten(80%),
      fill: (x, y) => if y == 0 { brand-blue } else if calc.odd(y) { white } else { brand-bg },
      table.header(
        text(fill: white, weight: "bold")[Component],
        text(fill: white, weight: "bold")[Key Metric],
        text(fill: white, weight: "bold")[Result],
      ),
      [CPU (single-thread)], [sysbench events/s], [1,399],
      [CPU (multi-thread)], [sysbench events/s], [15,677],
      [CPU (stress-ng)], [bogo ops/s (real)], [27,029],
      [Memory (single-thread)], [sysbench throughput], [34,644 MiB/s],
      [Memory (multi-thread)], [sysbench throughput], [128,309 MiB/s],
      [Disk seq. read], [fio bandwidth], [9,636 MiB/s #super[\*]],
      [Disk seq. write], [fio bandwidth], [8,483 MiB/s #super[\*]],
      [Disk random read 4K], [fio IOPS], [3.34M IOPS #super[\*]],
      [Disk random write 4K], [fio IOPS], [1.37M IOPS #super[\*]],
      [GPU (OpenGL)], [glmark2 score], [*9,809*],
    )
  ]
)

#v(0.3em)
#text(size: 8pt, fill: brand-slate-5)[#super[\*] Disk I/O numbers include kernel page cache effects. See Disk I/O section for details.]

#v(1cm)

== Test Conditions

- *Date/Time:* 20-02-2026 12:43 IST (UTC+2)
- *Kernel:* 6.14.0-15-generic (PREEMPT_DYNAMIC)
- *Governor:* Default (schedutil)
- *Background load:* Normal desktop usage (KDE Plasma, browser, terminal)
- *No special tuning* was applied (no CPU pinning, no governor override, no drop_caches)

== Tools & Versions

#table(
  columns: (auto, auto, auto),
  inset: 8pt,
  stroke: 0.5pt + brand-blue.lighten(80%),
  fill: (x, y) => if y == 0 { brand-bg-blue } else if calc.odd(y) { brand-bg } else { white },
  table.header(
    [*Tool*], [*Version*], [*Purpose*],
  ),
  [sysbench], [1.0.20 (LuaJIT 2.1)], [CPU and memory benchmarks],
  [stress-ng], [system package], [CPU stress / bogo-ops throughput],
  [fio], [3.39], [Disk I/O benchmarks],
  [glmark2-wayland], [2023.01], [OpenGL GPU benchmark],
  [Typst], [system install], [Report generation],
)

#pagebreak()

// ═══════════════════════════════════════════
= Appendix: Raw Benchmark Output
// ═══════════════════════════════════════════

== A.1 — sysbench CPU (Single-Thread)

#block(
  fill: brand-bg-tint,
  radius: 4pt,
  inset: 10pt,
  width: 100%,
  [
    #set text(font: "Liberation Mono", size: 7.5pt)
    ```
sysbench 1.0.20 (using system LuaJIT 2.1.1731486438)

Running the test with following options:
Number of threads: 1
Prime numbers limit: 20000

Threads started!

CPU speed:
    events per second:  1398.88

General statistics:
    total time:                          10.0004s
    total number of events:              13992

Latency (ms):
         min:                                    0.68
         avg:                                    0.71
         max:                                    4.16
         95th percentile:                        0.72
         sum:                                 9998.25

Threads fairness:
    events (avg/stddev):           13992.0000/0.00
    execution time (avg/stddev):   9.9982/0.00
    ```
  ]
)

== A.2 — sysbench CPU (Multi-Thread, 20T)

#block(
  fill: brand-bg-tint,
  radius: 4pt,
  inset: 10pt,
  width: 100%,
  [
    #set text(font: "Liberation Mono", size: 7.5pt)
    ```
sysbench 1.0.20 (using system LuaJIT 2.1.1731486438)

Running the test with following options:
Number of threads: 20
Prime numbers limit: 20000

Threads started!

CPU speed:
    events per second: 15677.35

General statistics:
    total time:                          10.0009s
    total number of events:              156802

Latency (ms):
         min:                                    0.70
         avg:                                    1.27
         max:                                   26.59
         95th percentile:                        1.50
         sum:                               199899.22

Threads fairness:
    events (avg/stddev):           7840.1000/791.70
    execution time (avg/stddev):   9.9950/0.01
    ```
  ]
)

== A.3 — sysbench Memory (Single-Thread)

#block(
  fill: brand-bg-tint,
  radius: 4pt,
  inset: 10pt,
  width: 100%,
  [
    #set text(font: "Liberation Mono", size: 7.5pt)
    ```
sysbench 1.0.20 (using system LuaJIT 2.1.1731486438)

Running memory speed test with the following options:
  block size: 1024KiB
  total size: 10240MiB
  operation: write
  scope: global

Number of threads: 1

Total operations: 10240 (34644.25 per second)
10240.00 MiB transferred (34644.25 MiB/sec)

General statistics:
    total time:                          0.2907s
    total number of events:              10240

Latency (ms):
         min:                                    0.02
         avg:                                    0.03
         max:                                    0.20
         95th percentile:                        0.03
         sum:                                  289.04
    ```
  ]
)

== A.4 — sysbench Memory (Multi-Thread, 20T)

#block(
  fill: brand-bg-tint,
  radius: 4pt,
  inset: 10pt,
  width: 100%,
  [
    #set text(font: "Liberation Mono", size: 7.5pt)
    ```
sysbench 1.0.20 (using system LuaJIT 2.1.1731486438)

Running memory speed test with the following options:
  block size: 1024KiB
  total size: 40960MiB
  operation: write
  scope: global

Number of threads: 20

Total operations: 40960 (128309.41 per second)
40960.00 MiB transferred (128309.41 MiB/sec)

General statistics:
    total time:                          0.3180s
    total number of events:              40960

Latency (ms):
         min:                                    0.03
         avg:                                    0.14
         max:                                    7.47
         95th percentile:                        0.21
         sum:                                 5609.92
    ```
  ]
)

== A.5 — stress-ng CPU (30s, All Methods)

#block(
  fill: brand-bg-tint,
  radius: 4pt,
  inset: 10pt,
  width: 100%,
  [
    #set text(font: "Liberation Mono", size: 7.5pt)
    ```
stress-ng: dispatching hogs: 20 cpu
stress-ng: stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s
stress-ng:                           (secs)    (secs)    (secs)   (real time) (usr+sys time)
stress-ng: cpu              810902     30.00    552.78      1.80     27028.85        1462.19
stress-ng: passed: 20: cpu (20)
stress-ng: failed: 0
stress-ng: successful run completed in 30.01 secs
    ```
  ]
)

== A.6 — fio Sequential Read

#block(
  fill: brand-bg-tint,
  radius: 4pt,
  inset: 10pt,
  width: 100%,
  [
    #set text(font: "Liberation Mono", size: 7.5pt)
    ```
seq_read: (groupid=0, jobs=1): err= 0
  read: IOPS=9635, BW=9636MiB/s (10.1GB/s)(282GiB/30001msec)
    slat (usec): min=85, max=697, avg=103.03, stdev=15.45
    clat (nsec): min=354, max=31165, avg=498.24, stdev=239.15
     lat (usec): min=85, max=700, avg=103.53, stdev=15.59
    clat percentiles (nsec):
     |  1.00th=[  398],  5.00th=[  418], 10.00th=[  426],
     | 50.00th=[  462], 90.00th=[  564], 99.00th=[ 1012]
   bw (MiB/s): min=7556, max=9898, avg=9636.17, stdev=359.26

   READ: bw=9636MiB/s (10.1GB/s), io=282GiB (303GB), run=30001msec
    ```
  ]
)

== A.7 — fio Sequential Write

#block(
  fill: brand-bg-tint,
  radius: 4pt,
  inset: 10pt,
  width: 100%,
  [
    #set text(font: "Liberation Mono", size: 7.5pt)
    ```
seq_write: (groupid=0, jobs=1): err= 0
  write: IOPS=8483, BW=8483MiB/s (8895MB/s)(249GiB/30001msec)
    slat (usec): min=73, max=1264, avg=116.97, stdev=27.85
    clat (nsec): min=388, max=59167, avg=587.23, stdev=449.04
     lat (usec): min=74, max=1269, avg=117.55, stdev=28.13
    clat percentiles (nsec):
     |  1.00th=[  442],  5.00th=[  458], 10.00th=[  466],
     | 50.00th=[  506], 90.00th=[  692], 99.00th=[ 2352]
   bw (MiB/s): min=7580, max=9038, avg=8483.53, stdev=389.78

   WRITE: bw=8483MiB/s (8895MB/s), io=249GiB (267GB), run=30001msec
    ```
  ]
)

== A.8 — fio Random Read 4K

#block(
  fill: brand-bg-tint,
  radius: 4pt,
  inset: 10pt,
  width: 100%,
  [
    #set text(font: "Liberation Mono", size: 7.5pt)
    ```
rand_read: (groupid=0, jobs=4): err= 0
  read: IOPS=3335k, BW=12.7GiB/s (13.7GB/s)(382GiB/30001msec)
    slat (nsec): min=423, max=806682, avg=820.46, stdev=476.11
    clat (nsec): min=786, max=916178, avg=37402.13, stdev=10059.35
     lat (nsec): min=1578, max=917491, avg=38222.59, stdev=10232.22
    clat percentiles (usec):
     |  1.00th=[   35],  5.00th=[   35], 10.00th=[   35],
     | 50.00th=[   37], 90.00th=[   40], 99.00th=[   64]
   bw (MiB/s): min=11223, max=13616, avg=13027.23, stdev=120.47

   READ: bw=12.7GiB/s (13.7GB/s), io=382GiB (410GB), run=30001msec
    ```
  ]
)

== A.9 — fio Random Write 4K

#block(
  fill: brand-bg-tint,
  radius: 4pt,
  inset: 10pt,
  width: 100%,
  [
    #set text(font: "Liberation Mono", size: 7.5pt)
    ```
rand_write: (groupid=0, jobs=4): err= 0
  write: IOPS=1366k, BW=5335MiB/s (5594MB/s)(156GiB/30001msec)
    slat (nsec): min=554, max=3073.6k, avg=2473.64, stdev=3374.50
    clat (nsec): min=919, max=3372.8k, avg=91064.59, stdev=28717.21
     lat (usec): min=3, max=3383, avg=93.54, stdev=29.26
    clat percentiles (usec):
     |  1.00th=[   73],  5.00th=[   77], 10.00th=[   79],
     | 50.00th=[   87], 90.00th=[  101], 99.00th=[  229]
   bw (MiB/s): min=4437, max=5854, avg=5334.70, stdev=81.06

   WRITE: bw=5335MiB/s (5594MB/s), io=156GiB (168GB), run=30001msec
    ```
  ]
)

== A.10 — glmark2 GPU Benchmark (Full Output)

#block(
  fill: brand-bg-tint,
  radius: 4pt,
  inset: 10pt,
  width: 100%,
  [
    #set text(font: "Liberation Mono", size: 7.5pt)
    ```
glmark2 2023.01
OpenGL Information
    GL_VENDOR:      AMD
    GL_RENDERER:    AMD Radeon RX 7700 XT (radeonsi, navi32,
                    LLVM 20.1.8, DRM 3.61, 6.14.0-15-generic)
    GL_VERSION:     4.6 (Compatibility Profile) Mesa 25.2.8
    Surface Config: buf=32 r=8 g=8 b=8 a=8 depth=24 stencil=0
    Surface Size:   800x600 windowed

[build] use-vbo=false:                          FPS: 9088
[build] use-vbo=true:                           FPS: 12409
[texture] texture-filter=nearest:               FPS: 13361
[texture] texture-filter=linear:                FPS: 12550
[texture] texture-filter=mipmap:                FPS: 12153
[shading] shading=gouraud:                      FPS: 12353
[shading] shading=blinn-phong-inf:              FPS: 12186
[shading] shading=phong:                        FPS: 11964
[shading] shading=cel:                          FPS: 11403
[bump] bump-render=high-poly:                   FPS: 12271
[bump] bump-render=normals:                     FPS: 11673
[bump] bump-render=height:                      FPS: 11616
[effect2d] kernel=0,1,0;1,-4,1;0,1,0;:         FPS: 12385
[effect2d] kernel=1,1,1,1,1;1,1,1,1,1;...:     FPS: 11224
[pulsar] light=false:quads=5:texture=false:     FPS: 11777
[desktop] blur-radius=5:passes=1:windows=4:     FPS: 6400
[desktop] effect=shadow:windows=4:              FPS: 7971
[buffer] columns=200:update-method=map:         FPS: 1172
[buffer] columns=200:update-method=subdata:     FPS: 2152
[buffer] columns=200:interleave=true:map:       FPS: 1366
[ideas] speed=duration:                         FPS: 4495
[jellyfish] <default>:                          FPS: 10494
[terrain] <default>:                            FPS: 3415
[shadow] <default>:                             FPS: 10048
[refract] <default>:                            FPS: 5991
[conditionals] fragment-steps=0:vertex=0:       FPS: 11591
[conditionals] fragment-steps=5:vertex=0:       FPS: 11757
[conditionals] fragment-steps=0:vertex=5:       FPS: 12061
[function] fragment-complexity=low:steps=5:     FPS: 11547
[function] fragment-complexity=medium:steps=5:  FPS: 11054
[loop] fragment-loop=false:steps=5:vertex=5:    FPS: 11747
[loop] fragment-uniform=false:steps=5:vertex=5: FPS: 11129
[loop] fragment-uniform=true:steps=5:vertex=5:  FPS: 10943

                              glmark2 Score: 9809
    ```
  ]
)

== A.11 — lscpu Output

#block(
  fill: brand-bg-tint,
  radius: 4pt,
  inset: 10pt,
  width: 100%,
  [
    #set text(font: "Liberation Mono", size: 7.5pt)
    ```
Architecture:            x86_64
CPU op-mode(s):          32-bit, 64-bit
Address sizes:           39 bits physical, 48 bits virtual
Byte Order:              Little Endian
CPU(s):                  20
On-line CPU(s) list:     0-19
Vendor ID:               GenuineIntel
Model name:              12th Gen Intel(R) Core(TM) i7-12700F
CPU family:              6
Model:                   151
Thread(s) per core:      2
Core(s) per socket:      12
Socket(s):               1
Stepping:                2
CPU max MHz:             4900.0000
CPU min MHz:             800.0000
BogoMIPS:                4224.00
Virtualization:          VT-x
L1d cache:               512 KiB (12 instances)
L1i cache:               512 KiB (12 instances)
L2 cache:                12 MiB (9 instances)
L3 cache:                25 MiB (1 instance)
NUMA node(s):            1
    ```
  ]
)

== A.12 — Memory Configuration (dmidecode)

#block(
  fill: brand-bg-tint,
  radius: 4pt,
  inset: 10pt,
  width: 100%,
  [
    #set text(font: "Liberation Mono", size: 7.5pt)
    ```
Error Correction Type: None

DIMM 1:  16 GB  Controller0-DIMMA1  DDR5  4800 MT/s  Kingston
DIMM 2:  16 GB  Controller0-DIMMA2  DDR5  4800 MT/s  Kingston
DIMM 3:  16 GB  Controller1-DIMMB1  DDR5  4800 MT/s  Kingston
DIMM 4:  16 GB  Controller1-DIMMB2  DDR5  4800 MT/s  Kingston

Total: 4 x 16 GB = 64 GB DDR5 @ 4800 MT/s
    ```
  ]
)
