Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6325C51B6D2
	for <lists+linux-arch@lfdr.de>; Thu,  5 May 2022 05:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242505AbiEED7n (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 May 2022 23:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242468AbiEED7k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 May 2022 23:59:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D4B4C414;
        Wed,  4 May 2022 20:56:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5195C61977;
        Thu,  5 May 2022 03:56:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B7BC385C0;
        Thu,  5 May 2022 03:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651722960;
        bh=8XLEMSuEe89wrb20sD10ke+Ufm9VTkGQ/8AZQEqbL1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SAOvY8AOQbg9Fkt4GKHWZwvjDVyZth4XTpkBlu7cdANQnyoPfHGm6lKzfSPxdZFbd
         OfFvnz4UvYVkFe3qMLHVNzU/QldmY9Ofhrg54ObsCi/ENdC44elYAVuPvYsUPA3DVU
         5qwr5qO+SjE1A4tVF9k/G6TX0zFT22l3CUxCFulcTWFSDf00JsHrcIrd5raTsss9SJ
         CCb+bNTe+5YrOSJYsdIi7Nf6EhOV6eKGnkU4MzZG8gDaMnCtX1GmMB2vqRvQ3i/IXp
         iHmmJZQb6/VyV3mgeG0K6bDyBFhMZUYeDvXqUbQDBwWZO/s/jyM8CxxBMSgd3/vjSJ
         EQGYxHmGS4xfQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de, palmer@dabbelt.com,
        mark.rutland@arm.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, dlustig@nvidia.com, parri.andrea@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V4 5/5] riscv: atomic: Optimize LRSC-pairs atomic ops with .aqrl annotation
Date:   Thu,  5 May 2022 11:55:26 +0800
Message-Id: <20220505035526.2974382-6-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505035526.2974382-1-guoren@kernel.org>
References: <20220505035526.2974382-1-guoren@kernel.org>
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

