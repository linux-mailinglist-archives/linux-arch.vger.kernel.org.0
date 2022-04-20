Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8CB508B00
	for <lists+linux-arch@lfdr.de>; Wed, 20 Apr 2022 16:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379781AbiDTOrq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Apr 2022 10:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379768AbiDTOrb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Apr 2022 10:47:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F357B42A30;
        Wed, 20 Apr 2022 07:44:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D94C61647;
        Wed, 20 Apr 2022 14:44:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5450C385AC;
        Wed, 20 Apr 2022 14:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650465883;
        bh=sAulfPUiEvDbBqRnfY9vU25oXxTZrbt8To4Bji3mwyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tPXOZu0vrdrkEajEXD7J4RwxL7f29AjfbOT4IBcggA0PvPHAGfMQ2HUqG/l9bNmaU
         lYhzbIMGzYCYZyrUAfSa2jsWQ3pKmKBZoU2c86KVsBFv1bxaiQMfUMllfUDNQl+xsG
         O4qH0JQR1ho6ORYR7LbnQVTkRQPGCwSSgiTjotL1aKCdlkZ4gYR+rH8gKX8Y/wN8mP
         t81UsuPTKux+lMBZU/4NP9QYgY2wdmSUY8OAPZ6Z6lEjYaMKBNCnLMcvGiC/ROX0nk
         uYkJmZVIDlsyrhaTn6YY/bkOt3Ou5lrsgNlrct74cxs8knSuRN7/2vtmiCHxHPrxaS
         jnyGB6S4/X81g==
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de, palmer@dabbelt.com,
        mark.rutland@arm.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, dlustig@nvidia.com, parri.andrea@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V3 3/5] riscv: atomic: Optimize memory barrier semantics of LRSC-pairs
Date:   Wed, 20 Apr 2022 22:44:15 +0800
Message-Id: <20220420144417.2453958-4-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220420144417.2453958-1-guoren@kernel.org>
References: <20220420144417.2453958-1-guoren@kernel.org>
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

The current implementation is the same with 8e86f0b409a4 ("arm64:
atomics: fix use of acquire + release for full barrier semantics").
RISC-V could combine acquire and release into the AMO instructions
and it could reduce the cost of instruction in performance. Here
is RISC-V ISA 10.2 Load-Reserved/Store-Conditional Instructions:

 - .aq:   The LR/SC sequence can be given acquire semantics by
          setting the aq bit on the LR instruction.
 - .rl:   The LR/SC sequence can be given release semantics by
          setting the rl bit on the SC instruction.
 - .aqrl: Setting the aq bit on the LR instruction, and setting
          both the aq and the rl bit on the SC instruction makes the
          LR/SC sequence sequentially consistent, meaning that it
          cannot be reordered with earlier or later memory operations
          from the same hart.

Software should not set the rl bit on an LR instruction unless the
aq bit is also set, nor should software set the aq bit on an SC
instruction unless the rl bit is also set. LR.rl and SC.aq
instructions are not guaranteed to provide any stronger ordering than
those with both bits clear, but may result in lower performance.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Dan Lustig <dlustig@nvidia.com>
Cc: Andrea Parri <parri.andrea@gmail.com>
---
 arch/riscv/include/asm/atomic.h  | 6 ++----
 arch/riscv/include/asm/cmpxchg.h | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

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

