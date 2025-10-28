Return-Path: <linux-arch+bounces-14380-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BF0C14A4D
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 13:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47A1A19C3830
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 12:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F5632E6A7;
	Tue, 28 Oct 2025 12:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IN9IXmlp"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0CC32BF52
	for <linux-arch@vger.kernel.org>; Tue, 28 Oct 2025 12:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761654640; cv=none; b=g/JxzJ4w+wsyiSu5jb2TwQvt7lG3TIrPFVeVHw0l57cPW42jJ4DdHklzAi67Phiu0VRjuip1KFRn9z4EdngtzbxklgIxocApHFl/paXtAPQLJF/8Ebzlh+M5e9LraQ4htsS9++C1uIQ53ljoEg0E5+UmjL25mtcEzK04aKVI01s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761654640; c=relaxed/simple;
	bh=FUJwnKqupuATzqa/yUkbLMKYSmrcPHWiju1XCYAtVvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AgBjxo9YIYW8RSoTsHSocqhgGKKIG//uTeDa/C+4wxwzFfmnuZm8o/PMLarSTqUZfLBJi2H9OmBbks5dwQx3ZZpGylAHsVr2RlXVrwwJA5fJGC5OCbOYtVZytvcXguo60h8O70xLo9zzAG57UBHYrNRGJ0Bk6Fb/9DM4EGhUiqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IN9IXmlp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155F0C4CEE7
	for <linux-arch@vger.kernel.org>; Tue, 28 Oct 2025 12:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761654640;
	bh=FUJwnKqupuATzqa/yUkbLMKYSmrcPHWiju1XCYAtVvU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IN9IXmlpfWmyQMe+4yoJTRjrGkXONjtInjRNNGwLDljJ1Ic7/ddFwvqAuTWuBxGEf
	 ggNv4arOeC36FTqSclS7agsLn0giGAlgy3711NOxA7QnriWNWG0jBFLFs9N5h4BZGw
	 Q8c+lbqvJ6pAW0kKUoegNkJhQkV8aLUg35ip0R31lA0L+fU9zQfaSwQjysXPIvBTEI
	 3RGk17q9uhF2ESP/I0/Ie5Dm/p5vDSh3YZTnUEYOO0p2nt4xh+HbjTSvfGCK5tFXHS
	 m7IOMOESNFONZnvFolxLiDeuUIdGtz94/CWxElVzIK1hkjq/Yf6lT+t5faKd6ehqUp
	 6HDN0JNqG/u5Q==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-3d56d0cb3dbso671977fac.3
        for <linux-arch@vger.kernel.org>; Tue, 28 Oct 2025 05:30:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWqPKH7tdRs9SdkeR3h8GQ3caefufgRSW9nLT0L86uDmXi8ndVBASJyDsrSz232TjHBY96O9zY1hohG@vger.kernel.org
X-Gm-Message-State: AOJu0YzgO9UEW2g38gL6T4+IImjzdDbE8cfiUAoB7wFRxM1rLIWN4gyv
	GFzmMRn7/29lcY+YSRGysJ2Q7vlZ86wIT/CDRrGIgLCgCWp/FPNsw2dp54tTlsEPzUsV54nELH2
	pn4MYkS5ps+wApejCalneYel+NdnSnLI=
X-Google-Smtp-Source: AGHT+IF4/+n4/HUbYzvmzntYRGMqRLoTUquPBb05pAoL2nb4JIDivDwVJlZRViGR0xOD6wLtOHPmiqYRVXII1LbUhvo=
X-Received: by 2002:a05:6870:a188:b0:3d2:f6c1:1744 with SMTP id
 586e51a60fabf-3d5d9554f00mr1276006fac.28.1761654639396; Tue, 28 Oct 2025
 05:30:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028053136.692462-1-ankur.a.arora@oracle.com> <20251028053136.692462-8-ankur.a.arora@oracle.com>
