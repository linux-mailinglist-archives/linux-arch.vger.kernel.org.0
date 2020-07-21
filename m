Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7110D227E46
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 13:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbgGULJI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 07:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729717AbgGULI4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 07:08:56 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41692C061794;
        Tue, 21 Jul 2020 04:08:56 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id y3so3431997wrl.4;
        Tue, 21 Jul 2020 04:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=XunMdMvkWzPxzceSO8589OZZNxbcZ0jXERe3FDXc4Go=;
        b=FqYmz9UBE4PDn0hc2i03AxdNbgdQuWC26CHX+LTmpFPMyc3D5Tdwionxj0V9wAv1rX
         5R1AZXE6ZKQqXTLvZE9IUPRBZDoLgY1Is9uxLpNFrqG6R8tVYU0s+m9hm6WfNPpZF0BI
         dp3WqItm2fG6M+4OcZjfj2YSlRy0vbZlt418Pt2xXWP5O8D85Gc4xtIQPlRvlCu0o7nB
         v7b5+223qylm20s3dIAnXRQ7ZuLzJgZU0zGf8k3rVd13tB0HUxwPPSd6CpLqkBOjwI/L
         6IkkN4GJGEdPfpBjb4gnmkC4tHt3tPOlup3nvOf2M/0yA1pX0lRqrPCd6mt8s4ZARSdu
         KZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=XunMdMvkWzPxzceSO8589OZZNxbcZ0jXERe3FDXc4Go=;
        b=eE0YyQssjUrAkRvLAebbI6SfzpDUbfu5Z9CB3PGusRw/c3Ok8F4Fq8ECgzJMnqzcWI
         5QXyqRGX4GnrC2xxeWdcr1X3++F/hia7YtR0JCytGtQ8HvZDYS8KPCSshlhGDXeJ2B66
         UoQR6JWgJaPvyQx3x9unUygs/axeg5PCTG5neOS4UXDBCJqhUpdjCvCUCURwNEt4zfre
         +8aIUkZNmn61JqlwlTtlOkxrh7QUtqAqdVwunZPLFFW0GiNKHdLwFCNCbWFi/PBzmgcV
         ClmFVr535LDGARP3lFTX1MUHlD+YaGlgopso7TYVZu6nV4Xyp2KvqgCZ0tQ8W6MuoKYR
         enRw==
X-Gm-Message-State: AOAM533w4ZoBZla/K0eFt5t0LHv/T3R6Js/9KZPIlJ0XU4d6LYPiROeu
        FXQzavJqPeMilZtRGHVdvXDeXAGV
X-Google-Smtp-Source: ABdhPJxb6Obroh8Tbl1JjXl1VQrrbHCwwmkBeiHvK1odJZa3Wx4Vfqy2xFxD9h9aE7o5NRR8+xd/Fw==
X-Received: by 2002:a5d:458a:: with SMTP id p10mr25848278wrq.184.1595329734966;
        Tue, 21 Jul 2020 04:08:54 -0700 (PDT)
Received: from localhost (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id k131sm3138401wmb.36.2020.07.21.04.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 04:08:54 -0700 (PDT)
Date:   Tue, 21 Jul 2020 21:08:47 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 0/6] powerpc: queued spinlocks and rwlocks
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Anton Blanchard <anton@ozlabs.org>,
        Boqun Feng <boqun.feng@gmail.com>, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Will Deacon <will@kernel.org>
References: <20200706043540.1563616-1-npiggin@gmail.com>
        <24f75d2c-60cd-2766-4aab-1a3b1c80646e@redhat.com>
        <1594101082.hfq9x5yact.astroid@bobo.none>
        <20200708084106.GE597537@hirez.programming.kicks-ass.net>
In-Reply-To: <20200708084106.GE597537@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-Id: <1595327263.lk78cqolxm.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Peter Zijlstra's message of July 8, 2020 6:41 pm:
> On Tue, Jul 07, 2020 at 03:57:06PM +1000, Nicholas Piggin wrote:
>> Yes, powerpc could certainly get more performance out of the slow
>> paths, and then there are a few parameters to tune.
>=20

