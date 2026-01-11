Return-Path: <linux-arch+bounces-15744-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADBFD0F7E9
	for <lists+linux-arch@lfdr.de>; Sun, 11 Jan 2026 18:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B2913025A73
	for <lists+linux-arch@lfdr.de>; Sun, 11 Jan 2026 17:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D27C346AE8;
	Sun, 11 Jan 2026 17:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/vN13OW"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6908833F8AC;
	Sun, 11 Jan 2026 17:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768151480; cv=none; b=gfcDmiVIU6pBg10ExlZlPpvLdlzHoACRFLOSHX7ZlEQQ/+CcERhdK0DTKSxJZ/Y6QpC0GuXcOG4OYi5OT+W3bV00bRzLgSRC4vI/L4W6Ucz5atBpotppIW3BpBcEnKugwkgbgzram2zfajWI6y385CsmlJJ+OVkj/d/1Dr0Zil0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768151480; c=relaxed/simple;
	bh=OnwustDebdONrg3DpiuMOYls7c9RN9aap05ypNQV4fk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WR6qvHdf+fdCXR8CMqnnrup5Sk3f/7K6dzJhGitdJiXWIVWJSZ5lN5hpcjpIaBhK83BVdcRVzySO50W6zaj6AaxsKbw2kfueZFDkeCfnmCUuA1N3OBMEUYTUiuS1r2eyQ6eV8CsTioWS8csfmrDCcthrreVCyy5Y9WJSjnsAaGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/vN13OW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B51DC4CEF7;
	Sun, 11 Jan 2026 17:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768151480;
	bh=OnwustDebdONrg3DpiuMOYls7c9RN9aap05ypNQV4fk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=e/vN13OWu5FI6PK6APMnOLTgEdcOlzt/gjkUx59XwZcZ2dUpXE7k9sYxACj+Id+Tq
	 zvENplEbpLoXxNxoRTrlIZRVGL/TnArv9HHMg8THqyBKQy8bjiSdepDl94uTBUOZ8D
	 Uc5hM/eNqpv3FKbH2bBrYdFwPOwPI9MTlnohOo8cFAKH8Z0x1LsUAu4o5/WdEDCnxu
	 PtX772XfYUbhoqcD5Dn41t0HrWrJRDyWv92h/ArbuIAP1IUjGrl4tTGdgoeQeZsGie
	 h8whVpTH2KbkSSPJuo7FeSngn8qFtN+KbQJcp8N9SC9t3GLzzcMM2H/EihbTF34BE4
	 rQJor4j84qZHQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Prakash Sangappa
 <prakash.sangappa@oracle.com>, Madadi Vineeth Reddy
 <vineethr@linux.ibm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Steven
 Rostedt <rostedt@goodmis.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, Peter
 Zijlstra <peterz@infradead.org>, Ron Geva <rongevarg@gmail.com>, Waiman
 Long <longman@redhat.com>, Florian Weimer <fweimer@redhat.com>,
 "carlos@redhat.com" <carlos@redhat.com>, Michael Jeanson
 <mjeanson@efficios.com>
Subject: Re: [patch V6 01/11] rseq: Add fields and constants for time slice
 extension
In-Reply-To: <225b9868-4ab7-4a90-8acb-8d965626f6a7@efficios.com>
References: <20251215155615.870031952@linutronix.de>
 <20251215155708.669472597@linutronix.de>
 <d97944e3-e5f3-4d7e-83ac-89ddd6a4cb64@efficios.com> <87jyyjbclh.ffs@tglx>
 <225b9868-4ab7-4a90-8acb-8d965626f6a7@efficios.com>
Date: Sun, 11 Jan 2026 18:11:16 +0100
Message-ID: <87ldi4gjm3.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 07 2026 at 16:11, Mathieu Desnoyers wrote:
> On 2025-12-18 18:21, Thomas Gleixner wrote:
>> On Tue, Dec 16 2025 at 09:36, Mathieu Desnoyers wrote:
>>> On 2025-12-15 13:24, Thomas Gleixner wrote:
>>> [...]
>>>> +The thread has to enable the functionality via prctl(2)::
>>>> +
>>>> +    prctl(PR_RSEQ_SLICE_EXTENSION, PR_RSEQ_SLICE_EXTENSION_SET,
>>>> +          PR_RSEQ_SLICE_EXT_ENABLE, 0, 0);
>>>
>>> Although it is not documented, it appears that a thread can
>>> also use this prctl to disable slice extension.
>> 
>> Obviously. Controls are supposed to be symmetrical.
>
> I agree that the vast majority of prctl are symmetrical, but
> there are exceptions, e.g. PR_SET_NO_NEW_PRIVS, PR_SET_SECCOMP.

Which have security requirements and are therefore different.

