Return-Path: <linux-arch+bounces-14377-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 349ECC13E57
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 10:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C62D4001AD
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 09:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BE32D8DB0;
	Tue, 28 Oct 2025 09:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="hZ3Zu+2c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qI2XE+kW"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62BC221271;
	Tue, 28 Oct 2025 09:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761644596; cv=none; b=T6b2lJelt/shMAQqnYPaCn3PaeV3vrsNogWPfm8Gic1FlL+n+/lsLtQiPKWSF5Ct1zpamiVLCqo42er+AfDzS1MFC/W6imfYwX9bFvV1UsFf3brPrIyK/mO9gItAo0qAXOBv/ISBNJYUvWedeh0znRbwTPRX8me76XaX7AxsAMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761644596; c=relaxed/simple;
	bh=7SwGEFWgVJYL+WqqeJIHpTCNGoh9w23ubHCRPn5kD+g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Jg5s+IuVc1A3DSbXEi2UhHdaPXK8oMQh8PTex7Cq63W5aAb9JQEGBJbj33c+NqJ9MYD4ijeMqZibIL/k+o6lKIbsG6ZJ6ZAJGUE7/XnWgm1Nq5swNedKMG2tQDEfbg1zglPPu2MdLXkyQ+nIYlW8QAjGZl08oQOUTZb9S5CRyeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=hZ3Zu+2c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qI2XE+kW; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DC06C1400312;
	Tue, 28 Oct 2025 05:43:12 -0400 (EDT)
Received: from phl-imap-17 ([10.202.2.105])
  by phl-compute-04.internal (MEProxy); Tue, 28 Oct 2025 05:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761644592;
	 x=1761730992; bh=6R82CPYt/trwZwdJVbkGNN3GySFpmpbKddDWCQfqcFo=; b=
	hZ3Zu+2c8VXu+fb3s7a4V6sVyr6Dkmgp4waxkIifbc1vZkIdkfwhhYjHFhNiQH7u
	iD3Fb5MHRe4LHk+JLFnGP6N9lk9gHCy6jwSfrTr9y8tHQvYBXZfQMusoMyjUdFBS
	2lQFogp/OgiY72SRE6lQ/40zdHYxhj4GhK37lvKZ6dvLWzIPFdEJqbCA6O9H1CHl
	TnYwMBaK04oGqKLcvppXhgXf0yyQVgeIi1XdexRTb8zzjBOywni1wM6ZmptvLV94
	O9VImnZmAIxlq3jjov/lbR9uYxW3KNHHB5qXSKxw7XYWVG4iOlRSVwiuSCaj/8Hb
	EwbeHF4RhCi6fiUpRVF7Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761644592; x=
	1761730992; bh=6R82CPYt/trwZwdJVbkGNN3GySFpmpbKddDWCQfqcFo=; b=q
	I2XE+kWL9O2Whx5kWRXiy7vupMuCpcBYU6gds3UU4lfCD1P55It2vTCmEDBTNQsz
	Hg5C607peIZLudzQA3ottt3RGXq23BUXq8odSLdKNL5vRndkry/OBXSvWg3bXT/E
	cyYe2GbqZAu4ssV2/JAYvSh+MIciqGKtfSuxzChqSYsR1wWV92cnnPZhv3lMJM7J
	CfvK9CD+k7gU6QbyDk1wRxHIuxrWb67RZLC9khyxoRFmr3UP1eYQfd+Mzopdw2wV
	W2Mtpi3T3y+NnTzuzpu65dJ0v8MuuHmI92tiJP3YgVT6mIjGN2iNc6VRLo45ERu3
	oBLPI6ESDu9EmU4RbKP4A==
