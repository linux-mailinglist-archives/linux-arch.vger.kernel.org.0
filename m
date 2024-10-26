Return-Path: <linux-arch+bounces-8605-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D379B9B14C9
	for <lists+linux-arch@lfdr.de>; Sat, 26 Oct 2024 06:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97678286149
	for <lists+linux-arch@lfdr.de>; Sat, 26 Oct 2024 04:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5758617335C;
	Sat, 26 Oct 2024 04:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2wQLo0b"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BF516C854;
	Sat, 26 Oct 2024 04:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729917489; cv=none; b=UmPJ/QRKtQPjblEJHZthRS2GhMlV/OvuaEaWbMw4LY2IcZoQZKRVtwIZn2bgqKHgn8WPGUsOiWgmdDYwoy/geUWTr13US0/GFRytlUeHF4VwoWhj5hhJ00YSgUd5dQluLXzyNRKQKN3vn+Hy9fq89WYB3lTmKjC18GROlOYsGVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729917489; c=relaxed/simple;
	bh=l9kF/l0bqD0+3Tk9MUinu/zNZdO/QVH0/GjbJr01A9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qBUNw0DE5PxkPSfs2tOG8miQMm+TzCOTRWCtHgukJQAz5txsxZiRj0zcF/XifXCRLwzkBbnOeN41rH6I9ahO+Vh3dcvIWEHfXTqZv3e+hNcNoITs1LrDwMLD7KAbQFRsE0y1r30dqCYf6eEUhou9db+lI2b2mNTgYEXHVs+w74A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2wQLo0b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54BFC4CEC6;
	Sat, 26 Oct 2024 04:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729917488;
	bh=l9kF/l0bqD0+3Tk9MUinu/zNZdO/QVH0/GjbJr01A9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t2wQLo0baeUwBI8lECjXBEPCyXzpnqWdLMAHanmZuQFVYNlq1+d6YYtflvkrbtPpq
	 qstxdxOVRRZ4c3B2R4P+7hr7iOUHxdHuqL3mRyqczr2hQHHRyLSoGof2Q0mi0dha7w
	 SvXRNiTV2nhtHExN8bervVmUUx+gZJmAGNPe5JkmyHZej+7M/gCB66VR6bqrfRS64h
	 qujVaf4CIWWEhbkdocG+ZurCP8N10zXqw8TcgINNCDs/PtGwaG9w0q/1/2kP7qFn7I
	 /dnbl8rNcUe28Lx9Wmr4zOrKRXi/2zbuXHU4wivrnWMt9RPkw8GLayZ5cdf5sXZ72/
	 yE15hUBnxfwGQ==
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
Subject: [PATCH v18 12/17] fprobe: Add fprobe_header encoding feature
Date: Sat, 26 Oct 2024 13:37:59 +0900
Message-ID: <172991747946.443985.11014834036464028393.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <172991731968.443985.4558065903004844780.stgit@devnote2>
References: <172991731968.443985.4558065903004844780.stgit@devnote2>
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
 arch/arm64/include/asm/fprobe.h     |    7 +++++++
 arch/loongarch/include/asm/fprobe.h |    5 +++++
 arch/riscv/include/asm/fprobe.h     |    9 +++++++++
 arch/s390/include/asm/fprobe.h      |   10 ++++++++++
 arch/x86/include/asm/fprobe.h       |    9 +++++++++
 include/asm-generic/fprobe.h        |   33 +++++++++++++++++++++++++++++++++
 kernel/trace/fprobe.c               |   29 +++++++++++++++++++++++++++++
 7 files changed, 102 insertions(+)
 create mode 100644 arch/arm64/include/asm/fprobe.h
 create mode 100644 arch/loongarch/include/asm/fprobe.h
 create mode 100644 arch/riscv/include/asm/fprobe.h
 create mode 100644 arch/s390/include/asm/fprobe.h
 create mode 100644 arch/x86/include/asm/fprobe.h
 create mode 100644 include/asm-generic/fprobe.h

