Return-Path: <linux-arch+bounces-14505-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB300C3284D
	for <lists+linux-arch@lfdr.de>; Tue, 04 Nov 2025 19:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F8DC42810B
	for <lists+linux-arch@lfdr.de>; Tue,  4 Nov 2025 18:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1D133DEE9;
	Tue,  4 Nov 2025 18:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJrL8B9V"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF6933BBA0
	for <linux-arch@vger.kernel.org>; Tue,  4 Nov 2025 18:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279689; cv=none; b=pBMCH7gsqxQBChLKOok5UwXEd16p9DlfeYzXrRorTUPBtCVXri8wPrOx7sjiPwHFoKoBy4nbMlvn9GsXJH47XUH7sw0Fo8g1ISAjHEhSU+QUDmGylfybmZE2P/wxKoD0GVe9lOwQy2s6zOm2o5Um4lVEja7BEgZIPShcIrmVU9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279689; c=relaxed/simple;
	bh=H+B0qEVhv/M/Hrjk3KWB9ja4t4CC1iXUb3hu7bcvErk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TEoeKm8q6z9OEBXIf9uR6RmER6b7fAsg3L0RTUb2uFCwN4ab72NoYlybAsRM1tWywej+w6Uy84PC3vnsmE4tbtoPt9Q93jfHWY2adVsqqXsCP2Q1hN1SbFTNExfyYXwux3tQGq1ySlOYlVYQRfkZpZRVfTBjm9y8mPmOnpEhBgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJrL8B9V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D24C2BCB4
	for <linux-arch@vger.kernel.org>; Tue,  4 Nov 2025 18:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762279688;
	bh=H+B0qEVhv/M/Hrjk3KWB9ja4t4CC1iXUb3hu7bcvErk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KJrL8B9VsSLFRaN5Nv1r2sEA54BPIO+ykvVUGuuC08YenM2w7o8J20Ceh7r/NCmzj
	 s+/VQhStBW6h0154jcj66OvTOKzoTYmHA4KoQHqhpkqymuqUgSzhPOFK428T7rF5rZ
	 CM6CIC9CIRUaqwmp3Lf//Y4xAZARt4PPzAXnFBh1okMmZcTGMpRiR8hkrEdk8xS4VD
	 i0UT0nODeY+9zE3P1Di1G8dOh73jcDZFxvRwDSydikmuYS/0GmWGDUJarf2amWYZWy
	 3VqVc0kiCG6KaSsXelDoTIeuK9tK5oc0hNTIEeDA6CWKO75wyt5WOIX1UdYmfrRCj1
	 gSWTA4WPA4vVw==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-44fe4ba1c1bso240240b6e.2
        for <linux-arch@vger.kernel.org>; Tue, 04 Nov 2025 10:08:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWmH+W0O1FLy1sqlHnxYFT3R31lImT9ToCQqVKDpeTNMjyZE4nj6YSlXnJNAt1WzAcUar2BCxEI24V9@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn8M1IWta+BhEGyGMnRL7Qd5B6zZQePO4H6/ete5dlUJDS9/pD
	UfqCeSudeYUQkP29YV17wL2KZPVvgqO30I9JHmPwN9Ql1Xz7F4/NWI2fNDTTC8WqLFH3/jEMApF
	euRGd231vj00zXM0hnptXQDnaGK5CR6g=
X-Google-Smtp-Source: AGHT+IHrSDGsNm50EjcF44D9MNFIEETayiGYgQQjLT67U0YPEVK8ag1wTkiiHIa/UUFfTk6ozb0F0TfYt8pNd0QYGzw=
X-Received: by 2002:a05:6808:c146:b0:44d:ba5b:ad34 with SMTP id
 5614622812f47-44fed503d77mr152270b6e.65.1762279687546; Tue, 04 Nov 2025
 10:08:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028053136.692462-1-ankur.a.arora@oracle.com>
 <20251028053136.692462-8-ankur.a.arora@oracle.com> <CAJZ5v0hSvzHfsE4nrEW-Ey0dnJ+m=dSU-f1RywGNU0Xyi3jXtQ@mail.gmail.com>
 <87ms5ajp4c.fsf@oracle.com> <CAJZ5v0hQ7G9jvOv9VtRmsCKahBpUcPJMMOe07k_2mqsvggWcWg@mail.gmail.com>
 <874irhjzcf.fsf@oracle.com> <CAJZ5v0i5-8eO6T_-Sr-K=3Up89+_qtJW7NSjDknJSkk3Nhu8BQ@mail.gmail.com>
 <875xbxifs0.fsf@oracle.com>