X-ME-Sender: <xms:L5AAaepgVhI_--biGubsM3Nr3M8wlN6VDYKz6TPmJjGVCeEFru0K4A>
    <xme:L5AAaXdTIIlkvOHjYT5jjJlI_2GO-8IJJ77k0gE69fz-3yB0TInq81plJ8-oTuaKR
    QM9o_PLUt9-GsrcqqpUyHFii8QTUNg891YZ1-T1tOm0zWxtREnIQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedthedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:L5AAaQkEZbpjcMrnp2cBz3cCrzlBjlNPk_WjmqKFkTj3wM9E1zbjGQ>
    <xmx:L5AAabZ0AGvD9DnKHfkLINOX7_s4yUcHdFAYIRKxXSJDYy73vNlamQ>
    <xmx:L5AAaerRzzEh0ex-jpkrwDUeiZ33DGeLCXgCoL8uzZGYltOx0Kr1_g>
    <xmx:L5AAaRiQHV7UBgJPQtk5tVYmq_rsY9kiIv6monQX0FSBIB5oa-NYNg>
    <xmx:MJAAaRmcloNIn3dV-9w2KbccA11-XAcB3f44646tPJd_EK2pjxru_KiP>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1CD9EC40054; Tue, 28 Oct 2025 05:43:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ArFVEkIwmB-N
Date: Tue, 28 Oct 2025 10:42:49 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ankur Arora" <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 bpf@vger.kernel.org
Cc: "Catalin Marinas" <catalin.marinas@arm.com>,
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
Message-Id: <4c87bbf8-00a3-4666-b844-916edd678305@app.fastmail.com>
In-Reply-To: <20251028053136.692462-2-ankur.a.arora@oracle.com>
References: <20251028053136.692462-1-ankur.a.arora@oracle.com>
 <20251028053136.692462-2-ankur.a.arora@oracle.com>
Subject: Re: [RESEND PATCH v7 1/7] asm-generic: barrier: Add
 smp_cond_load_relaxed_timeout()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Oct 28, 2025, at 06:31, Ankur Arora wrote:

> + */
> +#ifndef smp_cond_load_relaxed_timeout
> +#define smp_cond_load_relaxed_timeout(ptr, cond_expr, time_check_expr)	\
> +({									\
> +	typeof(ptr) __PTR = (ptr);					\
> +	__unqual_scalar_typeof(*ptr) VAL;				\
> +	u32 __n = 0, __spin = SMP_TIMEOUT_POLL_COUNT;			\
> +									\
> +	for (;;) {							\
> +		VAL = READ_ONCE(*__PTR);				\
> +		if (cond_expr)						\
> +			break;						\
> +		cpu_poll_relax(__PTR, VAL);				\
> +		if (++__n < __spin)					\
> +			continue;					\
> +		if (time_check_expr) {					\
> +			VAL = READ_ONCE(*__PTR);			\
> +			break;						\
> +		}							\
> +		__n = 0;						\
> +	}								\
> +	(typeof(*ptr))VAL;						\
> +})
> +#endif

I'm trying to think of ideas for how this would done on arm64
with FEAT_FWXT in a way that doesn't hurt other architectures.

The best idea I've come up with is to change that inner loop
to combine the cpu_poll_relax() with the timecheck and then
define the 'time_check_expr' so it has to return an approximate
(ceiling) number of nanoseconds of remaining time or zero if
expired.

The FEAT_WFXT version would then look something like

static inline void __cmpwait_u64_timeout(volatile u64 *ptr, unsigned long val, __u64 ns)
{
   unsigned long tmp;
   asm volatile ("sev; wfe; ldxr; eor; cbnz; wfet; 1:"
        : "=&r" (tmp), "+Q" (*ptr)
        : "r" (val), "r" (ns));
}
#define cpu_poll_relax_timeout_wfet(__PTR, VAL, TIMECHECK) \
({                                                    \
       u64 __t = TIMECHECK;
       if (__t)
            __cmpwait_u64_timeout(__PTR, VAL, __t);
})

while the 'wfe' version would continue to do the timecheck after the
wait.

I have two lesser concerns with the generic definition here:

- having both a timeout and a spin counter in the same loop
  feels redundant and error-prone, as the behavior in practice
  would likely depend a lot on the platform. What is the reason
  for keeping the counter if we already have a fixed timeout
  condition?

- I generally dislike the type-agnostic macros like this one,
  it adds a lot of extra complexity here that I feel can be
  completely avoided if we make explicitly 32-bit and 64-bit
  wide versions of these macros. We probably won't be able
  to resolve this as part of your series, but ideally I'd like
  have explicitly-typed versions of cmpxchg(), smp_load_acquire()
  and all the related ones, the same way we do for atomic_*()
  and atomic64_*().

       Arnd

