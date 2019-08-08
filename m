Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73C0986004
	for <lists+linux-arch@lfdr.de>; Thu,  8 Aug 2019 12:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403835AbfHHKjG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Aug 2019 06:39:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:47612 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403812AbfHHKjG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 8 Aug 2019 06:39:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D4754AFE3;
        Thu,  8 Aug 2019 10:39:03 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     bp@alien8.de
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v8 11/28] x86/asm/head: annotate data appropriatelly
Date:   Thu,  8 Aug 2019 12:38:37 +0200
Message-Id: <20190808103854.6192-12-jslaby@suse.cz>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808103854.6192-1-jslaby@suse.cz>
References: <20190808103854.6192-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Use the new SYM_DATA, SYM_DATA_START, and SYM_DATA_END in both 32 and 64
bit heads.  In the 64-bit version, define also
SYM_DATA_START_PAGE_ALIGNED locally using the new SYM_START. It is used
in the code instead of NEXT_PAGE() which was defined in this file and
has been using the obsolete macro GLOBAL().

Now, the data in the 64-bit object file look sane:
Value   Size Type    Bind   Vis      Ndx Name
  0000  4096 OBJECT  GLOBAL DEFAULT   15 init_level4_pgt
  1000  4096 OBJECT  GLOBAL DEFAULT   15 level3_kernel_pgt
  2000  2048 OBJECT  GLOBAL DEFAULT   15 level2_kernel_pgt
  3000  4096 OBJECT  GLOBAL DEFAULT   15 level2_fixmap_pgt
  4000  4096 OBJECT  GLOBAL DEFAULT   15 level1_fixmap_pgt
  5000     2 OBJECT  GLOBAL DEFAULT   15 early_gdt_descr
  5002     8 OBJECT  LOCAL  DEFAULT   15 early_gdt_descr_base
  500a     8 OBJECT  GLOBAL DEFAULT   15 phys_base
  0000     8 OBJECT  GLOBAL DEFAULT   17 initial_code
  0008     8 OBJECT  GLOBAL DEFAULT   17 initial_gs
  0010     8 OBJECT  GLOBAL DEFAULT   17 initial_stack
  0000     4 OBJECT  GLOBAL DEFAULT   19 early_recursion_flag
  1000  4096 OBJECT  GLOBAL DEFAULT   19 early_level4_pgt
  2000 0x40000 OBJECT  GLOBAL DEFAULT   19 early_dynamic_pgts
  0000  4096 OBJECT  GLOBAL DEFAULT   22 empty_zero_page

All have correct size and type.

Note, that we can now see that it might be worth pushing
early_recursion_flag after early_dynamic_pgts -- we are wasting almost
4K of .init.data.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
---
 arch/x86/kernel/head_32.S | 29 ++++++++-------
 arch/x86/kernel/head_64.S | 78 +++++++++++++++++++++------------------
 2 files changed, 58 insertions(+), 49 deletions(-)

diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index 0bae769b7b59..2d5390d84467 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -502,8 +502,7 @@ ENDPROC(early_ignore_irq)
 
 __INITDATA
 	.align 4
-GLOBAL(early_recursion_flag)
-	.long 0
+SYM_DATA(early_recursion_flag, .long 0)
 
 __REFDATA
 	.align 4
@@ -551,7 +550,7 @@ EXPORT_SYMBOL(empty_zero_page)
 __PAGE_ALIGNED_DATA
 	/* Page-aligned for the benefit of paravirt? */
 	.align PGD_ALIGN
-ENTRY(initial_page_table)
+SYM_DATA_START(initial_page_table)
 	.long	pa(initial_pg_pmd+PGD_IDENT_ATTR),0	/* low identity map */
 # if KPMDS == 3
 	.long	pa(initial_pg_pmd+PGD_IDENT_ATTR),0
@@ -569,17 +568,18 @@ ENTRY(initial_page_table)
 #  error "Kernel PMDs should be 1, 2 or 3"
 # endif
 	.align PAGE_SIZE		/* needs to be page-sized too */
+SYM_DATA_END(initial_page_table)
 #endif
 
 .data
 .balign 4
-ENTRY(initial_stack)
-	/*
-	 * The SIZEOF_PTREGS gap is a convention which helps the in-kernel
-	 * unwinder reliably detect the end of the stack.
-	 */
-	.long init_thread_union + THREAD_SIZE - SIZEOF_PTREGS - \
-	      TOP_OF_KERNEL_STACK_PADDING;
+/*
+ * The SIZEOF_PTREGS gap is a convention which helps the in-kernel unwinder
+ * reliably detect the end of the stack.
+ */
+SYM_DATA(initial_stack,
+		.long init_thread_union + THREAD_SIZE -
+		SIZEOF_PTREGS - TOP_OF_KERNEL_STACK_PADDING)
 
 __INITRODATA
 int_msg:
@@ -600,22 +600,25 @@ int_msg:
 	ALIGN
 # early boot GDT descriptor (must use 1:1 address mapping)
 	.word 0				# 32 bit align gdt_desc.address
