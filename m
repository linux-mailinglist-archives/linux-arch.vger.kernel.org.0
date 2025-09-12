Return-Path: <linux-arch+bounces-13516-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D0DB554AC
	for <lists+linux-arch@lfdr.de>; Fri, 12 Sep 2025 18:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB46B189A805
	for <lists+linux-arch@lfdr.de>; Fri, 12 Sep 2025 16:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973737B3E1;
	Fri, 12 Sep 2025 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T+qUjiPD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V4SMK+1D"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC814A23;
	Fri, 12 Sep 2025 16:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757694699; cv=none; b=Aqvd6e4RYldT3RcqQrz7pq/q9gpLmuUdkQdcyCVlyTEBORWYfjP+luZWbHN6RYxTZL9sOc7/g+aSkC8av2ns1pNczegjOYQdFBcMSeIwxJDCwJ9KfxfoP5nqfqknLbyMV1PsSUbjflo2bis1iPn8Z6Kiu9VkNejIh35LkWKZkaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757694699; c=relaxed/simple;
	bh=EHZpX9E4hnrAiWW2W8AeC6tcY8jT11ZMhrOd/G9RC6Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s7Hm2WeGLv0r/OkiQWwIvc6o+4eOLMixNTuVP+VpxvsyZw8OcPnu9eSakdUfFnFVLXnfUFbVjgQQztOqfJe36CFNdSfS948DgndXUSwCN/sGvD7yh6u6tmGwwCEo3NhOuycqrOXC4evvX2l7dm1WAwvtHzQnnRCNPzJ9JPqL26o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T+qUjiPD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V4SMK+1D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757694689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iJWnXehZDqLfsIHyhlWcYZq8awCULd602/ZmbxMSV4Y=;
	b=T+qUjiPDyys8hqu8PsbqZIxd2E4CCHvfajm809RsdMmgKi9dZJKn7rAt8gnjiL2ekt0N7z
	B4/nnz8TPJII5TVGcFj/vD82NR05wY6ulQHqoyAz3aASACKz/cxoUxnsNh4JhB8L4w6IpQ
	PlaXH3GJUub+antMtgfBbwa8vMzWph8joTYMMGHELe+bDcTBYTv0sw2B0XsVm1tAOorH1o
	OOvqQjxFdvn3fIruCjs7LMJVNC4lp5+nQo7cBgjBrtJpMVyuj6oNjae1U1vMeQh8UFYwsa
	JP6mOZNb8432ke62mMdMasecyqBjb/pbv1u2wtZ+XZw/GIPONanXAPivzP5FCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757694689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iJWnXehZDqLfsIHyhlWcYZq8awCULd602/ZmbxMSV4Y=;
	b=V4SMK+1DAZ3ZxC0odDakYxIXLGgU3PgD4kglyeoVqHlveV2iqSntP4VbAEXvXn1u99JbO+
	UrJtaxbbXF1Z6oCw==
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Peter Zilstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Prakash Sangappa <prakash.sangappa@oracle.com>, Madadi
 Vineeth Reddy <vineethr@linux.ibm.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>, Steven Rostedt <rostedt@goodmis.org>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org
Subject: Re: [patch 00/12] rseq: Implement time slice extension mechanism
In-Reply-To: <3d16490f-e4d3-4e91-af17-62018e789da9@efficios.com>
References: <20250908225709.144709889@linutronix.de>
 <159c984d-37fc-4b63-acf3-d0409c9b57cd@efficios.com> <87plbwrbef.ffs@tglx>
 <3d16490f-e4d3-4e91-af17-62018e789da9@efficios.com>
Date: Fri, 12 Sep 2025 18:31:28 +0200
Message-ID: <87a52zr5sv.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Sep 12 2025 at 08:33, Mathieu Desnoyers wrote:
> On 2025-09-11 16:18, Thomas Gleixner wrote:
>> It receives SIGSEGV because that means that it did not follow the rules
>> and stuck an arbitrary syscall into the critical section.
>
> Not following the rules could also be done by just looping for a long
> time in userspace within or after the critical section, in which case
> the timer should catch it.

It's pretty much impossible to tell for the kernel without more
overhead, whether that's actually a violation of the rules or not.

The operation after the grant can be interrupted (without resulting in
scheduling), which is out of control of the task which got the extension
granted.

