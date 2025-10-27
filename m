Return-Path: <linux-arch+bounces-14355-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDF0C0D30B
	for <lists+linux-arch@lfdr.de>; Mon, 27 Oct 2025 12:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 230204F6D73
	for <lists+linux-arch@lfdr.de>; Mon, 27 Oct 2025 11:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2B52FB975;
	Mon, 27 Oct 2025 11:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KajU9McI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FWjsy/Tj"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654C42F616B;
	Mon, 27 Oct 2025 11:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565108; cv=none; b=uBZEdgZpvBL+ZfkTZMLYifQ5GaTC4c+b3VbP7nBo0sQc3T5kSHVVdk7QbWyrAMBqpXGieZy6dTSViJNL8QWqPDCcZBN1KK6KnEzoPxHhUSPfAswqVtYkgLn5fHy1EyXguihEW2BnUyOjmsVcEazJylCLa413L1GYxNXnRLiAUz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565108; c=relaxed/simple;
	bh=KvL+uV3iWyurp+bVzQ4UyxpumwZNPH49D0WWiQ1ruek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7Fla04VZdYr4EUEhug4xVbeKlYaChIhCbSgTWAqtErekz0SJYfeto0KdTr7wmusX3Q0rHwulmspZWQL50qJaOHsZlqUWCT1GEqU+GCexuWpGPGSPVvy9muN1oDGka5gnpOpK3pmPBucRKxVmGKFwNDqPckr/3vkobxqA4GXMi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KajU9McI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FWjsy/Tj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Oct 2025 12:38:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761565104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CyDCdbZCWNxZAe7jFXv4qLbIRYvVEmusggw5T1qlrEM=;
	b=KajU9McIk08xoVzDH4XUWoxbeHgMaUQOcL3mfIlufbpaNl7EYs9eZk88TvMmFcGrCFW8fj
	PP80w090WrVmro/amgWsecr02abj68pxqH9oOmrmsg5fP83fqPn3VjAq7Zr5DFEr0oFDll
	Jq9r388VDXVH2DYdp39Oqm6C2vxwOGnJnaC6IcmEczm7tzzwsMkWrnJEVx2JX9riA113rO
	q7C75aXzuDOVFTymSFr8zs7oaTVaTLPHmpPt4p7WMZrYKNlWRXaPbV0/0mIESpa+ljoxEp
	bKf7TAAPkmgve5wzI8QZlidr97A7Jl6ctjevq6BVSPuDgCYiUcRUtRQL2ZY9yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761565104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CyDCdbZCWNxZAe7jFXv4qLbIRYvVEmusggw5T1qlrEM=;
	b=FWjsy/TjO6bSSl27ggYmR80mfoxA/AFkBdYS+aTdYXPOISDHz6nZc6JckiezcZfry4fUlI
	1rLiMtisiG8tt/DA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Prakash Sangappa <prakash.sangappa@oracle.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Steven Rostedt <rostedt@goodmis.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org
Subject: Re: [patch V2 08/12] rseq: Implement time slice extension
 enforcement timer
Message-ID: <20251027113822.UfDZz0mf@linutronix.de>
References: <20251022110646.839870156@linutronix.de>
 <20251022121427.406689298@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20251022121427.406689298@linutronix.de>

