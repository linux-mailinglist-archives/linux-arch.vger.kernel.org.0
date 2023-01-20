Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF9D67566E
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 15:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjATOLA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Jan 2023 09:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjATOK4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Jan 2023 09:10:56 -0500
Received: from fx403.security-mail.net (smtpout140.security-mail.net [85.31.212.143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610B8C63BA
        for <linux-arch@vger.kernel.org>; Fri, 20 Jan 2023 06:10:28 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by fx403.security-mail.net (Postfix) with ESMTP id 8FC21465271
        for <linux-arch@vger.kernel.org>; Fri, 20 Jan 2023 15:10:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1674223826;
        bh=u05gBbxbU0XcM84ibuGtkAO/5sZ+vaw532gyqiv5ke4=;
        h=From:To:Cc:Subject:Date;
        b=jTs2jAo9eqk86wLmUWl3lgXSVjuvLpjXIR9mYOi5Fm933zhuXmwp/UrScOmSwz1uM
         WJamAzHoo2Kp49D1D69jckKKEIrA+UdgzRU1KXy6PZKtriPETD8VgpIoWpnMKHAQHl
         T+QFTFQ+fh3jr3AMUhpBTiNctEZzN5fyEvX6Dhfo=
Received: from fx403 (localhost [127.0.0.1]) by fx403.security-mail.net
 (Postfix) with ESMTP id 0DD12464EF0; Fri, 20 Jan 2023 15:10:26 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx403.security-mail.net (Postfix) with ESMTPS id E43AC46572D; Fri, 20 Jan
 2023 15:10:24 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id 9CC5727E043D; Fri, 20 Jan 2023
 15:10:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id 70D2427E0439; Fri, 20 Jan 2023 15:10:24 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 ZR8CrZjtrms1; Fri, 20 Jan 2023 15:10:24 +0100 (CET)
Received: from junon.lin.mbt.kalray.eu (unknown [192.168.37.161]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id 1242527E0430; Fri, 20 Jan 2023
 15:10:24 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <f06d.63caa0d0.e2594.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 70D2427E0439
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1674223824;
 bh=01rZlNc4yKrLksy0dGX5eim8CfD+zzBrNNXjdcoErTo=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=DMUbMlHERVlEVDw9rRcJREzTGVMUCpHnBje5lOkRdVWE6eayRRsBTz+r0HNJTYa0N
 z+9u1/sjfXJix6dbCdLqQPKR0IGOAhtH3KUV9PchM9vRTLurujXHn+uikX0l6EghkY
 wT1M1A209642SKqj3mC4CuyYIjQfuaE9wb1yVeSI=
From:   Yann Sionneau <ysionneau@kalray.eu>
To:     Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Yann Sionneau <ysionneau@kalray.eu>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Clement Leger <clement@clement-leger.fr>,
        Vincent Chardon <vincent.chardon@elsys-design.com>,
        Marc =?utf-8?b?UG91bGhpw6hz?= <dkm@kataplop.net>,
        Julian Vetter <jvetter@kalray.eu>,
        Samuel Jones <sjones@kalray.eu>,
        Ashley Lesdalons <alesdalons@kalray.eu>,
        Thomas Costis <tcostis@kalray.eu>,
        Marius Gligor <mgligor@kalray.eu>,
        Jonathan Borne <jborne@kalray.eu>,
        Julien Villette <jvillette@kalray.eu>,
        Luc Michel <lmichel@kalray.eu>,
        Louis Morhet <lmorhet@kalray.eu>,
        Julien Hascoet <jhascoet@kalray.eu>,
        Jean-Christophe Pince <jcpince@gmail.com>,
        Guillaume Missonnier <gmissonnier@kalray.eu>,
        Alex Michon <amichon@kalray.eu>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <git@xen0n.name>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        John Garry <john.garry@huawei.com>,
        Guangbin Huang <huangguangbin2@huawei.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Bibo Mao <maobibo@loongson.cn>,
        Atish Patra <atishp@atishpatra.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Qi Liu <liuqi115@huawei.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Benjamin Mugnier <mugnier.benjamin@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-audit@redhat.com,
        linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Subject: [RFC PATCH v2 00/31] Upstream kvx Linux port
Date:   Fri, 20 Jan 2023 15:09:31 +0100
Message-ID: <20230120141002.2442-1-ysionneau@kalray.eu>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch series adds support for the kv3-1 CPU architecture of the kvx family
found in the Coolidge (aka MPPA3-80) SoC of Kalray.

This is an RFC, since kvx support is not yet upstreamed into gcc/binutils,
therefore this patch series cannot be merged into Linux for now.

The goal is to have preliminary reviews and to fix problems early.

The Kalray VLIW processor family (kvx) has the following features:
* 32/64 bits execution mode
* 6-issue VLIW architecture
* 64 x 64bits general purpose registers
* SIMD instructions
* little-endian
* deep learning co-processor

Kalray kv3-1 core which is the third of the kvx family is embedded in Kalray
Coolidge SoC currently used on K200 and K200-LP boards.

The Coolidge SoC contains 5 clusters each of which is made of:
* 4MiB of on-chip memory (SMEM)
* 1 dedicated safety/security core (kv3-1 core).
* 16 PEs (Processing Elements) (kv3-1 cores).
* 16 Co-processors (one per PE)
* 2 Crypto accelerators

The Coolidge SoC contains the following features:
* 5 Clusters
* 2 100G Ethernet controllers
* 8 PCIe GEN4 controllers (Root Complex and Endpoint capable)
* 2 USB 2.0 controllers
* 1 Octal SPI-NOR flash controller
* 1 eMMC controller
* 3 Quad SPI controllers
* 6 UART
* 5 I2C controllers (3 of which are SMBus capable)
* 4 CAN controllers
* 1 OTP memory

A kvx toolchain can be built using:
# install dependencies: texinfo bison flex libgmp-dev libmpc-dev libmpfr-dev
$ git clone https://github.com/kalray/build-scripts
$ cd build-scripts
$ source last.refs
$ ./build-kvx-xgcc.sh output

The kvx toolchain will be installed in the "output" directory.

You can also find prebuilt toolchains at: https://github.com/kalray/build-scripts/releases/tag/v4.11.1
They are built for Ubuntu 18.04, 20.04 and 22.04 (named 'latest').

A buildroot image (kernel+rootfs) and toolchain can be built using:
$ git clone -b coolidge-for-upstream-v2 https://github.com/kalray/buildroot
$ cd buildroot
$ make O=build_kvx kvx_defconfig
$ make O=build_kvx

The vmlinux image can be found in buildroot/build_kvx/images/vmlinux.

If you are just interested in building the Linux kernel with no rootfs you can
just do this with the kvx-elf- toolchain:
$ make ARCH=kvx O=build_kvx CROSS_COMPILE=kvx-elf- defconfig
$ make ARCH=kvx O=build_kvx CROSS_COMPILE=kvx-elf- -j$(($(nproc) + 1))

The vmlinux ELF can be run with qemu by doing:
# install dependencies: ninja pkg-config libglib-2.0-dev cmake libfdt-dev libpixman-1-dev zlib1g-dev
$ git clone https://github.com/kalray/qemu-builder
$ cd qemu-builder
$ git submodule update --init
$ make -j$(($(nproc) + 1))
$ ./qemu-system-kvx -m 1024 -nographic -kernel <path/to/vmlinux>

V1 -> V2:
 - Rebase on 6.1.6
 - Removed features that are non-necessary for basic port to boot: kgdb, l2 cache driver, jump label, ftrace, hw breakpoints, gdb python helpers and perf monitors
 - Split dt bindings in separate patches
 - Split irqchip drivers: 1 driver == 1 patch
 - Fixed typos in arch/kvx/Kconfig
 - Rewrote ASM atomic helpers in C using builtins
 - Documentation has been rewritten in RST format and included in documentation build system
 - Renamed default_defconfig to defconfig
 - Removed arch-specific __access_ok to use generic code
 - Fixed make clean issue caused by LIBGCC definition in arch/kvx/Makefile

Note that all remarks on V1 patchset are not addressed yet. We are still working on some fixes like removing legacy syscalls,
using generic entry, rework smp.c and publication of kv3-1 ABI specification.

Jules Maselbas (11):
  Documentation: Add binding for kalray,kv3-1-core-intc
  Documentation: Add binding for kalray,kv3-1-apic-gic
  Documentation: Add binding for kalray,kv3-1-apic-mailbox
  Documentation: Add binding for kalray,coolidge-itgen
  Documentation: Add binding for kalray,kv3-1-ipi-ctrl
  Documentation: Add binding for kalray,kv3-1-pwr-ctrl
  irqchip: Add irq-kvx-itgen driver
  irqchip: Add irq-kvx-apic-mailbox driver
  irqchip: Add kvx-core-intc core interupt controller driver
  kvx: Add power controller driver
  kvx: Add IPI driver

Yann Sionneau (20):
  Documentation: kvx: Add basic documentation
  kvx: Add ELF-related definitions
  kvx: Add build infrastructure
  kvx: Add CPU definition headers
  kvx: Add atomic/locking headers
  kvx: Add other common headers
  kvx: Add boot and setup routines
  kvx: Add exception/interrupt handling
  irqchip: Add irq-kvx-apic-gic driver
  kvx: Add process management
  kvx: Add memory management
  kvx: Add system call support
  kvx: Add signal handling support
  kvx: Add ELF relocations and module support
  kvx: Add misc common routines
  kvx: Add some library functions
  kvx: Add multi-processor (SMP) support
  kvx: Add kvx default config file
  kvx: Add debugging related support
  kvx: Add support for cpuinfo

 Documentation/arch.rst                        |    1 +
 .../kalray,coolidge-itgen.yaml                |   48 +
 .../kalray,kv3-1-apic-gic.yaml                |   66 +
 .../kalray,kv3-1-apic-mailbox.yaml            |   75 +
 .../kalray,kv3-1-core-intc.yaml               |   46 +
 .../kalray/kalray,kv3-1-ipi-ctrl.yaml         |   44 +
 .../kalray/kalray,kv3-1-pwr-ctrl.yaml         |   29 +
 Documentation/kvx/index.rst                   |   17 +
 Documentation/kvx/kvx-exceptions.rst          |  256 +
 Documentation/kvx/kvx-iommu.rst               |  191 +
 Documentation/kvx/kvx-mmu.rst                 |  287 +
 Documentation/kvx/kvx-smp.rst                 |   39 +
 Documentation/kvx/kvx.rst                     |  273 +
 arch/kvx/Kconfig                              |  224 +
 arch/kvx/Kconfig.debug                        |   70 +
 arch/kvx/Makefile                             |   53 +
 arch/kvx/configs/defconfig                    |  127 +
 arch/kvx/include/asm/Kbuild                   |   20 +
 arch/kvx/include/asm/asm-prototypes.h         |   14 +
 arch/kvx/include/asm/atomic.h                 |  104 +
 arch/kvx/include/asm/barrier.h                |   15 +
 arch/kvx/include/asm/bitops.h                 |  115 +
 arch/kvx/include/asm/bitrev.h                 |   32 +
 arch/kvx/include/asm/break_hook.h             |   69 +
 arch/kvx/include/asm/bug.h                    |   67 +
 arch/kvx/include/asm/cache.h                  |   43 +
 arch/kvx/include/asm/cacheflush.h             |  158 +
 arch/kvx/include/asm/clocksource.h            |   17 +
 arch/kvx/include/asm/cmpxchg.h                |  170 +
 arch/kvx/include/asm/current.h                |   22 +
 arch/kvx/include/asm/dame.h                   |   31 +
 arch/kvx/include/asm/debug.h                  |   35 +
 arch/kvx/include/asm/elf.h                    |  155 +
 arch/kvx/include/asm/fixmap.h                 |   47 +
 arch/kvx/include/asm/futex.h                  |  141 +
 arch/kvx/include/asm/hardirq.h                |   14 +
 arch/kvx/include/asm/hugetlb.h                |   36 +
 arch/kvx/include/asm/hw_irq.h                 |   14 +
 arch/kvx/include/asm/insns.h                  |   16 +
 arch/kvx/include/asm/insns_defs.h             |  197 +
 arch/kvx/include/asm/io.h                     |   34 +
 arch/kvx/include/asm/ipi.h                    |   16 +
 arch/kvx/include/asm/irqflags.h               |   58 +
 arch/kvx/include/asm/linkage.h                |   13 +
 arch/kvx/include/asm/mem_map.h                |   44 +
 arch/kvx/include/asm/mmu.h                    |  289 +
 arch/kvx/include/asm/mmu_context.h            |  156 +
 arch/kvx/include/asm/mmu_stats.h              |   38 +
 arch/kvx/include/asm/page.h                   |  187 +
 arch/kvx/include/asm/page_size.h              |   29 +
 arch/kvx/include/asm/pci.h                    |   36 +
 arch/kvx/include/asm/pgalloc.h                |  101 +
 arch/kvx/include/asm/pgtable-bits.h           |  102 +
 arch/kvx/include/asm/pgtable.h                |  451 ++
 arch/kvx/include/asm/privilege.h              |  211 +
 arch/kvx/include/asm/processor.h              |  172 +
 arch/kvx/include/asm/ptrace.h                 |  217 +
 arch/kvx/include/asm/pwr_ctrl.h               |   45 +
 arch/kvx/include/asm/rm_fw.h                  |   16 +
 arch/kvx/include/asm/sections.h               |   18 +
 arch/kvx/include/asm/setup.h                  |   29 +
 arch/kvx/include/asm/sfr.h                    |  107 +
 arch/kvx/include/asm/sfr_defs.h               | 5028 +++++++++++++++++
 arch/kvx/include/asm/smp.h                    |   42 +
 arch/kvx/include/asm/sparsemem.h              |   15 +
 arch/kvx/include/asm/spinlock.h               |   16 +
 arch/kvx/include/asm/spinlock_types.h         |   17 +
 arch/kvx/include/asm/stackprotector.h         |   47 +
 arch/kvx/include/asm/stacktrace.h             |   44 +
 arch/kvx/include/asm/string.h                 |   20 +
 arch/kvx/include/asm/swab.h                   |   48 +
 arch/kvx/include/asm/switch_to.h              |   21 +
 arch/kvx/include/asm/symbols.h                |   16 +
 arch/kvx/include/asm/sys_arch.h               |   51 +
 arch/kvx/include/asm/syscall.h                |   73 +
 arch/kvx/include/asm/syscalls.h               |   21 +
 arch/kvx/include/asm/thread_info.h            |   78 +
 arch/kvx/include/asm/timex.h                  |   20 +
 arch/kvx/include/asm/tlb.h                    |   24 +
 arch/kvx/include/asm/tlb_defs.h               |  131 +
 arch/kvx/include/asm/tlbflush.h               |   58 +
 arch/kvx/include/asm/traps.h                  |   76 +
 arch/kvx/include/asm/types.h                  |   12 +
 arch/kvx/include/asm/uaccess.h                |  317 ++
 arch/kvx/include/asm/unistd.h                 |   11 +
 arch/kvx/include/asm/vermagic.h               |   12 +
 arch/kvx/include/asm/vmalloc.h                |   10 +
 arch/kvx/include/uapi/asm/Kbuild              |    1 +
 arch/kvx/include/uapi/asm/bitsperlong.h       |   14 +
 arch/kvx/include/uapi/asm/byteorder.h         |   12 +
 arch/kvx/include/uapi/asm/cachectl.h          |   25 +
 arch/kvx/include/uapi/asm/ptrace.h            |  114 +
 arch/kvx/include/uapi/asm/sigcontext.h        |   16 +
 arch/kvx/include/uapi/asm/unistd.h            |   16 +
 arch/kvx/kernel/Makefile                      |   15 +
 arch/kvx/kernel/asm-offsets.c                 |  157 +
 arch/kvx/kernel/break_hook.c                  |   76 +
 arch/kvx/kernel/common.c                      |   11 +
 arch/kvx/kernel/cpuinfo.c                     |   96 +
 arch/kvx/kernel/dame_handler.c                |  113 +
 arch/kvx/kernel/debug.c                       |   64 +
 arch/kvx/kernel/entry.S                       | 1759 ++++++
 arch/kvx/kernel/head.S                        |  568 ++
 arch/kvx/kernel/insns.c                       |  144 +
 arch/kvx/kernel/io.c                          |   96 +
 arch/kvx/kernel/irq.c                         |   78 +
 arch/kvx/kernel/kvx_ksyms.c                   |   29 +
 arch/kvx/kernel/module.c                      |  148 +
 arch/kvx/kernel/process.c                     |  203 +
 arch/kvx/kernel/prom.c                        |   24 +
 arch/kvx/kernel/ptrace.c                      |  276 +
 arch/kvx/kernel/reset.c                       |   37 +
 arch/kvx/kernel/setup.c                       |  177 +
 arch/kvx/kernel/signal.c                      |  265 +
 arch/kvx/kernel/smp.c                         |  110 +
 arch/kvx/kernel/smpboot.c                     |  127 +
 arch/kvx/kernel/stacktrace.c                  |  173 +
 arch/kvx/kernel/sys_kvx.c                     |   58 +
 arch/kvx/kernel/syscall_table.c               |   19 +
 arch/kvx/kernel/time.c                        |  242 +
 arch/kvx/kernel/traps.c                       |  243 +
 arch/kvx/kernel/vdso.c                        |   87 +
 arch/kvx/kernel/vmlinux.lds.S                 |  150 +
 arch/kvx/lib/Makefile                         |    6 +
 arch/kvx/lib/clear_page.S                     |   40 +
 arch/kvx/lib/copy_page.S                      |   90 +
 arch/kvx/lib/delay.c                          |   39 +
 arch/kvx/lib/memcpy.c                         |   70 +
 arch/kvx/lib/memset.S                         |  351 ++
 arch/kvx/lib/strlen.S                         |  122 +
 arch/kvx/lib/usercopy.S                       |   90 +
 arch/kvx/mm/Makefile                          |    8 +
 arch/kvx/mm/cacheflush.c                      |  154 +
 arch/kvx/mm/dma-mapping.c                     |   85 +
 arch/kvx/mm/extable.c                         |   24 +
 arch/kvx/mm/fault.c                           |  264 +
 arch/kvx/mm/init.c                            |  277 +
 arch/kvx/mm/mmap.c                            |   31 +
 arch/kvx/mm/mmu.c                             |  202 +
 arch/kvx/mm/mmu_stats.c                       |   94 +
 arch/kvx/mm/tlb.c                             |  433 ++
 arch/kvx/platform/Makefile                    |    7 +
 arch/kvx/platform/ipi.c                       |  108 +
 arch/kvx/platform/pwr_ctrl.c                  |   91 +
 drivers/irqchip/Kconfig                       |   27 +
 drivers/irqchip/Makefile                      |    4 +
 drivers/irqchip/irq-kvx-apic-gic.c            |  356 ++
 drivers/irqchip/irq-kvx-apic-mailbox.c        |  480 ++
 drivers/irqchip/irq-kvx-core-intc.c           |   80 +
 drivers/irqchip/irq-kvx-itgen.c               |  236 +
 include/linux/cpuhotplug.h                    |    2 +
 include/uapi/linux/audit.h                    |    1 +
 include/uapi/linux/elf-em.h                   |    1 +
 include/uapi/linux/elf.h                      |    1 +
 tools/include/uapi/asm/bitsperlong.h          |    2 +
 155 files changed, 21474 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-itgen.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-apic-gic.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-apic-mailbox.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-core-intc.yaml
 create mode 100644 Documentation/devicetree/bindings/kalray/kalray,kv3-1-ipi-ctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/kalray/kalray,kv3-1-pwr-ctrl.yaml
 create mode 100644 Documentation/kvx/index.rst
 create mode 100644 Documentation/kvx/kvx-exceptions.rst
 create mode 100644 Documentation/kvx/kvx-iommu.rst
 create mode 100644 Documentation/kvx/kvx-mmu.rst
 create mode 100644 Documentation/kvx/kvx-smp.rst
 create mode 100644 Documentation/kvx/kvx.rst
 create mode 100644 arch/kvx/Kconfig
 create mode 100644 arch/kvx/Kconfig.debug
 create mode 100644 arch/kvx/Makefile
 create mode 100644 arch/kvx/configs/defconfig
 create mode 100644 arch/kvx/include/asm/Kbuild
 create mode 100644 arch/kvx/include/asm/asm-prototypes.h
 create mode 100644 arch/kvx/include/asm/atomic.h
 create mode 100644 arch/kvx/include/asm/barrier.h
 create mode 100644 arch/kvx/include/asm/bitops.h
 create mode 100644 arch/kvx/include/asm/bitrev.h
 create mode 100644 arch/kvx/include/asm/break_hook.h
 create mode 100644 arch/kvx/include/asm/bug.h
 create mode 100644 arch/kvx/include/asm/cache.h
 create mode 100644 arch/kvx/include/asm/cacheflush.h
 create mode 100644 arch/kvx/include/asm/clocksource.h
 create mode 100644 arch/kvx/include/asm/cmpxchg.h
 create mode 100644 arch/kvx/include/asm/current.h
 create mode 100644 arch/kvx/include/asm/dame.h
 create mode 100644 arch/kvx/include/asm/debug.h
 create mode 100644 arch/kvx/include/asm/elf.h
 create mode 100644 arch/kvx/include/asm/fixmap.h
 create mode 100644 arch/kvx/include/asm/futex.h
 create mode 100644 arch/kvx/include/asm/hardirq.h
 create mode 100644 arch/kvx/include/asm/hugetlb.h
 create mode 100644 arch/kvx/include/asm/hw_irq.h
 create mode 100644 arch/kvx/include/asm/insns.h
 create mode 100644 arch/kvx/include/asm/insns_defs.h
 create mode 100644 arch/kvx/include/asm/io.h
 create mode 100644 arch/kvx/include/asm/ipi.h
 create mode 100644 arch/kvx/include/asm/irqflags.h
 create mode 100644 arch/kvx/include/asm/linkage.h
 create mode 100644 arch/kvx/include/asm/mem_map.h
 create mode 100644 arch/kvx/include/asm/mmu.h
 create mode 100644 arch/kvx/include/asm/mmu_context.h
 create mode 100644 arch/kvx/include/asm/mmu_stats.h
 create mode 100644 arch/kvx/include/asm/page.h
 create mode 100644 arch/kvx/include/asm/page_size.h
 create mode 100644 arch/kvx/include/asm/pci.h
 create mode 100644 arch/kvx/include/asm/pgalloc.h
 create mode 100644 arch/kvx/include/asm/pgtable-bits.h
 create mode 100644 arch/kvx/include/asm/pgtable.h
 create mode 100644 arch/kvx/include/asm/privilege.h
 create mode 100644 arch/kvx/include/asm/processor.h
 create mode 100644 arch/kvx/include/asm/ptrace.h
 create mode 100644 arch/kvx/include/asm/pwr_ctrl.h
 create mode 100644 arch/kvx/include/asm/rm_fw.h
 create mode 100644 arch/kvx/include/asm/sections.h
 create mode 100644 arch/kvx/include/asm/setup.h
 create mode 100644 arch/kvx/include/asm/sfr.h
 create mode 100644 arch/kvx/include/asm/sfr_defs.h
 create mode 100644 arch/kvx/include/asm/smp.h
 create mode 100644 arch/kvx/include/asm/sparsemem.h
 create mode 100644 arch/kvx/include/asm/spinlock.h
 create mode 100644 arch/kvx/include/asm/spinlock_types.h
 create mode 100644 arch/kvx/include/asm/stackprotector.h
 create mode 100644 arch/kvx/include/asm/stacktrace.h
 create mode 100644 arch/kvx/include/asm/string.h
 create mode 100644 arch/kvx/include/asm/swab.h
 create mode 100644 arch/kvx/include/asm/switch_to.h
 create mode 100644 arch/kvx/include/asm/symbols.h
 create mode 100644 arch/kvx/include/asm/sys_arch.h
 create mode 100644 arch/kvx/include/asm/syscall.h
 create mode 100644 arch/kvx/include/asm/syscalls.h
 create mode 100644 arch/kvx/include/asm/thread_info.h
 create mode 100644 arch/kvx/include/asm/timex.h
 create mode 100644 arch/kvx/include/asm/tlb.h
 create mode 100644 arch/kvx/include/asm/tlb_defs.h
 create mode 100644 arch/kvx/include/asm/tlbflush.h
 create mode 100644 arch/kvx/include/asm/traps.h
 create mode 100644 arch/kvx/include/asm/types.h
 create mode 100644 arch/kvx/include/asm/uaccess.h
 create mode 100644 arch/kvx/include/asm/unistd.h
 create mode 100644 arch/kvx/include/asm/vermagic.h
 create mode 100644 arch/kvx/include/asm/vmalloc.h
 create mode 100644 arch/kvx/include/uapi/asm/Kbuild
 create mode 100644 arch/kvx/include/uapi/asm/bitsperlong.h
 create mode 100644 arch/kvx/include/uapi/asm/byteorder.h
 create mode 100644 arch/kvx/include/uapi/asm/cachectl.h
 create mode 100644 arch/kvx/include/uapi/asm/ptrace.h
 create mode 100644 arch/kvx/include/uapi/asm/sigcontext.h
 create mode 100644 arch/kvx/include/uapi/asm/unistd.h
 create mode 100644 arch/kvx/kernel/Makefile
 create mode 100644 arch/kvx/kernel/asm-offsets.c
 create mode 100644 arch/kvx/kernel/break_hook.c
 create mode 100644 arch/kvx/kernel/common.c
 create mode 100644 arch/kvx/kernel/cpuinfo.c
 create mode 100644 arch/kvx/kernel/dame_handler.c
 create mode 100644 arch/kvx/kernel/debug.c
 create mode 100644 arch/kvx/kernel/entry.S
 create mode 100644 arch/kvx/kernel/head.S
 create mode 100644 arch/kvx/kernel/insns.c
 create mode 100644 arch/kvx/kernel/io.c
 create mode 100644 arch/kvx/kernel/irq.c
 create mode 100644 arch/kvx/kernel/kvx_ksyms.c
 create mode 100644 arch/kvx/kernel/module.c
 create mode 100644 arch/kvx/kernel/process.c
 create mode 100644 arch/kvx/kernel/prom.c
 create mode 100644 arch/kvx/kernel/ptrace.c
 create mode 100644 arch/kvx/kernel/reset.c
 create mode 100644 arch/kvx/kernel/setup.c
 create mode 100644 arch/kvx/kernel/signal.c
 create mode 100644 arch/kvx/kernel/smp.c
 create mode 100644 arch/kvx/kernel/smpboot.c
 create mode 100644 arch/kvx/kernel/stacktrace.c
 create mode 100644 arch/kvx/kernel/sys_kvx.c
 create mode 100644 arch/kvx/kernel/syscall_table.c
 create mode 100644 arch/kvx/kernel/time.c
 create mode 100644 arch/kvx/kernel/traps.c
 create mode 100644 arch/kvx/kernel/vdso.c
 create mode 100644 arch/kvx/kernel/vmlinux.lds.S
 create mode 100644 arch/kvx/lib/Makefile
 create mode 100644 arch/kvx/lib/clear_page.S
 create mode 100644 arch/kvx/lib/copy_page.S
 create mode 100644 arch/kvx/lib/delay.c
 create mode 100644 arch/kvx/lib/memcpy.c
 create mode 100644 arch/kvx/lib/memset.S
 create mode 100644 arch/kvx/lib/strlen.S
 create mode 100644 arch/kvx/lib/usercopy.S
 create mode 100644 arch/kvx/mm/Makefile
 create mode 100644 arch/kvx/mm/cacheflush.c
 create mode 100644 arch/kvx/mm/dma-mapping.c
 create mode 100644 arch/kvx/mm/extable.c
 create mode 100644 arch/kvx/mm/fault.c
 create mode 100644 arch/kvx/mm/init.c
 create mode 100644 arch/kvx/mm/mmap.c
 create mode 100644 arch/kvx/mm/mmu.c
 create mode 100644 arch/kvx/mm/mmu_stats.c
 create mode 100644 arch/kvx/mm/tlb.c
 create mode 100644 arch/kvx/platform/Makefile
 create mode 100644 arch/kvx/platform/ipi.c
 create mode 100644 arch/kvx/platform/pwr_ctrl.c
 create mode 100644 drivers/irqchip/irq-kvx-apic-gic.c
 create mode 100644 drivers/irqchip/irq-kvx-apic-mailbox.c
 create mode 100644 drivers/irqchip/irq-kvx-core-intc.c
 create mode 100644 drivers/irqchip/irq-kvx-itgen.c

base-commit: 21e996306a6afaae88295858de0ffb8955173a15
-- 
2.37.2





