Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D816F53D193
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jun 2022 20:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347188AbiFCSf4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Jun 2022 14:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347617AbiFCSfm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Jun 2022 14:35:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08FD3191D;
        Fri,  3 Jun 2022 11:26:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F5F4B8244D;
        Fri,  3 Jun 2022 18:26:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2926FC385A9;
        Fri,  3 Jun 2022 18:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654280796;
        bh=DmNeGYRgdIk2MwJeFQveKNzQ11AszHchqK+mIA12nOI=;
        h=From:Date:Subject:To:Cc:From;
        b=VRfIOmC6K/PW9e7Ik4oMU2U5GiNBqkMhAp6ho0Sxc2CGSPtzRTOIhJNn1Cqok4hlu
         QQlFHxheqIe9NrahbcBkgRCPYj8M8nym8Fb6wWD94TPrl8Gn/XcMZ4ZhZDLt5ZWgUw
         z+WzXRJDK2w0H7cDMrq/OVYbLcJESL6/1VCAKltvuOb6p+boHaGBgFArpDCFUjoi1f
         f7/JUZXpn7zcVssDJJA4dZHuV+hhHUwP5sRL07KOk27WhsBGaBu0lHebYZD4vWMrw+
         5tV5x278qRj/LvXzqH1W5uB6QbL5igjpCORJqSQ4I46g5GX/4lBKYeyNVHVGRQsUX0
         PcsQ7i8iPWWfg==
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-2ef5380669cso90528427b3.9;
        Fri, 03 Jun 2022 11:26:36 -0700 (PDT)
X-Gm-Message-State: AOAM530M7j2aL8eA2NwOidvI8rfubxMeHCJb8JlO41G5J8B1Ydye+k5A
        GBHcc2f2QG7JxD9ddIaMA7m9bl1YxHwpKcQH9es=
X-Google-Smtp-Source: ABdhPJxjzzGIWFvLLwYeqpJ+SZSJHu8qWBTaEk9slzEmB0MGrjSr911mEPT6Nj0elmP22g+F0yENiZ5YM8dvVavY4Nc=
X-Received: by 2002:a81:745:0:b0:30f:b172:9efb with SMTP id
 66-20020a810745000000b0030fb1729efbmr13180327ywh.495.1654280795080; Fri, 03
 Jun 2022 11:26:35 -0700 (PDT)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 3 Jun 2022 20:26:18 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3LTdjqNRuqdWg126Ndmh11FDn6yo5DpR5nYZpZbxtg7w@mail.gmail.com>
Message-ID: <CAK8P3a3LTdjqNRuqdWg126Ndmh11FDn6yo5DpR5nYZpZbxtg7w@mail.gmail.com>
Subject: [GIT PULL] Add partial Loongarch architecture code
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Xuerui Wang <kernel@xen0n.name>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following changes since commit 50fd82b3a9a9335df5d50c7ddcb81c81d358c4fc:

  Merge tag 'docs-5.19-2' of git://git.lwn.net/linux (2022-06-02 15:36:06 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
tags/loongarch-5.19

for you to fetch changes up to 8be4493119b0aedf7dd61e1ca520fb398537b53e:

  MAINTAINERS: Add maintainer information for LoongArch (2022-06-03
20:09:29 +0800)

[ Side note: All the contents in this branch look fine to me and I think we are
 better off with them in 5.19 than later, mainly because it allows merging the
 glibc port sooner. On the other hand, the way here has been somewhat irregular
 and rushed, and as explained in the tag it doesn't  actually boot. If
you have any
 doubts about the submission, it can obviously wait for another release and get
 done properly then. - Arnd ]

----------------------------------------------------------------
Add partial Loongarch architecture code

This is the majority of the loongarch architecture code, including
the final system call interface and all core functionality.

It still misses three sets of peripheral but vital patches to add
support for other subsystems, which have yet to pass review:

 - The drivers/firmware/efi stub for booting from a standard UEFI
   firmware implementation. Both the original custom boot interface
   and a draft implementation of the EFI stub did not make it, so
   it is currently impossible to boot the kernel, until the
   loongarch specific portions get accepted into the UEFI subsystem

 - The drivers/irqchip/irq-loongson-*.c drivers are shared with the
   MIPS port, but currently lack support for ACPI based booting,
   which will get merged through the irqchip subsystem.

 - Similarly, the drivers/pci/controller/pci-loongson.c needs to be
   modified for ACPI support, which will be merged through the
   PCI subsystem.

