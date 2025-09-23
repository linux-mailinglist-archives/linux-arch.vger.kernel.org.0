Return-Path: <linux-arch+bounces-13736-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 957CBB974E6
	for <lists+linux-arch@lfdr.de>; Tue, 23 Sep 2025 21:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F4B42A6542
	for <lists+linux-arch@lfdr.de>; Tue, 23 Sep 2025 19:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4887302CBF;
	Tue, 23 Sep 2025 19:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="0BiAbPrc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="laYJFjYl"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C7E1A238C;
	Tue, 23 Sep 2025 19:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758654738; cv=none; b=F07qSSEqdhmVgyABT53MpDoy3UP5YvetQ8Bo7wdcEdZDnZt8YyPoAOZbeTlkcdgjUbdXSpw9eYzsy+iOAPfSjAabaTDX+YloIyodKfuv2azbYY3rjh0kGmGu+nwuH3QswZoxpc0jqpd1HDYnVH9Gtur+QWj/FxbzIgikxxGkP7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758654738; c=relaxed/simple;
	bh=K9hUxD1sDBQjJycPokUgcShClv5YGLDQwzjF05XesCg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=sWjYUfgnHOJbpJ3bCFn9QWKqjN1JITkhh5GkWoPtjwVwwT/dWp1Di6B1LiWdIxxX5/yyfUejPvQyPHdh8BC90Papw9xRKt15tJg2SflCiXQiPP1uH/17pquJUP/nCOp6tNI44fWOXER6EGQ6mMv8LTHwwahWvZXREMChSLzmHmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=0BiAbPrc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=laYJFjYl; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 8ED761D001E2;
	Tue, 23 Sep 2025 15:12:13 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Tue, 23 Sep 2025 15:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758654733;
	 x=1758741133; bh=iUiT2Fl+6MjOXvC+Q0lwYMXWDbppNCqwm5jrh/TyslY=; b=
	0BiAbPrc4I54T23GlrH+iGowUChevpO8+3nVvQK6FUnssG3HcbHM/7HG0ma7ISCN
	rw5Hh3GxExHG19YK8BA0mAFxCARgjOcZ6NJszXwmxzWs0HO++ZupGfWyXEt7Sr8q
	PJGj17KqH3dFgQYPS60Z8FgiALEKc8UMbu/5aDMVFn4WUEOcBdb0Y2TXJQ2uT9WP
	XmBo5/NBtbBgtb2vpRZKMXRkBj7E6B0A3TtRaA3fEQdfLeg0NVfUklU3cVr5Jeyu
	lGbD5bWt326h+Fd62mKKNrKHqpCqXqp00L7PPHNG3BdFWYQtSXgaBVpVl6+NkPeH
	CLAEi+e6Y6WmrWNeB1h2RA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758654733; x=
	1758741133; bh=iUiT2Fl+6MjOXvC+Q0lwYMXWDbppNCqwm5jrh/TyslY=; b=l
	aYJFjYlU2Bni4MQ7cU4cvarP52j8CwAw3TARt88G/SvcuDDfJrsbhnhgxt35yqAk
	TwHyg/CQqzBRVSCljmKNsXzj4fh6u6DafI5Ym7tpGJcHp83dTZIbmsmYKWiJ+xoq
	rFZVh0ixm8H134H4hBfeZWu1xnyFksA2ENbjnvoR+IfqO+VeU866q1prECqgEZA+
	NBOca/LjkM92sqw5IkjEC38rUQiAnAlN9bw2t9G2PhNCVzb8TLRgaLuQslNJPJ08
	kcVMRpLjCTJNl7G0we1UV12ayUdx6xhN2Gx5Dj9hCdeeQ1r4550kj6zoJ8xTct8E
	YlF/ZBO8HlKSQzd5uSxDQ==
X-ME-Sender: <xms:DPHSaDIHsgfBAHZluoyVxLK5ejuOZbZuLyBKR3kRVEi02syjWI5XWQ>
    <xme:DPHSaB_Q6hI6geTUqa6OWKf8keIR6k7nhMejJHAwx_AImBJuycpLo4BhsD8Hof6HT
    PW4VrEI7uCaGAwX4l5NnofQHWL7JQGkyBAfsQstQ9vlA8AOYnVS2E4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepmhgrrhhkrdhruhhtlhgrnhgusegrrhhmrdgtohhmpdhrtghpthhtoh
    epsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvthgvrhii
    sehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhg
    pdhrtghpthhtohepfhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtth
    hopehgvggvrhhtsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehlrghntggv
    rdihrghngheslhhinhhugidruggvvhdprhgtphhtthhopegtohhrsggvtheslhifnhdrnh
    gvth
