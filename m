Return-Path: <linux-arch+bounces-13195-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1B2B2BF06
	for <lists+linux-arch@lfdr.de>; Tue, 19 Aug 2025 12:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4F913BCD97
	for <lists+linux-arch@lfdr.de>; Tue, 19 Aug 2025 10:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C9A322A2E;
	Tue, 19 Aug 2025 10:34:54 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9FC322A28;
	Tue, 19 Aug 2025 10:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755599693; cv=none; b=gYzJdfyxgLK3YWnssc9EWzOQAZg/bFOPM1jNr8DOdXf6PPTFgiD1mvSsqQe3hTUq6f0c65ZHMIHjQgsuuOTIf8gKRIE5eZ8iuXsKd0nYRwrL6200fHlA+OiZtP7AVJ5PdZjjMlSCWPO7XJnMQHr9uIyVedCyQbAF2r552VW3M60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755599693; c=relaxed/simple;
	bh=YfxtKZ3KDpHdxU2AkTGk82RkHMdmrgN3HOIFgt4raRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HrcWNq5rQKnMPxWn1IHyAjCEO1kIGs00E1UQOJSz9A8F/lsbfJZnng4PoaJ7vYcIw/HcnVpqH1K44iosvprC5uZKax6c6yu6Qqi93zGsYqH4kBSCp7KyKYCmUqigq59eXmr92aSK7QdQGS+moKBZsvWSv0B5CihNvxjrLjtMqPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1E8C113D0;
	Tue, 19 Aug 2025 10:34:49 +0000 (UTC)
Date: Tue, 19 Aug 2025 11:34:47 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
	arnd@arndb.de, will@kernel.org, peterz@infradead.org,
	akpm@linux-foundation.org, mark.rutland@arm.com,
	harisokn@amazon.com, cl@gentwo.org, ast@kernel.org,
	memxor@gmail.com, zhenglifeng1@huawei.com,
	xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
	rafael@kernel.org, daniel.lezcano@linaro.org
Subject: Re: [PATCH v3 1/5] asm-generic: barrier: Add
 smp_cond_load_relaxed_timewait()
Message-ID: <aKRTRyQAaWFtRvDv@arm.com>
References: <20250627044805.945491-1-ankur.a.arora@oracle.com>
 <20250627044805.945491-2-ankur.a.arora@oracle.com>
 <aJXWyxzkA3x61fKA@arm.com>
 <877bz98sqb.fsf@oracle.com>
 <aJy414YufthzC1nv@arm.com>
 <87bjoi2wdf.fsf@oracle.com>
 <aJ3K4tQCztOXF6hO@arm.com>
 <87plctwq7x.fsf@oracle.com>
 <aKNo9pxx2w9sjJjc@arm.com>
 <87sehotp9q.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sehotp9q.fsf@oracle.com>

On Mon, Aug 18, 2025 at 12:15:29PM -0700, Ankur Arora wrote:
> Catalin Marinas <catalin.marinas@arm.com> writes:
> > On Sun, Aug 17, 2025 at 03:14:26PM -0700, Ankur Arora wrote:
> >> __cmpwait_relaxed() will need adjustment to set a deadline for WFET.
> >
> > Yeah, __cmpwait_relaxed() doesn't use WFET as it doesn't need a timeout
> > (it just happens to have one with the event stream).
> >
> > We could extend this or create a new one that uses WFET and takes an
> > argument. If extending this one, for example a timeout argument of 0
> > means WFE, non-zero means WFET cycles. This adds a couple of more
> > instructions.
> 
> Though then we would need an ALTERNATIVE for WFET to fallback to WFE where
> not available. This is a minor point, but how about just always using
> WFE or WFET appropriately instead of choosing between the two based on
> etime.
> 
>   static inline void __cmpwait_case_##sz(volatile void *ptr,              \
>                                   unsigned long val,                      \
>                                   unsigned long etime)                    \
>                                                                           \
>           unsigned long tmp;                                              \
>                                                                           \
>           const unsigned long ecycles = xloops_to_cycles(nsecs_to_xloops(etime)); \
>           asm volatile(                                                   \
>           "       sevl\ n"                                                \
>           "       wfe\ n"                                                 \
>           "       ldxr" #sfx "\ t%" #w "[tmp], %[v]\n"                    \
>           "       eor     %" #w "[tmp], %" #w "[tmp], %" #w "[val]\ n"    \
>           "       cbnz    %" #w "[tmp], 1f\ n"                            \
>           ALTERNATIVE("wfe\ n",                                           \
>                   "msr s0_3_c1_c0_0, %[ecycles]\ n",                      \
>                   ARM64_HAS_WFXT)                                         \
>           "1:"                                                            \
>           : [tmp] "=&r" (tmp), [v] "+Q" (*(u##sz *)ptr)                   \
>           : [val] "r" (val), [ecycles] "r" (ecycles));                    \
>   }
> 
> This would cause us to compute the end time unnecessarily for WFE but,
> given that nothing will use the output of that computation, wouldn't
> WFE be able to execute before the result of that computation is available?
> (Though I guess WFE is somewhat special, so the usual rules might not
> apply.)

The compiler cannot tell what's happening inside the asm block, so it
will compute ecycles, place it in a register before the asm. The
hardware won't do anything smarter like skip the computation because the
register holding ecycles is not going to be used (or it is going to be
re-written later). So I wouldn't want to penalise the existing
smp_cond_load_acquire() which only needs a WFE.

We could patch WFET in and always pass -1UL in the non-timeout case but
I think we are better off just duplicating the whole thing. It's going
to be inlined anyway, so it's not like we end up with lots of these
functions.

-- 
Catalin

