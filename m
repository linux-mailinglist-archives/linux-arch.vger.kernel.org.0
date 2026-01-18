Return-Path: <linux-arch+bounces-15844-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B047ED39441
	for <lists+linux-arch@lfdr.de>; Sun, 18 Jan 2026 11:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA4AA300727B
	for <lists+linux-arch@lfdr.de>; Sun, 18 Jan 2026 10:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E832DCF7B;
	Sun, 18 Jan 2026 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtoHKMgs"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B6C270545;
	Sun, 18 Jan 2026 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768733182; cv=none; b=bAy27LtafEDsZ7BojOr3JmQr8sbKxL2doxhe9o3u1kQUrWyoayx5/rJMbESlHXKUSJFxdJQ7Gxe8f8wXq6OYM9SkCIWCnwsZ244v/MlzzVoZrk5iqdddsCenxCDM6Q22+GQiyag+fyRuhNG9+/QZ+ShhxfYw/uW77+ciAORTdCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768733182; c=relaxed/simple;
	bh=hjWpmmhs2PbYtYrxpNGcT9bMRDBbHRhLgGMxRablJaE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dZArJPTSlMNCC954Kli8/KQYZvt3JGrfNZERHCgc4AYu5WxUs+fC3ygRt9nrPh9aWcqGBUVhgMqoRboQ025hG9dUAYk7YRt7GVq7Pw4nYorGV6vvSzWm6xX1kGcjPbOT2ODb9/O+7Mw2u9Ywi1fG8erjtLxfZGgs4o01DhHTAJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtoHKMgs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7889AC116D0;
	Sun, 18 Jan 2026 10:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768733182;
	bh=hjWpmmhs2PbYtYrxpNGcT9bMRDBbHRhLgGMxRablJaE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WtoHKMgsU4cYA82z07xFd8OTQElMXH9p6VOMq1eqFSAERDplwzUhxImUUdZ2P1R0k
	 uFqnHFR5D12DUn1h4CNUalm9P6cybbsog1vJN8GKxnMIWt0ir0xIEl5q92UwDtoZLY
	 HaHqN7PEXjZFU3gpsNMPZe4QnhiRvHeeeboBm/Fd3cBrZHKdowRS2c5VnfN8Xpo5xR
	 XxH/7Smc2TY7gYInaNBQIlVhhVhi/cjkKWL0Qv7inZv+1C7Yh0FXws/irsuKgCV57E
	 2qQ+D5In6yWhTUKeq27xjpoURzs1AbtSLcDjGuhzuNs4axSmTtvB2YA9w8Zl3G8I20
	 D9L5fIBUMh1PQ==
From: Thomas Gleixner <tglx@kernel.org>
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
In-Reply-To: <20260116181524.GF831285@noisy.programming.kicks-ass.net>
References: <20251215155615.870031952@linutronix.de>
 <20251215155709.068329497@linutronix.de>
 <20251218150524.GY3707837@noisy.programming.kicks-ass.net>
 <87ecorbccp.ffs@tglx>
 <20251219100517.GA1132199@noisy.programming.kicks-ass.net>
 <20260116181524.GF831285@noisy.programming.kicks-ass.net>
Date: Sun, 18 Jan 2026 11:46:18 +0100
Message-ID: <87zf6b19mt.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jan 16 2026 at 19:15, Peter Zijlstra wrote:
> On Fri, Dec 19, 2025 at 11:05:17AM +0100, Peter Zijlstra wrote:
>
>> I was thinking that perhaps the hrtimer tracepoints, filtered on this
>> specific timer, might just do. Arming the timer is the point where the
>> extension is granted, cancelling the timer is on the slice_yield() (or
>> any other random syscall :/), and the timer actually firing is on fail.
>
> Here, I google pasted this together. I don't actually speak much snake
> (as you well know). Nor does it fully work; the handle_expire() thing is
> busted, I definitely have expire entries in the trace, but they're not
> showing up.

You want the below. Then you get:

Task: slice_test    Mean: 350.266 ns
  Latency (us)    | Count
  ------------------------------
  EXPIRED         | 238
  0 us            | 143189
  1 us            | 167
  2 us            | 26
  3 us            | 11
  4 us            | 28
  5 us            | 31
  6 us            | 22
  7 us            | 23
  8 us            | 32
  9 us            | 16
  10 us           | 35

Thanks

        tglx
---
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1742,7 +1742,7 @@ static void __run_hrtimer(struct hrtimer
 
 	lockdep_assert_held(&cpu_base->lock);
 
-	debug_deactivate(timer);
+	debug_hrtimer_deactivate(timer);
 	base->running = timer;
 
 	/*

