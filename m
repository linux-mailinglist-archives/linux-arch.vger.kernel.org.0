Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925914BD6A0
	for <lists+linux-arch@lfdr.de>; Mon, 21 Feb 2022 07:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345575AbiBUGli (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Feb 2022 01:41:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345448AbiBUGlc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Feb 2022 01:41:32 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7C372E08A;
        Sun, 20 Feb 2022 22:40:26 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 870051476;
        Sun, 20 Feb 2022 22:40:26 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.49.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4EB7D3F70D;
        Sun, 20 Feb 2022 22:40:24 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-arch@vger.kernel.org
Subject: [PATCH V2 30/30] mm/mmap: Drop ARCH_HAS_VM_GET_PAGE_PROT
Date:   Mon, 21 Feb 2022 12:08:39 +0530
Message-Id: <1645425519-9034-31-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1645425519-9034-1-git-send-email-anshuman.khandual@arm.com>
References: <1645425519-9034-1-git-send-email-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

All platforms now define their own vm_get_page_prot() and also there is no
generic version left to fallback on. Hence drop ARCH_HAS_GET_PAGE_PROT.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/alpha/Kconfig      |  1 -
 arch/arc/Kconfig        |  1 -
 arch/arm/Kconfig        |  1 -
 arch/arm64/Kconfig      |  1 -
 arch/csky/Kconfig       |  1 -
 arch/hexagon/Kconfig    |  1 -
 arch/ia64/Kconfig       |  1 -
 arch/m68k/Kconfig       |  1 -
 arch/microblaze/Kconfig |  1 -
 arch/mips/Kconfig       |  1 -
 arch/nds32/Kconfig      |  1 -
 arch/nios2/Kconfig      |  1 -
 arch/openrisc/Kconfig   |  1 -
 arch/parisc/Kconfig     |  1 -
 arch/powerpc/Kconfig    |  1 -
 arch/riscv/Kconfig      |  1 -
 arch/s390/Kconfig       |  1 -
 arch/sh/Kconfig         |  1 -
 arch/sparc/Kconfig      |  2 --
 arch/um/Kconfig         |  1 -
 arch/x86/Kconfig        |  1 -
 arch/xtensa/Kconfig     |  1 -
 mm/Kconfig              |  3 ---
 mm/mmap.c               | 23 -----------------------
 24 files changed, 49 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 73e82fe5c770..4e87783c90ad 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -2,7 +2,6 @@
 config ALPHA
 	bool
 	default y
-	select ARCH_HAS_VM_GET_PAGE_PROT
 	select ARCH_32BIT_USTAT_F_TINODE
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 78ff0644b343..3c2a4753d09b 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -13,7 +13,6 @@ config ARC
 	select ARCH_HAS_SETUP_DMA_OPS
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
-	select ARCH_HAS_VM_GET_PAGE_PROT
 	select ARCH_SUPPORTS_ATOMIC_RMW if ARC_HAS_LLSC
 	select ARCH_32BIT_OFF_T
 	select BUILDTIME_TABLE_SORT
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 87b2e89ef3d6..4c97cb40eebb 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -23,7 +23,6 @@ config ARM
 	select ARCH_HAS_SYNC_DMA_FOR_CPU if SWIOTLB || !MMU
 	select ARCH_HAS_TEARDOWN_DMA_OPS if MMU
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
-	select ARCH_HAS_VM_GET_PAGE_PROT
 	select ARCH_HAVE_CUSTOM_GPIO_H
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG if CPU_V7 || CPU_V7M || CPU_V6K
 	select ARCH_HAS_GCOV_PROFILE_ALL
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7153d5fff603..bfb92b98d5aa 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -43,7 +43,6 @@ config ARM64
 	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_TEARDOWN_DMA_OPS if IOMMU_SUPPORT
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
-	select ARCH_HAS_VM_GET_PAGE_PROT
 	select ARCH_HAS_ZONE_DMA_SET if EXPERT
 	select ARCH_HAVE_ELF_PROT
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 209dac5686dd..132f43f12dd8 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -6,7 +6,6 @@ config CSKY
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
-	select ARCH_HAS_VM_GET_PAGE_PROT
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_WANT_FRAME_POINTERS if !CPU_CK610 && $(cc-option,-mbacktrace)
diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index cdc5df32a1e3..15dd8f38b698 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -6,7 +6,6 @@ config HEXAGON
 	def_bool y
 	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
-	select ARCH_HAS_VM_GET_PAGE_PROT
 	select ARCH_NO_PREEMPT
 	select DMA_GLOBAL_POOL
 	# Other pending projects/to-do items.
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 0ab15e8d5783..a7e01573abd8 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -11,7 +11,6 @@ config IA64
 	select ARCH_HAS_DMA_MARK_CLEAN
 	select ARCH_HAS_STRNCPY_FROM_USER
 	select ARCH_HAS_STRNLEN_USER
-	select ARCH_HAS_VM_GET_PAGE_PROT
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select ACPI
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 114e65164692..936e1803c7c7 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -11,7 +11,6 @@ config M68K
 	select ARCH_NO_PREEMPT if !COLDFIRE
 	select ARCH_USE_MEMTEST if MMU_MOTOROLA
 	select ARCH_WANT_IPC_PARSE_VERSION
-	select ARCH_HAS_VM_GET_PAGE_PROT
 	select BINFMT_FLAT_ARGVP_ENVP_ON_STACK
 	select DMA_DIRECT_REMAP if HAS_DMA && MMU && !COLDFIRE
 	select GENERIC_ATOMIC64
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index f2c25ba8621e..59798e43cdb0 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -7,7 +7,6 @@ config MICROBLAZE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
-	select ARCH_HAS_VM_GET_PAGE_PROT
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select BUILDTIME_TABLE_SORT
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index fcbfc52a1567..058446f01487 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -13,7 +13,6 @@ config MIPS
 	select ARCH_HAS_STRNLEN_USER
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
-	select ARCH_HAS_VM_GET_PAGE_PROT
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_KEEP_MEMBLOCK
 	select ARCH_SUPPORTS_UPROBES
diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
index 576e05479925..4d1421b18734 100644
--- a/arch/nds32/Kconfig
+++ b/arch/nds32/Kconfig
@@ -10,7 +10,6 @@ config NDS32
 	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
-	select ARCH_HAS_VM_GET_PAGE_PROT
 	select ARCH_WANT_FRAME_POINTERS if FTRACE
 	select CLKSRC_MMIO
 	select CLONE_BACKWARDS
diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index 85a58a357a3b..33fd06f5fa41 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -6,7 +6,6 @@ config NIOS2
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_HAS_DMA_SET_UNCACHED
-	select ARCH_HAS_VM_GET_PAGE_PROT
 	select ARCH_NO_SWAP
 	select COMMON_CLK
 	select TIMER_OF
diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 842a61426816..f724b3f1aeed 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -10,7 +10,6 @@ config OPENRISC
 	select ARCH_HAS_DMA_SET_UNCACHED
 	select ARCH_HAS_DMA_CLEAR_UNCACHED
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
-	select ARCH_HAS_VM_GET_PAGE_PROT
 	select COMMON_CLK
 	select OF
 	select OF_EARLY_FLATTREE
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index de512f120b50..43c1c880def6 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -10,7 +10,6 @@ config PARISC
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
-	select ARCH_HAS_VM_GET_PAGE_PROT
 	select ARCH_NO_SG_CHAIN
 	select ARCH_SUPPORTS_HUGETLBFS if PA20
 	select ARCH_SUPPORTS_MEMORY_FAILURE
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index ddb4a3687c05..b779603978e1 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -135,7 +135,6 @@ config PPC
 	select ARCH_HAS_TICK_BROADCAST		if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UACCESS_FLUSHCACHE
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
-	select ARCH_HAS_VM_GET_PAGE_PROT
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_KEEP_MEMBLOCK
 	select ARCH_MIGHT_HAVE_PC_PARPORT
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 9391742f9286..5adcbd9b5e88 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -31,7 +31,6 @@ config RISCV
 	select ARCH_HAS_STRICT_MODULE_RWX if MMU && !XIP_KERNEL
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
-	select ARCH_HAS_VM_GET_PAGE_PROT
 	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
 	select ARCH_STACKWALK
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index cb1b487e8201..be9f39fd06df 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -78,7 +78,6 @@ config S390
 	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_HAS_VDSO_DATA
-	select ARCH_HAS_VM_GET_PAGE_PROT
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_INLINE_READ_LOCK
 	select ARCH_INLINE_READ_LOCK_BH
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index f3fcd1c5e002..2474a04ceac4 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -11,7 +11,6 @@ config SUPERH
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
-	select ARCH_HAS_VM_GET_PAGE_PROT
 	select ARCH_HIBERNATION_POSSIBLE if MMU
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_WANT_IPC_PARSE_VERSION
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index ff29156f2380..1cab1b284f1a 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -59,7 +59,6 @@ config SPARC32
 	select HAVE_UID16
 	select OLD_SIGACTION
 	select ZONE_DMA
-	select ARCH_HAS_VM_GET_PAGE_PROT
 
 config SPARC64
 	def_bool 64BIT
@@ -85,7 +84,6 @@ config SPARC64
 	select PERF_USE_VMALLOC
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select HAVE_C_RECORDMCOUNT
-	select ARCH_HAS_VM_GET_PAGE_PROT
 	select HAVE_ARCH_AUDITSYSCALL
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_DEBUG_PAGEALLOC
diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 5836296868a8..4d398b80aea8 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -9,7 +9,6 @@ config UML
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_STRNCPY_FROM_USER
 	select ARCH_HAS_STRNLEN_USER
-	select ARCH_HAS_VM_GET_PAGE_PROT
 	select ARCH_NO_PREEMPT
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_SECCOMP_FILTER
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b2ea06c87708..013d8d6179e5 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -93,7 +93,6 @@ config X86
 	select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
 	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
-	select ARCH_HAS_VM_GET_PAGE_PROT
 	select ARCH_HAS_DEBUG_WX
 	select ARCH_HAS_ZONE_DMA_SET if EXPERT
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 1608f7517546..8ac599aa6d99 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -9,7 +9,6 @@ config XTENSA
 	select ARCH_HAS_DMA_SET_UNCACHED if MMU
 	select ARCH_HAS_STRNCPY_FROM_USER if !KASAN
 	select ARCH_HAS_STRNLEN_USER
-	select ARCH_HAS_VM_GET_PAGE_PROT
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
diff --git a/mm/Kconfig b/mm/Kconfig
index 212fb6e1ddaa..3326ee3903f3 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -744,9 +744,6 @@ config IDLE_PAGE_TRACKING
 config ARCH_HAS_CACHE_LINE_SIZE
 	bool
 
-config ARCH_HAS_VM_GET_PAGE_PROT
-	bool
-
 config ARCH_HAS_PTE_DEVMAP
 	bool
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 368bc8aee45b..00c9967bcfb4 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -81,29 +81,6 @@ static void unmap_region(struct mm_struct *mm,
 		struct vm_area_struct *vma, struct vm_area_struct *prev,
 		unsigned long start, unsigned long end);
 
-#ifndef CONFIG_ARCH_HAS_VM_GET_PAGE_PROT
-/* description of effects of mapping type and prot in current implementation.
- * this is due to the limited x86 page protection hardware.  The expected
- * behavior is in parens:
- *
- * map_type	prot
- *		PROT_NONE	PROT_READ	PROT_WRITE	PROT_EXEC
- * MAP_SHARED	r: (no) no	r: (yes) yes	r: (no) yes	r: (no) yes
- *		w: (no) no	w: (no) no	w: (yes) yes	w: (no) no
- *		x: (no) no	x: (no) yes	x: (no) yes	x: (yes) yes
- *
- * MAP_PRIVATE	r: (no) no	r: (yes) yes	r: (no) yes	r: (no) yes
- *		w: (no) no	w: (no) no	w: (copy) copy	w: (no) no
- *		x: (no) no	x: (no) yes	x: (no) yes	x: (yes) yes
- *
- * On arm64, PROT_EXEC has the following behaviour for both MAP_SHARED and
- * MAP_PRIVATE (with Enhanced PAN supported):
- *								r: (no) no
- *								w: (no) no
- *								x: (yes) yes
- */
-#endif	/* CONFIG_ARCH_HAS_VM_GET_PAGE_PROT */
-
 static pgprot_t vm_pgprot_modify(pgprot_t oldprot, unsigned long vm_flags)
 {
 	return pgprot_modify(oldprot, vm_get_page_prot(vm_flags));
-- 
2.25.1

