Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA2641CB01
	for <lists+linux-arch@lfdr.de>; Wed, 29 Sep 2021 19:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245157AbhI2RYY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Sep 2021 13:24:24 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:44841 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344094AbhI2RYX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Sep 2021 13:24:23 -0400
Received: by mail-wr1-f46.google.com with SMTP id d6so5485640wrc.11;
        Wed, 29 Sep 2021 10:22:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z/fjsp9YqZ9w10G0/lCqeb7NhPPLI/RdtJEwB09TTAk=;
        b=pRGg5UYREExR8nFiAOdDHwj/pb8+TDJLXyONl6fAtAa/HYOU5QldN51UP3+dk5Dyyj
         JtXBndtlmSccXsZFXqZaeV+/P4gzN4Aq8VdrBbFkMYd74QB8ppPSdY+D8kxwR9Cvdbqi
         j/2KHLMcJEqgs4fU5A/Ayfq1gLysP+74V4LOp9RhtvAe0iSvNxgRVaWehRjQgQlbMHFX
         QgKdHyvr1cCnuSybpW9LoOZ3NfohLMkSlfxVOCXng68QayW94TU1QtJkt9YyTA/3TH2h
         P4mJf+ebQINGNvI+bPqFenBDfU6/l3zbs+7OS/p6Rm3G8jhGlzE8QcmpVRmNNOHecadi
         gZAw==
X-Gm-Message-State: AOAM532fAbi1Zh+5OD1dpIuwjLA3OLQVqYlclvr+Iy2EN4WXTUvoQIbV
        UKKXIWSZb31oXM2pob50+3E=
X-Google-Smtp-Source: ABdhPJxuAsRjfCIKY/G4mmm5wEfClO0+eJpT5r79wkhfXcg6ND1k58KmN/NLJC47K6ayfu1sFqB6YA==
X-Received: by 2002:adf:a18d:: with SMTP id u13mr1097191wru.275.1632936161258;
        Wed, 29 Sep 2021 10:22:41 -0700 (PDT)
Received: from msft-t490s.. (mob-31-159-120-132.net.vodafone.it. [31.159.120.132])
        by smtp.gmail.com with ESMTPSA id n26sm2267502wmi.43.2021.09.29.10.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 10:22:40 -0700 (PDT)
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
Subject: [PATCH v5 1/3] riscv: optimized memcpy
Date:   Wed, 29 Sep 2021 19:22:32 +0200
Message-Id: <20210929172234.31620-2-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210929172234.31620-1-mcroce@linux.microsoft.com>
References: <20210929172234.31620-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

Write a C version of memcpy() which uses the biggest data size allowed,
without generating unaligned accesses.

The procedure is made of three steps:
First copy data one byte at time until the destination buffer is aligned
to a long boundary.
Then copy the data one long at time shifting the current and the next u8
to compose a long at every cycle.
Finally, copy the remainder one byte at time.

On a BeagleV, the TCP RX throughput increased by 45%:

before:

$ iperf3 -c beaglev
Connecting to host beaglev, port 5201
[  5] local 192.168.85.6 port 44840 connected to 192.168.85.48 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  76.4 MBytes   641 Mbits/sec   27    624 KBytes
[  5]   1.00-2.00   sec  72.5 MBytes   608 Mbits/sec    0    708 KBytes
[  5]   2.00-3.00   sec  73.8 MBytes   619 Mbits/sec   10    451 KBytes
[  5]   3.00-4.00   sec  72.5 MBytes   608 Mbits/sec    0    564 KBytes
[  5]   4.00-5.00   sec  73.8 MBytes   619 Mbits/sec    0    658 KBytes
[  5]   5.00-6.00   sec  73.8 MBytes   619 Mbits/sec   14    522 KBytes
[  5]   6.00-7.00   sec  73.8 MBytes   619 Mbits/sec    0    621 KBytes
[  5]   7.00-8.00   sec  72.5 MBytes   608 Mbits/sec    0    706 KBytes
[  5]   8.00-9.00   sec  73.8 MBytes   619 Mbits/sec   20    580 KBytes
[  5]   9.00-10.00  sec  73.8 MBytes   619 Mbits/sec    0    672 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec   736 MBytes   618 Mbits/sec   71             sender
[  5]   0.00-10.01  sec   733 MBytes   615 Mbits/sec                  receiver

