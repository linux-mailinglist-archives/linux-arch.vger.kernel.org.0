Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B7039C463
	for <lists+linux-arch@lfdr.de>; Sat,  5 Jun 2021 02:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhFEA3Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 20:29:25 -0400
Received: from mail-pj1-f48.google.com ([209.85.216.48]:43880 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhFEA3Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jun 2021 20:29:25 -0400
Received: by mail-pj1-f48.google.com with SMTP id l10-20020a17090a150ab0290162974722f2so6800884pja.2;
        Fri, 04 Jun 2021 17:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=bZWOWnyu5nOe9hcwFfo38NCzqJqFs6QIG+9+6hzf77k=;
        b=sVqQhvrIPUBvhq9HtJAXuH25dYnILW0Sccv/4f3kBtq8+yjB9Q2rlbVMvEFBrhoCwL
         8mqplKoEyo66t1+0ew+hojihXivOBR9xYtA22CBcYb9h1+P/N5WXqRC6zVN7Yb7hpK6N
         IocfJS0SQ3z3Xd78/cL8L5GZYphnNEXqg9BWMPOa7YD+4p4VteyOP9rpHNHclY8KN3o4
         WRwxq+nCsAJejGBX6AF6CAvv9npAJJHuOBrQ6RUH0u3pKT46ecjUodDLrIJPwIfWMCNx
         FirBG6cPB7pE8mqYmveLri/nAP8JMAY+TC69u0QDfQrjYiJhMN473ti2/BgpztdJQ4W1
         kxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=bZWOWnyu5nOe9hcwFfo38NCzqJqFs6QIG+9+6hzf77k=;
        b=axWqBXmWTO2gQck/qrWQMgGPtr3HGCGc7PU1TFNMNgzhUWkJyiNkTjtN71/g12E4E2
         6EVWf4aROumN5PbI8St/ibAUJeTsWIKyLD4mbQJdqBF1jl2fJn4Xw2DbKUSy+Jz+eoe6
         DxeisolDxuGgKOc6ztqDPzQ5d8/0nqDSc7AiT1rgRaE/zA8z5pl6BiGwx2Xhkfn8Ddy2
         Kk59ikf8F+BNU9GjBewCYci9vK/ectnMq14AO95RXj9j45/3ZVyy764y9n6rgZr0Ll4p
         GjBNi8EQRXN/JB5z7dLgGSj4bVJcQ+UQcCjt4cUeMARYm/rGkLfsFDio8s0f3Egr4kb7
         AVhg==
X-Gm-Message-State: AOAM530HVSA84R+9AA3DfcbZSgUBVNhmDx2WsBTsNqrqO+mn9+I7AF7n
        o6KuwNUaQv9EA0OKCHuh7LQ=
X-Google-Smtp-Source: ABdhPJxjr6SRTKqd7M2yn2GGd8wbqclJvvKqlheGcJ1NnTc0q1WibCsKIJKVTsY5Sdd7a6n11TS1OQ==
X-Received: by 2002:a17:902:f704:b029:f4:228d:4dca with SMTP id h4-20020a170902f704b02900f4228d4dcamr7003155plo.26.1622852798616;
        Fri, 04 Jun 2021 17:26:38 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id z17sm2589464pfq.218.2021.06.04.17.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 17:26:38 -0700 (PDT)
Date:   Sat, 05 Jun 2021 10:26:32 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 0/4] shoot lazy tlbs
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Anton Blanchard <anton@ozlabs.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, Randy Dunlap <rdunlap@infradead.org>
References: <20210601062303.3932513-1-npiggin@gmail.com>
        <603ffd67-3638-4c47-8067-c1bdfdf65f1b@kernel.org>
        <991660c3-c2bf-c303-a55c-7454f0cc45f7@kernel.org>
        <1622851909.wxi3vcx3m8.astroid@bobo.none>
