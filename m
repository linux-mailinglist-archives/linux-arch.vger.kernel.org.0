Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664FE26853B
	for <lists+linux-arch@lfdr.de>; Mon, 14 Sep 2020 09:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgINHAj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Sep 2020 03:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbgINHAh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Sep 2020 03:00:37 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F786C06174A;
        Mon, 14 Sep 2020 00:00:36 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id b17so4853516pji.1;
        Mon, 14 Sep 2020 00:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=Y2wlAqtXNyefQseZpanYLfJq3N5RvjaF5iCZEQXKmek=;
        b=SPsvJsoOJGWCNz0MqiQxw/0yRCr5888lfA3TYTSv87ufnSkUZYEsSA86+seIOVYE/Y
         sEsXwdezlw4T7/8lmU7BopeUocyx8Wa6xwC9agje45+MBpLMpwWv97C8P//JYAbRAGs3
         RMmdIo20tOL6WZzNu7HBBNTUuknLwntruhux56ilu09Rfw4I8shyVWz/6m63EEJ+2snF
         +epCklQ4IYAAnNg7MixSMBYM1fXZ+nXjSTYll1bQtE6q+nwWRrZrh+whLeyFq0aW0EYf
         K1k/F/sraohhvQlS7WMZtC4lA8lFxZZTPqySYZ/mADZFg1s3OkMfGyw5Am2EyNN2yrYJ
         NFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=Y2wlAqtXNyefQseZpanYLfJq3N5RvjaF5iCZEQXKmek=;
        b=pQYGZlElBZyNJe7PM6OlSVr/43w06P1EHrA1s52ZgtWAwK75z3d6eabKdNIyI7BIpg
         HTiAyXE8dIL1HZofbiMA/bOq2LI1HpNqhDNVEUVKpbScqG3kBv9HOPzj6t1RkpsbXsrD
         ySu+Y4HXPF+X0C36mbptPa3t48y2y2848RYrbagPB0apJ4QwAS28agr6D7ElzmIHUpcN
         3YrMjlsrI23enXLIBXnFd0U2J/010AZorQ3m9C1OX4EjmTcIm3+nUaOGdGw3kCPpK2QD
         WC72bNFFTdTPhujTqbLmSXwDPQiNH/ky+PnfPC0ZG3rqHd/nYbn325qhas77Az0lmVMg
         PuJQ==
X-Gm-Message-State: AOAM533mwkQ7Qy/q3iTtBodKG8ZVSp6Vb2EMv/49F2VgMWhRZjQLkAcT
        OGgyUsZyimvsiKmKVh/3Rl0=
X-Google-Smtp-Source: ABdhPJxSdvNhMAY02DXO75GE5ykb8GoCQd5VlSAXulERBIog4wwB9uSCtbBQFfL7CZp4YQqpVBmMZw==
X-Received: by 2002:a17:90a:930e:: with SMTP id p14mr13005911pjo.49.1600066835157;
        Mon, 14 Sep 2020 00:00:35 -0700 (PDT)
Received: from localhost ([203.185.249.227])
        by smtp.gmail.com with ESMTPSA id e2sm7536325pgl.38.2020.09.14.00.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 00:00:34 -0700 (PDT)
Date:   Mon, 14 Sep 2020 17:00:29 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 3/4] sparc64: remove mm_cpumask clearing to fix
 kthread_use_mm race
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Jens Axboe <axboe@kernel.dk>,
        "David S . Miller" <davem@davemloft.net>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Peter Zijlstra <peterz@infradead.org>,
        sparclinux@vger.kernel.org
References: <20200914045219.3736466-1-npiggin@gmail.com>
        <20200914045219.3736466-4-npiggin@gmail.com>
In-Reply-To: <20200914045219.3736466-4-npiggin@gmail.com>
MIME-Version: 1.0
Message-Id: <1600066040.vnmz9nxhwt.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Nicholas Piggin's message of September 14, 2020 2:52 pm:

[...]

> The basic fix for sparc64 is to remove its mm_cpumask clearing code. The
> optimisation could be effectively restored by sending IPIs to mm_cpumask
> members and having them remove themselves from mm_cpumask. This is more
> tricky so I leave it as an exercise for someone with a sparc64 SMP.
> powerpc has a (currently similarly broken) example.

So this compiles and boots on qemu, but qemu does not support any
sparc64 machines with SMP. Attempting some simple hacks doesn't get
me far because openbios isn't populating an SMP device tree, which
blows up everywhere.

The patch is _relatively_ simple, hopefully it shouldn't explode, so
it's probably ready for testing on real SMP hardware, if someone has
a few cycles.

Thanks,
Nick

