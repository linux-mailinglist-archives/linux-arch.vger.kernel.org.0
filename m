Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B7170BE24
	for <lists+linux-arch@lfdr.de>; Mon, 22 May 2023 14:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbjEVM2F (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 May 2023 08:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234002AbjEVM07 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2023 08:26:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 13DF2185;
        Mon, 22 May 2023 05:25:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2F6A1480;
        Mon, 22 May 2023 05:25:54 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 43C0E3F59C;
        Mon, 22 May 2023 05:25:08 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     akiyks@gmail.com, boqun.feng@gmail.com, corbet@lwn.net,
        keescook@chromium.org, linux-arch@vger.kernel.org,
        linux@armlinux.org.uk, linux-doc@vger.kernel.org,
        mark.rutland@arm.com, paulmck@kernel.org, peterz@infradead.org,
        sstabellini@kernel.org, will@kernel.org
Subject: [PATCH 13/26] locking/atomic: xtensa: add preprocessor symbols
Date:   Mon, 22 May 2023 13:24:16 +0100
Message-Id: <20230522122429.1915021-14-mark.rutland@arm.com>
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

Add the required definitions to arch/xtensa.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
---
 arch/xtensa/include/asm/atomic.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/xtensa/include/asm/atomic.h b/arch/xtensa/include/asm/atomic.h
index 1d323a864002c..7308b7f777d79 100644
--- a/arch/xtensa/include/asm/atomic.h
+++ b/arch/xtensa/include/asm/atomic.h
@@ -245,6 +245,11 @@ static inline int arch_atomic_fetch_##op(int i, atomic_t * v)		\
 ATOMIC_OPS(add)
 ATOMIC_OPS(sub)
 
+#define arch_atomic_add_return			arch_atomic_add_return
+#define arch_atomic_sub_return			arch_atomic_sub_return
+#define arch_atomic_fetch_add			arch_atomic_fetch_add
+#define arch_atomic_fetch_sub			arch_atomic_fetch_sub
+
 #undef ATOMIC_OPS
 #define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_FETCH_OP(op)
 
@@ -252,6 +257,10 @@ ATOMIC_OPS(and)
 ATOMIC_OPS(or)
 ATOMIC_OPS(xor)
 
+#define arch_atomic_fetch_and			arch_atomic_fetch_and
+#define arch_atomic_fetch_or			arch_atomic_fetch_or
+#define arch_atomic_fetch_xor			arch_atomic_fetch_xor
+
 #undef ATOMIC_OPS
 #undef ATOMIC_FETCH_OP
 #undef ATOMIC_OP_RETURN
-- 
2.30.2

