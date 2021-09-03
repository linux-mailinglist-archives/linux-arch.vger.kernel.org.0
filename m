Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0193FFD8B
	for <lists+linux-arch@lfdr.de>; Fri,  3 Sep 2021 11:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348982AbhICJyJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Sep 2021 05:54:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348822AbhICJyI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 3 Sep 2021 05:54:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB9B960FC4;
        Fri,  3 Sep 2021 09:53:04 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V2 00/22] arch: Add basic LoongArch support
Date:   Fri,  3 Sep 2021 17:51:51 +0800
Message-Id: <20210903095213.797973-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

LoongArch is a new RISC ISA, which is a bit like MIPS or RISC-V.
LoongArch includes a reduced 32-bit version (LA32R), a standard 32-bit
version (LA32S) and a 64-bit version (LA64). LoongArch use ACPI as its
boot protocol LoongArch-specific interrupt controllers (similar to APIC)
are already added in the next revision of ACPI Specification (current
revision is 6.4).

This patchset is adding basic LoongArch support in mainline kernel, we
can see a complete snapshot here:
https://github.com/loongson/linux/tree/loongarch-next

Cross-compile tool chain to build kernel:
https://github.com/loongson/build-tools/releases/latest/download/loongarch64-clfs-20210812-cross-tools.tar.xz

A CLFS-based Linux distro:
https://github.com/loongson/build-tools/releases/latest/download/loongarch64-clfs-system-2021-08-22.tar.bz2

Open-source tool chain which is under review:
https://github.com/loongson/binutils-gdb/tree/loongarch-2_37
https://github.com/loongson/gcc/tree/loongarch-12
https://github.com/loongson/glibc/tree/loongarch_2_34_dev

Loongson and LoongArch documentations:
https://github.com/loongson/LoongArch-Documentation

LoongArch-specific interrupt controllers:
https://mantis.uefi.org/mantis/view.php?id=2203

V1 -> V2:
1, Add documentation patches;
2, Restore copyright statements;
3, Split the big header patch;
4, Cleanup signal-related headers;
5, Cleanup incomplete 32-bit support;
6, Move the major PCI work to drivers/pci;
7, Rework Loongson64 platform support;
8, Rework lpj and __udelay()/__ndelay();
9, Rework page table layout config options;
10, Rework syscall/exception/interrupt with generic entry framework;
11, Simplify the VDSO/VSYSCALL implementation;
12, Use generic I/O access macros and functions;
13, Remove unaligned access emulation at present;
14, Keep clocksource code in arch since it is the "native clocksource";
15, Some other minor fixes and improvements.

