Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01BCF3AB77E
	for <lists+linux-arch@lfdr.de>; Thu, 17 Jun 2021 17:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbhFQPal (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Jun 2021 11:30:41 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:43953 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbhFQPab (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Jun 2021 11:30:31 -0400
Received: by mail-ed1-f46.google.com with SMTP id s6so4555845edu.10;
        Thu, 17 Jun 2021 08:28:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+FVDwFs2xHOEhSpP+OaWvipHFOx9EExeCmOqxSerbcM=;
        b=YBhUW7iV39WIEkFktRemnO/Y/2fagBrglW+xTMq5MJsAxMuauInktey9WTK+XhxYwb
         p2R1OQG2U7KfHDZ88hEPcqilfzqJMWRf10mO4OJF/iOeXf6jSZTFt/e9/wTP0O3JeM3o
         VzBag/JejH4NB7KYt/tczx1u78K8MmVmFISPQIOk4510UzbRr1tuP8SeKFuAo/rp4oDb
         iwjkjnrKlpPxH5cStVEgWBYEFSWJcJUpiFWcW5qU/P90K0U1FQp0j5RPxN0Ql0S+tkjl
         iIL7kZSfwq6pNMh8exp0uUFb9hYMkWeXnS0o9auXHuBt1TQ4dj5jk71O8FzwqKLO6Kts
         GtFg==
X-Gm-Message-State: AOAM530B0N2Yz5MingG+3K8Q/kYguv2gs/o7HDT0+VRaDwGqCvW1r87S
        ucneezU7FF7DTHkuAReAxno=
X-Google-Smtp-Source: ABdhPJy5ZWJ2v6Z/VT0vS6YYgk2KdhYYjP3mEp3SfxDkxhH7pfuRs4wHrcyf5WMFM03M2A6bq50hcg==
X-Received: by 2002:aa7:c84a:: with SMTP id g10mr7287948edt.326.1623943702665;
        Thu, 17 Jun 2021 08:28:22 -0700 (PDT)
Received: from msft-t490s.teknoraver.net (net-37-119-128-179.cust.vodafonedsl.it. [37.119.128.179])
        by smtp.gmail.com with ESMTPSA id g11sm4497850edz.12.2021.06.17.08.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 08:28:22 -0700 (PDT)
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
Subject: [PATCH v3 2/3] riscv: optimized memmove
Date:   Thu, 17 Jun 2021 17:27:53 +0200
Message-Id: <20210617152754.17960-3-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210617152754.17960-1-mcroce@linux.microsoft.com>
References: <20210617152754.17960-1-mcroce@linux.microsoft.com>
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
 arch/riscv/lib/string.c         | 23 ++++++++++++
 5 files changed, 26 insertions(+), 70 deletions(-)
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
index e48a79a045d8..9c7009d43c39 100644
--- a/arch/riscv/lib/string.c
+++ b/arch/riscv/lib/string.c
@@ -89,3 +89,26 @@ EXPORT_SYMBOL(__memcpy);
 
 void *memcpy(void *dest, const void *src, size_t count) __weak __alias(__memcpy);
 EXPORT_SYMBOL(memcpy);
+
+/*
+ * Simply check if the buffer overlaps an call memcpy() in case,
+ * otherwise do a simple one byte at time backward copy.
+ */
+void *__memmove(void *dest, const void *src, size_t count)
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
+EXPORT_SYMBOL(__memmove);
+
+void *memmove(void *dest, const void *src, size_t count) __weak __alias(__memmove);
+EXPORT_SYMBOL(memmove);
-- 
2.31.1

