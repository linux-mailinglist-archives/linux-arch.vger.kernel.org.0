Return-Path: <linux-arch+bounces-15851-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90540D3A41E
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 11:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 579D5303A1B2
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 10:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BDE2367D3;
	Mon, 19 Jan 2026 10:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hjdYwKDx"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B421E32CF;
	Mon, 19 Jan 2026 10:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768816931; cv=none; b=Vyl5UPZp+5txFgzkGjNuFJjpLFgOA0GJv9kBsWBFLUT/clThlmIF+RmahFXbfFFsfLJ0jHcgRKEqKmMElCPtcZJTMNM3N4OXGvu0fKQra42hk7lB3ird7Qz1/9191N9Pvr+f3y6BUGowuLeXZgUmEBDJ7W+ZHZDJA/oSSj4PrKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768816931; c=relaxed/simple;
	bh=pnEa4VrEeISlVZoQcuz8SHTYgHUKfSg2Cc8V9YYuxT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWkvC4Vuo4w0pKZ9Apjl5GuA0bny0GEPmz+ZSwOpcrAFUphtkUQAMfPkUEMZtguy+bNOE6xEULeZbw1eYozhaisOVt1BC0mosEPJC1F8q9JXHEOXy8TqNkQyVZ6AY/75pDPjyjBF6+6KC0no1C3/mKSN6W3ig3lsODAMUboHy+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hjdYwKDx; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qXOMWcP57YdkA+i9IBIoBnXaMzpom4V6rwMqCjGNerQ=; b=hjdYwKDxS2qcPazHW+3+Eqkkj3
	YE6Zl81cEwSRwQNkfSYtmQUIp3fLXdoVA2KqhVer9zMQDAjHCq9fPkFgFUIXYJq0tBlrlbQ+JzrAt
	Xmud/79wL8FQL95xdKBstVSn2bwhcj8ZAhDp6BMxL81T9+1Og4GZWp8j9TtECYP7B5ZfdY9l/KVFn
	H7oYT4GzqgypFGLe8nj5sq4Rhy0CoGs1lUaBnFvK3UuA94Lf7sopB4AB9ukGZR3CzwElTjzpZdcmC
	yb/FitY8ldcGGlv1nOT9Drg9RfQxm/JwddZhUJEeWRJ5wRreAvXjhDgRJu7ogcuEKZC8Jk5SlDPtw
	WHSaoYeg==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhm4u-0000000D86P-2dgS;
	Mon, 19 Jan 2026 10:01:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6D3B23006CD; Mon, 19 Jan 2026 11:01:43 +0100 (CET)
Date: Mon, 19 Jan 2026 11:01:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@kernel.org>
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
Message-ID: <20260119100143.GO830755@noisy.programming.kicks-ass.net>
References: <20251215155615.870031952@linutronix.de>
 <20251215155709.068329497@linutronix.de>
 <20251218150524.GY3707837@noisy.programming.kicks-ass.net>
 <87ecorbccp.ffs@tglx>
 <20251219100517.GA1132199@noisy.programming.kicks-ass.net>
 <20260116181524.GF831285@noisy.programming.kicks-ass.net>
 <87zf6b19mt.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zf6b19mt.ffs@tglx>

On Sun, Jan 18, 2026 at 11:46:18AM +0100, Thomas Gleixner wrote:
> On Fri, Jan 16 2026 at 19:15, Peter Zijlstra wrote:
> > On Fri, Dec 19, 2025 at 11:05:17AM +0100, Peter Zijlstra wrote:
> >
> >> I was thinking that perhaps the hrtimer tracepoints, filtered on this
> >> specific timer, might just do. Arming the timer is the point where the
> >> extension is granted, cancelling the timer is on the slice_yield() (or
> >> any other random syscall :/), and the timer actually firing is on fail.
> >
> > Here, I google pasted this together. I don't actually speak much snake
> > (as you well know). Nor does it fully work; the handle_expire() thing is
> > busted, I definitely have expire entries in the trace, but they're not
> > showing up.
> 
> You want the below. Then you get:
> 
> Task: slice_test    Mean: 350.266 ns
>   Latency (us)    | Count
>   ------------------------------
>   EXPIRED         | 238
>   0 us            | 143189
>   1 us            | 167
>   2 us            | 26
>   3 us            | 11
>   4 us            | 28
>   5 us            | 31
>   6 us            | 22
>   7 us            | 23
>   8 us            | 32
>   9 us            | 16
>   10 us           | 35
> 
> Thanks
> 
>         tglx
> ---
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -1742,7 +1742,7 @@ static void __run_hrtimer(struct hrtimer
>  
>  	lockdep_assert_held(&cpu_base->lock);
>  
> -	debug_deactivate(timer);
> +	debug_hrtimer_deactivate(timer);
>  	base->running = timer;

D'0h.

I suppose doing this makes more sense than fixing the script. Want me to
write it up?

