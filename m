Return-Path: <linux-arch+bounces-15836-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D517D38D66
	for <lists+linux-arch@lfdr.de>; Sat, 17 Jan 2026 10:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B22B301A734
	for <lists+linux-arch@lfdr.de>; Sat, 17 Jan 2026 09:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596C53115A2;
	Sat, 17 Jan 2026 09:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fgp9CfcX"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7142023BD1F;
	Sat, 17 Jan 2026 09:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768642607; cv=none; b=A+q6ZdHe0ax3fB46UTLSkKoJB2wc78yi1CbgoIi3KarP0G9b1dRM5MohEp+SJLHnaooEIUCzTDPFzBPfGA1FaM2KZsxm76Fbjb81G5UOlv12UM/gBvcfkmyHAyXCGDVRBTUJKNAmUnUsNq4esxqG+6JmA0KShYzvvPjEqqvyTHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768642607; c=relaxed/simple;
	bh=5KIJY3Ju0Z6OAN1ezdB4wWsifPinNgF8stjuhXV0Koo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGmI7Dvl5yFrsrdEQaPKvi+u+csJucXtpYj811EQ2Kj0llIlHgDmSOPRwWyub4bFWXwq0vdqyiwGht1q5bQxo+Z0QhVti+R8DUo3Ic0+j009+AAmZTEcUl9Vs7ujwDoGD+bO/qxBllBggzEPatQs0x58pLtmMAdnmAEhcgSy9qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fgp9CfcX; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gNSEBPRhmHq+mJaes1pknGXH2DKByrhX23P0zmHlIk4=; b=fgp9CfcXL7xyIVovGxP84JrsYJ
	3MF7RZJOyQjDPrA6BjZMVf2h4+oagqpoP7kp1iUYXjeVg+gkcUduL9njj/7IxFO/ROFWviqNoIl67
	xambcF8UiIne/3KpKL+4jLCAE69Zj9sAzJhsOUt/3SMDyEEbLW90UPZ1Qurus+Gp3LLq7BpikvSLS
	h6KeOp5gHIABeWub5Xl98zEszYo5UgEL6TlwG4zAi7pvFHZlqVbHZ+efNlcZW47Crh4iYU/bEmkYM
	MSSPBFix9W6HQvJCsOKz5ArijjpUj5OFjcuAuRvFQuosbfI8Vt0oewwBZiS1+U2aZEK13SFpoObiR
	i4qbl7kQ==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vh2jN-00000009ysB-3O0z;
	Sat, 17 Jan 2026 09:36:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8535930065D; Sat, 17 Jan 2026 10:36:28 +0100 (CET)
Date: Sat, 17 Jan 2026 10:36:28 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
	Florian Weimer <fweimer@redhat.com>,
	"carlos@redhat.com" <carlos@redhat.com>
Subject: Re: [patch V6 01/11] rseq: Add fields and constants for time slice
 extension
Message-ID: <20260117093628.GE1890602@noisy.programming.kicks-ass.net>
References: <20251215155615.870031952@linutronix.de>
 <20251215155708.669472597@linutronix.de>
 <d97944e3-e5f3-4d7e-83ac-89ddd6a4cb64@efficios.com>
 <87jyyjbclh.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jyyjbclh.ffs@tglx>

On Fri, Dec 19, 2025 at 12:21:30AM +0100, Thomas Gleixner wrote:
> On Tue, Dec 16 2025 at 09:36, Mathieu Desnoyers wrote:
> > On 2025-12-15 13:24, Thomas Gleixner wrote:
> > [...]
> >> +The thread has to enable the functionality via prctl(2)::
> >> +
> >> +    prctl(PR_RSEQ_SLICE_EXTENSION, PR_RSEQ_SLICE_EXTENSION_SET,
> >> +          PR_RSEQ_SLICE_EXT_ENABLE, 0, 0);
> >
> > Although it is not documented, it appears that a thread can
> > also use this prctl to disable slice extension.
> 
> Obviously. Controls are supposed to be symmetrical.
> 
> > How is it meant to compose once we have libc trying to use slice
> > extension internally and the application also using it or wishing to
> > disable it, unaware that libc is also trying to use it ?
> 
> Tons of prctls have the same "issue". What's so special about this?

So I've read this whole thread, and I'm with Thomas on this.

Yes this interface has sharp edges, but I don't think anything here
makes a case for adding more complexity.

As Thomas already stated; the very worst possible outcome is that slice
extensions are always denied -- this is a performance issue, not a
correctness issue.

To me it really reads like: Doctor, it hurts when I hit my hand with a
hammer.

