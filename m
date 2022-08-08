Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D166F58C3CF
	for <lists+linux-arch@lfdr.de>; Mon,  8 Aug 2022 09:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235689AbiHHHPv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Aug 2022 03:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237603AbiHHHOz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Aug 2022 03:14:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8FF9FC5;
        Mon,  8 Aug 2022 00:14:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84398B80DCF;
        Mon,  8 Aug 2022 07:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44801C433D7;
        Mon,  8 Aug 2022 07:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659942881;
        bh=5VBNACFhtl+dfvQZEMTzFThf7ylgX+7g/Yydm6EJovs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CtrfPxx/xVpdB9R30rfocfphFAEMUx3nf+KX3iZblbbX5nMZgnf3kBX9q/T8x3+Du
         7iSWsHWQCRLLSy5lzm41xxYNUAKpeHhGgnSKMyf2ktQ36tR98vW8EODRofQt7+ixkB
         XtS5zw4A/y1B/Iac3AG9JoTgyww0b+BoRxWhYEMbmKTZLUSw2cqYgK/sQ2z/VBK4Og
         ov2XnFQWLvq86LR8ySmjFTzWyqJ4davEhT3pTtMoyXdb+muPsw/yi9CXumjf1/Jo4i
         nECo2Gl1ZBlS5XwPCS5AGjQVQarW+bQrWstZiMiGTKQTqKuNgM3ahOF1BHvcSYZc5O
         LukfVJ+avrWIg==
From:   guoren@kernel.org
To:     palmer@rivosinc.com, heiko@sntech.de, hch@infradead.org,
        arnd@arndb.de, peterz@infradead.org, will@kernel.org,
        boqun.feng@gmail.com, longman@redhat.com, shorne@gmail.com,
        conor.dooley@microchip.com
Cc:     linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>, Guo Ren <guoren@kernel.org>
Subject: [PATCH V9 11/15] riscv: Add qspinlock support
Date:   Mon,  8 Aug 2022 03:13:14 -0400
Message-Id: <20220808071318.3335746-12-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220808071318.3335746-1-guoren@kernel.org>
References: <20220808071318.3335746-1-guoren@kernel.org>
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

Enable qspinlock by the requirements mentioned in a8ad07e5240c9
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

 - RISC-V provides cheap atomic_fetch_or_acquire() with RCsc.

 - RISC-V only provides relaxed xchg16 to support qspinlock.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/Kconfig               | 16 ++++++++++++++++
 arch/riscv/include/asm/Kbuild    |  2 ++
 arch/riscv/include/asm/cmpxchg.h | 24 ++++++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c3ca23bc6352..8b36a4307d03 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -359,6 +359,22 @@ config NODES_SHIFT
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
index 504f8b7e72d4..2cce98c7b653 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -2,7 +2,9 @@
 generic-y += early_ioremap.h
 generic-y += flat.h
 generic-y += kvm_para.h
+generic-y += mcs_spinlock.h
 generic-y += parport.h
+generic-y += qspinlock.h
 generic-y += spinlock.h
 generic-y += spinlock_types.h
 generic-y += qrwlock.h
diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 4b5fa25f4336..2ba88057db52 100644
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
+	case 2:	{							\
+		__ret = (__typeof__(*(ptr)))				\
+			__xchg16_relaxed((ulong)__new, __ptr);		\
+		break;}							\
 	case 4:								\
 		__asm__ __volatile__ (					\
 			"	amoswap.w %0, %2, %1\n"			\
-- 
2.36.1

