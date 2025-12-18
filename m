Return-Path: <linux-arch+bounces-15498-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 572A6CCC7DD
	for <lists+linux-arch@lfdr.de>; Thu, 18 Dec 2025 16:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2783E3107D11
	for <lists+linux-arch@lfdr.de>; Thu, 18 Dec 2025 15:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898AF338599;
	Thu, 18 Dec 2025 15:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UquYdImB"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7E834E762;
	Thu, 18 Dec 2025 15:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766071131; cv=none; b=nh/C27Hehur3JYcReO45fiBx4lkilncgSRBFbp46hxKrd8ru10OjjAhv3JgUnC41x09Cwr4mB/IS8HeUeKIAlxWWYrUEMnCtwokIFL/tePJqkKz2JxzKnC840DYiQdfzEYSJDI6NzKRQ+O4twaGZkk/ffgIQXTg3+MWNcliSHDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766071131; c=relaxed/simple;
	bh=TrEJjzb3nJuMY8iwDjl2nww5cxaS24ZcrZGE0nKMbMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZjJRFzIQ+zpvM6oQz1WbRwkz4s+Bde/kzjN1Dg4w/xRo0X86s603kOgPosoSv1ukXB8JCSTLbO2SQSAAtMNDK7tVH7srv2Zmn+6eLsLzlQigSdIOBLKrVU3RQpnK74AFJqcOzG7+p08fJ2PGhW0AeMDgFbzvCdye3lFziHU/z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UquYdImB; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wHWj04rkzQvBNlgQHH1xx4LApQ0YWrZMf2Ml5qSszN4=; b=UquYdImBHMy8q2pChjLnimpryX
	aRPGnBiQJmHaQgB2QRqT9MOhJcclRDCHSftHcdHw0A62+wymdLgIfGnljq0ckQ+NZQyAUMjPb/PQI
	9Zn3NJJXH2MWfRMtvcOuY2AVE1lIaan/Mvp1V9v0tWrhQ5uhcVuxXfXx9pFzWMvvebF5roKNTzcmV
	u3MIluQMYs4ArgkvnD6sVq7+hqrvQfN8v7aoXWZatkTGWVp1n1CiCmJc7szWrALoGUROXowYU7JxJ
	nXyitjB3UWOOe95l40wFdHzTk0H7oQMCnxroite4ECeHfhOa8kt/gfxr50y0N/g9S1alGpqYYR0oO
	CdygzDJw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWEuW-000000092iC-0fNU;
	Thu, 18 Dec 2025 14:23:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CCA7030045C; Thu, 18 Dec 2025 16:18:33 +0100 (CET)
Date: Thu, 18 Dec 2025 16:18:33 +0100
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
Message-ID: <20251218151833.GZ3707837@noisy.programming.kicks-ass.net>
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

> +static void rseq_cancel_slice_extension_timer(void)
> +{
> +	struct slice_timer *st = this_cpu_ptr(&slice_timer);
> +
> +	/*
> +	 * st->cookie can be safely read as preemption is disabled and the
> +	 * timer is CPU local.
> +	 *
> +	 * As this is most probably the first expiring timer, the cancel is
> +	 * expensive as it has to reprogram the hardware, but that's less
> +	 * expensive than going through a full hrtimer_interrupt() cycle
> +	 * for nothing.

So I have these hrtick patches that skip some of that reprogramming --
at the cost of causing those spurious interrupts. Overall that was a
win.

Should we look at the cost of a spurious hrtimer interrupt? IIRC each
base will stop at the first iteration if the timer is 'early', which
wasn't that bad.

> +	 * hrtimer_try_to_cancel() is sufficient here as the timer is CPU
> +	 * local and once the hrtimer code disabled interrupts the timer
> +	 * callback cannot be running.
> +	 */
> +	if (st->cookie == current)
> +		hrtimer_try_to_cancel(&st->timer);
> +}

