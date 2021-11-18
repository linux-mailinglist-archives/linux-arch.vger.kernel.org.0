Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE40455805
	for <lists+linux-arch@lfdr.de>; Thu, 18 Nov 2021 10:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243434AbhKRJdp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Nov 2021 04:33:45 -0500
Received: from mail.loongson.cn ([114.242.206.163]:48746 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243402AbhKRJdk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 18 Nov 2021 04:33:40 -0500
Received: from localhost.localdomain (unknown [111.9.175.10])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxbuQeHZZhYxcAAA--.269S2;
        Thu, 18 Nov 2021 17:30:14 +0800 (CST)
From:   Huang Pei <huangpei@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        ambrosehua@gmail.com
Cc:     Bibo Mao <maobibo@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Burton <paulburton@kernel.org>,
        Li Xuefeng <lixuefeng@loongson.cn>,
        Yang Tiezhu <yangtiezhu@loongson.cn>,
        Gao Juxin <gaojuxin@loongson.cn>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 1/4] MIPS: rework local_t operation on MIPS64
Date:   Thu, 18 Nov 2021 17:30:02 +0800
Message-Id: <20211118093005.3121-1-huangpei@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9AxbuQeHZZhYxcAAA--.269S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGw45Zr1DurykKF1ktw1UWrg_yoWrurWUpF
        srCan7KrWqvF4fA3Z7ZF4Svr13Wr4rGrWYkFyqvrWvy3W0q3W8Zrs3KanYyrykZFZ8X3W8
        XFW7ur15Z3ZrA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
        xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
        8cxan2IY04v7MxkF7I0En4kS14v26r126r1DMxkIecxEwVAFwVW8uwCF04k20xvY0x0EwI
        xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
        Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
        IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
        6cxKx2IYs7xG6r4j6FyUMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUyxRDUUUUU=
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

+. Use daddu/dsubu for long int on MIPS64.

+. remove "asm/war.h" since R10000_LLSC_WAR became a config option

+. clean up, no function changed

Suggested-by:  "Maciej W. Rozycki" <macro@orcam.me.uk>
Signed-off-by: Huang Pei <huangpei@loongson.cn>
---
 arch/mips/include/asm/asm.h   | 18 ++++++++++
 arch/mips/include/asm/local.h | 62 +++++++++--------------------------
 2 files changed, 33 insertions(+), 47 deletions(-)

diff --git a/arch/mips/include/asm/asm.h b/arch/mips/include/asm/asm.h
index 2f8ce94ebaaf..f3302b13d3e0 100644
--- a/arch/mips/include/asm/asm.h
+++ b/arch/mips/include/asm/asm.h
@@ -19,6 +19,7 @@
 
 #include <asm/sgidefs.h>
 #include <asm/asm-eva.h>
+#include <asm/isa-rev.h>
 
 #ifndef __VDSO__
 /*
@@ -211,6 +212,8 @@ symbol		=	value
 #define LONG_SUB	sub
 #define LONG_SUBU	subu
 #define LONG_L		lw
+#define LONG_LL		ll
+#define LONG_SC		sc
 #define LONG_S		sw
 #define LONG_SP		swp
 #define LONG_SLL	sll
@@ -236,6 +239,8 @@ symbol		=	value
 #define LONG_SUB	dsub
 #define LONG_SUBU	dsubu
 #define LONG_L		ld
+#define LONG_LL		lld
+#define LONG_SC		scd
 #define LONG_S		sd
 #define LONG_SP		sdp
 #define LONG_SLL	dsll
@@ -320,6 +325,19 @@ symbol		=	value
 
 #define SSNOP		sll zero, zero, 1
 
+/*
+ * Using a branch-likely instruction to check the result of an sc instruction
+ * works around a bug present in R10000 CPUs prior to revision 3.0 that could
+ * cause ll-sc sequences to execute non-atomically.
+ */
+#ifdef CONFIG_WAR_R10000_LLSC
+# define SC_BEQZ	beqzl
+#elif MIPS_ISA_REV >= 6
+# define SC_BEQZ	beqzc
+#else
+# define SC_BEQZ	beqz
+#endif
+
 #ifdef CONFIG_SGI_IP28
 /* Inhibit speculative stores to volatile (e.g.DMA) or invalid addresses. */
 #include <asm/cacheops.h>
diff --git a/arch/mips/include/asm/local.h b/arch/mips/include/asm/local.h
index ecda7295ddcd..c1e109357110 100644
--- a/arch/mips/include/asm/local.h
+++ b/arch/mips/include/asm/local.h
@@ -7,7 +7,7 @@
 #include <linux/atomic.h>
 #include <asm/cmpxchg.h>
 #include <asm/compiler.h>
