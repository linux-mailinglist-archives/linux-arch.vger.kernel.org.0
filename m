Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D86704DFD
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 14:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbjEPMqI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 08:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbjEPMqH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 08:46:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7252E4A;
        Tue, 16 May 2023 05:46:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53E0F627A4;
        Tue, 16 May 2023 12:46:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D251C433EF;
        Tue, 16 May 2023 12:46:00 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jun Yi <yijun@loongson.cn>
Subject: [PATCH] LoongArch: Support dbar with different hints
Date:   Tue, 16 May 2023 20:45:36 +0800
Message-Id: <20230516124536.535343-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.1
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

Traditionally, LoongArch uses "dbar 0" (full completion barrier) for
everything. But the full completion barrier is a performance killer, so
Loongson-3A6000 and newer processors introduce different hints:

Bit4: ordering or completion (0: completion, 1: ordering)
Bit3: barrier for previous read (0: true, 1: false)
Bit2: barrier for previous write (0: true, 1: false)
Bit1: barrier for succeeding read (0: true, 1: false)
Bit0: barrier for succedding write (0: true, 1: false)

Hint 0x700: barrier for "read after read" from the same address, which
is needed by LL-SC loops.

This patch enable various hints for different memory barries, it brings
performance improvements for Loongson-3A6000 series, and doesn't impact
Loongson-3A5000 series because they treat all hints as "dbar 0".

Signed-off-by: Jun Yi <yijun@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/barrier.h | 130 ++++++++++++---------------
 arch/loongarch/include/asm/io.h      |   2 +-
 arch/loongarch/kernel/smp.c          |   2 +-
 arch/loongarch/mm/tlbex.S            |   6 +-
 4 files changed, 60 insertions(+), 80 deletions(-)

diff --git a/arch/loongarch/include/asm/barrier.h b/arch/loongarch/include/asm/barrier.h
index cda977675854..0286ae7e3636 100644
--- a/arch/loongarch/include/asm/barrier.h
+++ b/arch/loongarch/include/asm/barrier.h
@@ -5,27 +5,56 @@
 #ifndef __ASM_BARRIER_H
 #define __ASM_BARRIER_H
 
-#define __sync()	__asm__ __volatile__("dbar 0" : : : "memory")
+/*
+ * Hint types:
+ *
+ * Bit4: ordering or completion (0: completion, 1: ordering)
+ * Bit3: barrier for previous read (0: true, 1: false)
+ * Bit2: barrier for previous write (0: true, 1: false)
+ * Bit1: barrier for succeeding read (0: true, 1: false)
+ * Bit0: barrier for succedding write (0: true, 1: false)
+ *
+ * Hint 0x700: barrier for "read after read" from the same address
+ */
+
+#define DBAR(hint) __asm__ __volatile__("dbar %0 " : : "I"(hint) : "memory")
+
+#define crwrw		0b00000
+#define cr_r_		0b00101
+#define c_w_w		0b01010
 
-#define fast_wmb()	__sync()
-#define fast_rmb()	__sync()
-#define fast_mb()	__sync()
-#define fast_iob()	__sync()
-#define wbflush()	__sync()
+#define orwrw		0b10000
+#define or_r_		0b10101
+#define o_w_w		0b11010
 
-#define wmb()		fast_wmb()
-#define rmb()		fast_rmb()
-#define mb()		fast_mb()
-#define iob()		fast_iob()
+#define orw_w		0b10010
+#define or_rw		0b10100
 
-#define __smp_mb()	__asm__ __volatile__("dbar 0" : : : "memory")
-#define __smp_rmb()	__asm__ __volatile__("dbar 0" : : : "memory")
-#define __smp_wmb()	__asm__ __volatile__("dbar 0" : : : "memory")
+#define c_sync()	DBAR(crwrw)
+#define c_rsync()	DBAR(cr_r_)
+#define c_wsync()	DBAR(c_w_w)
+
+#define o_sync()	DBAR(orwrw)
+#define o_rsync()	DBAR(or_r_)
+#define o_wsync()	DBAR(o_w_w)
+
+#define ldacq_mb()	DBAR(or_rw)
+#define strel_mb()	DBAR(orw_w)
+
+#define mb()		c_sync()
+#define rmb()		c_rsync()
+#define wmb()		c_wsync()
+#define iob()		c_sync()
+#define wbflush()	c_sync()
+
+#define __smp_mb()	o_sync()
+#define __smp_rmb()	o_rsync()
+#define __smp_wmb()	o_wsync()
 
 #ifdef CONFIG_SMP
-#define __WEAK_LLSC_MB		"	dbar 0  \n"
+#define __WEAK_LLSC_MB		"	dbar 0x700	\n"
 #else
-#define __WEAK_LLSC_MB		"		\n"
+#define __WEAK_LLSC_MB		"			\n"
 #endif
 
 #define __smp_mb__before_atomic()	barrier()
@@ -59,68 +88,19 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
 	return mask;
 }
 
