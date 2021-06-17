Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F67E3AA890
	for <lists+linux-arch@lfdr.de>; Thu, 17 Jun 2021 03:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbhFQB1r (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Jun 2021 21:27:47 -0400
Received: from mail-ej1-f46.google.com ([209.85.218.46]:37551 "EHLO
        mail-ej1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbhFQB1p (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Jun 2021 21:27:45 -0400
Received: by mail-ej1-f46.google.com with SMTP id ji1so702414ejc.4;
        Wed, 16 Jun 2021 18:25:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UMZDQpCn1XRqR5Gdtk9bdzPOC5AEK8tjHkOdd1NiUcw=;
        b=p9fJdABIzHHII4zkzfPex5TeAzLbi/ryXrQVkoADZVco13DyqGpnyWOpB3ygMrmleY
         dCuOtmzAcD0Uc1ZOm/EcwKVOfGcW3YHF91vWfq2FY+fdUsUGubgJMQha68FSPFTwhOOx
         MywAE1t932I6a6DQziYQxeqwegiKL9SWKqYCLz9zxA8ne//50hc6xo7tyloIKOq6YOWl
         SZVTEvZ7NQvO1JQPhgRaPO69wp4ykGCBekzHMhLnS4d4AAf1+EVbOTlP5u/V6FbVLjLJ
         1PEwL35ywf5+Z0x6ohn6bomhlQgfH60ldlhCm/tF0kKLlEpqtNbl7psEH5r7+viYqxco
         X57g==
X-Gm-Message-State: AOAM531OVC6hTc9NSj/DJWSE8TkFTIq+UVt2ogyEbt3GOe/W4mZMNQPz
        h60lklwHJ7nXGo3ZsDlOOK0=
X-Google-Smtp-Source: ABdhPJy57Vm9mQa+dehtQP34RDaGyCPqXGaDI/OsUo1jLe0t09rA9pyYdHOVlD3nn90hkt4f/sYWtg==
X-Received: by 2002:a17:906:9713:: with SMTP id k19mr2402972ejx.516.1623893136495;
        Wed, 16 Jun 2021 18:25:36 -0700 (PDT)
Received: from msft-t490s.teknoraver.net (net-37-119-128-179.cust.vodafonedsl.it. [37.119.128.179])
        by smtp.gmail.com with ESMTPSA id lu21sm2624721ejb.31.2021.06.16.18.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 18:25:36 -0700 (PDT)
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
        Guo Ren <guoren@kernel.org>
Subject: [PATCH v2 2/3] riscv: optimized memmove
Date:   Thu, 17 Jun 2021 03:25:08 +0200
Message-Id: <20210617012509.34265-3-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210617012509.34265-1-mcroce@linux.microsoft.com>
References: <20210617012509.34265-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

When the destination buffer is before the source one, or when the
buffers doesn't overlap, it's safe to use memcpy() instead, which is
optimized to use the bigger data size possible.

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
index 694352d21c21..c932401e365b 100644
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
+void __weak *memmove(void *dest, const void *src, size_t count)
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

