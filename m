Return-Path: <linux-arch+bounces-13818-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B99F2BAEF8B
	for <lists+linux-arch@lfdr.de>; Wed, 01 Oct 2025 03:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8BA374E18F6
	for <lists+linux-arch@lfdr.de>; Wed,  1 Oct 2025 01:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A016224DD15;
	Wed,  1 Oct 2025 01:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MlxOv+Lw"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D45F246BB9;
	Wed,  1 Oct 2025 01:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759283199; cv=none; b=U20ukx8JvhbSyeiv5buP3CqRLbNmbIXsxc2Lkzu8DAQwBieUGtrLDNJvEQiDHXcfZWOupJIsS4Hjy4D/gobL+s2e/EQvMO3yrYQzEpMZwYy646ECZwZalXVKzXAyQGeTWaeNJNsInyfeX5cSdwyDZUucQ0SH4gHtwbaFR5RkDnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759283199; c=relaxed/simple;
	bh=mwsU1ysAGhs3U/iSYpxh8bvI2wtk7MMT8xz0AVWe2g4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NvcIinLaYjIv5x1gTRQJWiPBg+yN6ql3tHhPNNJuQMSOW7Xrgu8UnaeU8LYH0phDSRyxH65doEC2AY6VG5IaGvyQSgZWsFO3qPsbIYqkCq9ltKH1WNRJga643JYUbVafNH6LE0x/FPfvv2yqzT9C5ZyTtXrt1rC3DsPY3rakURE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MlxOv+Lw; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 9AF7CEC010C;
	Tue, 30 Sep 2025 21:46:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 30 Sep 2025 21:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759283196; x=1759369596; bh=ivXED/lLknyu9sYEAc0al0uTM1FIS3FdbvE
	tdmKVtoY=; b=MlxOv+LwCVCG7ZxwFbC74EGzjcm7fNEu9PHcvoN3sPE/16frMTf
	ZTXC7uSg7uQyF+DqtoKJo1VeuUG7rzHBFcybk3jybFNTBO8wus8n1T4hZP8RTEqH
	5P2VU9eBIRbE52Evx9MI/uyCH5AvvtkRO/kleDH10Zr5xPb3IFhoYdV4AqQsnlvF
	xn+FsHuBGG35pFO2a6FxytNIWUjtYCThTnA8lNhj6O3br5BLYUoXa3WIXZYq//ql
	mNBdKR6c+N7Ro8DyLQqzKc+4G/HlGF45qn7K4yYXaM/UNSMITy8+LzVYxBxdhfev
	bN1lrI61xFD3XYYdsv3LNU25yoehQGutwZg==
X-ME-Sender: <xms:-4fcaAJ2lmzh67uC0IvTFd2MFKGovp2ErEcX8EFjG9OoM3_1kPU9KA>
    <xme:-4fcaITc7BrGh5Rxxd2UqhWdXaGcoiDPV__zNpAJnDdKNREp0hXe4zTR24j674fXs
    ufhvbvUF1rb2n4ENrlrkMBNbRdiLA4VsZhrjswqbkXiZHng_-JsRkM>
X-ME-Received: <xmr:-4fcaAOKQdCGgHlP3KSRmSzk59XFzmw1JdI-Vxz_SMXHXgaqyvhhgjtDXUt_oi-4Kp0WNMQ7TGhn6Gdl4wUA-09paXIiDVvORHU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekudeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfvhhgr
    ihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepleeuheelheekgfeuvedtveetjeekhfffkeeffffftdfgjeevkeegfedvueehueel
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhthh
    grihhnsehlihhnuhigqdhmieekkhdrohhrghdpnhgspghrtghpthhtohepuddvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgvggvrhhtsehlihhnuhigqdhmieekkhdroh
    hrghdprhgtphhtthhopegrrhhnugesrghrnhgusgdruggvpdhrtghpthhtohepphgvthgv
    rhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdho
    rhhgpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpth
    htoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtohepmhgrrhhkrdhruhhtlhgr
    nhgusegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:-4fcaNXzFLXPMsoffO5UNH96XEuBZfG_jH0wsZTE05md2DXcipATvw>
    <xmx:-4fcaDhRSegPtpYPlHIKr-H2zjMSOazyMBZExbwbw1NAOrNrlz6E9g>
    <xmx:-4fcaGiEPZvd8K3lCO56Ie1NRJhkNmc37phyDGOp0VRU0KyA-WVYIA>
    <xmx:-4fcaBHb8DZSNMtVx5FPoR0XFJX8U2kveM9sKyuG_ZALS4ln7y9-MQ>
    <xmx:_IfcaOtqsxvs8kjB30QAbre5UUu5xEsEu7birnDPhqM4D0OXnYpBpZnh>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Sep 2025 21:46:32 -0400 (EDT)