X-ME-Proxy: <xmx:DPHSaPEqVqZo97lvmb3tEneaotIr7nAqindr7Lq6ynAXSyA8d2iqvg>
    <xmx:DPHSaCtN2yPPNz-0iZm-NczqWZy7aTeEvcMswZvYA1Suy73QCAQ0Gw>
    <xmx:DPHSaNaeSDZgNy-QIxe6yFw-f_O_90xpjPBorxoz281ktIM5dzMoMw>
    <xmx:DPHSaK6EVcKt_cqamKBK3Vvae_RDjMCRaY-pPzu2_2Jj8iI7uLetmw>
    <xmx:DfHSaOG9d_xB2qs67oRkDLQwwHxNkQfa9NA1gTkSR3FeiGw-oG6g4w4o>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7CB7F700069; Tue, 23 Sep 2025 15:12:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ah_uXtpTlO07
Date: Tue, 23 Sep 2025 21:11:42 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Finn Thain" <fthain@linux-m68k.org>
Cc: "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Peter Zijlstra" <peterz@infradead.org>, "Will Deacon" <will@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Jonathan Corbet" <corbet@lwn.net>,
 "Mark Rutland" <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-m68k@vger.kernel.org,
 "Lance Yang" <lance.yang@linux.dev>
Message-Id: <da6cf99f-6da9-4cf7-9028-79580a8d7b2a@app.fastmail.com>
In-Reply-To: <3b55179e-b290-bbf5-fdf2-bb7834884017@linux-m68k.org>
References: <cover.1757810729.git.fthain@linux-m68k.org>
 <abf2bf114abfc171294895b63cd00af475350dba.1757810729.git.fthain@linux-m68k.org>
 <CAMuHMdUgkVYyUvc85_P9TyTM5f-=mC=+X=vtCWN45EMPqF7iMg@mail.gmail.com>
 <6c295a4e-4d18-a004-5db8-db2e57afc957@linux-m68k.org>
 <57ac401b-222b-4c85-b719-9e671a4617cf@app.fastmail.com>
 <86be5cf0-065e-d55d-fdb6-b9cf6655165e@linux-m68k.org>
 <d707b875-8e3c-4c18-a26f-bf2c5f554bc2@app.fastmail.com>
 <3b55179e-b290-bbf5-fdf2-bb7834884017@linux-m68k.org>
Subject: Re: [RFC v2 2/3] atomic: Specify alignment for atomic_t and atomic64_t
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Sep 23, 2025, at 10:05, Finn Thain wrote:
> On Tue, 23 Sep 2025, Arnd Bergmann wrote:
>> On Tue, Sep 23, 2025, at 08:28, Finn Thain wrote:
>>
>> Maybe we should just change __alignof__(unsigned long long) to a plain 
>> '8' here and make that the minimum alignment everywhere, same as the 
>> atomic64_t alignment change.
>> 
>
> It would be better (less wasteful of memory) to specify the alignment 
> parameter to kmem_cache_create() only at those call sites where it 
> matters.

I think that's the idea: __alignof__(unsigned long long) is the
alignment that the ABI requires for allocating arbitrary data
structures that may contain 64-bit integers, so this is already
the minimum. Architectures that may have noncoherent DMA master
devices often need to raise the ARCH_KMALLOC_MINALIGN to the cache
line size but leave the ARCH_SLAB_MINALIGN at the ABI-required
minimum value. Any caller that needs a higher alignment than the
ABI minimum needs to specify that.

>> Alternatively, we can keep the __alignof__ here in order to reduce 
>> padding on architectures with a default 4-byte alignment for __u64, but 
>> then override ARCH_SLAB_MINALIGN and ARCH_KMALLOC_MINALIGN on m68k to be 
>> '4' instead of '2'.
>> 
>
> Raising that to 4 would probably have little or no effect (for m68k or any 
> other arch). Back when I prepared the RFC patch series, I instrumented 
> create_cache() in mm/slab_common.c, and those caches that were allocated 
> at boot (for my usual minimal m68k .config) were already aligned to 4 
> bytes or 16.

Ok

> Also, increasing ARCH_SLAB_MINALIGN to 8 didn't solve the VFS/TTY layer 
> problem I have with CONFIG_DEBUG_ATOMIC on m68k. So the culprit is not the 
> obvious suspect (a kmem cache of objects with atomic64_t members). There's 
> some other allocator at work and it's aligning objects to 2 bytes not 4.

In that case, my guess would be something that concatenates structures
in some variant of

struct s1 {
     int a;
     short b;
     int rest[];
};

struct s2 {
     atomic_t a;
};

     struct s1 *obj1 = kmalloc(sizeof(struct s1) + sizeof(struct s2), GFP_KERNEL);
     struct s2 *obj2 = (void*)&obj1[1];

which causes problems because s2 has a larger alignment than s1.
We've had problems with DMA to structures like this in the past.

The more common construct that does

struct s1 {
     short a;
     struct s2;
};

should not produce misaligned members in the inner struct,
unless the outer one has a __packed attribute. Unfortunately
we disabled -Wpacked-not-aligned, which would otherwise catch
that problem.

     Arnd

