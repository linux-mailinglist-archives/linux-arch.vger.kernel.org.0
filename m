Return-Path: <linux-arch+bounces-13724-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BDBB94EB4
	for <lists+linux-arch@lfdr.de>; Tue, 23 Sep 2025 10:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 825B0484F68
	for <lists+linux-arch@lfdr.de>; Tue, 23 Sep 2025 08:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DC03191D8;
	Tue, 23 Sep 2025 08:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HGBqskiY"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AD73191D6;
	Tue, 23 Sep 2025 08:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758614760; cv=none; b=P6QeXlpHpb2EsWPQDE6dpVlAiAw/+NI7LrU0psZFjvzJtPkLy1YHk92OVi3pdIZjmyBquTb88BQeKNDtoE0UbjYmLCExJMQ3A8yToqeFgklpqURirQRiqW/c7XHSf79aaoZi8Uh28Y80/42/fOcX7an2a1iHjTYP5eoWEK9Dc34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758614760; c=relaxed/simple;
	bh=yNHzc7LJKJBnquHWz2WBCHWhmln5tYYqkJ/w13zzswg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lQ7G+TVIueF4Ol4CLpYqi6Rwm/csw/wLJR/QRpRn9VYNWdkNL1zahbCZMfEL5bi6kXP6Z5/zThDm7zDYOPRO0cna4boslzA1DldX0AXFOfB6pWUPh/GdB+W/1G5FyNYULHn21X2yva4LwxxjFs67DWehDjrB3aPJsDJYqmp7Pk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HGBqskiY; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 05C2DEC00D8;
	Tue, 23 Sep 2025 04:05:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 23 Sep 2025 04:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758614757; x=1758701157; bh=HsNf8DJ2SZR8XPmPI1ImnGlY7viJV3KBY1t
	tBHJeqA0=; b=HGBqskiYYAuByvO4Ban8x9INTx7pSSh2Vv/Ed0WbX8ENMGLdlzE
	FY/035R2G7oAjYLLPlrFXUYUErcxbpbpujOP8Htar0TAw8v8IgyCnabIpbdvXLwE
	I/t9rb3ZCegUkKNbOxk9a2a0Z06UPl2wk8EGW6rGc63El89P9ShOVbrc09ByifXV
	VzHTWBwaCalKMaCzsaSyWUWt6odDmR6E7TIGZEgEYZiHOVY95/Aa7Rdljd3aq75T
	MUYDRqxTBwxIEXVAgi9LpgzMknqCB2lV9fyiQ4Fxig4QdjHlNHfVvNKr/bUqAhor
	kOoBSXqxIQJTUHHwVudgh8iiVFEf4/SDQcg==
X-ME-Sender: <xms:5FTSaIffj3JthDNWw6ZEo0KJVpPn-MvIIuOGamqQRhFhzPq7z7b_xQ>
    <xme:5FTSaEqEIvbJzM0BhLTsTztzEdRzPgkoXVAxfQrK0BflIBu7TvdoAQ7I4y9k8B6PC
    hKHJJM8HTZcH76GFAvNdzJ4uJ6MAw_SedumIY7Phwtb8IZgmh2rcio>
X-ME-Received: <xmr:5FTSaBBOL0IAboKoxUsGneAmD3qLGhcAhwVEywYBXD98LHg1vUGvMQXSNTLmdyCJ3MAp2uV_sK4u1CoiFfm_Njj9ZcKYkfmmWK8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfvhhgr
    ihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepleeuheelheekgfeuvedtveetjeekhfffkeeffffftdfgjeevkeegfedvueehueel
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhthh
    grihhnsehlihhnuhigqdhmieekkhdrohhrghdpnhgspghrtghpthhtohepuddvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegrrhhnugesrghrnhgusgdruggvpdhrtghpth
    htohepghgvvghrtheslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtohepphgvthgv
    rhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdho
    rhhgpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpth
    htoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtohepmhgrrhhkrdhruhhtlhgr
    nhgusegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:5FTSaFe-9gET0cQqA5CMm5ydSRJGb4RzB-3EcqmgubJ_5GL72JmDxA>
    <xmx:5FTSaJvUstR3Equ9afU6blRRic64eTGwfQ2FFejy_s_p2LHxP4wlLQ>
    <xmx:5FTSaMjS9Tz21UE6tMCdzVGSUeIHUB12wAnvmbMKVjr4KHKA2O0Ovg>
    <xmx:5FTSaBu7FJ7Z4yaldl-S3qwQJQqMmhpEGgLjmg7jyMBY5JtYMkIGeA>
    <xmx:5FTSaI3oTB5FlXkXHMZRie9BuoZbpPgzKia9TbKO2cz9T2fotupg89Hw>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 04:05:54 -0400 (EDT)
