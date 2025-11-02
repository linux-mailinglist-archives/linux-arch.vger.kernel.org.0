Return-Path: <linux-arch+bounces-14458-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DAEC297B4
	for <lists+linux-arch@lfdr.de>; Sun, 02 Nov 2025 22:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77B454E1639
	for <lists+linux-arch@lfdr.de>; Sun,  2 Nov 2025 21:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399271D5CC6;
	Sun,  2 Nov 2025 21:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ZQsuCxzj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qZlW4TQw"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC502F56;
	Sun,  2 Nov 2025 21:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762120359; cv=none; b=iijn//3UjbXLJcTyHO42L+CpXlcOnnvouQZJVs4ElM9Qi/NtiFgWqb/IsA/JV/OB85frRvoeojufw/i7lfA+zpr+bohRrsQPEobGOLLI3CB4rdpO1h3zaxtSJZQbdNDe4upKN71So/OTUmF+SFvHoEs34eQBSZwq98gd3sPxTCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762120359; c=relaxed/simple;
	bh=hNqHiKEUcU8AwZq4oQsjF75faBKnrVk3Us5HffNqMIE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=P6uPt1I0lEF2Y0Qqwm/YaQUUi6wAnBHmtM7RWY9dMMQxeNBdzAKJclsHFBE5WRWYdz0fvvsD5dVAnx+ikzB0voapv50xMFAfTagBEQyn2f5JmEb7qFzif8Up605PhR+qt7zHoqmctEK/XzdJ5eMSbFPtE+Sg6OEfbU39WGqB8U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ZQsuCxzj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qZlW4TQw; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 98EB37A0139;
	Sun,  2 Nov 2025 16:52:35 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Sun, 02 Nov 2025 16:52:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762120355;
	 x=1762206755; bh=9vHQin6WX5kNVk7eATPmxx/Sgjw9mMDbh04yVioESkg=; b=
	ZQsuCxzjPvdSzahHffRfRla6ZaXlhNlOXDpJQvyfNoPsgk0U62wAEMkNO3U78o3p
	I6OSZwgWUjBG5Uuq+680dUotRJotox9YOsKOMhNVrgnC2juOBbyufxg79BZy1gan
	t0vB2jCbIY8pM9e+1ap35Dqy9IRb7EtNnnG7DVl5ouTDKrWX8R3M7+nQZm1/hI74
	GyYEBKz60TLgTVxKxNB9PqpuV+/LrcFodSANEm5XEFszcbN8pUOWKvC+J8RWSrkV
	0kgbErh0B8qhqxwPWTu4PLC76aF7tK36PillMfZJkUHUkehI7XcXfClsw7BNJx/a
	89UVQgm2LN2XmoEuN26x0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762120355; x=
	1762206755; bh=9vHQin6WX5kNVk7eATPmxx/Sgjw9mMDbh04yVioESkg=; b=q
	ZlW4TQwykm3yCXsbdkb1US5nt89xOLcFg+nR6rMK+ggHfvCe6SZEwv5P7KPzl/97
	5XyzigR15mwJsfHQJzCq3drOCa2tABb+7vqMpjU35U2ayCUCvqW6l6vcwYPXz88F
	6b3Buntkh6Rgko32lyy1BRygbC11m62hnr48ZYeXj0bj+2p3hevnUUeRJPAQx/gm
	qeV5qzRjwppNatUQxBY5jeWGPqgvq1YPfsaDcNpTdgSEJm8qW2H0C/zspXbUkq9V
	Da3OzSMGqD9nMQYNipsnp6tZ8nCf8u1Xtxc5IU6muD0w7P5U6SLhJo72X5jG8RR/
	oknSzyokVV2tk0cA4sDOg==
X-ME-Sender: <xms:otIHaRc5fksN7dmlO7GVGP9gbiNIkbQ_sPyMDwDRc7X-OaAQ1fhTgA>
    <xme:otIHaaDMy_qb4HDJgybltTuYTWaJe68zfmboqU_79v4y2LbL0fXfviKkoI1HNKmmy
    XzU01Dr6F8IjRiMC_cAQo89zVjoYvFklB6KIJ0QRd_uMiB1aw9haGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeeifeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepvddvpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehhrghrihhsohhknhesrghmrgiiohhnrdgtohhmpdhrtghpthhtoh
    eptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdrtghomhdprhgtphhtthhopehmrghr
    khdrrhhuthhlrghnugesrghrmhdrtghomhdprhgtphhtthhopegtlhesghgvnhhtfihord
    horhhgpdhrtghpthhtohepmhgvmhigohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    iihhvghnghhlihhfvghnghdusehhuhgrfigvihdrtghomhdprhgtphhtthhopehpvghtvg
    hriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegrshhtsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:otIHab7xYeJbAIlPVZfV-K1VCi1kcawA6EEnuad_4h0ONOSpOs2Wgw>
    <xmx:otIHacdIHsjyUuWzC14uR-k2tGZ7gvPkLN5x8DjzOiMfTe3dCqTTgQ>
    <xmx:otIHaSdjtuFeyF0LEdnbWjqdmXgRhblnYPjSFBfYhoRaM5r9_2TF-w>
    <xmx:otIHaRE1AjQxWWsdGMBkIZ6H5EKcm9PuLJweZtQObGAd1hVs_IfMNg>
    <xmx:o9IHae1lsgYi7IEIR3ec7PApfCT8ROth0jKkmUbJ8PVKXRRplZtZ1Ge4>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 53C52700054; Sun,  2 Nov 2025 16:52:34 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ArFVEkIwmB-N
