Return-Path: <linux-arch+bounces-13567-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C128CB56105
	for <lists+linux-arch@lfdr.de>; Sat, 13 Sep 2025 15:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EEBFA01836
	for <lists+linux-arch@lfdr.de>; Sat, 13 Sep 2025 13:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C269B21CA04;
	Sat, 13 Sep 2025 13:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eflKHWT2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l3fg+FaN"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9EA2EC573;
	Sat, 13 Sep 2025 13:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757768578; cv=none; b=cdg3mURsIODMkA1MhHp6RfN6Mf7zcaF1XRiozoW/xl7XaI2craPgR3pR7AXnjjzAxQjRBNsesEM7ACHEpXc1Wz0liwzpQy37W14ooaBO/x3PibcnpoHaorB80WEs2zCYEi71piEAHkYUoRfJWzIOc0IivlfMVOfLJT97iPVS660=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757768578; c=relaxed/simple;
	bh=cDcuciOscDOY7uYodziBIFL75IKyJ7hyqbGfVmH2k7A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fppBpTSnEaU5UABT/ooaP2qnk0q7w11hOQBRKx5KjMiQ7TkjfGF4m3wFuSH8HyPOrV/Vlja1zk/jC68Nu5h62Ue1+QXPgk/lvOtoCQgqFX3BF8OSq3mVMM/u1j2Np5fLcd0hf0TZS6LpczCESreckNCXUU325Ty+fjiiz5De3x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eflKHWT2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l3fg+FaN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757768573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gHlVUt8kQbE8EGvUw4N1Vb7/dUYSjnr6TDf3RdqDsvE=;
	b=eflKHWT2mKA33JFbvUzflkEUX9945+wAATCO0WQRQdrotfV/50s/uANua/s+EnS1Tnk+n+
	rEXxS9PkoecL5RUl0Z/TAX1n9yPnkLRP57mj03K9CZPjvvrFTtkBW5Ls2NMIh9QInvKZNR
	9UPSEUWEbyhD1eHZyBhY7ba4jdG7xMjV17UluBWH6qbAugmNM06nKdp13nP+AN8w99Q8nf
	3Sc1eu361u+NVmieLMahDPBURU11E/7L0MriAA5ltgo5CTMmsgS52/SOo9g9KZpOhQvL5+
	jzA/fPMp63fcmUiSjCoywL1sHsAWithAjYASYGMX/CqQNZNjGkT+2jaxXkuxnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757768573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gHlVUt8kQbE8EGvUw4N1Vb7/dUYSjnr6TDf3RdqDsvE=;
	b=l3fg+FaNgZGATP1yYXkmpRkrBkSm/F6v4PJM86dfiL1rRUednjMfOwBZomlGSYbq3XytOt
	AE6VU5R8yRrmWfAg==
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Peter Zilstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Prakash Sangappa <prakash.sangappa@oracle.com>, Madadi
 Vineeth Reddy <vineethr@linux.ibm.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>, Steven Rostedt <rostedt@goodmis.org>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, Florian Weimer <fweimer@redhat.com>,
 "carlos@redhat.com" <carlos@redhat.com>, libc-coord@lists.openwall.com
Subject: Re: [patch 00/12] rseq: Implement time slice extension mechanism
In-Reply-To: <a65dfd2c-b435-4d83-89d0-abc8002db7c7@efficios.com>
References: <20250908225709.144709889@linutronix.de>
 <159c984d-37fc-4b63-acf3-d0409c9b57cd@efficios.com> <87plbwrbef.ffs@tglx>
 <3d16490f-e4d3-4e91-af17-62018e789da9@efficios.com> <87a52zr5sv.ffs@tglx>
 <a65dfd2c-b435-4d83-89d0-abc8002db7c7@efficios.com>
Date: Sat, 13 Sep 2025 15:02:51 +0200
Message-ID: <874it6qzd0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Sep 12 2025 at 15:26, Mathieu Desnoyers wrote:
> On 2025-09-12 12:31, Thomas Gleixner wrote:
>>> 2) Slice requests are a good fit for locking. Locking typically
>>>      has nesting ability.
>>>
>>>      We should consider making the slice request ABI a 8-bit
>>>      or 16-bit nesting counter to allow nesting of its users.
>> 
>> Making request a counter requires to keep request set when the
>> extension is granted. So the states would be:
>> 
>>       request    granted
>>       0          0               Neutral
>>       >0         0               Requested
>>       >=0        1               Granted
>

Second thoughts on this.

Such a scheme means that slice_ctrl.request must be read only for the
kernel because otherwise the user space decrement would need to be an
atomic dec_if_not_zero(). We just argued the one atomic operation away. :)

That means, the kernel can only set and clear Granted. That in turn
loses the information whether a slice extension was denied or revoked,
which was something the Oracle people wanted to have. I'm not sure
whether that was a functional or more a instrumentation feature.

But what's worse: this is a receipe for disaster as it creates obviously
subtle and hard to debug ways to leak an increment, which means the
request would stay active forever defeating the whole purpose.

And no, the kernel cannot keep track of the counter and observe whether
it became zero at some point or not. You surely could come up with a
convoluted scheme to work around that in form of sequence counters or
whatever, but that just creates extra complexity for a very dubious
value.

The point is that the time slice extension is just providing an
opportunistic priority ceiling mechanism with low overhead and without
guarantees.

Once a request is not granted or revoked, the performance of that
particular operation goes south no matter what. Nesting does not help
there at all, which is a strong argument for using KISS as the primary
engineering principle here.

The simple boolean request/granted pair is simple and very well
defined. It does not suffer from any of those problems.

If user space wants nesting, then it can do so on its own without
creating an ill defined and fragile kernel/user ABI. We created enough
of them in the past and all of them resulted in long term headaches.

> Handling syscall within granted extension by killing the process

I'm absolutely not opposed to lift the syscall restriction to make
things easier, but this is the wrong argument for it:

> will likely reserve this feature to the niche use-cases.

Having this used only by people who actually know what they are doing is
actually the preferred outcome.

We've seen it over and over that supposedly "easy" features result in
mindless overutilization because everyone and his dog thinks they need
them just because and for the very wrong reasons. The unconditional
usage of the most power hungry floating point extensions just because
they are available, is only one example of many.

Thanks,

        tglx

