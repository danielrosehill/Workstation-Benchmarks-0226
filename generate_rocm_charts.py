#!/usr/bin/env python3
"""Generate ROCm benchmark charts for the workstation benchmark report."""

import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
import numpy as np
import os

CHARTS_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'charts')
os.makedirs(CHARTS_DIR, exist_ok=True)

# Color scheme
C_FP32 = '#2196F3'
C_FP16 = '#FF5722'
C_FLASH = '#4CAF50'
C_VRAM = '#9C27B0'
C_PCIE = '#FF9800'
C_GREY = '#78909C'
BG_COLOR = '#FAFAFA'
GRID_COLOR = '#E0E0E0'


def style_ax(ax, title, xlabel=None, ylabel=None):
    ax.set_facecolor(BG_COLOR)
    ax.set_title(title, fontsize=14, fontweight='bold', pad=12)
    if xlabel:
        ax.set_xlabel(xlabel, fontsize=11)
    if ylabel:
        ax.set_ylabel(ylabel, fontsize=11)
    ax.grid(True, axis='y', color=GRID_COLOR, linewidth=0.8)
    ax.set_axisbelow(True)
    ax.spines['top'].set_visible(False)
    ax.spines['right'].set_visible(False)


def chart_gemm():
    """GEMM throughput bar chart — FP32 vs FP16."""
    sizes = ['1024', '2048', '4096', '8192']
    fp32 = [8.17, 8.20, 8.92, 8.41]
    fp16 = [32.63, 47.65, 48.53, 48.78]

    fig, ax = plt.subplots(figsize=(10, 6))
    fig.patch.set_facecolor('white')
    x = np.arange(len(sizes))
    w = 0.35

    bars1 = ax.bar(x - w/2, fp32, w, label='FP32', color=C_FP32, edgecolor='white', linewidth=0.5)
    bars2 = ax.bar(x + w/2, fp16, w, label='FP16', color=C_FP16, edgecolor='white', linewidth=0.5)

    # Value labels
    for bar in bars1:
        ax.text(bar.get_x() + bar.get_width()/2, bar.get_height() + 0.5,
                f'{bar.get_height():.1f}', ha='center', va='bottom', fontsize=9, fontweight='bold')
    for bar in bars2:
        ax.text(bar.get_x() + bar.get_width()/2, bar.get_height() + 0.5,
                f'{bar.get_height():.1f}', ha='center', va='bottom', fontsize=9, fontweight='bold')

    ax.set_xticks(x)
    ax.set_xticklabels([f'{s}x{s}' for s in sizes])
    style_ax(ax, 'GEMM Throughput — AMD Radeon RX 7700 XT (ROCm 6.4)', 'Matrix Size', 'TFLOPS')
    ax.legend(fontsize=11, loc='upper left')
    ax.set_ylim(0, 58)

    # Add annotation
    ax.annotate('5.5x FP16/FP32 ratio\n(RDNA 3 packed FP16)', xy=(3, 48.78), xytext=(2.2, 40),
                fontsize=9, color=C_GREY, ha='center',
                arrowprops=dict(arrowstyle='->', color=C_GREY, lw=1.2))

    plt.tight_layout()
    path = os.path.join(CHARTS_DIR, 'rocm-gemm.png')
    fig.savefig(path, dpi=150, bbox_inches='tight')
    plt.close()
    print(f'  Saved: {path}')


def chart_resnet():
    """ResNet-50 inference throughput."""
    batches = ['B=1', 'B=8', 'B=32']
    fp32 = [264, 782, 726]
    fp16 = [353, 1554, 1668]

    fig, ax = plt.subplots(figsize=(9, 6))
    fig.patch.set_facecolor('white')
    x = np.arange(len(batches))
    w = 0.35

    bars1 = ax.bar(x - w/2, fp32, w, label='FP32', color=C_FP32, edgecolor='white', linewidth=0.5)
    bars2 = ax.bar(x + w/2, fp16, w, label='FP16', color=C_FP16, edgecolor='white', linewidth=0.5)

    for bar in bars1:
        ax.text(bar.get_x() + bar.get_width()/2, bar.get_height() + 20,
                f'{int(bar.get_height())}', ha='center', va='bottom', fontsize=10, fontweight='bold')
    for bar in bars2:
        ax.text(bar.get_x() + bar.get_width()/2, bar.get_height() + 20,
                f'{int(bar.get_height())}', ha='center', va='bottom', fontsize=10, fontweight='bold')

    ax.set_xticks(x)
    ax.set_xticklabels(batches)
    style_ax(ax, 'ResNet-50 Inference — AMD Radeon RX 7700 XT', 'Batch Size', 'Images / Second')
    ax.legend(fontsize=11)
    ax.set_ylim(0, 2000)
    ax.yaxis.set_major_formatter(ticker.FuncFormatter(lambda v, p: f'{int(v):,}'))

    plt.tight_layout()
    path = os.path.join(CHARTS_DIR, 'rocm-resnet50.png')
    fig.savefig(path, dpi=150, bbox_inches='tight')
    plt.close()
    print(f'  Saved: {path}')


