Return-Path: <linux-arch+bounces-13721-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C075EB948D5
	for <lists+linux-arch@lfdr.de>; Tue, 23 Sep 2025 08:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53E542E27BC
	for <lists+linux-arch@lfdr.de>; Tue, 23 Sep 2025 06:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBED30C363;
	Tue, 23 Sep 2025 06:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BJhjWQnG"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509881339B1;
	Tue, 23 Sep 2025 06:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758608927; cv=none; b=dCr8Co9cVYoTm1RzNa1znYLcDwtWC1PptbRUN0CdmIp8SpqAZIzD5EVXPWTU/UlorHhjTTTBuS7dGFAmgF46JnACX9qPVVl41a1UviRKKcYkQgvFsNSyhQUJ3RY/dbeXfb7PMvkG+6t15nMhFqF2rSqq0IspQQ7unaw0icRDgVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758608927; c=relaxed/simple;
	bh=NkP125ATTezUnhKgdUx8JE36LdcjUutSKbJNYs806jk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=a+PUSvrExrCo6nBmjqK8YYI88BKNQ0L0Q2UvJg+brfvfX1FQmW52bT4JmjZhCwyKFfg//NKZrz6crQi2zEBCnLYp7fvSEMBQctaqxgbDZ7MIUZa//TmLhnPMf8h8RR/ySUarGJ1UFOH1WcYQqQ6cA4lxkTqqEifT47ryozUVAVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BJhjWQnG; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 32E8AEC00BF;
	Tue, 23 Sep 2025 02:28:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 23 Sep 2025 02:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758608923; x=1758695323; bh=3NuQRXfs/lZoWU7jqTgyvHvDGlA/BMy0qPp
	aeoiVwNU=; b=BJhjWQnGJcJoEoIbwpzAyzc8P4ETp61dBe1bTXRS1K51zlBLH6x
	xt8+GEqJSfvAriAUQN8MVPkBI/v+rUBngjGavRnFvmZer2RdflmecnYwWAxmr7zA
	1u4BEnSXuxNeKnKvW5yCOm5qz5u+IFr1sB5e5Sv3WSIQ8rL32+dVr8A5XAAFfWiJ
	hhXyeLEaCA+YqLdPpb4N1rAeTl3/pYZlWITBIGAUs/8OFOENJNDUfWsMOgSF24o8
	UOsIxl/+w2nxu/1O6rqdaMsoOZ2XTAHbAYGxKN75LEQszvaq8Nc+fguiyZt4sGGU
	lbHWwtA1V6sWRNRPGE0qighzT7k6DzzhnUw==
X-ME-Sender: <xms:Gj7SaC1dbrtaTf-jFGjpp1h8XhFH8ZswRqNfXwR7jaY8oemiozsUSQ>
    <xme:Gj7SaNPrLgwG-09tAPZq9ik7IyWwqJWjKftfrPc8jQfoTkO3TOW-Nwsq5P4LdXI7e
    nQMtMr2_UmpHSmqR1XchghKU8s3sjEzL36vFB8XQBpgauLAWH6WNoo>
X-ME-Received: <xmr:Gj7SaKYI94Eoz7iaMaIe33w7XQSBXhnIyRyJYduVW8uKwtJJyH0GgsOGqgZEIHjW9xHATsIoVntRqOYVW2tRcWnrhriU-n2PoiU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfvhhgr
    ihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepueevvdegledvveehvddvkeeffefgvdeiieejvdejveffhefguefhheeftdetuddt
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrghinheslhhinhhugidqmheikehkrdho
    rhhgpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    eprghrnhgusegrrhhnuggsrdguvgdprhgtphhtthhopehgvggvrhhtsehlihhnuhigqdhm
    ieekkhdrohhrghdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrgh
    dprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghkphhm
    sehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegsohhquhhnrd
    hfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgv
    thdprhgtphhtthhopehmrghrkhdrrhhuthhlrghnugesrghrmhdrtghomhdprhgtphhtth
    hopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Gj7SaDxRZofyEPYb7BaSf729ZwwhjjBP9vom_vSwKoy3OBBBswMfpw>
    <xmx:Gj7SaBOgzPtLdbBobAI0V1u_fXaZSEOlLrf-CPzxQuSz1KN3__rYBQ>
    <xmx:Gj7SaKfZ4n7Yun0fZzrbxHvihbRpVUhrsy4dSpisMeCs_z9QZM8law>
    <xmx:Gj7SaOTAAOeC4slNSsXdghJS61SmkZFfxhnbeGZiY1j15HMI6kHuSw>
    <xmx:Gz7SaNpzccL9mUuih5g-lggqimr2lGBavrlYIlUdcz5DDU9DUa_ej5E0>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 02:28:39 -0400 (EDT)
Date: Tue, 23 Sep 2025 16:28:38 +1000 (AEST)
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
In-Reply-To: <57ac401b-222b-4c85-b719-9e671a4617cf@app.fastmail.com>
Message-ID: <86be5cf0-065e-d55d-fdb6-b9cf6655165e@linux-m68k.org>
References: <cover.1757810729.git.fthain@linux-m68k.org> <abf2bf114abfc171294895b63cd00af475350dba.1757810729.git.fthain@linux-m68k.org> <CAMuHMdUgkVYyUvc85_P9TyTM5f-=mC=+X=vtCWN45EMPqF7iMg@mail.gmail.com> <6c295a4e-4d18-a004-5db8-db2e57afc957@linux-m68k.org>
 <57ac401b-222b-4c85-b719-9e671a4617cf@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Mon, 22 Sep 2025, Arnd Bergmann wrote:

> On Mon, Sep 22, 2025, at 10:16, Finn Thain wrote:
> >
> > Yes, I noticed that also, after I started building with defconfigs.
> > I pushed a new patch to my github repo.
> >
> > https://github.com/fthain/linux/tree/atomic_t
> 
> I had a look at that repository, and I think the extra annotations you 
> added on a lot of structures have the same mistake that I made when 
> looking at annotating ABI structures for -malign-int earlier:
> 
> Adding __aligned__((sizeof(long))) to a structure definition only 
> changes the /outer/ alignment of the structure itself,

Right. I should have dropped those changes earlier.

@@ -8,7 +8,7 @@ struct vfsmount;
 struct path {
        struct vfsmount *mnt;
        struct dentry *dentry;
-} __randomize_layout;
+} __aligned(sizeof(long)) __randomize_layout;

There's no need: struct path contains a struct dentry, which contains a 
seqcount_spinlock_t, which contains a spinlock_t which contains an 
atomic_t member, which is explicitly aligned.

Despite that, there's still some kmem cache or other allocator somewhere 
that has produced some misaligned path and dentry structures. So we get 
misaligned atomics somewhere in the VFS and TTY layers. I was unable to 
find those allocations.

> so e.g.
> 
> struct {
>     short a;
>     int b;
> } __attribute__((aligned(sizeof(long))));
> 
> creates a structure with 4-byte alignment and 8-byte
> size when building with -mno-align-int, but the padding
> is added after 'b', which is still misaligned.
> 

Sure but -mno-align-int isn't particularly relevant here as it's only for 
m68k. Besides, I'd like to avoid the mess that would create.

The basic aim here is to naturally align both atomic_t and atomic64_t on 
all architectures (my testing is confined to m68k) and to try to find out 
what that would cost and what benefit it might bring.

The patches you're reviewing were a hack to try to silence the WARN from 
CONFIG_DEBUG_ATOMIC, because that way I could try to assess the 
cost/benefit.

