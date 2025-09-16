Return-Path: <linux-arch+bounces-13645-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CCFB588FA
	for <lists+linux-arch@lfdr.de>; Tue, 16 Sep 2025 02:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB56552095D
	for <lists+linux-arch@lfdr.de>; Tue, 16 Sep 2025 00:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89EEBA4A;
	Tue, 16 Sep 2025 00:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DTwym6wB"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75C915A8;
	Tue, 16 Sep 2025 00:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757981789; cv=none; b=N5kjfxzc6onXGVVoZqro3/JlfmViszcXnCBd1LNtiyxeVQCBgIw+ILlWonBmlsUWIbqzn2TdC2QBrQKJ+I4JPSzAYpk8vk7TNOwT97Tf/7QgZvl3FjlvACgYXuvemVBMWWXjYW3c5SMUSSgZt5yIUsraXbm28xLumQTS2whE2h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757981789; c=relaxed/simple;
	bh=7wyvt1aUEIplVhO7XedK4IOEAVq8hHM1yH+qSy1rpJc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=d+YCqxBVKDrDY3MC718pouogErLVR/fciY7t1DunkfOn+lbBD4j6L3Z+d8RgrmQ/ZLk9z+2EZDhfL/0GZRR2SDVpppzFnUdoLu1AJXXdJbrVEOXK9d3f0k778SefLTean2gJ5l0YKE7m3DzRRq1gz3PKgE1snUyrLM+gkIUgH4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DTwym6wB; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BF1827A014C;
	Mon, 15 Sep 2025 20:16:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 15 Sep 2025 20:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757981785; x=1758068185; bh=nd5//992Sn2C6rJuZNs6CVfdDJPCaeF3X6A
	0IwVAbQM=; b=DTwym6wB9PyYVJKs++qpVap4g8n//DXe5kH6IHNpkN5mhkE4cr9
	aiNsfvm0OHBL5KHtAp0PiYkuBiovzdO1x/+gLc+pXz+irwRvYjZdMyGb+/pYt8zb
	mCI1CeJDoa+m1eAQDPOcsIF5OKCy2i5WtRnluFnK6iXEKgVZ4w0KtE8sQod8L58e
	GfcAwM2glqqUg1xiQ1xNUPcCrbpcBA89AXdJQXhjlG2CSWSf3tnwL11tLxD1iBjd
	6eQyrDOp4vlN6+VyMC94o/YfawAm8WEWlPQMWss3xZIkXUgZZ5KO3npTvi+f8CeX
	GOXqXAStx/9wbLYGSvtpUZZFnY2S0EutEog==
X-ME-Sender: <xms:WKzIaITbrcF9CCQYLK3qjFtcN_XyKcAh4nXvpumAUfZc0QV89YESDA>
    <xme:WKzIaBl6ID0b0P5BNF26rZ3Ih7XNA71wid1MRelmliMDURM_lDROddoF1ya2OBMAM
    Etl4wWNuhW7-TAIEHk>
X-ME-Received: <xmr:WKzIaBOs4zmVUnA_Ho5weg0WHC-DoUaaEI36Scm3pPElfkusrnEo9AZN_bLx_1WMlV69Kuf5nnHGfjcXxpUlkSRdAlhEAPSgypw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefleduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfvhhgr
    ihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepfeeiheejvdetgfeitddutefhkeeilefhveehgfdvtdekkedvkeehffdtkeevvdeu
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrghinheslhhinhhugidqmheikehkrdho
    rhhgpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    eprghrnhgusegrrhhnuggsrdguvgdprhgtphhtthhopehpvghtvghriiesihhnfhhrrggu
    vggrugdrohhrghdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthho
    pegsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopegtohhrsggvth
    eslhifnhdrnhgvthdprhgtphhtthhopehmrghrkhdrrhhuthhlrghnugesrghrmhdrtgho
    mhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:WKzIaFiTu4CyMwTqs__Fky2KtquFaoP5UpQn-NDKLzR2TRlh__mHaA>
    <xmx:WKzIaPhi6cH_eZBS17w9y5PyajhQt51gXTDziMjjvKDUTq66WH9HBQ>
    <xmx:WKzIaELF6LYk7LUq538ggVi9AXmIiP7QcO5TkFrlqi-Lmdx43BYyLQ>
    <xmx:WKzIaOlWxuDMBAisTH4VbPuxygflomfJgrgn0_It54x0JsgQepAVvA>
    <xmx:WazIaPZfW3Hc61XmKDhjns6h0uUIz3diSE3aUOUcdGwlf9TeTvHoGjIH>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 20:16:21 -0400 (EDT)
Date: Tue, 16 Sep 2025 10:16:12 +1000 (AEST)
From: Finn Thain <fthain@linux-m68k.org>
To: Arnd Bergmann <arnd@arndb.de>
cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
    Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, 
    Linux-Arch <linux-arch@vger.kernel.org>, 
    Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org
Subject: Re: [RFC v2 3/3] atomic: Add alignment check to instrumented atomic
 operations
In-Reply-To: <57bca164-4e63-496d-9074-79fd89feb835@app.fastmail.com>
Message-ID: <1c9095f5-df5c-2129-df11-877a03a205ab@linux-m68k.org>
References: <cover.1757810729.git.fthain@linux-m68k.org> <e5a38b0ccf2d37185964a69b6e8657c992966ff7.1757810729.git.fthain@linux-m68k.org> <20250915080054.GS3419281@noisy.programming.kicks-ass.net> <4b687706-a8f1-5f51-6e64-6eb09ae3eb5b@linux-m68k.org>
 <20250915100604.GZ3245006@noisy.programming.kicks-ass.net> <8247e3bd-13c2-e28c-87d8-5fd1bfed7104@linux-m68k.org> <57bca164-4e63-496d-9074-79fd89feb835@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Mon, 15 Sep 2025, Arnd Bergmann wrote:

> On Mon, Sep 15, 2025, at 12:37, Finn Thain wrote:
> > On Mon, 15 Sep 2025, Peter Zijlstra wrote:
> >>
> >> > When you do atomic operations on atomic_t or atomic64_t, (sizeof(long)
> >> > - 1) probably doesn't make much sense. But atomic operations get used on 
> >> > scalar types (aside from atomic_t and atomic64_t) that don't have natural 
> >> > alignment. Please refer to the other thread about this: 
> >> > https://lore.kernel.org/all/ed1e0896-fd85-5101-e136-e4a5a37ca5ff@linux-m68k.org/
> >> 
> >> Perhaps set ARCH_SLAB_MINALIGN ?
> >> 
> >
> > That's not going to help much. The 850 byte offset of task_works into 
> > struct task_struct and the 418 byte offset of exit_state in struct 
> > task_struct are already misaligned.
> 
> Has there been any progress on building m68k kernels with -mint-align?

Not that I know of.

> IIRC there are only a small number of uapi structures that need
> __packed annotations to maintain the existing syscall ABI.
> 

Packing uapi structures (and adopting -malign-int) sounds easier than the 
alternative, which might be to align certain internal kernel struct 
members, on a case-by-case basis, where doing so could be shown to improve 
performance on some architecture or other (while keeping -mno-align-int).

Well, it's easy to find all the structs that belong to the uapi, but it's 
not easy to find all the internal kernel structs that describe MMIO 
registers. For -malign-int, both kinds of structs are a problem.

If better performance is to be had, my guess is that aligning atomic_t 
will get 80% of it (just an appeal to the Pareto principle, FWIW...)

