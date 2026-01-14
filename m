Return-Path: <linux-arch+bounces-15798-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7571D217C0
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jan 2026 23:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D45E30B50DF
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jan 2026 22:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36FB3A89A4;
	Wed, 14 Jan 2026 22:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6+5+1xU"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367F13AA190;
	Wed, 14 Jan 2026 21:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768427999; cv=none; b=a8jOJ+6fSPFO5uqvf1DhrmU3kmNH7vXGIn/n1Zkd9qRJfwfq9D+wJE95jqotdVnKWN1LRE/Xr3U6pBG3RiKQ7EuIBXSxlw9Cfl8PUZy2HR5jnmsdbyP2327rPHbUdSb5H5rD0oKvEL4Xhk4T8Seo76OsBdx8JvFU+7aI+82Oi0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768427999; c=relaxed/simple;
	bh=HI2UZ5fbq8uuafUG9pF8EH6CU76Jw/XzyUB2SrlBCiE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D7VXFwN7AVL8I5B1koQCjw+GkGyy3KwDZIlHPs0HTmPzFqPUTDBVz7qvP+WlgQYkktYMM8IOkMVj8B2fS1qVa0EXCX4jZDLlUmzzqc87YxEo9Nf+w3p8bdq3fr2XZ39CXtBdSvI62ttKyHQDXDkdtoImpvNLKLuPTMWYvCWzefE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6+5+1xU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33B5C4CEF7;
	Wed, 14 Jan 2026 21:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768427998;
	bh=HI2UZ5fbq8uuafUG9pF8EH6CU76Jw/XzyUB2SrlBCiE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=a6+5+1xUvXgJjPbCw7Bk2M/ejbNCvy+EwXvBn/0s2gx7sICTPZ89zYjfrCEZiyfa5
	 EiaYaNqPvY8yzq3Y+W4y9icWP5d2FDCixVd+GLttHzuLwr8xNnCYoql7FUfeDzzheF
	 gy5XeC3KtSJ+k0Np3mI+XZrKVzvgSdyn4gjlaAeBasiebyVedEzxMcVI8OQra/Mlk3
	 lMpaTx7jWjnvkrlRN9fw86909EmOGqGIhAZkNp1FWRAclhuhTrM3PGOFPQyTJmAi+d
	 Se4WVsgDWPdxJQLjthj6NP9fcshnEZEPy2y7SW/OA6bjJ6NkYeemZUgzjueR1lRP3W
	 kbM3DBklYQiLg==
From: Thomas Gleixner <tglx@kernel.org>
To: Florian Weimer <fweimer@redhat.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML
 <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Prakash Sangappa <prakash.sangappa@oracle.com>, Madadi Vineeth Reddy
 <vineethr@linux.ibm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Steven
 Rostedt <rostedt@goodmis.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, Peter
 Zijlstra <peterz@infradead.org>, Ron Geva <rongevarg@gmail.com>, Waiman
 Long <longman@redhat.com>, "carlos@redhat.com" <carlos@redhat.com>, Michael
 Jeanson <mjeanson@efficios.com>
Subject: Re: [patch V6 01/11] rseq: Add fields and constants for time slice
 extension
In-Reply-To: <lhua4yhcc0d.fsf@oldenburg.str.redhat.com>
References: <20251215155615.870031952@linutronix.de>
 <20251215155708.669472597@linutronix.de>
 <d97944e3-e5f3-4d7e-83ac-89ddd6a4cb64@efficios.com> <87jyyjbclh.ffs@tglx>
 <225b9868-4ab7-4a90-8acb-8d965626f6a7@efficios.com> <87ldi4gjm3.ffs@tglx>
 <lhua4yhcc0d.fsf@oldenburg.str.redhat.com>
Date: Wed, 14 Jan 2026 22:59:54 +0100
Message-ID: <87y0lzhn39.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 14 2026 at 00:45, Florian Weimer wrote:
> * Thomas Gleixner:
>> I'm not completely opposed to make it process wide. For threads created
>> after enablement, that's trivial because that can be done when the per
>> thread RSEQ is registered. But when it gets enabled _after_ threads have
>> been created already then we need code to chase the threads and enable
>> it after the fact because we are not going to query the enablement in
>> curr->mm::whatever just to have another conditional and another
>> cacheline to access.
>
> In glibc, we make sure that the registration for restartable sequences
> happens before any user code (with the exception of IFUNC resolvers) can
> run.  This includes code from signal handlers.  We started masking
> signals on newly created threads for this reason, to make these
> partially initialized states unobservable.
>
> It's not clear to me what the expected outcome is.  If we ever want to
> offer deadline extension as a mutex attribute (for example), then we
> have to switch this on at process start unconditionally because we don't
> know if this new API will be used by the new process (potentially after
> dlopen, so we can't even use things likely analyzing the symbol
> footprint ahead of time).

Sure, but then you can enable it at each thread start, no?

>> The only option is to reject enablement when there is already more than
>> one thread in the process, but there is a reasonable argument that a
>> process might only enable it for a subset of threads, which have actual
>> lock interaction and not bother with it for other things. I'm not seeing
>> a reason to restrict the flexibility of configuration just because you
>> envision magic use cases all over the place.
>
> Sure, but it looks like this needs a custom/minimal libc.  It's like
> repurposing set_robust_list for something else.  It can be done, but it
> has a significant cost in terms of compatibility because some
> functionality (that other libraries in the process depend on) will stop
> working.

The kernel is not there to cater magic user space expectations. It
provides interfaces and the minimal amount of policy.

If glibc wants to use it for mutexes (for all the wrong reasons) then
glibc needs to take care of enabling it like it does for registering
RSEQ for each newly created thread.

If glibc does not and the application does care for their particular
concurrency control, then it is the application's problem to ensure that
it is enabled for the threads it cares about, right?

>> On the other hand there is no guarantee that libc registers RSEQ when a
>> thread is started as it can be disabled or not supported, so you have
>> exactly the same problem there that the code which wants to use it needs
>> to ensure that a RSEQ area is registered, no?
>
> With glibc, if RSEQ is registered on the main thread, it will be
> registered on all other threads, too.  Technically, it's possible to
> unregister RSEQ with the kernel, of course, but that's totally
> undefined, like unmapping memory originally returned from malloc.

This is again user land policy. glibc decides to register RSEQ for each
new thread, but the kernel does not care whether it does or not.

>>>> The prctl allows you to query the state, so all parties can make
>>>> informed decisions. It's not any different from other mechanisms, which
>>>> require coordination between different parts.
>>>
>>> I'm fine with having prctl enable the feature (for the whole process)
>>> and query its state.
>>>
>>> The part I'm concerned with is the prctl disabling the feature, as
>>> we're losing the availability invariant after setup.
>>
>>   close(0);
>>
>> has the same problem. How many instances of bugs in that area have you
>> seen so far?
>
> We've had significant issues due to incorrect close calls (maybe not
> close(0) in particular, but definitely with double-closes removing
> descriptors created by other threads.

That's again not a kernel problem. The primary UNIX design principle is
to allow user space to shoot itself into the foot. There is zero reason
to change that unless it's a justified security issue.

   Time slice extension best effort magic does definitely qualify for
   that. It's harmless as the only side effect is that user space wastes
   cycles...

Thanks,

        tglx

