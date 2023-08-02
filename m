Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A181876D415
	for <lists+linux-arch@lfdr.de>; Wed,  2 Aug 2023 18:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjHBQtY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 12:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjHBQtF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 12:49:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C912D78;
        Wed,  2 Aug 2023 09:48:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A51C61A3C;
        Wed,  2 Aug 2023 16:48:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D8BC433CA;
        Wed,  2 Aug 2023 16:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690994925;
        bh=XpJMmQpizgl+1q4faLgZyV4Sr5SWoDQzo87jc2k0hEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rgxujrsdn7f+bcZFJbQ7fNjqz5y2CrBgF0JiPl0DEbMPu20EiePiHkH95Lmot58DW
         LviM3KysginZdajdwkNuvDoxVNN9RrLMOjPSuZ2jRVFlm0Qny2n4KMliWznJBLtDdM
         PysXqLOrB6cwwXJ7jKWDbYVbH0jnEiJgiskSOUOEj3Oeoj/ZstrC+OQYehdAcghRJK
         G7L0DezO+mrmdTlz+SbrU0xEuUAXSYjh3wFuhnVhocrtahkE+ip2vFt+KKjTcY8dze
         FrXIL/40ohIWf2ObIM0DmN2LJ5i1atvvrNMdz0WAJ+g3S86+2/6kXwSMt708WfOkjC
         iMkIyJYOTzcAA==
From:   guoren@kernel.org
To:     paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, paulmck@kernel.org, rostedt@goodmis.org,
        rdunlap@infradead.org, catalin.marinas@arm.com,
        conor.dooley@microchip.com, xiaoguang.xing@sophgo.com,
        bjorn@rivosinc.com, alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn
