Return-Path: <linux-arch+bounces-14356-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0740CC0F43A
	for <lists+linux-arch@lfdr.de>; Mon, 27 Oct 2025 17:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 894B0188CC4F
	for <lists+linux-arch@lfdr.de>; Mon, 27 Oct 2025 16:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D07430DEA3;
	Mon, 27 Oct 2025 16:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UEFVTzV3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6Ug8NWBU"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594D125392D;
	Mon, 27 Oct 2025 16:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582397; cv=none; b=eyLJyhYlK5oUkialZ+i+8RL9Aabu5FecMv7dPemONHOsQjLvA7G+SPmi+5XXbxz6vSN8W5/bQ0KE2vjlPR2M162U/ExpvU0DNCou8Lx4YXqCezi6ShcSNXCIPND13zvOtv0Uw+03ipMXyGEd/gk4eBFO0ya+ETH51Us2FG58k3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582397; c=relaxed/simple;
	bh=c4oRNhhcQ+/+8ZCzZZkt3EIJEucxRX7qrZHg/OkK2xk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NCgwA1Ip9RbH8fH2VhE3pYsh/3U3jLYPGqUq0xgKLnZ+ppe/3FcIgaogIMOxfR+CUXVb+9HgYdN4f7eCv2N4vpL+7CYfNDI4PcjmDs0jf5zXqos0OlLTkBd/G0/liAljJ1ANV80z1t5M04gxgmaXoUA3FW+mgTkYWcD7QNCdwPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UEFVTzV3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6Ug8NWBU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761582390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7UTZdrGauEFQJGAQ8e14nk+CHN/D+NILuEeSTu4MFPE=;
	b=UEFVTzV31PISf4qWF6yp8IFFo3L2YhNCuwiL0T3dI6yXCKJ8fYw5cSJp6AaDjJnEm4jrmg
	5JPla0ObAVKHvYRzwagGyPuPdLr4ece3QBWOapM07bWJzPF7Q66ESsktW56agE5i3cP8My
	Zh4GPEBo4IT4PC2g5rQc9tIzKkAZj3R7zMiypQilOEQ7r12j/PnyW/rJbj7VZW77Si33Hd
	xS5hcT06BIbPEwql/k5C41N5SqGxBe+M02SvfohSu14drFDh8XiYkBCEOE74cew792hNsl
	4YVGdfKlVQn2aiNz2vgSZd9fzOnO2go1AKmDGBi+ctWVB6HN0OYf3slO/HA3Yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761582390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7UTZdrGauEFQJGAQ8e14nk+CHN/D+NILuEeSTu4MFPE=;
	b=6Ug8NWBUEkvcph/iclZVumFfycbVOULnTkFyXx2dogne5ccwoLylCci+m0dIqhYdDi0fWU
	ffzmIi6Yz8kKuBCQ==
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Prakash Sangappa
 <prakash.sangappa@oracle.com>, Madadi Vineeth Reddy
 <vineethr@linux.ibm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Steven
 Rostedt <rostedt@goodmis.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org
Subject: Re: [patch V2 08/12] rseq: Implement time slice extension
 enforcement timer
In-Reply-To: <20251027113822.UfDZz0mf@linutronix.de>
References: <20251022110646.839870156@linutronix.de>
 <20251022121427.406689298@linutronix.de>
 <20251027113822.UfDZz0mf@linutronix.de>
Date: Mon, 27 Oct 2025 17:26:29 +0100
Message-ID: <87cy68wbt6.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27 2025 at 12:38, Sebastian Andrzej Siewior wrote:
> On 2025-10-22 14:57:38 [+0200], Thomas Gleixner wrote:
>> +static enum hrtimer_restart rseq_slice_expired(struct hrtimer *tmr)
>> +{
>> +	struct slice_timer *st =3D container_of(tmr, struct slice_timer, timer=
);
>> +
>> +	if (st->cookie =3D=3D current && current->rseq.slice.state.granted) {
>> +		rseq_stat_inc(rseq_stats.s_expired);
>> +		set_need_resched_current();
>> +	}
>
> You arm the timer while leaving to userland. Once in userland the task
> can be migrated to another CPU. Once migrated, this CPU can host another
> task while the timer fires and does nothing.

That's inevitable. If the scheduler decides to do that then there is
nothing which can be done about it and that's why the cookie pointer
exists.

>> +	return HRTIMER_NORESTART;
>> +}
>> +
> =E2=80=A6
>> +static void rseq_cancel_slice_extension_timer(void)
>> +{
>> +	struct slice_timer *st =3D this_cpu_ptr(&slice_timer);
>> +
>> +	/*
>> +	 * st->cookie can be safely read as preemption is disabled and the
>> +	 * timer is CPU local. The active check can obviously race with the
>> +	 * hrtimer interrupt, but that's better than disabling interrupts
>> +	 * unconditionally right away.
>> +	 *
>> +	 * As this is most probably the first expiring timer, the cancel is
>> +	 * expensive as it has to reprogram the hardware, but that's less
>> +	 * expensive than going through a full hrtimer_interrupt() cycle
>> +	 * for nothing.
>> +	 *
>> +	 * hrtimer_try_to_cancel() is sufficient here as with interrupts
>> +	 * disabled the timer callback cannot be running and the timer base
>> +	 * is well determined as the timer is pinned on the local CPU.
>> +	 */
>> +	if (st->cookie =3D=3D current && hrtimer_active(&st->timer)) {
>> +		scoped_guard(irq)
>> +			hrtimer_try_to_cancel(&st->timer);
>
> I don't see why hrtimer_active() and IRQ-disable is a benefit here.
> Unless you want to avoid a branch to hrtimer_try_to_cancel().
>
> The function has its own hrtimer_active() check and disables interrupts
> while accessing the hrtimer_base lock. Since preemption is disabled,
> st->cookie remains stable.
> It can fire right after the hrtimer_active() here. You could just
>
> 	if (st->cookie =3D=3D current)
> 		hrtimer_try_to_cancel(&st->timer);
>
> at the expense of a branch to hrtimer_try_to_cancel() if the timer
> already expired (no interrupts off/on).

That's not equivalent. As this is CPU local the interrupt disable
ensures that the timer is not running on this CPU. Otherwise you need
hrtimer_cancel(). Read the comment. :)

If it fired already, then the task is reaching this code too
late. Nothing to see there.

>> +		.extra1		=3D (unsigned int *)&rseq_slice_ext_nsecs_min,
>> +		.extra2		=3D (unsigned int *)&rseq_slice_ext_nsecs_max,
> =E2=80=A6
>
> maybe +
>
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/=
admin-guide/sysctl/kernel.rst
> index f3ee807b5d8b3..ed34d21ed94e4 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -1228,6 +1228,12 @@ reboot-cmd (SPARC only)
>  ROM/Flash boot loader. Maybe to tell it what to do after
>  rebooting. ???
>=20=20
> +rseq_slice_extension_nsec
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +A task may ask to delay its scheduling if it is in a critical section vi=
a the
> +prctl(PR_RSEQ_SLICE_EXTENSION_SET) mechanism. This sets the maximum allo=
wed
> +extension in nanoseconds before a mandatory scheduling of the task is fo=
rced.

Yes. Forgot about it as I already documented it in the time slice
extension docs. Let me add that.

Thanks,

        tglx

