Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD3B613B369
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2020 21:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgANUJG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jan 2020 15:09:06 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:53206 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727285AbgANUI5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Jan 2020 15:08:57 -0500
Received: from mailhost.synopsys.com (sv2-mailhost1.synopsys.com [10.205.2.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D144B406F7;
        Tue, 14 Jan 2020 20:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1579032536; bh=pnuNzowJEgDqFBcmPzhqodh5b56v6RmG8ENp9KF/2mQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CBcoxjqItxVjnTN0eYL3kI5Re7OGfz1Wr/fEHGi/KZQSeWVEV4Y6lKo+YXfps9tUb
         +OiepL3APR61mf5HiqQQu3gcE6J+pDR2nkZ7DTCT04x+UYI3LJQ3JdS+1qUmG3KNcq
         M9ZR0dwNXKMThv+OivrSN9MRIeloVrhg60DOUKQLDEN8lx/7vcGDQPVI78x4J62nM5
         XfriUwN4yomOGCl2oTAqolFokcsc9QZHUdcLB8Ahmsyf2vwxzCNA47RfRByRL8x1H4
         Z9nVQ7//YTY82LmYfl+NRSYMWxCqAa42QwIT1cd3ExRleiMENTWfXTl+zfjcRK9hYQ
         SJtLUn/iHDKBw==
Received: from vineetg-Latitude-E7450.internal.synopsys.com (vineetg-latitude-e7450.internal.synopsys.com [10.10.161.25])
        by mailhost.synopsys.com (Postfix) with ESMTP id 8090AA00AD;
        Tue, 14 Jan 2020 20:08:55 +0000 (UTC)
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [RFC 4/4] ARC: uaccess: use optimized generic __strnlen_user/__strncpy_from_user
Date:   Tue, 14 Jan 2020 12:08:46 -0800
Message-Id: <20200114200846.29434-5-vgupta@synopsys.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200114200846.29434-1-vgupta@synopsys.com>
References: <20200114200846.29434-1-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

These rely on word access rather than byte loop

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/Kconfig                      |  2 +
 arch/arc/include/asm/Kbuild           |  1 -
 arch/arc/include/asm/uaccess.h        | 71 ++-------------------------
 arch/arc/include/asm/word-at-a-time.h | 49 ++++++++++++++++++
 4 files changed, 56 insertions(+), 67 deletions(-)
 create mode 100644 arch/arc/include/asm/word-at-a-time.h

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 26108ea785c2..3b074c4d31fb 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -26,6 +26,8 @@ config ARC
 	select GENERIC_PENDING_IRQ if SMP
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
+	select GENERIC_STRNCPY_FROM_USER if MMU
+	select GENERIC_STRNLEN_USER if MMU
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_DEBUG_STACKOVERFLOW
diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild
index 1b505694691e..cb8d459b7f56 100644
--- a/arch/arc/include/asm/Kbuild
+++ b/arch/arc/include/asm/Kbuild
@@ -24,5 +24,4 @@ generic-y += topology.h
 generic-y += trace_clock.h
 generic-y += user.h
 generic-y += vga.h
-generic-y += word-at-a-time.h
 generic-y += xor.h
diff --git a/arch/arc/include/asm/uaccess.h b/arch/arc/include/asm/uaccess.h
index 0b34c152086f..f579e06447a9 100644
--- a/arch/arc/include/asm/uaccess.h
+++ b/arch/arc/include/asm/uaccess.h
@@ -23,7 +23,6 @@
 
 #include <linux/string.h>	/* for generic string functions */
 
-
 #define __kernel_ok		(uaccess_kernel())
 
 /*
@@ -52,6 +51,8 @@
 #define __access_ok(addr, sz)	(unlikely(__kernel_ok) || \
 				 likely(__user_ok((addr), (sz))))
 
+#define user_addr_max() 	(uaccess_kernel() ? ~0UL : get_fs())
+
 /*********** Single byte/hword/word copies ******************/
 
 #define __get_user_fn(sz, u, k)					\
@@ -655,75 +656,13 @@ static inline unsigned long __clear_user(void __user *to, unsigned long n)
 	return res;
 }
 
-static inline long
-__strncpy_from_user(char *dst, const char __user *src, long count)
-{
-	long res = 0;
-	char val;
-
-	if (count == 0)
-		return 0;
-
-	__asm__ __volatile__(
-	"	mov	lp_count, %5		\n"
-	"	lp	3f			\n"
-	"1:	ldb.ab  %3, [%2, 1]		\n"
-	"	breq.d	%3, 0, 3f               \n"
-	"	stb.ab  %3, [%1, 1]		\n"
-	"	add	%0, %0, 1	# Num of NON NULL bytes copied	\n"
-	"3:								\n"
-	"	.section .fixup, \"ax\"		\n"
-	"	.align 4			\n"
-	"4:	mov %0, %4		# sets @res as -EFAULT	\n"
-	"	j   3b				\n"
-	"	.previous			\n"
-	"	.section __ex_table, \"a\"	\n"
-	"	.align 4			\n"
-	"	.word   1b, 4b			\n"
-	"	.previous			\n"
-	: "+r"(res), "+r"(dst), "+r"(src), "=r"(val)
-	: "g"(-EFAULT), "r"(count)
-	: "lp_count", "memory");
-
-	return res;
-}
-
-static inline long __strnlen_user(const char __user *s, long n)
-{
-	long res, tmp1, cnt;
-	char val;
-
-	__asm__ __volatile__(
-	"	mov %2, %1			\n"
-	"1:	ldb.ab  %3, [%0, 1]		\n"
-	"	breq.d  %3, 0, 2f		\n"
-	"	sub.f   %2, %2, 1		\n"
-	"	bnz 1b				\n"
-	"	sub %2, %2, 1			\n"
-	"2:	sub %0, %1, %2			\n"
-	"3:	;nop				\n"
-	"	.section .fixup, \"ax\"		\n"
-	"	.align 4			\n"
-	"4:	mov %0, 0			\n"
-	"	j   3b				\n"
-	"	.previous			\n"
-	"	.section __ex_table, \"a\"	\n"
-	"	.align 4			\n"
-	"	.word 1b, 4b			\n"
-	"	.previous			\n"
-	: "=r"(res), "=r"(tmp1), "=r"(cnt), "=r"(val)
-	: "0"(s), "1"(n)
-	: "memory");
-
-	return res;
-}
-
 #define INLINE_COPY_TO_USER
 #define INLINE_COPY_FROM_USER
 
 #define __clear_user		__clear_user
-#define __strncpy_from_user	__strncpy_from_user
-#define __strnlen_user		__strnlen_user
+
+extern long strncpy_from_user(char *dest, const char __user *src, long count);
+extern __must_check long strnlen_user(const char __user *str, long n);
 
 #include <asm/segment.h>
 #include <asm-generic/uaccess.h>
diff --git a/arch/arc/include/asm/word-at-a-time.h b/arch/arc/include/asm/word-at-a-time.h
new file mode 100644
index 000000000000..00e92be70987
--- /dev/null
+++ b/arch/arc/include/asm/word-at-a-time.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2020 Synopsys Inc.
+ */
+#ifndef __ASM_ARC_WORD_AT_A_TIME_H
+#define __ASM_ARC_WORD_AT_A_TIME_H
+
+#ifdef __LITTLE_ENDIAN__
+
+#include <linux/kernel.h>
+
+struct word_at_a_time {
+	const unsigned long one_bits, high_bits;
+};
+
+#define WORD_AT_A_TIME_CONSTANTS { REPEAT_BYTE(0x01), REPEAT_BYTE(0x80) }
+
+static inline unsigned long has_zero(unsigned long a, unsigned long *bits,
+				     const struct word_at_a_time *c)
+{
+	unsigned long mask = ((a - c->one_bits) & ~a) & c->high_bits;
+	*bits = mask;
+	return mask;
+}
+
+#define prep_zero_mask(a, bits, c) (bits)
+
+static inline unsigned long create_zero_mask(unsigned long bits)
+{
+	bits = (bits - 1) & ~bits;
+	return bits >> 7;
+}
+
+static inline unsigned long find_zero(unsigned long mask)
+{
+#ifdef CONFIG_64BIT
+	return fls64(mask) >> 3;
+#else
+	return fls(mask) >> 3;
+#endif
+}
+
+#define zero_bytemask(mask) (mask)
+
+#else	/* __BIG_ENDIAN__ */
+#include <asm-generic/word-at-a-time.h>
+#endif
+
+#endif /* __ASM_WORD_AT_A_TIME_H */
-- 
2.20.1

