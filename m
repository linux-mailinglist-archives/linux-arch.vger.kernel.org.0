Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEE322C61F
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jul 2020 15:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgGXNPI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jul 2020 09:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgGXNPH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jul 2020 09:15:07 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A40C0619D3;
        Fri, 24 Jul 2020 06:15:07 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x9so4414159plr.2;
        Fri, 24 Jul 2020 06:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WiftbphxWXSIjSEt+dXbqpQmYX6qU7iPeGCFcxYtSQA=;
        b=g81IDF80xys7hUQAi+tyjSjNlCK2qfjl6DMDLGBqdXprJsL04R7sE+Ppf7O4NRtfC/
         XOS//mUthsddkAAPYDi+LuEet2/oqqhYQgoLAQh+Ep3WLc5cGnB4l66lgpOXZcgQjH/2
         THm3HuX15vW0lFTMuAkgNbj59CAbfANYE0Hc+Aj0wV1aAg/Ykj/AyBVMwiYQIazUkq9p
         lBF0c8mFla78lkA0QbHIOhKwQQ3bZagwfLEZMbPDeJMyNGvAdTbg1NyKQnDLjSfzOoZu
         bxN9uRPeTkkk/F+N4xTxoxctv3RbyMtZPX1+RB0q8g72P11W9020iBvl6qF2ZP1/2LM0
         rkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WiftbphxWXSIjSEt+dXbqpQmYX6qU7iPeGCFcxYtSQA=;
        b=S/7m/0xSumff4aEHytC4HjgylXhj+BxHPOiXmBh55LNscJBY0WC46VqF8RRd0uchQc
         dqnsrka9dS7yrjP1AU79fsNtMAsJNj9xYmVEjzrg24ECZlfJDW43Ah4hHJdwBRn4aO/k
         DKg5FMO0OKjlX6xDvtrIdyFkrEzXl8Gj9wK0XsEeD5hpes4U+UNIpPiFMkKJ5eUWto8O
         AysZV1mEjPUI8O6OWR4BRt3/l1QDsysc2pGYJ/QXVOTM/Oi4086ARoDOesBHdLAba/gU
         CTT3qQTOkq8aXfOtE4jslnZi7rHpEmA2DdC1CdxtOqtkgfCq/JXgAYF1k6kHJKLIrItm
         y0Gw==
X-Gm-Message-State: AOAM533yQ+EUxkZRB8+3Ptk5uDltuZd0FWopQKmnsSFeNWxBZRlEJGcV
        wq112TgZ97P5E/zWL4D+3sk=
X-Google-Smtp-Source: ABdhPJxDcJ3WwNc4e4B4k3cRPIw3LT71Pqkt7tkQKz15RWI12iCrEbS600oMqbiMl4hmSoD4ESVGAw==
X-Received: by 2002:a17:90b:300a:: with SMTP id hg10mr5327031pjb.211.1595596507027;
        Fri, 24 Jul 2020 06:15:07 -0700 (PDT)
Received: from bobo.ibm.com (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id az16sm5871998pjb.7.2020.07.24.06.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 06:15:06 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Anton Blanchard <anton@ozlabs.org>,
        =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH v4 5/6] powerpc/qspinlock: optimised atomic_try_cmpxchg_lock that adds the lock hint
Date:   Fri, 24 Jul 2020 23:14:22 +1000
Message-Id: <20200724131423.1362108-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200724131423.1362108-1-npiggin@gmail.com>
References: <20200724131423.1362108-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This brings the behaviour of the uncontended fast path back to roughly
equivalent to simple spinlocks -- a single atomic op with lock hint.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/atomic.h    | 28 ++++++++++++++++++++++++++++
 arch/powerpc/include/asm/qspinlock.h |  2 +-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index 498785ffc25f..f6a3d145ffb7 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -193,6 +193,34 @@ static __inline__ int atomic_dec_return_relaxed(atomic_t *v)
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 #define atomic_xchg_relaxed(v, new) xchg_relaxed(&((v)->counter), (new))
 
+/*
+ * Don't want to override the generic atomic_try_cmpxchg_acquire, because
+ * we add a lock hint to the lwarx, which may not be wanted for the
+ * _acquire case (and is not used by the other _acquire variants so it
+ * would be a surprise).
+ */
+static __always_inline bool
+atomic_try_cmpxchg_lock(atomic_t *v, int *old, int new)
+{
+	int r, o = *old;
+
+	__asm__ __volatile__ (
+"1:\t"	PPC_LWARX(%0,0,%2,1) "	# atomic_try_cmpxchg_acquire	\n"
+"	cmpw	0,%0,%3							\n"
+"	bne-	2f							\n"
+"	stwcx.	%4,0,%2							\n"
+"	bne-	1b							\n"
+"\t"	PPC_ACQUIRE_BARRIER "						\n"
+"2:									\n"
+	: "=&r" (r), "+m" (v->counter)
+	: "r" (&v->counter), "r" (o), "r" (new)
+	: "cr0", "memory");
+
+	if (unlikely(r != o))
+		*old = r;
+	return likely(r == o);
+}
+
 /**
  * atomic_fetch_add_unless - add unless the number is a given value
  * @v: pointer of type atomic_t
diff --git a/arch/powerpc/include/asm/qspinlock.h b/arch/powerpc/include/asm/qspinlock.h
index f5066f00a08c..b752d34517b3 100644
--- a/arch/powerpc/include/asm/qspinlock.h
+++ b/arch/powerpc/include/asm/qspinlock.h
@@ -37,7 +37,7 @@ static __always_inline void queued_spin_lock(struct qspinlock *lock)
 {
 	u32 val = 0;
 
-	if (likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL)))
+	if (likely(atomic_try_cmpxchg_lock(&lock->val, &val, _Q_LOCKED_VAL)))
 		return;
 
 	queued_spin_lock_slowpath(lock, val);
-- 
2.23.0

