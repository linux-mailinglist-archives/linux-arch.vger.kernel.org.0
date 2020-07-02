Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8979E211D71
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jul 2020 09:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgGBHtb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jul 2020 03:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgGBHta (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jul 2020 03:49:30 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17666C08C5C1;
        Thu,  2 Jul 2020 00:49:30 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id j19so6198915pgm.11;
        Thu, 02 Jul 2020 00:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9NJ1Ulnd8FUmc15smZh6pt0VA5vxUSOm2TGGwsdqYoM=;
        b=h1o1LcgG1xlbxsTXx56FrrXDQFQguL0GPMYYSt5jqmcQS9iaN8toSEHNjvoLQHl5g2
         kzDzzyNXxq0XYbgxtm1X7QREncpnWLB1Eu58VIUB0QuwN2jXCVFxKvOCnuLd0vhkqZNf
         7XS8ybdePQ/GGeEP9XrvMzir35iJR2SgXnl9wB7NtEhEMpbdkvDZCh2jdW5ci9ZxZRVq
         wmMJGIH33PvOU3axKN/hDYhkKBb8CGOyBYeL0lG2SXjANW5pAr9EBa8AmAoEI2P0z2df
         pwJwVQQ+KNZdfS632ULuiUJ7WUxOD2vhmhwGdR20X/XaNBtIygo3+0MK/U7nnju8pVc8
         vPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9NJ1Ulnd8FUmc15smZh6pt0VA5vxUSOm2TGGwsdqYoM=;
        b=LzDgZvTj7F8MhX12VW7RHrmgB6WZKZ9k3vD4iT9ccwTjF53CSZCtMD4p2QH4j7rDi8
         xc93Z94Ht1SoxtSFJJMcEbSzFyni/29JE1CJ8ksPV0fYd0dyh1i0VLkO43RNI/yN5lOO
         /WL3kYMuuUDtmBevrjVk0dYelFofCsZKrMSXCBc9NtlnCQWK0gAPf3tV/JZzdgIGIv2K
         07zWaOaHrn89gECBfJr9P3owuVpbMVoSeYiGAvKhIGN9be28VrsrA26MYPlzDAnxwL/r
         SZ2r50rbxUjm3mn54DN56tCHn7s+0LvMt+dPRv25ZcOm5ZP5G/CmoC9wKavUYRM+jw+z
         mGoA==
X-Gm-Message-State: AOAM530dsMpacGRtk8u/ZKUZz+u4kkcMzxuVCN8HnK/WrGWjFJgiWERC
        3MYiUgMM/6x8zE0tgGxGzOk=
X-Google-Smtp-Source: ABdhPJzwYFeDE0Zesg+dB6oDlHyvbtGF9QEI6LdVjc/BuBvcwXIzeNCPUJRMFXKCpdtG6Hbd1Ttt8g==
X-Received: by 2002:a63:7741:: with SMTP id s62mr22972293pgc.332.1593676169702;
        Thu, 02 Jul 2020 00:49:29 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-186-125.tpgi.com.au. [61.68.186.125])
        by smtp.gmail.com with ESMTPSA id 17sm6001953pfv.16.2020.07.02.00.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 00:49:29 -0700 (PDT)
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
Subject: [PATCH 7/8] powerpc/qspinlock: optimised atomic_try_cmpxchg_lock that adds the lock hint
Date:   Thu,  2 Jul 2020 17:48:38 +1000
Message-Id: <20200702074839.1057733-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200702074839.1057733-1-npiggin@gmail.com>
References: <20200702074839.1057733-1-npiggin@gmail.com>
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
index 997a9a32df77..7091f1ceec3d 100644
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

