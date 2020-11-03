Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3512A4DDD
	for <lists+linux-arch@lfdr.de>; Tue,  3 Nov 2020 19:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbgKCSHT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Nov 2020 13:07:19 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:7031 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729021AbgKCSHS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 3 Nov 2020 13:07:18 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CQd6B1lWkz9v1Yb;
        Tue,  3 Nov 2020 19:07:14 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id NF4LVou6ygdx; Tue,  3 Nov 2020 19:07:14 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CQd6B0xm0z9v1YS;
        Tue,  3 Nov 2020 19:07:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E19C58B7DC;
        Tue,  3 Nov 2020 19:07:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 1AyYWoDOcbhm; Tue,  3 Nov 2020 19:07:15 +0100 (CET)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 59EAB8B7DD;
        Tue,  3 Nov 2020 19:07:15 +0100 (CET)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 3E52266860; Tue,  3 Nov 2020 18:07:15 +0000 (UTC)
Message-Id: <2d03f4b466156c0a0bfe5494c8874dcac952445c.1604426550.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1604426550.git.christophe.leroy@csgroup.eu>
References: <cover.1604426550.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v13 4/8] powerpc/time: Move timebase functions into new
 asm/timebase.h
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, nathanl@linux.ibm.com,
        anton@ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        arnd@arndb.de, tglx@linutronix.de, vincenzo.frascino@arm.com,
        luto@kernel.org, linux-arch@vger.kernel.org
Date:   Tue,  3 Nov 2020 18:07:15 +0000 (UTC)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In order to easily use get_tb() from C VDSO, move timebase
functions into a new header named asm/timebase.h

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v13: new
---
 arch/powerpc/include/asm/time.h     | 30 +--------------------
 arch/powerpc/include/asm/timebase.h | 42 +++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 29 deletions(-)
 create mode 100644 arch/powerpc/include/asm/timebase.h

diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
index 2f566c1a754c..46d0d65cda0e 100644
--- a/arch/powerpc/include/asm/time.h
+++ b/arch/powerpc/include/asm/time.h
@@ -15,6 +15,7 @@
 
 #include <asm/processor.h>
 #include <asm/cpu_has_feature.h>
+#include <asm/timebase.h>
 
 /* time.c */
 extern unsigned long tb_ticks_per_jiffy;
@@ -38,12 +39,6 @@ struct div_result {
 	u64 result_low;
 };
 
-/* For compatibility, get_tbl() is defined as get_tb() on ppc64 */
-static inline unsigned long get_tbl(void)
-{
-	return mftb();
-}
-
 static inline u64 get_vtb(void)
 {
 #ifdef CONFIG_PPC_BOOK3S_64
@@ -53,29 +48,6 @@ static inline u64 get_vtb(void)
 	return 0;
 }
 
-static inline u64 get_tb(void)
-{
-	unsigned int tbhi, tblo, tbhi2;
-
-	if (IS_ENABLED(CONFIG_PPC64))
-		return mftb();
-
-	do {
-		tbhi = mftbu();
-		tblo = mftb();
-		tbhi2 = mftbu();
-	} while (tbhi != tbhi2);
-
-	return ((u64)tbhi << 32) | tblo;
-}
-
-static inline void set_tb(unsigned int upper, unsigned int lower)
-{
-	mtspr(SPRN_TBWL, 0);
-	mtspr(SPRN_TBWU, upper);
-	mtspr(SPRN_TBWL, lower);
-}
-
 /* Accessor functions for the decrementer register.
  * The 4xx doesn't even have a decrementer.  I tried to use the
  * generic timer interrupt code, which seems OK, with the 4xx PIT
diff --git a/arch/powerpc/include/asm/timebase.h b/arch/powerpc/include/asm/timebase.h
new file mode 100644
index 000000000000..a8eae3adaa91
--- /dev/null
+++ b/arch/powerpc/include/asm/timebase.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Common timebase prototypes and such for all ppc machines.
+ *
+ * Written by Cort Dougan (cort@cs.nmt.edu) to merge
+ * Paul Mackerras' version and mine for PReP and Pmac.
+ */
+
+#ifndef __POWERPC_TIMEBASE_H
+#define __POWERPC_TIMEBASE_H
+
+#include <asm/reg.h>
+
+/* For compatibility, get_tbl() is defined as get_tb() on ppc64 */
+static inline unsigned long get_tbl(void)
+{
+	return mftb();
+}
+
+static inline u64 get_tb(void)
+{
+	unsigned int tbhi, tblo, tbhi2;
+
+	if (IS_ENABLED(CONFIG_PPC64))
+		return mftb();
+
+	do {
+		tbhi = mftbu();
+		tblo = mftb();
+		tbhi2 = mftbu();
+	} while (tbhi != tbhi2);
+
+	return ((u64)tbhi << 32) | tblo;
+}
+
+static inline void set_tb(unsigned int upper, unsigned int lower)
+{
+	mtspr(SPRN_TBWL, 0);
+	mtspr(SPRN_TBWU, upper);
+	mtspr(SPRN_TBWL, lower);
+}
+#endif /* __POWERPC_TIMEBASE_H */
-- 
2.25.0

