Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2F125193B
	for <lists+linux-arch@lfdr.de>; Tue, 25 Aug 2020 15:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgHYNKC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Aug 2020 09:10:02 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:59975 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbgHYNJ7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 Aug 2020 09:09:59 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BbTqQ4nMsz9tyVb;
        Tue, 25 Aug 2020 15:09:54 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id GoazpFaya51s; Tue, 25 Aug 2020 15:09:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BbTqQ3J3Mz9tyVY;
        Tue, 25 Aug 2020 15:09:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B3F798B81B;
        Tue, 25 Aug 2020 15:09:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id FOlmpcS5VeIE; Tue, 25 Aug 2020 15:09:55 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3738E8B820;
        Tue, 25 Aug 2020 15:09:55 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 1404B65D37; Tue, 25 Aug 2020 13:09:55 +0000 (UTC)
Message-Id: <58514a7669667e1531cd3c896e0b60037e13a8ca.1598360789.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1598360789.git.christophe.leroy@csgroup.eu>
References: <cover.1598360789.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v11 1/5] powerpc/processor: Move cpu_relax() into
 asm/vdso/processor.h
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, nathanl@linux.ibm.com,
        anton@ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        arnd@arndb.de, tglx@linutronix.de, vincenzo.frascino@arm.com,
        luto@kernel.org, linux-arch@vger.kernel.org
Date:   Tue, 25 Aug 2020 13:09:55 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

cpu_relax() need to be in asm/vdso/processor.h to be used by
the C VDSO generic library.

Move it there.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v9: Forgot to remove cpu_relax() from processor.h in v8
---
 arch/powerpc/include/asm/processor.h      | 13 ++-----------
 arch/powerpc/include/asm/vdso/processor.h | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+), 11 deletions(-)
 create mode 100644 arch/powerpc/include/asm/vdso/processor.h

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index ed0d633ab5aa..c1ba9c8d9b90 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -6,6 +6,8 @@
  * Copyright (C) 2001 PPC 64 Team, IBM Corp
  */
 
+#include <vdso/processor.h>
+
 #include <asm/reg.h>
 
 #ifdef CONFIG_VSX
@@ -63,14 +65,6 @@ extern int _chrp_type;
 
 #endif /* defined(__KERNEL__) && defined(CONFIG_PPC32) */
 
-/* Macros for adjusting thread priority (hardware multi-threading) */
-#define HMT_very_low()   asm volatile("or 31,31,31   # very low priority")
-#define HMT_low()	 asm volatile("or 1,1,1	     # low priority")
-#define HMT_medium_low() asm volatile("or 6,6,6      # medium low priority")
-#define HMT_medium()	 asm volatile("or 2,2,2	     # medium priority")
-#define HMT_medium_high() asm volatile("or 5,5,5      # medium high priority")
-#define HMT_high()	 asm volatile("or 3,3,3	     # high priority")
-
 #ifdef __KERNEL__
 
 #ifdef CONFIG_PPC64
@@ -350,7 +344,6 @@ static inline unsigned long __pack_fe01(unsigned int fpmode)
 }
 
 #ifdef CONFIG_PPC64
-#define cpu_relax()	do { HMT_low(); HMT_medium(); barrier(); } while (0)
 
 #define spin_begin()	HMT_low()
 
@@ -369,8 +362,6 @@ do {								\
 	}							\
 } while (0)
 
-#else
-#define cpu_relax()	barrier()
 #endif
 
 /* Check that a certain kernel stack pointer is valid in task_struct p */
diff --git a/arch/powerpc/include/asm/vdso/processor.h b/arch/powerpc/include/asm/vdso/processor.h
new file mode 100644
index 000000000000..39b9beace9ca
--- /dev/null
+++ b/arch/powerpc/include/asm/vdso/processor.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __ASM_VDSO_PROCESSOR_H
+#define __ASM_VDSO_PROCESSOR_H
+
+#ifndef __ASSEMBLY__
+
+/* Macros for adjusting thread priority (hardware multi-threading) */
+#define HMT_very_low()		asm volatile("or 31, 31, 31	# very low priority")
+#define HMT_low()		asm volatile("or 1, 1, 1	# low priority")
+#define HMT_medium_low()	asm volatile("or 6, 6, 6	# medium low priority")
+#define HMT_medium()		asm volatile("or 2, 2, 2	# medium priority")
+#define HMT_medium_high()	asm volatile("or 5, 5, 5	# medium high priority")
+#define HMT_high()		asm volatile("or 3, 3, 3	# high priority")
+
+#ifdef CONFIG_PPC64
+#define cpu_relax()	do { HMT_low(); HMT_medium(); barrier(); } while (0)
+#else
+#define cpu_relax()	barrier()
+#endif
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __ASM_VDSO_PROCESSOR_H */
-- 
2.25.0

