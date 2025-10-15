Return-Path: <linux-arch+bounces-14119-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A09EBDDBF3
	for <lists+linux-arch@lfdr.de>; Wed, 15 Oct 2025 11:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 355584E837A
	for <lists+linux-arch@lfdr.de>; Wed, 15 Oct 2025 09:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00EE31A065;
	Wed, 15 Oct 2025 09:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gQ7f+QQE"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA5C318125;
	Wed, 15 Oct 2025 09:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760520147; cv=none; b=H6Avf8kD59oiZXs+O/HehHyTof1GlGChixFH3hrSborJT73Ug0ucFtXKZ2MbrloqA8+I4xa6IZl86zyMkzvWnAnOskHqKuLrX7jNZaj8n2vp7L7zcl9kB+ZYBvFZxp77aAYRYcrbHBExfzJ2zSaB8XKQj5jFNJC6yWrq0OagMfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760520147; c=relaxed/simple;
	bh=T+NkUjHjrIC/rIL+g0Kbk7elL0crIb8dQBvDa7nxczM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1B/Pq/4tek5Krmqa7gzDmLITvjoBq+ST88hL+ALde32paQc1gJGwhKMG8qLdAXlLeSvY9cOu4nulxQogNKqzOwAPQt9mx04LXYp0VY1QGSGQj1CGvUB27BrKdG2uLvV1YPlNItCdFntGiNI+My+/bRHOPmyTeTikbfsMcb18ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gQ7f+QQE; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RzAJqImAFXPtQRa+izbRdXNFcNgNneDg6snhyJLARfw=; b=gQ7f+QQEXR9jwM/d7euARKANnR
	Pl7HGvQ+PjKR+DKxcXVQ8jytXdadLRhoUnRTlgSN4/K9dxCX62Fl3/NMSRhDRQk/HYzo40c/lMxEj
	KqqakksiWddbk34tYahH07XUwoHNm/HXghjo9pRqTiU+VCM7TvkHN1bwreXXHyfFKSmnrPMeAIISD
	EggtC7w4olWcIPtbJoUGx7ov9ZeuIHu1yT8PioDggiYxXQox92oHXzIdYGA9mG5OMppjdwSS7QPPk
	x3DROZahohXxPYEnFK2U3AvTMmRGI5jUE9Ratv+s1inESd9fj7C7lM7Darvvzl8HHL0Mr6gAn6pOw
	pG3rie1A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8xha-00000005py6-3tkW;
	Wed, 15 Oct 2025 09:21:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DFB4630023C; Wed, 15 Oct 2025 11:21:45 +0200 (CEST)
Date: Wed, 15 Oct 2025 11:21:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Chuck Wolber <chuck@wolber.net>
Cc: Sasha Levin <sashal@kernel.org>, nathan@kernel.org,
	Matt.Kelly2@boeing.com, akpm@linux-foundation.org,
	andrew.j.oppelt@boeing.com, anton.ivanov@cambridgegreys.com,
	ardb@kernel.org, arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
	chuck.wolber@boeing.com, dave.hansen@linux.intel.com,
	dvyukov@google.com, hpa@zytor.com, jinghao7@illinois.edu,
	johannes@sipsolutions.net, jpoimboe@kernel.org,
	justinstitt@google.com, kees@kernel.org, kent.overstreet@linux.dev,
	linux-arch@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
	llvm@lists.linux.dev, luto@kernel.org, marinov@illinois.edu,
	masahiroy@kernel.org, maskray@google.com,
	mathieu.desnoyers@efficios.com, matthew.l.weber3@boeing.com,
	mhiramat@kernel.org, mingo@redhat.com, morbo@google.com,
	ndesaulniers@google.com, oberpar@linux.ibm.com, paulmck@kernel.org,
	richard@nod.at, rostedt@goodmis.org, samitolvanen@google.com,
	samuel.sarkisian@boeing.com, steven.h.vanderleest@boeing.com,
	tglx@linutronix.de, tingxur@illinois.edu, tyxu@illinois.edu,
	wentaoz5@illinois.edu, x86@kernel.org
Subject: Re: [RFC PATCH 0/4] Enable Clang's Source-based Code Coverage and
 MC/DC for x86-64
Message-ID: <20251015092145.GB3419281@noisy.programming.kicks-ass.net>
References: <20250829181007.GA468030@ax162>
 <20251014232639.673260-1-sashal@kernel.org>
 <20251015073701.GZ3419281@noisy.programming.kicks-ass.net>
 <DDIR4HE5C74G.1U5TA0KDN9O5J@wolber.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDIR4HE5C74G.1U5TA0KDN9O5J@wolber.net>

On Wed, Oct 15, 2025 at 08:26:50AM +0000, Chuck Wolber wrote:

> > I'm thinking I'm going to NAK this based on the fact that I'm not
> > interested in playing file based games. As long as this thing doesn't
> > honour noinstr I don't want this near x86.
> 
> I am working on a noinstr patchset that will precede this pachset. As it turns
> out there are several areas of the kernel (128 that I have found so far) that
> are missing the noinstr attribute macro.
> 
> Example:
> 
> kernel/locking/lockdep.c:
> 	void noinstr lockdep_hardirqs_off(unsigned long ip)
> include/linux/irqflags.h:
> 	static inline void lockdep_hardirqs_off(unsigned long ip) { }
> 
> The latter version is intended to be optimized out if the kernel is not
> configured to use this feature. However when the kernel is instrumented for
> profiling, the stub is not optimized out and ends up in the .text section
> rather than the .noinstr.text section.

Typically we switch to __always_inline when this happens. Ideally
though, compilers should strive to not be stupid and instrument dead
code to the point where DCE will fail.

> > And we have kcov support, and gcov and now llvm-cov, surely 3 coverage
> > solutions is like 2 too many?
> 
> Optimization makes it nearly impossible to correlate GCov results back to
> actual lines of source. llvm-cov instruments at the AST level which enables
> precise mapping back to source code regardless of optimization level.
> 
> 
> A detailed rundown on this issue can be found here[1], with the most relevant
> excerpt reproduced here:

Yes read and understand this, but that doesn't mean you have to have 3
different kernel interfaces for all of this, right?

