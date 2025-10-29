Return-Path: <linux-arch+bounces-14419-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D8CC1D346
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 21:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB7E94E10DB
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 20:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D13363344;
	Wed, 29 Oct 2025 20:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUcjl/s1"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F6635B121
	for <linux-arch@vger.kernel.org>; Wed, 29 Oct 2025 20:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761769810; cv=none; b=fz6X2F5PmpX+WKGquYrvdTZeIESvsOa58v/Ixy3N+KsvQzb74xtv7Lz2lmjl7+B3mpk9C/GLSTMs/vuKCeh+rQ/GrbRP1+6SsAip2Ou/ZoEVVvAKJKJmRLmtIQxqoHkoNTBCZELtYaZuZzwE0tJ7ptPqeSHoXyqlwUzDn/g0VUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761769810; c=relaxed/simple;
	bh=GOCTkUGLRQCwRuz7gY4C3QuQ/60lhuEdpy3XpjbsPDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YSowIMDYprvTxzPVB2XRD+a//Lf8k4XL9bfFaoMFz7WInAl2kMz/pMzXAqrfgYX/vGQCxLVTBnFkf773Dk09LMjpnuoQKtZ2DQ+NxBjkXqYZDeIKhjNY2NPkkPEUQSfRhFkRxXFIW0z8MqmiQiML8RS45G83fYeZlv/MScedkyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUcjl/s1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77478C113D0
	for <linux-arch@vger.kernel.org>; Wed, 29 Oct 2025 20:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761769810;
	bh=GOCTkUGLRQCwRuz7gY4C3QuQ/60lhuEdpy3XpjbsPDQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PUcjl/s14mLr6JgLAvYAvnZgA6MqBs8Iu7CBSaEqJBFaJx5B6bXJEoTEgxFWy7Oud
	 7+cSqpzXRI8wiFSCkhg1+Kif0wI/OF7CPgiTw+kV0PD782paa60U0Aq3e2QXjeJWbI
	 t7JdgaY6JEFIv3c5Qg/bNWHeiDjIWotZR1+uiUsl7hDC3cmiRnF7eRMajhYuJUlC/u
	 Mwkc36rVb39Pqew94b7dYa+T4DadHlUrk33A2UF1TkD5/+tf8r3kALKb3T6NXCU6O7
	 o3gfNe4ryokwsPaOU8zxy/qUQN3UGMrhLwolHNQIsyPUmR0s2QjZRAF1tdhrSikFd/
	 /OuxUfSd3yPUQ==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-65363319bacso131869eaf.2
        for <linux-arch@vger.kernel.org>; Wed, 29 Oct 2025 13:30:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV2/dcQq9Kr0WV6lOXr1yXL7AMzrVCghkfDekOh9FdwD0Zg7K0dV7P/ILOIi8FB+cC9hJPidlHDy8E9@vger.kernel.org
X-Gm-Message-State: AOJu0YwR3CEKLNmcAevMeNuAhvE337q1R4Aq8hThTp5Dpe8OIzvwypyf
	746RkCvEwux+WG+jdqyVlVP57U3BF/TzPQ9wlo6P56aAkdRHcJWLIyBfs0YN1HFXFsp4jnSO7so
	K+kfgZinZipE1EadeaaiNYBNlrSSPDTI=
X-Google-Smtp-Source: AGHT+IHW5uDP7MsolaMgn8jVjNqIsXYfFdWF7n+vPR5mI6Oev9ZYaWWAWl38Nzs+ZKhKkYITN6nyOLzYlFHqUlA5Z1k=
X-Received: by 2002:a05:6820:2207:b0:654:eb8d:a91 with SMTP id
 006d021491bc7-65682418834mr281105eaf.8.1761769809367; Wed, 29 Oct 2025
 13:30:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028053136.692462-1-ankur.a.arora@oracle.com>
 <20251028053136.692462-8-ankur.a.arora@oracle.com> <CAJZ5v0hSvzHfsE4nrEW-Ey0dnJ+m=dSU-f1RywGNU0Xyi3jXtQ@mail.gmail.com>
 <87ms5ajp4c.fsf@oracle.com> <CAJZ5v0hQ7G9jvOv9VtRmsCKahBpUcPJMMOe07k_2mqsvggWcWg@mail.gmail.com>
 <874irhjzcf.fsf@oracle.com>
