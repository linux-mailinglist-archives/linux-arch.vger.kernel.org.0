Return-Path: <linux-arch+bounces-14416-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC163C1CD51
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 19:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1427188D357
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 18:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B44357716;
	Wed, 29 Oct 2025 18:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="om5GOMGN"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5D93563E2
	for <linux-arch@vger.kernel.org>; Wed, 29 Oct 2025 18:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761763995; cv=none; b=DMjcp2fbWImIie0pY4MVpZyAJdIcoWMPqiRd2dmnqnvNDaoSEgjVBzwIbXHBBx3PRFxrL6sn/Peql29667jEkzVtpWnmyH4aSeJPnK3RTBq+2UyD7k/+bh1t3iXq///Abs3i+YUkFJSbj5Dpiwn1G/MgD5UHmGmgptct6uhZig0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761763995; c=relaxed/simple;
	bh=P1fpBKLpz3NhAHV8OSXmDOMSQKs45JoWLRgxhe1ZXi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pNuMRP3/9nlH6rrn+5AbfJI6n0upBe4soL9D0PXcy7YreZ5bUef6Fhy9bOcXd7tgdbF82MJnMatstKOMpsQQZunuvml38sfgioe3rkxgXaiduTf+23W7Yz6hs/chLcmXi1jhlpvm7I1Wuhn7ZEXfVu52LVPZezt+hUvHxn+787Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=om5GOMGN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6D9C4CEFF
	for <linux-arch@vger.kernel.org>; Wed, 29 Oct 2025 18:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761763995;
	bh=P1fpBKLpz3NhAHV8OSXmDOMSQKs45JoWLRgxhe1ZXi0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=om5GOMGN4jz2H6VEosyifBY2fP9P2ZUxOzCaRZL+HWT0ktMU1vscRxWze4AnqmN8g
	 U1PMJjoZkfd0gW1nqZKC/4AS3EJyhpT1K5fqsr9qPURuI6TSh5IKlZMIDmFkrfz2io
	 lKsCwZumZaNJ+iVnccVNxAso/e1ludjC5D8+WgjeoXlSbcosCg+xn0eoC3C9uegr/y
	 k4Hwo6K7QY68O8So1EonT0CeW5fABtEVwMaIi7LO9LkOh31l//qWPkMSV4jaZ6wOEQ
	 CvAoxXEZwRlB4ud0b57tRWmXsQWCKq7c2kOIMG8Lzh9SQkguTQDCgf/u2KUV7ZENpw
	 McpI/YV3EyWQQ==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7c53f916ef1so43312a34.1
        for <linux-arch@vger.kernel.org>; Wed, 29 Oct 2025 11:53:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV6wT7fKP5t7zDEni4ebCclvUKGrCUjObRemp2qnH0K/h7fwlrya9HA54wwsdp2iqNJLBuIIesDMKpK@vger.kernel.org
X-Gm-Message-State: AOJu0YwWjTpvDkG5SrqKev1vZR+jeLyOrjuVsMTvbF4OYA1xL86xzFjQ
	2oJmE5PYxg9bTMh6Uuza/u1Gl+JuWEIEZtknZXQ5pArRFVR5yyZzzUy9QgDZmRvBIFDR68KG6dK
	1DNY40jI1ffy6xKm4Rh1Bq9tGAxOXrg4=
X-Google-Smtp-Source: AGHT+IHqLr30NAl5M0UDPxgOiX509nO1xreEttv2Ja7V2VTnyLfOfv1uaRlgWgHZXMApbjkmBIuGTq5OSxr3Ncgi/MM=
X-Received: by 2002:a05:6808:148c:b0:441:cf96:934f with SMTP id
 5614622812f47-44f7a89144cmr1770625b6e.47.1761763994437; Wed, 29 Oct 2025
 11:53:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028053136.692462-1-ankur.a.arora@oracle.com>
 <20251028053136.692462-8-ankur.a.arora@oracle.com> <CAJZ5v0hSvzHfsE4nrEW-Ey0dnJ+m=dSU-f1RywGNU0Xyi3jXtQ@mail.gmail.com>
 <87ms5ajp4c.fsf@oracle.com>
In-Reply-To: <87ms5ajp4c.fsf@oracle.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 29 Oct 2025 19:53:03 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hQ7G9jvOv9VtRmsCKahBpUcPJMMOe07k_2mqsvggWcWg@mail.gmail.com>
X-Gm-Features: AWmQ_bk7-QDWwa1cDV85f7xAgSvOSsXB0uuTzMcOx_--MTMmqkafGtIfA3jK8No
Message-ID: <CAJZ5v0hQ7G9jvOv9VtRmsCKahBpUcPJMMOe07k_2mqsvggWcWg@mail.gmail.com>
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

