Return-Path: <linux-arch+bounces-15497-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6967CCC689
	for <lists+linux-arch@lfdr.de>; Thu, 18 Dec 2025 16:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A28D930A67D3
	for <lists+linux-arch@lfdr.de>; Thu, 18 Dec 2025 15:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100512DC783;
	Thu, 18 Dec 2025 15:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dLLE4R3b"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317A124DD1F;
	Thu, 18 Dec 2025 15:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766070342; cv=none; b=nb7EXNBhBj1DdfyTa87imX8xmL16PEiId3XBB2ew+uYD3iXjm5Utw99B6mcFKA8Sx9UmJYj7nZoUeaaRAQYRMjJJpZRLf8mdVq/QzmyvHKcwDhZ6phZOEWeYboel1GtUYQnwzJ8N7K5z2sIh2jpX+anDNmqtEDxk5EjYrcQJ7Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766070342; c=relaxed/simple;
	bh=r01wZaBj0VPKn3oBEMLPuntXAg3nmbcyznD01aHu/Po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgALl+7L8CW2XclzRyR8S1A6/++TRG6SLL53bOqSxQ0SGb7kuocG0su7XVc/N0TyeT3o58KPIkcczif0RS9e4c371CD4aJA2NMWkfQhDN9o7RpOynsNrVIynnLk5NrlkDgxf4YpgCjor66vtRqtyMuXOwZqPUSyhx6buU3aNChI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dLLE4R3b; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wVHRy78R0B7MDh+3cNQB284F3wNlr+lFLKkcoS/2ySA=; b=dLLE4R3bzrshh2HSB+OHFP57TK
	6Y7T5mPSIhr4Om8R+Q3J0lnaQxO6usDaV1iLDhjKplhyNTwcADMN97vwfHDu62WyiJxMwTIiNUSLB
	BYlZuvo3dHBVsNvjZp3vp8kB+pnhssQ/CVFgwI48X3c7cfQJRYExzUyk1dRSO5vd59aAUI8DRFQ4F
	Xo2IPm/EiEwk93/wxQ3tO8K+UtB+Yb7gD3ArQiNBeIftRuz6j4uV40pLjRyd+9xeyWL0sUK4TOt3d
	3HqTVB/ZJEhwH7jpQS39b6a3GSJ6KCaCBsvqBPAsILyc8TmJaUu5Q550JE3nZr4SEYgMZCqskq6nE
	DEf7kyPQ==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWEhn-0000000919l-1NwY;
	Thu, 18 Dec 2025 14:10:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A96D730056B; Thu, 18 Dec 2025 16:05:24 +0100 (CET)
Date: Thu, 18 Dec 2025 16:05:24 +0100
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
Message-ID: <20251218150524.GY3707837@noisy.programming.kicks-ass.net>
References: <20251215155615.870031952@linutronix.de>
 <20251215155709.068329497@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215155709.068329497@linutronix.de>

On Mon, Dec 15, 2025 at 05:52:22PM +0100, Thomas Gleixner wrote:

> V5: Document the slice extension range - PeterZ

> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -1228,6 +1228,14 @@ reboot-cmd (SPARC only)
>  ROM/Flash boot loader. Maybe to tell it what to do after
>  rebooting. ???
>  
> +rseq_slice_extension_nsec
> +=========================
> +
> +A task can request to delay its scheduling if it is in a critical section
> +via the prctl(PR_RSEQ_SLICE_EXTENSION_SET) mechanism. This sets the maximum
> +allowed extension in nanoseconds before scheduling of the task is enforced.
> +Default value is 30000ns (30us). The possible range is 10000ns (10us) to
> +50000ns (50us).

The important bit: we're not going to increase these numbers. If
anything, I would like the default to be 10us and taint the kernel if
you up it.

I also think we want some tracing/tool to find the actual length of the
extension used (min/avg/max etc.). That is the time between the kernel
finding the extension bit set and arming the timer and the slice_yield()
syscall.


