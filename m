Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28ED951B6CE
	for <lists+linux-arch@lfdr.de>; Thu,  5 May 2022 05:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242391AbiEED7i (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 May 2022 23:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbiEED72 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 May 2022 23:59:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1DB393D3;
        Wed,  4 May 2022 20:55:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A91161A8E;
        Thu,  5 May 2022 03:55:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CCF2C385AF;
        Thu,  5 May 2022 03:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651722949;
        bh=zEP2zr6mxUqpeaQg8TqMs57O91k1mSJfPjusddLpquU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TC1QLMp6xzwEn1E1GLMCM6MfsYmcR9ekeHf+HNLGQZ8XkpIMiWDTeZJ5XmM5DZHI2
         DyxDQe9ygFC3mJnzK4fGggD7gxnj3sOy7uMCVLwYAZOWSB8p09j2wyJ93I7A9lIm0n
         tgw2E7ddKxSThSjeAL+uQbRbBf644VDJsWfMXVBVnvPJH9iXcXwWpMsq9Bx5OKwKFV
         olxIXDt230yGcS2NblTwSBPgtaf28x6DZHAdEsgoTZlSOTuT4JqqOYRv5h4iZhBMhA
         y+gUCqk01aOqfQWl87zRxAiW0ehpn4At00ihakDvu8uk1VLnYEoBjaepYre60Olmj0
         IO2HMctw1E3sA==
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de, palmer@dabbelt.com,
        mark.rutland@arm.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, dlustig@nvidia.com, parri.andrea@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V4 2/5] riscv: atomic: Optimize dec_if_positive functions
Date:   Thu,  5 May 2022 11:55:23 +0800
Message-Id: <20220505035526.2974382-3-guoren@kernel.org>
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

Current implementation wastes another register to pass the
argument, but we only need addi to calculate the result. Optimize
the code with minimize the usage of registers.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Dan Lustig <dlustig@nvidia.com>
Cc: Andrea Parri <parri.andrea@gmail.com>
---
 arch/riscv/include/asm/atomic.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index ac9bdf4fc404..f3c6a6eac02a 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -310,47 +310,47 @@ ATOMIC_OPS()
 #undef ATOMIC_OPS
 #undef ATOMIC_OP
 
-static __always_inline int arch_atomic_sub_if_positive(atomic_t *v, int offset)
+static __always_inline int arch_atomic_dec_if_positive(atomic_t *v)
 {
        int prev, rc;
 
 	__asm__ __volatile__ (
 		"0:	lr.w     %[p],  %[c]\n"
-		"	sub      %[rc], %[p], %[o]\n"
+		"	addi     %[rc], %[p], -1\n"
 		"	bltz     %[rc], 1f\n"
 		"	sc.w.rl  %[rc], %[rc], %[c]\n"
 		"	bnez     %[rc], 0b\n"
 		"	fence    rw, rw\n"
 		"1:\n"
 		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
-		: [o]"r" (offset)
+		:
 		: "memory");
-	return prev - offset;
+	return prev - 1;
 }
 
-#define arch_atomic_dec_if_positive(v)	arch_atomic_sub_if_positive(v, 1)
+#define arch_atomic_dec_if_positive arch_atomic_dec_if_positive
 
 #ifndef CONFIG_GENERIC_ATOMIC64
-static __always_inline s64 arch_atomic64_sub_if_positive(atomic64_t *v, s64 offset)
+static __always_inline s64 arch_atomic64_dec_if_positive(atomic64_t *v)
 {
        s64 prev;
        long rc;
 
 	__asm__ __volatile__ (
 		"0:	lr.d     %[p],  %[c]\n"
-		"	sub      %[rc], %[p], %[o]\n"
+		"	addi      %[rc], %[p], -1\n"
 		"	bltz     %[rc], 1f\n"
 		"	sc.d.rl  %[rc], %[rc], %[c]\n"
 		"	bnez     %[rc], 0b\n"
 		"	fence    rw, rw\n"
 		"1:\n"
 		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
-		: [o]"r" (offset)
+		:
 		: "memory");
-	return prev - offset;
+	return prev - 1;
 }
 
-#define arch_atomic64_dec_if_positive(v)	arch_atomic64_sub_if_positive(v, 1)
+#define arch_atomic64_dec_if_positive	arch_atomic64_dec_if_positive
 #endif
 
 #endif /* _ASM_RISCV_ATOMIC_H */
-- 
2.25.1

