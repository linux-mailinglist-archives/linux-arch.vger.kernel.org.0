Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D322CE866
	for <lists+linux-arch@lfdr.de>; Fri,  4 Dec 2020 08:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbgLDHHT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Dec 2020 02:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgLDHHT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Dec 2020 02:07:19 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8D4C061A53;
        Thu,  3 Dec 2020 23:06:39 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id t8so3065180pfg.8;
        Thu, 03 Dec 2020 23:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=dwVSxo/1M8Xnxof7fMzvWiOBGddp/mlVm0/8qxQR6mk=;
        b=AhugiSj4YJkXajtvEzfvX3moDLw+5SLDF+ycyp2F6eeUGPNWtZ0JsFXZd/X+JHC/Gj
         ZucGXjwL4NWbZq8nulSLC3Gc12igAVspRrM1Je4YFt1KwMiaVyzUN+fQ+oTUM9heWFxs
         5uKrnkb2kUa/5Zc2MvQI9wapHq8dS+XClP4zsUK2cwjkdJfGLrbQkOkXLAFTbdoEC2Cc
         lR3G+gHvamcmMgPMPRd/OsOhv3X+IfOnxUbqFB0emsSjKA8HQx9iEudOkEMMWNL39sHb
         EjuGWwpFLjImyDhBtxSCB6qycdrit+l3HsPQ0Wd+hoK1D1bXv6kFhiMUdZXXhyYCBypH
         LgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=dwVSxo/1M8Xnxof7fMzvWiOBGddp/mlVm0/8qxQR6mk=;
        b=MhAA9oCGnob3bjL8POZSIRL5RupbOfZ5JfqjHmj3AT/A2n+BJv+a3CrJ43HbI32vAJ
         FLTeNM9vVjhh5SaHVGkppYcG5bfeB/J2pWIpw8QaZmUrT9lHmA+fUxrFh0YsuiXfUXlP
         /xkfGiOSGgiI39skc7j8VSYzuiB3jXWseBeuPGCMOY7FZBsmKPm8SPEKGhela0dBwgHL
         3/EccBQ9XjUinh0jSQSbfgRD4f+DSf8M4VASBus0NUT78mOzkkfNmUxu61PQdFlZe6ex
         GDBhZ/MNj6rPoedp5NODtmWZEvwt6m//Ux7nWZACAc9j7hJb/30HfJ/+bDxMhiAddMfE
         tJdA==
X-Gm-Message-State: AOAM533Km2OOYWZjsrJGvv+X3xrm3Q1mEXLiNVd+vtGa55qfbtSYVYPv
        h5paTYaqAuH/0BkwTEhuPU0=
X-Google-Smtp-Source: ABdhPJwg8+UkY63KZldOOJwcvxUsaRy0zBOIGCCPjMwwIJi9lyXUsbx8/+G9pNWlaAjZwFOxEMvGNg==
X-Received: by 2002:a62:ea09:0:b029:198:3d34:989 with SMTP id t9-20020a62ea090000b02901983d340989mr2681973pfh.42.1607065598913;
        Thu, 03 Dec 2020 23:06:38 -0800 (PST)
Received: from localhost ([1.129.136.33])
        by smtp.gmail.com with ESMTPSA id b13sm3676126pfo.15.2020.12.03.23.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 23:06:38 -0800 (PST)
Date:   Fri, 04 Dec 2020 17:06:31 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC v2 1/2] [NEEDS HELP] x86/mm: Handle unlazying membarrier
 core sync in the arch code
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jann Horn <jannh@google.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Will Deacon <will@kernel.org>, X86 ML <x86@kernel.org>
References: <cover.1607059162.git.luto@kernel.org>
        <203d39d11562575fd8bd6a094d97a3a332d8b265.1607059162.git.luto@kernel.org>
In-Reply-To: <203d39d11562575fd8bd6a094d97a3a332d8b265.1607059162.git.luto@kernel.org>
MIME-Version: 1.0
Message-Id: <1607064851.hub15e677x.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Andy Lutomirski's message of December 4, 2020 3:26 pm:
> The core scheduler isn't a great place for
> membarrier_mm_sync_core_before_usermode() -- the core scheduler doesn't
> actually know whether we are lazy.  With the old code, if a CPU is
> running a membarrier-registered task, goes idle, gets unlazied via a TLB
> shootdown IPI, and switches back to the membarrier-registered task, it
> will do an unnecessary core sync.
>=20
> Conveniently, x86 is the only architecture that does anything in this
> hook, so we can just move the code.

