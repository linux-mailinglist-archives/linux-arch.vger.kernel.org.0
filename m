Return-Path: <linux-arch+bounces-15743-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EC049D0EA65
	for <lists+linux-arch@lfdr.de>; Sun, 11 Jan 2026 12:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 946DE3003FC4
	for <lists+linux-arch@lfdr.de>; Sun, 11 Jan 2026 11:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6FE330661;
	Sun, 11 Jan 2026 11:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvb+H2WE"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383B633064E;
	Sun, 11 Jan 2026 11:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768129296; cv=none; b=TOTfr5DLORoqNBZeM2sqfX0RZXPjDzsLsz6QW5RlJhPHXk15d9Tes2B+nnrDNrlxx2BeXk+8K/tQf0uGrQXVGNOVsEGwUqFCZKIqto7J40F0+euYb5WqQL3QWCXNSVmsxQ58Wv27P9gYbPx2M0jtl7xj29L2IboOaEBGf2Jaolg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768129296; c=relaxed/simple;
	bh=o4CW2+vk0zKv56E//RFdbfEsliPa/M9rzdKnKi5Imtg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EbVr1SCp3gPZDgBzBpKG2dt/UMBEdhZwPA6YK8f5TXQxDTXcAZrUAqHeoR2LQm6tDOOHB7h9/CCynWcsteFtGukfCWSe9jbDZSqkHWyydGs5x5SJrsOZqxpikghvheRmh4VKOcA04lkPN/q92yTep0PAlUQvemh21qXSdDLDzzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvb+H2WE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DCEC4CEF7;
	Sun, 11 Jan 2026 11:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768129295;
	bh=o4CW2+vk0zKv56E//RFdbfEsliPa/M9rzdKnKi5Imtg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=fvb+H2WES6sPyq/eqtUvHrroq9du4l4V22lGk93eB04kVrL1QLRi+GHI+Fsq3cb41
	 7ncAWX614fViiMWby//Vcsgiy8D5WGNfLuVDRvc1dZbdXDy2SvNJh5ozCpR6MSSYTk
	 xA/agNdZ9pzMiR0wmYPrsfgo4guN2YQmgKEJvD7PPwt2H356IySm8xGuhZ8oEDcUd/
	 zVYHrmzvEsekCuChYOXIrA7wMIcmefOVzKVP7OniH+Q4WvmITD6ibyi8CP/zMKvtmO
	 Ae6PcLH7waDraQSjFF9pbsMRzDzDmUo/01a2kAL3qFw4W+/fmh0hJaMX4TgWuabNxH
	 lNaSAK1c1EwEw==
From: Thomas Gleixner <tglx@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Prakash Sangappa <prakash.sangappa@oracle.com>, Madadi
 Vineeth Reddy <vineethr@linux.ibm.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>, Steven Rostedt <rostedt@goodmis.org>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, Ron Geva
 <rongevarg@gmail.com>, Waiman Long <longman@redhat.com>
Subject: Re: [patch V6 10/11] entry: Hook up rseq time slice extension
In-Reply-To: <20251219110711.GE1132199@noisy.programming.kicks-ass.net>
References: <20251215155615.870031952@linutronix.de>
 <20251215155709.258157362@linutronix.de>
 <d8215f9a-3088-483c-bd96-4058767b886d@efficios.com>
 <20251219110711.GE1132199@noisy.programming.kicks-ass.net>
Date: Sun, 11 Jan 2026 12:01:31 +0100
Message-ID: <878qe4ifas.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Dec 19 2025 at 12:07, Peter Zijlstra wrote:
> On Tue, Dec 16, 2025 at 10:37:24AM -0500, Mathieu Desnoyers wrote:
>> On 2025-12-15 13:24, Thomas Gleixner wrote:
>> > Wire the grant decision function up in exit_to_user_mode_loop()
>> > 
>> [...]
>> > +/* TIF bits, which prevent a time slice extension. */
>> > +#ifdef CONFIG_PREEMPT_RT
>> > +# define TIF_SLICE_EXT_SCHED	(_TIF_NEED_RESCHED_LAZY)
>> > +#else
>> > +# define TIF_SLICE_EXT_SCHED	(_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY)
>> 
>> It would be relevant to explain the difference between RT and non-RT
>> in the commit message.
>
> So if you include TIF_NEED_RESCHED the extension period directly affects
> the minimum scheduler delay like:
>
>   min(extension_period, min_sched_delay)
>
> because this is strictly a from-userspace thing. That is, it is
> equivalent to the in-kernel preemption/IRQ disabled regions -- with
> exception of the scheduler critical sections itself.
>
> As I've agrued many times -- I don't see a fundamental reason to not do
> this for RT -- but perhaps further reduce the magic number such that its
> impact cannot be observed on a 'good' machine.
>
> But yes, if/when we do this on RT it needs the promise to agressively
> decrease the magic number any time it can actually be measured to impact
> performance.
>
> cyclictest should probably get a mode where it (ab)uses the feature to
> failure before we do this.
>
> Anyway, I don't mind excluding RT for now, but it *does* deserve a
> comment.

I know you argued about this many times, but I still maintain my point
of view that TIF_PREEMPT and TIF_PREEMPT_LAZY are fundmentally different:

     TIF_PREEMPT_LAZY grants a non-RT task to complete until it reaches
     return to user

     TIF_PREEMPT enforces preemption at the next possible preemption
     point

My main concern is this scenario:

   sched_other_task()
        request_slice_extension()

   ---> interrupt
        RT task is woken up

        return_to_user()
           grant_extension()
           ...

which means the RT task is delayed until the OTHER task relinquishes the
CPU voluntarily or via timeout.

That might be desired _if_ both tasks are using the same lock, but in
case of fully independent tasks it's not necessarily a good idea. If a
RT application uses locks in the RT tasks, then obviously latency is not
so much of a concern, but for optimized RT applications the side effect
of other processes getting a free pass to increase latency is troublesome.

So I prefer to keep the current semantics for RT. This can be revisited
of course when a proper evaluation has been done, but IMO there are too
many moving parts in a RT system to make this actually work correctly
under all circumstances.

I'll add proper comments to that effect.

Thanks,

        tglx