Date: Wed, 1 Oct 2025 11:46:34 +1000 (AEST)
From: Finn Thain <fthain@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, 
    Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
    Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
    Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, 
    Linux-Arch <linux-arch@vger.kernel.org>, linux-m68k@vger.kernel.org, 
    Lance Yang <lance.yang@linux.dev>
Subject: Re: [RFC v2 2/3] atomic: Specify alignment for atomic_t and
 atomic64_t
In-Reply-To: <CAMuHMdV1eGkq_kOPTGbfDt4E2V5zCTdYc_BGJg-56-ZUS353YQ@mail.gmail.com>
Message-ID: <7c2c4da1-57f6-23b6-dbff-6288ef3f2a4f@linux-m68k.org>
References: <cover.1757810729.git.fthain@linux-m68k.org> <abf2bf114abfc171294895b63cd00af475350dba.1757810729.git.fthain@linux-m68k.org> <CAMuHMdUgkVYyUvc85_P9TyTM5f-=mC=+X=vtCWN45EMPqF7iMg@mail.gmail.com> <6c295a4e-4d18-a004-5db8-db2e57afc957@linux-m68k.org>
 <57ac401b-222b-4c85-b719-9e671a4617cf@app.fastmail.com> <86be5cf0-065e-d55d-fdb6-b9cf6655165e@linux-m68k.org> <ec2982e3-2996-918e-f406-32f67a0decfe@linux-m68k.org> <CAMuHMdV1eGkq_kOPTGbfDt4E2V5zCTdYc_BGJg-56-ZUS353YQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Tue, 30 Sep 2025, Geert Uytterhoeven wrote:

> > To silence the misalignment WARN from CONFIG_DEBUG_ATOMIC, for 64-bit 
> > atomic operations, for my small m68k .config, it was also necesary to 
> > increase ARCH_SLAB_MINALIGN to 8. However, I'm not advocating a
> 
> Probably ARCH_SLAB_MINALIGN should be 4 on m68k.  Somehow I thought that 
> was already the case, but it is __alignof__(unsigned long long) = 2.
> 

I agree -- setting ARCH_SLAB_MINALIGN to 4 would be better style, and may 
avoid surprises in future. Right now that won't have any effect because 
that value gets increased to sizeof(void *) by calculate_alignment() and 
gets increased to ARCH_KMALLOC_MINALIGN or ARCH_DMA_MINALIGN by 
__kmalloc_minalign().

> > ARCH_SLAB_MINALIGN increase, as that wastes memory. I think it might be
> > more useful to limit the alignment test for CONFIG_DEBUG_ATOMIC, as
> > follows.
> 
> Did you check what would be the actual impact of increasing it to 4 or 8?
> 
> > --- a/include/linux/instrumented.h
> > +++ b/include/linux/instrumented.h
> > @@ -68,7 +68,7 @@ static __always_inline void instrument_atomic_read(const volatile void *v, size_
> >  {
> >         kasan_check_read(v, size);
> >         kcsan_check_atomic_read(v, size);
> > -       WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (size - 1)));
> > +       WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (size - 1) & 3));
> 
> I'd make that an arch-overridable define instead of hardcoded 3.
> 

How about (sizeof(atomic_long_t) - 1)?

Can you comment on this, Peter?