The current implementation is the same with 8e86f0b409a4
("arm64: atomics: fix use of acquire + release for full barrier
semantics"). RISC-V could combine acquire and release into the SC
instructions and it could reduce a fence instruction to gain better
performance. Here is related descriptio from RISC-V ISA 10.2
Load-Reserved/Store-Conditional Instructions:

 - .aq:   The LR/SC sequence can be given acquire semantics by
          setting the aq bit on the LR instruction.
 - .rl:   The LR/SC sequence can be given release semantics by
          setting the rl bit on the SC instruction.
 - .aqrl: Setting the aq bit on the LR instruction, and setting
          both the aq and the rl bit on the SC instruction makes
          the LR/SC sequence sequentially consistent, meaning that
          it cannot be reordered with earlier or later memory
          operations from the same hart.

 Software should not set the rl bit on an LR instruction unless
 the aq bit is also set, nor should software set the aq bit on an
 SC instruction unless the rl bit is also set. LR.rl and SC.aq
 instructions are not guaranteed to provide any stronger ordering
 than those with both bits clear, but may result in lower
 performance.

The only difference is when sc.w/d.aqrl failed, it would cause .aq
effect than before. But it's okay for sematic because overlap
address LR couldn't beyond relating SC.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Dan Lustig <dlustig@nvidia.com>
Cc: Andrea Parri <parri.andrea@gmail.com>
---
 arch/riscv/include/asm/atomic.h  | 24 ++++++++----------------
 arch/riscv/include/asm/cmpxchg.h |  6 ++----
 2 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index 34f757dfc8f2..aef8aa9ac4f4 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -269,9 +269,8 @@ static __always_inline int arch_atomic_fetch_add_unless(atomic_t *v, int a, int
 		"0:	lr.w     %[p],  %[c]\n"
 		"	beq      %[p],  %[u], 1f\n"
 		"	add      %[rc], %[p], %[a]\n"
-		"	sc.w.rl  %[rc], %[rc], %[c]\n"
+		"	sc.w.aqrl  %[rc], %[rc], %[c]\n"
 		"	bnez     %[rc], 0b\n"
-		"	fence    rw, rw\n"
 		"1:\n"
 		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
 		: [a]"r" (a), [u]"r" (u)
@@ -290,9 +289,8 @@ static __always_inline s64 arch_atomic64_fetch_add_unless(atomic64_t *v, s64 a,
 		"0:	lr.d     %[p],  %[c]\n"
 		"	beq      %[p],  %[u], 1f\n"
 		"	add      %[rc], %[p], %[a]\n"
-		"	sc.d.rl  %[rc], %[rc], %[c]\n"
+		"	sc.d.aqrl  %[rc], %[rc], %[c]\n"
 		"	bnez     %[rc], 0b\n"
-		"	fence    rw, rw\n"
 		"1:\n"
 		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
 		: [a]"r" (a), [u]"r" (u)
@@ -382,9 +380,8 @@ static __always_inline bool arch_atomic_inc_unless_negative(atomic_t *v)
 		"0:	lr.w      %[p],  %[c]\n"
 		"	bltz      %[p],  1f\n"
 		"	addi      %[rc], %[p], 1\n"
-		"	sc.w.rl   %[rc], %[rc], %[c]\n"
+		"	sc.w.aqrl %[rc], %[rc], %[c]\n"
 		"	bnez      %[rc], 0b\n"
-		"	fence     rw, rw\n"
 		"1:\n"
 		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
 		:
@@ -402,9 +399,8 @@ static __always_inline bool arch_atomic_dec_unless_positive(atomic_t *v)
 		"0:	lr.w      %[p],  %[c]\n"
 		"	bgtz      %[p],  1f\n"
 		"	addi      %[rc], %[p], -1\n"
-		"	sc.w.rl   %[rc], %[rc], %[c]\n"
+		"	sc.w.aqrl %[rc], %[rc], %[c]\n"
 		"	bnez      %[rc], 0b\n"
-		"	fence     rw, rw\n"
 		"1:\n"
 		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
 		:
@@ -422,9 +418,8 @@ static __always_inline int arch_atomic_dec_if_positive(atomic_t *v)
 		"0:	lr.w     %[p],  %[c]\n"
 		"	addi     %[rc], %[p], -1\n"
 		"	bltz     %[rc], 1f\n"
-		"	sc.w.rl  %[rc], %[rc], %[c]\n"
+		"	sc.w.aqrl %[rc], %[rc], %[c]\n"
 		"	bnez     %[rc], 0b\n"
-		"	fence    rw, rw\n"
 		"1:\n"
 		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
 		:
@@ -444,9 +439,8 @@ static __always_inline bool arch_atomic64_inc_unless_negative(atomic64_t *v)
 		"0:	lr.d      %[p],  %[c]\n"
 		"	bltz      %[p],  1f\n"
 		"	addi      %[rc], %[p], 1\n"
-		"	sc.d.rl   %[rc], %[rc], %[c]\n"
+		"	sc.d.aqrl %[rc], %[rc], %[c]\n"
 		"	bnez      %[rc], 0b\n"
-		"	fence     rw, rw\n"
 		"1:\n"
 		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
 		:
@@ -465,9 +459,8 @@ static __always_inline bool arch_atomic64_dec_unless_positive(atomic64_t *v)
 		"0:	lr.d      %[p],  %[c]\n"
 		"	bgtz      %[p],  1f\n"
 		"	addi      %[rc], %[p], -1\n"
-		"	sc.d.rl   %[rc], %[rc], %[c]\n"
+		"	sc.d.aqrl %[rc], %[rc], %[c]\n"
 		"	bnez      %[rc], 0b\n"
-		"	fence     rw, rw\n"
 		"1:\n"
 		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
 		:
@@ -486,9 +479,8 @@ static __always_inline s64 arch_atomic64_dec_if_positive(atomic64_t *v)
 		"0:	lr.d     %[p],  %[c]\n"
 		"	addi      %[rc], %[p], -1\n"
 		"	bltz     %[rc], 1f\n"
-		"	sc.d.rl  %[rc], %[rc], %[c]\n"
+		"	sc.d.aqrl %[rc], %[rc], %[c]\n"
 		"	bnez     %[rc], 0b\n"
-		"	fence    rw, rw\n"
 		"1:\n"
 		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
 		:
diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 1af8db92250b..9269fceb86e0 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -307,9 +307,8 @@
 		__asm__ __volatile__ (					\
 			"0:	lr.w %0, %2\n"				\
 			"	bne  %0, %z3, 1f\n"			\
-			"	sc.w.rl %1, %z4, %2\n"			\
+			"	sc.w.aqrl %1, %z4, %2\n"		\
 			"	bnez %1, 0b\n"				\
-			"	fence rw, rw\n"				\
 			"1:\n"						\
 			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
 			: "rJ" ((long)__old), "rJ" (__new)		\
@@ -319,9 +318,8 @@
 		__asm__ __volatile__ (					\
 			"0:	lr.d %0, %2\n"				\
 			"	bne %0, %z3, 1f\n"			\
-			"	sc.d.rl %1, %z4, %2\n"			\
+			"	sc.d.aqrl %1, %z4, %2\n"		\
 			"	bnez %1, 0b\n"				\
-			"	fence rw, rw\n"				\
 			"1:\n"						\
 			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
 			: "rJ" (__old), "rJ" (__new)			\
-- 
2.25.1