In-Reply-To: <875xbxifs0.fsf@oracle.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 4 Nov 2025 19:07:56 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0izSBR0_DeH5HVnSLFGRfV9WoSzbu9Mh5yvvuyrvw7fLg@mail.gmail.com>
X-Gm-Features: AWmQ_bntcfH83903HLZKfZK6BYsGABjvLPwboKVkSn1BQkd0aPOXL15UK_L4_Us
Message-ID: <CAJZ5v0izSBR0_DeH5HVnSLFGRfV9WoSzbu9Mh5yvvuyrvw7fLg@mail.gmail.com>
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

On Wed, Oct 29, 2025 at 10:01=E2=80=AFPM Ankur Arora <ankur.a.arora@oracle.=
com> wrote:
>
>
> Rafael J. Wysocki <rafael@kernel.org> writes:
>
> > On Wed, Oct 29, 2025 at 8:13=E2=80=AFPM Ankur Arora <ankur.a.arora@orac=
le.com> wrote:
> >>
> >>
> >> Rafael J. Wysocki <rafael@kernel.org> writes:
> >>
> >> > On Wed, Oct 29, 2025 at 5:42=E2=80=AFAM Ankur Arora <ankur.a.arora@o=
racle.com> wrote:
> >> >>
> >> >>
> >> >> Rafael J. Wysocki <rafael@kernel.org> writes:
> >> >>
> >> >> > On Tue, Oct 28, 2025 at 6:32=E2=80=AFAM Ankur Arora <ankur.a.aror=
a@oracle.com> wrote:
> >> >> >>
> >> >> >> The inner loop in poll_idle() polls over the thread_info flags,
> >> >> >> waiting to see if the thread has TIF_NEED_RESCHED set. The loop
> >> >> >> exits once the condition is met, or if the poll time limit has
> >> >> >> been exceeded.
> >> >> >>
> >> >> >> To minimize the number of instructions executed in each iteratio=
n,
> >> >> >> the time check is done only intermittently (once every
> >> >> >> POLL_IDLE_RELAX_COUNT iterations). In addition, each loop iterat=
ion
> >> >> >> executes cpu_relax() which on certain platforms provides a hint =
to
> >> >> >> the pipeline that the loop busy-waits, allowing the processor to
> >> >> >> reduce power consumption.
> >> >> >>
> >> >> >> This is close to what smp_cond_load_relaxed_timeout() provides. =
So,
> >> >> >> restructure the loop and fold the loop condition and the timeout=
 check
