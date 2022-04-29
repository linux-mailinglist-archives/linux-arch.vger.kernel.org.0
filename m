Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5163F5145C1
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 11:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356794AbiD2Jtb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 05:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356894AbiD2JtA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 05:49:00 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72662A94CD;
        Fri, 29 Apr 2022 02:45:42 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KqSJB5Y1zz1JBnl;
        Fri, 29 Apr 2022 17:44:42 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 17:45:15 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 17:45:15 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arch@vger.kernel.org>
CC:     <jthierry@redhat.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <masahiroy@kernel.org>, <jpoimboe@redhat.com>,
        <peterz@infradead.org>, <ycote@redhat.com>,
        <herbert@gondor.apana.org.au>, <mark.rutland@arm.com>,
        <davem@davemloft.net>, <ardb@kernel.org>, <maz@kernel.org>,
        <tglx@linutronix.de>, <luc.vanoostenryck@gmail.com>,
        <chenzhongjin@huawei.com>
Subject: [RFC PATCH v4 33/37] arm64: Annotate ASM symbols with unknown stack state
Date:   Fri, 29 Apr 2022 17:43:51 +0800
Message-ID: <20220429094355.122389-34-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220429094355.122389-1-chenzhongjin@huawei.com>
References: <20220429094355.122389-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Some assembly symbols contain code that might be executed with an
unspecified stack state (e.g. invalid stack pointer,
no stackframe, ...).

Annotate those symbol with UNWIND_HINT_EMPTY to let objtool be aware of
them.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 arch/arm64/include/asm/assembler.h  |  2 ++
 arch/arm64/kernel/cpu-reset.S       |  2 ++
 arch/arm64/kernel/efi-entry.S       |  2 ++
 arch/arm64/kernel/entry.S           |  5 +++++
 arch/arm64/kernel/head.S            | 13 +++++++++++++
 arch/arm64/kernel/hibernate-asm.S   |  2 ++
 arch/arm64/kernel/relocate_kernel.S |  2 ++
 arch/arm64/kernel/sleep.S           |  3 +++
 arch/arm64/kvm/hyp/hyp-entry.S      |  3 +++
 9 files changed, 34 insertions(+)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 8c5a61aeaf8e..68db05428e4b 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -25,6 +25,7 @@
 #include <asm/pgtable-hwdef.h>
 #include <asm/ptrace.h>
 #include <asm/thread_info.h>
+#include <asm/unwind_hints.h>
 
 	/*
 	 * Provide a wxN alias for each wN register so what we can paste a xN
@@ -147,6 +148,7 @@ lr	.req	x30		// link register
  */
 	 .macro	ventry	label
 	.align	7
+	UNWIND_HINT_EMPTY
 	b	\label
 	.endm
 
diff --git a/arch/arm64/kernel/cpu-reset.S b/arch/arm64/kernel/cpu-reset.S
index 48a8af97faa9..c9022042bdec 100644
--- a/arch/arm64/kernel/cpu-reset.S
+++ b/arch/arm64/kernel/cpu-reset.S
@@ -10,6 +10,7 @@
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/sysreg.h>
+#include <asm/unwind_hints.h>
 #include <asm/virt.h>
 
 .text
@@ -29,6 +30,7 @@
  * flat identity mapping.
  */
 SYM_CODE_START(cpu_soft_restart)
+	UNWIND_HINT_EMPTY
 	mov_q	x12, INIT_SCTLR_EL1_MMU_OFF
 	pre_disable_mmu_workaround
 	/*
diff --git a/arch/arm64/kernel/efi-entry.S b/arch/arm64/kernel/efi-entry.S
index 61a87fa1c305..9a1a94c3c4db 100644
--- a/arch/arm64/kernel/efi-entry.S
+++ b/arch/arm64/kernel/efi-entry.S
@@ -9,10 +9,12 @@
 #include <linux/init.h>
 
 #include <asm/assembler.h>
+#include <asm/unwind_hints.h>
 
 	__INIT
 
 SYM_CODE_START(efi_enter_kernel)
+	UNWIND_HINT_EMPTY
 	/*
 	 * efi_pe_entry() will have copied the kernel image if necessary and we
 	 * end up here with device tree address in x1 and the kernel entry
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 0af74fd59510..10fac8f13982 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -29,6 +29,7 @@
 #include <asm/thread_info.h>
 #include <asm/asm-uaccess.h>
 #include <asm/unistd.h>
+#include <asm/unwind_hints.h>
 
 	.macro	clear_gp_regs
 	.irp	n,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29
@@ -38,6 +39,7 @@
 
 	.macro kernel_ventry, el:req, ht:req, regsize:req, label:req
 	.align 7
+	UNWIND_HINT_EMPTY
 .Lventry_start\@:
 	.if	\el == 0
 	/*
@@ -663,6 +665,7 @@ alternative_else_nop_endif
 
 	.macro tramp_ventry, vector_start, regsize, kpti, bhb
 	.align	7
+	UNWIND_HINT_EMPTY
 1:
 	.if	\regsize == 64
 	msr	tpidrro_el0, x30	// Restored in kernel_ventry
@@ -764,10 +767,12 @@ SYM_CODE_START_NOALIGN(tramp_vectors)
 SYM_CODE_END(tramp_vectors)
 
 SYM_CODE_START_LOCAL(tramp_exit_native)
+	UNWIND_HINT_EMPTY
 	tramp_exit
 SYM_CODE_END(tramp_exit_native)
 
 SYM_CODE_START_LOCAL(tramp_exit_compat)
+	UNWIND_HINT_EMPTY
 	tramp_exit	32
 SYM_CODE_END(tramp_exit_compat)
 
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 64527718d4c2..e45e33f169b7 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -33,6 +33,7 @@
 #include <asm/smp.h>
 #include <asm/sysreg.h>
 #include <asm/thread_info.h>
+#include <asm/unwind_hints.h>
 #include <asm/virt.h>
 
 #include "efi-header.S"
@@ -63,6 +64,7 @@
 	 * DO NOT MODIFY. Image header expected by Linux boot-loaders.
 	 */
 SYM_DATA_LOCAL(efi_nop, efi_signature_nop)	// special NOP to identity as PE/COFF executable
