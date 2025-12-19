Return-Path: <linux-arch+bounces-15514-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B235FCCF49A
	for <lists+linux-arch@lfdr.de>; Fri, 19 Dec 2025 11:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60C0C30AEE83
	for <lists+linux-arch@lfdr.de>; Fri, 19 Dec 2025 10:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8AF1E1DE9;
	Fri, 19 Dec 2025 10:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ACcdzpdu"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659EF2ECE85;
	Fri, 19 Dec 2025 10:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766138737; cv=none; b=YH6VtR0C19RW8FL1tZY8wLGN1WOd/FPVvLBXjwTum7qyq/n7F+4k4l8+zXe/iBHEUjSYH3eAvVV+4b72+qxPOUKxXNg0WGYSwjrbhb9vi6TFS3SVpjTmsFj8Mn96kXLiE2vSEZrTNaXDHBqGn9r2Xi3oWzOxel9jLt5JERt3rj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766138737; c=relaxed/simple;
	bh=9dm8BaywtI/wsDAKb2LyWSSzdxIWbQnPRWdTdUPGpJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImKSIkIahh8lR3XSPwcsr0WHK1jDeCy+zykTri0GekWU3UFI9rjgJho1aBQ5Zed1+nN2SkYsR2ZW+v0ocbhscZYVygIfHOthZtOHe9UIQjtOPYo3Zmw3Zxo3k2uXjRjj4E4/hy+fsSwZKw++w1LBpQ1UcGofF3Fs9t/AznuB0kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ACcdzpdu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=LMappvxlAVQv3ofQFnpb3f7wYAH9H1sYPpsNVzsHQYk=; b=ACcdzpdu5HuC11809N+Y+Elbi+
	AgOfGKB6Cpf3XyT7kZ7PKRZCF7eTenno6orvWfl9C+MpLTW1DLArKsAGpwcyFTE5cln7T0C/Ys0Sc
	GLU9KVbaiaIJmDYRLvsSP1llaOMh7Gl5vcGA08Dc7ZSqpUF4SKUeYS6UnGsFMg6066vtWqjBIud9X
	OMItdNNJk6+SN/OJ73LVprgL+HKDu4nBgF0/3KzHih/lNtN7AMPRDZxX9GiQQwkcy+XZUPgx6FHin
	RkHrCfe1MqiYd+ASzYs9R/huKYKNA2+dCRlkB0ICX85otq2ZxLdQaCtpFYh9qDlMpGKztVbegdPiU
	LpeUwtwg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWXMN-00000007PPv-2oFJ;
	Fri, 19 Dec 2025 10:05:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7387030057C; Fri, 19 Dec 2025 11:05:17 +0100 (CET)
Date: Fri, 19 Dec 2025 11:05:17 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Prakash Sangappa <prakash.sangappa@oracle.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Ron Geva <rongevarg@gmail.com>, Waiman Long <longman@redhat.com>
Subject: Re: [patch V6 07/11] rseq: Implement time slice extension
 enforcement timer
Message-ID: <20251219100517.GA1132199@noisy.programming.kicks-ass.net>
References: <20251215155615.870031952@linutronix.de>
 <20251215155709.068329497@linutronix.de>
 <20251218150524.GY3707837@noisy.programming.kicks-ass.net>
 <87ecorbccp.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ecorbccp.ffs@tglx>

On Fri, Dec 19, 2025 at 12:26:46AM +0100, Thomas Gleixner wrote:
> On Thu, Dec 18 2025 at 16:05, Peter Zijlstra wrote:
> > On Mon, Dec 15, 2025 at 05:52:22PM +0100, Thomas Gleixner wrote:
> >
> >> V5: Document the slice extension range - PeterZ
> >
> >> --- a/Documentation/admin-guide/sysctl/kernel.rst
> >> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> >> @@ -1228,6 +1228,14 @@ reboot-cmd (SPARC only)
> >>  ROM/Flash boot loader. Maybe to tell it what to do after
> >>  rebooting. ???
> >>  
> >> +rseq_slice_extension_nsec
> >> +=========================
> >> +
> >> +A task can request to delay its scheduling if it is in a critical section
> >> +via the prctl(PR_RSEQ_SLICE_EXTENSION_SET) mechanism. This sets the maximum
> >> +allowed extension in nanoseconds before scheduling of the task is enforced.
> >> +Default value is 30000ns (30us). The possible range is 10000ns (10us) to
> >> +50000ns (50us).
> >
> > The important bit: we're not going to increase these numbers. If
> > anything, I would like the default to be 10us and taint the kernel if
> > you up it.
> 
> Fine with me.

Thanks; the thinking is that it will be very hard to shrink this number
due to unknown workloads in the wild and all that, so starting on the
small end is the conservative option.

> > I also think we want some tracing/tool to find the actual length of the
> > extension used (min/avg/max etc.). That is the time between the kernel
> > finding the extension bit set and arming the timer and the slice_yield()
> > syscall.
> 
> I could probably integrate that easily into the RSEQ stats mechanism.

I was thinking that perhaps the hrtimer tracepoints, filtered on this
specific timer, might just do. Arming the timer is the point where the
extension is granted, cancelling the timer is on the slice_yield() (or
any other random syscall :/), and the timer actually firing is on fail.

Normally I would suggest using a Poison distribution to find the
'average', but this case is more complicated because the start of the
extension is lost.

Let me ask one of these fancy AI things. Ah, it says this is "a classic
example of Length-Biased Sampling combined with Left-Truncation". It
then further suggests:

  If you cannot assume a distribution, you should use a Weighting
  Method.  Since the probability of catching an event of length L is
  proportional to L, you must weight each observation by 1/L.

      1. For each event, record the observed duration d_i

      2. Calculate the weighted mean:

			    \Sum (d_i * 1/d_i)      n
	      avg(x)_true = ------------------ = ----------
				\Sum 1/d_i       \Sum 1/d_i

      This is the Harmonic Mean of your observed durations. The harmonic
      mean effectively "penalizes" the long events you were more likely to
      catch.

It also babbled something about an Inspection Paradox:

  If your sampling rate is constant (a Poisson process) and the system is
  in a "steady state," the most robust and mathematically elegant way to
  find the true average duration (μ) is surprisingly simple.

  In a steady-state system where you catch an event in progress:

      The time from the start of the event to your arrival is U
      (unobserved).

      The time from your arrival to the end of the event is V (observed).

  Under these specific conditions, the expected value of the observed
  remaining duration (V) is exactly equal to the mean of the length-biased
  distribution. However, because long events are over-sampled, the mean of
  the durations you catch is actually higher than the true mean of all
  events. For many common distributions (like the Exponential
  distribution), the relationship is: μ=E[V]

  Wait, if you ignore the part you missed (U) and only average the parts
  you saw (V), you often arrive back at the true mean. This is known as
  the Inspection Paradox.

Now I suppose I should do the real research to see how much of that is a
hallucination :-)