> >> >> >> in smp_cond_load_relaxed_timeout().
> >> >> >
> >> >> > Well, it is close, but is it close enough?
> >> >>
> >> >> I guess that's the question.
> >> >>
> >> >> >> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> >> >> >> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> >> >> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> >> >> >> ---
> >> >> >>  drivers/cpuidle/poll_state.c | 29 ++++++++---------------------
> >> >> >>  1 file changed, 8 insertions(+), 21 deletions(-)
> >> >> >>
> >> >> >> diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll=
_state.c
> >> >> >> index 9b6d90a72601..dc7f4b424fec 100644
> >> >> >> --- a/drivers/cpuidle/poll_state.c
> >> >> >> +++ b/drivers/cpuidle/poll_state.c
> >> >> >> @@ -8,35 +8,22 @@
> >> >> >>  #include <linux/sched/clock.h>
> >> >> >>  #include <linux/sched/idle.h>
> >> >> >>
> >> >> >> -#define POLL_IDLE_RELAX_COUNT  200
> >> >> >> -
> >> >> >>  static int __cpuidle poll_idle(struct cpuidle_device *dev,
> >> >> >>                                struct cpuidle_driver *drv, int i=
ndex)
> >> >> >>  {
> >> >> >> -       u64 time_start;
> >> >> >> -
> >> >> >> -       time_start =3D local_clock_noinstr();
> >> >> >> +       u64 time_end;
> >> >> >> +       u32 flags =3D 0;
> >> >> >>
> >> >> >>         dev->poll_time_limit =3D false;
> >> >> >>
> >> >> >> +       time_end =3D local_clock_noinstr() + cpuidle_poll_time(d=
rv, dev);
> >> >> >
> >> >> > Is there any particular reason for doing this unconditionally?  I=
f
> >> >> > not, then it looks like an arbitrary unrelated change to me.
> >> >>
> >> >> Agreed. Will fix.
> >> >>
> >> >> >> +
> >> >> >>         raw_local_irq_enable();
> >> >> >>         if (!current_set_polling_and_test()) {
> >> >> >> -               unsigned int loop_count =3D 0;
> >> >> >> -               u64 limit;
> >> >> >> -
> >> >> >> -               limit =3D cpuidle_poll_time(drv, dev);
> >> >> >> -
> >> >> >> -               while (!need_resched()) {
> >> >> >> -                       cpu_relax();
> >> >> >> -                       if (loop_count++ < POLL_IDLE_RELAX_COUNT=
)
> >> >> >> -                               continue;
> >> >> >> -
> >> >> >> -                       loop_count =3D 0;
> >> >> >> -                       if (local_clock_noinstr() - time_start >=
 limit) {
> >> >> >> -                               dev->poll_time_limit =3D true;
> >> >> >> -                               break;
> >> >> >> -                       }
> >> >> >> -               }
> >> >> >> +               flags =3D smp_cond_load_relaxed_timeout(&current=
_thread_info()->flags,
> >> >> >> +                                                     (VAL & _TI=
F_NEED_RESCHED),
> >> >> >> +                                                     (local_clo=
ck_noinstr() >=3D time_end));
> >> >> >
> >> >> > So my understanding of this is that it reduces duplication with s=
ome
> >> >> > other places doing similar things.  Fair enough.
> >> >> >
> >> >> > However, since there is "timeout" in the name, I'd expect it to t=
ake
> >> >> > the timeout as an argument.
> >> >>
> >> >> The early versions did have a timeout but that complicated the
> >> >> implementation significantly. And the current users poll_idle(),
> >> >> rqspinlock don't need a precise timeout.
> >> >>
> >> >> smp_cond_load_relaxed_timed(), smp_cond_load_relaxed_timecheck()?
> >> >>
> >> >> The problem with all suffixes I can think of is that it makes the
> >> >> interface itself nonobvious.
> >> >>
> >> >> Possibly something with the sense of bail out might work.
> >> >
> >> > It basically has two conditions, one of which is checked in every st=
ep
> >> > of the internal loop and the other one is checked every
> >> > SMP_TIMEOUT_POLL_COUNT steps of it.  That isn't particularly
> >> > straightforward IMV.
> >>
> >> Right. And that's similar to what poll_idle().
> >
> > My point is that the macro in its current form is not particularly
> > straightforward.
> >
> > The code in poll_idle() does what it needs to do.
> >
> >> > Honestly, I prefer the existing code.  It is much easier to follow a=
nd
> >> > I don't see why the new code would be better.  Sorry.
> >>
> >> I don't think there's any problem with the current code. However, I'd =
like
> >> to add support for poll_idle() on arm64 (and maybe other platforms) wh=
ere
> >> instead of spinning in a cpu_relax() loop, you wait on a cacheline.
> >
> > Well, there is MWAIT on x86, but it is not used here.  It just takes
> > too much time to wake up from.  There are "fast" variants of that too,
> > but they have been designed with user space in mind, so somewhat
> > cumbersome for kernel use.
> >
> >> And that's what using something like smp_cond_load_relaxed_timeout()
> >> would enable.
> >>
> >> Something like the series here:
> >>   https://lore.kernel.org/lkml/87wmaljd81.fsf@oracle.com/
> >>
> >> (Sorry, should have mentioned this in the commit message.)
> >
> > I'm not sure how you can combine that with a proper timeout.
>
> Would taking the timeout as a separate argument work?
>
>   flags =3D smp_cond_load_relaxed_timeout(&current_thread_info()->flags,
>                                          (VAL & _TIF_NEED_RESCHED),
>                                          local_clock_noinstr(), time_end)=
;
>
> Or you are thinking of something on different lines from the smp_cond_loa=
d
> kind of interface?

I would like it to be something along the lines of

arch_busy_wait_for_need_resched(time_limit);
dev->poll_time_limit =3D !need_resched();

and I don't care much about how exactly this is done in the arch code,
so long as it does what it says.

> > The timeout is needed because you want to break out of this when it sta=
rts
> > to take too much time, so you can go back to the idle loop and maybe
> > select a better idle state.
>
> Agreed. And that will happen with the version in the patch:
>
>      flags =3D smp_cond_load_relaxed_timeout(&current_thread_info()->flag=
s,
>                                             (VAL & _TIF_NEED_RESCHED),
>                                             (local_clock_noinstr() >=3D t=
ime_end));
>
> Just that with waited mode on arm64 the timeout might be delayed dependin=
g
> on granularity of the event stream.

That's fine.  cpuidle_poll_time() is not exact anyway.