Sorry for the delay, got bogged down and distracted by other things :(

> Can you clarify? The slow path is already in use on ARM64 which is weak,
> so I doubt there's superfluous serialization present. And Will spend a
> fair amount of time on making that thing guarantee forward progressm, so
> there just isn't too much room to play.

Sure, the way the pending not-queued slowpath (which I guess is the
medium-path) is implemented is just poorly structured for LL/SC. It
has one more atomic than necessary (queued_fetch_set_pending_acquire),
and a lot of branches in suboptimal order.

Attached patch (completely untested just compiled and looked at asm
so far) is a way we can fix this on powerpc I think. It's actually
very little generic code change which is good, duplicated medium-path
logic unfortunately but that's no worse than something like x86
really.

>> We don't have a good alternate patching for function calls yet, but
>> that would be something to do for native vs pv.
>=20
> Going by your jump_label implementation, support for static_call should
> be fairly straight forward too, no?
>=20
>   https://lkml.kernel.org/r/20200624153024.794671356@infradead.org

Nice, yeah it should be. I've wanted this for ages!

powerpc is kind of annoying to implement that with limited call range,
Hmm, not sure if we'd need a new linker feature to support it. We'd
provide call site patch space for indirect branches for those out of
range of direct call, so that should work fine. The trick would be=20
patching in the TOC lookup for the function... should be doable somehow.

Thanks,
Nick

---

diff --git a/arch/powerpc/include/asm/qspinlock.h b/arch/powerpc/include/as=
m/qspinlock.h
index b752d34517b3..26d8766a1106 100644
--- a/arch/powerpc/include/asm/qspinlock.h
+++ b/arch/powerpc/include/asm/qspinlock.h
@@ -31,16 +31,57 @@ static inline void queued_spin_unlock(struct qspinlock =
*lock)
=20
 #else
 extern void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
+extern void queued_spin_lock_slowpath_queue(struct qspinlock *lock);
 #endif
=20
 static __always_inline void queued_spin_lock(struct qspinlock *lock)
 {
-	u32 val =3D 0;
-
-	if (likely(atomic_try_cmpxchg_lock(&lock->val, &val, _Q_LOCKED_VAL)))
+	atomic_t *a =3D &lock->val;
+	u32 val;
+
+again:
+	asm volatile(
+"1:\t"	PPC_LWARX(%0,0,%1,1) "	# queued_spin_lock			\n"
+	: "=3D&r" (val)
+	: "r" (&a->counter)
+	: "memory");
+
+	if (likely(val =3D=3D 0)) {
+		asm_volatile_goto(
+	"	stwcx.	%0,0,%1							\n"
+	"	bne-	%l[again]						\n"
+	"\t"	PPC_ACQUIRE_BARRIER "						\n"
+		:
+		: "r"(_Q_LOCKED_VAL), "r" (&a->counter)
+		: "cr0", "memory"
+		: again );
 		return;
-
-	queued_spin_lock_slowpath(lock, val);
+	}
+
+	if (likely(val =3D=3D _Q_LOCKED_VAL)) {
+		asm_volatile_goto(
+	"	stwcx.	%0,0,%1							\n"
+	"	bne-	%l[again]						\n"
+		:
+		: "r"(_Q_LOCKED_VAL | _Q_PENDING_VAL), "r" (&a->counter)
+		: "cr0", "memory"
+		: again );
+
+		atomic_cond_read_acquire(a, !(VAL & _Q_LOCKED_MASK));
+//		clear_pending_set_locked(lock);
+		WRITE_ONCE(lock->locked_pending, _Q_LOCKED_VAL);
+//		lockevent_inc(lock_pending);
+		return;
+	}
+
+	if (val =3D=3D _Q_PENDING_VAL) {
+		int cnt =3D _Q_PENDING_LOOPS;
+		val =3D atomic_cond_read_relaxed(a,
+					       (VAL !=3D _Q_PENDING_VAL) || !cnt--);
+		if (!(val & ~_Q_LOCKED_MASK))
+			goto again;
+        }
+	queued_spin_lock_slowpath_queue(lock);
 }
 #define queued_spin_lock queued_spin_lock
=20
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index b9515fcc9b29..ebcc6f5d99d5 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -287,10 +287,14 @@ static __always_inline u32  __pv_wait_head_or_lock(st=
ruct qspinlock *lock,
=20
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
 #define queued_spin_lock_slowpath	native_queued_spin_lock_slowpath
+#define queued_spin_lock_slowpath_queue	native_queued_spin_lock_slowpath_q=
ueue
 #endif
=20
 #endif /* _GEN_PV_LOCK_SLOWPATH */
=20
+void queued_spin_lock_slowpath_queue(struct qspinlock *lock);
+static void __queued_spin_lock_slowpath_queue(struct qspinlock *lock);
+
 /**
  * queued_spin_lock_slowpath - acquire the queued spinlock
  * @lock: Pointer to queued spinlock structure
@@ -314,12 +318,6 @@ static __always_inline u32  __pv_wait_head_or_lock(str=
uct qspinlock *lock,
  */
 void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 {
-	struct mcs_spinlock *prev, *next, *node;
-	u32 old, tail;
-	int idx;
-
-	BUILD_BUG_ON(CONFIG_NR_CPUS >=3D (1U << _Q_TAIL_CPU_BITS));
-
 	if (pv_enabled())
 		goto pv_queue;
=20
@@ -397,6 +395,26 @@ void queued_spin_lock_slowpath(struct qspinlock *lock,=
 u32 val)
 queue:
 	lockevent_inc(lock_slowpath);
 pv_queue:
+	__queued_spin_lock_slowpath_queue(lock);
+}
+EXPORT_SYMBOL(queued_spin_lock_slowpath);
+
+void queued_spin_lock_slowpath_queue(struct qspinlock *lock)
+{
+	lockevent_inc(lock_slowpath);
+	__queued_spin_lock_slowpath_queue(lock);
+}
+EXPORT_SYMBOL(queued_spin_lock_slowpath_queue);
+
+static void __queued_spin_lock_slowpath_queue(struct qspinlock *lock)
+{
+	struct mcs_spinlock *prev, *next, *node;
+	u32 old, tail;
+	u32 val;
+	int idx;
+
+	BUILD_BUG_ON(CONFIG_NR_CPUS >=3D (1U << _Q_TAIL_CPU_BITS));
+
 	node =3D this_cpu_ptr(&qnodes[0].mcs);
 	idx =3D node->count++;
 	tail =3D encode_tail(smp_processor_id(), idx);
@@ -559,7 +577,6 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, =
u32 val)
 	 */
 	__this_cpu_dec(qnodes[0].mcs.count);
 }
-EXPORT_SYMBOL(queued_spin_lock_slowpath);
=20
 /*
  * Generate the paravirt code for queued_spin_unlock_slowpath().
