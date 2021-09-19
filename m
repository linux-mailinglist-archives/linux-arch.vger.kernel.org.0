Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9C5410D10
	for <lists+linux-arch@lfdr.de>; Sun, 19 Sep 2021 21:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhISTXH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 19 Sep 2021 15:23:07 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:38570 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbhISTXF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 19 Sep 2021 15:23:05 -0400
Received: by mail-ed1-f47.google.com with SMTP id q3so52209952edt.5;
        Sun, 19 Sep 2021 12:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6WKTUDHCnT3OPIFvure+beopQF+eNqtWBPQ4gjVkMTI=;
        b=4pcux8WhROBGznopjrX8GQneNtVmyDuMuykF750jybo+BQXe84Igxq+wCDnjJHFddG
         EaZCSI4Vb+gir4BsY3dgTRk/lin7IyFolEHXn42378dqIdqEcsTOKtyXxZ7ZjIzytOp6
         mrmkVoYG5A1aLxiJFu5V8Uu5/rp1kt4fejI1YDMQm3o5zrczeTVedY22V4TivFgAAQwS
         zBDqR1B7Hv6LqATqQbH6tdITgdgfT7gPbguwT36hT/W2nx/dTdY0sPjc8MTiOAImq6F6
         W+XPvbJSiGXtDISNSEOG9kLd9loxnnG7ucZFCCLQfN4TC76Q4xDJJX0CDZi+wvTaFxpB
         2aLA==
X-Gm-Message-State: AOAM531o5iVFS7Ac3kiYEY2fd25/KCuu+zxoYTfUTwTi96MvBp6sTaie
        LgUKQEXjQ8dV4zlnvJDDARE=
X-Google-Smtp-Source: ABdhPJzBhq+wusZQHO1R26VyDP34hQgE/m5908flWiPlxtv1eZ2hpsrwywzIJFpM61oQ/n2aK066ww==
X-Received: by 2002:a05:6402:4247:: with SMTP id g7mr25350958edb.287.1632079299299;
        Sun, 19 Sep 2021 12:21:39 -0700 (PDT)
Received: from turbo.teknoraver.net (net-2-34-36-22.cust.vodafonedsl.it. [2.34.36.22])
        by smtp.gmail.com with ESMTPSA id 10sm5208525eju.12.2021.09.19.12.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 12:21:38 -0700 (PDT)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        Bin Meng <bmeng.cn@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Guo Ren <guoren@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 3/3] riscv: optimized memset
Date:   Sun, 19 Sep 2021 21:21:04 +0200
Message-Id: <20210919192104.98592-4-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210919192104.98592-1-mcroce@linux.microsoft.com>
References: <20210919192104.98592-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

The generic memset is defined as a byte at time write. This is always
safe, but it's slower than a 4 byte or even 8 byte write.

Write a generic memset which fills the data one byte at time until the
destination is aligned, then fills using the largest size allowed,
and finally fills the remaining data one byte at time.

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 arch/riscv/include/asm/string.h |  10 +--
 arch/riscv/kernel/Makefile      |   1 -
 arch/riscv/kernel/riscv_ksyms.c |  13 ----
 arch/riscv/lib/Makefile         |   1 -
 arch/riscv/lib/memset.S         | 113 --------------------------------
 arch/riscv/lib/string.c         |  41 ++++++++++++
 6 files changed, 44 insertions(+), 135 deletions(-)
 delete mode 100644 arch/riscv/kernel/riscv_ksyms.c
 delete mode 100644 arch/riscv/lib/memset.S

diff --git a/arch/riscv/include/asm/string.h b/arch/riscv/include/asm/string.h
index 25d9b9078569..90500635035a 100644
--- a/arch/riscv/include/asm/string.h
+++ b/arch/riscv/include/asm/string.h
@@ -6,14 +6,10 @@
 #ifndef _ASM_RISCV_STRING_H
 #define _ASM_RISCV_STRING_H
 
