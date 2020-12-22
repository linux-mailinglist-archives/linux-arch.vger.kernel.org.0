Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5862DF5EF
	for <lists+linux-arch@lfdr.de>; Sun, 20 Dec 2020 16:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbgLTPkO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 20 Dec 2020 10:40:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:44872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727711AbgLTPkM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 20 Dec 2020 10:40:12 -0500
From:   guoren@kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     guoren@kernel.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-arch@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH v2 2/5] csky: Fixup barrier design
Date:   Sun, 20 Dec 2020 15:39:20 +0000
Message-Id: <1608478763-60148-2-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608478763-60148-1-git-send-email-guoren@kernel.org>
References: <1608478763-60148-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Remove shareable bit for ordering barrier, just keep ordering
in current hart is enough for SMP. Using three continuous
sync.is as PTW barrier to prevent speculative PTW in 860
microarchitecture.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/csky/include/asm/barrier.h | 82 ++++++++++++++++++++++++++++++-----------
 1 file changed, 60 insertions(+), 22 deletions(-)

diff --git a/arch/csky/include/asm/barrier.h b/arch/csky/include/asm/barrier.h
index a430e7f..117e622 100644
--- a/arch/csky/include/asm/barrier.h
+++ b/arch/csky/include/asm/barrier.h
@@ -8,6 +8,61 @@
 
 #define nop()	asm volatile ("nop\n":::"memory")
 
+#ifdef CONFIG_SMP
+
+/*
+ * bar.brwarws: ordering barrier for all load/store instructions
+ *              before/after
+ *
+ * |31|30 26|25 21|20 16|15  10|9   5|4           0|
+ *  1  10000 00000 00000 100001	00001 0 bw br aw ar
+ *
+ * b: before
+ * a: after
+ * r: read
+ * w: write
+ *
+ * Here are all combinations:
+ *
+ * bar.brw
+ * bar.br
+ * bar.bw
+ * bar.arw
+ * bar.ar
+ * bar.aw
+ * bar.brwarw
+ * bar.brarw
+ * bar.bwarw
+ * bar.brwar
+ * bar.brwaw
+ * bar.brar
+ * bar.bwaw
+ */
+#define __bar_brw()	asm volatile (".long 0x842cc000\n":::"memory")
+#define __bar_br()	asm volatile (".long 0x8424c000\n":::"memory")
+#define __bar_bw()	asm volatile (".long 0x8428c000\n":::"memory")
+#define __bar_arw()	asm volatile (".long 0x8423c000\n":::"memory")
+#define __bar_ar()	asm volatile (".long 0x8421c000\n":::"memory")
+#define __bar_aw()	asm volatile (".long 0x8422c000\n":::"memory")
+#define __bar_brwarw()	asm volatile (".long 0x842fc000\n":::"memory")
+#define __bar_brarw()	asm volatile (".long 0x8427c000\n":::"memory")
+#define __bar_bwarw()	asm volatile (".long 0x842bc000\n":::"memory")
+#define __bar_brwar()	asm volatile (".long 0x842dc000\n":::"memory")
+#define __bar_brwaw()	asm volatile (".long 0x842ec000\n":::"memory")
+#define __bar_brar()	asm volatile (".long 0x8425c000\n":::"memory")
+#define __bar_brar()	asm volatile (".long 0x8425c000\n":::"memory")
+#define __bar_bwaw()	asm volatile (".long 0x842ac000\n":::"memory")
+
+#define __smp_mb()	__bar_brwarw()
+#define __smp_rmb()	__bar_brar()
+#define __smp_wmb()	__bar_bwaw()
+
+#define ACQUIRE_FENCE		".long 0x8427c000\n"
+#define __smp_acquire_fence()	__bar_brarw()
+#define __smp_release_fence()	__bar_brwaw()
+
+#endif /* CONFIG_SMP */
+
 /*
  * sync:        completion barrier, all sync.xx instructions
  *              guarantee the last response recieved by bus transaction
@@ -15,31 +70,14 @@
  * sync.s:      inherit from sync, but also shareable to other cores
  * sync.i:      inherit from sync, but also flush cpu pipeline
  * sync.is:     the same with sync.i + sync.s
- *
- * bar.brwarw:  ordering barrier for all load/store instructions before it
- * bar.brwarws: ordering barrier for all load/store instructions before it
- *						and shareable to other cores
- * bar.brar:    ordering barrier for all load       instructions before it
- * bar.brars:   ordering barrier for all load       instructions before it
- *						and shareable to other cores
- * bar.bwaw:    ordering barrier for all store      instructions before it
- * bar.bwaws:   ordering barrier for all store      instructions before it
- *						and shareable to other cores
  */
+#define mb()		asm volatile ("sync\n":::"memory")
 
 #ifdef CONFIG_CPU_HAS_CACHEV2
-#define mb()		asm volatile ("sync.s\n":::"memory")
-
-#ifdef CONFIG_SMP
-#define __smp_mb()	asm volatile ("bar.brwarws\n":::"memory")
-#define __smp_rmb()	asm volatile ("bar.brars\n":::"memory")
-#define __smp_wmb()	asm volatile ("bar.bwaws\n":::"memory")
-#endif /* CONFIG_SMP */
-
-#define sync_is()	asm volatile ("sync.is\n":::"memory")
-
-#else /* !CONFIG_CPU_HAS_CACHEV2 */
-#define mb()		asm volatile ("sync\n":::"memory")
+/*
+ * Using three sync.is to prevent speculative PTW
+ */
+#define sync_is()	asm volatile ("sync.is\nsync.is\nsync.is\n":::"memory")
 #endif
 
 #include <asm-generic/barrier.h>
-- 
2.7.4