-boot_gdt_descr:
+SYM_DATA_START(boot_gdt_descr)
 	.word __BOOT_DS+7
 	.long boot_gdt - __PAGE_OFFSET
+SYM_DATA_END(boot_gdt_descr)
 
 # boot GDT descriptor (later on used by CPU#0):
 	.word 0				# 32 bit align gdt_desc.address
-ENTRY(early_gdt_descr)
+SYM_DATA_START(early_gdt_descr)
 	.word GDT_ENTRIES*8-1
 	.long gdt_page			/* Overwritten for secondary CPUs */
+SYM_DATA_END(early_gdt_descr)
 
 /*
  * The boot_gdt must mirror the equivalent in setup.S and is
  * used only for booting.
  */
 	.align L1_CACHE_BYTES
-ENTRY(boot_gdt)
+SYM_DATA_START(boot_gdt)
 	.fill GDT_ENTRY_BOOT_CS,8,0
 	.quad 0x00cf9a000000ffff	/* kernel 4GB code at 0x00000000 */
 	.quad 0x00cf92000000ffff	/* kernel 4GB data at 0x00000000 */
+SYM_DATA_END(boot_gdt)
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 6fedcda37634..6661c76a2049 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -260,16 +260,14 @@ END(start_cpu0)
 	/* Both SMP bootup and ACPI suspend change these variables */
 	__REFDATA
 	.balign	8
-	GLOBAL(initial_code)
-	.quad	x86_64_start_kernel
-	GLOBAL(initial_gs)
-	.quad	INIT_PER_CPU_VAR(fixed_percpu_data)
-	GLOBAL(initial_stack)
-	/*
-	 * The SIZEOF_PTREGS gap is a convention which helps the in-kernel
-	 * unwinder reliably detect the end of the stack.
-	 */
-	.quad  init_thread_union + THREAD_SIZE - SIZEOF_PTREGS
+SYM_DATA(initial_code,	.quad x86_64_start_kernel)
+SYM_DATA(initial_gs,	.quad INIT_PER_CPU_VAR(fixed_percpu_data))
+/*
+ * The SIZEOF_PTREGS gap is a convention which helps the in-kernel unwinder
+ * reliably detect the end of the stack.
+ */
+SYM_DATA(initial_stack,
+		.quad init_thread_union + THREAD_SIZE - SIZEOF_PTREGS)
 	__FINITDATA
 
 	__INIT
@@ -338,12 +336,10 @@ SYM_CODE_END(early_idt_handler_common)
 	__INITDATA
 
 	.balign 4
-GLOBAL(early_recursion_flag)
-	.long 0
+SYM_DATA(early_recursion_flag, .long 0)
 
-#define NEXT_PAGE(name) \
-	.balign	PAGE_SIZE; \
-GLOBAL(name)
+#define SYM_DATA_START_PAGE_ALIGNED(name)			\
+	SYM_START(name, SYM_L_GLOBAL, .balign PAGE_SIZE)
 
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 /*
@@ -358,11 +354,11 @@ GLOBAL(name)
  */
 #define PTI_USER_PGD_FILL	512
 /* This ensures they are 8k-aligned: */
-#define NEXT_PGD_PAGE(name) \
-	.balign 2 * PAGE_SIZE; \
-GLOBAL(name)
+#define SYM_DATA_START_PTI_ALIGNED(name) \
+	SYM_START(name, SYM_L_GLOBAL, .balign 2 * PAGE_SIZE)
 #else
-#define NEXT_PGD_PAGE(name) NEXT_PAGE(name)
+#define SYM_DATA_START_PTI_ALIGNED(name) \
+	SYM_DATA_START_PAGE_ALIGNED(name)
 #define PTI_USER_PGD_FILL	0
 #endif
 
@@ -375,17 +371,19 @@ GLOBAL(name)
 	.endr
 
 	__INITDATA
-NEXT_PGD_PAGE(early_top_pgt)
+SYM_DATA_START_PTI_ALIGNED(early_top_pgt)
 	.fill	512,8,0
 	.fill	PTI_USER_PGD_FILL,8,0
+SYM_DATA_END(early_top_pgt)
 
-NEXT_PAGE(early_dynamic_pgts)
+SYM_DATA_START_PAGE_ALIGNED(early_dynamic_pgts)
 	.fill	512*EARLY_DYNAMIC_PAGE_TABLES,8,0
+SYM_DATA_END(early_dynamic_pgts)
 
 	.data
 
 #if defined(CONFIG_XEN_PV) || defined(CONFIG_PVH)
-NEXT_PGD_PAGE(init_top_pgt)
+SYM_DATA_START_PTI_ALIGNED(init_top_pgt)
 	.quad   level3_ident_pgt - __START_KERNEL_map + _KERNPG_TABLE_NOENC
 	.org    init_top_pgt + L4_PAGE_OFFSET*8, 0
 	.quad   level3_ident_pgt - __START_KERNEL_map + _KERNPG_TABLE_NOENC