>=20
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/sparc/kernel/smp_64.c | 65 ++++++++------------------------------
>  1 file changed, 14 insertions(+), 51 deletions(-)
>=20
> diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
> index e286e2badc8a..e38d8bf454e8 100644
> --- a/arch/sparc/kernel/smp_64.c
> +++ b/arch/sparc/kernel/smp_64.c
> @@ -1039,38 +1039,9 @@ void smp_fetch_global_pmu(void)
>   * are flush_tlb_*() routines, and these run after flush_cache_*()
>   * which performs the flushw.
>   *
> - * The SMP TLB coherency scheme we use works as follows:
> - *
> - * 1) mm->cpu_vm_mask is a bit mask of which cpus an address
> - *    space has (potentially) executed on, this is the heuristic
> - *    we use to avoid doing cross calls.
> - *
> - *    Also, for flushing from kswapd and also for clones, we
> - *    use cpu_vm_mask as the list of cpus to make run the TLB.
> - *
> - * 2) TLB context numbers are shared globally across all processors
> - *    in the system, this allows us to play several games to avoid
> - *    cross calls.
> - *
> - *    One invariant is that when a cpu switches to a process, and
> - *    that processes tsk->active_mm->cpu_vm_mask does not have the
> - *    current cpu's bit set, that tlb context is flushed locally.
> - *
> - *    If the address space is non-shared (ie. mm->count =3D=3D 1) we avo=
id
> - *    cross calls when we want to flush the currently running process's
> - *    tlb state.  This is done by clearing all cpu bits except the curre=
nt
> - *    processor's in current->mm->cpu_vm_mask and performing the
> - *    flush locally only.  This will force any subsequent cpus which run
> - *    this task to flush the context from the local tlb if the process
> - *    migrates to another cpu (again).
> - *
> - * 3) For shared address spaces (threads) and swapping we bite the
> - *    bullet for most cases and perform the cross call (but only to
> - *    the cpus listed in cpu_vm_mask).
> - *
> - *    The performance gain from "optimizing" away the cross call for thr=
eads is
> - *    questionable (in theory the big win for threads is the massive sha=
ring of
> - *    address space state across processors).
> + * mm->cpu_vm_mask is a bit mask of which cpus an address
> + * space has (potentially) executed on, this is the heuristic
> + * we use to limit cross calls.
>   */
> =20
>  /* This currently is only used by the hugetlb arch pre-fault
> @@ -1080,18 +1051,13 @@ void smp_fetch_global_pmu(void)
>  void smp_flush_tlb_mm(struct mm_struct *mm)
>  {
>  	u32 ctx =3D CTX_HWBITS(mm->context);
> -	int cpu =3D get_cpu();
> =20
> -	if (atomic_read(&mm->mm_users) =3D=3D 1) {
> -		cpumask_copy(mm_cpumask(mm), cpumask_of(cpu));
> -		goto local_flush_and_out;
> -	}
> +	get_cpu();
> =20
>  	smp_cross_call_masked(&xcall_flush_tlb_mm,
>  			      ctx, 0, 0,
>  			      mm_cpumask(mm));
> =20
> -local_flush_and_out:
>  	__flush_tlb_mm(ctx, SECONDARY_CONTEXT);
> =20
>  	put_cpu();
> @@ -1114,17 +1080,15 @@ void smp_flush_tlb_pending(struct mm_struct *mm, =
unsigned long nr, unsigned long
>  {
>  	u32 ctx =3D CTX_HWBITS(mm->context);
>  	struct tlb_pending_info info;
> -	int cpu =3D get_cpu();
> +
> +	get_cpu();
> =20
>  	info.ctx =3D ctx;
>  	info.nr =3D nr;
>  	info.vaddrs =3D vaddrs;
> =20
> -	if (mm =3D=3D current->mm && atomic_read(&mm->mm_users) =3D=3D 1)
> -		cpumask_copy(mm_cpumask(mm), cpumask_of(cpu));
> -	else
> -		smp_call_function_many(mm_cpumask(mm), tlb_pending_func,
> -				       &info, 1);
> +	smp_call_function_many(mm_cpumask(mm), tlb_pending_func,
> +			       &info, 1);
> =20
>  	__flush_tlb_pending(ctx, nr, vaddrs);
> =20
> @@ -1134,14 +1098,13 @@ void smp_flush_tlb_pending(struct mm_struct *mm, =
unsigned long nr, unsigned long
>  void smp_flush_tlb_page(struct mm_struct *mm, unsigned long vaddr)
>  {
>  	unsigned long context =3D CTX_HWBITS(mm->context);
> -	int cpu =3D get_cpu();
> =20
> -	if (mm =3D=3D current->mm && atomic_read(&mm->mm_users) =3D=3D 1)
> -		cpumask_copy(mm_cpumask(mm), cpumask_of(cpu));
> -	else
> -		smp_cross_call_masked(&xcall_flush_tlb_page,
> -				      context, vaddr, 0,
> -				      mm_cpumask(mm));
> +	get_cpu();
> +
> +	smp_cross_call_masked(&xcall_flush_tlb_page,
> +			      context, vaddr, 0,
> +			      mm_cpumask(mm));
> +
>  	__flush_tlb_page(context, vaddr);
> =20
>  	put_cpu();
> --=20
> 2.23.0
>=20
>=20