On 2025-10-22 14:57:38 [+0200], Thomas Gleixner wrote:
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -500,8 +502,82 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
>  }
> =20
>  #ifdef CONFIG_RSEQ_SLICE_EXTENSION
> +struct slice_timer {
> +	struct hrtimer	timer;
> +	void		*cookie;
> +};
> +
> +unsigned int rseq_slice_ext_nsecs __read_mostly =3D 30 * NSEC_PER_USEC;
> +static DEFINE_PER_CPU(struct slice_timer, slice_timer);
>  DEFINE_STATIC_KEY_TRUE(rseq_slice_extension_key);
> =20
> +static enum hrtimer_restart rseq_slice_expired(struct hrtimer *tmr)
> +{
> +	struct slice_timer *st =3D container_of(tmr, struct slice_timer, timer);
> +
> +	if (st->cookie =3D=3D current && current->rseq.slice.state.granted) {
> +		rseq_stat_inc(rseq_stats.s_expired);
> +		set_need_resched_current();
> +	}

You arm the timer while leaving to userland. Once in userland the task
can be migrated to another CPU. Once migrated, this CPU can host another
task while the timer fires and does nothing.

> +	return HRTIMER_NORESTART;
> +}
> +
=E2=80=A6
> +static void rseq_cancel_slice_extension_timer(void)
> +{
> +	struct slice_timer *st =3D this_cpu_ptr(&slice_timer);
> +
> +	/*
> +	 * st->cookie can be safely read as preemption is disabled and the
> +	 * timer is CPU local. The active check can obviously race with the
> +	 * hrtimer interrupt, but that's better than disabling interrupts
> +	 * unconditionally right away.
> +	 *
> +	 * As this is most probably the first expiring timer, the cancel is
> +	 * expensive as it has to reprogram the hardware, but that's less
> +	 * expensive than going through a full hrtimer_interrupt() cycle
> +	 * for nothing.
> +	 *
> +	 * hrtimer_try_to_cancel() is sufficient here as with interrupts
> +	 * disabled the timer callback cannot be running and the timer base
> +	 * is well determined as the timer is pinned on the local CPU.
> +	 */
> +	if (st->cookie =3D=3D current && hrtimer_active(&st->timer)) {
> +		scoped_guard(irq)
> +			hrtimer_try_to_cancel(&st->timer);

I don't see why hrtimer_active() and IRQ-disable is a benefit here.
Unless you want to avoid a branch to hrtimer_try_to_cancel().

The function has its own hrtimer_active() check and disables interrupts
while accessing the hrtimer_base lock. Since preemption is disabled,
st->cookie remains stable.
It can fire right after the hrtimer_active() here. You could just

	if (st->cookie =3D=3D current)
		hrtimer_try_to_cancel(&st->timer);

at the expense of a branch to hrtimer_try_to_cancel() if the timer
already expired (no interrupts off/on).

> +}
> +
>  static inline void rseq_slice_set_need_resched(struct task_struct *curr)
>  {
>  	/*
> @@ -654,6 +731,31 @@ SYSCALL_DEFINE0(rseq_slice_yield)
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_SYSCTL
> +static const unsigned int rseq_slice_ext_nsecs_min =3D 10 * NSEC_PER_USE=
C;
> +static const unsigned int rseq_slice_ext_nsecs_max =3D 50 * NSEC_PER_USE=
C;
> +
> +static const struct ctl_table rseq_slice_ext_sysctl[] =3D {
> +	{
> +		.procname	=3D "rseq_slice_extension_nsec",
> +		.data		=3D &rseq_slice_ext_nsecs,
> +		.maxlen		=3D sizeof(unsigned int),
> +		.mode		=3D 0644,
> +		.proc_handler	=3D proc_douintvec_minmax,
> +		.extra1		=3D (unsigned int *)&rseq_slice_ext_nsecs_min,
> +		.extra2		=3D (unsigned int *)&rseq_slice_ext_nsecs_max,
=E2=80=A6

maybe +

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/ad=
min-guide/sysctl/kernel.rst
index f3ee807b5d8b3..ed34d21ed94e4 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1228,6 +1228,12 @@ reboot-cmd (SPARC only)
 ROM/Flash boot loader. Maybe to tell it what to do after
 rebooting. ???
=20
+rseq_slice_extension_nsec
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+A task may ask to delay its scheduling if it is in a critical section via =
the
+prctl(PR_RSEQ_SLICE_EXTENSION_SET) mechanism. This sets the maximum allowed
+extension in nanoseconds before a mandatory scheduling of the task is forc=
ed.
=20
 sched_energy_aware
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


Sebastian