def chart_transformer():
    """Transformer layer latency — FP32 vs FP16 vs FP16+Flash."""
    configs = ['BERT-base\n(B=1, L=512)', 'BERT-base\n(B=8, L=512)', 'LLaMA-7B-like\n(B=1, L=2048)']
    fp32 = [2.76, 25.15, 472.31]
    fp16 = [0.52, 2.47, 29.54]
    flash = [0.38, 2.15, 27.76]

    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(14, 6), gridspec_kw={'width_ratios': [1, 2]})
    fig.patch.set_facecolor('white')

    # Left panel: BERT configs (small values)
    x_left = np.arange(2)
    w = 0.25
    ax1.bar(x_left - w, fp32[:2], w, label='FP32', color=C_FP32, edgecolor='white')
    ax1.bar(x_left, fp16[:2], w, label='FP16', color=C_FP16, edgecolor='white')
    ax1.bar(x_left + w, flash[:2], w, label='FP16 + Flash', color=C_FLASH, edgecolor='white')

    for i, (f32, f16, fl) in enumerate(zip(fp32[:2], fp16[:2], flash[:2])):
        ax1.text(i - w, f32 + 0.3, f'{f32:.1f}', ha='center', fontsize=8, fontweight='bold')
        ax1.text(i, f16 + 0.3, f'{f16:.2f}', ha='center', fontsize=8, fontweight='bold')
        ax1.text(i + w, fl + 0.3, f'{fl:.2f}', ha='center', fontsize=8, fontweight='bold')

    ax1.set_xticks(x_left)
    ax1.set_xticklabels(['BERT-base\nB=1, L=512', 'BERT-base\nB=8, L=512'], fontsize=9)
    style_ax(ax1, 'Transformer Layer Latency (BERT)', ylabel='ms / iteration')
    ax1.legend(fontsize=8, loc='upper left')

    # Right panel: LLaMA config (large values)
    x_right = np.arange(1)
    bars = ax2.bar([-0.2, 0, 0.2], [fp32[2], fp16[2], flash[2]], 0.18,
                   color=[C_FP32, C_FP16, C_FLASH], edgecolor='white')

    for bar, val, label in zip(bars, [fp32[2], fp16[2], flash[2]], ['FP32', 'FP16', 'FP16+Flash']):
        ax2.text(bar.get_x() + bar.get_width()/2, bar.get_height() + 5,
                 f'{val:.1f} ms\n({label})', ha='center', va='bottom', fontsize=9, fontweight='bold')

    ax2.set_xticks([0])
    ax2.set_xticklabels(['LLaMA-7B-like\nB=1, L=2048'], fontsize=10)
    style_ax(ax2, 'Transformer Layer Latency (LLaMA-scale)', ylabel='ms / iteration')
    ax2.set_ylim(0, 550)

    # Speedup annotation
    speedup = fp32[2] / flash[2]
    ax2.annotate(f'{speedup:.0f}x speedup\nFP32 → FP16+Flash', xy=(0.2, flash[2]),
                 xytext=(0.5, 200), fontsize=10, color=C_FLASH, fontweight='bold',
                 arrowprops=dict(arrowstyle='->', color=C_FLASH, lw=1.5))

    fig.suptitle('Transformer Layer — AMD Radeon RX 7700 XT (ROCm 6.4)', fontsize=14, fontweight='bold', y=1.02)
    plt.tight_layout()
    path = os.path.join(CHARTS_DIR, 'rocm-transformer.png')
    fig.savefig(path, dpi=150, bbox_inches='tight')
    plt.close()
    print(f'  Saved: {path}')


