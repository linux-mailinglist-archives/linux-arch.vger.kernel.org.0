Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F48E55709A
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jun 2022 03:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378053AbiFWBxQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jun 2022 21:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377464AbiFWBwH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jun 2022 21:52:07 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66CB43AEC;
        Wed, 22 Jun 2022 18:51:51 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LT37F0lDfzShBv;
        Thu, 23 Jun 2022 09:48:25 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 23 Jun 2022 09:51:49 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 23 Jun 2022 09:51:49 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kbuild@vger.kernel.org>, <live-patching@vger.kernel.org>
CC:     <jpoimboe@kernel.org>, <peterz@infradead.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <masahiroy@kernel.org>, <michal.lkml@markovi.net>,
        <ndesaulniers@google.com>, <mark.rutland@arm.com>,
        <pasha.tatashin@soleen.com>, <broonie@kernel.org>,
        <chenzhongjin@huawei.com>, <rmk+kernel@armlinux.org.uk>,
        <madvenka@linux.microsoft.com>, <christophe.leroy@csgroup.eu>,
        <daniel.thompson@linaro.org>
Subject: [PATCH v6 19/33] arm64: Annotate unwind_hint for symbols with empty stack
Date:   Thu, 23 Jun 2022 09:49:03 +0800
Message-ID: <20220623014917.199563-20-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220623014917.199563-1-chenzhongjin@huawei.com>
References: <20220623014917.199563-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Some assembly symbols contain code that might be executed with an
unspecified stack state (e.g. invalid stack pointer,
no stackframe, code after alt_cb, ...).

Annotate those symbol with UNWIND_HINT_EMPTY to let objtool be aware of
them.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 arch/arm64/include/asm/assembler.h  |  2 ++
 arch/arm64/kernel/cpu-reset.S       |  2 ++
 arch/arm64/kernel/efi-entry.S       |  2 ++
 arch/arm64/kernel/entry.S           |  7 +++++++
 arch/arm64/kernel/head.S            | 14 ++++++++++++++
 arch/arm64/kernel/hibernate-asm.S   |  2 ++
 arch/arm64/kernel/relocate_kernel.S |  2 ++
 arch/arm64/kernel/sleep.S           |  3 +++
 arch/arm64/kvm/hyp/hyp-entry.S      |  1 +
 arch/arm64/mm/trans_pgd-asm.S       |  3 +++
 10 files changed, 38 insertions(+)

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
index c460ba2d009d..3bd11101e79d 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -28,6 +28,7 @@
 #include <asm/thread_info.h>
 #include <asm/asm-uaccess.h>
 #include <asm/unistd.h>
+#include <asm/unwind_hints.h>
 
 	.macro	clear_gp_regs
 	.irp	n,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29
@@ -37,6 +38,7 @@
 
 	.macro kernel_ventry, el:req, ht:req, regsize:req, label:req
 	.align 7
+	UNWIND_HINT_EMPTY
 .Lventry_start\@:
 	.if	\el == 0
 	/*
@@ -44,6 +46,7 @@
 	 * skipped by the trampoline vectors, to trigger the cleanup.
 	 */
 	b	.Lskip_tramp_vectors_cleanup\@
+	UNWIND_HINT_EMPTY
 	.if	\regsize == 64
 	mrs	x30, tpidrro_el0
 	msr	tpidrro_el0, xzr
