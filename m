Return-Path: <linux-arch+bounces-15507-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE47CCDEE2
	for <lists+linux-arch@lfdr.de>; Fri, 19 Dec 2025 00:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71C7A30194F4
	for <lists+linux-arch@lfdr.de>; Thu, 18 Dec 2025 23:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D013B298CBC;
	Thu, 18 Dec 2025 23:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DBRIq7Jb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MqBCKQy1"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC2C27CB0A;
	Thu, 18 Dec 2025 23:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766100415; cv=none; b=OrLo95Ey+p+vYLRifE8I4nS9FaJFqWgr4ptWVEoB8zt7h+Tk3KvHxHAh/qClooHOciE/gW5B58PB1thanf7qY/1YsyHtZjsAg/I6bgUbXP2Cwdqa29Q6L+HjU+xZ09+Pt6LmlntkZTopqybIpdnqM1DLiEpMzhuV+BuyN8xtbRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766100415; c=relaxed/simple;
	bh=Fo5W4bpyM2z8d/Yf0yZFbrCWZaKnXfARDrEinI83OmI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jU0+VATUC5kVyFZ3eQeYEOxAX3NCp8W6+p4LJX84PVd5PBRw9kG9Y80tFK4YpG5KmazvcBqq3IvU1szII33vsSS9LUWyfzRv8uHbIjkqVOEwGSsyg/Z40I68pMfNxuU1K90xRR6r8ipCofuTok9crXAyA13usuE5X/dWgl+Jjn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DBRIq7Jb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MqBCKQy1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766100407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/t5NTGmkTJfu4RQuBq9I6q4a3LCulzlXyeadLF8QzZ0=;
	b=DBRIq7Jbs6VaYLkaF1WH0DhA+bR8VJ+Z0Vzv3J1UjIMgJG53Br5qvF7jFaCk06KvS4fhVV
	vwNBGTKf56gDZzA0uHGBmOM00vT10z953p86cutUnRe2VpnbxdVTo2BrHlDeJr5F6Up4x4
	KqvBK6Rlm5vYjf6hcvE6xfn9l2kZlmrIRKLeYGgYvXueSptxW7ekoVSbAiUtnWehiWYAI/
	tQsFAx9mwpi9JNMqwIF54+FXpjr+znfCf/VHwyoHPk8uHSI8Fag4Wp1wxyIGuInrX/EXJ7
	VWavSptqqZ4kRs0Y1AxnyecfdAXH1Q/FL7YIyaWTXyTB9/h0rpt6ahVDhr3OtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766100407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/t5NTGmkTJfu4RQuBq9I6q4a3LCulzlXyeadLF8QzZ0=;
	b=MqBCKQy1oSsbMSrJRtMj97K2Dj74lUGzPtcw4SMXAFW49IjSmLK+k5DJKnSOZM0WLF/h+6
	7WL4iFyv2hdL7mCg==
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
In-Reply-To: <20251218150524.GY3707837@noisy.programming.kicks-ass.net>
References: <20251215155615.870031952@linutronix.de>
 <20251215155709.068329497@linutronix.de>
 <20251218150524.GY3707837@noisy.programming.kicks-ass.net>
Date: Fri, 19 Dec 2025 00:26:46 +0100
Message-ID: <87ecorbccp.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Dec 18 2025 at 16:05, Peter Zijlstra wrote:
> On Mon, Dec 15, 2025 at 05:52:22PM +0100, Thomas Gleixner wrote:
>
>> V5: Document the slice extension range - PeterZ
>
>> --- a/Documentation/admin-guide/sysctl/kernel.rst
>> +++ b/Documentation/admin-guide/sysctl/kernel.rst
>> @@ -1228,6 +1228,14 @@ reboot-cmd (SPARC only)
>>  ROM/Flash boot loader. Maybe to tell it what to do after
>>  rebooting. ???
>>  
>> +rseq_slice_extension_nsec
>> +=========================
>> +
>> +A task can request to delay its scheduling if it is in a critical section
>> +via the prctl(PR_RSEQ_SLICE_EXTENSION_SET) mechanism. This sets the maximum
>> +allowed extension in nanoseconds before scheduling of the task is enforced.
>> +Default value is 30000ns (30us). The possible range is 10000ns (10us) to
>> +50000ns (50us).
>
> The important bit: we're not going to increase these numbers. If
> anything, I would like the default to be 10us and taint the kernel if
> you up it.

Fine with me.

> I also think we want some tracing/tool to find the actual length of the
> extension used (min/avg/max etc.). That is the time between the kernel
> finding the extension bit set and arming the timer and the slice_yield()
> syscall.

I could probably integrate that easily into the RSEQ stats mechanism.

Thanks,

        tglx

