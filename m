Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A8B4FCD51
	for <lists+linux-arch@lfdr.de>; Tue, 12 Apr 2022 05:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345291AbiDLDwt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Apr 2022 23:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345258AbiDLDwo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Apr 2022 23:52:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7B417A90;
        Mon, 11 Apr 2022 20:50:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D85A7B81A93;
        Tue, 12 Apr 2022 03:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6078C385AC;
        Tue, 12 Apr 2022 03:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649735425;
        bh=O2y3teAL9Rp1btL3NXWebprGsFA2ymLi02cTCI1njfs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HgFIXpXyatOm2DaTaDUeoy8YS8nwMT4zsGyWUanxympfGxzA5PYMcFivgLiBKduNV
         4igcn0Ao59VrB7hYFUE5IV3dG4AwItsdQynQSoeG2ruRqmCCO58LOCYO7IspPFIQdq
         hNalsA3hzgd8FPUa9tsIEzzo3SCoFZ51MyJGB053SVIH1DqA5cDueGnYvPhXwBtING
         MBqEaGm9U8IWiiXJNNeXGsdsT053jQiAkZqUoAd4ObFISo+VCsXBTvSnHC7uT8Pu4F
         b81ICNG1Kd2Bef52wjyJIMuvmqDxX1FU7qKyLo3zwPSg1oNB43eHA2H3buN6dbpCAi
         sAj2KGP15xZ1A==
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de, palmer@dabbelt.com,
        mark.rutland@arm.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V2 3/3] riscv: atomic: Optimize memory barrier semantics of LRSC-pairs
Date:   Tue, 12 Apr 2022 11:49:57 +0800
Message-Id: <20220412034957.1481088-4-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220412034957.1481088-1-guoren@kernel.org>
References: <20220412034957.1481088-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The current implementation is the same with 8e86f0b409a4 ("arm64:
atomics: fix use of acquire + release for full barrier semantics").
RISC-V could combine acquire and release into the AMO instructions
and it could reduce the cost of instruction in performance. Here
are the reasons for optimization:
 - Reduce one extra fence instruction
 - The "LR/SC" instruction with "acquire and release" operation is
   less cost than ACQUIRE_BARRIER/RELEASE_BARRIER which used
   precedes-loads/subsequent-stores prohibit to protect only LR/SC
   self-instruction.
 - Putting acquire/release barrier into the loop shouldn't cost
   extra performance problems from the micro-arch design view.
   Because LR and SC are sequential in the loop by RVWMO rules.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 arch/riscv/include/asm/atomic.h  |  6 ++----
 arch/riscv/include/asm/cmpxchg.h | 18 ++++++------------
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index 20ce8b83bc18..4aaf5b01e7c6 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -382,9 +382,8 @@ static __always_inline int arch_atomic_sub_if_positive(atomic_t *v, int offset)
 		"0:	lr.w     %[p],  %[c]\n"
 		"	sub      %[rc], %[p], %[o]\n"
 		"	bltz     %[rc], 1f\n"
-		"	sc.w.rl  %[rc], %[rc], %[c]\n"
+		"	sc.w.aqrl %[rc], %[rc], %[c]\n"
 		"	bnez     %[rc], 0b\n"
-		"	fence    rw, rw\n"
 		"1:\n"
 		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
 		: [o]"r" (offset)
@@ -404,9 +403,8 @@ static __always_inline s64 arch_atomic64_sub_if_positive(atomic64_t *v, s64 offs
 		"0:	lr.d     %[p],  %[c]\n"
 		"	sub      %[rc], %[p], %[o]\n"
 		"	bltz     %[rc], 1f\n"
-		"	sc.d.rl  %[rc], %[rc], %[c]\n"
+		"	sc.d.aqrl %[rc], %[rc], %[c]\n"
 		"	bnez     %[rc], 0b\n"
-		"	fence    rw, rw\n"
 		"1:\n"
 		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
 		: [o]"r" (offset)
diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 1af8db92250b..dfb51c98324d 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -215,9 +215,8 @@
 		__asm__ __volatile__ (					\
 			"0:	lr.w %0, %2\n"				\
 			"	bne  %0, %z3, 1f\n"			\
-			"	sc.w %1, %z4, %2\n"			\
+			"	sc.w.aq %1, %z4, %2\n"			\
 			"	bnez %1, 0b\n"				\
-			RISCV_ACQUIRE_BARRIER				\
 			"1:\n"						\
 			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
 			: "rJ" ((long)__old), "rJ" (__new)		\
@@ -227,9 +226,8 @@
 		__asm__ __volatile__ (					\
 			"0:	lr.d %0, %2\n"				\
 			"	bne %0, %z3, 1f\n"			\
-			"	sc.d %1, %z4, %2\n"			\
+			"	sc.d.aq %1, %z4, %2\n"			\
 			"	bnez %1, 0b\n"				\
-			RISCV_ACQUIRE_BARRIER				\
 			"1:\n"						\
 			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
 			: "rJ" (__old), "rJ" (__new)			\
@@ -259,8 +257,7 @@
 	switch (size) {							\
 	case 4:								\
 		__asm__ __volatile__ (					\
-			RISCV_RELEASE_BARRIER				\
-			"0:	lr.w %0, %2\n"				\
+			"0:	lr.w.rl %0, %2\n"			\
 			"	bne  %0, %z3, 1f\n"			\
 			"	sc.w %1, %z4, %2\n"			\
 			"	bnez %1, 0b\n"				\
@@ -271,8 +268,7 @@
 		break;							\
 	case 8:								\
 		__asm__ __volatile__ (					\
-			RISCV_RELEASE_BARRIER				\
-			"0:	lr.d %0, %2\n"				\
+			"0:	lr.d.rl %0, %2\n"			\
 			"	bne %0, %z3, 1f\n"			\
 			"	sc.d %1, %z4, %2\n"			\
 			"	bnez %1, 0b\n"				\
@@ -307,9 +303,8 @@
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
@@ -319,9 +314,8 @@
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

