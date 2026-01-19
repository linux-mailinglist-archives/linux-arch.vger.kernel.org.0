Return-Path: <linux-arch+bounces-15863-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C88D3A615
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 12:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E748C3003869
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 11:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DD034B40A;
	Mon, 19 Jan 2026 11:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K8+lHblW"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09709500945;
	Mon, 19 Jan 2026 11:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768820597; cv=none; b=IrWWJPl4h2asl4XBgj3S+MpppKIxwgEt42k+bgG3fJ+WykGQECn7YBpVvjcS80g0O3VFLHJtYHOx0Vjf2sT01WshBiQYVp+3cBnceLgQ3OYwjIS1DdmZsqbdkEQacIghpFP71ePtMcVPAWQgxt6X2sAKd8lXxVkfooDwM8eBl48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768820597; c=relaxed/simple;
	bh=oHhAzJ9k2cnwf80n9xr3pxihMkMNz1m49Y/Haq4Kaao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mS0QpCUPssQEMpHa6uL4ZynuECZ1BnqqYSXEGh2K8FzvK6ojTkFnlUHBb32ayjgTobeMn0fvWLBxA5HbP8HCZypci3D6NeVuqnf70UXm6f39yEgAi/WvTJRlK1SryiTKNMyvF+ziNVVLAWy9s1jvLfk9bt8njJcfJneZA1XY+iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=K8+lHblW; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oeHBFU0GkIX6vG9jw2jkXaJrpWeVtW6WJz1I7haTmWw=; b=K8+lHblW7ZtRPazX/mJzFBpuqN
	+GD8EuBwsbh7wCLLmBXt1Of99PjHertDhB/k1zDLxslf0g0WFf3sCUxD3CFPhTQ4oXrj/b7n3/AES
	HmFD07Hx4MZBLH5Bx+1BQDdO2Dpn7ZDuENKGEbcdnO3plUlI7fWL6gKMbKtubAqs/Pz0ZsJGAw307
	JT6NgKz2AvHDXaIfIQ6KijELpx+y58meeFnn1FjzeZYNAjufnNkcRea6KjfdSkp+6D82UgCaqggqX
	6pQI1lmmAfn+KN0sWkB80SbFi4831W2yZ9w4Z1Jw8ghj1F9HNwjjIBlQUwQuW7AUpggiEDMSQSAsR
	ZCG+QkIw==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhn2E-0000000BvAH-1Sr3;
	Mon, 19 Jan 2026 11:03:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 47D143006CD; Mon, 19 Jan 2026 12:03:00 +0100 (CET)
Date: Mon, 19 Jan 2026 12:03:00 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Florian Weimer <fweimer@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Prakash Sangappa <prakash.sangappa@oracle.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Ron Geva <rongevarg@gmail.com>, Waiman Long <longman@redhat.com>,
	"carlos@redhat.com" <carlos@redhat.com>,
	Michael Jeanson <mjeanson@efficios.com>
Subject: Re: [patch V6 01/11] rseq: Add fields and constants for time slice
 extension
Message-ID: <20260119110300.GR830755@noisy.programming.kicks-ass.net>
References: <20251215155615.870031952@linutronix.de>
 <20251215155708.669472597@linutronix.de>
 <d97944e3-e5f3-4d7e-83ac-89ddd6a4cb64@efficios.com>
 <87jyyjbclh.ffs@tglx>
 <225b9868-4ab7-4a90-8acb-8d965626f6a7@efficios.com>
 <87ldi4gjm3.ffs@tglx>
 <lhua4yhcc0d.fsf@oldenburg.str.redhat.com>
 <45fd706a-86be-42b8-879e-11bbe262e159@efficios.com>
 <20260119102138.GQ830755@noisy.programming.kicks-ass.net>
 <5d2f428d-4fdc-486d-90e1-474f3ee9f54f@efficios.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d2f428d-4fdc-486d-90e1-474f3ee9f54f@efficios.com>

On Mon, Jan 19, 2026 at 11:30:53AM +0100, Mathieu Desnoyers wrote:
> On 2026-01-19 05:21, Peter Zijlstra wrote:
> > On Sat, Jan 17, 2026 at 05:16:16PM +0100, Mathieu Desnoyers wrote:
> > 
> > > My main concern is about the overhead of added system calls at thread
> > > creation. I recall that doing an additional rseq system call at thread
> > > creation was analyzed thoroughly for performance regressions at the
> > > libc level. I would not want to start requiring libc to issue a
> > > handful of additional prctl system calls per thread creation for no good
> > > reason.
> > 
> > A wee something like so?
> > 
> > That would allow registering rseq with RSEQ_FLAG_SLICE_EXT_DEFAULT_ON
> > set and if all the stars align, it will then have it on at the end.
> 
> That's a very good step in the right direction. I just wonder how
> userspace is expected to learn that it runs on a kernel which
> accepts the RSEQ_FLAG_SLICE_EXT_DEFAULT_ON flag ?
> 
> I think it could expect it when getauxval for AT_RSEQ_FEATURE_SIZE
> includes the slice ext field. This gives us a cheap way to know
> from userspace whether this new flag is supported or not.

struct rseq vs struct rseq_data. I don't think that slice field is
exposed on the user side of things.

I was thinking it could just try with the flag the firs time, and then
record if that worked or not and use the 'correct' value for all future
rseq calls.

> One nit below:
> 
> [...]
> > -	if (IS_ENABLED(CONFIG_RSEQ_SLICE_EXTENSION))
> > +	if (IS_ENABLED(CONFIG_RSEQ_SLICE_EXTENSION)) {
> >   		rseqfl |= RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE;
> > +		if (rseq_slice_extension_enabled() &&
> > +		    flags & RSEQ_FLAG_SLICE_EXT_DEFAULT_ON)
> 
> I think you want to surround flags & RSEQ_FLAG_SLICE_EXT_DEFAULT_ON with
> parentheses () to have the expected operator priority.

Moo, done (I added that rseq_slice_extension_enabled() test later).

