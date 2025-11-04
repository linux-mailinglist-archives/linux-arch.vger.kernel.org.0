Return-Path: <linux-arch+bounces-14503-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBE8C3152C
	for <lists+linux-arch@lfdr.de>; Tue, 04 Nov 2025 14:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A66C4E25A8
	for <lists+linux-arch@lfdr.de>; Tue,  4 Nov 2025 13:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF49329E4C;
	Tue,  4 Nov 2025 13:55:44 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E31320CC0;
	Tue,  4 Nov 2025 13:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762264544; cv=none; b=h3KvIo0fmrC3tAx5Tn6GKRjr5hOiHQFN2fMi6FfLW4w8fRgs0DMNVk0Rb5QE2/1zyh/V/tAd2OKiw6WUXnp1w8L7SL2VZc9GUl1XaIqeBc1YONx7m1jiu0rhv1Sbv5GrCuv17bWMcJEPRYK7dw+/ISD6yqlj731WOUK5pJB7ZHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762264544; c=relaxed/simple;
	bh=WlATIyN7OY1lmmvv+dDA36bx0fRkHJFpAzHG8BwceyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJbbhoODmVIfErwzg3/kN3QdgMw0S3w6FtboGRbgec/Ka4ViIJliR4Ndr8grmYrbr2HQrB7jHmfICivrt+pE3l54HnsFDHgW1CdGbcPEHiOASO6b7kYSihJdwUoEWqyuXsXrkPkP/okzb/E7EzpDaO23UbQGx+vsLpLr6gayiYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97F9E1CE0;
	Tue,  4 Nov 2025 05:55:33 -0800 (PST)
Received: from arm.com (RQ4T19M611-5.cambridge.arm.com [10.1.31.107])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 004DB3F694;
	Tue,  4 Nov 2025 05:55:37 -0800 (PST)
Date: Tue, 4 Nov 2025 13:55:35 +0000
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
Message-ID: <aQoF1-uKTgJo89W8@arm.com>
References: <20251028053136.692462-1-ankur.a.arora@oracle.com>
 <20251028053136.692462-3-ankur.a.arora@oracle.com>
 <3642cfd1-7da6-4a75-80b7-00c21ab6955f@app.fastmail.com>
 <87qzumq51p.fsf@oracle.com>
 <aQEy6ObvE0s2Gfbg@arm.com>
 <746c2de4-7613-4f13-911c-c2c4e071ed73@app.fastmail.com>
 <87ikfqesr2.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ikfqesr2.fsf@oracle.com>

On Mon, Nov 03, 2025 at 01:00:33PM -0800, Ankur Arora wrote:
>     /**
>     * smp_cond_load_relaxed_timeout() - (Spin) wait for cond with no ordering
>     * guarantees until a timeout expires.
>     * @ptr: pointer to the variable to wait on
>     * @cond: boolean expression to wait for
>     * @time_expr: time expression in caller's preferred clock
>     * @time_end: end time in nanosecond (compared against time_expr;
>     * might also be used for setting up a future event.)
>     *
>     * Equivalent to using READ_ONCE() on the condition variable.
>     *
>     * Note that the expiration of the timeout might have an architecture specific
>     * delay.
>     */
>     #ifndef smp_cond_load_relaxed_timeout
>     #define smp_cond_load_relaxed_timeout(ptr, cond_expr, time_expr, time_end_ns)	\
>     ({									\
>             typeof(ptr) __PTR = (ptr);					\
>             __unqual_scalar_typeof(*ptr) VAL;				\
>             u32 __n = 0, __spin = SMP_TIMEOUT_POLL_COUNT;		\
>             u64 __time_end_ns = (time_end_ns);				\
>                                                                         \
>             for (;;) {							\
>                     VAL = READ_ONCE(*__PTR);				\
>                     if (cond_expr)					\
>                             break;					\
>                     cpu_poll_relax(__PTR, VAL, __time_end_ns);		\

With time_end_ns being passed to cpu_poll_relax(), we assume that this
is always the absolute time. Do we still need time_expr in this case?
It works for WFET as long as we can map this time_end_ns onto the
hardware CNTVCT.

Alternatively, we could pass something like remaining_ns, though not
sure how smp_cond_load_relaxed_timeout() can decide to spin before
checking time_expr again (we probably went over this in the past two
years ;)).

>                     if (++__n < __spin)				\
>                             continue;					\
>                     if ((time_expr) >= __time_end_ns) {		\
>                             VAL = READ_ONCE(*__PTR);			\
>                             break;					\
>                     }							\
>                     __n = 0;						\
>             }								\
>             (typeof(*ptr))VAL;						\
>     })
>     #endif

-- 
Catalin