after:

$ iperf3 -c beaglev
Connecting to host beaglev, port 5201
[  5] local 192.168.85.6 port 44864 connected to 192.168.85.48 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec   109 MBytes   912 Mbits/sec   48    559 KBytes
[  5]   1.00-2.00   sec   108 MBytes   902 Mbits/sec    0    690 KBytes
[  5]   2.00-3.00   sec   106 MBytes   891 Mbits/sec   36    396 KBytes
[  5]   3.00-4.00   sec   108 MBytes   902 Mbits/sec    0    567 KBytes
[  5]   4.00-5.00   sec   106 MBytes   891 Mbits/sec    0    699 KBytes
[  5]   5.00-6.00   sec   106 MBytes   891 Mbits/sec   32    414 KBytes
[  5]   6.00-7.00   sec   106 MBytes   891 Mbits/sec    0    583 KBytes
[  5]   7.00-8.00   sec   106 MBytes   891 Mbits/sec    0    708 KBytes
[  5]   8.00-9.00   sec   106 MBytes   891 Mbits/sec   28    433 KBytes
[  5]   9.00-10.00  sec   108 MBytes   902 Mbits/sec    0    591 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  1.04 GBytes   897 Mbits/sec  144             sender
[  5]   0.00-10.01  sec  1.04 GBytes   894 Mbits/sec                  receiver

And the decreased CPU time of the memcpy() is observable with perf top.
This is the `perf top -Ue task-clock` output when doing the test:

before:

Overhead  Shared O  Symbol
  42.22%  [kernel]  [k] memcpy
  35.00%  [kernel]  [k] __asm_copy_to_user
   3.50%  [kernel]  [k] sifive_l2_flush64_range
   2.30%  [kernel]  [k] stmmac_napi_poll_rx
   1.11%  [kernel]  [k] memset

after:

Overhead  Shared O  Symbol
  45.69%  [kernel]  [k] __asm_copy_to_user
  29.06%  [kernel]  [k] memcpy
   4.09%  [kernel]  [k] sifive_l2_flush64_range
   2.77%  [kernel]  [k] stmmac_napi_poll_rx
   1.24%  [kernel]  [k] memset

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 arch/riscv/include/asm/string.h |   8 ++-
 arch/riscv/kernel/riscv_ksyms.c |   2 -
 arch/riscv/lib/Makefile         |   2 +-
 arch/riscv/lib/memcpy.S         | 108 --------------------------------
 arch/riscv/lib/string.c         |  90 ++++++++++++++++++++++++++
 5 files changed, 97 insertions(+), 113 deletions(-)
 delete mode 100644 arch/riscv/lib/memcpy.S
 create mode 100644 arch/riscv/lib/string.c

diff --git a/arch/riscv/include/asm/string.h b/arch/riscv/include/asm/string.h
index 909049366555..6b5d6fc3eab4 100644
--- a/arch/riscv/include/asm/string.h
+++ b/arch/riscv/include/asm/string.h
@@ -12,9 +12,13 @@
 #define __HAVE_ARCH_MEMSET
 extern asmlinkage void *memset(void *, int, size_t);
 extern asmlinkage void *__memset(void *, int, size_t);
+
+#ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
 #define __HAVE_ARCH_MEMCPY
-extern asmlinkage void *memcpy(void *, const void *, size_t);
-extern asmlinkage void *__memcpy(void *, const void *, size_t);
+extern void *memcpy(void *dest, const void *src, size_t count);
+extern void *__memcpy(void *dest, const void *src, size_t count);
+#endif
+
 #define __HAVE_ARCH_MEMMOVE
 extern asmlinkage void *memmove(void *, const void *, size_t);
 extern asmlinkage void *__memmove(void *, const void *, size_t);
