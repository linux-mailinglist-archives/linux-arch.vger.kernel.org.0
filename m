Return-Path: <linux-arch+bounces-13710-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1024B90417
	for <lists+linux-arch@lfdr.de>; Mon, 22 Sep 2025 12:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CA4316BA66
	for <lists+linux-arch@lfdr.de>; Mon, 22 Sep 2025 10:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CA7223DFD;
	Mon, 22 Sep 2025 10:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hp6NooUD"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA909179A3;
	Mon, 22 Sep 2025 10:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758538033; cv=none; b=oZmEAnc1Qn4C2J2w0omziWzbEeFtn+lbo7lbPcjVf2FVeh0reFRdTKPraAM0cdL4slpx5Yt8CkzTmK0k3FE1QkU1Tsg/POXtsIudAl2ENanDVfbBljpL2OOD+xqEhOMeuENA3xwIjOvNC+oBJV76WzS+8qTIhS2/qbfpwo4UZgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758538033; c=relaxed/simple;
	bh=5wrwo5Dx5awItaR1obuaJIJiS37s0dpVkSAowpkf4PM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xe1TiKGvu9qiaZjnRWH46uQ70zPuOZY6FdYmyrLGoP/B0gHyOdvcKpQHk0MlPEQPTY8dUqvQjD3LooiqusE7jvlqiA2Yx1C1aHE6ck/X+xy4QNDv4j00O9YL2ovABrYR2/MMCZuLE5CXY0+OC0ZetxVU2CGwp6cmvoJ0zn2TGaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hp6NooUD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD375C4CEF0;
	Mon, 22 Sep 2025 10:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758538033;
	bh=5wrwo5Dx5awItaR1obuaJIJiS37s0dpVkSAowpkf4PM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hp6NooUDuR6ilyAslj7UVm2g2vpSqNkg+z+eMVhbwssw1WXb1E/8Ia14HGZb+l8M0
	 T/RgvS/XYaOX7f7Nu369N4YDMiCKrMFpqLdx9n/RDXH/6To4XDG3117gyNQRb4FeCx
	 J8JR2sv8SN1RPwqlWGRqMQ0dYlEj47fwzIXsr0Amr4xf9sK7Sd09jpLURop3jznx2H
	 nel+4I8KqdQgG/fl6bXshFzmlhjkN8A8slYGzdSByIM0YASn3kFCvUYP70cFZraduW
	 1B7P8FERT9KL9Zbips19SUJY7oFRIJvR0tNi4GpDYkCdCMxIJgUDXnVDlXFdqL2rUW
	 1iKX9VieytiRg==
Date: Mon, 22 Sep 2025 11:47:06 +0100
From: Will Deacon <will@kernel.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
	arnd@arndb.de, catalin.marinas@arm.com, peterz@infradead.org,
	akpm@linux-foundation.org, mark.rutland@arm.com,
	harisokn@amazon.com, cl@gentwo.org, ast@kernel.org,
	memxor@gmail.com, zhenglifeng1@huawei.com,
	xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v5 1/5] asm-generic: barrier: Add
 smp_cond_load_relaxed_timeout()
Message-ID: <aNEpKjjwO_Ms6U7S@willie-the-truck>
References: <20250911034655.3916002-1-ankur.a.arora@oracle.com>
 <20250911034655.3916002-2-ankur.a.arora@oracle.com>
 <aMxgsh3AVO5_CCqf@willie-the-truck>
 <87qzw2f1rv.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87qzw2f1rv.fsf@oracle.com>

On Fri, Sep 19, 2025 at 04:41:56PM -0700, Ankur Arora wrote:
> Will Deacon <will@kernel.org> writes:
> > On Wed, Sep 10, 2025 at 08:46:51PM -0700, Ankur Arora wrote:
> >> +	for (;;) {							\
> >> +		VAL = READ_ONCE(*__PTR);				\
> >> +		if (cond_expr)						\
> >> +			break;						\
> >> +		cpu_relax();						\
> >> +		if (++__n < __spin)					\
> >> +			continue;					\
> >> +		if (time_check_expr)					\
> >> +			break;						\
> >
> > There's a funny discrepancy here when compared to the arm64 version in
> > the next patch. Here, if we time out, then the value returned is
> > potentially quite stale because it was read before the last cpu_relax().
> > In the arm64 patch, the timeout check is before the cmpwait/cpu_relax(),
> > which I think is better.
> 
> So, that's a good point. But, the return value being stale also seems to
> be incorrect.
> 
> > Regardless, I think having the same behaviour for the two implementations
> > would be a good idea.
> 
> Yeah agreed.
> 
> As you outlined in the other mail, how about something like this:
> 
> #ifndef smp_cond_load_relaxed_timeout
> #define smp_cond_load_relaxed_timeout(ptr, cond_expr, time_check_expr)	\
> ({									\
> 	typeof(ptr) __PTR = (ptr);					\
> 	__unqual_scalar_typeof(*ptr) VAL;				\
> 	u32 __n = 0, __poll = SMP_TIMEOUT_POLL_COUNT;			\
> 									\
> 	for (;;) {							\
> 		VAL = READ_ONCE(*__PTR);				\
> 		if (cond_expr)						\
> 			break;						\
> 		cpu_poll_relax();					\
> 		if (++__n < __poll)					\
> 			continue;					\
> 		if (time_check_expr) {					\
> 			VAL = READ_ONCE(*__PTR);			\
> 			break;						\
> 		}							\
> 		__n = 0;						\
> 	}								\
> 	(typeof(*ptr))VAL;						\
> })
> #endif

That looks better to me, thanks.

Will