Huacai Chen(22):
 Documentation: LoongArch: Add basic documentations.
 Documentation/zh_CN: Add basic LoongArch documentations.
 LoongArch: Add elf-related definitions.
 LoongArch: Add writecombine support for drm.
 LoongArch: Add build infrastructure.
 LoongArch: Add CPU definition headers.
 LoongArch: Add atomic/locking headers.
 LoongArch: Add other common headers.
 LoongArch: Add boot and setup routines.
 LoongArch: Add exception/interrupt handling. 
 LoongArch: Add process management.
 LoongArch: Add memory management.
 LoongArch: Add system call support.
 LoongArch: Add signal handling support.
 LoongArch: Add elf and module support.
 LoongArch: Add misc common routines.
 LoongArch: Add some library functions.
 LoongArch: Add PCI controller support.
 LoongArch: Add VDSO and VSYSCALL support.
 LoongArch: Add multi-processor (SMP) support.
 LoongArch: Add Non-Uniform Memory Access (NUMA) support.
 LoongArch: Add Loongson-3 default config file.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 Documentation/arch.rst                             |    1 +
 Documentation/loongarch/features.rst               |    3 +
 Documentation/loongarch/index.rst                  |   21 +
 Documentation/loongarch/introduction.rst           |  342 +++++
 Documentation/loongarch/irq-chip-model.rst         |  158 ++
 Documentation/translations/zh_CN/index.rst         |    1 +
 .../translations/zh_CN/loongarch/features.rst      |    8 +
 .../translations/zh_CN/loongarch/index.rst         |   26 +
 .../translations/zh_CN/loongarch/introduction.rst  |  316 ++++
 .../zh_CN/loongarch/irq-chip-model.rst             |  160 +++
 arch/loongarch/.gitignore                          |    9 +
 arch/loongarch/Kbuild                              |   10 +
 arch/loongarch/Kconfig                             |  437 ++++++
 arch/loongarch/Kconfig.debug                       |    0
 arch/loongarch/Makefile                            |  124 ++
 arch/loongarch/configs/loongson3_defconfig         |  722 ++++++++++
 arch/loongarch/include/asm/Kbuild                  |   31 +
 arch/loongarch/include/asm/abi.h                   |   27 +
 arch/loongarch/include/asm/acenv.h                 |   17 +
 arch/loongarch/include/asm/acpi.h                  |   39 +
 arch/loongarch/include/asm/addrspace.h             |  110 ++
 arch/loongarch/include/asm/asm-offsets.h           |    5 +
 arch/loongarch/include/asm/asm-prototypes.h        |    7 +
 arch/loongarch/include/asm/asm.h                   |  212 +++
 arch/loongarch/include/asm/asmmacro.h              |  318 +++++
 arch/loongarch/include/asm/atomic.h                |  302 ++++
 arch/loongarch/include/asm/barrier.h               |  161 +++
 arch/loongarch/include/asm/bitops.h                |  220 +++
 arch/loongarch/include/asm/bitrev.h                |   34 +
 arch/loongarch/include/asm/boot_param.h            |   91 ++
 arch/loongarch/include/asm/bootinfo.h              |   34 +
 arch/loongarch/include/asm/branch.h                |   21 +
 arch/loongarch/include/asm/bug.h                   |   23 +
 arch/loongarch/include/asm/cache.h                 |   13 +
 arch/loongarch/include/asm/cacheflush.h            |   79 +
 arch/loongarch/include/asm/cacheops.h              |   32 +
 arch/loongarch/include/asm/clocksource.h           |   12 +
 arch/loongarch/include/asm/cmpxchg.h               |  138 ++
 arch/loongarch/include/asm/compiler.h              |   15 +
 arch/loongarch/include/asm/cpu-features.h          |   67 +
 arch/loongarch/include/asm/cpu-info.h              |  136 ++
 arch/loongarch/include/asm/cpu.h                   |  123 ++
 arch/loongarch/include/asm/cpufeature.h            |   24 +
 arch/loongarch/include/asm/delay.h                 |   26 +
 arch/loongarch/include/asm/device.h                |   17 +
 arch/loongarch/include/asm/dma-direct.h            |   11 +
 arch/loongarch/include/asm/dma.h                   |   13 +
 arch/loongarch/include/asm/dmi.h                   |   24 +
 arch/loongarch/include/asm/efi.h                   |   35 +
 arch/loongarch/include/asm/elf.h                   |  308 ++++
 arch/loongarch/include/asm/entry-common.h          |   13 +
 arch/loongarch/include/asm/exec.h                  |   10 +
 arch/loongarch/include/asm/fb.h                    |   23 +
 arch/loongarch/include/asm/fixmap.h                |   15 +
 arch/loongarch/include/asm/fpregdef.h              |   55 +
 arch/loongarch/include/asm/fpu.h                   |  129 ++
 arch/loongarch/include/asm/futex.h                 |  108 ++
 arch/loongarch/include/asm/fw.h                    |   18 +
 arch/loongarch/include/asm/hardirq.h               |   26 +
 arch/loongarch/include/asm/hugetlb.h               |   79 +
 arch/loongarch/include/asm/hw_irq.h                |   17 +
 arch/loongarch/include/asm/idle.h                  |    9 +
 arch/loongarch/include/asm/io.h                    |  126 ++
 arch/loongarch/include/asm/irq.h                   |  102 ++
 arch/loongarch/include/asm/irq_regs.h              |   27 +
 arch/loongarch/include/asm/irqflags.h              |   52 +
 arch/loongarch/include/asm/kdebug.h                |   23 +
 arch/loongarch/include/asm/linkage.h               |   36 +
 arch/loongarch/include/asm/local.h                 |  138 ++
 arch/loongarch/include/asm/loongarch.h             | 1505 ++++++++++++++++++++
 arch/loongarch/include/asm/loongson.h              |  159 +++
 arch/loongarch/include/asm/mmu.h                   |   16 +
 arch/loongarch/include/asm/mmu_context.h           |  151 ++
 arch/loongarch/include/asm/mmzone.h                |   18 +
 arch/loongarch/include/asm/module.h                |   15 +
 arch/loongarch/include/asm/numa.h                  |   69 +
 arch/loongarch/include/asm/page.h                  |  127 ++
 arch/loongarch/include/asm/pci.h                   |   42 +
 arch/loongarch/include/asm/percpu.h                |  222 +++
 arch/loongarch/include/asm/perf_event.h            |   10 +
 arch/loongarch/include/asm/pgalloc.h               |   97 ++
 arch/loongarch/include/asm/pgtable-bits.h          |  139 ++
 arch/loongarch/include/asm/pgtable.h               |  618 ++++++++
 arch/loongarch/include/asm/prefetch.h              |   29 +
 arch/loongarch/include/asm/processor.h             |  209 +++
 arch/loongarch/include/asm/ptrace.h                |  140 ++
 arch/loongarch/include/asm/reboot.h                |   10 +
 arch/loongarch/include/asm/regdef.h                |   43 +
 arch/loongarch/include/asm/serial.h                |   11 +
 arch/loongarch/include/asm/setup.h                 |   25 +
 arch/loongarch/include/asm/shmparam.h              |   12 +
 arch/loongarch/include/asm/smp.h                   |  133 ++
 arch/loongarch/include/asm/sparsemem.h             |   21 +
 arch/loongarch/include/asm/spinlock.h              |   12 +
 arch/loongarch/include/asm/spinlock_types.h        |   11 +
 arch/loongarch/include/asm/stackframe.h            |  241 ++++
 arch/loongarch/include/asm/string.h                |   17 +
 arch/loongarch/include/asm/switch_to.h             |   37 +
 arch/loongarch/include/asm/syscall.h               |   72 +
 arch/loongarch/include/asm/thread_info.h           |  116 ++
 arch/loongarch/include/asm/time.h                  |   50 +
 arch/loongarch/include/asm/timex.h                 |   32 +
 arch/loongarch/include/asm/tlb.h                   |  216 +++
 arch/loongarch/include/asm/tlbflush.h              |   46 +
 arch/loongarch/include/asm/topology.h              |   41 +
 arch/loongarch/include/asm/types.h                 |   33 +
 arch/loongarch/include/asm/uaccess.h               |  327 +++++
 arch/loongarch/include/asm/unistd.h                |   11 +
 arch/loongarch/include/asm/vdso.h                  |   38 +
 arch/loongarch/include/asm/vdso/clocksource.h      |    8 +
 arch/loongarch/include/asm/vdso/gettimeofday.h     |  100 ++
 arch/loongarch/include/asm/vdso/processor.h        |   23 +
 arch/loongarch/include/asm/vdso/vdso.h             |   31 +
 arch/loongarch/include/asm/vdso/vsyscall.h         |   27 +
 arch/loongarch/include/asm/vermagic.h              |   19 +
 arch/loongarch/include/asm/vmalloc.h               |    4 +
 arch/loongarch/include/uapi/asm/Kbuild             |    2 +
 arch/loongarch/include/uapi/asm/abidefs.h          |   21 +
 arch/loongarch/include/uapi/asm/auxvec.h           |   17 +
 arch/loongarch/include/uapi/asm/bitfield.h         |   15 +
 arch/loongarch/include/uapi/asm/bitsperlong.h      |    9 +
 arch/loongarch/include/uapi/asm/break.h            |   23 +
 arch/loongarch/include/uapi/asm/byteorder.h        |   13 +
 arch/loongarch/include/uapi/asm/hwcap.h            |   20 +
 arch/loongarch/include/uapi/asm/ptrace.h           |   50 +
 arch/loongarch/include/uapi/asm/reg.h              |  103 ++
 arch/loongarch/include/uapi/asm/sigcontext.h       |   40 +
 arch/loongarch/include/uapi/asm/swab.h             |   52 +
 arch/loongarch/include/uapi/asm/ucontext.h         |   46 +
 arch/loongarch/include/uapi/asm/unistd.h           |    6 +
 arch/loongarch/kernel/Makefile                     |   28 +
 arch/loongarch/kernel/access-helper.h              |   13 +
 arch/loongarch/kernel/acpi.c                       |  493 +++++++
 arch/loongarch/kernel/asm-offsets.c                |  256 ++++
 arch/loongarch/kernel/boardinfo.c                  |   36 +
 arch/loongarch/kernel/cacheinfo.c                  |  126 ++
 arch/loongarch/kernel/cmdline.c                    |   28 +
 arch/loongarch/kernel/cmpxchg.c                    |  107 ++
 arch/loongarch/kernel/cpu-probe.c                  |  301 ++++
 arch/loongarch/kernel/dma.c                        |   58 +
 arch/loongarch/kernel/efi.c                        |   68 +
 arch/loongarch/kernel/elf.c                        |   41 +
 arch/loongarch/kernel/entry.S                      |   86 ++
 arch/loongarch/kernel/env.c                        |  170 +++
 arch/loongarch/kernel/fpu.S                        |  296 ++++
 arch/loongarch/kernel/genex.S                      |  160 +++
 arch/loongarch/kernel/head.S                       |   91 ++
 arch/loongarch/kernel/idle.c                       |   16 +
 arch/loongarch/kernel/io.c                         |   94 ++
 arch/loongarch/kernel/irq.c                        |  190 +++
 arch/loongarch/kernel/mem.c                        |   85 ++
 arch/loongarch/kernel/module.c                     |  653 +++++++++
 arch/loongarch/kernel/msi.c                        |   38 +
 arch/loongarch/kernel/numa.c                       |  483 +++++++
 arch/loongarch/kernel/proc.c                       |  127 ++
 arch/loongarch/kernel/process.c                    |  273 ++++
 arch/loongarch/kernel/ptrace.c                     |  420 ++++++
 arch/loongarch/kernel/reset.c                      |  102 ++
 arch/loongarch/kernel/rtc.c                        |   36 +
 arch/loongarch/kernel/setup.c                      |  501 +++++++
 arch/loongarch/kernel/signal-common.h              |   38 +
 arch/loongarch/kernel/signal.c                     |  572 ++++++++
 arch/loongarch/kernel/smp.c                        |  900 ++++++++++++
 arch/loongarch/kernel/switch.S                     |   47 +
 arch/loongarch/kernel/syscall.c                    |   80 ++
 arch/loongarch/kernel/time.c                       |  237 +++
 arch/loongarch/kernel/topology.c                   |   57 +
 arch/loongarch/kernel/traps.c                      |  745 ++++++++++
 arch/loongarch/kernel/vdso.c                       |  139 ++
 arch/loongarch/kernel/vmlinux.lds.S                |  115 ++
 arch/loongarch/lib/Makefile                        |    7 +
 arch/loongarch/lib/clear_user.S                    |   43 +
 arch/loongarch/lib/copy_user.S                     |   47 +
 arch/loongarch/lib/delay.c                         |   43 +
 arch/loongarch/lib/dump_tlb.c                      |  107 ++
 arch/loongarch/lib/memcpy.S                        |   32 +
 arch/loongarch/lib/memmove.S                       |   45 +
 arch/loongarch/lib/memset.S                        |   30 +
 arch/loongarch/lib/strncpy_user.S                  |   51 +
 arch/loongarch/lib/strnlen_user.S                  |   47 +
 arch/loongarch/mm/Makefile                         |    9 +
 arch/loongarch/mm/cache.c                          |  153 ++
 arch/loongarch/mm/extable.c                        |   22 +
 arch/loongarch/mm/fault.c                          |  248 ++++
 arch/loongarch/mm/hugetlbpage.c                    |   87 ++
 arch/loongarch/mm/init.c                           |  227 +++
 arch/loongarch/mm/ioremap.c                        |   27 +
 arch/loongarch/mm/maccess.c                        |   10 +
 arch/loongarch/mm/mmap.c                           |  125 ++
 arch/loongarch/mm/page.S                           |   84 ++
 arch/loongarch/mm/pgtable.c                        |  132 ++
 arch/loongarch/mm/tlb.c                            |  286 ++++
 arch/loongarch/mm/tlbex.S                          |  537 +++++++
 arch/loongarch/pci/Makefile                        |    7 +
 arch/loongarch/pci/acpi.c                          |  176 +++
 arch/loongarch/pci/pci.c                           |  195 +++
 arch/loongarch/vdso/Makefile                       |   96 ++
 arch/loongarch/vdso/elf.S                          |   15 +
 arch/loongarch/vdso/gen_vdso_offsets.sh            |   14 +
 arch/loongarch/vdso/sigreturn.S                    |   24 +
 arch/loongarch/vdso/vdso.S                         |   22 +
 arch/loongarch/vdso/vdso.lds.S                     |   72 +
 arch/loongarch/vdso/vgettimeofday.c                |   26 +
 drivers/gpu/drm/drm_vm.c                           |    2 +-
 drivers/gpu/drm/ttm/ttm_module.c                   |    2 +-
 include/drm/drm_cache.h                            |    8 +
 include/linux/cpuhotplug.h                         |    1 +
 include/uapi/linux/audit.h                         |    2 +
 include/uapi/linux/elf-em.h                        |    1 +
 include/uapi/linux/elf.h                           |    5 +
 include/uapi/linux/kexec.h                         |    1 +
 scripts/sorttable.c                                |    5 +
 scripts/subarch.include                            |    2 +-
 213 files changed, 23197 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/loongarch/features.rst
 create mode 100644 Documentation/loongarch/index.rst
 create mode 100644 Documentation/loongarch/introduction.rst
 create mode 100644 Documentation/loongarch/irq-chip-model.rst
 create mode 100644 Documentation/translations/zh_CN/loongarch/features.rst
 create mode 100644 Documentation/translations/zh_CN/loongarch/index.rst
 create mode 100644 Documentation/translations/zh_CN/loongarch/introduction.rst
 create mode 100644 Documentation/translations/zh_CN/loongarch/irq-chip-model.rst
 create mode 100644 arch/loongarch/.gitignore
 create mode 100644 arch/loongarch/Kbuild
 create mode 100644 arch/loongarch/Kconfig
 create mode 100644 arch/loongarch/Kconfig.debug
 create mode 100644 arch/loongarch/Makefile
 create mode 100644 arch/loongarch/configs/loongson3_defconfig
 create mode 100644 arch/loongarch/include/asm/Kbuild
 create mode 100644 arch/loongarch/include/asm/abi.h
 create mode 100644 arch/loongarch/include/asm/acenv.h
 create mode 100644 arch/loongarch/include/asm/acpi.h
 create mode 100644 arch/loongarch/include/asm/addrspace.h
 create mode 100644 arch/loongarch/include/asm/asm-offsets.h
 create mode 100644 arch/loongarch/include/asm/asm-prototypes.h
 create mode 100644 arch/loongarch/include/asm/asm.h
 create mode 100644 arch/loongarch/include/asm/asmmacro.h
 create mode 100644 arch/loongarch/include/asm/atomic.h
 create mode 100644 arch/loongarch/include/asm/barrier.h
 create mode 100644 arch/loongarch/include/asm/bitops.h
 create mode 100644 arch/loongarch/include/asm/bitrev.h
 create mode 100644 arch/loongarch/include/asm/boot_param.h
 create mode 100644 arch/loongarch/include/asm/bootinfo.h
 create mode 100644 arch/loongarch/include/asm/branch.h
 create mode 100644 arch/loongarch/include/asm/bug.h
 create mode 100644 arch/loongarch/include/asm/cache.h
 create mode 100644 arch/loongarch/include/asm/cacheflush.h
 create mode 100644 arch/loongarch/include/asm/cacheops.h
 create mode 100644 arch/loongarch/include/asm/clocksource.h
 create mode 100644 arch/loongarch/include/asm/cmpxchg.h
 create mode 100644 arch/loongarch/include/asm/compiler.h
 create mode 100644 arch/loongarch/include/asm/cpu-features.h
 create mode 100644 arch/loongarch/include/asm/cpu-info.h
 create mode 100644 arch/loongarch/include/asm/cpu.h
 create mode 100644 arch/loongarch/include/asm/cpufeature.h
 create mode 100644 arch/loongarch/include/asm/delay.h
 create mode 100644 arch/loongarch/include/asm/device.h
 create mode 100644 arch/loongarch/include/asm/dma-direct.h
 create mode 100644 arch/loongarch/include/asm/dma.h
 create mode 100644 arch/loongarch/include/asm/dmi.h
 create mode 100644 arch/loongarch/include/asm/efi.h
 create mode 100644 arch/loongarch/include/asm/elf.h
 create mode 100644 arch/loongarch/include/asm/entry-common.h
 create mode 100644 arch/loongarch/include/asm/exec.h
 create mode 100644 arch/loongarch/include/asm/fb.h
 create mode 100644 arch/loongarch/include/asm/fixmap.h
 create mode 100644 arch/loongarch/include/asm/fpregdef.h
 create mode 100644 arch/loongarch/include/asm/fpu.h
 create mode 100644 arch/loongarch/include/asm/futex.h
 create mode 100644 arch/loongarch/include/asm/fw.h
 create mode 100644 arch/loongarch/include/asm/hardirq.h
 create mode 100644 arch/loongarch/include/asm/hugetlb.h
 create mode 100644 arch/loongarch/include/asm/hw_irq.h
 create mode 100644 arch/loongarch/include/asm/idle.h
 create mode 100644 arch/loongarch/include/asm/io.h
 create mode 100644 arch/loongarch/include/asm/irq.h
 create mode 100644 arch/loongarch/include/asm/irq_regs.h
 create mode 100644 arch/loongarch/include/asm/irqflags.h
 create mode 100644 arch/loongarch/include/asm/kdebug.h
 create mode 100644 arch/loongarch/include/asm/linkage.h
 create mode 100644 arch/loongarch/include/asm/local.h
 create mode 100644 arch/loongarch/include/asm/loongarch.h
 create mode 100644 arch/loongarch/include/asm/loongson.h
 create mode 100644 arch/loongarch/include/asm/mmu.h
 create mode 100644 arch/loongarch/include/asm/mmu_context.h
 create mode 100644 arch/loongarch/include/asm/mmzone.h
 create mode 100644 arch/loongarch/include/asm/module.h
 create mode 100644 arch/loongarch/include/asm/numa.h
 create mode 100644 arch/loongarch/include/asm/page.h
 create mode 100644 arch/loongarch/include/asm/pci.h
 create mode 100644 arch/loongarch/include/asm/percpu.h
 create mode 100644 arch/loongarch/include/asm/perf_event.h
 create mode 100644 arch/loongarch/include/asm/pgalloc.h
 create mode 100644 arch/loongarch/include/asm/pgtable-bits.h
 create mode 100644 arch/loongarch/include/asm/pgtable.h
 create mode 100644 arch/loongarch/include/asm/prefetch.h
 create mode 100644 arch/loongarch/include/asm/processor.h
 create mode 100644 arch/loongarch/include/asm/ptrace.h
 create mode 100644 arch/loongarch/include/asm/reboot.h
 create mode 100644 arch/loongarch/include/asm/regdef.h
 create mode 100644 arch/loongarch/include/asm/serial.h
 create mode 100644 arch/loongarch/include/asm/setup.h
 create mode 100644 arch/loongarch/include/asm/shmparam.h
 create mode 100644 arch/loongarch/include/asm/smp.h
 create mode 100644 arch/loongarch/include/asm/sparsemem.h
 create mode 100644 arch/loongarch/include/asm/spinlock.h
 create mode 100644 arch/loongarch/include/asm/spinlock_types.h
 create mode 100644 arch/loongarch/include/asm/stackframe.h
 create mode 100644 arch/loongarch/include/asm/string.h
 create mode 100644 arch/loongarch/include/asm/switch_to.h
 create mode 100644 arch/loongarch/include/asm/syscall.h
 create mode 100644 arch/loongarch/include/asm/thread_info.h
 create mode 100644 arch/loongarch/include/asm/time.h
 create mode 100644 arch/loongarch/include/asm/timex.h
 create mode 100644 arch/loongarch/include/asm/tlb.h
 create mode 100644 arch/loongarch/include/asm/tlbflush.h
 create mode 100644 arch/loongarch/include/asm/topology.h
 create mode 100644 arch/loongarch/include/asm/types.h
 create mode 100644 arch/loongarch/include/asm/uaccess.h
 create mode 100644 arch/loongarch/include/asm/unistd.h
 create mode 100644 arch/loongarch/include/asm/vdso.h
 create mode 100644 arch/loongarch/include/asm/vdso/clocksource.h
 create mode 100644 arch/loongarch/include/asm/vdso/gettimeofday.h
 create mode 100644 arch/loongarch/include/asm/vdso/processor.h
 create mode 100644 arch/loongarch/include/asm/vdso/vdso.h
 create mode 100644 arch/loongarch/include/asm/vdso/vsyscall.h
 create mode 100644 arch/loongarch/include/asm/vermagic.h
 create mode 100644 arch/loongarch/include/asm/vmalloc.h
 create mode 100644 arch/loongarch/include/uapi/asm/Kbuild
 create mode 100644 arch/loongarch/include/uapi/asm/abidefs.h
 create mode 100644 arch/loongarch/include/uapi/asm/auxvec.h
 create mode 100644 arch/loongarch/include/uapi/asm/bitfield.h
 create mode 100644 arch/loongarch/include/uapi/asm/bitsperlong.h
 create mode 100644 arch/loongarch/include/uapi/asm/break.h
 create mode 100644 arch/loongarch/include/uapi/asm/byteorder.h
 create mode 100644 arch/loongarch/include/uapi/asm/hwcap.h
 create mode 100644 arch/loongarch/include/uapi/asm/ptrace.h
 create mode 100644 arch/loongarch/include/uapi/asm/reg.h
 create mode 100644 arch/loongarch/include/uapi/asm/sigcontext.h
 create mode 100644 arch/loongarch/include/uapi/asm/swab.h
 create mode 100644 arch/loongarch/include/uapi/asm/ucontext.h
 create mode 100644 arch/loongarch/include/uapi/asm/unistd.h
 create mode 100644 arch/loongarch/kernel/Makefile
 create mode 100644 arch/loongarch/kernel/access-helper.h
 create mode 100644 arch/loongarch/kernel/acpi.c
 create mode 100644 arch/loongarch/kernel/asm-offsets.c
 create mode 100644 arch/loongarch/kernel/boardinfo.c
 create mode 100644 arch/loongarch/kernel/cacheinfo.c
 create mode 100644 arch/loongarch/kernel/cmdline.c
 create mode 100644 arch/loongarch/kernel/cmpxchg.c
 create mode 100644 arch/loongarch/kernel/cpu-probe.c
 create mode 100644 arch/loongarch/kernel/dma.c
 create mode 100644 arch/loongarch/kernel/efi.c
 create mode 100644 arch/loongarch/kernel/elf.c
 create mode 100644 arch/loongarch/kernel/entry.S
 create mode 100644 arch/loongarch/kernel/env.c
 create mode 100644 arch/loongarch/kernel/fpu.S
 create mode 100644 arch/loongarch/kernel/genex.S
 create mode 100644 arch/loongarch/kernel/head.S
 create mode 100644 arch/loongarch/kernel/idle.c
 create mode 100644 arch/loongarch/kernel/io.c
 create mode 100644 arch/loongarch/kernel/irq.c
 create mode 100644 arch/loongarch/kernel/mem.c
 create mode 100644 arch/loongarch/kernel/module.c
 create mode 100644 arch/loongarch/kernel/msi.c
 create mode 100644 arch/loongarch/kernel/numa.c
 create mode 100644 arch/loongarch/kernel/proc.c
 create mode 100644 arch/loongarch/kernel/process.c
 create mode 100644 arch/loongarch/kernel/ptrace.c
 create mode 100644 arch/loongarch/kernel/reset.c
 create mode 100644 arch/loongarch/kernel/rtc.c
 create mode 100644 arch/loongarch/kernel/setup.c
 create mode 100644 arch/loongarch/kernel/signal-common.h
 create mode 100644 arch/loongarch/kernel/signal.c
 create mode 100644 arch/loongarch/kernel/smp.c
 create mode 100644 arch/loongarch/kernel/switch.S
 create mode 100644 arch/loongarch/kernel/syscall.c
 create mode 100644 arch/loongarch/kernel/time.c
 create mode 100644 arch/loongarch/kernel/topology.c
 create mode 100644 arch/loongarch/kernel/traps.c
 create mode 100644 arch/loongarch/kernel/vdso.c
 create mode 100644 arch/loongarch/kernel/vmlinux.lds.S
 create mode 100644 arch/loongarch/lib/Makefile
 create mode 100644 arch/loongarch/lib/clear_user.S
 create mode 100644 arch/loongarch/lib/copy_user.S
 create mode 100644 arch/loongarch/lib/delay.c
 create mode 100644 arch/loongarch/lib/dump_tlb.c
 create mode 100644 arch/loongarch/lib/memcpy.S
 create mode 100644 arch/loongarch/lib/memmove.S
 create mode 100644 arch/loongarch/lib/memset.S
 create mode 100644 arch/loongarch/lib/strncpy_user.S
 create mode 100644 arch/loongarch/lib/strnlen_user.S
 create mode 100644 arch/loongarch/mm/Makefile
 create mode 100644 arch/loongarch/mm/cache.c
 create mode 100644 arch/loongarch/mm/extable.c
 create mode 100644 arch/loongarch/mm/fault.c
 create mode 100644 arch/loongarch/mm/hugetlbpage.c
 create mode 100644 arch/loongarch/mm/init.c
 create mode 100644 arch/loongarch/mm/ioremap.c
 create mode 100644 arch/loongarch/mm/maccess.c
 create mode 100644 arch/loongarch/mm/mmap.c
 create mode 100644 arch/loongarch/mm/page.S
 create mode 100644 arch/loongarch/mm/pgtable.c
 create mode 100644 arch/loongarch/mm/tlb.c
 create mode 100644 arch/loongarch/mm/tlbex.S
 create mode 100644 arch/loongarch/pci/Makefile
 create mode 100644 arch/loongarch/pci/acpi.c
 create mode 100644 arch/loongarch/pci/pci.c
 create mode 100644 arch/loongarch/vdso/Makefile
 create mode 100644 arch/loongarch/vdso/elf.S
 create mode 100755 arch/loongarch/vdso/gen_vdso_offsets.sh
 create mode 100644 arch/loongarch/vdso/sigreturn.S
 create mode 100644 arch/loongarch/vdso/vdso.S
 create mode 100644 arch/loongarch/vdso/vdso.lds.S
 create mode 100644 arch/loongarch/vdso/vgettimeofday.c
--
2.27.0