@@ -393,11 +391,13 @@ NEXT_PGD_PAGE(init_top_pgt)
 	/* (2^48-(2*1024*1024*1024))/(2^39) = 511 */
 	.quad   level3_kernel_pgt - __START_KERNEL_map + _PAGE_TABLE_NOENC
 	.fill	PTI_USER_PGD_FILL,8,0
+SYM_DATA_END(init_top_pgt)
 
-NEXT_PAGE(level3_ident_pgt)
+SYM_DATA_START_PAGE_ALIGNED(level3_ident_pgt)
 	.quad	level2_ident_pgt - __START_KERNEL_map + _KERNPG_TABLE_NOENC
 	.fill	511, 8, 0
-NEXT_PAGE(level2_ident_pgt)
+SYM_DATA_END(level3_ident_pgt)
+SYM_DATA_START_PAGE_ALIGNED(level2_ident_pgt)
 	/*
 	 * Since I easily can, map the first 1G.
 	 * Don't set NX because code runs from these pages.
@@ -407,25 +407,29 @@ NEXT_PAGE(level2_ident_pgt)
 	 * the CPU should ignore the bit.
 	 */
 	PMDS(0, __PAGE_KERNEL_IDENT_LARGE_EXEC, PTRS_PER_PMD)
+SYM_DATA_END(level2_ident_pgt)
 #else
-NEXT_PGD_PAGE(init_top_pgt)
+SYM_DATA_START_PTI_ALIGNED(init_top_pgt)
 	.fill	512,8,0
 	.fill	PTI_USER_PGD_FILL,8,0
+SYM_DATA_END(init_top_pgt)
 #endif
 
 #ifdef CONFIG_X86_5LEVEL
-NEXT_PAGE(level4_kernel_pgt)
+SYM_DATA_START_PAGE_ALIGNED(level4_kernel_pgt)
 	.fill	511,8,0
 	.quad	level3_kernel_pgt - __START_KERNEL_map + _PAGE_TABLE_NOENC
+SYM_DATA_END(level4_kernel_pgt)
 #endif
 
-NEXT_PAGE(level3_kernel_pgt)
+SYM_DATA_START_PAGE_ALIGNED(level3_kernel_pgt)
 	.fill	L3_START_KERNEL,8,0
 	/* (2^48-(2*1024*1024*1024)-((2^39)*511))/(2^30) = 510 */
 	.quad	level2_kernel_pgt - __START_KERNEL_map + _KERNPG_TABLE_NOENC
 	.quad	level2_fixmap_pgt - __START_KERNEL_map + _PAGE_TABLE_NOENC
+SYM_DATA_END(level3_kernel_pgt)
 
-NEXT_PAGE(level2_kernel_pgt)
+SYM_DATA_START_PAGE_ALIGNED(level2_kernel_pgt)
 	/*
 	 * 512 MB kernel mapping. We spend a full page on this pagetable
 	 * anyway.
@@ -442,8 +446,9 @@ NEXT_PAGE(level2_kernel_pgt)
 	 */
 	PMDS(0, __PAGE_KERNEL_LARGE_EXEC,
 		KERNEL_IMAGE_SIZE/PMD_SIZE)
+SYM_DATA_END(level2_kernel_pgt)
 
-NEXT_PAGE(level2_fixmap_pgt)
+SYM_DATA_START_PAGE_ALIGNED(level2_fixmap_pgt)
 	.fill	(512 - 4 - FIXMAP_PMD_NUM),8,0
 	pgtno = 0
 	.rept (FIXMAP_PMD_NUM)
@@ -453,21 +458,21 @@ NEXT_PAGE(level2_fixmap_pgt)
 	.endr
 	/* 6 MB reserved space + a 2MB hole */
 	.fill	4,8,0
+SYM_DATA_END(level2_fixmap_pgt)
 
-NEXT_PAGE(level1_fixmap_pgt)
+SYM_DATA_START_PAGE_ALIGNED(level1_fixmap_pgt)
 	.rept (FIXMAP_PMD_NUM)
 	.fill	512,8,0
 	.endr
+SYM_DATA_END(level1_fixmap_pgt)
 
 #undef PMDS
 
 	.data
 	.align 16
-	.globl early_gdt_descr
-early_gdt_descr:
-	.word	GDT_ENTRIES*8-1
-early_gdt_descr_base:
-	.quad	INIT_PER_CPU_VAR(gdt_page)
+
+SYM_DATA(early_gdt_descr,		.word GDT_ENTRIES*8-1)
+SYM_DATA_LOCAL(early_gdt_descr_base,	.quad INIT_PER_CPU_VAR(gdt_page))
 
 /* This must match the first entry in level2_kernel_pgt */
 SYM_DATA(phys_base, .quad 0x0000000000000000)
@@ -476,7 +481,8 @@ EXPORT_SYMBOL(phys_base)
 #include "../../x86/xen/xen-head.S"
 
 	__PAGE_ALIGNED_BSS
-NEXT_PAGE(empty_zero_page)
+SYM_DATA_START_PAGE_ALIGNED(empty_zero_page)
 	.skip PAGE_SIZE
+SYM_DATA_END(empty_zero_page)
 EXPORT_SYMBOL(empty_zero_page)
 
-- 
2.22.0

