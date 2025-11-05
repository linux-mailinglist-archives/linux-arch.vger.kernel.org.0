Return-Path: <linux-arch+bounces-14517-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D89EC35241
	for <lists+linux-arch@lfdr.de>; Wed, 05 Nov 2025 11:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 570E63B2DFB
	for <lists+linux-arch@lfdr.de>; Wed,  5 Nov 2025 10:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD50F30505B;
	Wed,  5 Nov 2025 10:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="JucRCD8l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uXXCqiE5"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530C7301007;
	Wed,  5 Nov 2025 10:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762339275; cv=none; b=KtUffElRtUfLP7LLgbdNyJ9/A5JhiwKfGXiFfvZnx9oVZOyCv4iXit2th4zsLcR7/8fpkYZ1QfCZylSzxplP/R5IjtgrozOwAebdYwmx8aEp3IJIY3eoK0J/gsX6kkC+BtdO+4D9fuaRvkvp5wMChksxdMBlQ9kvU0G9FJpFY7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762339275; c=relaxed/simple;
	bh=RAhuk8SB4STeVQWXzK35AWod9u15ucxFcd9ZonQyeXM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=i3Keb8ctqSUiWRpn77u915gVADIDLIAndApd9DVcx7SBNzRqEBVi1BYG+NML6dCPxZeSrhiiy/i9nop1JNp7w4rVw3tdsOYTbwve6IQ5faiPgPyLmI4OdRatbCG4OsrSP04OA6GHC8KyPTI4T6PrAlkQjp4waylrZT0+Ovf2Mgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=JucRCD8l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uXXCqiE5; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 0FD941D0004A;
	Wed,  5 Nov 2025 05:41:11 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Wed, 05 Nov 2025 05:41:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762339270;
	 x=1762425670; bh=bvAiRx3uwEuD8DW8gu/kdX/dizLums2NJ7ZQAKbtM/0=; b=
	JucRCD8lPjgEyVrwbCPlnHfTNrcK89CLE+B4DoVqD805L2CoDH/s3hIRZCn9vnK8
	crLgpagyHHqYjJ57aUYyuvoUz8rs/lL+avjn/f383RyeVLSRdAjvqez98RzJcgf7
	7MZeXgVOsT2B7EXFwa/XX79SJz1s3r4MuXOdaJW1larpxpwF74jrFFlWALLqWI8w
	Qz0ObY6i/1lEkq17Nte+CxpT1NDrXGT6cEzx21Br5Y6AKy0QO2t0G41bIlSEEHE1
	AT21eTg8uLXWRHJLAthAgU2S+vaBlFMq0ue+a7Jh2K2dtkCK4/tehFeH/soCwFTO
	ISCctO/A2PwOuMhIV2cL/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762339270; x=
	1762425670; bh=bvAiRx3uwEuD8DW8gu/kdX/dizLums2NJ7ZQAKbtM/0=; b=u
	XXCqiE5JdhnpTngrIvGHAzSQZ0+Zvt5fSYSrvC+xAV8Mnr+TzG1FdV/dP4hBP5td
	HyU6GZ0b9/dUo7e79WmGgNIq6vZKyVqMTe3P1o/TnfzVL92HaTqC1+V6TtYKcGlA
	g/RJlxxzxXKUwaoLj4IGSOYnqTAPyxJjpnm5btwi0hzlt0Y5EHJAQMSC72JfmZ0z
	VkZv2G8zdAMGMfYA8jB8Gyq9sNHu5cN1/hVnIpY90JDIPqGW1+WfdEQTFFoEarun
	x50s0Xfw6YtkcbQaWYagL9HcnpAne0iDuPj+UI1z3q3AO7wuy4vfAjJlCwwVJ1Q0
	2pRC9iJKPJwImxSQivDOA==
