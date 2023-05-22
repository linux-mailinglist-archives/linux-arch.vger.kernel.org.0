Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC75570BE1D
	for <lists+linux-arch@lfdr.de>; Mon, 22 May 2023 14:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbjEVM1w (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 May 2023 08:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbjEVM06 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2023 08:26:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA55910EF;
        Mon, 22 May 2023 05:25:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB65611FB;
        Mon, 22 May 2023 05:25:51 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2C9983F59C;
        Mon, 22 May 2023 05:25:05 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     akiyks@gmail.com, boqun.feng@gmail.com, corbet@lwn.net,
        keescook@chromium.org, linux-arch@vger.kernel.org,
        linux@armlinux.org.uk, linux-doc@vger.kernel.org,
        mark.rutland@arm.com, paulmck@kernel.org, peterz@infradead.org,
        sstabellini@kernel.org, will@kernel.org
Subject: [PATCH 12/26] locking/atomic: x86: add preprocessor symbols
Date:   Mon, 22 May 2023 13:24:15 +0100
Message-Id: <20230522122429.1915021-13-mark.rutland@arm.com>
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

Some atomics can be implemented in several different ways, e.g.
FULL/ACQUIRE/RELEASE ordered atomics can be implemented in terms of
RELAXED atomics, and ACQUIRE/RELEASE/RELAXED can be implemented in terms
of FULL ordered atomics. Other atomics are optional, and don't exist in
some configurations (e.g. not all architectures implement the 128-bit
cmpxchg ops).

Subsequent patches will require that architectures define a preprocessor
symbol for any atomic (or ordering variant) which is optional. This will
make the fallback ifdeffery more robust, and simplify future changes.

Add the required definitions to arch/x86.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
---
 arch/x86/include/asm/cmpxchg_64.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/cmpxchg_64.h b/arch/x86/include/asm/cmpxchg_64.h
index 3e6e3eef701b3..44b08b53ab32f 100644
--- a/arch/x86/include/asm/cmpxchg_64.h
+++ b/arch/x86/include/asm/cmpxchg_64.h
@@ -45,11 +45,13 @@ static __always_inline u128 arch_cmpxchg128(volatile u128 *ptr, u128 old, u128 n
 {
 	return __arch_cmpxchg128(ptr, old, new, LOCK_PREFIX);
 }
+#define arch_cmpxchg128 arch_cmpxchg128
 
 static __always_inline u128 arch_cmpxchg128_local(volatile u128 *ptr, u128 old, u128 new)
 {
 	return __arch_cmpxchg128(ptr, old, new,);
 }
+#define arch_cmpxchg128_local arch_cmpxchg128_local
 
 #define __arch_try_cmpxchg128(_ptr, _oldp, _new, _lock)			\
 ({									\
@@ -75,11 +77,13 @@ static __always_inline bool arch_try_cmpxchg128(volatile u128 *ptr, u128 *oldp,
 {
 	return __arch_try_cmpxchg128(ptr, oldp, new, LOCK_PREFIX);
 }
+#define arch_try_cmpxchg128 arch_try_cmpxchg128
 
 static __always_inline bool arch_try_cmpxchg128_local(volatile u128 *ptr, u128 *oldp, u128 new)
 {
 	return __arch_try_cmpxchg128(ptr, oldp, new,);
 }
+#define arch_try_cmpxchg128_local arch_try_cmpxchg128_local
 
 #define system_has_cmpxchg128()		boot_cpu_has(X86_FEATURE_CX16)
 
-- 
2.30.2