While the port cannot actually be used before all the above are
merged, having it in 5.19 helps to establish the user space ABI
for the libc ports to build on, and to help any treewide changes
in the mainline kernel get applied here as well. A gcc-12 based
tool chains for build testing is now included in
https://mirrors.edge.kernel.org/pub/tools/crosstool/.

Original description from Huacai Chen at
https://lore.kernel.org/lkml/20220603072053.35005-1-chenhuacai@loongson.cn/:

 "LoongArch is a new RISC ISA, which is a bit like MIPS or RISC-V.
  LoongArch includes a reduced 32-bit version (LA32R), a standard 32-bit
  version (LA32S) and a 64-bit version (LA64). LoongArch use ACPI as its
  boot protocol LoongArch-specific interrupt controllers (similar to APIC)
  are already added in the next revision of ACPI Specification (current
  revision is 6.4).

  This patchset is adding basic LoongArch support in mainline kernel, we
  can see a complete snapshot here:
  https://github.com/loongson/linux/tree/loongarch-next
  https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git/log/?h=loongarch-next

  Cross-compile tool chain to build kernel:
  https://github.com/loongson/build-tools/releases/download/2021.12.21/loongarch64-clfs-2022-03-03-cross-tools-gcc-glibc.tar.xz

  A CLFS-based Linux distro:
  https://github.com/loongson/build-tools/releases/download/2021.12.21/loongarch64-clfs-system-2022-03-03.tar.bz2

  Open-source tool chain which is under review (Binutils and Gcc are
already upstream):
  https://github.com/loongson/binutils-gdb/tree/upstream_v3.1
  https://github.com/loongson/gcc/tree/loongarch_upstream_v6.3
  https://github.com/loongson/glibc/tree/loongarch_2_35_dev_v2.2

  Loongson and LoongArch documentations:
  https://github.com/loongson/LoongArch-Documentation

  LoongArch-specific interrupt controllers:
  https://mantis.uefi.org/mantis/view.php?id=2203
  https://mantis.uefi.org/mantis/view.php?id=2313"

