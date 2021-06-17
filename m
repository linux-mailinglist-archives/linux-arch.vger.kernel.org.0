Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E733AB77D
	for <lists+linux-arch@lfdr.de>; Thu, 17 Jun 2021 17:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbhFQPai (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Jun 2021 11:30:38 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:37644 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbhFQPaa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Jun 2021 11:30:30 -0400
Received: by mail-ed1-f50.google.com with SMTP id b11so4595349edy.4;
        Thu, 17 Jun 2021 08:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z1SvxJzqSSG7CG3GDXyo/O1nVcLPyYkQp599omwkMT0=;
        b=rz2PT7l6hTEU8CdzUUekUOT3MXpAbbvEruk7TGpCCEZR1DGFkazdWaxzuSP0NGwJhr
         5rZIUMYRaY+Wxe074//my+3TRFE7byHTgnAS8BK+Z8Y2a80TVRJgeoN7Pht173RllpjW
         emzytJ77lSkwh7lcmcmOtfyjRaOJcQqPS6EeA/fylTOzkYmxEfwkXs+mCl60IfroNyZ4
         KDp8udt3PCWQn+aomUEPBburGBeKtocga3SkzUsxhroalO9lgn5tGC+q8z0vTgGG/4qm
         Z6jkPZBIbhsCKWpyY4VK8Dtc/LEVgsf3iohXJNioOdt2zVUKlhabVLvTBh3kcKk15rOB
         BaEg==
X-Gm-Message-State: AOAM531kCbRi96hA2NDdmzvVq6CRIo9xgDl8+HDNPA0knJz8ljBSvRWA
        TD26DjU/AQ8xTv3B7oxL61I=
X-Google-Smtp-Source: ABdhPJweOSYw6QSP33P6i4xCQEX4WXMRIhhh879fzphabZdi3BAle3SioW2cqRu/G0xlkTQysMFGkA==
X-Received: by 2002:a05:6402:3513:: with SMTP id b19mr7248173edd.148.1623943701415;
        Thu, 17 Jun 2021 08:28:21 -0700 (PDT)
Received: from msft-t490s.teknoraver.net (net-37-119-128-179.cust.vodafonedsl.it. [37.119.128.179])
        by smtp.gmail.com with ESMTPSA id g11sm4497850edz.12.2021.06.17.08.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 08:28:20 -0700 (PDT)
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
Subject: [PATCH v3 1/3] riscv: optimized memcpy
Date:   Thu, 17 Jun 2021 17:27:52 +0200
Message-Id: <20210617152754.17960-2-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210617152754.17960-1-mcroce@linux.microsoft.com>
References: <20210617152754.17960-1-mcroce@linux.microsoft.com>
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
---
 arch/riscv/include/asm/string.h |   8 ++-
 arch/riscv/kernel/riscv_ksyms.c |   2 -
 arch/riscv/lib/Makefile         |   2 +-
 arch/riscv/lib/memcpy.S         | 108 --------------------------------
 arch/riscv/lib/string.c         |  91 +++++++++++++++++++++++++++
 5 files changed, 98 insertions(+), 113 deletions(-)
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
index 000000000000..e48a79a045d8
--- /dev/null
+++ b/arch/riscv/lib/string.c
@@ -0,0 +1,91 @@
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
+#define MIN_THRESHOLD (BITS_PER_LONG / 8 * 2)
+
+/* convenience union to avoid cast between different pointer types */
+union types {
+	u8 *u8;
+	unsigned long *ulong;
+	uintptr_t uptr;
+};
+
+union const_types {
+	const u8 *u8;
+	unsigned long *ulong;
+};
+
+void *__memcpy(void *dest, const void *src, size_t count)
+{
+	const int bytes_long = BITS_PER_LONG / 8;
+#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+	const int mask = bytes_long - 1;
+	const int distance = (src - dest) & mask;
+#endif
+	union const_types s = { .u8 = src };
+	union types d = { .u8 = dest };
+
+#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+	if (count < MIN_THRESHOLD)
+		goto copy_remainder;
+
+	/* copy a byte at time until destination is aligned */
+	for (; count && d.uptr & mask; count--)
+		*d.u8++ = *s.u8++;
+
+	if (distance) {
+		unsigned long last, next;
+
+		/* move s backward to the previous alignment boundary */
+		s.u8 -= distance;
+
+		/* 32/64 bit wide copy from s to d.
+		 * d is aligned now but s is not, so read s alignment wise,
+		 * and do proper shift to get the right value.
+		 * Works only on Little Endian machines.
+		 */
+		for (next = s.ulong[0]; count >= bytes_long + mask; count -= bytes_long) {
+			last = next;
+			next = s.ulong[1];
+
+			d.ulong[0] = last >> (distance * 8) |
+				     next << ((bytes_long - distance) * 8);
+
+			d.ulong++;
+			s.ulong++;
+		}
+
+		/* restore s with the original offset */
+		s.u8 += distance;
+	} else
+#endif
+	{
+		/* if the source and dest lower bits are the same, do a simple
+		 * 32/64 bit wide copy.
+		 */
+		for (; count >= bytes_long; count -= bytes_long)
+			*d.ulong++ = *s.ulong++;
+	}
+
+	/* suppress warning when CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y */
+	goto copy_remainder;
+
+copy_remainder:
+	while (count--)
+		*d.u8++ = *s.u8++;
+
+	return dest;
+}
+EXPORT_SYMBOL(__memcpy);
+
+void *memcpy(void *dest, const void *src, size_t count) __weak __alias(__memcpy);
+EXPORT_SYMBOL(memcpy);
-- 
2.31.1

