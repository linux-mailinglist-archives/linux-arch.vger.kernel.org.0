Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD54B585E53
	for <lists+linux-arch@lfdr.de>; Sun, 31 Jul 2022 11:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbiGaJr7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 31 Jul 2022 05:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbiGaJr7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 31 Jul 2022 05:47:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FB111463;
        Sun, 31 Jul 2022 02:47:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46A5A60AC6;
        Sun, 31 Jul 2022 09:47:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62053C433C1;
        Sun, 31 Jul 2022 09:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659260875;
        bh=PXuhXAtEtlz/ee7wW/TouzcLsC3AOmyHAuLf8/PbQs0=;
        h=From:To:Cc:Subject:Date:From;
        b=NNzwY3e/fPX7A12FHKv9hlLY3FyPPbHFopiHQ21QGhaVE6g+qkiNb4cdrvtzYi3TO
         4hQGmeoVJTtL2JE86RSTyUVvMTb9QW1OAV1BVGhftstFNG1I2H/91c3fiULkYq4LSh
         DGWbuH0dqXNh3CjTLXNAkdwtfpHKo9zRajApkLkh3Sdw+f3CQGpXlRvbHgGnXAr2/I
         VfDDaMw0MGjDC9VFSkXg2g3I/CpMBfr5QjT95qksslMUZuCzRBt4O9LNhk6uyiTCp8
         Q/w2s/qGxPhWlFGvyvfxwSDoU5zda6mu7O6nxt7D70NbhXan+sn54mxOGI7ryesPtJ
         dxB1v+Wa8zY3A==
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, mark.rutland@arm.com
Cc:     linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH] csky: Add qspinlock support
Date:   Sun, 31 Jul 2022 05:47:41 -0400
Message-Id: <20220731094741.3770926-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Enable qspinlock by the requirements mentioned in a8ad07e5240c9
("asm-generic: qspinlock: Indicate the use of mixed-size atomics").

C-SKY only has "ldex/stex" for all atomic operations. So csky give a
strong forward guarantee for "ldex/stex." That means when ldex grabbed
the cache line into $L1, it would block other cores from snooping the
address with several cycles. The atomic_fetch_add & xchg16 has the same
forward guarantee level in C-SKY.

Qspinlock has better code size and performance in a fast path.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/csky/Kconfig                      |  1 +
 arch/csky/include/asm/Kbuild           |  4 ++--
 arch/csky/include/asm/cmpxchg.h        | 20 ++++++++++++++++++++
 arch/csky/include/asm/spinlock.h       | 12 ++++++++++++
 arch/csky/include/asm/spinlock_types.h |  9 +++++++++
 5 files changed, 44 insertions(+), 2 deletions(-)
 create mode 100644 arch/csky/include/asm/spinlock.h
 create mode 100644 arch/csky/include/asm/spinlock_types.h

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 41d7d614f7a2..333def12faef 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -8,6 +8,7 @@ config CSKY
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_QUEUED_RWLOCKS
+	select ARCH_USE_QUEUED_SPINLOCKS
 	select ARCH_WANT_FRAME_POINTERS if !CPU_CK610 && $(cc-option,-mbacktrace)
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
 	select COMMON_CLK
diff --git a/arch/csky/include/asm/Kbuild b/arch/csky/include/asm/Kbuild
index 103207a58f97..1117c28cb7e8 100644
--- a/arch/csky/include/asm/Kbuild
+++ b/arch/csky/include/asm/Kbuild
@@ -3,10 +3,10 @@ generic-y += asm-offsets.h
 generic-y += extable.h
 generic-y += gpio.h
 generic-y += kvm_para.h
-generic-y += spinlock.h
-generic-y += spinlock_types.h
+generic-y += mcs_spinlock.h
 generic-y += qrwlock.h
 generic-y += qrwlock_types.h
+generic-y += qspinlock.h
 generic-y += parport.h
 generic-y += user.h
 generic-y += vmlinux.lds.h
diff --git a/arch/csky/include/asm/cmpxchg.h b/arch/csky/include/asm/cmpxchg.h
index 5b8faccd65e4..5f693fadb56c 100644
--- a/arch/csky/include/asm/cmpxchg.h
+++ b/arch/csky/include/asm/cmpxchg.h
@@ -15,6 +15,26 @@ extern void __bad_xchg(void);
 	__typeof__(*(ptr)) __ret;				\
 	unsigned long tmp;					\
 	switch (size) {						\
+	case 2: {						\
+		u32 ret;					\
+		u32 shif = ((ulong)__ptr & 2) ? 16 : 0;		\
+		u32 mask = 0xffff << shif;			\
+		__ptr = (__typeof__(ptr))((ulong)__ptr & ~2);	\
+		__asm__ __volatile__ (				\
+			"1:	ldex.w %0, (%4)\n"		\
+			"	and    %1, %0, %2\n"		\
+			"	or     %1, %1, %3\n"		\
+			"	stex.w %1, (%4)\n"		\
+			"	bez    %1, 1b\n"		\
+			: "=&r" (ret), "=&r" (tmp)		\
+			: "r" (~mask),				\
+			  "r" ((u32)__new << shif),		\
+			  "r" (__ptr)				\
+			: "memory");				\
+		__ret = (__typeof__(*(ptr)))			\
+			((ret & mask) >> shif);			\
+		break;						\
+	}							\
 	case 4:							\
 		asm volatile (					\
 		"1:	ldex.w		%0, (%3) \n"		\
diff --git a/arch/csky/include/asm/spinlock.h b/arch/csky/include/asm/spinlock.h
new file mode 100644
index 000000000000..83a2005341f5
--- /dev/null
+++ b/arch/csky/include/asm/spinlock.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_CSKY_SPINLOCK_H
+#define __ASM_CSKY_SPINLOCK_H
+
+#include <asm/qspinlock.h>
+#include <asm/qrwlock.h>
+
+/* See include/linux/spinlock.h */
+#define smp_mb__after_spinlock()	smp_mb()
+
+#endif /* __ASM_CSKY_SPINLOCK_H */
diff --git a/arch/csky/include/asm/spinlock_types.h b/arch/csky/include/asm/spinlock_types.h
new file mode 100644
index 000000000000..75bdf3af80ba
--- /dev/null
+++ b/arch/csky/include/asm/spinlock_types.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_CSKY_SPINLOCK_TYPES_H
+#define __ASM_CSKY_SPINLOCK_TYPES_H
+
+#include <asm-generic/qspinlock_types.h>
+#include <asm-generic/qrwlock_types.h>
+
+#endif /* __ASM_CSKY_SPINLOCK_TYPES_H */
-- 
2.36.1

