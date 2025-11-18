Return-Path: <linux-arch+bounces-14868-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 412E4C691A2
	for <lists+linux-arch@lfdr.de>; Tue, 18 Nov 2025 12:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 08FB8380F32
	for <lists+linux-arch@lfdr.de>; Tue, 18 Nov 2025 11:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5728E350A01;
	Tue, 18 Nov 2025 11:30:37 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8F22F6592;
	Tue, 18 Nov 2025 11:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763465437; cv=none; b=Rel2kGL7EgpH1Ufl47TSSOBV0eGJZtXPSRwfJiJadhsMVZV7ROR95tXU0b4Fr46rCCjLfdv9BAnNnmdmcJq6U3sOfMVkfzgknFoyMRbDO/hA+dNuo8aQ0mbxr16bk0IjVKnde4xWcnqKHbbDLx2N4zD62yml6W8NKp/husQq2sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763465437; c=relaxed/simple;
	bh=s65mt4xmF/EY1Gvjm+U5Ue0R3n2+rgjnOu9fACrHPaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cB7u39SdkVlKdoYtw09bAPKKuaf7APb8WubI+u2pOhLJZxp0IKtgztwtju7LOOI7qOMivT+/i94xqNPUa3Gr1iufp8stpOj2Mp+ekvDyxbZuwes5RzobS+0235HxfKzLdGpTxNXs16Pbe9X7Yb6ZGSW1KNGE5cDMAmCpcTbVXSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4280C16AAE;
	Tue, 18 Nov 2025 11:30:33 +0000 (UTC)
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
Subject: [PATCH V2 11/14] LoongArch: Adjust misc routines for 32BIT/64BIT
Date: Tue, 18 Nov 2025 19:27:25 +0800
Message-ID: <20251118112728.571869-12-chenhuacai@loongson.cn>
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

Adjust misc routines for both 32BIT and 64BIT, including: checksum,
jump label, unaligned access emulator, PCI init routines, sleep/wakeup
routines, etc.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/checksum.h   |  4 ++
 arch/loongarch/include/asm/jump_label.h | 12 ++++-
 arch/loongarch/include/asm/string.h     |  2 +
 arch/loongarch/kernel/unaligned.c       | 30 ++++++++---
 arch/loongarch/lib/unaligned.S          | 72 ++++++++++++-------------
 arch/loongarch/pci/pci.c                |  8 +--
 arch/loongarch/power/suspend_asm.S      | 72 ++++++++++++-------------
 7 files changed, 116 insertions(+), 84 deletions(-)

diff --git a/arch/loongarch/include/asm/checksum.h b/arch/loongarch/include/asm/checksum.h
index cabbf6af44c4..cc2754e0aa25 100644
--- a/arch/loongarch/include/asm/checksum.h
+++ b/arch/loongarch/include/asm/checksum.h
@@ -9,6 +9,8 @@
 #include <linux/bitops.h>
 #include <linux/in6.h>
 
+#ifdef CONFIG_64BIT
+
 #define _HAVE_ARCH_IPV6_CSUM
 __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 			const struct in6_addr *daddr,
@@ -61,6 +63,8 @@ static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
 extern unsigned int do_csum(const unsigned char *buff, int len);
 #define do_csum do_csum
 
+#endif
+
 #include <asm-generic/checksum.h>
 
 #endif	/* __ASM_CHECKSUM_H */
diff --git a/arch/loongarch/include/asm/jump_label.h b/arch/loongarch/include/asm/jump_label.h
index 4000c7603d8e..dcaecf69ea5a 100644
--- a/arch/loongarch/include/asm/jump_label.h
+++ b/arch/loongarch/include/asm/jump_label.h
@@ -10,15 +10,23 @@
 #ifndef __ASSEMBLER__
 
 #include <linux/types.h>
+#include <linux/stringify.h>
+#include <asm/asm.h>
 
 #define JUMP_LABEL_NOP_SIZE	4
 
+#ifdef CONFIG_32BIT
+#define JUMP_LABEL_TYPE		".long "
+#else
+#define JUMP_LABEL_TYPE		".quad "
+#endif
+
 /* This macro is also expanded on the Rust side. */
 #define JUMP_TABLE_ENTRY(key, label)			\
 	 ".pushsection	__jump_table, \"aw\"	\n\t"	\
-	 ".align	3			\n\t"	\
+	 ".align	" __stringify(PTRLOG) "	\n\t"	\
 	 ".long		1b - ., " label " - .	\n\t"	\
