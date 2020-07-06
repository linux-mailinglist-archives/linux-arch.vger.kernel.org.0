Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE872151C8
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jul 2020 06:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbgGFEg2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Jul 2020 00:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbgGFEg2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jul 2020 00:36:28 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2958FC061794;
        Sun,  5 Jul 2020 21:36:28 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o8so37800804wmh.4;
        Sun, 05 Jul 2020 21:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cAuLxDL8CkBp1tpBnhqClilHhcD0O782TDI+bdg1kNU=;
        b=XOdg5H2E4lNGYFhYc0/rxP9u8/fuTv6VeFja8Noz+koduO9ASBPQiUJIZhJUoe3FZ1
         5j6pJEMPoDcUJa4a693ePzR0S0bWCuP+okHF201wWOQJPeFXc19q1Wjad8zvFortsca4
         BAU2cWVym6HmdO3WF6QoeaegeTIDsaaabWgHbqVLzx2BEzkwec86jclgPu2E2A4yUupb
         d2wbC887pQ79Xz0sn+vujqemnZPZJNUPEuhO9Ih5S3OuA12J314AIXAeIrWLtZfjUxBp
         DPfOl5ls1Z513+Q9hqkmMlLQbBDtAUtP8bHoauVyDliR6Voin8q9hhSW7niY5xE76rE4
         BlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cAuLxDL8CkBp1tpBnhqClilHhcD0O782TDI+bdg1kNU=;
        b=bWze14XuD7ETshOYdBvGCLIa1YxkZSVULXH4g0ZPhOoVFVlIIGX2rZNfhxr10gJO+C
         Yylr+1/UGO4I9yUREDNI0/yJVaF0McGyVAy4zvIg3rJdfOgTVY3EZp+ENe1C0nZtldha
         mP5I01QsU5r9r1brjioQPfO3/IMcjv2FbyMi1h8l+1y9YCVsTpB7XoFue2O1v1SMy81y
         tmWPdm6C1b2GhYEqQ+pOjI3syf7VyFwFSIi6h00NgBT1T9WcwvitoV/M1Yzb/ipdA7RQ
         99CshD/SmGM0vAC0dBFObX8rWeAVTO39BGM7Ql//pORd0Ca2+VvytOg2TXxuSrSfN8uV
         2VlQ==
X-Gm-Message-State: AOAM531gYmRqXO1FWa2m6dHABgJJKuc7cxsQNXfTC6osxeADTtsnScd7
        LfM9OnQ+9vVeBPCXGPuqoEc=
X-Google-Smtp-Source: ABdhPJw3xwCHjl66IDwjNwnrVaS+sYKKRxEjT29tJBVhRnVy0iHX8mmwPpg7n6zCTYEyHFzW18ALwQ==
X-Received: by 2002:a7b:c44d:: with SMTP id l13mr49403893wmi.66.1594010186996;
        Sun, 05 Jul 2020 21:36:26 -0700 (PDT)
Received: from bobo.ibm.com (61-68-186-125.tpgi.com.au. [61.68.186.125])
        by smtp.gmail.com with ESMTPSA id r10sm22202309wrm.17.2020.07.05.21.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 21:36:26 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Anton Blanchard <anton@ozlabs.org>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH v3 6/6] powerpc/qspinlock: optimised atomic_try_cmpxchg_lock that adds the lock hint
Date:   Mon,  6 Jul 2020 14:35:40 +1000
Message-Id: <20200706043540.1563616-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200706043540.1563616-1-npiggin@gmail.com>
References: <20200706043540.1563616-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This brings the behaviour of the uncontended fast path back to
roughly equivalent to simple spinlocks -- a single atomic op with
lock hint.

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

