Return-Path: <linux-arch+bounces-15506-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57320CCDED0
	for <lists+linux-arch@lfdr.de>; Fri, 19 Dec 2025 00:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D99B301B2E3
	for <lists+linux-arch@lfdr.de>; Thu, 18 Dec 2025 23:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286CE271464;
	Thu, 18 Dec 2025 23:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jNzd1ftm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oZusioOc"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7A0213254;
	Thu, 18 Dec 2025 23:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766100320; cv=none; b=OwIrLn0b3vWi+ImLiCPPIirY8s+xHLWHkFPpwZYJjB3clbRlhWXn65vLxmJiiRqiqeKV/09xoSbgnEjfnOQbufd/1CDN5Ina9lsZtan7vJqGG0RAPHZn81S00MMmEIBSfcsFhkUldeDS7ztvqaumAw9OsyUlM1OrT6Oj2gdh3WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766100320; c=relaxed/simple;
	bh=OaCz5rho57wCk9myVZynwe9opvM8HKjwv9dDuqIWSww=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j5RwwANGpYtI9z3W6iuj8dkMr+7EeBiKkM/S7yEzVyyvFhQLdhFl1K0RPF8hQ7Qn4VE4BCjpGr34Gr66IWMxPJBK5elf7zTbeCS7XxLsML0qulHnGSrGXdI69XltYosyCVUiPziB1KGjVx3vPFBGoU+IGbCW5XzYCAnrSk66jsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jNzd1ftm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oZusioOc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766100315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1SmrG+NCKzmKEEa+6igvuFA1RhxhYiwkBl0XBSYywJc=;
	b=jNzd1ftmuxSWVfikKQMCpEUEa8Hd7dJJJLKslv8Xz5LFUF+UEc3L9haaBLAHHCGtRlbss3
	/V7wAQZ6ajZHoE/eZD3lEEVZtJbdki6Ln4vyVAI2vYxmpOM5Z+y+SMynv2XskRxhvq9Cbb
	ynDa8yJhDwXTFZ88hbngywvLVJbr1a3kGz2T3wP5GjarS+I4iQ1TTNSZ3Z9Ji6UedP0iKB
	yilFXpwDHB7mP//3x89+gw+PRYziT1h0OExRimkN1Dod7N/LDFTlYiHg6rZYT467curU0/
	L4pNot3GIT6DCvDW9zGGUamo7auqEiblZei/JCgYNk/LyUbckSezweJeQEN+EA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766100315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1SmrG+NCKzmKEEa+6igvuFA1RhxhYiwkBl0XBSYywJc=;
	b=oZusioOcvpSZb1PJe9rqkaRXvb6kUWgFTyZEGJpTYLCnGT6ymjxs1d3nPBEEyDtYziujnE
	o2zRqRTlebbaTJBw==
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Prakash Sangappa <prakash.sangappa@oracle.com>, Madadi Vineeth Reddy
 <vineethr@linux.ibm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Steven
 Rostedt <rostedt@goodmis.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, Ron Geva
 <rongevarg@gmail.com>, Waiman Long <longman@redhat.com>
Subject: Re: [patch V6 07/11] rseq: Implement time slice extension
 enforcement timer
In-Reply-To: <20251218151833.GZ3707837@noisy.programming.kicks-ass.net>
References: <20251215155615.870031952@linutronix.de>
 <20251215155709.068329497@linutronix.de>
 <20251218151833.GZ3707837@noisy.programming.kicks-ass.net>
Date: Fri, 19 Dec 2025 00:25:14 +0100
Message-ID: <87h5tnbcf9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Dec 18 2025 at 16:18, Peter Zijlstra wrote:
> On Mon, Dec 15, 2025 at 05:52:22PM +0100, Thomas Gleixner wrote:
>
>> +static void rseq_cancel_slice_extension_timer(void)
>> +{
>> +	struct slice_timer *st = this_cpu_ptr(&slice_timer);
>> +
>> +	/*
>> +	 * st->cookie can be safely read as preemption is disabled and the
>> +	 * timer is CPU local.
>> +	 *
>> +	 * As this is most probably the first expiring timer, the cancel is
>> +	 * expensive as it has to reprogram the hardware, but that's less
>> +	 * expensive than going through a full hrtimer_interrupt() cycle
>> +	 * for nothing.
>
> So I have these hrtick patches that skip some of that reprogramming --
> at the cost of causing those spurious interrupts. Overall that was a
> win.
>
> Should we look at the cost of a spurious hrtimer interrupt? IIRC each
> base will stop at the first iteration if the timer is 'early', which
> wasn't that bad.

Correct, but it's still going to reprogram the timer, so contrary to
cancel this takes the full overhead of the interrupt and in this case
because the expiry is short it will trigger most of the time.

Thanks,

        tglx

