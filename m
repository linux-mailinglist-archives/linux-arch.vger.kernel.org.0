Return-Path: <linux-arch+bounces-14451-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F93AC26F6F
	for <lists+linux-arch@lfdr.de>; Fri, 31 Oct 2025 21:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D20E1404C92
	for <lists+linux-arch@lfdr.de>; Fri, 31 Oct 2025 20:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68A9328B72;
	Fri, 31 Oct 2025 20:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JiiZeOL/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DVT74glT"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B101320CDF;
	Fri, 31 Oct 2025 20:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761944337; cv=none; b=Q9qvn0xlQImxnJdzuqxAgADsWsCkk2S5aJKOKq3bJm8U77Yzz8uwkbzfahRS0uPPLluo5ccBKx49pksyx5KKFSuUrHMxKjRJaFnp2CYVToyO7m0+2Js6NemniIeudeyhAEvqJQTbl4XhfnWrsN5VQJX2QYXhLOQ6B8EOshvYQFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761944337; c=relaxed/simple;
	bh=ieFxzP0bgHh5TpzcBPfpmaihnIr1CIE2W8RqnM27EeE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n7R7O+AWhbNzee0IjEtbRPwKJ0cBNs0UjjeX4eXgeiaBCXU1RXPZboiCsqZ9C6Hhreb5sm7Qjnt24tlAG3Pn9bkxdG0r1l2xCVBvSDGGldtS1CpxQjUJtUkudx1px84mrZHZhVQ8VcdjbqvYpOKRnXlOJxLcI0d/YpZ0F/Ds3Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JiiZeOL/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DVT74glT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761944333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oDlOpN7T7bvpG0U+BGICtGoFwGEppX8i/sApHshtWww=;
	b=JiiZeOL/qU/cZxz6hVYO4z8bF6trYvl8RtseXHyoE6VhZauj7rKQFbHEUsA333eZqnDsUj
	2b2C0Qv8haIs+5DuOu+NEILU6X2UjGJKOBuV28bX7Wtocmf92NpNGJThkd8na+YHTb1Ip3
	F0PrGQbHoXCekV/iuubDbidlgTxx/eom4Ln12zg660ymSFX8ePYr3GaPXKCou1eD5lGgC7
	DA77jxH1VL0J2w6y/FAviH9/LxNlhTd7c1dXLOWbgT4Dno6kT0T/yCuFR57qHoRiLOCOKP
	7Ch4Wk8CElurmpCsenondHSyOUmvMG2l1HH8Vg86dhy7dyfI0KDJ8VvZ+sBGkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761944333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oDlOpN7T7bvpG0U+BGICtGoFwGEppX8i/sApHshtWww=;
	b=DVT74glTff+Pii/9fCkZtDn4szWh4qHfhQjuAG0EAchrfE1GVpIjoCpmASWU9nelLULVG1
	ZaKVrVIecOu0z7Dg==
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Prakash Sangappa <prakash.sangappa@oracle.com>, Madadi
 Vineeth Reddy <vineethr@linux.ibm.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>, Steven Rostedt <rostedt@goodmis.org>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org
Subject: Re: [patch V3 02/12] rseq: Add fields and constants for time slice
 extension
In-Reply-To: <7e44ca0b-e898-4b7f-aaaa-30d8ac52c643@efficios.com>
References: <20251029125514.496134233@linutronix.de>
 <20251029130403.542731428@linutronix.de>
 <7e44ca0b-e898-4b7f-aaaa-30d8ac52c643@efficios.com>
Date: Fri, 31 Oct 2025 21:58:52 +0100
Message-ID: <87bjlmss8j.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Oct 31 2025 at 15:31, Mathieu Desnoyers wrote:
> On 2025-10-29 09:22, Thomas Gleixner wrote:
> [...]
>> +
>> +The thread has to enable the functionality via prctl(2)::
>> +
>> +    prctl(PR_RSEQ_SLICE_EXTENSION, PR_RSEQ_SLICE_EXTENSION_SET,
>> +          PR_RSEQ_SLICE_EXT_ENABLE, 0, 0);
>
> Enabling specifically for each thread requires hooking into thread
> creation, and is not a good fit for enabling this from executable or
> library constructor function.

Where is the problem? It's not rocket science to handle that in user
space.

> What is the use-case for enabling it only for a few threads within
> a process rather than for the entire process ?

My general approach to all of this is to reduce overhead by default and
to provide the ability of fine grained control.

Using time slice extensions requires special care and a use case which
justifies the extra work to be done. So those people really can be asked
to do the extra work of enabling it, no?

I really don't get your attitude of enabling everything by default and
thereby inflicting the maximum amount of overhead on everything.

I've just wasted weeks to cure the fallout of that approach and it's
still unsatisfying because the whole CID management crud and related
overhead is there unconditionally with exactly zero users on any
distro. The special use cases of the uncompilable gurgle tcmalloc and
the esoteric librseq are not a justification at all to inflict that on
everyone.

Sadly nobody noticed when this got merged and now with RSEQ being widely
used by glibc it's even harder to turn the clock back. I'm still tempted
to break this half thought out ABI and make CID opt-in and default to
CID = CPUID if not activated.

Seriously the kernel is there to manage resources and provide resource
control, but it's not there to accomodate the laziness of user space
programmers and to proliferate the 'I envision this to be widely used'
wishful thinking mindset.

That said I'm not completely against making this per process, but then
it has to be enabled on the main thread _before_ it spawns threads and
rejected otherwise.

That said I just went down the obvious road of making it opt-in and
therefore low overhead and flexible by default. That is correct, simple
and straight forward. No?

Thanks,

        tglx