On Wed, Oct 29, 2025 at 5:42=E2=80=AFAM Ankur Arora <ankur.a.arora@oracle.c=
om> wrote:
>
>
> Rafael J. Wysocki <rafael@kernel.org> writes:
>
> > On Tue, Oct 28, 2025 at 6:32=E2=80=AFAM Ankur Arora <ankur.a.arora@orac=
le.com> wrote:
> >>
> >> The inner loop in poll_idle() polls over the thread_info flags,
> >> waiting to see if the thread has TIF_NEED_RESCHED set. The loop
> >> exits once the condition is met, or if the poll time limit has
> >> been exceeded.
> >>
> >> To minimize the number of instructions executed in each iteration,
> >> the time check is done only intermittently (once every
> >> POLL_IDLE_RELAX_COUNT iterations). In addition, each loop iteration
> >> executes cpu_relax() which on certain platforms provides a hint to
> >> the pipeline that the loop busy-waits, allowing the processor to
> >> reduce power consumption.
> >>
> >> This is close to what smp_cond_load_relaxed_timeout() provides. So,
> >> restructure the loop and fold the loop condition and the timeout check
> >> in smp_cond_load_relaxed_timeout().
> >
> > Well, it is close, but is it close enough?
>
> I guess that's the question.
>
> >> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> >> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> >> ---
> >>  drivers/cpuidle/poll_state.c | 29 ++++++++---------------------
> >>  1 file changed, 8 insertions(+), 21 deletions(-)
> >>
> >> diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state=
.c
> >> index 9b6d90a72601..dc7f4b424fec 100644
> >> --- a/drivers/cpuidle/poll_state.c
> >> +++ b/drivers/cpuidle/poll_state.c
> >> @@ -8,35 +8,22 @@
> >>  #include <linux/sched/clock.h>
> >>  #include <linux/sched/idle.h>
> >>
> >> -#define POLL_IDLE_RELAX_COUNT  200
> >> -
> >>  static int __cpuidle poll_idle(struct cpuidle_device *dev,
> >>                                struct cpuidle_driver *drv, int index)
> >>  {
> >> -       u64 time_start;
> >> -
> >> -       time_start =3D local_clock_noinstr();
> >> +       u64 time_end;
> >> +       u32 flags =3D 0;
> >>
> >>         dev->poll_time_limit =3D false;
> >>
> >> +       time_end =3D local_clock_noinstr() + cpuidle_poll_time(drv, de=
v);
> >
> > Is there any particular reason for doing this unconditionally?  If
> > not, then it looks like an arbitrary unrelated change to me.
>
> Agreed. Will fix.
>
> >> +
> >>         raw_local_irq_enable();
> >>         if (!current_set_polling_and_test()) {
> >> -               unsigned int loop_count =3D 0;
> >> -               u64 limit;
> >> -
> >> -               limit =3D cpuidle_poll_time(drv, dev);
> >> -
> >> -               while (!need_resched()) {
> >> -                       cpu_relax();
> >> -                       if (loop_count++ < POLL_IDLE_RELAX_COUNT)
> >> -                               continue;
> >> -
> >> -                       loop_count =3D 0;
> >> -                       if (local_clock_noinstr() - time_start > limit=
) {
> >> -                               dev->poll_time_limit =3D true;
> >> -                               break;
> >> -                       }
> >> -               }
> >> +               flags =3D smp_cond_load_relaxed_timeout(&current_threa=
d_info()->flags,
> >> +                                                     (VAL & _TIF_NEED=
_RESCHED),
> >> +                                                     (local_clock_noi=
nstr() >=3D time_end));
> >
> > So my understanding of this is that it reduces duplication with some
> > other places doing similar things.  Fair enough.
> >
> > However, since there is "timeout" in the name, I'd expect it to take
> > the timeout as an argument.
>
> The early versions did have a timeout but that complicated the
> implementation significantly. And the current users poll_idle(),
> rqspinlock don't need a precise timeout.
>
> smp_cond_load_relaxed_timed(), smp_cond_load_relaxed_timecheck()?
>
> The problem with all suffixes I can think of is that it makes the
> interface itself nonobvious.
>
> Possibly something with the sense of bail out might work.

It basically has two conditions, one of which is checked in every step
of the internal loop and the other one is checked every
SMP_TIMEOUT_POLL_COUNT steps of it.  That isn't particularly
straightforward IMV.

Honestly, I prefer the existing code.  It is much easier to follow and
I don't see why the new code would be better.  Sorry.

