Return-Path: <linux-arch+bounces-15724-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF006D0A98A
	for <lists+linux-arch@lfdr.de>; Fri, 09 Jan 2026 15:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F7CD3073F95
	for <lists+linux-arch@lfdr.de>; Fri,  9 Jan 2026 14:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37E535E53B;
	Fri,  9 Jan 2026 14:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WG46vr/E"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEC32E8DFE;
	Fri,  9 Jan 2026 14:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767968184; cv=none; b=XvYXPJUsF3OnB7dJAmHTG/3u6/XpY4usqussiTdM6b+wbqWuUpbNT8YEDhNduxRWhVT7gE5NxOymLK665AW4mqFsc4B2B23qteZ8MhlSbNtY8u408fup4I6AlLHJWVLC2Lf3XuN8oPFtSw3mDSuWG3BcTwhTIZYkHh8xf1qxong=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767968184; c=relaxed/simple;
	bh=CrekNb1dyF5mdDmLDlXBHlZWJJ6T0rEqpIAPw8943rE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJZzpXEvRIFOwfKu5wnmn9WvXmBxYMuuQSeEqj4vWp2B5zdhF+6rWF79yCTvIK1KZt2IYN/pSzx9R4JGeH5/uAaWMp3FcMHhgMDMEgSKQV+q20k2vNd/JtXOYiRTWJ5q1SeTK8I5oPnnMye2W19k1aqZsaqHEwFstY9lnTeeLD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WG46vr/E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1E0C19421;
	Fri,  9 Jan 2026 14:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767968184;
	bh=CrekNb1dyF5mdDmLDlXBHlZWJJ6T0rEqpIAPw8943rE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WG46vr/EzI5fbUdRrIc3zQ3nu8+ECZ/t7wbnWcjsusUN84kOQ8YmlLLE4JjpIcvcX
	 YitKYrV/LbR+LfReyDPxL/QBCHeXBZ7VvqC6GC93gC6HW9LHURXlAdDhhgf1lmPaa4
	 DtcPDy5a5TiazlSFVHClgCUSYTTsK9u5p7SOjhchrNvccMZjKKIBi76J6mPeaqBgAL
	 ohkI3oEQe7JejBBlHD7e9iZ6xMehQ5ADBVn30LHU8F2ETT3DkwuZs4sxERFXSF4SCW
	 7aVx1T9AA9+jkZg708xRh5mtPLZk0MXlg1sZJyG0sXbruSWyyy368nTs3v91142ER+
	 ayMmzicQeFRkw==
Date: Fri, 9 Jan 2026 14:16:17 +0000
From: Will Deacon <will@kernel.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	bpf@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
	peterz@infradead.org, akpm@linux-foundation.org,
	mark.rutland@arm.com, harisokn@amazon.com, cl@gentwo.org,
	ast@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
	memxor@gmail.com, zhenglifeng1@huawei.com,
	xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v8 04/12] arm64: support WFET in
 smp_cond_relaxed_timeout()
Message-ID: <aWENsQywXuM880_l@willie-the-truck>
References: <20251215044919.460086-1-ankur.a.arora@oracle.com>
 <20251215044919.460086-5-ankur.a.arora@oracle.com>
 <aWAjMbSqN2g7v58Z@willie-the-truck>
 <874iovp34a.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874iovp34a.fsf@oracle.com>

On Fri, Jan 09, 2026 at 01:05:57AM -0800, Ankur Arora wrote:
> 
> Will Deacon <will@kernel.org> writes:
> 
> > On Sun, Dec 14, 2025 at 08:49:11PM -0800, Ankur Arora wrote:
> >> +#define __CMPWAIT_CASE(w, sfx, sz)						\
> >> +static inline void __cmpwait_case_##sz(volatile void *ptr,			\
> >> +				       unsigned long val,			\
> >> +				       s64 timeout_ns)				\
> >> +{										\
> >> +	unsigned long tmp;							\
> >> +										\
> >> +	if (!alternative_has_cap_unlikely(ARM64_HAS_WFXT) || timeout_ns <= 0) {	\
> >> +		asm volatile(							\
> >> +		"	sevl\n"							\
> >> +		"	wfe\n"							\
> >> +		"	ldxr" #sfx "\t%" #w "[tmp], %[v]\n"			\
> >> +		"	eor	%" #w "[tmp], %" #w "[tmp], %" #w "[val]\n"	\
> >> +		"	cbnz	%" #w "[tmp], 1f\n"				\
> >> +		"	wfe\n"							\
> >> +		"1:"								\
> >> +		: [tmp] "=&r" (tmp), [v] "+Q" (*(u##sz *)ptr)			\
> >> +		: [val] "r" (val));						\
> >> +	} else {								\
> >> +		u64 ecycles = arch_timer_read_counter() +			\
> >> +				NSECS_TO_CYCLES(timeout_ns);			\
> >> +		asm volatile(							\
> >> +		"	sevl\n"							\
> >> +		"	wfe\n"							\
> >> +		"	ldxr" #sfx "\t%" #w "[tmp], %[v]\n"			\
> >> +		"	eor	%" #w "[tmp], %" #w "[tmp], %" #w "[val]\n"	\
> >> +		"	cbnz	%" #w "[tmp], 2f\n"				\
> >> +		"	msr s0_3_c1_c0_0, %[ecycles]\n"				\
> >> +		"2:"								\
> >> +		: [tmp] "=&r" (tmp), [v] "+Q" (*(u##sz *)ptr)			\
> >> +		: [val] "r" (val), [ecycles] "r" (ecycles));			\
> >> +	}									\
> >
> > Why not have a separate helper for the WFXT version and avoid the runtime
> > check on timeout_ns?
> 
> My main reason for keeping them together was that a separate helper
> needed duplication of a lot of the __CMPWAIT_CASE and __CMPWAIT_GEN
> stuff.
> 
> Relooking at it, I think we could get by without duplicating the
> __CMPWAIT_GEN (the WFE helper just needs to take an unused timeout_ns
> paramter).
> 
> But, it seems overkill to get rid of the unnecessary check on timeout_ns
> (which AFAICT should be well predicted) and the duplicate static branch.

tbh, I was actually struggling to see what the check achieves. In fact,
why is 'timeout_ns' signed in the first place? Has BPF invented time
travel now? :p

If the requested timeout is 0 then we should return immediately (or issue
a WFET which will wake up immediately).

If the requested timeout is negative, then WFET may end up with a really
long timeout, but that should still be no worse than a plain WFE.

If the check is only there to de-multiplex __cmpwait() vs
__cmpwait_relaxed_timeout() as the caller, then I think we should just
avoid muxing them in the first place. The duplication argument doesn't
hold a lot of water when the asm block is already mostly copy-paste.

Will

