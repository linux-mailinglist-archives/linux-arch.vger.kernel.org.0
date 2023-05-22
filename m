Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E944E70BE09
	for <lists+linux-arch@lfdr.de>; Mon, 22 May 2023 14:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbjEVM1L (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 May 2023 08:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234019AbjEVM0g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2023 08:26:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 600B21FCA;
        Mon, 22 May 2023 05:24:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57F9F150C;
        Mon, 22 May 2023 05:25:30 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ADA8B3F59C;
        Mon, 22 May 2023 05:24:43 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     akiyks@gmail.com, boqun.feng@gmail.com, corbet@lwn.net,
        keescook@chromium.org, linux-arch@vger.kernel.org,
        linux@armlinux.org.uk, linux-doc@vger.kernel.org,
        mark.rutland@arm.com, paulmck@kernel.org, peterz@infradead.org,
        sstabellini@kernel.org, will@kernel.org
Subject: [PATCH 03/26] locking/atomic: hexagon: remove redundant arch_atomic_cmpxchg
Date:   Mon, 22 May 2023 13:24:06 +0100
Message-Id: <20230522122429.1915021-4-mark.rutland@arm.com>
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

Hexagon's implementation of arch_atomic_cmpxchg() is identical to its
implementation of arch_cmpxchg(). Have it define arch_atomic_cmpxchg()
in terms of arch_cmpxchg(), matching what it does for arch_atomic_xchg()
and arch_xchg().

At the same time, remove the kerneldoc comments for hexagon's
arch_atomic_xchg() and arch_atomic_cmpxchg(). The arch_atomic_*()
namespace is shared by all architectures and the API should be
documented centrally, and the comments aren't all that helpful as-is.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
---
 arch/hexagon/include/asm/atomic.h | 46 +++----------------------------
 1 file changed, 4 insertions(+), 42 deletions(-)

diff --git a/arch/hexagon/include/asm/atomic.h b/arch/hexagon/include/asm/atomic.h
index 6e94f8d04146f..738857e10d6ec 100644
--- a/arch/hexagon/include/asm/atomic.h
+++ b/arch/hexagon/include/asm/atomic.h
@@ -36,49 +36,11 @@ static inline void arch_atomic_set(atomic_t *v, int new)
  */
 #define arch_atomic_read(v)		READ_ONCE((v)->counter)
 
-/**
- * arch_atomic_xchg - atomic
- * @v: pointer to memory to change
- * @new: new value (technically passed in a register -- see xchg)
- */
-#define arch_atomic_xchg(v, new)	(arch_xchg(&((v)->counter), (new)))
-
-
-/**
- * arch_atomic_cmpxchg - atomic compare-and-exchange values
- * @v: pointer to value to change
- * @old:  desired old value to match
- * @new:  new value to put in
- *
- * Parameters are then pointer, value-in-register, value-in-register,
- * and the output is the old value.
- *
- * Apparently this is complicated for archs that don't support
- * the memw_locked like we do (or it's broken or whatever).
- *
- * Kind of the lynchpin of the rest of the generically defined routines.
- * Remember V2 had that bug with dotnew predicate set by memw_locked.
- *
- * "old" is "expected" old val, __oldval is actual old value
- */
-static inline int arch_atomic_cmpxchg(atomic_t *v, int old, int new)
-{
-	int __oldval;
+#define arch_atomic_xchg(v, new)					\
+	(arch_xchg(&((v)->counter), (new)))
 
-	asm volatile(
-		"1:	%0 = memw_locked(%1);\n"
-		"	{ P0 = cmp.eq(%0,%2);\n"
-		"	  if (!P0.new) jump:nt 2f; }\n"
-		"	memw_locked(%1,P0) = %3;\n"
-		"	if (!P0) jump 1b;\n"
-		"2:\n"
-		: "=&r" (__oldval)
-		: "r" (&v->counter), "r" (old), "r" (new)
-		: "memory", "p0"
-	);
-
-	return __oldval;
-}
+#define arch_atomic_cmpxchg(v, old, new)				\
+	(arch_cmpxchg(&((v)->counter), (old), (new)))
 
 #define ATOMIC_OP(op)							\
 static inline void arch_atomic_##op(int i, atomic_t *v)			\
-- 
2.30.2

