Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B52454F9AF
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jun 2022 16:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377916AbiFQOzq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jun 2022 10:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358452AbiFQOzp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jun 2022 10:55:45 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EFA1BEA9
        for <linux-arch@vger.kernel.org>; Fri, 17 Jun 2022 07:55:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B2DD4CE2C2C
        for <linux-arch@vger.kernel.org>; Fri, 17 Jun 2022 14:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A092C3411B;
        Fri, 17 Jun 2022 14:55:37 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Add qspinlock support
Date:   Fri, 17 Jun 2022 22:57:05 +0800
Message-Id: <20220617145705.581985-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On NUMA system, the performance of qspinlock is better than generic
spinlock. Below is the UnixBench test results on a 8 nodes (4 cores
per node, 32 cores in total) machine.

A. With generic spinlock:

System Benchmarks Index Values               BASELINE       RESULT    INDEX
Dhrystone 2 using register variables         116700.0  449574022.5  38523.9
Double-Precision Whetstone                       55.0      85190.4  15489.2
Execl Throughput                                 43.0      14696.2   3417.7
File Copy 1024 bufsize 2000 maxblocks          3960.0     143157.8    361.5
File Copy 256 bufsize 500 maxblocks            1655.0      37631.8    227.4
File Copy 4096 bufsize 8000 maxblocks          5800.0     444814.2    766.9
Pipe Throughput                               12440.0    5047490.7   4057.5
Pipe-based Context Switching                   4000.0    2021545.7   5053.9
Process Creation                                126.0      23829.8   1891.3
Shell Scripts (1 concurrent)                     42.4      33756.7   7961.5
Shell Scripts (8 concurrent)                      6.0       4062.9   6771.5
System Call Overhead                          15000.0    2479748.6   1653.2
                                                                   ========
System Benchmarks Index Score                                        2955.6

B. With qspinlock:

System Benchmarks Index Values               BASELINE       RESULT    INDEX
Dhrystone 2 using register variables         116700.0  449467876.9  38514.8
Double-Precision Whetstone                       55.0      85174.6  15486.3
Execl Throughput                                 43.0      14769.1   3434.7
File Copy 1024 bufsize 2000 maxblocks          3960.0     146150.5    369.1
File Copy 256 bufsize 500 maxblocks            1655.0      37496.8    226.6
File Copy 4096 bufsize 8000 maxblocks          5800.0     447527.0    771.6
Pipe Throughput                               12440.0    5175989.2   4160.8
Pipe-based Context Switching                   4000.0    2207747.8   5519.4
Process Creation                                126.0      25125.5   1994.1
Shell Scripts (1 concurrent)                     42.4      33461.2   7891.8
Shell Scripts (8 concurrent)                      6.0       4024.7   6707.8
System Call Overhead                          15000.0    2917278.6   1944.9
                                                                   ========
System Benchmarks Index Score                                        3040.1

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/Kconfig                      |   1 +
 arch/loongarch/include/asm/Kbuild           |   5 +-
 arch/loongarch/include/asm/cmpxchg.h        |  14 +++
 arch/loongarch/include/asm/percpu.h         |   8 ++
 arch/loongarch/include/asm/spinlock.h       |  12 +++
 arch/loongarch/include/asm/spinlock_types.h |  11 ++
 arch/loongarch/kernel/Makefile              |   2 +-
 arch/loongarch/kernel/cmpxchg.c             | 105 ++++++++++++++++++++
 8 files changed, 154 insertions(+), 4 deletions(-)
 create mode 100644 arch/loongarch/include/asm/spinlock.h
 create mode 100644 arch/loongarch/include/asm/spinlock_types.h
 create mode 100644 arch/loongarch/kernel/cmpxchg.c

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 1920d52653b4..1ec220df751d 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -46,6 +46,7 @@ config LOONGARCH
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_USE_QUEUED_RWLOCKS
+	select ARCH_USE_QUEUED_SPINLOCKS
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
 	select ARCH_WANTS_NO_INSTR
 	select BUILDTIME_TABLE_SORT
diff --git a/arch/loongarch/include/asm/Kbuild b/arch/loongarch/include/asm/Kbuild
index 83bc0681e72b..a0eed6076c79 100644
--- a/arch/loongarch/include/asm/Kbuild
+++ b/arch/loongarch/include/asm/Kbuild
@@ -1,12 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
 generic-y += dma-contiguous.h
 generic-y += export.h
+generic-y += mcs_spinlock.h
 generic-y += parport.h
 generic-y += early_ioremap.h
 generic-y += qrwlock.h