-#define __smp_load_acquire(p)							\
-({										\
-	union { typeof(*p) __val; char __c[1]; } __u;				\
-	unsigned long __tmp = 0;							\
-	compiletime_assert_atomic_type(*p);					\
-	switch (sizeof(*p)) {							\
-	case 1:									\
-		*(__u8 *)__u.__c = *(volatile __u8 *)p;				\
-		__smp_mb();							\
-		break;								\
-	case 2:									\
-		*(__u16 *)__u.__c = *(volatile __u16 *)p;			\
-		__smp_mb();							\
-		break;								\
-	case 4:									\
-		__asm__ __volatile__(						\
-		"amor_db.w %[val], %[tmp], %[mem]	\n"				\
-		: [val] "=&r" (*(__u32 *)__u.__c)				\
-		: [mem] "ZB" (*(u32 *) p), [tmp] "r" (__tmp)			\
-		: "memory");							\
-		break;								\
-	case 8:									\
-		__asm__ __volatile__(						\
-		"amor_db.d %[val], %[tmp], %[mem]	\n"				\
-		: [val] "=&r" (*(__u64 *)__u.__c)				\
-		: [mem] "ZB" (*(u64 *) p), [tmp] "r" (__tmp)			\
-		: "memory");							\
-		break;								\
-	}									\
-	(typeof(*p))__u.__val;								\
+#define __smp_load_acquire(p)				\
+({							\
+	typeof(*p) ___p1 = READ_ONCE(*p);		\
+	compiletime_assert_atomic_type(*p);		\
+	ldacq_mb();					\
+	___p1;						\
 })
 
-#define __smp_store_release(p, v)						\
-do {										\
-	union { typeof(*p) __val; char __c[1]; } __u =				\
-		{ .__val = (__force typeof(*p)) (v) };				\
-	unsigned long __tmp;							\
-	compiletime_assert_atomic_type(*p);					\
-	switch (sizeof(*p)) {							\
-	case 1:									\
-		__smp_mb();							\
-		*(volatile __u8 *)p = *(__u8 *)__u.__c;				\
-		break;								\
-	case 2:									\
-		__smp_mb();							\
-		*(volatile __u16 *)p = *(__u16 *)__u.__c;			\
-		break;								\
-	case 4:									\
-		__asm__ __volatile__(						\
-		"amswap_db.w %[tmp], %[val], %[mem]	\n"			\
-		: [mem] "+ZB" (*(u32 *)p), [tmp] "=&r" (__tmp)			\
-		: [val] "r" (*(__u32 *)__u.__c)					\
-		: );								\
-		break;								\
-	case 8:									\
-		__asm__ __volatile__(						\
-		"amswap_db.d %[tmp], %[val], %[mem]	\n"			\
-		: [mem] "+ZB" (*(u64 *)p), [tmp] "=&r" (__tmp)			\
-		: [val] "r" (*(__u64 *)__u.__c)					\
-		: );								\
-		break;								\
-	}									\
+#define __smp_store_release(p, v)			\
+do {							\
+	compiletime_assert_atomic_type(*p);		\
+	strel_mb();					\
+	WRITE_ONCE(*p, v);				\
 } while (0)
 
 #define __smp_store_mb(p, v)							\
diff --git a/arch/loongarch/include/asm/io.h b/arch/loongarch/include/asm/io.h
index 545e2708fbf7..1c9410220040 100644
--- a/arch/loongarch/include/asm/io.h
+++ b/arch/loongarch/include/asm/io.h
@@ -62,7 +62,7 @@ extern pgprot_t pgprot_wc;
 #define ioremap_cache(offset, size)	\
 	ioremap_prot((offset), (size), pgprot_val(PAGE_KERNEL))
 
-#define mmiowb() asm volatile ("dbar 0" ::: "memory")
+#define mmiowb() wmb()
 
 /*
  * String version of I/O memory access operations.
diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index ed167e244cda..8daa97148c8e 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -118,7 +118,7 @@ static u32 ipi_read_clear(int cpu)
 	action = iocsr_read32(LOONGARCH_IOCSR_IPI_STATUS);
 	/* Clear the ipi register to clear the interrupt */
 	iocsr_write32(action, LOONGARCH_IOCSR_IPI_CLEAR);
-	smp_mb();
+	wbflush();
 
 	return action;
 }
diff --git a/arch/loongarch/mm/tlbex.S b/arch/loongarch/mm/tlbex.S
index 244e2f5aeee5..240ced55586e 100644
--- a/arch/loongarch/mm/tlbex.S
+++ b/arch/loongarch/mm/tlbex.S
@@ -184,7 +184,7 @@ tlb_huge_update_load:
 	ertn
 
 nopage_tlb_load:
-	dbar		0
+	dbar		0x700
 	csrrd		ra, EXCEPTION_KS2
 	la_abs		t0, tlb_do_page_fault_0
 	jr		t0
@@ -333,7 +333,7 @@ tlb_huge_update_store:
 	ertn
 
 nopage_tlb_store:
-	dbar		0
+	dbar		0x700
 	csrrd		ra, EXCEPTION_KS2
 	la_abs		t0, tlb_do_page_fault_1
 	jr		t0
@@ -480,7 +480,7 @@ tlb_huge_update_modify:
 	ertn
 
 nopage_tlb_modify:
-	dbar		0
+	dbar		0x700
 	csrrd		ra, EXCEPTION_KS2
 	la_abs		t0, tlb_do_page_fault_1
 	jr		t0
-- 
2.39.1