This should go on top of my series that adds the exit_lazy_mm call
and switches x86 over, at least.

> XXX: there are some comments in swich_mm_irqs_off() that seem to be
> trying to document what barriers are expected, and it's not clear to me
> that these barriers are actually present in all paths through the
> code.  So I think this change makes the code more comprehensible and
> has no effect on the code's correctness, but I'm not at all convinced
> that the code is correct.
>=20
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  arch/x86/mm/tlb.c   | 17 ++++++++++++++++-
>  kernel/sched/core.c | 14 +++++++-------
>  2 files changed, 23 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 3338a1feccf9..23df035b80e8 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -8,6 +8,7 @@
>  #include <linux/export.h>
>  #include <linux/cpu.h>
>  #include <linux/debugfs.h>
> +#include <linux/sched/mm.h>
> =20
>  #include <asm/tlbflush.h>
>  #include <asm/mmu_context.h>
> @@ -496,6 +497,8 @@ void switch_mm_irqs_off(struct mm_struct *prev, struc=
t mm_struct *next,
>  		 * from one thread in a process to another thread in the same
>  		 * process. No TLB flush required.
>  		 */
> +
> +		// XXX: why is this okay wrt membarrier?
>  		if (!was_lazy)
>  			return;
> =20
> @@ -508,12 +511,24 @@ void switch_mm_irqs_off(struct mm_struct *prev, str=
uct mm_struct *next,
>  		smp_mb();
>  		next_tlb_gen =3D atomic64_read(&next->context.tlb_gen);
>  		if (this_cpu_read(cpu_tlbstate.ctxs[prev_asid].tlb_gen) =3D=3D
> -				next_tlb_gen)
> +		    next_tlb_gen) {
> +			/*
> +			 * We're reactivating an mm, and membarrier might
> +			 * need to serialize.  Tell membarrier.
> +			 */
> +
> +			// XXX: I can't understand the logic in
> +			// membarrier_mm_sync_core_before_usermode().  What's
> +			// the mm check for?

Writing CR3 is serializing, apparently. Another x86ism that gets=20
commented and moved into arch/x86 with my patch.


> +			membarrier_mm_sync_core_before_usermode(next);
>  			return;
> +		}
> =20
>  		/*
>  		 * TLB contents went out of date while we were in lazy
>  		 * mode. Fall through to the TLB switching code below.
> +		 * No need for an explicit membarrier invocation -- the CR3
> +		 * write will serialize.
>  		 */
>  		new_asid =3D prev_asid;
>  		need_flush =3D true;
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 2d95dc3f4644..6c4b76147166 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3619,22 +3619,22 @@ static struct rq *finish_task_switch(struct task_=
struct *prev)
>  	kcov_finish_switch(current);
> =20
>  	fire_sched_in_preempt_notifiers(current);
> +
>  	/*
>  	 * When switching through a kernel thread, the loop in
>  	 * membarrier_{private,global}_expedited() may have observed that
>  	 * kernel thread and not issued an IPI. It is therefore possible to
>  	 * schedule between user->kernel->user threads without passing though
>  	 * switch_mm(). Membarrier requires a barrier after storing to
> -	 * rq->curr, before returning to userspace, so provide them here:
> +	 * rq->curr, before returning to userspace, and mmdrop() provides
> +	 * this barrier.
>  	 *
> -	 * - a full memory barrier for {PRIVATE,GLOBAL}_EXPEDITED, implicitly
> -	 *   provided by mmdrop(),
> -	 * - a sync_core for SYNC_CORE.
> +	 * XXX: I don't think mmdrop() actually does this.  There's no
> +	 * smp_mb__before/after_atomic() in there.

mmdrop definitely does provide a full barrier.

>  	 */
> -	if (mm) {
> -		membarrier_mm_sync_core_before_usermode(mm);
> +	if (mm)
>  		mmdrop(mm);
> -	}
> +
>  	if (unlikely(prev_state =3D=3D TASK_DEAD)) {
>  		if (prev->sched_class->task_dead)
>  			prev->sched_class->task_dead(prev);
> --=20
> 2.28.0
>=20
>=20