-generic-y += qrwlock_types.h
-generic-y += spinlock.h
-generic-y += spinlock_types.h
+generic-y += qspinlock.h
 generic-y += rwsem.h
 generic-y += segment.h
 generic-y += user.h
diff --git a/arch/loongarch/include/asm/cmpxchg.h b/arch/loongarch/include/asm/cmpxchg.h
index 75b3a4478652..afcd05be010e 100644
--- a/arch/loongarch/include/asm/cmpxchg.h
+++ b/arch/loongarch/include/asm/cmpxchg.h
@@ -21,10 +21,17 @@
 		__ret;				\
 })
 
+extern unsigned long __xchg_small(volatile void *ptr, unsigned long x,
+				  unsigned int size);
+
 static inline unsigned long __xchg(volatile void *ptr, unsigned long x,
 				   int size)
 {
 	switch (size) {
+	case 1:
+	case 2:
+		return __xchg_small(ptr, x, size);
+
 	case 4:
 		return __xchg_asm("amswap_db.w", (volatile u32 *)ptr, (u32)x);
 
@@ -67,10 +74,17 @@ static inline unsigned long __xchg(volatile void *ptr, unsigned long x,
 	__ret;								\
 })
 
+extern unsigned long __cmpxchg_small(volatile void *ptr, unsigned long old,
+				     unsigned long new, unsigned int size);
+
 static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 				      unsigned long new, unsigned int size)
 {
 	switch (size) {
+	case 1:
+	case 2:
+		return __cmpxchg_small(ptr, old, new, size);
+
 	case 4:
 		return __cmpxchg_asm("ll.w", "sc.w", (volatile u32 *)ptr,
 				     (u32)old, new);
diff --git a/arch/loongarch/include/asm/percpu.h b/arch/loongarch/include/asm/percpu.h
index e6569f18c6dd..0bd6b0110198 100644
--- a/arch/loongarch/include/asm/percpu.h
+++ b/arch/loongarch/include/asm/percpu.h
@@ -123,6 +123,10 @@ static inline unsigned long __percpu_xchg(void *ptr, unsigned long val,
 						int size)
 {
 	switch (size) {
+	case 1:
+	case 2:
+		return __xchg_small((volatile void *)ptr, val, size);
+
 	case 4:
 		return __xchg_asm("amswap.w", (volatile u32 *)ptr, (u32)val);
 
@@ -204,9 +208,13 @@ do {									\
 #define this_cpu_write_4(pcp, val) _percpu_write(pcp, val)
 #define this_cpu_write_8(pcp, val) _percpu_write(pcp, val)
 
+#define this_cpu_xchg_1(pcp, val) _percpu_xchg(pcp, val)
+#define this_cpu_xchg_2(pcp, val) _percpu_xchg(pcp, val)
 #define this_cpu_xchg_4(pcp, val) _percpu_xchg(pcp, val)
 #define this_cpu_xchg_8(pcp, val) _percpu_xchg(pcp, val)
 
+#define this_cpu_cmpxchg_1(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
+#define this_cpu_cmpxchg_2(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
 #define this_cpu_cmpxchg_4(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
 #define this_cpu_cmpxchg_8(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
 
diff --git a/arch/loongarch/include/asm/spinlock.h b/arch/loongarch/include/asm/spinlock.h
new file mode 100644
index 000000000000..7cb3476999be
--- /dev/null
+++ b/arch/loongarch/include/asm/spinlock.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_SPINLOCK_H
+#define _ASM_SPINLOCK_H
+
+#include <asm/processor.h>
+#include <asm/qspinlock.h>
+#include <asm/qrwlock.h>
+
+#endif /* _ASM_SPINLOCK_H */
diff --git a/arch/loongarch/include/asm/spinlock_types.h b/arch/loongarch/include/asm/spinlock_types.h
new file mode 100644
index 000000000000..7458d036c161
--- /dev/null
+++ b/arch/loongarch/include/asm/spinlock_types.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_SPINLOCK_TYPES_H
+#define _ASM_SPINLOCK_TYPES_H
+
+#include <asm-generic/qspinlock_types.h>
+#include <asm-generic/qrwlock_types.h>
+
+#endif
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index 940de9173542..07930921f7b5 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -5,7 +5,7 @@
 
 extra-y		:= head.o vmlinux.lds
 
-obj-y		+= cpu-probe.o cacheinfo.o env.o setup.o entry.o genex.o \
+obj-y		+= cpu-probe.o cacheinfo.o cmpxchg.o env.o setup.o entry.o genex.o \
 		   traps.o irq.o idle.o process.o dma.o mem.o io.o reset.o switch.o \
 		   elf.o syscall.o signal.o time.o topology.o inst.o ptrace.o vdso.o
 
diff --git a/arch/loongarch/kernel/cmpxchg.c b/arch/loongarch/kernel/cmpxchg.c
new file mode 100644
index 000000000000..4c83471c4e47
--- /dev/null
+++ b/arch/loongarch/kernel/cmpxchg.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author: Huacai Chen <chenhuacai@loongson.cn>
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ *
+ * Derived from MIPS:
+ * Copyright (C) 2017 Imagination Technologies
+ * Author: Paul Burton <paul.burton@mips.com>
+ */
+
+#include <linux/bug.h>
+#include <asm/barrier.h>
+#include <asm/cmpxchg.h>
+
+unsigned long __xchg_small(volatile void *ptr, unsigned long val, unsigned int size)
+{
+	u32 old32, mask, temp;
+	volatile u32 *ptr32;
+	unsigned int shift;
+
+	/* Check that ptr is naturally aligned */
+	WARN_ON((unsigned long)ptr & (size - 1));
+
+	/* Mask value to the correct size. */
+	mask = GENMASK((size * BITS_PER_BYTE) - 1, 0);
+	val &= mask;
+
+	/*
+	 * Calculate a shift & mask that correspond to the value we wish to
+	 * exchange within the naturally aligned 4 byte integerthat includes
+	 * it.
+	 */
+	shift = (unsigned long)ptr & 0x3;
+	shift *= BITS_PER_BYTE;
+	mask <<= shift;
+
+	/*
+	 * Calculate a pointer to the naturally aligned 4 byte integer that
+	 * includes our byte of interest, and load its value.
+	 */
+	ptr32 = (volatile u32 *)((unsigned long)ptr & ~0x3);
+
+	asm volatile (
+	"1:	ll.w		%0, %3		\n"
+	"	andn		%1, %0, %4	\n"
+	"	or		%1, %1, %5	\n"
+	"	sc.w		%1, %2		\n"
+	"	beqz		%1, 1b		\n"
+	: "=&r" (old32), "=&r" (temp), "=" GCC_OFF_SMALL_ASM() (*ptr32)
+	: GCC_OFF_SMALL_ASM() (*ptr32), "Jr" (mask), "Jr" (val << shift)
+	: "memory");
+
+	return (old32 & mask) >> shift;
+}
+
+unsigned long __cmpxchg_small(volatile void *ptr, unsigned long old,
+			      unsigned long new, unsigned int size)
+{
+	u32 old32, mask, temp;
+	volatile u32 *ptr32;
+	unsigned int shift;
+
+	/* Check that ptr is naturally aligned */
+	WARN_ON((unsigned long)ptr & (size - 1));
+
+	/* Mask inputs to the correct size. */
+	mask = GENMASK((size * BITS_PER_BYTE) - 1, 0);
+	old &= mask;
+	new &= mask;
+
+	/*
+	 * Calculate a shift & mask that correspond to the value we wish to
+	 * compare & exchange within the naturally aligned 4 byte integer
+	 * that includes it.
+	 */
+	shift = (unsigned long)ptr & 0x3;
+	shift *= BITS_PER_BYTE;
+	old <<= shift;
+	new <<= shift;
+	mask <<= shift;
+
+	/*
+	 * Calculate a pointer to the naturally aligned 4 byte integer that
+	 * includes our byte of interest, and load its value.
+	 */
+	ptr32 = (volatile u32 *)((unsigned long)ptr & ~0x3);
+
+	asm volatile (
+	"1:	ll.w		%0, %3		\n"
+	"	and		%1, %0, %4	\n"
+	"	bne		%1, %5, 2f	\n"
+	"	andn		%1, %0, %4	\n"
+	"	or		%1, %1, %6	\n"
+	"	sc.w		%1, %2		\n"
+	"	beqz		%1, 1b		\n"
+	"	b		3f		\n"
+	"2:					\n"
+	__WEAK_LLSC_MB
+	"3:					\n"
+	: "=&r" (old32), "=&r" (temp), "=" GCC_OFF_SMALL_ASM() (*ptr32)
+	: GCC_OFF_SMALL_ASM() (*ptr32), "Jr" (mask), "Jr" (old), "Jr" (new)
+	: "memory");
+
+	return (old32 & mask) >> shift;
+}
-- 
2.27.0

