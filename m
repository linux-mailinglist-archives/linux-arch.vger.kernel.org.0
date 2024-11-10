Return-Path: <linux-arch+bounces-8952-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DFC9C3382
	for <lists+linux-arch@lfdr.de>; Sun, 10 Nov 2024 16:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C94902815F5
	for <lists+linux-arch@lfdr.de>; Sun, 10 Nov 2024 15:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A52130E58;
	Sun, 10 Nov 2024 15:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNB+45qC"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8186081741;
	Sun, 10 Nov 2024 15:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731253896; cv=none; b=Azf9uNYnL72bc5Uda/XjbKUiWrkrN07uzBu+rLZMuW/ojtYOmpjhpaQ58SYprcjIPzxpGzlEK/96/mRG59XmY5RIWtjIIWD/HLwrY+oxh5sjB1JzKcJEW3CLqkxvJCyadRWr9oJcFXqIgrE+X3i0ka9oLEfwe4HSftH3hoaOkFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731253896; c=relaxed/simple;
	bh=/HkSeJVyvgLEhQ5zekLtpHg9nCl4G6foTq1nkaeg7FY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zd0vKluxAdXMHFboCzKBzyxO1ISzKsDAzsE112ITUaS0uJpleItQ3Aedb9LmvDtIiTpw0csZ/n1E9JCcGrMfj0EkOy4Q99E+MH+SJ1lypE8+fxnqT6a/Zq9ia6gQfnybNItfw1kTa/26koZh74pjjhGvnYrRyabgbGv2qHtLhCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNB+45qC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77318C4CECD;
	Sun, 10 Nov 2024 15:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731253894;
	bh=/HkSeJVyvgLEhQ5zekLtpHg9nCl4G6foTq1nkaeg7FY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lNB+45qC6uZp/1TFNdePkucUf4gFtCe4yhhJA2u9XEsPbaAamdcH5YbGzmruhiNHn
	 lTcaWBVhGajyRjMPAm9OLK5FFY5PDPUQ2se9ivOK3mmjyXOXTIYC8njq/0qyWIXd91
	 4/vuZJGR6Cy8jxAz2yf7k0NRce1m+yTL5jCDOAHT9tt5KlvrNaPsiLext6QK1Hkplk
	 i3SYqXEvmQfG9W693fFV9ks2nfGzDYIuKRllJYKHa7XNqaLrk/MUnyCKEN2OLd5kjm
	 icOsNzxT3FmZ3rOd8lUfzisKW3tJncyzwbCAPO0IZV9HtnbYhB2pbBrdE07F1tW072
	 FRnhKXIJlAW+A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Florent Revest <revest@chromium.org>
Cc: linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arch@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v19 13/19] fprobe: Add fprobe_header encoding feature
Date: Mon, 11 Nov 2024 00:51:25 +0900
Message-ID: <173125388510.172790.1161831132316963172.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173125372214.172790.6929368952404083802.stgit@devnote2>
References: <173125372214.172790.6929368952404083802.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Fprobe store its data structure address and size on the fgraph return stack
by __fprobe_header. But most 64bit architecture can combine those to
one unsigned long value because 4 MSB in the kernel address are the same.
With this encoding, fprobe can consume less space on ret_stack.

This introduces asm/fprobe.h to define arch dependent encode/decode
macros. Note that since fprobe depends on CONFIG_HAVE_FUNCTION_GRAPH_FREGS,
currently only arm64, loongarch, riscv, s390 and x86 are supported.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 Changes in v19:
  - Fix to use Kbuild for generic arm/fprobe.h
  - Check CONFIG_64BIT in asm-generic/fprobe.h.
---
 arch/arm64/include/asm/Kbuild       |    1 +
 arch/loongarch/include/asm/fprobe.h |   12 +++++++++
 arch/riscv/include/asm/Kbuild       |    1 +
 arch/s390/include/asm/fprobe.h      |   10 ++++++++
 arch/x86/include/asm/Kbuild         |    1 +
 include/asm-generic/fprobe.h        |   46 +++++++++++++++++++++++++++++++++++
 kernel/trace/fprobe.c               |   29 ++++++++++++++++++++++
 7 files changed, 100 insertions(+)
 create mode 100644 arch/loongarch/include/asm/fprobe.h
 create mode 100644 arch/s390/include/asm/fprobe.h
 create mode 100644 include/asm-generic/fprobe.h

diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index 4e350df9a02d..d2ff8f6c3231 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -8,6 +8,7 @@ syscall-y += unistd_32.h
 syscall-y += unistd_compat_32.h
 
 generic-y += early_ioremap.h
+generic-y += fprobe.h
 generic-y += mcs_spinlock.h
 generic-y += mmzone.h
 generic-y += qrwlock.h
diff --git a/arch/loongarch/include/asm/fprobe.h b/arch/loongarch/include/asm/fprobe.h
new file mode 100644
index 000000000000..7af3b3126caf
--- /dev/null
+++ b/arch/loongarch/include/asm/fprobe.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_LOONGARCH_FPROBE_H
+#define _ASM_LOONGARCH_FPROBE_H
+
+/*
+ * Explicitly undef ARCH_DEFINE_ENCODE_FPROBE_HEADER, because loongarch does not
+ * have enough number of fixed MSBs of the address of kernel objects for
+ * encoding the size of data in fprobe_header. Use 2-entries encoding instead.
+ */
+#undef ARCH_DEFINE_ENCODE_FPROBE_HEADER
+
+#endif /* _ASM_LOONGARCH_FPROBE_H */
diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index 1461af12da6e..e4c8790d728a 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -4,6 +4,7 @@ syscall-y += syscall_table_64.h
 
 generic-y += early_ioremap.h
 generic-y += flat.h