+	UNWIND_HINT_EMPTY
 	b	primary_entry			// branch to kernel start, magic
 SYM_DATA_LOCAL(_zero_reserved, .quad	0)	// Image load offset from start of RAM, little-endian
 SYM_DATA_START_LOCAL(_arm64_common_header)
@@ -111,6 +113,7 @@ SYM_CODE_END(primary_entry)
  * Preserve the arguments passed by the bootloader in x0 .. x3
  */
 SYM_CODE_START_LOCAL(preserve_boot_args)
+	UNWIND_HINT_EMPTY
 	mov	x21, x0				// x21=FDT
 
 	adr_l	x0, boot_args			// record the contents of
@@ -262,6 +265,7 @@ SYM_CODE_END(preserve_boot_args)
  *     been enabled
  */
 SYM_CODE_START_LOCAL(__create_page_tables)
+	UNWIND_HINT_EMPTY
 	mov	x28, lr
 
 	/*
@@ -496,6 +500,7 @@ EXPORT_SYMBOL(kimage_vaddr)
  * booted in EL1 or EL2 respectively.
  */
 SYM_CODE_START(init_kernel_el)
+	UNWIND_HINT_EMPTY
 	mrs	x0, CurrentEL
 	cmp	x0, #CurrentEL_EL2
 	b.eq	init_el2
@@ -566,6 +571,7 @@ SYM_CODE_END(init_kernel_el)
  * in w0. See arch/arm64/include/asm/virt.h for more info.
  */
 SYM_CODE_START_LOCAL(set_cpu_boot_mode_flag)
+	UNWIND_HINT_EMPTY
 	adr_l	x1, __boot_cpu_mode
 	cmp	w0, #BOOT_CPU_MODE_EL2
 	b.ne	1f
@@ -609,6 +615,7 @@ SYM_DATA_END(__early_cpu_boot_status)
 	 * cores are held until we're ready for them to initialise.
 	 */
 SYM_CODE_START(secondary_holding_pen)
+	UNWIND_HINT_EMPTY
 	bl	init_kernel_el			// w0=cpu_boot_mode
 	bl	set_cpu_boot_mode_flag
 	mrs	x0, mpidr_el1
@@ -627,6 +634,7 @@ SYM_CODE_END(secondary_holding_pen)
 	 * be used where CPUs are brought online dynamically by the kernel.
 	 */
 SYM_CODE_START(secondary_entry)
+	UNWIND_HINT_EMPTY
 	bl	init_kernel_el			// w0=cpu_boot_mode
 	bl	set_cpu_boot_mode_flag
 	b	secondary_startup
@@ -646,6 +654,7 @@ SYM_CODE_START_LOCAL(secondary_startup)
 SYM_CODE_END(secondary_startup)
 
 SYM_CODE_START_LOCAL(__secondary_switched)
+	UNWIND_HINT_EMPTY
 	adr_l	x5, vectors
 	msr	vbar_el1, x5
 	isb
@@ -665,6 +674,7 @@ SYM_CODE_START_LOCAL(__secondary_switched)
 SYM_CODE_END(__secondary_switched)
 
 SYM_CODE_START_LOCAL(__secondary_too_slow)
+	UNWIND_HINT_EMPTY
 	wfe
 	wfi
 	b	__secondary_too_slow
