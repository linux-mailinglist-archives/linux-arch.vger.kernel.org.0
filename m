Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E19C213525
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jul 2020 09:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgGCHgA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Jul 2020 03:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgGCHf7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Jul 2020 03:35:59 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FE2C08C5C1;
        Fri,  3 Jul 2020 00:35:59 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id m9so3388346pfh.0;
        Fri, 03 Jul 2020 00:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kvRCd9PLGVjMWPK2r0TpbnS9leKQS2B3nkKMRCX0GBc=;
        b=tUMVPFF4vP2G4/hgBKCTYJMF+Rw+SPYAjVXhxPe0fKu026bXGY5X+I5s+FA04mZq6a
         Et0nP5rO88tHymCo1NOQQ/W/kJDXtP6UaLNrJgLJXf8JIfg9yGsu8i0ZSFQwVqPFYkBX
         Wb6Vj1fQ2w43tn7SzVOKglgLx7emY1FiLNKNQIKSKfEbs73HUANA4nkFZ70EQNdNBHgB
         kLu3aQQ0XiLbZOQRXQm1V4GyCEOvfFXXsND1+pAzYPksxSg2lNgJiEO8xDchGcWp3HaT
         604/CxpVjNs6i0Fkg797X4y1Q+H9nLZnDzhhVAcrw64zCjA8NYJr7L1Gl1Wek4A7IMtT
         ackg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kvRCd9PLGVjMWPK2r0TpbnS9leKQS2B3nkKMRCX0GBc=;
        b=KM77fhNHvJYfgF//AXpK/CEv84v9mE3160l4FoZYePxhOsOYN5XqgLW3qLt9tTJVK6
         NHD/bEUNA3YZRLuTrrL/PaLFZGaGhzMh3vZaYXrDlng04K/Ekmd1jgoRPC66tXZBKIJf
         rNOvMH5xcCy8PyaBoMIy+dNehMv/JgH0oUHQkYGQydkWIgj86qCjUnpfaaTvAm2SCdT+
         wDyozIRaiNLIXQCPtKcpMFhiXbpaUIC8rxxov6K0yJZLpaZ0xU3HK1Hv/2+rT9DonMmD
         AP8LfI43wW/XSJptMqy/5zXuwWpkG//KKU+llwGH2Zo5WYSZaghE95ZkvJAw+8m265dO
         3NPA==
X-Gm-Message-State: AOAM5331p1annmOOHySzP5Jl3GdrJnj9ZhesGhISb9oMzmEt38qv8yhX
        rh4ZrGj+Tw4wQaUijz8wCsE=
X-Google-Smtp-Source: ABdhPJwRaPz9pu4t64jQMYoToKXv30O7t7kk9YVbA5y1a5jnOvLY5hddEayNHp5CZ6Ie32+ngdqn2w==
X-Received: by 2002:a62:1c13:: with SMTP id c19mr17009102pfc.52.1593761759369;
        Fri, 03 Jul 2020 00:35:59 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-186-125.tpgi.com.au. [61.68.186.125])
        by smtp.gmail.com with ESMTPSA id y7sm10218499pgk.93.2020.07.03.00.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 00:35:59 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Anton Blanchard <anton@ozlabs.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH v2 6/6] powerpc/qspinlock: optimised atomic_try_cmpxchg_lock that adds the lock hint
Date:   Fri,  3 Jul 2020 17:35:16 +1000
Message-Id: <20200703073516.1354108-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200703073516.1354108-1-npiggin@gmail.com>
References: <20200703073516.1354108-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
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
index 0960a0de2467..beb6aa4628e7 100644
--- a/arch/powerpc/include/asm/qspinlock.h
+++ b/arch/powerpc/include/asm/qspinlock.h
@@ -26,7 +26,7 @@ static __always_inline void queued_spin_lock(struct qspinlock *lock)
 {
 	u32 val = 0;
 
-	if (likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL)))
+	if (likely(atomic_try_cmpxchg_lock(&lock->val, &val, _Q_LOCKED_VAL)))
 		return;
 
 	queued_spin_lock_slowpath(lock, val);
-- 
2.23.0

