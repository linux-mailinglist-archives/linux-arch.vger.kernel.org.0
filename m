Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B15E799D22
	for <lists+linux-arch@lfdr.de>; Sun, 10 Sep 2023 10:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbjIJIam (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 10 Sep 2023 04:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjIJIam (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 10 Sep 2023 04:30:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB5718F;
        Sun, 10 Sep 2023 01:30:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79BD6C433C7;
        Sun, 10 Sep 2023 08:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694334633;
        bh=RIvCrY8aBdKMNBfBShTR8o+UM7FnOQ4QZsRxMNLpjdw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KjCnXhMG6KClfl718naMf98+jPxX1V1N4S6PUpmhSsX9BjtbUPsH5h4JgW4UIvFl5
         gJxh4UC7UMdy5IkSGSnGA5IYbGLCzbKvkQF+/mACEoVG9tFS95mZ8t/PSBeqmckfLT
         5VLp7eBOhVtNCI5mLqSH1O/MY8PzUChOhu9Y792vLHaPgIMY2pJARxF50VH7M46PAt
         1aEFPzbYLaJDVXFZCwqidYQ+quX4JjQ9QjO9QLknsAGmTnDweASiVmnIoNQjI9yf++
         LXOLFwOKc8/XuL5qoy95gnzseByq1vbYUJ9Nj2dXCMj7Np+2SdZ1SBREM6Frqrg1iw
         y8KMhHo2aCNtA==
From:   guoren@kernel.org
To:     paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, paulmck@kernel.org, rostedt@goodmis.org,
        rdunlap@infradead.org, catalin.marinas@arm.com,
        conor.dooley@microchip.com, xiaoguang.xing@sophgo.com,
        bjorn@rivosinc.com, alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn,
        leobras@redhat.com
Cc:     linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH V11 04/17] locking/qspinlock: Improve xchg_tail for number of cpus >= 16k
Date:   Sun, 10 Sep 2023 04:28:58 -0400
Message-Id: <20230910082911.3378782-5-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230910082911.3378782-1-guoren@kernel.org>
References: <20230910082911.3378782-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The target of xchg_tail is to write the tail to the lock value, so
adding prefetchw could help the next cmpxchg step, which may
decrease the cmpxchg retry loops of xchg_tail. Some processors may
utilize this feature to give a forward guarantee, e.g., RISC-V
XuanTie processors would block the snoop channel & irq for several
cycles when prefetch.w instruction (from Zicbop extension) retired,
which guarantees the next cmpxchg succeeds.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 kernel/locking/qspinlock.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index d3f99060b60f..96b54e2ade86 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -223,7 +223,10 @@ static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
  */
 static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
 {
-	u32 old, new, val = atomic_read(&lock->val);
+	u32 old, new, val;
+
+	prefetchw(&lock->val);
+	val = atomic_read(&lock->val);
 
 	for (;;) {
 		new = (val & _Q_LOCKED_PENDING_MASK) | tail;
-- 
2.36.1

