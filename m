Return-Path: <linux-arch+bounces-14861-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DA83FC69175
	for <lists+linux-arch@lfdr.de>; Tue, 18 Nov 2025 12:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B724D4F11CB
	for <lists+linux-arch@lfdr.de>; Tue, 18 Nov 2025 11:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1952D352944;
	Tue, 18 Nov 2025 11:28:51 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2CE34F46F;
	Tue, 18 Nov 2025 11:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763465331; cv=none; b=hZV6giCjhmywlb4/t/WGSEmxDDWddJMK6vJWOwu+9w4monPimCcCWMHt7tmgRQXj3QGGF6ecsNzkLz9urQlQ1neUL2g2TKpfu/sA0v3LtMQ4PJ6Eb9uuiTHHj9PStoaaZ8H2gAX4MRHtK89d0a9cT8vyo9ExOHd5o4KVoC+4ITg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763465331; c=relaxed/simple;
	bh=hxX8+PyeVIBWYsyqaEOq/F6FjpcAgQzoJb7jE00yxqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T5Mw7XqSazi/UUkVGe9Wpdz/TU0WtVzDVFtaL5krYBXcr7ffbac3FR4bEjoJkkw25zH6gad3UUSLjKfPPmYufCUd5lDs+XxNymNpzr9H548nuuAV9/deb7NO5EzRa8VGdsOolHjTeErzK1u8mCbjYO04KyZojwcvPs1iJvOmrK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF98C4CEF1;
	Tue, 18 Nov 2025 11:28:47 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Arnd Bergmann <arnd@arndb.de>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-arch@vger.kernel.org,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V2 04/14] LoongArch: Adjust boot & setup for 32BIT/64BIT
Date: Tue, 18 Nov 2025 19:27:18 +0800
Message-ID: <20251118112728.571869-5-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251118112728.571869-1-chenhuacai@loongson.cn>
References: <20251118112728.571869-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjust boot & setup for both 32BIT and 64BIT, including: efi header
definition, MAX_IO_PICS definition, kernel entry and environment setup
routines, etc.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/addrspace.h |  2 +-
 arch/loongarch/include/asm/irq.h       |  5 ++++
 arch/loongarch/kernel/efi-header.S     |  4 +++
 arch/loongarch/kernel/efi.c            |  4 ++-
 arch/loongarch/kernel/env.c            |  9 ++++--
 arch/loongarch/kernel/head.S           | 39 +++++++++++---------------
 arch/loongarch/kernel/relocate.c       |  9 +++++-
 7 files changed, 45 insertions(+), 27 deletions(-)

diff --git a/arch/loongarch/include/asm/addrspace.h b/arch/loongarch/include/asm/addrspace.h
index e739dbc6329d..9766a100504a 100644
--- a/arch/loongarch/include/asm/addrspace.h
+++ b/arch/loongarch/include/asm/addrspace.h
@@ -42,7 +42,7 @@ extern unsigned long vm_map_base;
 #endif
 
 #define DMW_PABITS	48
-#define TO_PHYS_MASK	((1ULL << DMW_PABITS) - 1)
+#define TO_PHYS_MASK	((_ULL(1) << _ULL(DMW_PABITS)) - 1)
 
 /*
  * Memory above this physical address will be considered highmem.
diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/irq.h
index 12bd15578c33..cf6c82a9117b 100644
--- a/arch/loongarch/include/asm/irq.h
+++ b/arch/loongarch/include/asm/irq.h
@@ -53,7 +53,12 @@ void spurious_interrupt(void);
 #define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
 void arch_trigger_cpumask_backtrace(const struct cpumask *mask, int exclude_cpu);
 
+#ifdef CONFIG_32BIT
+#define MAX_IO_PICS 1
+#else
 #define MAX_IO_PICS 8
+#endif
+
 #define NR_IRQS	(64 + NR_VECTORS * (NR_CPUS + MAX_IO_PICS))
 
 struct acpi_vector_group {
diff --git a/arch/loongarch/kernel/efi-header.S b/arch/loongarch/kernel/efi-header.S
index ba0bdbf86aa8..6df56241cb95 100644
--- a/arch/loongarch/kernel/efi-header.S
+++ b/arch/loongarch/kernel/efi-header.S
@@ -9,7 +9,11 @@
 	.macro	__EFI_PE_HEADER
 	.long	IMAGE_NT_SIGNATURE
 .Lcoff_header:
+#ifdef CONFIG_32BIT
+	.short	IMAGE_FILE_MACHINE_LOONGARCH32		/* Machine */
+#else
 	.short	IMAGE_FILE_MACHINE_LOONGARCH64		/* Machine */
+#endif
 	.short	.Lsection_count				/* NumberOfSections */
 	.long	0 					/* TimeDateStamp */
 	.long	0					/* PointerToSymbolTable */
diff --git a/arch/loongarch/kernel/efi.c b/arch/loongarch/kernel/efi.c
index 860a3bc030e0..52c21c895318 100644
--- a/arch/loongarch/kernel/efi.c
+++ b/arch/loongarch/kernel/efi.c
@@ -115,7 +115,9 @@ void __init efi_init(void)
 
 	efi_systab_report_header(&efi_systab->hdr, efi_systab->fw_vendor);
 
-	set_bit(EFI_64BIT, &efi.flags);
+	if (IS_ENABLED(CONFIG_64BIT))
+		set_bit(EFI_64BIT, &efi.flags);
+
 	efi_nr_tables	 = efi_systab->nr_tables;
 	efi_config_table = (unsigned long)efi_systab->tables;
 
