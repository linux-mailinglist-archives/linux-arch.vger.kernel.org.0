Return-Path: <linux-arch+bounces-13693-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D3FB8A8A8
	for <lists+linux-arch@lfdr.de>; Fri, 19 Sep 2025 18:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AE171CC315A
	for <lists+linux-arch@lfdr.de>; Fri, 19 Sep 2025 16:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1101B31FEEE;
	Fri, 19 Sep 2025 16:18:22 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B9D31FED6;
	Fri, 19 Sep 2025 16:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758298702; cv=none; b=vAEoiMSvLW6pivmLkYGUPeTEQyDTOkh3ccnR8eYl6C/O5rVXK+XB1yPAkdC+MbQ7X9Hg9IKWTj10hEFz3GHRUMEDFc2hFrduEdo5vbFNMf9AphgbTakNvrApJsKbFhRSkXVeO0wd3ugw9PUhyJdoh92HBd8qp/XgYCfLqchl10M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758298702; c=relaxed/simple;
	bh=OdxmKl5lgS2AzkjDgESXXLnzD849ig1vx6x2nSyjJBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JL7auM/5LiUyfYA8T7HBSQN+gJ/Cp+sjut29e1TQYvO+mltbJQ3zkJl2C1JyAPQz5WWBlvx+MTUznHdSuNsqBYXFBfXFv7XEy3/iUEsTwYeIP9cFTrjiMUCg3ooV/oSDCFUY2DZl+JnM8AX/6FKNRHEtOGrCF4B951vMrAmcc/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4260CC4CEFD;
	Fri, 19 Sep 2025 16:18:18 +0000 (UTC)
Date: Fri, 19 Sep 2025 17:18:15 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org, arnd@arndb.de, peterz@infradead.org,
	akpm@linux-foundation.org, mark.rutland@arm.com,
	harisokn@amazon.com, cl@gentwo.org, ast@kernel.org,
	memxor@gmail.com, zhenglifeng1@huawei.com,
	xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v5 2/5] arm64: barrier: Add
 smp_cond_load_relaxed_timeout()
Message-ID: <aM2CR3peZkQlL0S1@arm.com>
References: <20250911034655.3916002-1-ankur.a.arora@oracle.com>
 <20250911034655.3916002-3-ankur.a.arora@oracle.com>
 <aMxmAuK-adVaVezk@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMxmAuK-adVaVezk@willie-the-truck>

On Thu, Sep 18, 2025 at 09:05:22PM +0100, Will Deacon wrote:
> > +/* Re-declared here to avoid include dependency. */
> > +extern bool arch_timer_evtstrm_available(void);
> > +
> > +#define smp_cond_load_relaxed_timeout(ptr, cond_expr, time_check_expr)	\
> > +({									\
> > +	typeof(ptr) __PTR = (ptr);					\
> > +	__unqual_scalar_typeof(*ptr) VAL;				\
> > +	bool __wfe = arch_timer_evtstrm_available();			\
> > +									\
> > +	for (;;) {							\
> > +		VAL = READ_ONCE(*__PTR);				\
> > +		if (cond_expr)						\
> > +			break;						\
> > +		if (time_check_expr)					\
> > +			break;						\
> > +		if (likely(__wfe))					\
> > +			__cmpwait_relaxed(__PTR, VAL);			\
> > +		else							\
> > +			cpu_relax();					\
> 
> It'd be an awful lot nicer if we could just use the generic code if
> wfe isn't available. One option would be to make that available as
> e.g. __smp_cond_load_relaxed_timeout_cpu_relax() and call it from the
> arch code when !arch_timer_evtstrm_available() but a potentially cleaner
> version would be to introduce something like cpu_poll_relax() and use
> that in the core code.
> 
> So arm64 would do:
> 
> #define SMP_TIMEOUT_SPIN_COUNT	1
> #define cpu_poll_relax(ptr, val)	do {				\
> 	if (arch_timer_evtstrm_available())				\
> 		__cmpwait_relaxed(ptr, val);				\
> 	else								\
> 		cpu_relax();						\
> } while (0)
> 
> and then the core code would have:
> 
> #ifndef cpu_poll_relax
> #define cpu_poll_relax(p, v)	cpu_relax()
> #endif

A slight problem here is that we have two users that want different spin
counts: poll_idle() uses 200, rqspinlock wants 16K. They've been
empirically chosen but I guess it also depends on what they call in
time_check_expr and the resolution they need. From the discussion on
patch 5, Kumar would like to override the spin count to 16K from the
current one of 200 (or if poll_idle works with 16K, we just set that as
the default; we have yet to hear from the cpuidle folk).

I guess on arm64 we'd first #undef it and redefine it as 1. The
non-event stream variant is for debug only really, I'd expect it to
always have it on in production (or go for WFET).

So yeah, I think the above would work. Ankur proposed something similar
in the early versions but I found it too complicated (a spin and wait
policy callback populating the spin variable). Your proposal looks a lot
simpler.

Thanks.

-- 
Catalin

