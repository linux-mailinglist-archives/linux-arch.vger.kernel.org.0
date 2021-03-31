Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9896D350249
	for <lists+linux-arch@lfdr.de>; Wed, 31 Mar 2021 16:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236109AbhCaOcW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Mar 2021 10:32:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236091AbhCaOcT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 31 Mar 2021 10:32:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F176760FF1;
        Wed, 31 Mar 2021 14:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617201139;
        bh=ET6mHFYyqB1SBq1ewQ1GZzs5w6YT4Vz0URxeLviz9rs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dy4lrqNV7m0Yy2r05bp8XCPUAC8z34FNeWbsZGbTVJ+lgmHiGOSKMdqGkne7CRoBG
         h0aP6WRVV3BKhLHvmSQDrzflE0xWl0GYT7L60PDBgOBiqmYcbTKt2Bu9uZKJRZaUsC
         JLg3lic8aznTBUZTOQL+OKg8JNXlyE4WjU8cBh3xHk++jJEXBQtzEiQLzHnfiNCq/B
         g0HKpMzU6FVFUg006DAIrSZXocPI/6dxOd8xDDjfBpSviR9gXQWC7FD1n/kNq2jEoY
         ZMcJKFPvCAztLJ9A87rOz+Mc+atT+903XzdCNzQmHX5+m1XwlVwCQPi/iackWOsnMS
         W85nWlUX/+dvg==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v6 4/9] csky: locks: Optimize coding convention
Date:   Wed, 31 Mar 2021 14:30:35 +0000
Message-Id: <1617201040-83905-5-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617201040-83905-1-git-send-email-guoren@kernel.org>
References: <1617201040-83905-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

 - Using smp_cond_load_acquire in arch_spin_lock by Peter's
   advice.
 - Using __smp_acquire_fence in arch_spin_trylock
 - Using smp_store_release in arch_spin_unlock

All above are just coding conventions and won't affect the
function.

TODO in smp_cond_load_acquire for architecture:
 - current csky only has:
   lr.w val, <p0>
   sc.w <p0>. val2
   (Any other stores to p0 will let sc.w failed)

 - But smp_cond_load_acquire need:
   lr.w val, <p0>
   wfe
   (Any stores to p0 will send the event to let wfe retired)

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Link: https://lore.kernel.org/linux-riscv/CAAhSdy1JHLUFwu7RuCaQ+RUWRBks2KsDva7EpRt8--4ZfofSUQ@mail.gmail.com/T/#m13adac285b7f51f4f879a5d6b65753ecb1a7524e
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/include/asm/spinlock.h | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/csky/include/asm/spinlock.h b/arch/csky/include/asm/spinlock.h
index 69f5aa249c5f..69677167977a 100644
--- a/arch/csky/include/asm/spinlock.h
+++ b/arch/csky/include/asm/spinlock.h
@@ -26,10 +26,8 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
 		: "r"(p), "r"(ticket_next)
 		: "cc");
 
-	while (lockval.tickets.next != lockval.tickets.owner)
-		lockval.tickets.owner = READ_ONCE(lock->tickets.owner);
-
-	smp_mb();
+	smp_cond_load_acquire(&lock->tickets.owner,
+					VAL == lockval.tickets.next);
 }
 
 static inline int arch_spin_trylock(arch_spinlock_t *lock)
@@ -55,15 +53,14 @@ static inline int arch_spin_trylock(arch_spinlock_t *lock)
 	} while (!res);
 
 	if (!contended)
-		smp_mb();
+		__smp_acquire_fence();
 
 	return !contended;
 }
 
 static inline void arch_spin_unlock(arch_spinlock_t *lock)
 {
-	smp_mb();
-	WRITE_ONCE(lock->tickets.owner, lock->tickets.owner + 1);
+	smp_store_release(&lock->tickets.owner, lock->tickets.owner + 1);
 }
 
 static inline int arch_spin_value_unlocked(arch_spinlock_t lock)
-- 
2.17.1