-#include <linux/types.h>
-#include <linux/linkage.h>
-
-#define __HAVE_ARCH_MEMSET
-extern asmlinkage void *memset(void *, int, size_t);
-extern asmlinkage void *__memset(void *, int, size_t);
-
 #ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
+#define __HAVE_ARCH_MEMSET
+extern void *memset(void *s, int c, size_t count);
+extern void *__memset(void *s, int c, size_t count);
 #define __HAVE_ARCH_MEMCPY
 extern void *memcpy(void *dest, const void *src, size_t count);
 extern void *__memcpy(void *dest, const void *src, size_t count);
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 3397ddac1a30..fecf03822435 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -31,7 +31,6 @@ obj-y	+= syscall_table.o
 obj-y	+= sys_riscv.o
 obj-y	+= time.o
 obj-y	+= traps.o
-obj-y	+= riscv_ksyms.o
 obj-y	+= stacktrace.o
 obj-y	+= cacheinfo.o
 obj-y	+= patch.o
diff --git a/arch/riscv/kernel/riscv_ksyms.c b/arch/riscv/kernel/riscv_ksyms.c
deleted file mode 100644
index 361565c4db7e..000000000000
--- a/arch/riscv/kernel/riscv_ksyms.c
+++ /dev/null
@@ -1,13 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2017 Zihao Yu
- */
-
-#include <linux/export.h>
-#include <linux/uaccess.h>
-
-/*
- * Assembly functions that may be used (directly or indirectly) by modules
- */
-EXPORT_SYMBOL(memset);
-EXPORT_SYMBOL(__memset);
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index 484f5ff7b508..e33263cc622a 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 lib-y			+= delay.o
-lib-y			+= memset.o
 lib-$(CONFIG_MMU)	+= uaccess.o
 lib-$(CONFIG_64BIT)	+= tishift.o
 lib-$(CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE) += string.o
