Return-Path: <linux-arch+bounces-15515-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AE0CCF886
	for <lists+linux-arch@lfdr.de>; Fri, 19 Dec 2025 12:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4F47300B80B
	for <lists+linux-arch@lfdr.de>; Fri, 19 Dec 2025 11:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AE52D876B;
	Fri, 19 Dec 2025 11:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pj1It2jp"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A58A1ADC97;
	Fri, 19 Dec 2025 11:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766142449; cv=none; b=ssXaN1iVZfuxTNzZCTrbFT9eGAHcfIeX1j8/C80m161NG9rvC8o00iheVYPmup188TLXEaNm5wZHL17pnpKWDxM+3jpYyvNkNklmz8YO5HIGSMzc+mnj4CyA6cqPh4xoop+38AW0N0qmhHODmtsFCO8gHyVzT/qjEZYkdcRDlHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766142449; c=relaxed/simple;
	bh=DG2uWZxmecjWkRaJWw3r0E/1MrZh3186M/QNL+cOvpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8UowX6Ghcj1oUL3ACYzh2JucbrPDBpaWNfcfzso+FTblBcj3Sfz4sHmmo8IF0P68ketxqWGGGzyffrOkpiqssQItlLTEM85c4Jz3dIcBpV72s3sThONuTS9TnTOouIzl+onHA7lHxmmAia7rFwDlkqDd4BhviJNNTPM0HBYJy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Pj1It2jp; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SAtyteEqumfmMTwLvG3p4LPU19h6xuFctkK5ldC4ehY=; b=Pj1It2jpDpqXbElvzkceztEirF
	MDBA3TmwIpw3bI+H0QQWe6FjnqdeDsNoCuJg51utA/RGnSqfAKEPvAcucbggmsld2a34d4M2zwyKz
	v9goB/jIlS2gZyG1onm6NuhWyOi4qpA5AHJK1UdDJyr/ksEhxdeHUHlZapVdBYx75SKNXM/OevUvI
	uOku2SkKKee8LWY3LRsKZbuGJwMhZi+cCvom8SlmQWot/DAyPTlHFS9J1hKQKnWaugWIhNVcl2U/D
	gPiCaQH9JtMt+qxDcXbWjyNhjnp23A6SlN5wqqDUWFue4QEVewxzA8CtV4HfTa14W7yHX5/gn2635
	8VlnCVxw==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWXSp-0000000Aeid-0N98;
	Fri, 19 Dec 2025 10:11:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E033C30057C; Fri, 19 Dec 2025 12:07:11 +0100 (CET)
Date: Fri, 19 Dec 2025 12:07:11 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
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
	Ron Geva <rongevarg@gmail.com>, Waiman Long <longman@redhat.com>
Subject: Re: [patch V6 10/11] entry: Hook up rseq time slice extension
Message-ID: <20251219110711.GE1132199@noisy.programming.kicks-ass.net>
References: <20251215155615.870031952@linutronix.de>
 <20251215155709.258157362@linutronix.de>
 <d8215f9a-3088-483c-bd96-4058767b886d@efficios.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8215f9a-3088-483c-bd96-4058767b886d@efficios.com>

On Tue, Dec 16, 2025 at 10:37:24AM -0500, Mathieu Desnoyers wrote:
> On 2025-12-15 13:24, Thomas Gleixner wrote:
> > Wire the grant decision function up in exit_to_user_mode_loop()
> > 
> [...]
> > +/* TIF bits, which prevent a time slice extension. */
> > +#ifdef CONFIG_PREEMPT_RT
> > +# define TIF_SLICE_EXT_SCHED	(_TIF_NEED_RESCHED_LAZY)
> > +#else
> > +# define TIF_SLICE_EXT_SCHED	(_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY)
> 
> It would be relevant to explain the difference between RT and non-RT
> in the commit message.

So if you include TIF_NEED_RESCHED the extension period directly affects
the minimum scheduler delay like:

  min(extension_period, min_sched_delay)

because this is strictly a from-userspace thing. That is, it is
equivalent to the in-kernel preemption/IRQ disabled regions -- with
exception of the scheduler critical sections itself.

As I've agrued many times -- I don't see a fundamental reason to not do
this for RT -- but perhaps further reduce the magic number such that its
impact cannot be observed on a 'good' machine.

But yes, if/when we do this on RT it needs the promise to agressively
decrease the magic number any time it can actually be measured to impact
performance.

cyclictest should probably get a mode where it (ab)uses the feature to
failure before we do this.

Anyway, I don't mind excluding RT for now, but it *does* deserve a
comment.

