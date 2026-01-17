Return-Path: <linux-arch+bounces-15838-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AD6D38D88
	for <lists+linux-arch@lfdr.de>; Sat, 17 Jan 2026 10:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA91B301EFF3
	for <lists+linux-arch@lfdr.de>; Sat, 17 Jan 2026 09:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019B3314D1B;
	Sat, 17 Jan 2026 09:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="beXc5vLV"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1883346A5;
	Sat, 17 Jan 2026 09:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768643870; cv=none; b=aVUL38LhlCHRcFSEmTPXbDcOhWfXtopYcAXUHtUvKshWXHBlwROe26h7Ck8OOVjMgJyHc4dcDNKA1ha4ACwo1LlqafN6wdCM2DIzpOg0UFqJFGm6LcmmLqfIxvOoX5XI4hIOWf1H/MhYf53u8HHDLRKWf9Znx3uTRvineSOZ49c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768643870; c=relaxed/simple;
	bh=+XZ3WepdgSYpYRQS3IqT899pUwyR7EO0fQYzBBxeiBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PyRRwFbGc5sqEZMQeM4cKmVzPLqttT4pnshYY3Jw3FZc3H5op1WXrwY7cdQDXxIT46JnQftJUnuaZfm/Y/aoRDY+jaNiot5IZkukNGUld56C5sTfnDKjqZZoYZsFG1OGdfjbkptaNN9kUxMkERC0i5qC0AmR7nAQYtHU0RZVFPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=beXc5vLV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vLBklmuVJKSp+vLtcJk+b1E85y5JI2DbLyjQiFTq/dw=; b=beXc5vLVfbAjod68/qA/XlgjlY
	hMX34xYDl39nySFQYtEDMHBCUlWJxUee0qKTB7UHfRNapMp97RJm1kPTCxpwIssyIIqc334ut70/J
	yIdQZtmp4oRdlW6UwohiVXC/TR0f/YzqYxxllM3DKGK+swJCzKobkUpb+L96pTOzJ/EqVYQAYY7rp
	ClhmY/SUOEYSj4C7+lU1FQwSGwjtPh0AyRabs6DsKAM6sVlrnP9lUdG1PpMZ4bFCue2tUYQL9I+rM
	AAZltXDMfJ7gcdPn1QzmDDgVtf7dKZCvGpYmdheUsm+qNbArCtPw+QgwiudD1Xs6x4sOlRawKG0WG
	p1sLYh3A==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vh33p-0000000Ac0L-3NB3;
	Sat, 17 Jan 2026 09:57:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 57A8E30065D; Sat, 17 Jan 2026 10:57:37 +0100 (CET)
Date: Sat, 17 Jan 2026 10:57:37 +0100
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
Message-ID: <20260117095737.GG1890602@noisy.programming.kicks-ass.net>
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

> +rseq_slice_extension_nsec
> +=========================
> +
> +A task can request to delay its scheduling if it is in a critical section
> +via the prctl(PR_RSEQ_SLICE_EXTENSION_SET) mechanism. This sets the maximum
> +allowed extension in nanoseconds before scheduling of the task is enforced.
> +Default value is 30000ns (30us). The possible range is 10000ns (10us) to
> +50000ns (50us).
+
+This value has a direct correlation to the worst case scheduling latency;
+increment at your own risk.


> +unsigned int rseq_slice_ext_nsecs __read_mostly = 30 * NSEC_PER_USEC;

Changed default to 10us

Also, given the results of that slice_test thing, we might possibly get
away with a much lower value still. 

Prakash, could you possibly capture a trace of hrtimer_start,
hrtimer_cancel and hrtimer_expire_entry for your Oracle workload and run
that python thing on it?


> +#ifdef CONFIG_SYSCTL
> +static const unsigned int rseq_slice_ext_nsecs_min = 10 * NSEC_PER_USEC;
> +static const unsigned int rseq_slice_ext_nsecs_max = 50 * NSEC_PER_USEC;
> +
> +static const struct ctl_table rseq_slice_ext_sysctl[] = {
> +	{
> +		.procname	= "rseq_slice_extension_nsec",
> +		.data		= &rseq_slice_ext_nsecs,
> +		.maxlen		= sizeof(unsigned int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_douintvec_minmax,
> +		.extra1		= (unsigned int *)&rseq_slice_ext_nsecs_min,
> +		.extra2		= (unsigned int *)&rseq_slice_ext_nsecs_max,
> +	},
> +};
> +
> +static void rseq_slice_sysctl_init(void)
> +{
> +	if (rseq_slice_extension_enabled())
> +		register_sysctl_init("kernel", rseq_slice_ext_sysctl);
> +}
> +#else /* CONFIG_SYSCTL */
> +static inline void rseq_slice_sysctl_init(void) { }
> +#endif  /* !CONFIG_SYSCTL */

And I was contemplating moving this to DebugFS rather than sysctl.