-#include <asm/war.h>
+#include <asm/asm.h>
 
 typedef struct
 {
@@ -31,34 +31,18 @@ static __inline__ long local_add_return(long i, local_t * l)
 {
 	unsigned long result;
 
-	if (kernel_uses_llsc && IS_ENABLED(CONFIG_WAR_R10000_LLSC)) {
-		unsigned long temp;
-
-		__asm__ __volatile__(
-		"	.set	push					\n"
-		"	.set	arch=r4000				\n"
-			__SYNC(full, loongson3_war) "			\n"
-		"1:"	__LL	"%1, %2		# local_add_return	\n"
-		"	addu	%0, %1, %3				\n"
-			__SC	"%0, %2					\n"
-		"	beqzl	%0, 1b					\n"
-		"	addu	%0, %1, %3				\n"
-		"	.set	pop					\n"
-		: "=&r" (result), "=&r" (temp), "=m" (l->a.counter)
-		: "Ir" (i), "m" (l->a.counter)
-		: "memory");
-	} else if (kernel_uses_llsc) {
+	if (kernel_uses_llsc) {
 		unsigned long temp;
 
 		__asm__ __volatile__(
 		"	.set	push					\n"
 		"	.set	"MIPS_ISA_ARCH_LEVEL"			\n"
-			__SYNC(full, loongson3_war) "			\n"
-		"1:"	__LL	"%1, %2		# local_add_return	\n"
-		"	addu	%0, %1, %3				\n"
-			__SC	"%0, %2					\n"
-		"	beqz	%0, 1b					\n"
-		"	addu	%0, %1, %3				\n"
+			__SYNC(full, loongson3_war) "                   \n"
+		"1:"	__stringify(LONG_LL)	"	%1, %2		\n"
+		"	"__stringify(LONG_ADDU)	"	%0, %1, %3	\n"
+		"	"__stringify(LONG_SC)	"	%0, %2		\n"
+		"	"__stringify(SC_BEQZ)	"	%0, 1b		\n"
+		"	"__stringify(LONG_ADDU)	"	%0, %1, %3	\n"
 		"	.set	pop					\n"
 		: "=&r" (result), "=&r" (temp), "=m" (l->a.counter)
 		: "Ir" (i), "m" (l->a.counter)
@@ -80,34 +64,18 @@ static __inline__ long local_sub_return(long i, local_t * l)
 {
 	unsigned long result;
 
-	if (kernel_uses_llsc && IS_ENABLED(CONFIG_WAR_R10000_LLSC)) {
-		unsigned long temp;
-
-		__asm__ __volatile__(
-		"	.set	push					\n"
-		"	.set	arch=r4000				\n"
-			__SYNC(full, loongson3_war) "			\n"
-		"1:"	__LL	"%1, %2		# local_sub_return	\n"
-		"	subu	%0, %1, %3				\n"
-			__SC	"%0, %2					\n"
-		"	beqzl	%0, 1b					\n"
-		"	subu	%0, %1, %3				\n"
-		"	.set	pop					\n"
-		: "=&r" (result), "=&r" (temp), "=m" (l->a.counter)
-		: "Ir" (i), "m" (l->a.counter)
-		: "memory");
-	} else if (kernel_uses_llsc) {
+	if (kernel_uses_llsc) {
 		unsigned long temp;
 
 		__asm__ __volatile__(
 		"	.set	push					\n"
 		"	.set	"MIPS_ISA_ARCH_LEVEL"			\n"
-			__SYNC(full, loongson3_war) "			\n"
-		"1:"	__LL	"%1, %2		# local_sub_return	\n"
-		"	subu	%0, %1, %3				\n"
-			__SC	"%0, %2					\n"
-		"	beqz	%0, 1b					\n"
-		"	subu	%0, %1, %3				\n"
+			__SYNC(full, loongson3_war) "                   \n"
+		"1:"	__stringify(LONG_LL)	"	%1, %2		\n"
+		"	"__stringify(LONG_SUBU)	"	%0, %1, %3	\n"
+		"	"__stringify(LONG_SC)	"	%0, %2		\n"
+		"	"__stringify(SC_BEQZ)	"	%0, 1b		\n"
+		"	"__stringify(LONG_SUBU)	"	%0, %1, %3	\n"
 		"	.set	pop					\n"
 		: "=&r" (result), "=&r" (temp), "=m" (l->a.counter)
 		: "Ir" (i), "m" (l->a.counter)
-- 
2.20.1