----------------------------------------------------------------
Huacai Chen (24):
      irqchip: Adjust Kconfig for Loongson
      irqchip/loongson-liointc: Fix build error for LoongArch
      Documentation: LoongArch: Add basic documentations
      Documentation/zh_CN: Add basic LoongArch documentations
      LoongArch: Add ELF-related definitions
      LoongArch: Add writecombine support for drm
      LoongArch: Add build infrastructure
      LoongArch: Add CPU definition headers
      LoongArch: Add atomic/locking headers
      LoongArch: Add other common headers
      LoongArch: Add boot and setup routines
      LoongArch: Add exception/interrupt handling
      LoongArch: Add process management
      LoongArch: Add memory management
      LoongArch: Add system call support
      LoongArch: Add signal handling support
      LoongArch: Add ELF and module support
      LoongArch: Add misc common routines
      LoongArch: Add some library functions
      LoongArch: Add VDSO and VSYSCALL support
      LoongArch: Add multi-processor (SMP) support
      LoongArch: Add Non-Uniform Memory Access (NUMA) support
      LoongArch: Add Loongson-3 default config file
      MAINTAINERS: Add maintainer information for LoongArch

 Documentation/arch.rst                             |    1 +
 Documentation/loongarch/features.rst               |    3 +
 Documentation/loongarch/index.rst                  |   21 +
 Documentation/loongarch/introduction.rst           |  387 +++++
 Documentation/loongarch/irq-chip-model.rst         |  156 ++
 Documentation/translations/zh_CN/index.rst         |    1 +
 .../translations/zh_CN/loongarch/features.rst      |    8 +
 .../translations/zh_CN/loongarch/index.rst         |   26 +
 .../translations/zh_CN/loongarch/introduction.rst  |  351 +++++
 .../zh_CN/loongarch/irq-chip-model.rst             |  155 ++
 MAINTAINERS                                        |   10 +
 arch/loongarch/Kbuild                              |    6 +
 arch/loongarch/Kconfig                             |  438 ++++++
 arch/loongarch/Kconfig.debug                       |    0
 arch/loongarch/Makefile                            |  100 ++
 arch/loongarch/boot/.gitignore                     |    2 +
 arch/loongarch/boot/Makefile                       |   16 +
 arch/loongarch/boot/dts/Makefile                   |    4 +
 arch/loongarch/configs/loongson3_defconfig         |  771 ++++++++++
 arch/loongarch/include/asm/Kbuild                  |   30 +
 arch/loongarch/include/asm/acenv.h                 |   18 +
 arch/loongarch/include/asm/acpi.h                  |   38 +
 arch/loongarch/include/asm/addrspace.h             |  112 ++
 arch/loongarch/include/asm/asm-offsets.h           |    5 +
 arch/loongarch/include/asm/asm-prototypes.h        |    7 +
 arch/loongarch/include/asm/asm.h                   |  191 +++
 arch/loongarch/include/asm/asmmacro.h              |  289 ++++
 arch/loongarch/include/asm/atomic.h                |  362 +++++
 arch/loongarch/include/asm/barrier.h               |  159 ++
 arch/loongarch/include/asm/bitops.h                |   33 +
 arch/loongarch/include/asm/bitrev.h                |   34 +
 arch/loongarch/include/asm/bootinfo.h              |   43 +
 arch/loongarch/include/asm/branch.h                |   21 +
 arch/loongarch/include/asm/bug.h                   |   23 +
 arch/loongarch/include/asm/cache.h                 |   13 +
 arch/loongarch/include/asm/cacheflush.h            |   80 ++
 arch/loongarch/include/asm/cacheops.h              |   37 +
 arch/loongarch/include/asm/clocksource.h           |   12 +
 arch/loongarch/include/asm/cmpxchg.h               |  123 ++
 arch/loongarch/include/asm/compiler.h              |   15 +
 arch/loongarch/include/asm/cpu-features.h          |   73 +
 arch/loongarch/include/asm/cpu-info.h              |  116 ++
 arch/loongarch/include/asm/cpu.h                   |  127 ++
 arch/loongarch/include/asm/cpufeature.h            |   24 +
 arch/loongarch/include/asm/delay.h                 |   26 +
 arch/loongarch/include/asm/dma-direct.h            |   11 +
 arch/loongarch/include/asm/dmi.h                   |   24 +
 arch/loongarch/include/asm/efi.h                   |   41 +
 arch/loongarch/include/asm/elf.h                   |  301 ++++
 arch/loongarch/include/asm/entry-common.h          |   13 +
 arch/loongarch/include/asm/exec.h                  |   10 +
 arch/loongarch/include/asm/fb.h                    |   23 +
 arch/loongarch/include/asm/fixmap.h                |   13 +
 arch/loongarch/include/asm/fpregdef.h              |   53 +
 arch/loongarch/include/asm/fpu.h                   |  129 ++
 arch/loongarch/include/asm/futex.h                 |  108 ++
 arch/loongarch/include/asm/hardirq.h               |   26 +
 arch/loongarch/include/asm/hugetlb.h               |   83 ++
 arch/loongarch/include/asm/hw_irq.h                |   17 +
 arch/loongarch/include/asm/idle.h                  |    9 +
 arch/loongarch/include/asm/inst.h                  |  117 ++
 arch/loongarch/include/asm/io.h                    |  129 ++
 arch/loongarch/include/asm/irq.h                   |  132 ++
 arch/loongarch/include/asm/irq_regs.h              |   27 +
 arch/loongarch/include/asm/irqflags.h              |   78 +
 arch/loongarch/include/asm/kdebug.h                |   23 +
 arch/loongarch/include/asm/linkage.h               |   36 +
 arch/loongarch/include/asm/local.h                 |  138 ++
 arch/loongarch/include/asm/loongarch.h             | 1516 ++++++++++++++++++++
 arch/loongarch/include/asm/loongson.h              |  153 ++
 arch/loongarch/include/asm/mmu.h                   |   16 +
 arch/loongarch/include/asm/mmu_context.h           |  152 ++
 arch/loongarch/include/asm/mmzone.h                |   18 +
 arch/loongarch/include/asm/module.h                |   80 ++
 arch/loongarch/include/asm/module.lds.h            |    7 +
 arch/loongarch/include/asm/numa.h                  |   67 +
 arch/loongarch/include/asm/page.h                  |  115 ++
 arch/loongarch/include/asm/percpu.h                |  214 +++
 arch/loongarch/include/asm/perf_event.h            |   10 +
 arch/loongarch/include/asm/pgalloc.h               |  103 ++
 arch/loongarch/include/asm/pgtable-bits.h          |  131 ++
 arch/loongarch/include/asm/pgtable.h               |  565 ++++++++
 arch/loongarch/include/asm/prefetch.h              |   29 +
 arch/loongarch/include/asm/processor.h             |  209 +++
 arch/loongarch/include/asm/ptrace.h                |  152 ++
 arch/loongarch/include/asm/reboot.h                |   10 +
 arch/loongarch/include/asm/regdef.h                |   41 +
 arch/loongarch/include/asm/seccomp.h               |   20 +
 arch/loongarch/include/asm/serial.h                |   11 +
 arch/loongarch/include/asm/setup.h                 |   21 +
 arch/loongarch/include/asm/shmparam.h              |   12 +
 arch/loongarch/include/asm/smp.h                   |  124 ++
 arch/loongarch/include/asm/sparsemem.h             |   23 +
 arch/loongarch/include/asm/stackframe.h            |  219 +++
 arch/loongarch/include/asm/stacktrace.h            |   74 +
 arch/loongarch/include/asm/string.h                |   12 +
 arch/loongarch/include/asm/switch_to.h             |   37 +
 arch/loongarch/include/asm/syscall.h               |   74 +
 arch/loongarch/include/asm/thread_info.h           |  106 ++
 arch/loongarch/include/asm/time.h                  |   50 +
 arch/loongarch/include/asm/timex.h                 |   33 +
 arch/loongarch/include/asm/tlb.h                   |  180 +++
 arch/loongarch/include/asm/tlbflush.h              |   48 +
 arch/loongarch/include/asm/topology.h              |   41 +
 arch/loongarch/include/asm/types.h                 |   19 +
 arch/loongarch/include/asm/uaccess.h               |  269 ++++
 arch/loongarch/include/asm/unistd.h                |   11 +
 arch/loongarch/include/asm/vdso.h                  |   38 +
 arch/loongarch/include/asm/vdso/clocksource.h      |    8 +
 arch/loongarch/include/asm/vdso/gettimeofday.h     |   99 ++
 arch/loongarch/include/asm/vdso/processor.h        |   14 +
 arch/loongarch/include/asm/vdso/vdso.h             |   30 +
 arch/loongarch/include/asm/vdso/vsyscall.h         |   27 +
 arch/loongarch/include/asm/vermagic.h              |   19 +
 arch/loongarch/include/asm/vmalloc.h               |    4 +
 arch/loongarch/include/uapi/asm/Kbuild             |    2 +
 arch/loongarch/include/uapi/asm/auxvec.h           |   17 +
 arch/loongarch/include/uapi/asm/bitsperlong.h      |    9 +
 arch/loongarch/include/uapi/asm/break.h            |   23 +
 arch/loongarch/include/uapi/asm/byteorder.h        |   13 +
 arch/loongarch/include/uapi/asm/hwcap.h            |   20 +
 arch/loongarch/include/uapi/asm/ptrace.h           |   52 +
 arch/loongarch/include/uapi/asm/reg.h              |   59 +
 arch/loongarch/include/uapi/asm/sigcontext.h       |   44 +
 arch/loongarch/include/uapi/asm/signal.h           |   13 +
 arch/loongarch/include/uapi/asm/ucontext.h         |   35 +
 arch/loongarch/include/uapi/asm/unistd.h           |    5 +
 arch/loongarch/kernel/.gitignore                   |    2 +
 arch/loongarch/kernel/Makefile                     |   25 +
 arch/loongarch/kernel/access-helper.h              |   13 +
 arch/loongarch/kernel/acpi.c                       |  333 +++++
 arch/loongarch/kernel/asm-offsets.c                |  264 ++++
 arch/loongarch/kernel/cacheinfo.c                  |  122 ++
 arch/loongarch/kernel/cpu-probe.c                  |  292 ++++
 arch/loongarch/kernel/dma.c                        |   40 +
 arch/loongarch/kernel/efi.c                        |   72 +
 arch/loongarch/kernel/elf.c                        |   30 +
 arch/loongarch/kernel/entry.S                      |   89 ++
 arch/loongarch/kernel/env.c                        |  101 ++
 arch/loongarch/kernel/fpu.S                        |  261 ++++
 arch/loongarch/kernel/genex.S                      |   95 ++
 arch/loongarch/kernel/head.S                       |   98 ++
 arch/loongarch/kernel/idle.c                       |   16 +
 arch/loongarch/kernel/inst.c                       |   40 +
 arch/loongarch/kernel/io.c                         |   94 ++
 arch/loongarch/kernel/irq.c                        |   88 ++
 arch/loongarch/kernel/mem.c                        |   64 +
 arch/loongarch/kernel/module-sections.c            |  121 ++
 arch/loongarch/kernel/module.c                     |  375 +++++
 arch/loongarch/kernel/numa.c                       |  466 ++++++
 arch/loongarch/kernel/proc.c                       |  127 ++
 arch/loongarch/kernel/process.c                    |  267 ++++
 arch/loongarch/kernel/ptrace.c                     |  431 ++++++
 arch/loongarch/kernel/reset.c                      |  102 ++
 arch/loongarch/kernel/setup.c                      |  374 +++++
 arch/loongarch/kernel/signal.c                     |  566 ++++++++
 arch/loongarch/kernel/smp.c                        |  751 ++++++++++
 arch/loongarch/kernel/switch.S                     |   35 +
 arch/loongarch/kernel/syscall.c                    |   63 +
 arch/loongarch/kernel/time.c                       |  214 +++
 arch/loongarch/kernel/topology.c                   |   52 +
 arch/loongarch/kernel/traps.c                      |  725 ++++++++++
 arch/loongarch/kernel/vdso.c                       |  138 ++
 arch/loongarch/kernel/vmlinux.lds.S                |  120 ++
 arch/loongarch/lib/Makefile                        |    6 +
 arch/loongarch/lib/clear_user.S                    |   43 +
 arch/loongarch/lib/copy_user.S                     |   47 +
 arch/loongarch/lib/delay.c                         |   43 +
 arch/loongarch/lib/dump_tlb.c                      |  111 ++
 arch/loongarch/mm/Makefile                         |    9 +
 arch/loongarch/mm/cache.c                          |  141 ++
 arch/loongarch/mm/extable.c                        |   22 +
 arch/loongarch/mm/fault.c                          |  261 ++++
 arch/loongarch/mm/hugetlbpage.c                    |   87 ++
 arch/loongarch/mm/init.c                           |  178 +++
 arch/loongarch/mm/ioremap.c                        |   27 +
 arch/loongarch/mm/maccess.c                        |   10 +
 arch/loongarch/mm/mmap.c                           |  125 ++
 arch/loongarch/mm/page.S                           |   84 ++
 arch/loongarch/mm/pgtable.c                        |  130 ++
 arch/loongarch/mm/tlb.c                            |  305 ++++
 arch/loongarch/mm/tlbex.S                          |  546 +++++++
 arch/loongarch/pci/Makefile                        |    7 +
 arch/loongarch/vdso/.gitignore                     |    2 +
 arch/loongarch/vdso/Makefile                       |   96 ++
 arch/loongarch/vdso/elf.S                          |   15 +
 arch/loongarch/vdso/gen_vdso_offsets.sh            |   13 +
 arch/loongarch/vdso/sigreturn.S                    |   24 +
 arch/loongarch/vdso/vdso.S                         |   22 +
 arch/loongarch/vdso/vdso.lds.S                     |   72 +
 arch/loongarch/vdso/vgettimeofday.c                |   25 +
 drivers/gpu/drm/drm_vm.c                           |    2 +-
 drivers/gpu/drm/ttm/ttm_module.c                   |    2 +-
 drivers/irqchip/Kconfig                            |    6 +-
 drivers/irqchip/irq-loongson-liointc.c             |    6 +-
 include/drm/drm_cache.h                            |    8 +
 include/linux/cpuhotplug.h                         |    1 +
 include/uapi/linux/audit.h                         |    2 +
 include/uapi/linux/elf-em.h                        |    1 +
 include/uapi/linux/elf.h                           |    5 +
 include/uapi/linux/kexec.h                         |    1 +
 scripts/sorttable.c                                |    5 +
 scripts/subarch.include                            |    2 +-
 tools/include/uapi/asm/bitsperlong.h               |    2 +
 204 files changed, 21064 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/loongarch/features.rst
 create mode 100644 Documentation/loongarch/index.rst
 create mode 100644 Documentation/loongarch/introduction.rst
 create mode 100644 Documentation/loongarch/irq-chip-model.rst
 create mode 100644 Documentation/translations/zh_CN/loongarch/features.rst
 create mode 100644 Documentation/translations/zh_CN/loongarch/index.rst
 create mode 100644 Documentation/translations/zh_CN/loongarch/introduction.rst
 create mode 100644