diff --git a/arch/arm64/include/asm/fprobe.h b/arch/arm64/include/asm/fprobe.h
new file mode 100644
index 000000000000..bbf254db878d
--- /dev/null
+++ b/arch/arm64/include/asm/fprobe.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_ARM64_FPROBE_H
+#define _ASM_ARM64_FPROBE_H
+
+#include <asm-generic/fprobe.h>
+
+#endif /* _ASM_ARM64_FPROBE_H */
\ No newline at end of file
diff --git a/arch/loongarch/include/asm/fprobe.h b/arch/loongarch/include/asm/fprobe.h
new file mode 100644
index 000000000000..68156a66873c
--- /dev/null
+++ b/arch/loongarch/include/asm/fprobe.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_LOONGARCH_FPROBE_H
+#define _ASM_LOONGARCH_FPROBE_H
+
+#endif /* _ASM_LOONGARCH_FPROBE_H */
\ No newline at end of file
diff --git a/arch/riscv/include/asm/fprobe.h b/arch/riscv/include/asm/fprobe.h
new file mode 100644
index 000000000000..51fc2ef3eda1
--- /dev/null
+++ b/arch/riscv/include/asm/fprobe.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RISCV_FPROBE_H
+#define _ASM_RISCV_FPROBE_H
+
+#ifdef CONFIG_64BIT
+#include <asm-generic/fprobe.h>
+#endif
+
+#endif /* _ASM_RISCV_FPROBE_H */
\ No newline at end of file
diff --git a/arch/s390/include/asm/fprobe.h b/arch/s390/include/asm/fprobe.h
new file mode 100644
index 000000000000..84b94ba6e3a4
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
\ No newline at end of file
diff --git a/arch/x86/include/asm/fprobe.h b/arch/x86/include/asm/fprobe.h
new file mode 100644
index 000000000000..c863518bef90
--- /dev/null
+++ b/arch/x86/include/asm/fprobe.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_FPROBE_H
+#define _ASM_X86_FPROBE_H
+
+#ifdef CONFIG_64BIT
+#include <asm-generic/fprobe.h>
+#endif
+
+#endif /* _ASM_X86_FPROBE_H */
\ No newline at end of file
diff --git a/include/asm-generic/fprobe.h b/include/asm-generic/fprobe.h
new file mode 100644
index 000000000000..00f480748a1d
--- /dev/null
+++ b/include/asm-generic/fprobe.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * linux/include/asm-generic/fprobe.h
+ */
+#ifndef __ASM_GENERIC_FPROBE_H__
+#define __ASM_GENERIC_FPROBE_H__
+
+#include <linux/bits.h>
+
+#define ARCH_HAVE_ENCODE_FPROBE_HEADER
+
+#define FPROBE_HEADER_MSB_SIZE_SHIFT (BITS_PER_LONG - FPROBE_DATA_SIZE_BITS)
+#define FPROBE_HEADER_MSB_MASK					\
+	GENMASK(FPROBE_HEADER_MSB_SIZE_SHIFT - 1, 0)
+#define FPROBE_HEADER_MSB_PATTERN				\
+	GENMASK(BITS_PER_LONG - 1, FPROBE_HEADER_MSB_SIZE_SHIFT)
+
+#define arch_fprobe_header_encodable(fp)			\
+	(((unsigned long)(fp) & ~FPROBE_HEADER_MSB_MASK) ==	\
+	 FPROBE_HEADER_MSB_PATTERN)
+
+#define arch_encode_fprobe_header(fp, size) 			\
+	((unsigned long)(fp) & FPROBE_HEADER_MSB_MASK) | 	\
+	((unsigned long)(size) << FPROBE_HEADER_MSB_SIZE_SHIFT)
+
+#define arch_decode_fprobe_header_size(val) 			\
+	((unsigned long)(val) >> FPROBE_HEADER_MSB_SIZE_SHIFT)
+
+#define arch_decode_fprobe_header_fp(val) 					\
+	(struct fprobe *)(((unsigned long)(val) & FPROBE_HEADER_MSB_MASK) |	\
+			  FPROBE_HEADER_MSB_PATTERN)
+
+#endif /* __ASM_GENERIC_FPROBE_H__ */
\ No newline at end of file
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index ed9c1d79426a..949963f1f17a 100644
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
 
+#ifdef ARCH_HAVE_ENCODE_FPROBE_HEADER
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