@@ -701,6 +711,7 @@ SYM_CODE_END(__secondary_too_slow)
  * If it isn't, park the CPU
  */
 SYM_CODE_START(__enable_mmu)
+	UNWIND_HINT_EMPTY
 	mrs	x2, ID_AA64MMFR0_EL1
 	ubfx	x2, x2, #ID_AA64MMFR0_TGRAN_SHIFT, 4
 	cmp     x2, #ID_AA64MMFR0_TGRAN_SUPPORTED_MIN
@@ -722,6 +733,7 @@ SYM_CODE_START(__enable_mmu)
 SYM_CODE_END(__enable_mmu)
 
 SYM_CODE_START_LOCAL(__cpu_secondary_check52bitva)
+	UNWIND_HINT_EMPTY
 #ifdef CONFIG_ARM64_VA_BITS_52
 	ldr_l	x0, vabits_actual
 	cmp	x0, #52
@@ -753,6 +765,7 @@ SYM_CODE_END(__no_granule_support)
 
 #ifdef CONFIG_RELOCATABLE
 SYM_CODE_START_LOCAL(__relocate_kernel)
+	UNWIND_HINT_EMPTY
 	/*
 	 * Iterate over each entry in the relocation table, and apply the
 	 * relocations in place.
diff --git a/arch/arm64/kernel/hibernate-asm.S b/arch/arm64/kernel/hibernate-asm.S
index 0e1d9c3c6a93..c0bec20bf0e0 100644
--- a/arch/arm64/kernel/hibernate-asm.S
+++ b/arch/arm64/kernel/hibernate-asm.S
@@ -13,6 +13,7 @@
 #include <asm/cputype.h>
 #include <asm/memory.h>
 #include <asm/page.h>
+#include <asm/unwind_hints.h>
 #include <asm/virt.h>
 
 /*
@@ -46,6 +47,7 @@
  */
 .pushsection    ".hibernate_exit.text", "ax"
 SYM_CODE_START(swsusp_arch_suspend_exit)
+	UNWIND_HINT_EMPTY
 	/*
 	 * We execute from ttbr0, change ttbr1 to our copied linear map tables
 	 * with a break-before-make via the zero page
diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index f0a3df9e18a3..f8cd8fcf2d4f 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -16,6 +16,7 @@
 #include <asm/page.h>
 #include <asm/sysreg.h>
 #include <asm/virt.h>
+#include <asm/unwind_hints.h>
 
 .macro turn_off_mmu tmp1, tmp2
 	mov_q   \tmp1, INIT_SCTLR_EL1_MMU_OFF
@@ -37,6 +38,7 @@
  * safe memory that has been set up to be preserved during the copy operation.
  */
 SYM_CODE_START(arm64_relocate_new_kernel)
+	UNWIND_HINT_EMPTY
 	/* Setup the list loop variables. */
 	ldr	x18, [x0, #KIMAGE_ARCH_ZERO_PAGE] /* x18 = zero page for BBM */
 	ldr	x17, [x0, #KIMAGE_ARCH_TTBR1]	/* x17 = linear map copy */
diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
index e01a24b5c5f7..7fd276f3c532 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -4,6 +4,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/assembler.h>
 #include <asm/smp.h>
+#include <asm/unwind_hints.h>
 
 	.text
 /*
@@ -100,6 +101,7 @@ SYM_FUNC_END(__cpu_suspend_enter)
 
 	.pushsection ".idmap.text", "awx"
 SYM_CODE_START(cpu_resume)
+	UNWIND_HINT_EMPTY
 	bl	init_kernel_el
 	bl	switch_to_vhe
 	bl	__cpu_setup
@@ -113,6 +115,7 @@ SYM_CODE_END(cpu_resume)
 	.popsection
 
 SYM_CODE_START(_cpu_resume)
+	UNWIND_HINT_EMPTY
 	mrs	x1, mpidr_el1
 	adr_l	x8, mpidr_hash		// x8 = struct mpidr_hash virt address
 
diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
index 7839d075729b..a93af0730da0 100644
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -14,6 +14,7 @@
 #include <asm/kvm_asm.h>
 #include <asm/mmu.h>
 #include <asm/spectre.h>
+#include <asm/unwind_hints.h>
 
 .macro save_caller_saved_regs_vect
 	/* x0 and x1 were saved in the vector entry */
@@ -150,6 +151,7 @@ SYM_CODE_END(\label)
 
 .macro valid_vect target
 	.align 7
+        UNWIND_HINT_EMPTY
 661:
 	esb
 	stp	x0, x1, [sp, #-16]!
@@ -161,6 +163,7 @@ check_preamble_length 661b, 662b
 
 .macro invalid_vect target
 	.align 7
+        UNWIND_HINT_EMPTY
 661:
 	nop
 	stp	x0, x1, [sp, #-16]!
-- 
2.17.1