In-Reply-To: <1622851909.wxi3vcx3m8.astroid@bobo.none>
MIME-Version: 1.0
Message-Id: <1622852601.xyhcpcfd7y.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Nicholas Piggin's message of June 5, 2021 10:17 am:
> Excerpts from Andy Lutomirski's message of June 5, 2021 3:05 am:
>> On 6/4/21 9:54 AM, Andy Lutomirski wrote:
>>> On 5/31/21 11:22 PM, Nicholas Piggin wrote:
>>>> There haven't been objections to the series since last posting, this
>>>> is just a rebase and tidies up a few comments minor patch rearranging.
>>>>
>>>=20
>>> I continue to object to having too many modes.  I like my more generic
>>> improvements better.  Let me try to find some time to email again.
>>>=20
>>=20
>> Specifically, this:
>>=20
>> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=
=3Dx86/mm
>=20
> That's worse than what powerpc does with the shoot lazies code so=20
> we wouldn't use it anyway.
>=20
> The fact is mm-cpumask and lazy mm is very architecture specific, so I=20
> don't really see that another "mode" is such a problem, it's for the=20
> most part "this is what powerpc does" -> "this is what powerpc does".
> The only mode in the context switch is just "take a ref on the lazy mm"
> or "don't take a ref". Surely that's not too onerous to add!?
>=20
> Actually the bigger part of it is actually the no-lazy mmu mode which
> is not yet used, I thought it was a neat little demonstrator of how code
> works with/without lazy but I will get rid of that for submission.

I admit that does add a bit more churn than necessary maybe that was
the main objection.

Here is the entire kernel/sched/core.c change after that is removed.
Pretty simple now. I'll resubmit.

Thanks,
Nick


diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e359c76ea2e2..1be0b97e12ec 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4171,7 +4171,7 @@ static struct rq *finish_task_switch(struct task_stru=
ct *prev)
 	__releases(rq->lock)
 {
 	struct rq *rq =3D this_rq();
-	struct mm_struct *mm =3D rq->prev_mm;
+	struct mm_struct *mm =3D NULL;
 	long prev_state;
=20
 	/*
@@ -4190,7 +4190,10 @@ static struct rq *finish_task_switch(struct task_str=
uct *prev)
 		      current->comm, current->pid, preempt_count()))
 		preempt_count_set(FORK_PREEMPT_COUNT);
=20
-	rq->prev_mm =3D NULL;
+#ifdef CONFIG_MMU_LAZY_TLB_REFCOUNT
+	mm =3D rq->prev_lazy_mm;
+	rq->prev_lazy_mm =3D NULL;
+#endif
=20
 	/*
 	 * A task struct has one reference for the use as "current".
@@ -4326,9 +4329,21 @@ context_switch(struct rq *rq, struct task_struct *pr=
ev,
 		switch_mm_irqs_off(prev->active_mm, next->mm, next);
=20
 		if (!prev->mm) {                        // from kernel
-			/* will mmdrop_lazy_tlb() in finish_task_switch(). */
-			rq->prev_mm =3D prev->active_mm;
+#ifdef CONFIG_MMU_LAZY_TLB_REFCOUNT
+			/* Will mmdrop_lazy_tlb() in finish_task_switch(). */
+			rq->prev_lazy_mm =3D prev->active_mm;
 			prev->active_mm =3D NULL;
+#else
+			/*
+			 * Without MMU_LAZY_TLB_REFCOUNT there is no lazy
+			 * tracking (because no rq->prev_lazy_mm) in
+			 * finish_task_switch, so no mmdrop_lazy_tlb(),
+			 * so no memory barrier for membarrier (see the
+			 * membarrier comment in finish_task_switch()).
+			 * Do it here.
+			 */
+			smp_mb();
+#endif
 		}
 	}
=20
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a189bec13729..0729cf19a987 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -961,7 +961,9 @@ struct rq {
 	struct task_struct	*idle;
 	struct task_struct	*stop;
 	unsigned long		next_balance;
-	struct mm_struct	*prev_mm;
+#ifdef CONFIG_MMU_LAZY_TLB_REFCOUNT
+	struct mm_struct	*prev_lazy_mm;
+#endif
=20
 	unsigned int		clock_update_flags;
 	u64			clock;

