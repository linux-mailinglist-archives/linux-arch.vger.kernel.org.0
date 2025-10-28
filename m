Return-Path: <linux-arch+bounces-14371-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CB5C138DD
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 09:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 14F013504F6
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 08:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104D51DDA24;
	Tue, 28 Oct 2025 08:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N3JSUMKv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OOzR5ynh"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4372021576E;
	Tue, 28 Oct 2025 08:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761640448; cv=none; b=Ru+mJfsExbzTETmLtUnjlse4Rvd/kjokXmaKh52LYrzim4pkCgq5PK/nUS/H5jqNIyEUAozhR1L6na+iID46yeFDcvj6/kQ+5Cba4UUajrb31CYCuZ4f17wlQ+1vsMpQhWWN1yHmSxhxVuRlq/4E73ZcASs7bZUPtcTVZC8967w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761640448; c=relaxed/simple;
	bh=CYLmaOBgHYt3LSzhmMb2Wlpalqn3kMa60TBG7D9z+UI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVz3j8HZVoi7rjNvBqxJ0VtLKle5rb5NWggH9dwz9FQwSnvvyU+lHQ8Qfsaf0//xx7BX6TKavvIJlXF168tYf0skIdAVvFI5C2rcEp4P55z/21srOkEuJejMvXkZeWAtqKH+zJ9+Y1KL0zmMpkUlEGCvUKMng+dCle4ji3Y0AEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N3JSUMKv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OOzR5ynh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 28 Oct 2025 09:33:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761640437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v8bo8tT6fUf4Z0oRK29BRJ8yd34/WHo4boCnEa8kDIY=;
	b=N3JSUMKvMR4/nK4bPpfSSsRRu7u5CzJvaYbZ3VQndBFt9eNFXNXNOf/nivfdwEsY61Dwyx
	bzl9I4o49guELHZVTUhqopidgnngWdWYGgn4i4zDFaiztVATxia5LvyXfbikjtQUwC81Lu
	kPxKRYtQwjsSjugjFVi9S3ORBsoWfgGyWxfkgubSCXaFq3DB9gYFH8aWYn3qtyAgd4bf3I
	4A82bm9YgIgP5r7dRSj3NE71xIjrK4WyueIW+SOimY27Ji/CMZkLjxbYgXkLJtm38uqVjW
	C6CFtijmnLs5Zr5dA7G8rA9NtgdCe4HcNXoZToWOqjJoq/Uu/b2nsafEq/prTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761640437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v8bo8tT6fUf4Z0oRK29BRJ8yd34/WHo4boCnEa8kDIY=;
	b=OOzR5ynhJ5kHWV2nAudvooXqPaF166obYxwIeuAX9mjXK8Pg/Xjv7WjPSseHYaS5s8mg+o
	anM+JRb4QxgL0FDA==
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
Message-ID: <20251028083356.cDl403Q9@linutronix.de>
References: <20251022110646.839870156@linutronix.de>
 <20251022121427.406689298@linutronix.de>
 <20251027113822.UfDZz0mf@linutronix.de>
 <87cy68wbt6.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87cy68wbt6.ffs@tglx>

On 2025-10-27 17:26:29 [+0100], Thomas Gleixner wrote:
> On Mon, Oct 27 2025 at 12:38, Sebastian Andrzej Siewior wrote:
> > On 2025-10-22 14:57:38 [+0200], Thomas Gleixner wrote:
> >> +static enum hrtimer_restart rseq_slice_expired(struct hrtimer *tmr)
> >> +{
> >> +	struct slice_timer *st =3D container_of(tmr, struct slice_timer, tim=
er);
> >> +
> >> +	if (st->cookie =3D=3D current && current->rseq.slice.state.granted) {
> >> +		rseq_stat_inc(rseq_stats.s_expired);
> >> +		set_need_resched_current();
> >> +	}
> >
> > You arm the timer while leaving to userland. Once in userland the task
> > can be migrated to another CPU. Once migrated, this CPU can host another
> > task while the timer fires and does nothing.
>=20
> That's inevitable. If the scheduler decides to do that then there is
> nothing which can be done about it and that's why the cookie pointer
> exists.

Without an interrupt on the target CPU, there is nothing stopping the
task from overstepping its fair share.

> >> +	return HRTIMER_NORESTART;
> >> +}
> >> +
> > =E2=80=A6
> >> +static void rseq_cancel_slice_extension_timer(void)
> >> +{
> >> +	struct slice_timer *st =3D this_cpu_ptr(&slice_timer);
> >> +
> >> +	/*
> >> +	 * st->cookie can be safely read as preemption is disabled and the
> >> +	 * timer is CPU local. The active check can obviously race with the
> >> +	 * hrtimer interrupt, but that's better than disabling interrupts
> >> +	 * unconditionally right away.
> >> +	 *
> >> +	 * As this is most probably the first expiring timer, the cancel is
> >> +	 * expensive as it has to reprogram the hardware, but that's less
> >> +	 * expensive than going through a full hrtimer_interrupt() cycle
> >> +	 * for nothing.
> >> +	 *
> >> +	 * hrtimer_try_to_cancel() is sufficient here as with interrupts
> >> +	 * disabled the timer callback cannot be running and the timer base
> >> +	 * is well determined as the timer is pinned on the local CPU.
> >> +	 */
> >> +	if (st->cookie =3D=3D current && hrtimer_active(&st->timer)) {
> >> +		scoped_guard(irq)
> >> +			hrtimer_try_to_cancel(&st->timer);
> >
> > I don't see why hrtimer_active() and IRQ-disable is a benefit here.
> > Unless you want to avoid a branch to hrtimer_try_to_cancel().
> >
> > The function has its own hrtimer_active() check and disables interrupts
> > while accessing the hrtimer_base lock. Since preemption is disabled,
> > st->cookie remains stable.
> > It can fire right after the hrtimer_active() here. You could just
> >
> > 	if (st->cookie =3D=3D current)
> > 		hrtimer_try_to_cancel(&st->timer);
> >
> > at the expense of a branch to hrtimer_try_to_cancel() if the timer
> > already expired (no interrupts off/on).
>=20
> That's not equivalent. As this is CPU local the interrupt disable
> ensures that the timer is not running on this CPU. Otherwise you need
> hrtimer_cancel(). Read the comment. :)

Since it is a CPU local timer which is HRTIMER_MODE_HARD, from this CPUs
perspective it is either about to run or it did run. Therefore the
hrtimer_try_to_cancel() can't return -1 due to
hrtimer_callback_running() =3D=3D true.
If you drop hrtimer_active() check and scoped_guard(irq),
hrtimer_try_to_cancel() will do the same hrtimer_active() check as you
have above followed by disable interrupts via lock_hrtimer_base() and
here hrtimer_callback_running() can't return true because interrupts are
disabled and the timer can't run on a remote CPU because it is a
CPU-local timer.

So you avoid a branch to hrtimer_try_to_cancel() if the timer already
fired.

> Thanks,
>=20
>         tglx

Sebastian