+generic-y += fprobe.h
 generic-y += kvm_para.h
 generic-y += mmzone.h
 generic-y += parport.h
diff --git a/arch/s390/include/asm/fprobe.h b/arch/s390/include/asm/fprobe.h
new file mode 100644
index 000000000000..5ef600b372f4
--- /dev/null
+++ b/arch/s390/include/asm/fprobe.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_S390_FPROBE_H
+#define _ASM_S390_FPROBE_H
+
+#include <asm-generic/fprobe.h>
+
+#undef FPROBE_HEADER_MSB_PATTERN
+#define FPROBE_HEADER_MSB_PATTERN 0
+
+#endif /* _ASM_S390_FPROBE_H */
diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
index 6c23d1661b17..58f4ddecc5fa 100644
--- a/arch/x86/include/asm/Kbuild
+++ b/arch/x86/include/asm/Kbuild
@@ -10,5 +10,6 @@ generated-y += unistd_64_x32.h
 generated-y += xen-hypercalls.h
 
 generic-y += early_ioremap.h
+generic-y += fprobe.h
 generic-y += mcs_spinlock.h
 generic-y += mmzone.h
diff --git a/include/asm-generic/fprobe.h b/include/asm-generic/fprobe.h
new file mode 100644
index 000000000000..8659a4dc6eb6
--- /dev/null
+++ b/include/asm-generic/fprobe.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Generic arch dependent fprobe macros.
+ */
+#ifndef __ASM_GENERIC_FPROBE_H__
+#define __ASM_GENERIC_FPROBE_H__
+
+#include <linux/bits.h>
+
+#ifdef CONFIG_64BIT
+/*
+ * Encoding the size and the address of fprobe into one 64bit entry.
+ * The 32bit architectures should use 2 entries to store those info.
+ */
+
+#define ARCH_DEFINE_ENCODE_FPROBE_HEADER
+
+#define FPROBE_HEADER_MSB_SIZE_SHIFT (BITS_PER_LONG - FPROBE_DATA_SIZE_BITS)
+#define FPROBE_HEADER_MSB_MASK					\
+	GENMASK(FPROBE_HEADER_MSB_SIZE_SHIFT - 1, 0)
+
+/*
+ * By default, this expects the MSBs in the address of kprobe is 0xf.
+ * If any arch needs another fixed pattern (e.g. s390 is zero filled),
+ * override this.
+ */
+#define FPROBE_HEADER_MSB_PATTERN				\
+	GENMASK(BITS_PER_LONG - 1, FPROBE_HEADER_MSB_SIZE_SHIFT)
+
+#define arch_fprobe_header_encodable(fp)			\
+	(((unsigned long)(fp) & ~FPROBE_HEADER_MSB_MASK) ==	\
+	 FPROBE_HEADER_MSB_PATTERN)
+
+#define arch_encode_fprobe_header(fp, size)			\
+	(((unsigned long)(fp) & FPROBE_HEADER_MSB_MASK) |	\
+	 ((unsigned long)(size) << FPROBE_HEADER_MSB_SIZE_SHIFT))
+
+#define arch_decode_fprobe_header_size(val)			\
+	((unsigned long)(val) >> FPROBE_HEADER_MSB_SIZE_SHIFT)
+
+#define arch_decode_fprobe_header_fp(val)					\
+	((struct fprobe *)(((unsigned long)(val) & FPROBE_HEADER_MSB_MASK) |	\
+			   FPROBE_HEADER_MSB_PATTERN))
+#endif /* CONFIG_64BIT */
+
+#endif /* __ASM_GENERIC_FPROBE_H__ */
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index ed9c1d79426a..2560b312ad57 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -13,6 +13,8 @@
 #include <linux/slab.h>
 #include <linux/sort.h>
 
+#include <asm/fprobe.h>
+
 #include "trace.h"
 
 #define FPROBE_IP_HASH_BITS 8
@@ -143,6 +145,31 @@ static int del_fprobe_hash(struct fprobe *fp)
 	return 0;
 }
 
+#ifdef ARCH_DEFINE_ENCODE_FPROBE_HEADER
+
+/* The arch should encode fprobe_header info into one unsigned long */
+#define FPROBE_HEADER_SIZE_IN_LONG	1
+
+static inline bool write_fprobe_header(unsigned long *stack,
+					struct fprobe *fp, unsigned int size_words)
+{
+	if (WARN_ON_ONCE(size_words > MAX_FPROBE_DATA_SIZE_WORD ||
+			 !arch_fprobe_header_encodable(fp)))
+		return false;
+
+	*stack = arch_encode_fprobe_header(fp, size_words);
+	return true;
+}
+
+static inline void read_fprobe_header(unsigned long *stack,
+					struct fprobe **fp, unsigned int *size_words)
+{
+	*fp = arch_decode_fprobe_header_fp(*stack);
+	*size_words = arch_decode_fprobe_header_size(*stack);
+}
+
+#else
+
 /* Generic fprobe_header */
 struct __fprobe_header {
 	struct fprobe *fp;
@@ -173,6 +200,8 @@ static inline void read_fprobe_header(unsigned long *stack,
 	*size_words = fph->size_words;
 }
 
+#endif
+
 /*
  * fprobe shadow stack management:
  * Since fprobe shares a single fgraph_ops, it needs to share the stack entry