def chart_memory_bandwidth():
    """GPU memory bandwidth — VRAM and PCIe."""
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(13, 5.5))
    fig.patch.set_facecolor('white')

    # VRAM D2D bandwidth
    sizes = ['64 MB', '256 MB', '1 GB']
    bw = [299.7, 304.1, 305.9]
    theoretical = 432

    bars = ax1.bar(sizes, bw, color=C_VRAM, edgecolor='white', linewidth=0.5, width=0.5)
    ax1.axhline(y=theoretical, color=C_GREY, linestyle='--', linewidth=1.5, label=f'Theoretical peak ({theoretical} GB/s)')

    for bar in bars:
        pct = bar.get_height() / theoretical * 100
        ax1.text(bar.get_x() + bar.get_width()/2, bar.get_height() + 5,
                 f'{bar.get_height():.0f}\n({pct:.0f}%)', ha='center', va='bottom', fontsize=9, fontweight='bold')

    style_ax(ax1, 'VRAM Bandwidth (Device-to-Device Copy)', 'Transfer Size', 'GB/s')
    ax1.set_ylim(0, 500)
    ax1.legend(fontsize=9, loc='lower right')

    # PCIe bandwidth
    labels = ['H→D\n(pinned)', 'D→H\n(pinned)']
    bw_pcie = [12.5, 11.9]  # average of the two runs
    theoretical_pcie = 25.0  # PCIe 4.0 x16 bidirectional

    bars2 = ax2.bar(labels, bw_pcie, color=C_PCIE, edgecolor='white', linewidth=0.5, width=0.4)
    ax2.axhline(y=theoretical_pcie/2, color=C_GREY, linestyle='--', linewidth=1.5,
                label=f'PCIe 4.0 x16 unidirectional (~{theoretical_pcie/2:.0f} GB/s)')

    for bar in bars2:
        ax2.text(bar.get_x() + bar.get_width()/2, bar.get_height() + 0.3,
                 f'{bar.get_height():.1f} GB/s', ha='center', va='bottom', fontsize=10, fontweight='bold')

    style_ax(ax2, 'PCIe Transfer Bandwidth', 'Direction', 'GB/s')
    ax2.set_ylim(0, 18)
    ax2.legend(fontsize=9, loc='upper right')

    fig.suptitle('GPU Memory Bandwidth — AMD Radeon RX 7700 XT', fontsize=14, fontweight='bold', y=1.02)
    plt.tight_layout()
    path = os.path.join(CHARTS_DIR, 'rocm-memory-bandwidth.png')
    fig.savefig(path, dpi=150, bbox_inches='tight')
    plt.close()
    print(f'  Saved: {path}')


def chart_conv2d():
    """Conv2D layer latency."""
    configs = ['First layer\nB=32, 3→64\n224x224, k=7',
               'Mid layer\nB=32, 256→256\n56x56, k=3',
               'First layer\nB=1, 3→64\n224x224, k=7',
               'Deep layer\nB=8, 512→512\n28x28, k=3']
    times = [2.18, 3.58, 0.08, 0.92]

    fig, ax = plt.subplots(figsize=(10, 5.5))
    fig.patch.set_facecolor('white')

    colors = [C_FP32, C_FP32, '#64B5F6', '#64B5F6']
    bars = ax.barh(configs, times, color=colors, edgecolor='white', linewidth=0.5, height=0.5)

    for bar in bars:
        ax.text(bar.get_width() + 0.05, bar.get_y() + bar.get_height()/2,
                f'{bar.get_width():.2f} ms', va='center', fontsize=10, fontweight='bold')

    style_ax(ax, 'Conv2D Layer Latency (FP32) — AMD Radeon RX 7700 XT', 'ms / iteration')
    ax.set_xlim(0, 4.5)
    ax.invert_yaxis()
    ax.grid(True, axis='x', color=GRID_COLOR, linewidth=0.8)
    ax.grid(False, axis='y')

    plt.tight_layout()
    path = os.path.join(CHARTS_DIR, 'rocm-conv2d.png')
    fig.savefig(path, dpi=150, bbox_inches='tight')
    plt.close()
    print(f'  Saved: {path}')


def chart_summary():
    """Summary overview chart with key metrics."""
    fig, axes = plt.subplots(1, 4, figsize=(16, 4.5))
    fig.patch.set_facecolor('white')

    metrics = [
        ('FP32 GEMM\n(peak)', 8.9, 'TFLOPS', C_FP32),
        ('FP16 GEMM\n(peak)', 48.8, 'TFLOPS', C_FP16),
        ('VRAM BW\n(measured)', 306, 'GB/s', C_VRAM),
        ('ResNet-50\n(FP16 B=32)', 1668, 'img/s', C_FLASH),
    ]

    for ax, (label, value, unit, color) in zip(axes, metrics):
        ax.set_facecolor(BG_COLOR)
        ax.set_xlim(0, 1)
        ax.set_ylim(0, 1)
        ax.axis('off')

        # Big number
        if value >= 100:
            val_str = f'{value:,.0f}'
        else:
            val_str = f'{value:.1f}'

        ax.text(0.5, 0.55, val_str, ha='center', va='center',
                fontsize=36, fontweight='bold', color=color)
        ax.text(0.5, 0.30, unit, ha='center', va='center',
                fontsize=16, color=C_GREY)
        ax.text(0.5, 0.10, label, ha='center', va='center',
                fontsize=11, color='#424242')

        # Border
        for spine in ax.spines.values():
            spine.set_visible(True)
            spine.set_color(GRID_COLOR)
            spine.set_linewidth(1.5)

    fig.suptitle('ROCm Compute Summary — AMD Radeon RX 7700 XT', fontsize=15, fontweight='bold', y=1.05)
    plt.tight_layout()
    path = os.path.join(CHARTS_DIR, 'rocm-summary.png')
    fig.savefig(path, dpi=150, bbox_inches='tight')
    plt.close()
    print(f'  Saved: {path}')


if __name__ == '__main__':
    print('Generating ROCm benchmark charts...')
    chart_gemm()
    chart_resnet()
    chart_transformer()
    chart_memory_bandwidth()
    chart_conv2d()
    chart_summary()
    print('Done!')
