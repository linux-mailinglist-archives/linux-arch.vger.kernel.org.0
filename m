Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67AD970BE01
	for <lists+linux-arch@lfdr.de>; Mon, 22 May 2023 14:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbjEVM07 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 May 2023 08:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbjEVM0e (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2023 08:26:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F84F2126;
        Mon, 22 May 2023 05:24:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DCF4139F;
        Mon, 22 May 2023 05:25:25 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 63EE03F59C;
        Mon, 22 May 2023 05:24:38 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     akiyks@gmail.com, boqun.feng@gmail.com, corbet@lwn.net,
        keescook@chromium.org, linux-arch@vger.kernel.org,
        linux@armlinux.org.uk, linux-doc@vger.kernel.org,
        mark.rutland@arm.com, paulmck@kernel.org, peterz@infradead.org,
        sstabellini@kernel.org, will@kernel.org
Subject: [PATCH 01/26] locking/atomic: arm: fix sync ops
Date:   Mon, 22 May 2023 13:24:04 +0100
Message-Id: <20230522122429.1915021-2-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230522122429.1915021-1-mark.rutland@arm.com>
References: <20230522122429.1915021-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The sync_*() ops on arch/arm are defined in terms of the regular bitops
with no special handling. This is not correct, as UP kernels elide
barriers for the fully-ordered operations, and so the required ordering
is lost when such UP kernels are run under a hypervsior on an SMP
system.

Fix this by defining sync ops with the required barriers.

Note: On 32-bit arm, the sync_*() ops are currently only used by Xen,
which requires ARMv7, but the semantics can be implemented for ARMv6+.

Fixes: e54d2f61528165bb ("xen/arm: sync_bitops")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm/include/asm/assembler.h   | 17 +++++++++++++++++
 arch/arm/include/asm/sync_bitops.h | 29 +++++++++++++++++++++++++----
 arch/arm/lib/bitops.h              | 14 +++++++++++---
 arch/arm/lib/testchangebit.S       |  4 ++++
 arch/arm/lib/testclearbit.S        |  4 ++++
 arch/arm/lib/testsetbit.S          |  4 ++++
 6 files changed, 65 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 505a306e0271a..aebe2c8f6a686 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -394,6 +394,23 @@ ALT_UP_B(.L0_\@)
 #endif
 	.endm
 
+/*
+ * Raw SMP data memory barrier
+ */
+	.macro	__smp_dmb mode
+#if __LINUX_ARM_ARCH__ >= 7
+	.ifeqs "\mode","arm"
+	dmb	ish
+	.else
+	W(dmb)	ish
+	.endif
+#elif __LINUX_ARM_ARCH__ == 6
+	mcr	p15, 0, r0, c7, c10, 5	@ dmb
+#else
+	.error "Incompatible SMP platform"
+#endif
+	.endm
+
 #if defined(CONFIG_CPU_V7M)
 	/*
 	 * setmode is used to assert to be in svc mode during boot. For v7-M
diff --git a/arch/arm/include/asm/sync_bitops.h b/arch/arm/include/asm/sync_bitops.h
index 6f5d627c44a3c..f46b3c570f92e 100644
--- a/arch/arm/include/asm/sync_bitops.h
+++ b/arch/arm/include/asm/sync_bitops.h
@@ -14,14 +14,35 @@
  * ops which are SMP safe even on a UP kernel.
  */
 
+/*
+ * Unordered
+ */
+
 #define sync_set_bit(nr, p)		_set_bit(nr, p)
 #define sync_clear_bit(nr, p)		_clear_bit(nr, p)
 #define sync_change_bit(nr, p)		_change_bit(nr, p)
-#define sync_test_and_set_bit(nr, p)	_test_and_set_bit(nr, p)
-#define sync_test_and_clear_bit(nr, p)	_test_and_clear_bit(nr, p)
-#define sync_test_and_change_bit(nr, p)	_test_and_change_bit(nr, p)
 #define sync_test_bit(nr, addr)		test_bit(nr, addr)
-#define arch_sync_cmpxchg		arch_cmpxchg
 
+/*
+ * Fully ordered
+ */
+
+int _sync_test_and_set_bit(int nr, volatile unsigned long * p);
+#define sync_test_and_set_bit(nr, p)	_sync_test_and_set_bit(nr, p)
+
+int _sync_test_and_clear_bit(int nr, volatile unsigned long * p);
+#define sync_test_and_clear_bit(nr, p)	_sync_test_and_clear_bit(nr, p)
+
+int _sync_test_and_change_bit(int nr, volatile unsigned long * p);
+#define sync_test_and_change_bit(nr, p)	_sync_test_and_change_bit(nr, p)
+
+#define arch_sync_cmpxchg(ptr, old, new)				\
+({									\
+	__typeof__(*(ptr)) __ret;					\
+	__smp_mb__before_atomic();					\
+	__ret = arch_cmpxchg_relaxed((ptr), (old), (new));		\
+	__smp_mb__after_atomic();					\
+	__ret;								\
+})
 
 #endif
diff --git a/arch/arm/lib/bitops.h b/arch/arm/lib/bitops.h
index 95bd359912889..f069d1b2318e6 100644
--- a/arch/arm/lib/bitops.h
+++ b/arch/arm/lib/bitops.h
@@ -28,7 +28,7 @@ UNWIND(	.fnend		)
 ENDPROC(\name		)
 	.endm
 
-	.macro	testop, name, instr, store
+	.macro	__testop, name, instr, store, barrier
 ENTRY(	\name		)
 UNWIND(	.fnstart	)
 	ands	ip, r1, #3
@@ -38,7 +38,7 @@ UNWIND(	.fnstart	)
 	mov	r0, r0, lsr #5
 	add	r1, r1, r0, lsl #2	@ Get word offset
 	mov	r3, r2, lsl r3		@ create mask
-	smp_dmb
+	\barrier
 #if __LINUX_ARM_ARCH__ >= 7 && defined(CONFIG_SMP)
 	.arch_extension	mp
 	ALT_SMP(W(pldw)	[r1])
@@ -50,13 +50,21 @@ UNWIND(	.fnstart	)
 	strex	ip, r2, [r1]
 	cmp	ip, #0
 	bne	1b
-	smp_dmb
+	\barrier
 	cmp	r0, #0
 	movne	r0, #1
 2:	bx	lr
 UNWIND(	.fnend		)
 ENDPROC(\name		)
 	.endm
+
+	.macro	testop, name, instr, store
+	__testop \name, \instr, \store, smp_dmb
+	.endm
+
+	.macro	sync_testop, name, instr, store
+	__testop \name, \instr, \store, __smp_dmb
+	.endm
 #else
 	.macro	bitop, name, instr
 ENTRY(	\name		)
diff --git a/arch/arm/lib/testchangebit.S b/arch/arm/lib/testchangebit.S
index 4ebecc67e6e04..f13fe9bc2399a 100644
--- a/arch/arm/lib/testchangebit.S
+++ b/arch/arm/lib/testchangebit.S
@@ -10,3 +10,7 @@
                 .text
 
 testop	_test_and_change_bit, eor, str
+
+#if __LINUX_ARM_ARCH__ >= 6
+sync_testop	_sync_test_and_change_bit, eor, str
+#endif
diff --git a/arch/arm/lib/testclearbit.S b/arch/arm/lib/testclearbit.S
index 009afa0f5b4a7..4d2c5ca620ebf 100644
--- a/arch/arm/lib/testclearbit.S
+++ b/arch/arm/lib/testclearbit.S
@@ -10,3 +10,7 @@
                 .text
 
 testop	_test_and_clear_bit, bicne, strne
+
+#if __LINUX_ARM_ARCH__ >= 6
+sync_testop	_sync_test_and_clear_bit, bicne, strne
+#endif
diff --git a/arch/arm/lib/testsetbit.S b/arch/arm/lib/testsetbit.S
index f3192e55acc87..649dbab65d8d0 100644
--- a/arch/arm/lib/testsetbit.S
+++ b/arch/arm/lib/testsetbit.S
@@ -10,3 +10,7 @@
                 .text
 
 testop	_test_and_set_bit, orreq, streq
+
+#if __LINUX_ARM_ARCH__ >= 6
+sync_testop	_sync_test_and_set_bit, orreq, streq
+#endif
-- 
2.30.2

