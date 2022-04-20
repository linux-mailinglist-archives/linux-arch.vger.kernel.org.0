Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D83508B01
	for <lists+linux-arch@lfdr.de>; Wed, 20 Apr 2022 16:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379793AbiDTOrr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Apr 2022 10:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379782AbiDTOrh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Apr 2022 10:47:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAA2240;
        Wed, 20 Apr 2022 07:44:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 374F16176C;
        Wed, 20 Apr 2022 14:44:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC91C385A8;
        Wed, 20 Apr 2022 14:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650465887;
        bh=2lohV9FIb13AC3ra+UrYDKbvvuDZmMNdD6/UGs8XgO8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CuAZfwf3MjkmBTu2TZaBtRNJtpESsgpXqIA6PhB+MQ74rrbUDF/QVusDi/4OWGE+h
         /2qSsYUrinpsKBtHxf63d6Zd160XftP642RxJW1c9LBT7+IA39E6t3pblSEW/J6itG
         9aWCdVU9DWZddtN+JaN1KDX1zP/eFFJQRTXlIrdCYf1hSgWDtZDv3Q8sEdu7UJgagc
         7GlMEd0j/MnDyAFlmw9KRaNHlkpVgiX1OyKmNkXCIMulrHgKGDhL43sfiC845Xjbqy
         PR+DGjaWYx8G7dOW17Mb/yxdtOodHXBinkojBktJL9v1GA88LeHUpgM/7DkMrTsf78
         rdAVlGxnb0M9A==
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de, palmer@dabbelt.com,
        mark.rutland@arm.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, dlustig@nvidia.com, parri.andrea@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V3 4/5] riscv: atomic: Optimize dec_if_positive functions
Date:   Wed, 20 Apr 2022 22:44:16 +0800
Message-Id: <20220420144417.2453958-5-guoren@kernel.org>
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

The arch_atomic_sub_if_positive is unnecessary for current Linux,
and it causes another register allocation. Implementing the
dec_if_positive function directly is more efficient.

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
index 4aaf5b01e7c6..5589e1de2c80 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -374,45 +374,45 @@ ATOMIC_OPS()
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
 		"	sc.w.aqrl %[rc], %[rc], %[c]\n"
 		"	bnez     %[rc], 0b\n"
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
 		"	sc.d.aqrl %[rc], %[rc], %[c]\n"
 		"	bnez     %[rc], 0b\n"
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