@@ -417,6 +420,7 @@ alternative_else_nop_endif
 	ldp	x24, x25, [sp, #16 * 12]
 	ldp	x26, x27, [sp, #16 * 13]
 	ldp	x28, x29, [sp, #16 * 14]
+	UNWIND_HINT_EMPTY
 
 	.if	\el == 0
 alternative_if_not ARM64_UNMAP_KERNEL_AT_EL0
@@ -662,6 +666,7 @@ alternative_else_nop_endif
 
 	.macro tramp_ventry, vector_start, regsize, kpti, bhb
 	.align	7
+	UNWIND_HINT_EMPTY
 1:
 	.if	\regsize == 64
 	msr	tpidrro_el0, x30	// Restored in kernel_ventry
@@ -687,6 +692,7 @@ alternative_else_nop_endif
 	 * enter the full-fat kernel vectors.
 	 */
 	bl	2f
+	UNWIND_HINT_EMPTY
 	b	.
 2:
 	tramp_map_kernel	x30
@@ -717,6 +723,7 @@ alternative_else_nop_endif
 	.endm
 
 	.macro tramp_exit, regsize = 64
+	UNWIND_HINT_EMPTY
 	tramp_data_read_var	x30, this_cpu_vector
 	get_this_cpu_offset x29
 	ldr	x30, [x30, x29]
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 6db9c3603bd8..2a66d18091eb 100644
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
 	efi_signature_nop			// special NOP to identity as PE/COFF executable
+	UNWIND_HINT_EMPTY
 	b	primary_entry			// branch to kernel start, magic
 	.quad	0				// Image load offset from start of RAM, little-endian
 	le64sym	_kernel_size_le			// Effective size of kernel image, little-endian
@@ -109,6 +111,7 @@ SYM_CODE_END(primary_entry)
  * Preserve the arguments passed by the bootloader in x0 .. x3
  */
 SYM_CODE_START_LOCAL(preserve_boot_args)
+	UNWIND_HINT_EMPTY
 	mov	x21, x0				// x21=FDT
 
 	adr_l	x0, boot_args			// record the contents of
@@ -260,6 +263,7 @@ SYM_CODE_END(preserve_boot_args)
  *     been enabled
  */
 SYM_CODE_START_LOCAL(__create_page_tables)
+	UNWIND_HINT_EMPTY
 	mov	x28, lr
 
 	/*
@@ -494,6 +498,7 @@ EXPORT_SYMBOL(kimage_vaddr)
  * booted in EL1 or EL2 respectively.
  */
 SYM_CODE_START(init_kernel_el)
+	UNWIND_HINT_EMPTY
 	mrs	x0, CurrentEL
 	cmp	x0, #CurrentEL_EL2
 	b.eq	init_el2
@@ -553,6 +558,7 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
 	eret
 
 __cpu_stick_to_vhe:
+	UNWIND_HINT_EMPTY
 	mov	x0, #HVC_VHE_RESTART
 	hvc	#0
 	mov	x0, #BOOT_CPU_MODE_EL2
@@ -564,6 +570,7 @@ SYM_CODE_END(init_kernel_el)
  * in w0. See arch/arm64/include/asm/virt.h for more info.
  */
 SYM_CODE_START_LOCAL(set_cpu_boot_mode_flag)
+	UNWIND_HINT_EMPTY
 	adr_l	x1, __boot_cpu_mode
 	cmp	w0, #BOOT_CPU_MODE_EL2
 	b.ne	1f
@@ -607,6 +614,7 @@ SYM_DATA_END(__early_cpu_boot_status)
 	 * cores are held until we're ready for them to initialise.
 	 */
 SYM_CODE_START(secondary_holding_pen)
+	UNWIND_HINT_EMPTY
 	bl	init_kernel_el			// w0=cpu_boot_mode
 	bl	set_cpu_boot_mode_flag
 	mrs	x0, mpidr_el1
@@ -625,6 +633,7 @@ SYM_CODE_END(secondary_holding_pen)
 	 * be used where CPUs are brought online dynamically by the kernel.
 	 */
 SYM_CODE_START(secondary_entry)
+	UNWIND_HINT_EMPTY
 	bl	init_kernel_el			// w0=cpu_boot_mode
 	bl	set_cpu_boot_mode_flag
 	b	secondary_startup
@@ -644,6 +653,7 @@ SYM_CODE_START_LOCAL(secondary_startup)
 SYM_CODE_END(secondary_startup)
 
 SYM_CODE_START_LOCAL(__secondary_switched)
+	UNWIND_HINT_EMPTY
 	adr_l	x5, vectors
 	msr	vbar_el1, x5
 	isb
@@ -663,6 +673,7 @@ SYM_CODE_START_LOCAL(__secondary_switched)
 SYM_CODE_END(__secondary_switched)
 
 SYM_CODE_START_LOCAL(__secondary_too_slow)
+	UNWIND_HINT_EMPTY
 	wfe
 	wfi
 	b	__secondary_too_slow
@@ -699,6 +710,7 @@ SYM_CODE_END(__secondary_too_slow)
  * If it isn't, park the CPU
  */
 SYM_CODE_START(__enable_mmu)
+	UNWIND_HINT_EMPTY
 	mrs	x2, ID_AA64MMFR0_EL1
 	ubfx	x2, x2, #ID_AA64MMFR0_TGRAN_SHIFT, 4
 	cmp     x2, #ID_AA64MMFR0_TGRAN_SUPPORTED_MIN
@@ -720,6 +732,7 @@ SYM_CODE_START(__enable_mmu)
 SYM_CODE_END(__enable_mmu)
 
 SYM_CODE_START_LOCAL(__cpu_secondary_check52bitva)
+	UNWIND_HINT_EMPTY
 #ifdef CONFIG_ARM64_VA_BITS_52
 	ldr_l	x0, vabits_actual
 	cmp	x0, #52
@@ -751,6 +764,7 @@ SYM_CODE_END(__no_granule_support)
 
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
index f0087e8bcd28..799ec01b0649 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -4,6 +4,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/assembler.h>
 #include <asm/smp.h>
+#include <asm/unwind_hints.h>
 
 	.text
 /*
@@ -99,6 +100,7 @@ SYM_FUNC_END(__cpu_suspend_enter)
 
 	.pushsection ".idmap.text", "awx"
 SYM_CODE_START(cpu_resume)
+	UNWIND_HINT_EMPTY
 	bl	init_kernel_el
 	bl	switch_to_vhe
 	bl	__cpu_setup
@@ -112,6 +114,7 @@ SYM_CODE_END(cpu_resume)
 	.popsection
 
 SYM_CODE_START(_cpu_resume)
+	UNWIND_HINT_EMPTY
 	mrs	x1, mpidr_el1
 	adr_l	x8, mpidr_hash		// x8 = struct mpidr_hash virt address
 
diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
index 7839d075729b..4a65262a4f3a 100644
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -14,6 +14,7 @@
 #include <asm/kvm_asm.h>
 #include <asm/mmu.h>
 #include <asm/spectre.h>
+#include <asm/unwind_hints.h>
 
 .macro save_caller_saved_regs_vect
 	/* x0 and x1 were saved in the vector entry */
diff --git a/arch/arm64/mm/trans_pgd-asm.S b/arch/arm64/mm/trans_pgd-asm.S
index 021c31573bcb..148435248860 100644
--- a/arch/arm64/mm/trans_pgd-asm.S
+++ b/arch/arm64/mm/trans_pgd-asm.S
@@ -8,10 +8,12 @@
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/kvm_asm.h>
+#include <asm/unwind_hints.h>
 
 .macro invalid_vector	label
 SYM_CODE_START_LOCAL(\label)
 	.align 7
+	UNWIND_HINT_EMPTY
 	b	\label
 SYM_CODE_END(\label)
 .endm
@@ -19,6 +21,7 @@ SYM_CODE_END(\label)
 .macro el1_sync_vector
 SYM_CODE_START_LOCAL(el1_sync)
 	.align 7
+	UNWIND_HINT_EMPTY
 	cmp	x0, #HVC_SET_VECTORS	/* Called from hibernate */
 	b.ne	1f
 	msr	vbar_el2, x1
-- 
2.17.1

