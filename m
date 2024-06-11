Return-Path: <linux-arch+bounces-4830-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD024904251
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 19:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF6A21C2429B
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 17:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324F74778C;
	Tue, 11 Jun 2024 17:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="mbvjaAyC"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB7222086;
	Tue, 11 Jun 2024 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718126434; cv=none; b=JX68yz6/YrrRoF/Mtnk7jqFQFkEgsIrhHUQIRsg6t22zJJEjo5SewlcH6x+xSuW+xfzwJBT0MHAjW6ulWk112UfVWq+0sTft5aSVHoK6LwYZs/pZaiJk36KI8QpleqazrW9mY3PoTiXfDr6N9fBAe11y4ZMXv+OHxrkQLgY1zoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718126434; c=relaxed/simple;
	bh=LDS+lQ1Dge7tph4L1/rDUIFeOC9KuOHV5hBkAT51FdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pf5fWG5CvkPhaZD2tc0ulBkWt+cOCX8Kk1Kh11qLj0ZEmpb7QpH7eFHNhfIIlBnNXW3i7BOQN41jzI4JAmZEdHm3dikh+PX7wUSyaCfgGwApXLLV/vSUCw4I8yEO8B/v0NMHir0MNPpji0YiSL4dXqONFpG/gYhqhOtOHULpScc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=mbvjaAyC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C99C2BD10;
	Tue, 11 Jun 2024 17:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718126433;
	bh=LDS+lQ1Dge7tph4L1/rDUIFeOC9KuOHV5hBkAT51FdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mbvjaAyCLpSpQDpTWrsS8DPAXe3ItDtfEu0qBwYlnVTtKMAVM+DPpmZPRK8DGXxCQ
	 uD/2iYklY7z4+PlresI6jmYhtlRpDk0FU44m8N9KOtKc8a25L+VfsHBC+O/ivb3Mpr
	 RaHkcgbZFG9biiGpi72Zc3xU9Ge0K5tv+CRZViGQ=
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Anvin <hpa@zytor.com>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	the arch/x86 maintainers <x86@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-arch <linux-arch@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4/7 v2] arm64: add 'runtime constant' support
Date: Tue, 11 Jun 2024 10:20:10 -0700
Message-ID: <20240611172010.287427-1-torvalds@linux-foundation.org>
X-Mailer: git-send-email 2.45.1.209.gc6f12300df
In-Reply-To: <CAHk-=wiHp60JjTs=qZDboGnQxKSzv=hLyjEp+8StqvtjOKY64w@mail.gmail.com>
References: <CAHk-=wiHp60JjTs=qZDboGnQxKSzv=hLyjEp+8StqvtjOKY64w@mail.gmail.com>
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
v2: updates as per Mark Rutland

 arch/arm64/include/asm/runtime-const.h | 83 ++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/vmlinux.lds.S        |  3 ++
 2 files changed, 86 insertions(+)
 create mode 100644 arch/arm64/include/asm/runtime-const.h

diff --git a/arch/arm64/include/asm/runtime-const.h b/arch/arm64/include/asm/runtime-const.h
new file mode 100644
index 000000000000..8dc83d48a202
--- /dev/null
+++ b/arch/arm64/include/asm/runtime-const.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RUNTIME_CONST_H
+#define _ASM_RUNTIME_CONST_H
+
+#include <asm/cacheflush.h>
+
+/* Sigh. You can still run arm64 in BE mode */
+#include <asm/byteorder.h>
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
+/* 16-bit immediate for wide move (movz and movk) in bits 5..20 */
+static inline void __runtime_fixup_16(__le32 *p, unsigned int val)
+{
+	u32 insn = le32_to_cpu(*p);
+	insn &= 0xffe0001f;
+	insn |= (val & 0xffff) << 5;
+	*p = insn;
+	*p = cpu_to_le32(insn);
+}
+
+static inline void __runtime_fixup_ptr(void *where, unsigned long val)
+{
+	__le32 *p = lm_alias(where);
+	__runtime_fixup_16(p, val);
+	__runtime_fixup_16(p+1, val >> 16);
+	__runtime_fixup_16(p+2, val >> 32);
+	__runtime_fixup_16(p+3, val >> 48);
+	caches_clean_inval_pou((unsigned long)p, (unsigned long)(p + 4));
+}
+
+/* Immediate value is 6 bits starting at bit #16 */
+static inline void __runtime_fixup_shift(void *where, unsigned long val)
+{
+	__le32 *p = lm_alias(where);
+	u32 insn = le32_to_cpu(*p);
+	insn &= 0xffc0ffff;
+	insn |= (val & 63) << 16;
+	*p = cpu_to_le32(insn);
+	caches_clean_inval_pou((unsigned long)p, (unsigned long)(p + 1));
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
 

