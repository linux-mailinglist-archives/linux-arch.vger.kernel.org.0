Return-Path: <linux-arch+bounces-13508-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 634DDB53CFE
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 22:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F159BAA01C7
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 20:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D184B22F74A;
	Thu, 11 Sep 2025 20:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZwEp9SpG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h4MFgrTh"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130CA21D5AA;
	Thu, 11 Sep 2025 20:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757621901; cv=none; b=kWVlzfZrDiqgVm6+teJ1MiCPah9G6qHPdj5NJXmRrHj6Lh4cKFQp1Ejb2E7gBqSOHeEP1L5g/WNZvmDYbRnuYc1/T3AaWCVSjWgLQA/Yk7Ir+1SUL9qSw3y2AOc27upcGH1AUftQ23SLjZWZGuZeI3aKIn2C9q9eMvWfw7pjkTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757621901; c=relaxed/simple;
	bh=6qNHJ0q7wDrZq+xssnP1UJAXw1x/i3g0Uc3Ne6C+Iic=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=skj/rQrCDshiB+2SOWXCmO4Q0HBfS68qM8axpC/ZsUxCcnHmew4DbSbYjAzV5LByqLVI3C2c1mCvrtd0vcQGxRGqNnRA6+4vpm812mfwMwL6T1Olm9xw5sJHay99bgQmEjUnBTHxntzyPuI9cscDbaCok+UUyEizpvu0AFW6xhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZwEp9SpG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h4MFgrTh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757621898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=acc6cGeH1f8fveTaLJ8eW4iIDAFHsW3FUsNmOwASx8Y=;
	b=ZwEp9SpGTWsA36STa4YTofUyaCiKX0LByFd9wL5RgMPsrhNCnmSpy9cCMzs6fFxztlCct5
	4V+kiYLqvnBUb3Ll3SShFbjQ4WkCTXa2e1TbJOiKqMl/odxAHz+m2+9BESH3HAXQerU5+P
	MErPf4SZxOD4Gze21ooKQVnSWnWiCscumrxfmi+GzeKvUUO8VrDRxVEWf/FsjWC2H10n8s
	EaAopAQusTvXgPi16r0EBi5KJFHx7Xtc2k3sI0PTwZdw6cB9ucayGPUB1q19krHy41Y7Ng
	Gr9P3yMlAmnUhfbXKemFs2UUpM3ZgwGHwGZJJAXW8F6MbyyR/QdzfpD8pL8mug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757621898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=acc6cGeH1f8fveTaLJ8eW4iIDAFHsW3FUsNmOwASx8Y=;
	b=h4MFgrThbpg2snTEsq7qdIDlnp0onNKEWwqkjg9Kq8iRTnReq8+IHdWlBML884bXcN44AE
	NLJiq4zYDSgrs2DA==
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
In-Reply-To: <159c984d-37fc-4b63-acf3-d0409c9b57cd@efficios.com>
References: <20250908225709.144709889@linutronix.de>
 <159c984d-37fc-4b63-acf3-d0409c9b57cd@efficios.com>
Date: Thu, 11 Sep 2025 22:18:16 +0200
Message-ID: <87plbwrbef.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 11 2025 at 11:27, Mathieu Desnoyers wrote:
> On 2025-09-08 18:59, Thomas Gleixner wrote:
>> If it is interrupted and the interrupt return path in the kernel observes a
>> rescheduling request, then the kernel can grant a time slice extension. The
>> kernel clears the REQUEST bit and sets the GRANTED bit with a simple
>> non-atomic store operation. If it does not grant the extension only the
>> REQUEST bit is cleared.
>> 
>> If user space observes the REQUEST bit cleared, when it finished the
>> critical section, then it has to check the GRANTED bit. If that is set,
>> then it has to invoke the rseq_slice_yield() syscall to terminate the
>
> Does it "have" to ? What is the consequence of misbehaving ?

It receives SIGSEGV because that means that it did not follow the rules
and stuck an arbitrary syscall into the critical section.

> I wonder if we could achieve this without the cpu-local atomic, and
> just rely on simple relaxed-atomic or volatile loads/stores and compiler
> barriers in userspace. Let's say we have:
>
> union {
> 	u16 slice_ctrl;
> 	struct {
> 		u8 rseq->slice_request;
> 		u8 rseq->slice_grant;

Interesting way to define a struct member :)

> 	};
> };
>
> With userspace doing:
>
> rseq->slice_request = true;  /* WRITE_ONCE() */
> barrier();
> critical_section();
> barrier();
> rseq->slice_request = false; /* WRITE_ONCE() */
> if (rseq->slice_grant)       /* READ_ONCE() */
>    rseq_slice_yield();

That should work as it's strictly CPU local. Good point, now that you
said it it's obvious :)

Let me rework it accordingly.

> In the kernel interrupt return path, if the kernel observes
> "rseq->slice_request" set and "rseq->slice_grant" cleared,
> it grants the extension and sets "rseq->slice_grant".

They can't be both set. If they are then user space fiddled with the
bits.

>>      - A futile attempt to make this "work" on the PREEMPT_LAZY preemption
>>        model which is utilized by PREEMPT_RT.
>
> Can you clarify why this attempt is "futile" ?

Because on RT interrupts usually end up with TIF_PREEMPT set either due
to softirqs or interrupt threads. And no, we don't want to
overcomplicate things right now to make it "work" for real-time tasks in
the first place as that's just going to result either endless
discussions or subtle latency problems or both. For now allowing it for
the 'LAZY' case is good enough.

With the non-RT LAZY model that's not really a good idea either, because
when TIF_PREEMPT is set, then either the preempting task is in a RT
class or the to be preempted task already has overrun the LAZY granted
computation time and the scheduler sets TIF_PREEMPT to whack it over the
head.

Thanks,

        tglx