The timer is there to ensure that there is an upper bound to the grant
independent of the actual reason.

Going through a different syscall is an obvious deviation from the rule.

As far I understood the earlier discussions, scheduler folks want to
enforce that because of PREEMPT_NONE semantics, where a randomly chosen
syscall might not result in an immediate reschedule because the work,
which needs to be done takes arbitrary time to complete.

Though that's arguably not much different from

       syscall()
                -> tick -> NEED_RESCHED
        do_tons_of_work();
       exit_to_user()
          schedule();

except that in the slice extension case, the latency increases by the
slice extension time.

If we allow arbitrary syscalls to terminate the grant, then we need to
stick an immediate schedule() into the syscall entry work function. We'd
still need the separate yield() syscall to provide a side effect free
way of termination.

I have no strong opinions either way. Peter?

>>> rseq->slice_request = true;  /* WRITE_ONCE() */
>>> barrier();
>>> critical_section();
>>> barrier();
>>> rseq->slice_request = false; /* WRITE_ONCE() */
>>> if (rseq->slice_grant)       /* READ_ONCE() */
>>>     rseq_slice_yield();
>> 
>> That should work as it's strictly CPU local. Good point, now that you
>> said it it's obvious :)
>> 
>> Let me rework it accordingly.
>
> I have two questions wrt ABI here:
>
> 1) Do we expect the slice requests to be done from C and higher level
>     languages or only from assembly ?

It doesn't matter as long as the ordering is guaranteed.

> 2) Slice requests are a good fit for locking. Locking typically
>     has nesting ability.
>
>     We should consider making the slice request ABI a 8-bit
>     or 16-bit nesting counter to allow nesting of its users.

Making request a counter requires to keep request set when the
extension is granted. So the states would be:

     request    granted
     0          0               Neutral
     >0         0               Requested
     >=0        1               Granted

That should work.

Though I'm not really convinced that unconditionally embeddeding it into
random locking primitives is the right thing to do.

The extension makes only sense, when the actual critical section is
small and likely to complete within the extension time, which is usually
only true for highly optimized code and not for general usage, where the
lock held section is arbitrary long and might even result in syscalls
even if the critical section itself does not have an obvious explicit
syscall embedded:

     lock(a)
        lock(b) <- Contention results in syscall

Same applies for library functions within a critical section.

That then immediately conflicts with the yield mechanism rules, because
the extension could have been granted _before_ the syscall happens, so
we'd have remove that restriction too.

That said, we can make the ABI a counter and split the slice control
word into two u16. So the decision function would be:

     get_usr(ctrl);
     if (!ctrl.request)
     	return;
     ....
     ctrl.granted = 1;
     put_usr(ctrl);

Along with documentation why this should only be used nested when you
know what you are doing.

> 3) Slice requests are also a good fit for rseq critical sections.
>     Of course someone could explicitly increment/decrement the
>     slice request counter before/after the rseq critical sections, but
>     I think we could do better there and integrate this directly within
>     the struct rseq_cs as a new critical section flag. Basically, a
>     critical section with this new RSEQ_CS_SLICE_REQUEST flag (or
>     better name) set within its descriptor flags would behave as if
>     the slice request counter is non-zero when preempted without
>     requiring any extra instruction on the fast path. The only
>     added overhead would be a check of the rseq->slice_grant flag
>     when exiting the critical section to conditionally issue
>     rseq_slice_yield().

Plus checking first whether rseq->slice.request is actually zero,
i.e. whether the rseq critical section was the outermost one. If not,
you cannot invoke the yield even if granted is true, right?

But mixing state spaces is not really a good idea at all. Let's not go
there.

Also you'd make checking of rseq_cs unconditional, which means extra
work in the grant decision function as it would then have to do:

         if (!usr->slice.ctrl.request) {
            if (!usr->rseq_cs)
               return;
            if (!valid_ptr(usr->rseq_cs))
               goto die;
            if (!within(regs->ip, usr->rseq_cs.start_ip, usr->rseq_cs.offset))
               return;
            if (!(use->rseq_cs.flags & REQUEST))
               return;
         }

IOW, we'd copy half of the rseq cs handling into that code.

Can we please keep it independent and simple?

Thanks,

        tglx

