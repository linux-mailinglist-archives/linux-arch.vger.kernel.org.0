Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B0F798A27
	for <lists+linux-arch@lfdr.de>; Fri,  8 Sep 2023 17:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244751AbjIHPn4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Sep 2023 11:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237259AbjIHPny (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Sep 2023 11:43:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA01813E;
        Fri,  8 Sep 2023 08:43:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F46C433C9;
        Fri,  8 Sep 2023 15:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694187830;
        bh=nvtvLaa0FoHyowq+s+FNMuvJVWJKzmwnQCxC99FMXow=;
        h=From:To:Cc:Subject:Date:From;
        b=taR3O9MNcKUhRi9Ue07COaSLrdRP7Bwc2UjsV2YdJabPs79M5xh0VL8nlBps3QU+g
         byQzj9RXhIGd7LS4AF0A8W7mTY6sMDL8YCg1wLN9MYueIVFiAwbI77YWVX1ZpEJDYP
         r/wC3TZyyer76nRla5GLZxG7KQLbvZVwkkr/bPsx7oUlldrV5JXeqsS46WIuzCtFsE
         csbmxrSLSWULw2SJcgPdfU035pVRDa9g1vx2DTpGh6eHn80DXo+0xm7+mMFEde8+Fv
         icCwd8P9HyqCBKQhEUme310+4zqQ+PMeyyhfIUb79PkpGCV1e5ppOBvtqPoizZUIz5
         4JyW3XdFN4Ivg==
From:   guoren@kernel.org
To:     guoren@kernel.org, David.Laight@ACULAB.COM, will@kernel.org,
        peterz@infradead.org, mingo@redhat.com, longman@redhat.com,
        maobibo@loongson.cn, mjguzik@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V3] asm-generic: ticket-lock: Optimize arch_spin_value_unlocked
Date:   Fri,  8 Sep 2023 11:43:39 -0400
Message-Id: <20230908154339.3250567-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The arch_spin_value_unlocked of ticket-lock would cause the compiler to
generate inefficient asm code in riscv architecture because of
unnecessary memory access to the contended value.

Before the patch:
------
void lockref_get(struct lockref *lockref)
{
  78:   fd010113                add     sp,sp,-48
  7c:   02813023                sd      s0,32(sp)
  80:   02113423                sd      ra,40(sp)
  84:   03010413                add     s0,sp,48

0000000000000088 <.LBB296>:
        CMPXCHG_LOOP(
  88:   00053783                ld      a5,0(a0)
------

After the patch:
------
void lockref_get(struct lockref *lockref)
{
        CMPXCHG_LOOP(
  78:   00053783                ld      a5,0(a0)
------

After the patch, the lockref_get could get in a fast path instead of the
function's prologue. This is because ticket lock complex logic would
limit compiler optimization for the spinlock fast path, and qspinlock
won't.

The caller of arch_spin_value_unlocked() could benefit from this
change. Currently, the only caller is lockref.

Acked-by: Waiman Long <longman@redhat.com>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
Changelog
V3:
 - Add Acked-by tags
 - Optimize commit log

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

