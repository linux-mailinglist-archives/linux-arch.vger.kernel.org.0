Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6D623ACA3
	for <lists+linux-arch@lfdr.de>; Mon,  3 Aug 2020 20:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgHCSxw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Aug 2020 14:53:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:37708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbgHCSxw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 3 Aug 2020 14:53:52 -0400
Received: from localhost.localdomain (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B18EB207DF;
        Mon,  3 Aug 2020 18:53:48 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 and cross-arch updates for 5.9
Date:   Mon,  3 Aug 2020 19:53:47 +0100
Message-Id: <20200803185347.21925-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Linus,

Here's a slightly wider-spread set of updates for 5.9. Going outside the
usual arch/arm64/ is the removal of read_barrier_depends() series from
Will (http://lkml.kernel.org/r/20200710165203.31284-1-will@kernel.org)
and the MSI/IOMMU ID translation series from Lorenzo
(http://lkml.kernel.org/r/20200619082013.13661-1-lorenzo.pieralisi@arm.com).
The notable arm64 updates include ARMv8.4 TLBI range operations and
translation level hint, time namespace support, perf.

There is only a trivial conflict with v5.8, resolved as:

------------8<-------------------------
diff --cc arch/arm64/include/asm/vdso/compat_gettimeofday.h
index 9a625e8947ff,d0cbb04bfc10..85b6873b1cfa
--- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
@@@ -152,12 -153,18 +153,24 @@@ static __always_inline const struct vds
  	return ret;
  }
  
 +static inline bool vdso_clocksource_ok(const struct vdso_data *vd)
 +{
 +	return vd->clock_mode == VDSO_CLOCKMODE_ARCHTIMER;
 +}
 +#define vdso_clocksource_ok	vdso_clocksource_ok
 +
+ #ifdef CONFIG_TIME_NS
+ static __always_inline const struct vdso_data *__arch_get_timens_vdso_data(void)
+ {
+ 	const struct vdso_data *ret;
+ 
+ 	/* See __arch_get_vdso_data(). */
+ 	asm volatile("mov %0, %1" : "=r"(ret) : "r"(_timens_data));
+ 
+ 	return ret;
+ }
+ #endif
+ 
  #endif /* !__ASSEMBLY__ */
  
  #endif /* __ASM_VDSO_GETTIMEOFDAY_H */
------------8<-------------------------

If there are any issues, please let me know. I can send separate pull
requests if necessary. Thanks.

The following changes since commit 9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68:

  Linux 5.8-rc3 (2020-06-28 15:00:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

for you to fetch changes up to 0e4cd9f2654915be8d09a1bd1b405ce5426e64c4:

  Merge branch 'for-next/read-barrier-depends' into for-next/core (2020-07-31 18:09:57 +0100)

----------------------------------------------------------------
arm64 and cross-arch updates for 5.9:

- Removal of the tremendously unpopular read_barrier_depends() barrier,
  which is a NOP on all architectures apart from Alpha, in favour of
  allowing architectures to override READ_ONCE() and do whatever dance
  they need to do to ensure address dependencies provide LOAD ->
  LOAD/STORE ordering. This work also offers a potential solution if
  compilers are shown to convert LOAD -> LOAD address dependencies into
  control dependencies (e.g. under LTO), as weakly ordered architectures
  will effectively be able to upgrade READ_ONCE() to smp_load_acquire().
  The latter case is not used yet, but will be discussed further at LPC.

- Make the MSI/IOMMU input/output ID translation PCI agnostic, augment
  the MSI/IOMMU ACPI/OF ID mapping APIs to accept an input ID
  bus-specific parameter and apply the resulting changes to the device
  ID space provided by the Freescale FSL bus.

- arm64 support for TLBI range operations and translation table level
  hints (part of the ARMv8.4 architecture version).

- Time namespace support for arm64.

- Export the virtual and physical address sizes in vmcoreinfo for
  makedumpfile and crash utilities.

- CPU feature handling cleanups and checks for programmer errors
  (overlapping bit-fields).

- ACPI updates for arm64: disallow AML accesses to EFI code regions and
  kernel memory.

- perf updates for arm64.

- Miscellaneous fixes and cleanups, most notably PLT counting
  optimisation for module loading, recordmcount fix to ignore
  relocations other than R_AARCH64_CALL26, CMA areas reserved for
  gigantic pages on 16K and 64K configurations.

- Trivial typos, duplicate words.

----------------------------------------------------------------
Ahmed S. Darwish (1):
      time/sched_clock: Use raw_read_seqcount_latch()

Andrei Vagin (6):
      arm64/vdso: use the fault callback to map vvar pages
      arm64/vdso: Zap vvar pages when switching to a time namespace
      arm64/vdso: Add time namespace page
      arm64/vdso: Handle faults on timens page
      arm64/vdso: Restrict splitting VVAR VMA
      arm64: enable time namespace support

Andrew Scull (1):
      smccc: Make constants available to assembly

Anshuman Khandual (7):
      arm64/panic: Unify all three existing notifier blocks
      arm64/cpufeature: Add remaining feature bits in ID_AA64MMFR0 register
      arm64/cpufeature: Add remaining feature bits in ID_AA64MMFR1 register
      arm64/cpufeature: Add remaining feature bits in ID_AA64MMFR2 register
      arm64/cpufeature: Replace all open bits shift encodings with macros
      arm64/cpufeature: Validate feature bits spacing in arm64_ftr_regs[]
      arm64/hugetlb: Reserve CMA areas for gigantic pages on 16K and 64K configs

Ard Biesheuvel (3):
      arm64/acpi: disallow AML memory opregions to access kernel memory
      arm64/acpi: disallow writeable AML opregion mapping for EFI code regions
      arm64/entry: deduplicate SW PAN entry/exit routines

Bhupesh Sharma (3):
      crash_core, vmcoreinfo: Append 'MAX_PHYSMEM_BITS' to vmcoreinfo
      arm64/crash_core: Export TCR_EL1.T1SZ in vmcoreinfo
      arm64/defconfig: Enable CONFIG_KEXEC_FILE

Catalin Marinas (5):
      arm64: Shift the __tlbi_level() indentation left
      arm64: Reserve HWCAP2_MTE as (1 << 18)
      Merge branches 'for-next/misc', 'for-next/vmcoreinfo', 'for-next/cpufeature', 'for-next/acpi', 'for-next/perf', 'for-next/timens', 'for-next/msi-iommu' and 'for-next/trivial' into for-next/core
      Merge branch 'for-next/tlbi' into for-next/core
      Merge branch 'for-next/read-barrier-depends' into for-next/core

Diana Craciun (2):
      of/irq: make of_msi_map_get_device_domain() bus agnostic
      bus/fsl-mc: Refactor the MSI domain creation in the DPRC driver

Gavin Shan (1):
      arm64/mm: Redefine CONT_{PTE, PMD}_SHIFT

Gregory Herrero (1):
      recordmcount: only record relocation of type R_AARCH64_CALL26 on arm64.

Jay Chen (1):
      perf/smmuv3: To simplify code for ioremap page in pmcg

Laurentiu Tudor (1):
      dt-bindings: arm: fsl: Add msi-map device-tree binding for fsl-mc bus

Leo Yan (1):
      tools headers UAPI: Update tools's copy of linux/perf_event.h

Lorenzo Pieralisi (8):
      ACPI/IORT: Make iort_match_node_callback walk the ACPI namespace for NC
      ACPI/IORT: Make iort_get_device_domain IRQ domain agnostic
      ACPI/IORT: Make iort_msi_map_rid() PCI agnostic
      ACPI/IORT: Remove useless PCI bus walk
      ACPI/IORT: Add an input ID to acpi_dma_configure()
      of/iommu: Make of_map_rid() PCI agnostic
      of/device: Add input id to of_dma_configure()
      of/irq: Make of_msi_map_rid() PCI bus agnostic

Makarand Pawagi (1):
      bus: fsl-mc: Add ACPI support for fsl-mc

Maninder Singh (1):
      arm64: use IRQ_STACK_SIZE instead of THREAD_SIZE for irq stack

Marc Zyngier (3):
      arm64: Detect the ARMv8.4 TTL feature
      arm64: Document SW reserved PTE/PMD bits in Stage-2 descriptors
      arm64: Add level-hinted TLB invalidation helper

Mark Brown (2):
      arm64: Document sysctls for emulated deprecated instructions
      arm64: stacktrace: Move export for save_stack_trace_tsk()

Peter Zijlstra (5):
      sched_clock: Expose struct clock_read_data
      arm64: perf: Implement correct cap_user_time
      arm64: perf: Only advertise cap_user_time for arch_timer
      perf: Add perf_event_mmap_page::cap_user_time_short ABI
      arm64: perf: Add cap_user_time_short

Peter Zijlstra (Intel) (1):
      tlb: mmu_gather: add tlb_flush_*_range APIs

Pingfan Liu (1):
      arm64/mm: save memory access in check_and_switch_context() fast switch path

Randy Dunlap (3):
      arm64: pgtable-hwdef.h: delete duplicated words
      arm64: ptrace.h: delete duplicated word
      arm64: sigcontext.h: delete duplicated word

Saravana Kannan (1):
      arm64/module: Optimize module load time by optimizing PLT counting

SeongJae Park (1):
      Documentation/barriers/kokr: Remove references to [smp_]read_barrier_depends()

Shaokun Zhang (2):
      arm64: perf: Correct the event index in sysfs
      arm64: perf: Expose some new events via sysfs

Vladimir Murzin (1):
      arm64: s/AMEVTYPE/AMEVTYPER

Will Deacon (15):
      tools: bpf: Use local copy of headers including uapi/linux/filter.h
      compiler.h: Split {READ,WRITE}_ONCE definitions out into rwonce.h
      asm/rwonce: Allow __READ_ONCE to be overridden by the architecture
      alpha: Override READ_ONCE() with barriered implementation
      asm/rwonce: Remove smp_read_barrier_depends() invocation
      asm/rwonce: Don't pull <asm/barrier.h> into 'asm-generic/rwonce.h'
      vhost: Remove redundant use of read_barrier_depends() barrier
      alpha: Replace smp_read_barrier_depends() usage with smp_[r]mb()
      locking/barriers: Remove definitions for [smp_]read_barrier_depends()
      Documentation/barriers: Remove references to [smp_]read_barrier_depends()
      tools/memory-model: Remove smp_read_barrier_depends() from informal doc
      include/linux: Remove smp_read_barrier_depends() from comments
      checkpatch: Remove checks relating to [smp_]read_barrier_depends()
      compiler.h: Move compiletime_assert() macros into compiler_types.h
      arm64: Reduce the number of header files pulled into vmlinux.lds.S

Zhenyu Ye (7):
      arm64: Add tlbi_user_level TLB invalidation helper
      arm64: tlb: Set the TTL field in flush_tlb_range
      arm64: tlb: Set the TTL field in flush_*_tlb_range
      arm64: tlb: don't set the ttl value in flush_tlb_page_nosync
      arm64: tlb: Detect the ARMv8.4 TLBI RANGE feature
      arm64: enable tlbi range instructions
      arm64: tlb: Use the TLBI RANGE feature in arm64

 .../RCU/Design/Requirements/Requirements.rst       |   2 +-
 Documentation/admin-guide/kdump/vmcoreinfo.rst     |  16 ++
 .../devicetree/bindings/misc/fsl,qoriq-mc.txt      |  50 +++++-
 Documentation/memory-barriers.txt                  | 156 +-----------------
 .../translations/ko_KR/memory-barriers.txt         | 146 +----------------
 arch/alpha/include/asm/atomic.h                    |  16 +-
 arch/alpha/include/asm/barrier.h                   |  59 +------
 arch/alpha/include/asm/pgtable.h                   |  10 +-
 arch/alpha/include/asm/rwonce.h                    |  35 ++++
 arch/arm/include/asm/vdso/gettimeofday.h           |   1 +
 arch/arm64/Kconfig                                 |  23 ++-
 arch/arm64/Makefile                                |   7 +
 arch/arm64/configs/defconfig                       |   1 +
 arch/arm64/include/asm/acpi.h                      |  15 +-
 arch/arm64/include/asm/cpucaps.h                   |   4 +-
 arch/arm64/include/asm/cpufeature.h                |   7 +
 arch/arm64/include/asm/hugetlb.h                   |   2 +
 arch/arm64/include/asm/hwcap.h                     |   1 +
 arch/arm64/include/asm/kernel-pgtable.h            |   2 +-
 arch/arm64/include/asm/memory.h                    |  12 +-
 arch/arm64/include/asm/mmu_context.h               |   6 +-
 arch/arm64/include/asm/perf_event.h                |  27 ++++
 arch/arm64/include/asm/pgtable-hwdef.h             |  23 +--
 arch/arm64/include/asm/pgtable.h                   |  10 ++
 arch/arm64/include/asm/ptrace.h                    |   2 +-
 arch/arm64/include/asm/stage2_pgtable.h            |   9 ++
 arch/arm64/include/asm/sysreg.h                    |  49 +++++-
 arch/arm64/include/asm/tlb.h                       |  29 +++-
 arch/arm64/include/asm/tlbflush.h                  | 177 +++++++++++++++++++--
 arch/arm64/include/asm/uaccess.h                   |   1 +
 arch/arm64/include/asm/vdso.h                      |   2 +
 arch/arm64/include/asm/vdso/compat_gettimeofday.h  |  13 ++
 arch/arm64/include/asm/vdso/gettimeofday.h         |   9 ++
 arch/arm64/include/uapi/asm/hwcap.h                |   1 +
 arch/arm64/include/uapi/asm/sigcontext.h           |   2 +-
 arch/arm64/kernel/acpi.c                           |  75 +++++++++
 arch/arm64/kernel/cpufeature.c                     | 149 ++++++++++++-----
 arch/arm64/kernel/cpuinfo.c                        |   1 +
 arch/arm64/kernel/crash_core.c                     |  10 ++
 arch/arm64/kernel/entry.S                          |  96 +++++------
 arch/arm64/kernel/module-plts.c                    |  46 +++++-
 arch/arm64/kernel/perf_event.c                     |  89 ++++++++---
 arch/arm64/kernel/setup.c                          |  24 +--
 arch/arm64/kernel/stacktrace.c                     |   2 +-
 arch/arm64/kernel/traps.c                          |   2 +-
 arch/arm64/kernel/vdso.c                           | 136 ++++++++++++++--
 arch/arm64/kernel/vdso/vdso.lds.S                  |   5 +-
 arch/arm64/kernel/vdso32/vdso.lds.S                |   5 +-
 arch/arm64/kernel/vmlinux.lds.S                    |   1 -
 arch/arm64/kvm/hyp-init.S                          |   1 +
 arch/arm64/kvm/sys_regs.c                          |  68 ++++----
 arch/arm64/mm/context.c                            |  10 +-
 arch/arm64/mm/hugetlbpage.c                        |  42 ++++-
 arch/arm64/mm/init.c                               |  22 +--
 arch/riscv/include/asm/vdso/gettimeofday.h         |   1 +
 drivers/acpi/arm64/iort.c                          | 108 +++++++++----
 drivers/acpi/scan.c                                |   8 +-
 drivers/bus/fsl-mc/dprc-driver.c                   |  31 +---
 drivers/bus/fsl-mc/fsl-mc-bus.c                    |  79 ++++++---
 drivers/bus/fsl-mc/fsl-mc-msi.c                    |  36 +++--
 drivers/bus/fsl-mc/fsl-mc-private.h                |   6 +-
 drivers/iommu/of_iommu.c                           |  81 +++++-----
 drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c        | 105 +++++++++---
 drivers/of/base.c                                  |  42 ++---
 drivers/of/device.c                                |   8 +-
 drivers/of/irq.c                                   |  34 ++--
 drivers/pci/msi.c                                  |   9 +-
 drivers/perf/arm_smmuv3_pmu.c                      |   3 +-
 drivers/vhost/vhost.c                              |   5 -
 include/acpi/acpi_bus.h                            |   9 +-
 include/asm-generic/Kbuild                         |   1 +
 include/asm-generic/barrier.h                      |  19 +--
 include/asm-generic/rwonce.h                       |  90 +++++++++++
 include/asm-generic/tlb.h                          |  55 +++++--
 include/linux/acpi.h                               |   7 +
 include/linux/acpi_iort.h                          |  20 +--
 include/linux/arm-smccc.h                          |  44 ++---
 include/linux/compiler.h                           | 134 +---------------
 include/linux/compiler_types.h                     |  41 +++++
 include/linux/nospec.h                             |   2 +
 include/linux/of.h                                 |   4 +-
 include/linux/of_device.h                          |  16 +-
 include/linux/of_iommu.h                           |   6 +-
 include/linux/of_irq.h                             |  13 +-
 include/linux/percpu-refcount.h                    |   2 +-
 include/linux/ptr_ring.h                           |   2 +-
 include/linux/sched_clock.h                        |  28 ++++
 include/uapi/linux/perf_event.h                    |  23 ++-
 include/vdso/datapage.h                            |   1 +
 kernel/crash_core.c                                |   1 +
 kernel/time/sched_clock.c                          |  41 ++---
 mm/memory.c                                        |   2 +-
 scripts/checkpatch.pl                              |   9 +-
 scripts/recordmcount.c                             |   6 +
 tools/bpf/Makefile                                 |   3 +-
 tools/include/uapi/linux/filter.h                  |  90 +++++++++++
 tools/include/uapi/linux/perf_event.h              |  23 ++-
 tools/memory-model/Documentation/explanation.txt   |  26 ++-
 98 files changed, 1892 insertions(+), 1091 deletions(-)
 create mode 100644 arch/alpha/include/asm/rwonce.h
 create mode 100644 include/asm-generic/rwonce.h
 create mode 100644 tools/include/uapi/linux/filter.h