-	 ".quad		" key " - .		\n\t"	\
+	 JUMP_LABEL_TYPE  key " - .		\n\t"	\
 	 ".popsection				\n\t"
 
 #define ARCH_STATIC_BRANCH_ASM(key, label)		\
diff --git a/arch/loongarch/include/asm/string.h b/arch/loongarch/include/asm/string.h
index 5bb5a90d2681..bfa3fd879c7f 100644
--- a/arch/loongarch/include/asm/string.h
+++ b/arch/loongarch/include/asm/string.h
@@ -5,6 +5,7 @@
 #ifndef _ASM_STRING_H
 #define _ASM_STRING_H
 
+#ifdef CONFIG_64BIT
 #define __HAVE_ARCH_MEMSET
 extern void *memset(void *__s, int __c, size_t __count);
 extern void *__memset(void *__s, int __c, size_t __count);
@@ -16,6 +17,7 @@ extern void *__memcpy(void *__to, __const__ void *__from, size_t __n);
 #define __HAVE_ARCH_MEMMOVE
 extern void *memmove(void *__dest, __const__ void *__src, size_t __n);
 extern void *__memmove(void *__dest, __const__ void *__src, size_t __n);
+#endif
 
 #if defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__)
 
diff --git a/arch/loongarch/kernel/unaligned.c b/arch/loongarch/kernel/unaligned.c
index 487be604b96a..cc929c9fe7e9 100644
--- a/arch/loongarch/kernel/unaligned.c
+++ b/arch/loongarch/kernel/unaligned.c
@@ -27,12 +27,21 @@ static u32 unaligned_instructions_user;
 static u32 unaligned_instructions_kernel;
 #endif
 
