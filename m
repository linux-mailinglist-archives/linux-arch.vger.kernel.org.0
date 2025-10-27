Return-Path: <linux-arch+bounces-14358-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E320CC10516
	for <lists+linux-arch@lfdr.de>; Mon, 27 Oct 2025 19:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2466056276F
	for <lists+linux-arch@lfdr.de>; Mon, 27 Oct 2025 18:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3D432D434;
	Mon, 27 Oct 2025 18:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lcgc6fnu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X9Wz0vi7"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923C832C956;
	Mon, 27 Oct 2025 18:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761590943; cv=none; b=CiAh8FYuFl0tdRTyOCkgnDE6lrWky0SMpxl+AsgZGRroX6pKwbNR8KHDW8M+b1HyXxd16srT/xb26gGeOOP80wuvH7NB6LnEceYdTOICmRLtqLo1LtlUOqz7taE6kY3KNruPxhnb6xTRhYzheSJA8iSiYaPMVQXRcLGPbaGXQrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761590943; c=relaxed/simple;
	bh=Rr8cZ1bJDuPsNGv9cwNRpcZ0bWFDiAXJQm4BZxYNtxU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QjKd/M9x/r+ppOdYxzRKEQV3Tf74b/b/dTNKbnyY3S78j2iEF5X6133POIwoExUEz9fhecJmRu78rcJzjKGO1pYuXR9f5Cj54TozVvrm7po/KRl2GP2k0WNUzXYIZk/FZ3GMXAT1UQCjiz82SNBzgDJzGtiN03zNfYyWub91DFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lcgc6fnu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X9Wz0vi7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761590937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ZYVUru8TILHqr330R5FmSM+rR0QuSBe8jHzGc/RYNA=;
	b=lcgc6fnu2WLeleH5HLZL2pmtPZzNdvsao3lV4YZp8JE1so323UOPo00x2/FPaRnr3siZC+
	6E98bUiIpB6pMVFIzFwxwUN3z6yrOLQTygEdTDuTTCLfHrhnFBWqHeLLQUORR2O45lYKlh
	L1X0Bp0zdOoaYzepTr9QUHyJd6gex0TKvj3raYm4Wxwmir1CisYFwAHwVuoaaB/3evxJZD
	G+dLTlxAwbUhduGWDvhOvKHFXBiYiQjggLnc4QThlQuO5V9bAUcBXLR0CysK631NulC2Hr
	CBeKrCHojTDsnFiOmp4HLR3iyKBhe6EHGn+MurL3Uj5cWM549NR0zZpnjqQlzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761590937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ZYVUru8TILHqr330R5FmSM+rR0QuSBe8jHzGc/RYNA=;
	b=X9Wz0vi7+Cz311JzS4nGxo1GxiEl+9ghRakG66bT9OlrEYToImn7s52TifYDgtCH6WYRsV
	hu+vn0BfJlhEwcAg==
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zilstra
 <peterz@infradead.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Prakash Sangappa <prakash.sangappa@oracle.com>, Madadi Vineeth Reddy
 <vineethr@linux.ibm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Steven
 Rostedt <rostedt@goodmis.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org
Subject: Re: [patch V2 00/12] rseq: Implement time slice extension mechanism
In-Reply-To: <20251027173037.Cj4b_alm@linutronix.de>
References: <20251022110646.839870156@linutronix.de>
 <20251027173037.Cj4b_alm@linutronix.de>
Date: Mon, 27 Oct 2025 19:48:56 +0100
Message-ID: <87wm4guqnb.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 27 2025 at 18:30, Sebastian Andrzej Siewior wrote:

> |       slice_test-2903    [001] d..2.  2313.285484: hrtimer_cancel: hrtimer=0000000030a688cc
> extension granted, timer started and revoked and set need resched.
>
> |       slice_test-2903    [001] dN.2.  2313.285487: sched_stat_runtime: comm=slice_test pid=2903 runtime=36886 [ns]
> This is coming from schedule() already. It took me a while since I was
> hunting a missing clear of need-resched.
>
> |       slice_test-2903    [001] d..2.  2313.285489: sched_switch: prev_comm=slice_test prev_pid=2903 prev_prio=120 prev_state=R+ ==> next_comm=ksoftirqd/1 next_pid=32 next_prio=120
> |      ksoftirqd/1-32      [001] ..s.1  2313.285490: softirq_entry: vec=7 [action=SCHED]
> |      ksoftirqd/1-32      [001] ..s.1  2313.285501: softirq_exit: vec=7 [action=SCHED]
> |      ksoftirqd/1-32      [001] d..2.  2313.285502: sched_stat_runtime: comm=ksoftirqd/1 pid=32 runtime=16438 [ns]
> |      ksoftirqd/1-32      [001] d..2.  2313.285503: sched_switch: prev_comm=ksoftirqd/1 prev_pid=32 prev_prio=120 prev_state=S ==> next_comm=slice_test next_pid=2904 next_prio=120
> |       slice_test-2904    [001] .....  2313.285507: sys_enter: NR 230 (1, 0, 7f4692c7baa0, 0, 0, 0)
> |       slice_test-2904    [001] .....  2313.285507: hrtimer_setup: hrtimer=00000000f2d53899 clockid=CLOCK_MONOTONIC mode=REL
> |       slice_test-2904    [001] d..1.  2313.285507: hrtimer_start: hrtimer=00000000f2d53899 function=hrtimer_wakeup expires=2313208168792 softexpires=2313208118792 mode=REL
> |       slice_test-2904    [001] d..2.  2313.285508: sched_stat_runtime: comm=slice_test pid=2904 runtime=6149 [ns]
> |       slice_test-2904    [001] d..2.  2313.285510: sched_switch: prev_comm=slice_test prev_pid=2904 prev_prio=120 prev_state=S ==> next_comm=slice_test next_pid=2903 next_prio=120
> |       slice_test-2903    [001] .....  2313.285510: sys_enter: NR 470 (7fffc04f1ff0, c350, 11a0e0, 0, 7f4692e99000, 0)
>
> slice_test-2903 enters _now_ rseq_slice_yield() so it must have been in
> userland during the suppressed wake up at 2313.285457.
> But a few iterations later it turns at out this trace event is recorded
> _after_ the rseq magic happens at sys_enter time. We entered
> rseq_slice_yield() a few cycles after the extension was granted. Buh.
> So it seems to work as intended but it is not obvious tell from tracing
> why it does not work.

Tracing of the syscall happens _after_ syscall_trace_enter() invoked
rseq_syscall_enter_work() which canceled the timer and set
NEED_RESCHED. That immediately rescheduled _after_ the preempt enable:

  syscall()
    do_syscall_64()
      syscall_enter_from_user_mode() {
        syscall_enter_from_user_mode_work()
          syscall_trace_enter()
            rseq_syscall_enter_work()
              preempt_disable()
              hrtimer_try_to_cancel()
                remove_hrtimer()                <- tracepoint
              set_need_resched()
              preempt_enable()
                schedule()
           ...
           trace_sys_enter()                    <- tracepoint

Even if it would not reschedule immediately the ordering would be
reverse.

Thanks,

        tglx

