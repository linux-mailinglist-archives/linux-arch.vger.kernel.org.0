Return-Path: <linux-arch+bounces-14388-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E0AC16E92
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 22:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 886A43ADC60
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 21:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FFF34AB0D;
	Tue, 28 Oct 2025 21:17:35 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2421D1F4188;
	Tue, 28 Oct 2025 21:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686255; cv=none; b=Q5mJZTeRa8CK2XzmlhwKXjOSlQL10JWDTh3d/GoEIcZ4VFYrjQ1noAEmrzC+2Wx1E/Uum4ZqG/1XV4io3oVq3pXaHFKoAitMAirpfw2+KwQEp0dX6ivge5JD6YxrfQbxlumL5Pl10aRusebFNvtN1ZZgFFGBUJhbp/7Ol+GONwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686255; c=relaxed/simple;
	bh=em98p2AJC4tx6/0tI7pM4H80h48CM34VXM6lkBhTBOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKCRffkha2gSAxEcstcqJf+BRJRUSoiw4oCvjyVGlqbfC7zQses6wxiSEhagSSENJSbPgVnzKFMpbRMSuBKMv8Yjz4otHClLQ84uZu7Ac6YlJg7/u7c5EHJ++IW5OH9Y6mY82xg7BJWhOaMAAyMgnDaOhcPClrCuxu6vw4hxFiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E193C4CEE7;
	Tue, 28 Oct 2025 21:17:30 +0000 (UTC)
Date: Tue, 28 Oct 2025 21:17:28 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	Linux-Arch <linux-arch@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	bpf@vger.kernel.org, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Haris Okanovic <harisokn@amazon.com>,
	"Christoph Lameter (Ampere)" <cl@gentwo.org>,
	Alexei Starovoitov <ast@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, zhenglifeng1@huawei.com,
	xueshuai@linux.alibaba.com,
	Joao Martins <joao.m.martins@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [RESEND PATCH v7 2/7] arm64: barrier: Support
 smp_cond_load_relaxed_timeout()
Message-ID: <aQEy6ObvE0s2Gfbg@arm.com>
References: <20251028053136.692462-1-ankur.a.arora@oracle.com>
 <20251028053136.692462-3-ankur.a.arora@oracle.com>
 <3642cfd1-7da6-4a75-80b7-00c21ab6955f@app.fastmail.com>
 <87qzumq51p.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87qzumq51p.fsf@oracle.com>

On Tue, Oct 28, 2025 at 11:01:22AM -0700, Ankur Arora wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> > On Tue, Oct 28, 2025, at 06:31, Ankur Arora wrote:
> >> Support waiting in smp_cond_load_relaxed_timeout() via
> >> __cmpwait_relaxed(). Limit this to when the event-stream is enabled,
> >> to ensure that we wake from WFE periodically and don't block forever
> >> if there are no stores to the cacheline.
> >>
> >> In the unlikely event that the event-stream is unavailable, fallback
> >> to spin-waiting.
> >>
> >> Also set SMP_TIMEOUT_POLL_COUNT to 1 so we do the time-check for each
> >> iteration in smp_cond_load_relaxed_timeout().
> >
> > After I looked at the entire series again, this one feels like
> > a missed opportunity. Especially on low-power systems but possibly
> > on any ARMv9.2+ implementation including Cortex-A320, it would
> > be nice to be able to both turn off the event stream and also
> > make this function take fewer wakeups:
> >
> >> +/* Re-declared here to avoid include dependency. */
> >> +extern bool arch_timer_evtstrm_available(void);
> >> +
> >> +#define cpu_poll_relax(ptr, val)					\
> >> +do {									\
> >> +	if (arch_timer_evtstrm_available())				\
> >> +		__cmpwait_relaxed(ptr, val);				\
> >> +	else								\
> >> +		cpu_relax();						\
> >> +} while (0)
> >> +
> >
> > Since the caller knows exactly how long it wants to wait for,
> > we should be able to fit a 'wfet' based primitive in here and
> > pass the timeout as another argument.
> 
> Per se, I don't disagree with this when it comes to WFET.
> 
> Handling a timeout, however, is messier when we use other mechanisms.
> 
> Some problems that came up in my earlier discussions with Catalin:
> 
>   - when using WFE, we also need some notion of slack
>     - and if a caller specifies only a small or no slack, then we need
>       to combine WFE+cpu_relax()
> 
>   - for platforms that only use a polling primitive, we want to check
>     the clock only intermittently for power reasons.
>     Now, this could be done with an architecture specific spin-count.
>     However, if the caller specifies a small slack, then we might need
>     to we check the clock more often as we get closer to the deadline etc.
> 
> A smaller problem was that different users want different clocks and so
> folding the timeout in a 'timeout_cond_expr' lets us do away with the
> interface having to handle any of that.
> 
> I had earlier versions [v2] [v3] which had rather elaborate policies for
> handling timeout, slack etc. But, given that the current users of the
> interface don't actually care about precision, all of that seemed
> a little overengineered.

Indeed, we've been through all these options and without a concrete user
that needs a more precise timeout, we decided it's not worth it. It can,
however, be improved later if such users appear.

> [v2] https://lore.kernel.org/lkml/20250502085223.1316925-1-ankur.a.arora@oracle.com/#r
> [v3] https://lore.kernel.org/lkml/20250627044805.945491-1-ankur.a.arora@oracle.com/

-- 
Catalin