-static inline unsigned long read_fpr(unsigned int idx)
+static inline u64 read_fpr(unsigned int idx)
 {
+#ifdef CONFIG_64BIT
 #define READ_FPR(idx, __value)		\
 	__asm__ __volatile__("movfr2gr.d %0, $f"#idx"\n\t" : "=r"(__value));
-
-	unsigned long __value;
+#else
+#define READ_FPR(idx, __value)								\
+{											\
+	u32 __value_lo, __value_hi;							\
+	__asm__ __volatile__("movfr2gr.s  %0, $f"#idx"\n\t" : "=r"(__value_lo));	\
+	__asm__ __volatile__("movfrh2gr.s %0, $f"#idx"\n\t" : "=r"(__value_hi));	\
+	__value = (__value_lo | ((u64)__value_hi << 32));				\
+}
+#endif
+	u64 __value;
 
 	switch (idx) {
 	case 0:
@@ -138,11 +147,20 @@ static inline unsigned long read_fpr(unsigned int idx)
 	return __value;
 }
 
-static inline void write_fpr(unsigned int idx, unsigned long value)
+static inline void write_fpr(unsigned int idx, u64 value)
 {
+#ifdef CONFIG_64BIT
 #define WRITE_FPR(idx, value)		\
 	__asm__ __volatile__("movgr2fr.d $f"#idx", %0\n\t" :: "r"(value));
-
+#else
+#define WRITE_FPR(idx, value)							\
+{										\
+	u32 value_lo = value;							\
+	u32 value_hi = value >> 32;						\
+	__asm__ __volatile__("movgr2fr.w  $f"#idx", %0\n\t" :: "r"(value_lo));	\
+	__asm__ __volatile__("movgr2frh.w $f"#idx", %0\n\t" :: "r"(value_hi));	\
+}
+#endif
 	switch (idx) {
 	case 0:
 		WRITE_FPR(0, value);
@@ -252,7 +270,7 @@ void emulate_load_store_insn(struct pt_regs *regs, void __user *addr, unsigned i
 	bool sign, write;
 	bool user = user_mode(regs);
 	unsigned int res, size = 0;
-	unsigned long value = 0;
+	u64 value = 0;
 	union loongarch_instruction insn;
 
 	perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS, 1, regs, 0);
diff --git a/arch/loongarch/lib/unaligned.S b/arch/loongarch/lib/unaligned.S
index 185f82d85810..470c0bfa3463 100644
--- a/arch/loongarch/lib/unaligned.S
+++ b/arch/loongarch/lib/unaligned.S
@@ -24,35 +24,35 @@
  * a3: sign
  */
 SYM_FUNC_START(unaligned_read)
-	beqz	a2, 5f
+	beqz		a2, 5f
 
-	li.w	t2, 0
-	addi.d	t0, a2, -1
-	slli.d	t1, t0, 3
-	add.d 	a0, a0, t0
+	li.w		t2, 0
+	LONG_ADDI	t0, a2, -1
+	PTR_SLLI	t1, t0, LONGLOG
+	PTR_ADD		a0, a0, t0
 
-	beqz	a3, 2f
-1:	ld.b	t3, a0, 0
-	b	3f
+	beqz		a3, 2f
+1:	ld.b		t3, a0, 0
+	b		3f
 
-2:	ld.bu	t3, a0, 0
-3:	sll.d	t3, t3, t1
-	or	t2, t2, t3
-	addi.d	t1, t1, -8
-	addi.d	a0, a0, -1
-	addi.d	a2, a2, -1
-	bgtz	a2, 2b
-4:	st.d	t2, a1, 0
+2:	ld.bu		t3, a0, 0
+3:	LONG_SLLV	t3, t3, t1
+	or		t2, t2, t3
+	LONG_ADDI	t1, t1, -8
+	PTR_ADDI	a0, a0, -1
+	PTR_ADDI	a2, a2, -1
+	bgtz		a2, 2b
+4:	LONG_S		t2, a1, 0
 
-	move	a0, a2
-	jr	ra
+	move		a0, a2
+	jr		ra
 
-5:	li.w    a0, -EFAULT
-	jr	ra
+5:	li.w		a0, -EFAULT
+	jr		ra
 
-	_asm_extable 1b, .L_fixup_handle_unaligned
-	_asm_extable 2b, .L_fixup_handle_unaligned
-	_asm_extable 4b, .L_fixup_handle_unaligned
+	_asm_extable	1b, .L_fixup_handle_unaligned
+	_asm_extable	2b, .L_fixup_handle_unaligned
+	_asm_extable	4b, .L_fixup_handle_unaligned
 SYM_FUNC_END(unaligned_read)
 
 /*
@@ -63,21 +63,21 @@ SYM_FUNC_END(unaligned_read)
  * a2: n
  */
 SYM_FUNC_START(unaligned_write)
-	beqz	a2, 3f
+	beqz		a2, 3f
 
-	li.w	t0, 0
-1:	srl.d	t1, a1, t0
-2:	st.b	t1, a0, 0
-	addi.d	t0, t0, 8
-	addi.d	a2, a2, -1
-	addi.d	a0, a0, 1
-	bgtz	a2, 1b
+	li.w		t0, 0
+1:	LONG_SRLV	t1, a1, t0
+2:	st.b		t1, a0, 0
+	LONG_ADDI	t0, t0, 8
+	PTR_ADDI	a2, a2, -1
+	PTR_ADDI	a0, a0, 1
+	bgtz		a2, 1b
 
-	move	a0, a2
-	jr	ra
+	move		a0, a2
+	jr		ra
 
-3:	li.w    a0, -EFAULT
-	jr	ra
+3:	li.w		a0, -EFAULT
+	jr		ra
 
-	_asm_extable 2b, .L_fixup_handle_unaligned
+	_asm_extable	2b, .L_fixup_handle_unaligned
 SYM_FUNC_END(unaligned_write)
diff --git a/arch/loongarch/pci/pci.c b/arch/loongarch/pci/pci.c
index 5bc9627a6cf9..d9fc5d520b37 100644
--- a/arch/loongarch/pci/pci.c
+++ b/arch/loongarch/pci/pci.c
@@ -50,11 +50,11 @@ static int __init pcibios_init(void)
 	 */
 	lsize = cpu_last_level_cache_line_size();
 
-	BUG_ON(!lsize);
+	if (lsize) {
+		pci_dfl_cache_line_size = lsize >> 2;
 
-	pci_dfl_cache_line_size = lsize >> 2;
-
-	pr_debug("PCI: pci_cache_line_size set to %d bytes\n", lsize);
+		pr_debug("PCI: pci_cache_line_size set to %d bytes\n", lsize);
+	}
 
 	return 0;
 }
diff --git a/arch/loongarch/power/suspend_asm.S b/arch/loongarch/power/suspend_asm.S
index df0865df26fa..c8119ad5fb2c 100644
--- a/arch/loongarch/power/suspend_asm.S
+++ b/arch/loongarch/power/suspend_asm.S
@@ -14,41 +14,41 @@
 
 /* preparatory stuff */
 .macro	SETUP_SLEEP
-	addi.d		sp, sp, -PT_SIZE
-	st.d		$r1, sp, PT_R1
-	st.d		$r2, sp, PT_R2
-	st.d		$r3, sp, PT_R3
-	st.d		$r4, sp, PT_R4
-	st.d		$r21, sp, PT_R21
-	st.d		$r22, sp, PT_R22
-	st.d		$r23, sp, PT_R23
-	st.d		$r24, sp, PT_R24
-	st.d		$r25, sp, PT_R25
-	st.d		$r26, sp, PT_R26
-	st.d		$r27, sp, PT_R27
-	st.d		$r28, sp, PT_R28
-	st.d		$r29, sp, PT_R29
-	st.d		$r30, sp, PT_R30
-	st.d		$r31, sp, PT_R31
+	PTR_ADDI	sp, sp, -PT_SIZE
+	REG_S		$r1, sp, PT_R1
+	REG_S		$r2, sp, PT_R2
+	REG_S		$r3, sp, PT_R3
+	REG_S		$r4, sp, PT_R4
+	REG_S		$r21, sp, PT_R21
+	REG_S		$r22, sp, PT_R22
+	REG_S		$r23, sp, PT_R23
+	REG_S		$r24, sp, PT_R24
+	REG_S		$r25, sp, PT_R25
+	REG_S		$r26, sp, PT_R26
+	REG_S		$r27, sp, PT_R27
+	REG_S		$r28, sp, PT_R28
+	REG_S		$r29, sp, PT_R29
+	REG_S		$r30, sp, PT_R30
+	REG_S		$r31, sp, PT_R31
 .endm
 
 .macro SETUP_WAKEUP
-	ld.d		$r1, sp, PT_R1
-	ld.d		$r2, sp, PT_R2
-	ld.d		$r3, sp, PT_R3
-	ld.d		$r4, sp, PT_R4
-	ld.d		$r21, sp, PT_R21
-	ld.d		$r22, sp, PT_R22
-	ld.d		$r23, sp, PT_R23
-	ld.d		$r24, sp, PT_R24
-	ld.d		$r25, sp, PT_R25
-	ld.d		$r26, sp, PT_R26
-	ld.d		$r27, sp, PT_R27
-	ld.d		$r28, sp, PT_R28
-	ld.d		$r29, sp, PT_R29
-	ld.d		$r30, sp, PT_R30
-	ld.d		$r31, sp, PT_R31
-	addi.d		sp, sp, PT_SIZE
+	REG_L		$r1, sp, PT_R1
+	REG_L		$r2, sp, PT_R2
+	REG_L		$r3, sp, PT_R3
+	REG_L		$r4, sp, PT_R4
+	REG_L		$r21, sp, PT_R21
+	REG_L		$r22, sp, PT_R22
+	REG_L		$r23, sp, PT_R23
+	REG_L		$r24, sp, PT_R24
+	REG_L		$r25, sp, PT_R25
+	REG_L		$r26, sp, PT_R26
+	REG_L		$r27, sp, PT_R27
+	REG_L		$r28, sp, PT_R28
+	REG_L		$r29, sp, PT_R29
+	REG_L		$r30, sp, PT_R30
+	REG_L		$r31, sp, PT_R31
+	PTR_ADDI	sp, sp, PT_SIZE
 .endm
 
 	.text
@@ -59,15 +59,15 @@ SYM_FUNC_START(loongarch_suspend_enter)
 	SETUP_SLEEP
 
 	la.pcrel	t0, acpi_saved_sp
-	st.d		sp, t0, 0
+	REG_S		sp, t0, 0
 
 	bl		__flush_cache_all
 
 	/* Pass RA and SP to BIOS */
-	addi.d		a1, sp, 0
+	PTR_ADDI	a1, sp, 0
 	la.pcrel	a0, loongarch_wakeup_start
 	la.pcrel	t0, loongarch_suspend_addr
-	ld.d		t0, t0, 0
+	REG_L		t0, t0, 0
 	jirl		ra, t0, 0 /* Call BIOS's STR sleep routine */
 
 	/*
@@ -83,7 +83,7 @@ SYM_INNER_LABEL(loongarch_wakeup_start, SYM_L_GLOBAL)
 	csrwr		t0, LOONGARCH_CSR_CRMD
 
 	la.pcrel	t0, acpi_saved_sp
-	ld.d		sp, t0, 0
+	REG_L		sp, t0, 0
 
 	SETUP_WAKEUP
 	jr		ra
-- 
2.47.3


