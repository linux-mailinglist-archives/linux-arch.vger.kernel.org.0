Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDC63A742D
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jun 2021 04:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhFOCni (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Jun 2021 22:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbhFOCnh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Jun 2021 22:43:37 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C192C0613A2;
        Mon, 14 Jun 2021 19:41:32 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id i13so49057841edb.9;
        Mon, 14 Jun 2021 19:41:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B5eq+NMAoBB0mBYPYHItWOU/L9Y+dhBJjcdEFT7I1T0=;
        b=N7RSWYKtywZUVGlEfsHMovgNQWTW2R8HFyf088K+3Mt3887DyYPA18NsoeFOcNdmkV
         WdZROytA3MUBineW95pIUszlHlJ8uqXKmTck03gRCTvlO/E+ntPogca0Q1z0sfjxLu+w
         6jmos858Hsw3x4IRVXtqO473gwyQuIOeYys4+czHs4tPxkhfn8LBV2+Z0TZZbt3Y6ofx
         EGnf/hKcEJWZ5A5ciYRvAKi+RIwjMS8SCguRAQbpXz+HlrOuu+8Vl80k4K+86Im0sQRd
         9djTigGa0jgNdTE0pHOqqt+c2aCYhi5nopz19s3OhWxoLxi3urffJqPV4QUeWQVkpqQN
         v6nA==
X-Gm-Message-State: AOAM531H77CSQ94jlOTnXBSU4mmkSlM/nP1xU65EfsRz5zj32LaAdrAQ
        urw048F1Cj3I2Z+hAEB0xi4=
X-Google-Smtp-Source: ABdhPJyxEl2Bki0u7t8w2cOeJo1RLJ78EgRJ98Dqw2D99S4+5PkI8ZANdpxsaExN1kz5bIyZ8ZCuvA==
X-Received: by 2002:aa7:d590:: with SMTP id r16mr20773482edq.355.1623724823944;
        Mon, 14 Jun 2021 19:40:23 -0700 (PDT)
Received: from msft-t490s.teknoraver.net (net-37-119-128-179.cust.vodafonedsl.it. [37.119.128.179])
        by smtp.gmail.com with ESMTPSA id cn25sm834966edb.69.2021.06.14.19.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 19:40:23 -0700 (PDT)
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
        Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 2/3] riscv: optimized memmove
Date:   Tue, 15 Jun 2021 04:38:11 +0200
Message-Id: <20210615023812.50885-3-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210615023812.50885-1-mcroce@linux.microsoft.com>
References: <20210615023812.50885-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

When the destination buffer is before the source one, or when the
buffers doesn't overlap, it's safe to use memcpy() instead, which is
optimized to use a bigger data size possible.

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 arch/riscv/include/asm/string.h |  6 ++--
 arch/riscv/kernel/riscv_ksyms.c |  2 --
 arch/riscv/lib/Makefile         |  1 -
 arch/riscv/lib/memmove.S        | 64 ---------------------------------
 arch/riscv/lib/string.c         | 26 ++++++++++++++
 5 files changed, 29 insertions(+), 70 deletions(-)
 delete mode 100644 arch/riscv/lib/memmove.S

diff --git a/arch/riscv/include/asm/string.h b/arch/riscv/include/asm/string.h
index 6b5d6fc3eab4..25d9b9078569 100644
--- a/arch/riscv/include/asm/string.h
+++ b/arch/riscv/include/asm/string.h
@@ -17,11 +17,11 @@ extern asmlinkage void *__memset(void *, int, size_t);
 #define __HAVE_ARCH_MEMCPY
 extern void *memcpy(void *dest, const void *src, size_t count);
 extern void *__memcpy(void *dest, const void *src, size_t count);
+#define __HAVE_ARCH_MEMMOVE
+extern void *memmove(void *dest, const void *src, size_t count);
+extern void *__memmove(void *dest, const void *src, size_t count);
 #endif
 
-#define __HAVE_ARCH_MEMMOVE
-extern asmlinkage void *memmove(void *, const void *, size_t);
-extern asmlinkage void *__memmove(void *, const void *, size_t);
 /* For those files which don't want to check by kasan. */
 #if defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__)
 #define memcpy(dst, src, len) __memcpy(dst, src, len)