diff --git a/arch/riscv/kernel/riscv_ksyms.c b/arch/riscv/kernel/riscv_ksyms.c
index 5ab1c7e1a6ed..3f6d512a5b97 100644
--- a/arch/riscv/kernel/riscv_ksyms.c
+++ b/arch/riscv/kernel/riscv_ksyms.c
@@ -10,8 +10,6 @@
  * Assembly functions that may be used (directly or indirectly) by modules
  */
 EXPORT_SYMBOL(memset);
-EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(memmove);
 EXPORT_SYMBOL(__memset);
-EXPORT_SYMBOL(__memcpy);
 EXPORT_SYMBOL(__memmove);
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index 25d5c9664e57..2ffe85d4baee 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -1,9 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0-only
 lib-y			+= delay.o
-lib-y			+= memcpy.o
 lib-y			+= memset.o
 lib-y			+= memmove.o
 lib-$(CONFIG_MMU)	+= uaccess.o
 lib-$(CONFIG_64BIT)	+= tishift.o
+lib-$(CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE) += string.o
 
 obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
diff --git a/arch/riscv/lib/memcpy.S b/arch/riscv/lib/memcpy.S
deleted file mode 100644
index 51ab716253fa..000000000000
--- a/arch/riscv/lib/memcpy.S
+++ /dev/null
@@ -1,108 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2013 Regents of the University of California
- */
-
-#include <linux/linkage.h>
-#include <asm/asm.h>
-
-/* void *memcpy(void *, const void *, size_t) */
-ENTRY(__memcpy)
-WEAK(memcpy)
-	move t6, a0  /* Preserve return value */
-
-	/* Defer to byte-oriented copy for small sizes */
-	sltiu a3, a2, 128
-	bnez a3, 4f
-	/* Use word-oriented copy only if low-order bits match */
-	andi a3, t6, SZREG-1
-	andi a4, a1, SZREG-1
-	bne a3, a4, 4f
-
-	beqz a3, 2f  /* Skip if already aligned */
-	/*
-	 * Round to nearest double word-aligned address
-	 * greater than or equal to start address
-	 */
-	andi a3, a1, ~(SZREG-1)
-	addi a3, a3, SZREG
-	/* Handle initial misalignment */
-	sub a4, a3, a1
-1:
-	lb a5, 0(a1)
-	addi a1, a1, 1
-	sb a5, 0(t6)
-	addi t6, t6, 1
-	bltu a1, a3, 1b
-	sub a2, a2, a4  /* Update count */
-
-2:
-	andi a4, a2, ~((16*SZREG)-1)
-	beqz a4, 4f
-	add a3, a1, a4
-3:
-	REG_L a4,       0(a1)
-	REG_L a5,   SZREG(a1)
-	REG_L a6, 2*SZREG(a1)
-	REG_L a7, 3*SZREG(a1)
-	REG_L t0, 4*SZREG(a1)
-	REG_L t1, 5*SZREG(a1)
-	REG_L t2, 6*SZREG(a1)
-	REG_L t3, 7*SZREG(a1)
-	REG_L t4, 8*SZREG(a1)
-	REG_L t5, 9*SZREG(a1)
-	REG_S a4,       0(t6)
-	REG_S a5,   SZREG(t6)
-	REG_S a6, 2*SZREG(t6)
-	REG_S a7, 3*SZREG(t6)
-	REG_S t0, 4*SZREG(t6)
-	REG_S t1, 5*SZREG(t6)
-	REG_S t2, 6*SZREG(t6)
-	REG_S t3, 7*SZREG(t6)
-	REG_S t4, 8*SZREG(t6)
-	REG_S t5, 9*SZREG(t6)
-	REG_L a4, 10*SZREG(a1)
-	REG_L a5, 11*SZREG(a1)
-	REG_L a6, 12*SZREG(a1)
-	REG_L a7, 13*SZREG(a1)
-	REG_L t0, 14*SZREG(a1)
-	REG_L t1, 15*SZREG(a1)
-	addi a1, a1, 16*SZREG
-	REG_S a4, 10*SZREG(t6)
-	REG_S a5, 11*SZREG(t6)
-	REG_S a6, 12*SZREG(t6)
-	REG_S a7, 13*SZREG(t6)
-	REG_S t0, 14*SZREG(t6)
-	REG_S t1, 15*SZREG(t6)
-	addi t6, t6, 16*SZREG
-	bltu a1, a3, 3b
-	andi a2, a2, (16*SZREG)-1  /* Update count */
-
-4:
-	/* Handle trailing misalignment */
-	beqz a2, 6f
-	add a3, a1, a2
-
-	/* Use word-oriented copy if co-aligned to word boundary */
-	or a5, a1, t6
-	or a5, a5, a3
-	andi a5, a5, 3
-	bnez a5, 5f
-7:
-	lw a4, 0(a1)
-	addi a1, a1, 4
-	sw a4, 0(t6)
-	addi t6, t6, 4
-	bltu a1, a3, 7b
-
-	ret
-
-5:
-	lb a4, 0(a1)
-	addi a1, a1, 1
-	sb a4, 0(t6)
-	addi t6, t6, 1
-	bltu a1, a3, 5b
-6:
-	ret
-END(__memcpy)
diff --git a/arch/riscv/lib/string.c b/arch/riscv/lib/string.c
new file mode 100644
index 000000000000..bfc912ee23f8
--- /dev/null
+++ b/arch/riscv/lib/string.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * String functions optimized for hardware which doesn't
+ * handle unaligned memory accesses efficiently.
+ *
+ * Copyright (C) 2021 Matteo Croce
+ */
+
+#include <linux/types.h>
+#include <linux/module.h>
+
+/* Minimum size for a word copy to be convenient */
+#define BYTES_LONG	sizeof(long)
+#define WORD_MASK	(BYTES_LONG - 1)
+#define MIN_THRESHOLD	(BYTES_LONG * 2)
+
+/* convenience union to avoid cast between different pointer types */
+union types {
+	u8 *as_u8;
+	unsigned long *as_ulong;
+	uintptr_t as_uptr;
+};
+
+union const_types {
+	const u8 *as_u8;
+	unsigned long *as_ulong;
+	uintptr_t as_uptr;
+};
+
+void *__memcpy(void *dest, const void *src, size_t count)
+{
+	union const_types s = { .as_u8 = src };
+	union types d = { .as_u8 = dest };
+	int distance = 0;
+
+	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)) {
+		if (count < MIN_THRESHOLD)
+			goto copy_remainder;
+
+		/* Copy a byte at time until destination is aligned. */
+		for (; d.as_uptr & WORD_MASK; count--)
+			*d.as_u8++ = *s.as_u8++;
+
+		distance = s.as_uptr & WORD_MASK;
+	}
+
+	if (distance) {
+		unsigned long last, next;
+
+		/*
+		 * s is distance bytes ahead of d, and d just reached
+		 * the alignment boundary. Move s backward to word align it
+		 * and shift data to compensate for distance, in order to do
+		 * word-by-word copy.
+		 */
+		s.as_u8 -= distance;
+
+		next = s.as_ulong[0];
+		for (; count >= BYTES_LONG; count -= BYTES_LONG) {
+			last = next;
+			next = s.as_ulong[1];
+
+			d.as_ulong[0] = last >> (distance * 8) |
+					next << ((BYTES_LONG - distance) * 8);
+
+			d.as_ulong++;
+			s.as_ulong++;
+		}
+
+		/* Restore s with the original offset. */
+		s.as_u8 += distance;
+	} else {
+		/*
+		 * If the source and dest lower bits are the same, do a simple
+		 * 32/64 bit wide copy.
+		 */
+		for (; count >= BYTES_LONG; count -= BYTES_LONG)
+			*d.as_ulong++ = *s.as_ulong++;
+	}
+
+copy_remainder:
+	while (count--)
+		*d.as_u8++ = *s.as_u8++;
+
+	return dest;
+}
+EXPORT_SYMBOL(__memcpy);
+
+void *memcpy(void *dest, const void *src, size_t count) __weak __alias(__memcpy);
+EXPORT_SYMBOL(memcpy);
-- 
2.31.1