In-Reply-To: <874irhjzcf.fsf@oracle.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 29 Oct 2025 21:29:58 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i5-8eO6T_-Sr-K=3Up89+_qtJW7NSjDknJSkk3Nhu8BQ@mail.gmail.com>
X-Gm-Features: AWmQ_bk-kPvfwcU7JMvzIW3LgFhb5fas4TUCYzr6Ntlxek5O_3tqCEg-J-2w8JI
Message-ID: <CAJZ5v0i5-8eO6T_-Sr-K=3Up89+_qtJW7NSjDknJSkk3Nhu8BQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v7 7/7] cpuidle/poll_state: Poll via smp_cond_load_relaxed_timeout()
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, bpf@vger.kernel.org, arnd@arndb.de, 
	catalin.marinas@arm.com, will@kernel.org, peterz@infradead.org, 
	akpm@linux-foundation.org, mark.rutland@arm.com, harisokn@amazon.com, 
	cl@gentwo.org, ast@kernel.org, daniel.lezcano@linaro.org, memxor@gmail.com, 
	zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com, 
	joao.m.martins@oracle.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 8:13=E2=80=AFPM Ankur Arora <ankur.a.arora@oracle.c=
om> wrote:
>
>
> Rafael J. Wysocki <rafael@kernel.org> writes:
>
> > On Wed, Oct 29, 2025 at 5:42=E2=80=AFAM Ankur Arora <ankur.a.arora@orac=
le.com> wrote:
> >>
> >>
> >> Rafael J. Wysocki <rafael@kernel.org> writes:
> >>
> >> > On Tue, Oct 28, 2025 at 6:32=E2=80=AFAM Ankur Arora <ankur.a.arora@o=
racle.com> wrote:
> >> >>
> >> >> The inner loop in poll_idle() polls over the thread_info flags,
> >> >> waiting to see if the thread has TIF_NEED_RESCHED set. The loop
> >> >> exits once the condition is met, or if the poll time limit has
> >> >> been exceeded.
> >> >>
> >> >> To minimize the number of instructions executed in each iteration,
> >> >> the time check is done only intermittently (once every
> >> >> POLL_IDLE_RELAX_COUNT iterations). In addition, each loop iteration
> >> >> executes cpu_relax() which on certain platforms provides a hint to
> >> >> the pipeline that the loop busy-waits, allowing the processor to
> >> >> reduce power consumption.
> >> >>
> >> >> This is close to what smp_cond_load_relaxed_timeout() provides. So,
> >> >> restructure the loop and fold the loop condition and the timeout ch=
eck
> >> >> in smp_cond_load_relaxed_timeout().
> >> >
> >> > Well, it is close, but is it close enough?
> >>
> >> I guess that's the question.
> >>
> >> >> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> >> >> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> >> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> >> >> ---
> >> >>  drivers/cpuidle/poll_state.c | 29 ++++++++---------------------
> >> >>  1 file changed, 8 insertions(+), 21 deletions(-)
> >> >>
> >> >> diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_st=
ate.c
> >> >> index 9b6d90a72601..dc7f4b424fec 100644
> >> >> --- a/drivers/cpuidle/poll_state.c
> >> >> +++ b/drivers/cpuidle/poll_state.c
> >> >> @@ -8,35 +8,22 @@
> >> >>  #include <linux/sched/clock.h>
> >> >>  #include <linux/sched/idle.h>
> >> >>
> >> >> -#define POLL_IDLE_RELAX_COUNT  200
> >> >> -
> >> >>  static int __cpuidle poll_idle(struct cpuidle_device *dev,
> >> >>                                struct cpuidle_driver *drv, int inde=
x)
> >> >>  {
> >> >> -       u64 time_start;
> >> >> -
> >> >> -       time_start =3D local_clock_noinstr();
> >> >> +       u64 time_end;
> >> >> +       u32 flags =3D 0;
> >> >>
> >> >>         dev->poll_time_limit =3D false;
> >> >>
> >> >> +       time_end =3D local_clock_noinstr() + cpuidle_poll_time(drv,=
 dev);
> >> >
> >> > Is there any particular reason for doing this unconditionally?  If
> >> > not, then it looks like an arbitrary unrelated change to me.
> >>
> >> Agreed. Will fix.
> >>
> >> >> +
> >> >>         raw_local_irq_enable();
> >> >>         if (!current_set_polling_and_test()) {
> >> >> -               unsigned int loop_count =3D 0;
> >> >> -               u64 limit;
> >> >> -
> >> >> -               limit =3D cpuidle_poll_time(drv, dev);
> >> >> -
> >> >> -               while (!need_resched()) {
> >> >> -                       cpu_relax();
> >> >> -                       if (loop_count++ < POLL_IDLE_RELAX_COUNT)
> >> >> -                               continue;
> >> >> -
> >> >> -                       loop_count =3D 0;
> >> >> -                       if (local_clock_noinstr() - time_start > li=
mit) {
> >> >> -                               dev->poll_time_limit =3D true;
> >> >> -                               break;
> >> >> -                       }
> >> >> -               }
> >> >> +               flags =3D smp_cond_load_relaxed_timeout(&current_th=
read_info()->flags,
> >> >> +                                                     (VAL & _TIF_N=
EED_RESCHED),
> >> >> +                                                     (local_clock_=
noinstr() >=3D time_end));
> >> >
> >> > So my understanding of this is that it reduces duplication with some
> >> > other places doing similar things.  Fair enough.
> >> >
> >> > However, since there is "timeout" in the name, I'd expect it to take
> >> > the timeout as an argument.
> >>
> >> The early versions did have a timeout but that complicated the
> >> implementation significantly. And the current users poll_idle(),
> >> rqspinlock don't need a precise timeout.
> >>
> >> smp_cond_load_relaxed_timed(), smp_cond_load_relaxed_timecheck()?
> >>
> >> The problem with all suffixes I can think of is that it makes the
> >> interface itself nonobvious.
> >>
> >> Possibly something with the sense of bail out might work.
> >
> > It basically has two conditions, one of which is checked in every step
> > of the internal loop and the other one is checked every
> > SMP_TIMEOUT_POLL_COUNT steps of it.  That isn't particularly
> > straightforward IMV.
>
> Right. And that's similar to what poll_idle().

My point is that the macro in its current form is not particularly
straightforward.

The code in poll_idle() does what it needs to do.

> > Honestly, I prefer the existing code.  It is much easier to follow and
> > I don't see why the new code would be better.  Sorry.
>
> I don't think there's any problem with the current code. However, I'd lik=
e
> to add support for poll_idle() on arm64 (and maybe other platforms) where
> instead of spinning in a cpu_relax() loop, you wait on a cacheline.

Well, there is MWAIT on x86, but it is not used here.  It just takes
too much time to wake up from.  There are "fast" variants of that too,
but they have been designed with user space in mind, so somewhat
cumbersome for kernel use.

> And that's what using something like smp_cond_load_relaxed_timeout()
> would enable.
>
> Something like the series here:
>   https://lore.kernel.org/lkml/87wmaljd81.fsf@oracle.com/
>
> (Sorry, should have mentioned this in the commit message.)

I'm not sure how you can combine that with a proper timeout.  The
timeout is needed because you want to break out of this when it starts
to take too much time, so you can go back to the idle loop and maybe
select a better idle state.

