Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FFC5521A2
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jun 2022 17:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239827AbiFTPyX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jun 2022 11:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiFTPyV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jun 2022 11:54:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F531D31E;
        Mon, 20 Jun 2022 08:54:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 782936148E;
        Mon, 20 Jun 2022 15:54:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C44C3411B;
        Mon, 20 Jun 2022 15:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655740458;
        bh=KtWEptVGxksrRg8rkZA74nxyhIwgcnJ5Ar0DUkK8+cU=;
        h=From:To:Cc:Subject:Date:From;
        b=qx2jdZwEvDyPwpqdHbgZT83fAScKchJVA1I0Tqdy1L7kg4seMsOcQbc5gu3CtaoRP
         cMGNxS38aQ28PMoBkV9A0OB6mXBKLBk78S04Kv1mZUCyHfTrCk6IGW4shlVH4uqt0S
         2QjSTdWJY0zULwQet5tKN6yxmQI2qtoGTpJQkF0ObHdMoex4VbkrOFk6Ys4nZxqu7j
         LHVFDxBG5qHZ/e6sVmX5vMdgvvJlVdWgphrDHAdJJ87e84knmIIau/yhYn2VPSP5O+
         ySoD0xfMosUjdKibAzrz8LeUSc42wVpP8thvbrr6IOPpELL0DhpZ3113Apgqx+YI9j
         AtvkTFucEMT/g==
From:   guoren@kernel.org
To:     palmer@rivosinc.com, arnd@arndb.de, peterz@infradead.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH V5] riscv: Add qspinlock support
Date:   Mon, 20 Jun 2022 11:54:04 -0400
Message-Id: <20220620155404.1968739-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Enable qspinlock and meet the requirements mentioned in a8ad07e5240c9
("asm-generic: qspinlock: Indicate the use of mixed-size atomics").

 - RISC-V atomic_*_release()/atomic_*_acquire() are implemented with
   own relaxed version plus acquire/release_fence for RCsc
   synchronization.

 - RISC-V LR/SC pairs could provide a strong/weak forward guarantee
   that depends on micro-architecture. And RISC-V ISA spec has given
   out several limitations to let hardware support strict forward
   guarantee (RISC-V User ISA - 8.3 Eventual Success of
   Store-Conditional Instructions). Some riscv cores such as BOOMv3
   & XiangShan could provide strict & strong forward guarantee (The
   cache line would be kept in an exclusive state for Backoff cycles,
   and only this core's interrupt could break the LR/SC pair).

 - RISC-V could provide cheap atomic_fetch_or_acquire() with RCsc.

 - RISC-V only provides relaxed xhg16 to support qspinlock.

The first version of patch was made in 2019.1 [1]. The second version
was made in 2020.11 [2].

[1] https://lore.kernel.org/linux-riscv/20190211043829.30096-1-michaeljclark@mac.com/#r
[2] https://lore.kernel.org/linux-riscv/1606225437-22948-2-git-send-email-guoren@kernel.org/

Change V5:
 - Update comment with RISC-V forward guarantee feature.
 - Back to V3 direction and optimize asm code.

Change V4:
 - Remove custom sub-word xchg implementation
 - Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32 in locking/qspinlock

Change V3:
 - Coding convention by Peter Zijlstra's advices

Change V2:
 - Coding convention in cmpxchg.h
 - Re-implement short xchg
 - Remove char & cmpxchg implementations

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/Kconfig                      |  9 +++++++++
 arch/riscv/include/asm/Kbuild           |  4 ++--
 arch/riscv/include/asm/cmpxchg.h        | 16 ++++++++++++++++
 arch/riscv/include/asm/spinlock.h       | 12 ++++++++++++
 arch/riscv/include/asm/spinlock_types.h | 12 ++++++++++++
 5 files changed, 51 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/include/asm/spinlock.h
 create mode 100644 arch/riscv/include/asm/spinlock_types.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 32ffef9f6e5b..3b0b117b4e95 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -333,6 +333,15 @@ config NODES_SHIFT
 	  Specify the maximum number of NUMA Nodes available on the target
 	  system.  Increases memory reserved to accommodate various tables.
 
+config RISCV_USE_QUEUED_SPINLOCKS
+	bool "Using queued spinlock instead of ticket-lock"
+	depends on SMP && MMU
+	select ARCH_USE_QUEUED_SPINLOCKS
+	default y if NUMA
+	help
+	  Make sure your micro arch LL/SC has a strong forward progress guarantee.
+	  Otherwise, stay at ticket-lock.
+
 config RISCV_ALTERNATIVE
 	bool
 	depends on !XIP_KERNEL
diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index 504f8b7e72d4..e066ccab6417 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -2,10 +2,10 @@
 generic-y += early_ioremap.h
 generic-y += flat.h
 generic-y += kvm_para.h
+generic-y += mcs_spinlock.h
 generic-y += parport.h
-generic-y += spinlock.h
-generic-y += spinlock_types.h
 generic-y += qrwlock.h
 generic-y += qrwlock_types.h
+generic-y += qspinlock.h
 generic-y += user.h
 generic-y += vmlinux.lds.h
diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 12debce235e5..f7f8e359d3ac 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -17,6 +17,22 @@
 	__typeof__(new) __new = (new);					\
 	__typeof__(*(ptr)) __ret;					\
 	switch (size) {							\
+	case 2:								\
+		u32 temp;						\
+		u32 shif = ((ulong)__ptr & 2) ? 16 : 0;			\
+		u32 mask = 0xffff << shif;				\
+		__ptr = (__typeof__(ptr))((ulong)__ptr & ~(ulong)2);	\
+		__asm__ __volatile__ (					\
+			"0:	lr.w %0, %2\n"				\
+			"	and  %1, %0, %z3\n"			\
+			"	or   %1, %1, %z4\n"			\
+			"	sc.w %1, %1, %2\n"			\
+			"	bnez %1, 0b\n"				\
+			: "=&r" (__ret), "=&r" (temp), "+A" (*__ptr)	\
+			: "rJ" (~mask), "rJ" (__new << shif)		\
+			: "memory");					\
+		__ret = (__ret & mask) >> shif;				\
+		break;							\
 	case 4:								\
 		__asm__ __volatile__ (					\
 			"	amoswap.w %0, %2, %1\n"			\
diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
new file mode 100644
index 000000000000..fd3fd09cff52
--- /dev/null
+++ b/arch/riscv/include/asm/spinlock.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_SPINLOCK_H
+#define __ASM_SPINLOCK_H
+
+#ifdef CONFIG_ARCH_USE_QUEUED_SPINLOCKS
+#include <asm/qspinlock.h>
+#include <asm/qrwlock.h>
+#else
+#include <asm-generic/spinlock.h>
+#endif
+
+#endif /* __ASM_SPINLOCK_H */
diff --git a/arch/riscv/include/asm/spinlock_types.h b/arch/riscv/include/asm/spinlock_types.h
new file mode 100644
index 000000000000..9281237b5f4e
--- /dev/null
+++ b/arch/riscv/include/asm/spinlock_types.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_SPINLOCK_TYPES_H
+#define __ASM_SPINLOCK_TYPES_H
+
+#ifdef CONFIG_ARCH_USE_QUEUED_SPINLOCKS
+#include <asm-generic/qspinlock_types.h>
+#include <asm-generic/qrwlock_types.h>
+#else
+#include <asm-generic/spinlock_types.h>
+#endif
+
+#endif /* __ASM_SPINLOCK_TYPES_H */
-- 
2.36.1