>>> How is it meant to compose once we have libc trying to use slice
>>> extension internally and the application also using it or wishing to
>>> disable it, unaware that libc is also trying to use it ?
>> 
>> Tons of prctls have the same "issue". What's so special about this?
>
> What is special about this is the fact that we want to allow userspace
> to specialize its fast-path code at runtime based on availability of an
> rseq feature.
>
> If we allow slice extension to be disabled by the program or any
> library within the process, this means that either the program or any
> other library cannot assume slice extension availability to stay
> invariant after it has been setup.

That's really a non-problem. This is not any different from other
tunables and there is really no reason to make up theoretical cases
where a library enables and another one disables. If user space can't
get it's act together then so be it. It's not the kernels problem and as
this is not a security feature with strict semantics, there is no reason
to let the kernel implement policy.

> Moreover, if the prctl enables the feature independently for each
> thread (rather than for the whole process), this requires a conditional
> state check on every use because it can be enabled or disabled
> depending on the thread. This prevents code specialization that would
> select the appropriate code at process startup through either ifunc
> resolver, code patching or other mean.

I'm not completely opposed to make it process wide. For threads created
after enablement, that's trivial because that can be done when the per
thread RSEQ is registered. But when it gets enabled _after_ threads have
been created already then we need code to chase the threads and enable
it after the fact because we are not going to query the enablement in
curr->mm::whatever just to have another conditional and another
cacheline to access.

The only option is to reject enablement when there is already more than
one thread in the process, but there is a reasonable argument that a
process might only enable it for a subset of threads, which have actual
lock interaction and not bother with it for other things. I'm not seeing
a reason to restrict the flexibility of configuration just because you
envision magic use cases all over the place.

On the other hand there is no guarantee that libc registers RSEQ when a
thread is started as it can be disabled or not supported, so you have
exactly the same problem there that the code which wants to use it needs
to ensure that a RSEQ area is registered, no?

> [...]
>
>> The prctl allows you to query the state, so all parties can make
>> informed decisions. It's not any different from other mechanisms, which
>> require coordination between different parts.
>
> I'm fine with having prctl enable the feature (for the whole process)
> and query its state.
>
> The part I'm concerned with is the prctl disabling the feature, as
> we're losing the availability invariant after setup.

  close(0);

has the same problem. How many instances of bugs in that area have you
seen so far?

>> What I've seen so far at least from the implementation is that it aims
>> to enable the maximum amount of features, aka. overhead, unconditionally
>> even if nothing uses them, e.g. CID.
>
> I don't mind having things disabled on process startup and then opt-in.
> What I care about though is that the enabled state stays invariant across
> the entire process after setting this up at program startup.

Userspace is perfectly equipped to do so and the kernel is not there to
prevent user space from shooting itself into the foot.

>> As I pointed out in the previous submission, the benefits of time slice
>> extensions are limited. In low contention scenarios they result in
>> measurable regressions, so it's not the magic panacea which solves all
>> locking/critical section problems at once.
>
> I agree that whatever code we add to an uncontended spinlock fast path
> will show up in microbenchmark measurements.

It not only shows up in microbenchmarks. It shows up in real world
scenarios too. So enabling and using it in random places just because
you can will not necessarily result in any performance gain, it might
actually get worse.

>> The idea that cobbling random libraries together in the hope that
>> everything goes well has never worked. That's simply a wet dream and
>> Java has proven that to the maximum extent decades ago. Nevertheless all
>> other programming models went down the same yawning abyss and everyone
>> expects that the kernel is magically solving their problems by adding
>> more abusable [mis]features.
>> 
>> Systems have to be designed carefully as a whole if you want to achieve
>> the maximum performance. That's not any different from other targets
>> like real-time. A real-time enabled kernel does not magically create a
>> real-time system.
> [...]
>
> I think we are talking about two different program/libraries composition
> use-cases here.
>
> AFAIU, the aspect you are focused on is whether we should allow users of
> slice extension to nest. I agree with you that we should document this
> as unsupported, since the goal of slice extension is really for short
> spinlock critical sections, and nesting of those goes against that
> basic definition.

This is not about nesting. This is about the completely unrealistic idea
that combining random libraries will result in a functional optimized
system. If you want to ensure that nothing can disable it then implement
a syscall filter which rejects the disable command. That's user space
policy, not kernel side hardcoded policy.

> The concern I am raising here is different. It's about just _using_
> slice extension from various entities (program, libraries) within a
> process, without any nesting of slice extension requests.
>
> If libc successfully enables slice extension in its startup, the
> kernel should guarantee that it stays invariant for the lifetime
> of the program so libc can optimize its code accordingly, or use
> a fallback, without requiring additional per-thread variable checks
> in its fast paths.

Even if libc enables it and something else disables it, then the only
downside is that user space pointlessly does the request dance:

      set_request()
      critical_section()
      clear_request()
      if (granted())            // Guaranteed to be false
         sys_rseq_slice_yield()

The resulting harm is that requests are ignored by the kernel, so the
"optimized" code is not getting what it expects and executes 3
instructions for nothing. That's all. So where is your problem?

Thanks,

        tglx