diff --git a/arch/riscv/lib/memset.S b/arch/riscv/lib/memset.S
deleted file mode 100644
index 34c5360c6705..000000000000
--- a/arch/riscv/lib/memset.S
+++ /dev/null
@@ -1,113 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2013 Regents of the University of California
- */
-
-
-#include <linux/linkage.h>
-#include <asm/asm.h>
-
-/* void *memset(void *, int, size_t) */
-ENTRY(__memset)
-WEAK(memset)
-	move t0, a0  /* Preserve return value */
-
-	/* Defer to byte-oriented fill for small sizes */
-	sltiu a3, a2, 16
-	bnez a3, 4f
-
-	/*
-	 * Round to nearest XLEN-aligned address
-	 * greater than or equal to start address
-	 */
-	addi a3, t0, SZREG-1
-	andi a3, a3, ~(SZREG-1)
-	beq a3, t0, 2f  /* Skip if already aligned */
-	/* Handle initial misalignment */
-	sub a4, a3, t0
-1:
-	sb a1, 0(t0)
-	addi t0, t0, 1
-	bltu t0, a3, 1b
-	sub a2, a2, a4  /* Update count */
-
-2: /* Duff's device with 32 XLEN stores per iteration */
-	/* Broadcast value into all bytes */
-	andi a1, a1, 0xff
-	slli a3, a1, 8
-	or a1, a3, a1
-	slli a3, a1, 16
-	or a1, a3, a1
-#ifdef CONFIG_64BIT
-	slli a3, a1, 32
-	or a1, a3, a1
-#endif
-
-	/* Calculate end address */
-	andi a4, a2, ~(SZREG-1)
-	add a3, t0, a4
-
-	andi a4, a4, 31*SZREG  /* Calculate remainder */
-	beqz a4, 3f            /* Shortcut if no remainder */
-	neg a4, a4
-	addi a4, a4, 32*SZREG  /* Calculate initial offset */
-
-	/* Adjust start address with offset */
-	sub t0, t0, a4
-
-	/* Jump into loop body */
-	/* Assumes 32-bit instruction lengths */
-	la a5, 3f
-#ifdef CONFIG_64BIT
-	srli a4, a4, 1
-#endif
-	add a5, a5, a4
-	jr a5
-3:
-	REG_S a1,        0(t0)
-	REG_S a1,    SZREG(t0)
-	REG_S a1,  2*SZREG(t0)
-	REG_S a1,  3*SZREG(t0)
-	REG_S a1,  4*SZREG(t0)
-	REG_S a1,  5*SZREG(t0)
-	REG_S a1,  6*SZREG(t0)
-	REG_S a1,  7*SZREG(t0)
-	REG_S a1,  8*SZREG(t0)
-	REG_S a1,  9*SZREG(t0)
-	REG_S a1, 10*SZREG(t0)
-	REG_S a1, 11*SZREG(t0)
-	REG_S a1, 12*SZREG(t0)
-	REG_S a1, 13*SZREG(t0)
-	REG_S a1, 14*SZREG(t0)
-	REG_S a1, 15*SZREG(t0)
-	REG_S a1, 16*SZREG(t0)
-	REG_S a1, 17*SZREG(t0)
-	REG_S a1, 18*SZREG(t0)
-	REG_S a1, 19*SZREG(t0)
-	REG_S a1, 20*SZREG(t0)
-	REG_S a1, 21*SZREG(t0)
-	REG_S a1, 22*SZREG(t0)
-	REG_S a1, 23*SZREG(t0)
-	REG_S a1, 24*SZREG(t0)
-	REG_S a1, 25*SZREG(t0)
-	REG_S a1, 26*SZREG(t0)
-	REG_S a1, 27*SZREG(t0)
-	REG_S a1, 28*SZREG(t0)
-	REG_S a1, 29*SZREG(t0)
-	REG_S a1, 30*SZREG(t0)
-	REG_S a1, 31*SZREG(t0)
-	addi t0, t0, 32*SZREG
-	bltu t0, a3, 3b
-	andi a2, a2, SZREG-1  /* Update count */
-
-4:
-	/* Handle trailing misalignment */
-	beqz a2, 6f
-	add a3, t0, a2
-5:
-	sb a1, 0(t0)
-	addi t0, t0, 1
-	bltu t0, a3, 5b
-6:
-	ret
-END(__memset)
diff --git a/arch/riscv/lib/string.c b/arch/riscv/lib/string.c
index da033af8fe2f..12daa71698fb 100644
--- a/arch/riscv/lib/string.c
+++ b/arch/riscv/lib/string.c
@@ -111,3 +111,44 @@ EXPORT_SYMBOL(__memmove);
 
 void *memmove(void *dest, const void *src, size_t count) __weak __alias(__memmove);
 EXPORT_SYMBOL(memmove);
+
+void *__memset(void *s, int c, size_t count)
+{
+	union types dest = { .as_u8 = s };
+
+	if (count >= MIN_THRESHOLD) {
+		unsigned long cu = (unsigned long)c;
+
+		/* Compose an ulong with 'c' repeated 4/8 times */
+#ifdef CONFIG_ARCH_HAS_FAST_MULTIPLIER
+		cu *= 0x0101010101010101UL;
+#else
+		cu |= cu << 8;
+		cu |= cu << 16;
+		/* Suppress warning on 32 bit machines */
+		cu |= (cu << 16) << 16;
+#endif
+		if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)) {
+			/*
+			 * Fill the buffer one byte at time until
+			 * the destination is word aligned.
+			 */
+			for (; count && dest.as_uptr & WORD_MASK; count--)
+				*dest.as_u8++ = c;
+		}
+
+		/* Copy using the largest size allowed */
+		for (; count >= BYTES_LONG; count -= BYTES_LONG)
+			*dest.as_ulong++ = cu;
+	}
+
+	/* copy the remainder */
+	while (count--)
+		*dest.as_u8++ = c;
+
+	return s;
+}
+EXPORT_SYMBOL(__memset);
+
+void *memset(void *s, int c, size_t count) __weak __alias(__memset);
+EXPORT_SYMBOL(memset);
-- 
2.31.1