Date: Tue, 23 Sep 2025 18:05:51 +1000 (AEST)
From: Finn Thain <fthain@linux-m68k.org>
To: Arnd Bergmann <arnd@arndb.de>
cc: Geert Uytterhoeven <geert@linux-m68k.org>, 
    Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
    Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, 
    Linux-Arch <linux-arch@vger.kernel.org>, linux-m68k@vger.kernel.org, 
    Lance Yang <lance.yang@linux.dev>
Subject: Re: [RFC v2 2/3] atomic: Specify alignment for atomic_t and
 atomic64_t
In-Reply-To: <d707b875-8e3c-4c18-a26f-bf2c5f554bc2@app.fastmail.com>
Message-ID: <3b55179e-b290-bbf5-fdf2-bb7834884017@linux-m68k.org>
References: <cover.1757810729.git.fthain@linux-m68k.org> <abf2bf114abfc171294895b63cd00af475350dba.1757810729.git.fthain@linux-m68k.org> <CAMuHMdUgkVYyUvc85_P9TyTM5f-=mC=+X=vtCWN45EMPqF7iMg@mail.gmail.com> <6c295a4e-4d18-a004-5db8-db2e57afc957@linux-m68k.org>
 <57ac401b-222b-4c85-b719-9e671a4617cf@app.fastmail.com> <86be5cf0-065e-d55d-fdb6-b9cf6655165e@linux-m68k.org> <d707b875-8e3c-4c18-a26f-bf2c5f554bc2@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Tue, 23 Sep 2025, Arnd Bergmann wrote:

> On Tue, Sep 23, 2025, at 08:28, Finn Thain wrote:
> > On Mon, 22 Sep 2025, Arnd Bergmann wrote:
> >> On Mon, Sep 22, 2025, at 10:16, Finn Thain wrote:
> > @@ -8,7 +8,7 @@ struct vfsmount;
> >  struct path {
> >         struct vfsmount *mnt;
> >         struct dentry *dentry;
> > -} __randomize_layout;
> > +} __aligned(sizeof(long)) __randomize_layout;
> >
> > There's no need: struct path contains a struct dentry, which contains a 
> > seqcount_spinlock_t, which contains a spinlock_t which contains an 
> > atomic_t member, which is explicitly aligned.
> >
> > Despite that, there's still some kmem cache or other allocator somewhere 
> > that has produced some misaligned path and dentry structures. So we get 
> > misaligned atomics somewhere in the VFS and TTY layers. I was unable to 
> > find those allocations.
> 
> Ok, I see. Those would certainly be good to find. I would assume that 
> all kmem caches have a sensible alignment on each architecture, but I 
> think the definition in linux/slab.h actually ends up setting the 
> minimum to 2 here:
> 
> #ifndef ARCH_KMALLOC_MINALIGN
> #define ARCH_KMALLOC_MINALIGN __alignof__(unsigned long long)
> #elif ARCH_KMALLOC_MINALIGN > 8
> #define KMALLOC_MIN_SIZE ARCH_KMALLOC_MINALIGN
> #define KMALLOC_SHIFT_LOW ilog2(KMALLOC_MIN_SIZE)
> #endif
> 
> #ifndef ARCH_SLAB_MINALIGN
> #define ARCH_SLAB_MINALIGN __alignof__(unsigned long long)
> #endif
> 
> Maybe we should just change __alignof__(unsigned long long) to a plain 
> '8' here and make that the minimum alignment everywhere, same as the 
> atomic64_t alignment change.
> 

It would be better (less wasteful of memory) to specify the alignment 
parameter to kmem_cache_create() only at those call sites where it 
matters.

> Alternatively, we can keep the __alignof__ here in order to reduce 
> padding on architectures with a default 4-byte alignment for __u64, but 
> then override ARCH_SLAB_MINALIGN and ARCH_KMALLOC_MINALIGN on m68k to be 
> '4' instead of '2'.
> 

Raising that to 4 would probably have little or no effect (for m68k or any 
other arch). Back when I prepared the RFC patch series, I instrumented 
create_cache() in mm/slab_common.c, and those caches that were allocated 
at boot (for my usual minimal m68k .config) were already aligned to 4 
bytes or 16.

Also, increasing ARCH_SLAB_MINALIGN to 8 didn't solve the VFS/TTY layer 
problem I have with CONFIG_DEBUG_ATOMIC on m68k. So the culprit is not the 
obvious suspect (a kmem cache of objects with atomic64_t members). There's 
some other allocator at work and it's aligning objects to 2 bytes not 4.

