Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEC458C4A2
	for <lists+linux-arch@lfdr.de>; Mon,  8 Aug 2022 10:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242111AbiHHIGg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Aug 2022 04:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242016AbiHHIGd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Aug 2022 04:06:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1DA13D4C;
        Mon,  8 Aug 2022 01:06:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5499FB80DD7;
        Mon,  8 Aug 2022 08:06:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B85C433D6;
        Mon,  8 Aug 2022 08:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659945983;
        bh=88SuZrvyL3jeJFfiTyPwnClk88QEzLMNBQPdHR9UyV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l4y7FiXxZ/3MlZLfl2cFaqKyz++tjbho4X9H2WHIaHFWDO4xvCWc/zx2pMZCTmn1s
         ckSQaw7NQ6Pqz1tTx6Tj19+TmTFv7OFhio/a29OboGFsDXyep7pzvjqsiQNxyO9FF8
         p2aDspkgMOSU5FhziAy1LKzLPD2ko78xk4r2x57YV9o0MIoXHwXL96EdPbdabgQeAS
         EdUXQszkHktiCCDhkjmXnsppif1V4ZcWpmuIL4c0cvc4Hj6+/4REakl2Cpfo583b+7
         9UEzb9BTXhYAvRoSLdFQpCxHzQSmUyE+M/pct1EIEP/461VqY22RUwFR861/Tn25c0
         mmkj+T+xM93yA==
From:   guoren@kernel.org
To:     tj@kernel.org, cl@linux.com, palmer@dabbelt.com, will@kernel.org,
        catalin.marinas@arm.com, peterz@infradead.org, arnd@arndb.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>, Guo Ren <guoren@kernel.org>
Subject: [RFC PATCH 2/4] arm64: percpu: Use generic PERCPU_RW_OPS
Date:   Mon,  8 Aug 2022 04:05:58 -0400
Message-Id: <20220808080600.3346843-3-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220808080600.3346843-1-guoren@kernel.org>
References: <20220808080600.3346843-1-guoren@kernel.org>
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

The generic percpu implementation also using READ_ONCE()/WRITE_ONCE().
And the generic even give a better __native_word() check.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/arm64/include/asm/percpu.h | 33 ---------------------------------
 1 file changed, 33 deletions(-)

diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
index b9ba19dbdb69..a58de20d742a 100644
--- a/arch/arm64/include/asm/percpu.h
+++ b/arch/arm64/include/asm/percpu.h
@@ -52,17 +52,6 @@ static inline unsigned long __kern_my_cpu_offset(void)
 #define __my_cpu_offset __kern_my_cpu_offset()
 #endif
 
-#define PERCPU_RW_OPS(sz)						\
-static inline unsigned long __percpu_read_##sz(void *ptr)		\
-{									\
-	return READ_ONCE(*(u##sz *)ptr);				\
-}									\
-									\
-static inline void __percpu_write_##sz(void *ptr, unsigned long val)	\
-{									\
-	WRITE_ONCE(*(u##sz *)ptr, (u##sz)val);				\
-}
-
 #define __PERCPU_OP_CASE(w, sfx, name, sz, op_llsc, op_lse)		\
 static inline void							\
 __percpu_##name##_case_##sz(void *ptr, unsigned long val)		\
@@ -120,10 +109,6 @@ __percpu_##name##_return_case_##sz(void *ptr, unsigned long val)	\
 	__PERCPU_RET_OP_CASE(w,  , name, 32, op_llsc, op_lse)		\
 	__PERCPU_RET_OP_CASE( ,  , name, 64, op_llsc, op_lse)
 
-PERCPU_RW_OPS(8)
-PERCPU_RW_OPS(16)
-PERCPU_RW_OPS(32)
-PERCPU_RW_OPS(64)
 PERCPU_OP(add, add, stadd)
 PERCPU_OP(andnot, bic, stclr)
 PERCPU_OP(or, orr, stset)
@@ -168,24 +153,6 @@ PERCPU_RET_OP(add, add, ldadd)
 	__retval;							\
 })
 
-#define this_cpu_read_1(pcp)		\
-	_pcp_protect_return(__percpu_read_8, pcp)
-#define this_cpu_read_2(pcp)		\
-	_pcp_protect_return(__percpu_read_16, pcp)
-#define this_cpu_read_4(pcp)		\
-	_pcp_protect_return(__percpu_read_32, pcp)
-#define this_cpu_read_8(pcp)		\
-	_pcp_protect_return(__percpu_read_64, pcp)
-
-#define this_cpu_write_1(pcp, val)	\
-	_pcp_protect(__percpu_write_8, pcp, (unsigned long)val)
-#define this_cpu_write_2(pcp, val)	\
-	_pcp_protect(__percpu_write_16, pcp, (unsigned long)val)
-#define this_cpu_write_4(pcp, val)	\
-	_pcp_protect(__percpu_write_32, pcp, (unsigned long)val)
-#define this_cpu_write_8(pcp, val)	\
-	_pcp_protect(__percpu_write_64, pcp, (unsigned long)val)
-
 #define this_cpu_add_1(pcp, val)	\
 	_pcp_protect(__percpu_add_case_8, pcp, val)
 #define this_cpu_add_2(pcp, val)	\
-- 
2.36.1

