Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB34758E3B
	for <lists+linux-arch@lfdr.de>; Wed, 19 Jul 2023 09:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjGSHAL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Jul 2023 03:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjGSHAK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Jul 2023 03:00:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E341F10A;
        Wed, 19 Jul 2023 00:00:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78A0F61275;
        Wed, 19 Jul 2023 07:00:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93359C433C7;
        Wed, 19 Jul 2023 07:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689750008;
        bh=HDeq1/IS5rQ4pnF29vgg6/9UWwbJAWwzrpsSqnIsDaw=;
        h=From:To:Cc:Subject:Date:From;
        b=BlcMRpZXnKySXsRU/BLq7GNtkEcIqOSpQtkb9tE+IHnV5dfCtpRdy8Vot8NgHZKEP
         5icYatEmT1Aeu0O4/z2ZhmvRY5EgFlT6p3jxOlyN+gCF8vtHejFG7QaBqMOZaRjBr5
         hqrDu9imKG4cshkQ0M33xGa+SEspuW5tYh4BSy562wAcV2CAlsgDziRsbcWcnHz1t1
         An8hZxwQ24hbu7bfU+NbBXcNxbf9sxSvTcQWrlM7H0NI+6fcaRXGG4nwEEo3EL2d6N
         ZSFNO42cUZMlt9PtQjmqMU4BDQ2dcYRxqdryZnYIsKeKzbVFt7GawtHarwukr6Dy3m
         paPXR9B6ffsBQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, David.Laight@ACULAB.COM, will@kernel.org,
        peterz@infradead.org, mingo@redhat.com, longman@redhat.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH] asm-generic: ticket-lock: Optimize arch_spin_value_unlocked
Date:   Wed, 19 Jul 2023 03:00:01 -0400
Message-Id: <20230719070001.795010-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
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

Using arch_spinlock_is_locked would cause another unnecessary memory
access to the contended value. Although it won't cause a significant
performance gap in most architectures, the arch_spin_value_unlocked
argument contains enough information. Thus, remove unnecessary
atomic_read in arch_spin_value_unlocked().

Signed-off-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: David Laight <David.Laight@ACULAB.COM>
Cc: Peter Zijlstra <peterz@infradead.org>
---
Changelog:
This patch is separate from:
https://lore.kernel.org/linux-riscv/20220808071318.3335746-1-guoren@kernel.org/

Peter & David have commented on it:
https://lore.kernel.org/linux-riscv/YsK4Z9w0tFtgkni8@hirez.programming.kicks-ass.net/
---
 include/asm-generic/spinlock.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinlock.h
index fdfebcb050f4..90803a826ba0 100644
--- a/include/asm-generic/spinlock.h
+++ b/include/asm-generic/spinlock.h
@@ -68,11 +68,18 @@ static __always_inline void arch_spin_unlock(arch_spinlock_t *lock)
 	smp_store_release(ptr, (u16)val + 1);
 }
 
+static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
+{
+	u32 val = lock.counter;
+
+	return ((val >> 16) == (val & 0xffff));
+}
+
 static __always_inline int arch_spin_is_locked(arch_spinlock_t *lock)
 {
-	u32 val = atomic_read(lock);
+	arch_spinlock_t val = READ_ONCE(*lock);
 
-	return ((val >> 16) != (val & 0xffff));
+	return !arch_spin_value_unlocked(val);
 }
 
 static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
@@ -82,11 +89,6 @@ static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
 	return (s16)((val >> 16) - (val & 0xffff)) > 1;
 }
 
-static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
-{
-	return !arch_spin_is_locked(&lock);
-}
-
 #include <asm/qrwlock.h>
 
 #endif /* __ASM_GENERIC_SPINLOCK_H */
-- 
2.36.1