diff --git a/arch/loongarch/kernel/env.c b/arch/loongarch/kernel/env.c
index 23bd5ae2212c..3e8a25eb901b 100644
--- a/arch/loongarch/kernel/env.c
+++ b/arch/loongarch/kernel/env.c
@@ -68,18 +68,23 @@ static int __init fdt_cpu_clk_init(void)
 
 	np = of_get_cpu_node(0, NULL);
 	if (!np)
-		return -ENODEV;
+		goto fallback;
 
 	clk = of_clk_get(np, 0);
 	of_node_put(np);
 
 	if (IS_ERR(clk))
-		return -ENODEV;
+		goto fallback;
 
 	cpu_clock_freq = clk_get_rate(clk);
 	clk_put(clk);
 
 	return 0;
+
+fallback:
+	cpu_clock_freq = 200 * 1000 * 1000;
+
+	return -ENODEV;
 }
 late_initcall(fdt_cpu_clk_init);
 
diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
index e3865e92a917..aba548db2446 100644
--- a/arch/loongarch/kernel/head.S
+++ b/arch/loongarch/kernel/head.S
@@ -43,36 +43,29 @@ SYM_DATA(kernel_fsize, .long _kernel_fsize);
 
 SYM_CODE_START(kernel_entry)			# kernel entry point
 
-	/* Config direct window and set PG */
-	SETUP_DMWINS	t0
+	SETUP_TWINS
+	SETUP_MODES	t0
 	JUMP_VIRT_ADDR	t0, t1
-
-	/* Enable PG */
-	li.w		t0, 0xb0		# PLV=0, IE=0, PG=1
-	csrwr		t0, LOONGARCH_CSR_CRMD
-	li.w		t0, 0x04		# PLV=0, PIE=1, PWE=0
-	csrwr		t0, LOONGARCH_CSR_PRMD
-	li.w		t0, 0x00		# FPE=0, SXE=0, ASXE=0, BTE=0
-	csrwr		t0, LOONGARCH_CSR_EUEN
+	SETUP_DMWINS	t0
 
 	la.pcrel	t0, __bss_start		# clear .bss
-	st.d		zero, t0, 0
+	LONG_S		zero, t0, 0
 	la.pcrel	t1, __bss_stop - LONGSIZE
 1:
-	addi.d		t0, t0, LONGSIZE
-	st.d		zero, t0, 0
+	PTR_ADDI	t0, t0, LONGSIZE
+	LONG_S		zero, t0, 0
 	bne		t0, t1, 1b
 
 	la.pcrel	t0, fw_arg0
-	st.d		a0, t0, 0		# firmware arguments
+	PTR_S		a0, t0, 0		# firmware arguments
 	la.pcrel	t0, fw_arg1
-	st.d		a1, t0, 0
+	PTR_S		a1, t0, 0
 	la.pcrel	t0, fw_arg2
-	st.d		a2, t0, 0
+	PTR_S		a2, t0, 0
 
 #ifdef CONFIG_PAGE_SIZE_4KB
-	li.d		t0, 0
-	li.d		t1, CSR_STFILL
+	LONG_LI		t0, 0
+	LONG_LI		t1, CSR_STFILL
 	csrxchg		t0, t1, LOONGARCH_CSR_IMPCTL1
 #endif
 	/* KSave3 used for percpu base, initialized as 0 */
@@ -98,7 +91,7 @@ SYM_CODE_START(kernel_entry)			# kernel entry point
 
 	/* Jump to the new kernel: new_pc = current_pc + random_offset */
 	pcaddi		t0, 0
-	add.d		t0, t0, a0
+	PTR_ADD		t0, t0, a0
 	jirl		zero, t0, 0xc
 #endif /* CONFIG_RANDOMIZE_BASE */
 
@@ -121,12 +114,14 @@ SYM_CODE_END(kernel_entry)
  */
 SYM_CODE_START(smpboot_entry)
 
-	SETUP_DMWINS	t0
+	SETUP_TWINS
+	SETUP_MODES	t0
 	JUMP_VIRT_ADDR	t0, t1
+	SETUP_DMWINS	t0
 
 #ifdef CONFIG_PAGE_SIZE_4KB
-	li.d		t0, 0
-	li.d		t1, CSR_STFILL
+	LONG_LI		t0, 0
+	LONG_LI		t1, CSR_STFILL
 	csrxchg		t0, t1, LOONGARCH_CSR_IMPCTL1
 #endif
 	/* Enable PG */
diff --git a/arch/loongarch/kernel/relocate.c b/arch/loongarch/kernel/relocate.c
index b5e2312a2fca..c28ba45d80d6 100644
--- a/arch/loongarch/kernel/relocate.c
+++ b/arch/loongarch/kernel/relocate.c
@@ -68,18 +68,25 @@ static inline void __init relocate_absolute(long random_offset)
 
 	for (p = begin; (void *)p < end; p++) {
 		long v = p->symvalue;
-		uint32_t lu12iw, ori, lu32id, lu52id;
+		uint32_t lu12iw, ori;
+#ifdef CONFIG_64BIT
+		uint32_t lu32id, lu52id;
+#endif
 		union loongarch_instruction *insn = (void *)p->pc;
 
 		lu12iw = (v >> 12) & 0xfffff;
 		ori    = v & 0xfff;
+#ifdef CONFIG_64BIT
 		lu32id = (v >> 32) & 0xfffff;
 		lu52id = v >> 52;
+#endif
 
 		insn[0].reg1i20_format.immediate = lu12iw;
 		insn[1].reg2i12_format.immediate = ori;
+#ifdef CONFIG_64BIT
 		insn[2].reg1i20_format.immediate = lu32id;
 		insn[3].reg2i12_format.immediate = lu52id;
+#endif
 	}
 }
 
-- 
2.47.3