In-Reply-To: <20251028053136.692462-8-ankur.a.arora@oracle.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 28 Oct 2025 13:30:28 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hSvzHfsE4nrEW-Ey0dnJ+m=dSU-f1RywGNU0Xyi3jXtQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmK2EK_uRWSBm9YaeD6TrkAr4FPkjdGF2gNL1N7yUrOkz2AUZHQBAURvQI
Message-ID: <CAJZ5v0hSvzHfsE4nrEW-Ey0dnJ+m=dSU-f1RywGNU0Xyi3jXtQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v7 7/7] cpuidle/poll_state: Poll via smp_cond_load_relaxed_timeout()
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	bpf@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org, 
	peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com, 
	harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org, 
	daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com, 
	xueshuai@linux.alibaba.com, joao.m.martins@oracle.com, 
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 6:32=E2=80=AFAM Ankur Arora <ankur.a.arora@oracle.c=
om> wrote:
>
> The inner loop in poll_idle() polls over the thread_info flags,
> waiting to see if the thread has TIF_NEED_RESCHED set. The loop
> exits once the condition is met, or if the poll time limit has
> been exceeded.
>
> To minimize the number of instructions executed in each iteration,
> the time check is done only intermittently (once every
> POLL_IDLE_RELAX_COUNT iterations). In addition, each loop iteration
> executes cpu_relax() which on certain platforms provides a hint to
> the pipeline that the loop busy-waits, allowing the processor to
> reduce power consumption.
>
> This is close to what smp_cond_load_relaxed_timeout() provides. So,
> restructure the loop and fold the loop condition and the timeout check
> in smp_cond_load_relaxed_timeout().

Well, it is close, but is it close enough?

> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  drivers/cpuidle/poll_state.c | 29 ++++++++---------------------
>  1 file changed, 8 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
> index 9b6d90a72601..dc7f4b424fec 100644
> --- a/drivers/cpuidle/poll_state.c
> +++ b/drivers/cpuidle/poll_state.c
> @@ -8,35 +8,22 @@
>  #include <linux/sched/clock.h>
>  #include <linux/sched/idle.h>
>
> -#define POLL_IDLE_RELAX_COUNT  200
> -
>  static int __cpuidle poll_idle(struct cpuidle_device *dev,
>                                struct cpuidle_driver *drv, int index)
>  {
> -       u64 time_start;
> -
> -       time_start =3D local_clock_noinstr();
> +       u64 time_end;
> +       u32 flags =3D 0;
>
>         dev->poll_time_limit =3D false;
>
> +       time_end =3D local_clock_noinstr() + cpuidle_poll_time(drv, dev);

Is there any particular reason for doing this unconditionally?  If
not, then it looks like an arbitrary unrelated change to me.

> +
>         raw_local_irq_enable();
>         if (!current_set_polling_and_test()) {
> -               unsigned int loop_count =3D 0;
> -               u64 limit;
> -
> -               limit =3D cpuidle_poll_time(drv, dev);
> -
> -               while (!need_resched()) {
> -                       cpu_relax();
> -                       if (loop_count++ < POLL_IDLE_RELAX_COUNT)
> -                               continue;
> -
> -                       loop_count =3D 0;
> -                       if (local_clock_noinstr() - time_start > limit) {
> -                               dev->poll_time_limit =3D true;
> -                               break;
> -                       }
> -               }
> +               flags =3D smp_cond_load_relaxed_timeout(&current_thread_i=
nfo()->flags,
> +                                                     (VAL & _TIF_NEED_RE=
SCHED),
> +                                                     (local_clock_noinst=
r() >=3D time_end));

So my understanding of this is that it reduces duplication with some
other places doing similar things.  Fair enough.

However, since there is "timeout" in the name, I'd expect it to take
the timeout as an argument.

> +               dev->poll_time_limit =3D !(flags & _TIF_NEED_RESCHED);
>         }
>         raw_local_irq_disable();
>
> --