diff --git a/arch/riscv/kernel/riscv_ksyms.c b/arch/riscv/kernel/riscv_ksyms.c
index 3f6d512a5b97..361565c4db7e 100644
--- a/arch/riscv/kernel/riscv_ksyms.c
+++ b/arch/riscv/kernel/riscv_ksyms.c
@@ -10,6 +10,4 @@
  * Assembly functions that may be used (directly or indirectly) by modules
  */
 EXPORT_SYMBOL(memset);
-EXPORT_SYMBOL(memmove);
 EXPORT_SYMBOL(__memset);
-EXPORT_SYMBOL(__memmove);
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index 2ffe85d4baee..484f5ff7b508 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 lib-y			+= delay.o
 lib-y			+= memset.o
-lib-y			+= memmove.o
 lib-$(CONFIG_MMU)	+= uaccess.o
 lib-$(CONFIG_64BIT)	+= tishift.o
 lib-$(CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE) += string.o
diff --git a/arch/riscv/lib/memmove.S b/arch/riscv/lib/memmove.S
deleted file mode 100644
index 07d1d2152ba5..000000000000
--- a/arch/riscv/lib/memmove.S
+++ /dev/null
@@ -1,64 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#include <linux/linkage.h>
-#include <asm/asm.h>
-
-ENTRY(__memmove)
-WEAK(memmove)
-        move    t0, a0
-        move    t1, a1
-
-        beq     a0, a1, exit_memcpy
-        beqz    a2, exit_memcpy
-        srli    t2, a2, 0x2
-
-        slt     t3, a0, a1
-        beqz    t3, do_reverse
-
-        andi    a2, a2, 0x3
-        li      t4, 1
-        beqz    t2, byte_copy
-
-word_copy:
-        lw      t3, 0(a1)
-        addi    t2, t2, -1
-        addi    a1, a1, 4
-        sw      t3, 0(a0)
-        addi    a0, a0, 4
-        bnez    t2, word_copy
-        beqz    a2, exit_memcpy
-        j       byte_copy
-
-do_reverse:
-        add     a0, a0, a2
-        add     a1, a1, a2
-        andi    a2, a2, 0x3
-        li      t4, -1
-        beqz    t2, reverse_byte_copy
-
-reverse_word_copy:
-        addi    a1, a1, -4
-        addi    t2, t2, -1
-        lw      t3, 0(a1)
-        addi    a0, a0, -4
-        sw      t3, 0(a0)
-        bnez    t2, reverse_word_copy
-        beqz    a2, exit_memcpy
-
-reverse_byte_copy:
-        addi    a0, a0, -1
-        addi    a1, a1, -1
-
-byte_copy:
-        lb      t3, 0(a1)
-        addi    a2, a2, -1
-        sb      t3, 0(a0)
-        add     a1, a1, t4
-        add     a0, a0, t4
-        bnez    a2, byte_copy
-
-exit_memcpy:
-        move a0, t0
-        move a1, t1
-        ret
-END(__memmove)
diff --git a/arch/riscv/lib/string.c b/arch/riscv/lib/string.c
index 525f9ee25a74..bc006708f075 100644
--- a/arch/riscv/lib/string.c
+++ b/arch/riscv/lib/string.c
@@ -92,3 +92,29 @@ void *__memcpy(void *dest, const void *src, size_t count)
 	return memcpy(dest, src, count);
 }
 EXPORT_SYMBOL(__memcpy);
+
+/*
+ * Simply check if the buffer overlaps an call memcpy() in case,
+ * otherwise do a simple one byte at time backward copy.
+ */
+void *memmove(void *dest, const void *src, size_t count)
+{
+	if (dest < src || src + count <= dest)
+		return memcpy(dest, src, count);
+
+	if (dest > src) {
+		const char *s = src + count;
+		char *tmp = dest + count;
+
+		while (count--)
+			*--tmp = *--s;
+	}
+	return dest;
+}
+EXPORT_SYMBOL(memmove);
+
+void *__memmove(void *dest, const void *src, size_t count)
+{
+	return memmove(dest, src, count);
+}
+EXPORT_SYMBOL(__memmove);
-- 
2.31.1

