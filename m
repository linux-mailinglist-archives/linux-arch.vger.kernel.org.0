Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229AF3D8D05
	for <lists+linux-arch@lfdr.de>; Wed, 28 Jul 2021 13:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbhG1Ltk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Jul 2021 07:49:40 -0400
Received: from mail.loongson.cn ([114.242.206.163]:57034 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232530AbhG1Ltj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Jul 2021 07:49:39 -0400
Received: from localhost.localdomain (unknown [121.228.27.69])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx30FERAFhOkQlAA--.1341S2;
        Wed, 28 Jul 2021 19:49:29 +0800 (CST)
From:   Rui Wang <wangrui@loongson.cn>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, Guo Ren <guoren@kernel.org>,
        linux-arch@vger.kernel.org, Rui Wang <wangrui@loongson.cn>,
        hev <r@hev.cc>, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [RFC PATCH v1 2/5] locking/qspinlock: Refactor xchg_tail to use atomic_fetch_and_or
Date:   Wed, 28 Jul 2021 19:49:23 +0800
Message-Id: <20210728114923.1294-1-wangrui@loongson.cn>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dx30FERAFhOkQlAA--.1341S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKr45CFWDGrykuF4kJF4xWFg_yoWkWFX_XF
        y2van5uF18Aw43Zw1YkrnrJr1jgwsaga13uwn5tFs5uFZFyw1qk347JF43JryUuanrX34Y
        kFWqkrySyr4jkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbsAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
        1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
        cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
        ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc2xSY4AK67AK6r4kMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Gr0_Zr1lIxAIcVC2
        z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
        UI43ZEXa7VUbLID7UUUUU==
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: wangrui <wangrui@loongson.cn>

Signed-by-off: Rui Wang <wangrui@loongson.cn>
Signed-by-off: hev <r@hev.cc>
---
 kernel/locking/qspinlock.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index cbff6ba53d56..350363e14e38 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -219,22 +219,8 @@ static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
  */
 static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
 {
-	u32 old, new, val = atomic_read(&lock->val);
-
-	for (;;) {
-		new = (val & _Q_LOCKED_PENDING_MASK) | tail;
-		/*
-		 * We can use relaxed semantics since the caller ensures that
-		 * the MCS node is properly initialized before updating the
-		 * tail.
-		 */
-		old = atomic_cmpxchg_relaxed(&lock->val, val, new);
-		if (old == val)
-			break;
-
-		val = old;
-	}
-	return old;
+	const u32 mask = _Q_LOCKED_PENDING_MASK;
+	return atomic_fetch_and_or_relaxed(mask, tail, &lock->val);
 }
 #endif /* _Q_PENDING_BITS == 8 */
 
-- 
2.32.0

