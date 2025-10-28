Return-Path: <linux-arch+bounces-14374-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1ACDC13A46
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 09:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B14624003AE
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 08:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2812D28E571;
	Tue, 28 Oct 2025 08:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WEAEtgo3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XTzHrhT9"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD281F4CB3;
	Tue, 28 Oct 2025 08:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641590; cv=none; b=dlZ+Lv7Z/vPZdMw5XoNKLl5muNvfCJdcT55z3jcmWbHwrNNInq/DAqIp6FqEX+/KYl5or6ivHkIjrUb/7OyqF7d0xsvdKTsvtf1oNUtbzdqJtlyHF6UFknyhoN3H43gv1eu4c5Fc/FIOSw0F44OowXBeaMnIFQrgv4tXkfT+b+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641590; c=relaxed/simple;
	bh=dA3k4EoqsfWhaM54pAEeF2cKY1fRrVAI0rCky7jUPFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYKF6cJc1zZG5GvMeY3KwguLoyYJq8O+Tziju86WU8Sk+GT+MLncpKNcW9SF5a14LrTSKKOq0f+eyTmmV8rzbTfYz8ZK+VaB7gcllZGTvdqJe1Beo5AMr/t6qU8jv/OeHPtiZUPXgLnOgiqa2uKeyqHJDd5L3piVyakeYOkFv1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WEAEtgo3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XTzHrhT9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 28 Oct 2025 09:53:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761641584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TthOS8+FpeS9aTdVCrSUI7ecvjKtwF4rB/2AM+7BU64=;
	b=WEAEtgo3AVucVBi518Dw4wCYtePZ0dxrd/nvPIGU7bs9iQ4kpnKiVErU1XWr4pei+Av5bg
	RhCC0BFp+h34Afk2oKvRk6Gs//Pllc4FgrNXc6j+THVTAYkRInkgGzdR3UtoNJzNvCd2xu
	Xb+v9De+4WZo8qP+ay6WVv8rxsuB15nsms1Oc1ZjF+WMAI7cDabj9Q9p+uTP8pt7nciI5L
	mmRvP76tSeESyvVocP9JjGqTzHO1bNt1y3JQMUrlJ5x4ab6QA/XS1sya4Bia0Tx6T1YdHB
	VDZEfo8b05vMcgjvlrijY7ShSsoyP4I/3/8jvIyYE5nQaPJahGfuo266tkuPsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761641584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TthOS8+FpeS9aTdVCrSUI7ecvjKtwF4rB/2AM+7BU64=;
	b=XTzHrhT99pw9IA+rF8B9PSkc9Clt8z98Z1d6o3jc3HSLPw5S9VNLEAQTJvIHsM+LH2acur
	+F4ZleQElQXSPpAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zilstra <peterz@infradead.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Prakash Sangappa <prakash.sangappa@oracle.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Steven Rostedt <rostedt@goodmis.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org
Subject: Re: [patch V2 00/12] rseq: Implement time slice extension mechanism
Message-ID: <20251028085303.ut6C2XgR@linutronix.de>
References: <20251022110646.839870156@linutronix.de>
 <20251027173037.Cj4b_alm@linutronix.de>
 <87wm4guqnb.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wm4guqnb.ffs@tglx>

On 2025-10-27 19:48:56 [+0100], Thomas Gleixner wrote:
> 
> Tracing of the syscall happens _after_ syscall_trace_enter() invoked
> rseq_syscall_enter_work() which canceled the timer and set
> NEED_RESCHED. That immediately rescheduled _after_ the preempt enable:
> 
>   syscall()
>     do_syscall_64()
>       syscall_enter_from_user_mode() {
>         syscall_enter_from_user_mode_work()
>           syscall_trace_enter()
>             rseq_syscall_enter_work()
>               preempt_disable()
>               hrtimer_try_to_cancel()
>                 remove_hrtimer()                <- tracepoint
>               set_need_resched()
>               preempt_enable()
>                 schedule()
>            ...
>            trace_sys_enter()                    <- tracepoint
> 
> Even if it would not reschedule immediately the ordering would be
> reverse.

I know that know after doing the tracing. But having only the sched
events looked like the slice gets granted and usecs later scheduling
happens. Adding interrupts and syscalls continued pointing to the wrong
direction.
Maybe the lack of events here is okay if you know what you do and what
to expect in terms of available trace events.

In that spirit, I did test it and didn't find anything wrong with it ;)

> Thanks,
> 
>         tglx

Sebastian