Cc:     linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH V10 04/19] riscv: qspinlock: Add basic queued_spinlock support
Date:   Wed,  2 Aug 2023 12:46:46 -0400
Message-Id: <20230802164701.192791-5-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230802164701.192791-1-guoren@kernel.org>
References: <20230802164701.192791-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The requirements of qspinlock have been documented by commit:
a8ad07e5240c ("asm-generic: qspinlock: Indicate the use of mixed-size
atomics").

Although RISC-V ISA gives out a weaker forward guarantee LR/SC, which
doesn't satisfy the requirements of qspinlock above, it won't prevent
some riscv vendors from implementing a strong fwd guarantee LR/SC in
microarchitecture to match xchg_tail requirement. T-HEAD C9xx processor
is the one.

We've tested the patch on SOPHGO sg2042 & th1520 and passed the stress
test on Fedora & Ubuntu & OpenEuler ... Here is the performance
comparison between qspinlock and ticket_lock on sg2042 (64 cores):

sysbench test=threads threads=32 yields=100 lock=8 (+13.8%):
  queued_spinlock 0.5109/0.00
  ticket_spinlock 0.5814/0.00

perf futex/hash (+6.7%):
  queued_spinlock 1444393 operations/sec (+- 0.09%)
  ticket_spinlock 1353215 operations/sec (+- 0.15%)

perf futex/wake-parallel (+8.6%):
  queued_spinlock (waking 1/64 threads) in 0.0253 ms (+-2.90%)
  ticket_spinlock (waking 1/64 threads) in 0.0275 ms (+-3.12%)

perf futex/requeue (+4.2%):
  queued_spinlock Requeued 64 of 64 threads in 0.0785 ms (+-0.55%)
  ticket_spinlock Requeued 64 of 64 threads in 0.0818 ms (+-4.12%)

System Benchmarks (+6.4%)
  queued_spinlock:
    System Benchmarks Index Values               BASELINE       RESULT    INDEX
    Dhrystone 2 using register variables         116700.0  628613745.4  53865.8
    Double-Precision Whetstone                       55.0     182422.8  33167.8
    Execl Throughput                                 43.0      13116.6   3050.4
    File Copy 1024 bufsize 2000 maxblocks          3960.0    7762306.2  19601.8
    File Copy 256 bufsize 500 maxblocks            1655.0    3417556.8  20649.9
    File Copy 4096 bufsize 8000 maxblocks          5800.0    7427995.7  12806.9
    Pipe Throughput                               12440.0   23058600.5  18535.9
    Pipe-based Context Switching                   4000.0    2835617.7   7089.0
    Process Creation                                126.0      12537.3    995.0
    Shell Scripts (1 concurrent)                     42.4      57057.4  13456.9
    Shell Scripts (8 concurrent)                      6.0       7367.1  12278.5
    System Call Overhead                          15000.0   33308301.3  22205.5
                                                                       ========
    System Benchmarks Index Score                                       12426.1

  ticket_spinlock:
    System Benchmarks Index Values               BASELINE       RESULT    INDEX
    Dhrystone 2 using register variables         116700.0  626541701.9  53688.2
    Double-Precision Whetstone                       55.0     181921.0  33076.5
    Execl Throughput                                 43.0      12625.1   2936.1
    File Copy 1024 bufsize 2000 maxblocks          3960.0    6553792.9  16550.0
    File Copy 256 bufsize 500 maxblocks            1655.0    3189231.6  19270.3
    File Copy 4096 bufsize 8000 maxblocks          5800.0    7221277.0  12450.5
    Pipe Throughput                               12440.0   20594018.7  16554.7
    Pipe-based Context Switching                   4000.0    2571117.7   6427.8
    Process Creation                                126.0      10798.4    857.0
    Shell Scripts (1 concurrent)                     42.4      57227.5  13497.1
    Shell Scripts (8 concurrent)                      6.0       7329.2  12215.3
    System Call Overhead                          15000.0   30766778.4  20511.2
                                                                       ========
    System Benchmarks Index Score                                       11670.7

The qspinlock has a significant improvement on SOPHGO SG2042 64
cores platform than the ticket_lock.

Signed-off-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/riscv/Kconfig                | 16 ++++++++++++++++
 arch/riscv/include/asm/Kbuild     |  3 ++-
 arch/riscv/include/asm/cmpxchg.h  | 24 ++++++++++++++++++++++++
 arch/riscv/include/asm/spinlock.h | 17 +++++++++++++++++
 4 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/include/asm/spinlock.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 93ff677d2be5..e89a3bea3dc1 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -438,6 +438,22 @@ config NODES_SHIFT
 	  Specify the maximum number of NUMA Nodes available on the target
 	  system.  Increases memory reserved to accommodate various tables.
 
+choice
+	prompt "RISC-V spinlock type"
+	default RISCV_TICKET_SPINLOCKS
+
+config RISCV_TICKET_SPINLOCKS
+	bool "Using ticket spinlock"
+
+config RISCV_QUEUED_SPINLOCKS
+	bool "Using queued spinlock"
+	depends on SMP && MMU
+	select ARCH_USE_QUEUED_SPINLOCKS
+	help
+	  Make sure your micro arch LL/SC has a strong forward progress guarantee.
+	  Otherwise, stay at ticket-lock.
+endchoice
+
 config RISCV_ALTERNATIVE
 	bool
 	depends on !XIP_KERNEL
diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index 504f8b7e72d4..a0dc85e4a754 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -2,10 +2,11 @@
 generic-y += early_ioremap.h
 generic-y += flat.h
 generic-y += kvm_para.h
+generic-y += mcs_spinlock.h
 generic-y += parport.h
-generic-y += spinlock.h
 generic-y += spinlock_types.h
 generic-y += qrwlock.h
 generic-y += qrwlock_types.h
+generic-y += qspinlock.h
 generic-y += user.h
 generic-y += vmlinux.lds.h
diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 2f4726d3cfcc..d12231d752a4 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -11,12 +11,36 @@
 #include <asm/barrier.h>
 #include <asm/fence.h>
 
+static inline ulong __xchg16_relaxed(ulong new, void *ptr)
+{
+	ulong ret, tmp;
+	ulong shif = ((ulong)ptr & 2) ? 16 : 0;
+	ulong mask = 0xffff << shif;
+	ulong *__ptr = (ulong *)((ulong)ptr & ~2);
+
+	__asm__ __volatile__ (
+		"0:	lr.w %0, %2\n"
+		"	and  %1, %0, %z3\n"
+		"	or   %1, %1, %z4\n"
+		"	sc.w %1, %1, %2\n"
+		"	bnez %1, 0b\n"
+		: "=&r" (ret), "=&r" (tmp), "+A" (*__ptr)
+		: "rJ" (~mask), "rJ" (new << shif)
+		: "memory");
+
+	return (ulong)((ret & mask) >> shif);
+}
+
 #define __xchg_relaxed(ptr, new, size)					\
 ({									\
 	__typeof__(ptr) __ptr = (ptr);					\
 	__typeof__(new) __new = (new);					\
 	__typeof__(*(ptr)) __ret;					\
 	switch (size) {							\
+	case 2:								\
+		__ret = (__typeof__(*(ptr)))				\
+			__xchg16_relaxed((ulong)__new, __ptr);		\
+		break;							\
 	case 4:								\
 		__asm__ __volatile__ (					\
 			"	amoswap.w %0, %2, %1\n"			\
diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
new file mode 100644
index 000000000000..c644a92d4548
--- /dev/null
+++ b/arch/riscv/include/asm/spinlock.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_RISCV_SPINLOCK_H
+#define __ASM_RISCV_SPINLOCK_H
+
+#ifdef CONFIG_QUEUED_SPINLOCKS
+#define _Q_PENDING_LOOPS	(1 << 9)
+#endif
+
+#ifdef CONFIG_QUEUED_SPINLOCKS
+#include <asm/qspinlock.h>
+#include <asm/qrwlock.h>
+#else
+#include <asm-generic/spinlock.h>
+#endif
+
+#endif /* __ASM_RISCV_SPINLOCK_H */
-- 
2.36.1