Date: Sun, 02 Nov 2025 22:52:08 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ankur Arora" <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 bpf@vger.kernel.org, "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Mark Rutland" <mark.rutland@arm.com>,
 "Haris Okanovic" <harisokn@amazon.com>,
 "Christoph Lameter (Ampere)" <cl@gentwo.org>,
 "Alexei Starovoitov" <ast@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 "Daniel Lezcano" <daniel.lezcano@linaro.org>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, zhenglifeng1@huawei.com,
 xueshuai@linux.alibaba.com, "Joao Martins" <joao.m.martins@oracle.com>,
 "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
 "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>
Message-Id: <84914748-4bf9-44a5-9e08-80528ca27177@app.fastmail.com>
In-Reply-To: <874irimm6d.fsf@oracle.com>
References: <20251028053136.692462-1-ankur.a.arora@oracle.com>
 <20251028053136.692462-2-ankur.a.arora@oracle.com>
 <4c87bbf8-00a3-4666-b844-916edd678305@app.fastmail.com>
 <874irimm6d.fsf@oracle.com>
Subject: Re: [RESEND PATCH v7 1/7] asm-generic: barrier: Add
 smp_cond_load_relaxed_timeout()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Oct 29, 2025, at 04:17, Ankur Arora wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
>> On Tue, Oct 28, 2025, at 06:31, Ankur Arora wrote:
>> The FEAT_WFXT version would then look something like
>>
>> static inline void __cmpwait_u64_timeout(volatile u64 *ptr, unsigned long val, __u64 ns)
>> {
>>    unsigned long tmp;
>>    asm volatile ("sev; wfe; ldxr; eor; cbnz; wfet; 1:"
>>         : "=&r" (tmp), "+Q" (*ptr)
>>         : "r" (val), "r" (ns));
>> }
>> #define cpu_poll_relax_timeout_wfet(__PTR, VAL, TIMECHECK) \
>> ({                                                    \
>>        u64 __t = TIMECHECK;
>>        if (__t)
>>             __cmpwait_u64_timeout(__PTR, VAL, __t);
>> })
>>
>> while the 'wfe' version would continue to do the timecheck after the
>> wait.
>
> I think this is a good way to do it if we need the precision
> at some point in the future.

I'm sorry I wrote this in a confusing way, but I really don't
care about precision here, but for power savings reasons I
would like to use a wfe/wfet based wait here (like you do)
while at the same time being able to turn off the event
stream entirely as long as FEAR_WFXT is available, saving
additional power.

>> I have two lesser concerns with the generic definition here:
>>
>> - having both a timeout and a spin counter in the same loop
>>   feels redundant and error-prone, as the behavior in practice
>>   would likely depend a lot on the platform. What is the reason
>>   for keeping the counter if we already have a fixed timeout
>>   condition?
>
> The main reason was that the time check is expensive in power terms.
> Which is fine for platforms with a WFE like primitive but others
> want to do the time check only infrequently. That's why poll_idle()
> introduced a rate limit on polling (which the generic definition
> reused here.)

Right, I misunderstood how this works, so this part is fine.

>> - I generally dislike the type-agnostic macros like this one,
>>   it adds a lot of extra complexity here that I feel can be
>>   completely avoided if we make explicitly 32-bit and 64-bit
>>   wide versions of these macros. We probably won't be able
>>   to resolve this as part of your series, but ideally I'd like
>>   have explicitly-typed versions of cmpxchg(), smp_load_acquire()
>>   and all the related ones, the same way we do for atomic_*()
>>   and atomic64_*().
>
> Ah. And the caller uses say smp_load_acquire_long() or whatever, and
> that resolves to whatever makes sense for the arch.
>
> The __unqual_scalar_typeof() does look pretty ugly when looking at the
> preprocesed version but other than that smp_cond_load() etc look
> pretty straight forward. Just for my curiousity could you elaborate on
> the complexity?

The nested macros with __unqual_scalar_typeof() make the
preprocessed version completely unreadable, especially when
combined with other sets of complex macros like min()/max(),
tracepoints or arm64 atomics.

If something goes wrong inside of it, it becomes rather
hard for people to debug or even read the compiler warnings.
Since I do a lot of build testing, I do tend to run into those
more than others do.

I've also seen cases where excessively complex macros get
nested to the point of slowing down the kernel build, which
can happen once the nesting expands to megabytes of source
code.

     Arnd

