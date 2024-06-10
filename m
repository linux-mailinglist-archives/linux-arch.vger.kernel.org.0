Return-Path: <linux-arch+bounces-4811-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EDF902A31
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 22:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 282491F207C4
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 20:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725DC14F9F5;
	Mon, 10 Jun 2024 20:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YPwqi78X"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6B514F9F2;
	Mon, 10 Jun 2024 20:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718052533; cv=none; b=DeFpLY5L9onn6Ir9NHroMmidT9nW3oXCXzoB1aSYSAXsWlTfPIRJYN/p/PJZVm55E37fysZT+EjGgE2qQXhXAblDXhpZUVGp+tCvif43w4WL4vUpKhQfWW0ygSFUR1tRscwLA1d7EY3HH9/xoHT/dXlhRb/nVAXFmLPz0UTsHIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718052533; c=relaxed/simple;
	bh=7f3f228SGMKS0WITa2x2BowrmDUER/1fLEQ+DyBwzuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eoatNG239RQrNuchl8PPJMvFgDzA85vOw3cwNdMGNNwQqGGc9Noe9iWxCrruvqmgs3XJqvWjq3k0v3tFnChhjMgUghfqbRcg1unCZAKQYG+t9mWXF2UQ5PyP4uo4P1QLt0O0nYDgnLnPrbAvGYKHrgDd8wS0rihFFKtGxuaPsDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YPwqi78X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8FAC4AF1C;
	Mon, 10 Jun 2024 20:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718052532;
	bh=7f3f228SGMKS0WITa2x2BowrmDUER/1fLEQ+DyBwzuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YPwqi78XF8g+oefGjk6SWIu9gETbsXAcfc1xuXxesUVODbHxG6F+Ihl/hQS8A6wHG
	 h+h5f5IcE9LJ94AoyVcNT9TRaIM1jZTVmlB+cNNR9Ws/oUpeqTbhAiEgblNqzvHmGB
	 V1scnDa858xxUlqxCoLdiKtjB+7xyFKKBoIeCoB0=
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Peter Anvin <hpa@zytor.com>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	the arch/x86 maintainers <x86@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-arch <linux-arch@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4/7] arm64: add 'runtime constant' support
Date: Mon, 10 Jun 2024 13:48:18 -0700
Message-ID: <20240610204821.230388-5-torvalds@linux-foundation.org>
X-Mailer: git-send-email 2.45.1.209.gc6f12300df
In-Reply-To: <20240610204821.230388-1-torvalds@linux-foundation.org>
References: <20240610204821.230388-1-torvalds@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This implements the runtime constant infrastructure for arm64, allowing
the dcache d_hash() function to be generated using as a constant for
hash table address followed by shift by a constant of the hash index.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/arm64/include/asm/runtime-const.h | 75 ++++++++++++++++++++++++++
 arch/arm64/kernel/vmlinux.lds.S        |  3 ++
 2 files changed, 78 insertions(+)
 create mode 100644 arch/arm64/include/asm/runtime-const.h

diff --git a/arch/arm64/include/asm/runtime-const.h b/arch/arm64/include/asm/runtime-const.h
new file mode 100644
index 000000000000..02462b2cb6f9
--- /dev/null
+++ b/arch/arm64/include/asm/runtime-const.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RUNTIME_CONST_H
+#define _ASM_RUNTIME_CONST_H
+
+#define runtime_const_ptr(sym) ({				\
+	typeof(sym) __ret;					\
+	asm_inline("1:\t"					\
+		"movz %0, #0xcdef\n\t"				\
+		"movk %0, #0x89ab, lsl #16\n\t"			\
+		"movk %0, #0x4567, lsl #32\n\t"			\
+		"movk %0, #0x0123, lsl #48\n\t"			\
+		".pushsection runtime_ptr_" #sym ",\"a\"\n\t"	\
+		".long 1b - .\n\t"				\
+		".popsection"					\
+		:"=r" (__ret));					\
+	__ret; })
+
+#define runtime_const_shift_right_32(val, sym) ({		\
+	unsigned long __ret;					\
+	asm_inline("1:\t"					\
+		"lsr %w0,%w1,#12\n\t"				\
+		".pushsection runtime_shift_" #sym ",\"a\"\n\t"	\
+		".long 1b - .\n\t"				\
+		".popsection"					\
+		:"=r" (__ret)					\
+		:"r" (0u+(val)));				\
+	__ret; })
+
+#define runtime_const_init(type, sym) do {		\
+	extern s32 __start_runtime_##type##_##sym[];	\
+	extern s32 __stop_runtime_##type##_##sym[];	\
+	runtime_const_fixup(__runtime_fixup_##type,	\
+		(unsigned long)(sym), 			\
+		__start_runtime_##type##_##sym,		\
+		__stop_runtime_##type##_##sym);		\
+} while (0)
+
+// 16-bit immediate for wide move (movz and movk) in bits 5..20
+static inline void __runtime_fixup_16(unsigned int *p, unsigned int val)
+{
+	unsigned int insn = *p;
+	insn &= 0xffe0001f;
+	insn |= (val & 0xffff) << 5;
+	*p = insn;
+}
+
+static inline void __runtime_fixup_ptr(void *where, unsigned long val)
+{
+	unsigned int *p = lm_alias(where);
+	__runtime_fixup_16(p, val);
+	__runtime_fixup_16(p+1, val >> 16);
+	__runtime_fixup_16(p+2, val >> 32);
+	__runtime_fixup_16(p+3, val >> 48);
+}
+
+// Immediate value is 5 bits starting at bit #16
+static inline void __runtime_fixup_shift(void *where, unsigned long val)
+{
+	unsigned int *p = lm_alias(where);
+	unsigned int insn = *p;
+	insn &= 0xffc0ffff;
+	insn |= (val & 63) << 16;
+	*p = insn;
+}
+
+static inline void runtime_const_fixup(void (*fn)(void *, unsigned long),
+	unsigned long val, s32 *start, s32 *end)
+{
+	while (start < end) {
+		fn(*start + (void *)start, val);
+		start++;
+	}
+}
+
+#endif
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 755a22d4f840..55a8e310ea12 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -264,6 +264,9 @@ SECTIONS
 		EXIT_DATA
 	}
 
+	RUNTIME_CONST(shift, d_hash_shift)
+	RUNTIME_CONST(ptr, dentry_hashtable)
+
 	PERCPU_SECTION(L1_CACHE_BYTES)
 	HYPERVISOR_PERCPU_SECTION
 
-- 
2.45.1.209.gc6f12300df