Documentation/translations/zh_CN/loongarch/irq-chip-model.rst
 create mode 100644 arch/loongarch/Kbuild
 create mode 100644 arch/loongarch/Kconfig
 create mode 100644 arch/loongarch/Kconfig.debug
 create mode 100644 arch/loongarch/Makefile
 create mode 100644 arch/loongarch/boot/.gitignore
 create mode 100644 arch/loongarch/boot/Makefile
 create mode 100644 arch/loongarch/boot/dts/Makefile
 create mode 100644 arch/loongarch/configs/loongson3_defconfig
 create mode 100644 arch/loongarch/include/asm/Kbuild
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
 create mode 100644 arch/loongarch/include/asm/dma-direct.h
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
 create mode 100644 arch/loongarch/include/asm/hardirq.h
 create mode 100644 arch/loongarch/include/asm/hugetlb.h
 create mode 100644 arch/loongarch/include/asm/hw_irq.h
 create mode 100644 arch/loongarch/include/asm/idle.h
 create mode 100644 arch/loongarch/include/asm/inst.h
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
 create mode 100644 arch/loongarch/include/asm/module.lds.h
 create mode 100644 arch/loongarch/include/asm/numa.h
 create mode 100644 arch/loongarch/include/asm/page.h
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
 create mode 100644 arch/loongarch/include/asm/seccomp.h
 create mode 100644 arch/loongarch/include/asm/serial.h
 create mode 100644 arch/loongarch/include/asm/setup.h
 create mode 100644 arch/loongarch/include/asm/shmparam.h
 create mode 100644 arch/loongarch/include/asm/smp.h
 create mode 100644 arch/loongarch/include/asm/sparsemem.h
 create mode 100644 arch/loongarch/include/asm/stackframe.h
 create mode 100644 arch/loongarch/include/asm/stacktrace.h
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
 create mode 100644 arch/loongarch/include/uapi/asm/auxvec.h
 create mode 100644 arch/loongarch/include/uapi/asm/bitsperlong.h
 create mode 100644 arch/loongarch/include/uapi/asm/break.h
 create mode 100644 arch/loongarch/include/uapi/asm/byteorder.h
 create mode 100644 arch/loongarch/include/uapi/asm/hwcap.h
 create mode 100644 arch/loongarch/include/uapi/asm/ptrace.h
 create mode 100644 arch/loongarch/include/uapi/asm/reg.h
 create mode 100644 arch/loongarch/include/uapi/asm/sigcontext.h
 create mode 100644 arch/loongarch/include/uapi/asm/signal.h
 create mode 100644 arch/loongarch/include/uapi/asm/ucontext.h
 create mode 100644 arch/loongarch/include/uapi/asm/unistd.h
 create mode 100644 arch/loongarch/kernel/.gitignore
 create mode 100644 arch/loongarch/kernel/Makefile
 create mode 100644 arch/loongarch/kernel/access-helper.h
 create mode 100644 arch/loongarch/kernel/acpi.c
 create mode 100644 arch/loongarch/kernel/asm-offsets.c
 create mode 100644 arch/loongarch/kernel/cacheinfo.c
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
 create mode 100644 arch/loongarch/kernel/inst.c
 create mode 100644 arch/loongarch/kernel/io.c
 create mode 100644 arch/loongarch/kernel/irq.c
 create mode 100644 arch/loongarch/kernel/mem.c
 create mode 100644 arch/loongarch/kernel/module-sections.c
 create mode 100644 arch/loongarch/kernel/module.c
 create mode 100644 arch/loongarch/kernel/numa.c
 create mode 100644 arch/loongarch/kernel/proc.c
 create mode 100644 arch/loongarch/kernel/process.c
 create mode 100644 arch/loongarch/kernel/ptrace.c
 create mode 100644 arch/loongarch/kernel/reset.c
 create mode 100644 arch/loongarch/kernel/setup.c
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
 create mode 100644 arch/loongarch/vdso/.gitignore
 create mode 100644 arch/loongarch/vdso/Makefile
 create mode 100644 arch/loongarch/vdso/elf.S
 create mode 100755 arch/loongarch/vdso/gen_vdso_offsets.sh
 create mode 100644 arch/loongarch/vdso/sigreturn.S
 create mode 100644 arch/loongarch/vdso/vdso.S
 create mode 100644 arch/loongarch/vdso/vdso.lds.S
 create mode 100644 arch/loongarch/vdso/vgettimeofday.c
