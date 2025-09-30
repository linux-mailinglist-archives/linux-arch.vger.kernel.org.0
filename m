Return-Path: <linux-arch+bounces-13803-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0643EBAAF94
	for <lists+linux-arch@lfdr.de>; Tue, 30 Sep 2025 04:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 568B7189DA08
	for <lists+linux-arch@lfdr.de>; Tue, 30 Sep 2025 02:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0027F219A8D;
	Tue, 30 Sep 2025 02:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rcdMVqr2"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACE41D90DD;
	Tue, 30 Sep 2025 02:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759198710; cv=none; b=Bb983A4IjQr3gk1rA7ErniU7hE2zAx7bWUi+pj+7BL57RkRHcnLqGY1i1pQHmYMRFDCV1rVZipT0+WDFqBO4mnSP2yDIxBstXS5q55cHbp77HgCljLRu1whidKECsIWlzHmEfobdyCbI+vK6Oi3zLxD8CYytotkLrUki9s3Yc7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759198710; c=relaxed/simple;
	bh=zwmI4fi1gUlKKuIqdfNOTlqHa1rvM+fktGwKmYh2zRA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oGCYpr3Zp53VXf6U8L9FyQR7JLsZ62RNudEQFPkkRHvI61NWzEiZXnlD+WYDXEM0jOgt+8NO2p49AcBnGMjGGqIYoRUPZp+Z98mF8791ugOcrg/qiSULKSfWI5IsSSk3509eTs1zQyvHqM2P5FQXhUviWNAp7gMh7KXH7wMvv5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rcdMVqr2; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 77C851D0009F;
	Mon, 29 Sep 2025 22:18:26 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 29 Sep 2025 22:18:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759198706; x=1759285106; bh=j5IHdNjhYZKz/YGLkmQrITb2jP7tOnqjnYw
	EbmqU8g4=; b=rcdMVqr2pmErDpuubXeYNaUOzdqbXfzDA2pxKgweiBUGGJvFejR
	qru9kwV53qT47G+8XmPG514yGBz8bdlOjbBwVXTQ9uc+lWcT7cXJD6NSkF2VtzPs
	wLammHa5gC23/KQp1wwJWWDy/W3SC4PDbA5gU/oIwa6ojqDDyMTmGgJg3LsqPCZM
	0nmx/ZXO9DRMM+FXONvnB0U284dG/VPjBcVsbdOkZTH+87rYLi1rL4GDkeN37e4G
	bCSCnF3g/aE0WEeimyiS4Wo4F8Zmb2CtH4wevqjjgpvmyWZJe7IVMR8FAzZo5DL6
	M8cg/T4oW3I2DHN/EbYNyDmNzc4K8rjzwTA==
X-ME-Sender: <xms:8D3baEXngSJ8Bj_McMpel1A2uHV6BLCjR34It1LkSml_jTOO987mng>
    <xme:8D3baAtIspvXaB02GU6Y314vhb2_erg2cTIlZPi0qEVoum5nYQD9kMAS51NAZ2fuM
    DyQNLMH7G1yO8fgoXGwF_noivn-yJxIzBbcYmfGuyauICA6-oRnPlI>
X-ME-Received: <xmr:8D3baH6cXzVEZSAjiklZC1mdpUVERfud56QLRlm3Q1fMt4A9Ps6_TD2Tnp6tpLbuMcgbqAdd0PtIHMlwwMjaJkBpnbDD6Kq0M1c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejleeiiecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:8D3baDRU4XpRsXkNwWEg1kUHRauXJTg9Yd1BgMae7NtuWeslv88y2w>
    <xmx:8D3baKuzd_gj-q5s-27IXj9jT392NsiSNXQxQ-YHiy9gyCCtzyMw-g>
    <xmx:8D3baF_BdKeWoA_3gxYc93V5_caHBnVmvP7vepEogrRCy1rzzpkFXQ>
    <xmx:8D3baDy673D4S580cSjV4tiDCHqRRWZ6E1E_hk4XQE9tVHJNJPcSZw>
    <xmx:8j3baBJFsPQl4_-2VESjoUfhPp5do53Grecm9v68XGE4ejHuEXMhJWnO>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Sep 2025 22:18:23 -0400 (EDT)
Date: Tue, 30 Sep 2025 12:18:21 +1000 (AEST)
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
In-Reply-To: <86be5cf0-065e-d55d-fdb6-b9cf6655165e@linux-m68k.org>
Message-ID: <ec2982e3-2996-918e-f406-32f67a0decfe@linux-m68k.org>
References: <cover.1757810729.git.fthain@linux-m68k.org> <abf2bf114abfc171294895b63cd00af475350dba.1757810729.git.fthain@linux-m68k.org> <CAMuHMdUgkVYyUvc85_P9TyTM5f-=mC=+X=vtCWN45EMPqF7iMg@mail.gmail.com> <6c295a4e-4d18-a004-5db8-db2e57afc957@linux-m68k.org>
 <57ac401b-222b-4c85-b719-9e671a4617cf@app.fastmail.com> <86be5cf0-065e-d55d-fdb6-b9cf6655165e@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Tue, 23 Sep 2025, I wrote:

> 
> ... there's still some kmem cache or other allocator somewhere that has 
> produced some misaligned path and dentry structures. So we get 
> misaligned atomics somewhere in the VFS and TTY layers. I was unable to 
> find those allocations.
> 

It turned out that the problem wasn't dynamic allocations, it was a local 
variable in the core locking code (kernel/locking/rwsem.c): a misaligned 
long used with an atomic operation (cmpxchg). To get natural alignment for 
64-bit quantities, I had to align other local variables as well, such as 
the one in ktime_get_real_ts64_mg() that's used with 
atomic64_try_cmpxchg(). The atomic_t branch in my github repo has the 
patches I wrote for that.

To silence the misalignment WARN from CONFIG_DEBUG_ATOMIC, for 64-bit 
atomic operations, for my small m68k .config, it was also necesary to 
increase ARCH_SLAB_MINALIGN to 8. However, I'm not advocating a 
ARCH_SLAB_MINALIGN increase, as that wastes memory. I think it might be 
more useful to limit the alignment test for CONFIG_DEBUG_ATOMIC, as 
follows.


diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
index 402a999a0d6b..cd569a87c0a8 100644
--- a/include/linux/instrumented.h
+++ b/include/linux/instrumented.h
@@ -68,7 +68,7 @@ static __always_inline void instrument_atomic_read(const volatile void *v, size_
 {
 	kasan_check_read(v, size);
 	kcsan_check_atomic_read(v, size);
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (size - 1)));
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (size - 1) & 3));
 }
 
 /**
@@ -83,7 +83,7 @@ static __always_inline void instrument_atomic_write(const volatile void *v, size
 {
 	kasan_check_write(v, size);
 	kcsan_check_atomic_write(v, size);
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (size - 1)));
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (size - 1) & 3));
 }
 
 /**
@@ -98,7 +98,7 @@ static __always_inline void instrument_atomic_read_write(const volatile void *v,
 {
 	kasan_check_write(v, size);
 	kcsan_check_atomic_read_write(v, size);
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (size - 1)));
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (size - 1) & 3));
 }
 
 /**

