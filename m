Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5F4768A05
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jul 2023 04:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjGaCdX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 30 Jul 2023 22:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjGaCdX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 30 Jul 2023 22:33:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFDCE78;
        Sun, 30 Jul 2023 19:33:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8440760E0A;
        Mon, 31 Jul 2023 02:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6D6C433C8;
        Mon, 31 Jul 2023 02:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690770800;
        bh=0gAtJOQpVMD8BwO73WEaaztsqkDnNRkgEfGHbRe8E4w=;
        h=From:To:Cc:Subject:Date:From;
        b=G6PYP+nCCFGX5k/Hi5Jr75omCG6AH0IALpAYUKDAbmdOdLbSoz/oEoCh2GaopoYJA
         b4So3ErnwWMVWBWd/RtKCT2QAL5tjhLvwXpmwIKWtbXOm778YrJtOxLUDPLM8wyrY9
         LY37LeLPQFbJrspWfmGzgLb5qKB3z2/OvFHOe5kzJGll3iu+mMAS0tZr4Pwc3WYWy4
         X/Yk1+kNU/5RC3BLEVkhgYmXdPMd8jvH/hgJzD6JLQi0EE5TcqOdwEx/tMBua3PB92
         WOJvUGpzDAiv0fc4Hri9UdC+z1JAs75/diQ1JRd/fnElYCXG3XqJmtF0WdpeYpsb1w
         RdFH53r+vERNA==
From:   guoren@kernel.org
To:     guoren@kernel.org, David.Laight@ACULAB.COM, will@kernel.org,
        peterz@infradead.org, mingo@redhat.com, longman@redhat.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V2] asm-generic: ticket-lock: Optimize arch_spin_value_unlocked
Date:   Sun, 30 Jul 2023 22:33:08 -0400
Message-Id: <20230731023308.3748432-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The arch_spin_value_unlocked would cause an unnecessary memory
access to the contended value. Although it won't cause a significant
performance gap in most architectures, the arch_spin_value_unlocked
argument contains enough information. Thus, remove unnecessary
atomic_read in arch_spin_value_unlocked().

The caller of arch_spin_value_unlocked() could benefit from this
change. Currently, the only caller is lockref.

Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: David Laight <David.Laight@ACULAB.COM>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
Changelog
V2:
 - Fixup commit log with Waiman advice.
 - Add Waiman comment in the commit msg.
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

