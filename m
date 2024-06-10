Return-Path: <linux-arch+bounces-4810-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87779902A2F
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 22:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68E311C21774
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 20:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DAA14D719;
	Mon, 10 Jun 2024 20:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JiH6A5U0"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A2014D6E4;
	Mon, 10 Jun 2024 20:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718052531; cv=none; b=h5RdNCTI32Nhqa34XakL4twgKnQOFtQZnDI4jgUXs3hntuhlBXJaZvgKQQAuGojJa0boH0odxO1xek9/KGrkfkWyYDK9/Ia3kJ9AA8bwbkjMG81xBkTco7p+Mnz04P+hdkuxFMh2FTioysKfRffVzkZ6olIvx1rXl14on/VIsJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718052531; c=relaxed/simple;
	bh=qEWhUwOtY4dP2oKEOdCg3gFZW6ZZXNIFIaLC2/7lZ38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FaLzT9OIYcy0PZDWpA+ASm5FZd+CseCksekHT7fux31YZlvngmVKkFqdNdtmPrQXqS4a7eJ+pQUBRBlWmTYMtVuWGhsELXj+f91dUtW5AQaCPcpl4XgnPu1XXXba+zCEq89m/kInVrO4VzMAd05iB7pZ5MF23Nszenkt2G6eIpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JiH6A5U0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0984C2BBFC;
	Mon, 10 Jun 2024 20:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718052531;
	bh=qEWhUwOtY4dP2oKEOdCg3gFZW6ZZXNIFIaLC2/7lZ38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JiH6A5U0arD1NhlbdfpjK8+SD3NECg/OLaKv9RnBd5T4AY15CPLPBn42T6GSAQYe0
	 huRV6nMOULL9ce93ox3iDF9DgMHNhwPGXHnXzZuoAnF9gMVEKsa6esEKLrVWVk74Q7
	 1anFZ5tXKEpPNvsXPKCh2bUP4fB3HkiBWds2d1Io=
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
Subject: [PATCH 3/7] x86: add 'runtime constant' support
Date: Mon, 10 Jun 2024 13:48:17 -0700
Message-ID: <20240610204821.230388-4-torvalds@linux-foundation.org>
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

This implements the runtime constant infrastructure for x86, allowing
the dcache d_hash() function to be generated using as a constant for
hash table address followed by shift by a constant of the hash index.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/x86/include/asm/runtime-const.h | 61 ++++++++++++++++++++++++++++
 arch/x86/kernel/vmlinux.lds.S        |  3 ++
 2 files changed, 64 insertions(+)
 create mode 100644 arch/x86/include/asm/runtime-const.h

diff --git a/arch/x86/include/asm/runtime-const.h b/arch/x86/include/asm/runtime-const.h
new file mode 100644
index 000000000000..24e3a53ca255
--- /dev/null
+++ b/arch/x86/include/asm/runtime-const.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RUNTIME_CONST_H
+#define _ASM_RUNTIME_CONST_H
+
+#define runtime_const_ptr(sym) ({				\
+	typeof(sym) __ret;					\
+	asm_inline("mov %1,%0\n1:\n"				\
+		".pushsection runtime_ptr_" #sym ",\"a\"\n\t"	\
+		".long 1b - %c2 - .\n\t"			\
+		".popsection"					\
+		:"=r" (__ret)					\
+		:"i" ((unsigned long)0x0123456789abcdefull),	\
+		 "i" (sizeof(long)));				\
+	__ret; })
+
+// The 'typeof' will create at _least_ a 32-bit type, but
+// will happily also take a bigger type and the 'shrl' will
+// clear the upper bits
+#define runtime_const_shift_right_32(val, sym) ({		\
+	typeof(0u+(val)) __ret = (val);				\
+	asm_inline("shrl $12,%k0\n1:\n"				\
+		".pushsection runtime_shift_" #sym ",\"a\"\n\t"	\
+		".long 1b - 1 - .\n\t"				\
+		".popsection"					\
+		:"+r" (__ret));					\
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
+/*
+ * The text patching is trivial - you can only do this at init time,
+ * when the text section hasn't been marked RO, and before the text
+ * has ever been executed.
+ */
+static inline void __runtime_fixup_ptr(void *where, unsigned long val)
+{
+	*(unsigned long *)where = val;
+}
+
+static inline void __runtime_fixup_shift(void *where, unsigned long val)
+{
+	*(unsigned char *)where = val;
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
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 3509afc6a672..6e73403e874f 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -357,6 +357,9 @@ SECTIONS
 	PERCPU_SECTION(INTERNODE_CACHE_BYTES)
 #endif
 
+	RUNTIME_CONST(shift, d_hash_shift)
+	RUNTIME_CONST(ptr, dentry_hashtable)
+
 	. = ALIGN(PAGE_SIZE);
 
 	/* freed after init ends here */
-- 
2.45.1.209.gc6f12300df