X-ME-Sender: <xms:xCkLadjqEgqBmmzaP9fGmrS18GGfJ3L9DQGuiRytSCSKL9SRhkCWnQ>
    <xme:xCkLac3huvP4wJSMYLLwLftnuZYkZoFvQGR3p7ArHMLx4XjnxlZZr2M5BiQ7mRd2D
    CZzjYlza5RJjn0fNhmpTav7G42lo0MdanwEJO6QkOP-6Phm7Jld4zvo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeefieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepfefhheetffduvdfgieeghfejtedvkeetkeejfeekkeelffejteevvdeghffhiefh
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgt
    phhtthhopedvvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhgrrhhishhokh
    hnsegrmhgriihonhdrtghomhdprhgtphhtthhopegtrghtrghlihhnrdhmrghrihhnrghs
    segrrhhmrdgtohhmpdhrtghpthhtohepmhgrrhhkrdhruhhtlhgrnhgusegrrhhmrdgtoh
    hmpdhrtghpthhtoheptghlsehgvghnthifohdrohhrghdprhgtphhtthhopehmvghmgiho
    rhesghhmrghilhdrtghomhdprhgtphhtthhopeiihhgvnhhglhhifhgvnhhgudeshhhurg
    ifvghirdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhg
    pdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvg
    hlsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:xSkLaSdibJWgIc9pb8TUJorGV9-b-GctbUSl5sYnAAlsGK-XDPGmEA>
    <xmx:xSkLaXx7WhMnGyDxJDZTHgtU6UC-C6GxsXeQAGN0VLrskLOXpfdYPg>
    <xmx:xSkLaTiYwrQXcuyWD-VR2oQCgAl7qFatxaBgtu8MJtIDmDhS6xPYqA>
    <xmx:xSkLaU4TjrGy1u3JxXs6wZPNv9GVqWPraa4QvE557TLEo0_JBj0Omg>
    <xmx:xikLaRd1VkHsvtAqk77tkfzl9M4ryinSq5T-ScnKLetKMA17SPWyrhGp>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DFAFE700063; Wed,  5 Nov 2025 05:41:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ab2ZwGVH8-qs
Date: Wed, 05 Nov 2025 11:37:53 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ankur Arora" <ankur.a.arora@oracle.com>,
 "Catalin Marinas" <catalin.marinas@arm.com>
Cc: linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 bpf@vger.kernel.org, "Will Deacon" <will@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
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
Message-Id: <d087f250-daf1-429f-8ce0-c4f4332d0469@app.fastmail.com>
In-Reply-To: <87jz04anq1.fsf@oracle.com>
References: <20251028053136.692462-1-ankur.a.arora@oracle.com>
 <20251028053136.692462-3-ankur.a.arora@oracle.com>
 <3642cfd1-7da6-4a75-80b7-00c21ab6955f@app.fastmail.com>
 <87qzumq51p.fsf@oracle.com> <aQEy6ObvE0s2Gfbg@arm.com>
 <746c2de4-7613-4f13-911c-c2c4e071ed73@app.fastmail.com>
 <87ikfqesr2.fsf@oracle.com> <aQoF1-uKTgJo89W8@arm.com>
 <87jz04anq1.fsf@oracle.com>
Subject: Re: [RESEND PATCH v7 2/7] arm64: barrier: Support
 smp_cond_load_relaxed_timeout()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Nov 5, 2025, at 09:27, Ankur Arora wrote:
> Catalin Marinas <catalin.marinas@arm.com> writes:
>> On Mon, Nov 03, 2025 at 01:00:33PM -0800, Ankur Arora wrote:
>> With time_end_ns being passed to cpu_poll_relax(), we assume that this
>> is always the absolute time. Do we still need time_expr in this case?
>> It works for WFET as long as we can map this time_end_ns onto the
>> hardware CNTVCT.
>>
>> Alternatively, we could pass something like remaining_ns, though not
>> sure how smp_cond_load_relaxed_timeout() can decide to spin before
>> checking time_expr again (we probably went over this in the past two
>> years ;)).
>
> I'm sure it is in there somewhere :).
> This one?: https://lore.kernel.org/lkml/aJy414YufthzC1nv@arm.com/.
> Though the whole wait_policy thing confused the issue somewhat there.
>
> Though that problem exists for both remaining_ns and for time_end_ns
> with WFE. I think we are fine so long as SMP_TIMEOUT_POLL_COUNT is
> defined to be 1.

We need to be careful with the definition of the time_expr() if
cpu_poll_relax requires the absolute time in CNTVCT domain.
We're probably fine here, but it feels like a bit of a layering
violation. I think passing relative time into it would be cleaner
because it avoids the ambiguity it but probably requires an extra
access to the timer register that is hopefully fast on arm64.

I'm ok with either way.

> For now, I think it makes sense to always pass the absolute deadline
> even if the caller uses remaining_ns. So:
>
> #define smp_cond_load_relaxed_timeout(ptr, cond_expr, time_expr, remaining_ns)	\
> ({									\
> 	typeof(ptr) __PTR = (ptr);					\
> 	__unqual_scalar_typeof(*ptr) VAL;				\
> 	u32 __n = 0, __spin = SMP_TIMEOUT_POLL_COUNT;			\
> 	u64 __time_start_ns = (time_expr);				\
> 	s64 __time_end_ns = __time_start_ns + (remaining_ns);		\
> 									\
> 	for (;;) {							\
> 		VAL = READ_ONCE(*__PTR);				\
> 		if (cond_expr)						\
> 			break;						\
> 		cpu_poll_relax(__PTR, VAL, __time_end_ns);		\

This looks perfectly fine to me, thanks for the update!

    Arnd

