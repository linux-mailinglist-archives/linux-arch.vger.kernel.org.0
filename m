Return-Path: <linux-arch+bounces-14381-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6DEC14BF2
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 14:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 574A91886BC4
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 13:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CDA3093DF;
	Tue, 28 Oct 2025 13:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S0GM83XJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Eh7BMRuo"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B411F4C8E;
	Tue, 28 Oct 2025 13:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761656666; cv=none; b=L4l2j8Gad+J6RuR1ZmxlyZwRIXOXIn6zjibmSQXrb9AzqecUmMt02yXy/1R67m6IgZmg8Zhaj5C+BqRuNH/o9wsoWATxDritljvWlqfsQqSRhvE05/zTUM+EZKvXSIgUAnA8szEVYLvNMrrTW6T1l4F0mDWZLI6lhcZsnuUJSqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761656666; c=relaxed/simple;
	bh=0keN4uf+oCdEM7z/g5nLocViNiPVNqPlCkfcHTjbj6U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oSDPoSDv4KnMS7TJZjNt/9L5gWyqAzF90PYHA66rAAO8ny7LgvDfexdAmvE9OY+A3Z/9HTp2VhMnIGTO77ClOz0klbFXEpvDf0zp+4DGsC9BjQV6zKwv/8w2vvUlDGe/DGaGO3BsuQ2rJ41E4j4t/tQPpyAX7heRgc4gAkCmpDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S0GM83XJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Eh7BMRuo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761656663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rih7V8lhhV1Uz9qrmE1IenQly0r+yFC6m8HuQcXUPXU=;
	b=S0GM83XJ3PoMyN971w8gTFPPU1e548Pej/XIJ+9//zCe7NwXSn3vIuPv+TGgD63SiXBkdc
	NMn3VDb4no6mOqlI5Z88NkY44riYWGvupt5vgqyKtEktDF+ity2aV6gxeT6mRTrE4Ibutl
	dpEHhIssyNiU0d8L4YXcC/BzCI2v7bEtTFRn6xPrS0nCaxgUOt0sG9Nev1aQChRVIzncc5
	W+u7KjtFoM/c4oLsxZCtgLV+gPDaAK8swnwkG+L6lL5gRKgUpGjbLqKQ85/vsYwAOa7x6S
	dszFB2IqC1R/+ECTyuFghjwkfIdCh2ij5dvPcbkeCZw0+f5TL+ucfwdRGyEsMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761656663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rih7V8lhhV1Uz9qrmE1IenQly0r+yFC6m8HuQcXUPXU=;
	b=Eh7BMRuork9NPVe6xTsHHrohgpRZjJS9RuQeWGeQ1KN/O13+xvasfZ0sedC0ob993aB90Z
	9nqu++w9eFQUbOCg==
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
In-Reply-To: <20251028083356.cDl403Q9@linutronix.de>
References: <20251022110646.839870156@linutronix.de>
 <20251022121427.406689298@linutronix.de>
 <20251027113822.UfDZz0mf@linutronix.de> <87cy68wbt6.ffs@tglx>
 <20251028083356.cDl403Q9@linutronix.de>
Date: Tue, 28 Oct 2025 14:04:22 +0100
Message-ID: <87ms5buqi1.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 28 2025 at 09:33, Sebastian Andrzej Siewior wrote:
> On 2025-10-27 17:26:29 [+0100], Thomas Gleixner wrote:
>> On Mon, Oct 27 2025 at 12:38, Sebastian Andrzej Siewior wrote:
>> > On 2025-10-22 14:57:38 [+0200], Thomas Gleixner wrote:
>> >> +static enum hrtimer_restart rseq_slice_expired(struct hrtimer *tmr)
>> >> +{
>> >> +	struct slice_timer *st = container_of(tmr, struct slice_timer, timer);
>> >> +
>> >> +	if (st->cookie == current && current->rseq.slice.state.granted) {
>> >> +		rseq_stat_inc(rseq_stats.s_expired);
>> >> +		set_need_resched_current();
>> >> +	}
>> >
>> > You arm the timer while leaving to userland. Once in userland the task
>> > can be migrated to another CPU. Once migrated, this CPU can host another
>> > task while the timer fires and does nothing.
>> 
>> That's inevitable. If the scheduler decides to do that then there is
>> nothing which can be done about it and that's why the cookie pointer
>> exists.
>
> Without an interrupt on the target CPU, there is nothing stopping the
> task from overstepping its fair share.

If a task gets migrated then it can't overstep the share because the
migration is bringing it back into the kernel, schedules it out and
schedules it in on the new CPU. So the whole accounting start over
freshly. That's the same as if the task gets the extension granted, goes
to user space and gets interrupted again. If that interrupt sets
NEED_RESCHED the grant is "revoked" and the timer fires for nothing.

> Since it is a CPU local timer which is HRTIMER_MODE_HARD, from this CPUs
> perspective it is either about to run or it did run. Therefore the
> hrtimer_try_to_cancel() can't return -1 due to
> hrtimer_callback_running() == true.
> If you drop hrtimer_active() check and scoped_guard(irq),
> hrtimer_try_to_cancel() will do the same hrtimer_active() check as you
> have above followed by disable interrupts via lock_hrtimer_base() and
> here hrtimer_callback_running() can't return true because interrupts are
> disabled and the timer can't run on a remote CPU because it is a
> CPU-local timer.
>
> So you avoid a branch to hrtimer_try_to_cancel() if the timer already
> fired.

Yes you are right. Seems I've suffered from brain congestion. Let me
remove it.

Thanks,

        tglx

