Return-Path: <linux-arch+bounces-13817-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E541BAEEB4
	for <lists+linux-arch@lfdr.de>; Wed, 01 Oct 2025 03:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A792189F2F5
	for <lists+linux-arch@lfdr.de>; Wed,  1 Oct 2025 01:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A5972626;
	Wed,  1 Oct 2025 01:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gOIT35jJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC832556E;
	Wed,  1 Oct 2025 01:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759280606; cv=none; b=J1M9ErU1reeDJYncnLUiuSPE0+fIg24If4TQRIADn9JwGkUE2pqTfb8Eio5rI6XESv3LYUhVx5UQFglRAWR8DHM0tMVZvrQACu0opXIMrVTgIzPILVoixJ5+Ped3XOcXkFOnMFbMVb/ck0p+2KND3yronsMK4L2tOCPJZED0/vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759280606; c=relaxed/simple;
	bh=NvRw842uN22jxnvSyEp39EnvRN2HqvRlGd6W1aQfD9A=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=l1SR6woeRMBfiv7QbIkdtGmexu8zWMgPThFqqxvUx8s008AO2i/u7Bn21RNXVA7Ue+0oEBLHUce9FwXP1Qbw/BhRNyZLyZGUGtJXKR5fmGG94tXltaSi2miCU91fUI5zC2PM1lWg2XUF8cEe9qJUv1eIp6BjOgB6ZISZgOqbk3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gOIT35jJ; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 05FB514000B5;
	Tue, 30 Sep 2025 21:03:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 30 Sep 2025 21:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759280602; x=1759367002; bh=NuCyfF8qzbXchBGONiYIuvd6quu2IunfxbV
	es7Qlwco=; b=gOIT35jJfBLTfx6piT/NT0dedZTnIto88G7+K3lIvdGweqowxxg
	OF5CblCd1ZxLeju7fMY6U0MLZGojLGwmc9l1wRKGqn5O6A8tFrmTPtpxAtRW1A93
	FKhsaJUgw4S07qZ3ttY9cM8hudfB8T6/94jMbKOnxsH0H6BAxGNB8Am4tyl+Ii6H
	DihXePjdtL7jd6f05lLsXQCdSHnp6aAyKt/zu+mGYzy4sYt/Ne5oCXE8KWwKDJty
	MI/eiIWrgLzoEhstNJduoHJpXGJdLtwtyOKbLOQjQIS59UOwvTxAKJRceilWsDe8
	gfIt3egtpYbqnkSuxWT4o0Bz4FG91Ot1XEg==
X-ME-Sender: <xms:2X3caJJ1v1K3o6XppVsZnC_jdrmF-gsNWw9ItHrnQYV-Tlrwo3khog>
    <xme:2X3caNQMvWi0ct2oYKBBb3Bl4wX2UDhEL78FKkUIN8bqLuIqxna3X3YmFvA07ACbK
    8VcAiYjipPWGg4Uyl1e3X2_7AfaOvSbE8a1jmbRGpLinjztZnp9n-c>
X-ME-Received: <xmr:2X3caBP8DedZqNpr_YH4y4ut-h_pOX09uDSLzKYHLKDKU78eAbZ-mGBMdhHgM9PknEtaDEYq8D94jJOw7H_VWis84l2-08vWM0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekudekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfvhhgr
    ihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepteeukefggfduiedtkeeihfffieehkeffffevffegieetgfetgeejieegledtheek
    necuffhomhgrihhnpehgohgusgholhhtrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepfhhthhgrihhnsehlihhnuhigqdhmieekkhdr
    ohhrghdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopegrrhhnugesrghrnhgusgdruggvpdhrtghpthhtohepghgvvghrtheslhhinhhugidq
    mheikehkrdhorhhgpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorh
    hgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrkhhp
    mheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepsghoqhhunh
    drfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhn
    vghtpdhrtghpthhtohepmhgrrhhkrdhruhhtlhgrnhgusegrrhhmrdgtohhmpdhrtghpth
    htoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:2X3caKXkWx8PpQVU69_ZgLuobm9KTNUb3hCz_DDMEoLLATeTudaokA>
    <xmx:2X3caMi5mESBJTxWU8ffJJSm5qkMAw1DNF4VszZQOj0drPtnXZZZow>
    <xmx:2X3caLhpvoXgeCnUGtR3pdd1MeTjJWKte_oebKKH_VoH6OXxQ0GdtA>
    <xmx:2X3caCFemKMywKTcjR9mcL3lKN7EGGbagQtRord8EmnnN00tVCBjKA>
    <xmx:2X3caDv5hnGZnCvziBa3UgO0dOFy5Us0mJ45q0MSrySdmKsLGxpQr8Iq>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Sep 2025 21:03:17 -0400 (EDT)
Date: Wed, 1 Oct 2025 11:03:16 +1000 (AEST)
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
In-Reply-To: <e02f861b-706c-4f6d-bded-002601da954a@app.fastmail.com>
Message-ID: <60325e45-e4a7-d0cf-ba28-a1a811f9a890@linux-m68k.org>
References: <cover.1757810729.git.fthain@linux-m68k.org> <abf2bf114abfc171294895b63cd00af475350dba.1757810729.git.fthain@linux-m68k.org> <CAMuHMdUgkVYyUvc85_P9TyTM5f-=mC=+X=vtCWN45EMPqF7iMg@mail.gmail.com> <6c295a4e-4d18-a004-5db8-db2e57afc957@linux-m68k.org>
 <57ac401b-222b-4c85-b719-9e671a4617cf@app.fastmail.com> <86be5cf0-065e-d55d-fdb6-b9cf6655165e@linux-m68k.org> <ec2982e3-2996-918e-f406-32f67a0decfe@linux-m68k.org> <e02f861b-706c-4f6d-bded-002601da954a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Tue, 30 Sep 2025, Arnd Bergmann wrote:

> On Tue, Sep 30, 2025, at 04:18, Finn Thain wrote:
> >
> > It turned out that the problem wasn't dynamic allocations, it was a 
> > local variable in the core locking code (kernel/locking/rwsem.c): a 
> > misaligned long used with an atomic operation (cmpxchg). To get 
> > natural alignment for 64-bit quantities, I had to align other local 
> > variables as well, such as the one in ktime_get_real_ts64_mg() that's 
> > used with atomic64_try_cmpxchg(). The atomic_t branch in my github 
> > repo has the patches I wrote for that.
> 
> It looks like the variable you get the warning for is not even the 
> atomic64_t but the 'old' argument to atomic64_try_cmpxchg(), at least in 
> some of the cases you found if not all of them.
> 
> I don't see where why there is a requirement to have that aligned at 
> all, even if we do require the atomic64_t to be naturally aligned, and I 
> would expect the same warning to hit on x86-32 and the other 
> architectures with 4-byte alignment of u64 variable on stack and .data.
> 

Right -- there's only one memory operand in a CAS instruction on m68k, and 
there's only one pointer in the C implementation in asm-generic.

> > To silence the misalignment WARN from CONFIG_DEBUG_ATOMIC, for 64-bit 
> > atomic operations, for my small m68k .config, it was also necesary to 
> > increase ARCH_SLAB_MINALIGN to 8. However, I'm not advocating a 
> > ARCH_SLAB_MINALIGN increase, as that wastes memory.
> 
> Have you tried to quantify the memory waste here?

I think it's entirely workload dependent. The memory efficiency question 
comes down to the misalignment distance as a proportion of the size of the 
allocation.

> I assume that most slab allocations are already 8-byte aligned, at least 
> kmalloc() with size>4, while custom caches are usually done for larger 
> structures where an extra average of 2 bytes per allocation may not be 
> that bad.
> 
> > diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
> > index 402a999a0d6b..cd569a87c0a8 100644
> > --- a/include/linux/instrumented.h
> > +++ b/include/linux/instrumented.h
> > @@ -68,7 +68,7 @@ static __always_inline void 
> > instrument_atomic_read(const volatile void *v, size_
> >  {
> >  	kasan_check_read(v, size);
> >  	kcsan_check_atomic_read(v, size);
> > -	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & 
> > (size - 1)));
> > +	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & 
> > (size - 1) & 3));
> >  }
> 
> What is the alignment of stack variables on m68k? E.g. if you have a 
> function with two local variables, would that still be able to trigger 
> the check?
> 
> int f(atomic64_t *a)
> {
>      u16 pad;
>      u64 old;
>      
>      g(&pad);
>      atomic64_try_cmpxchg(a, &old, 0);
> }
> 

I assume so:

int foo(void) {
    short s;
    long long ll;
    return alignof(ll);
}

# Compilation provided by Compiler Explorer at https://godbolt.org/
foo():
        link.w %fp,#0
        moveq #2,%d0
        unlk %fp
        rts

> Since there is nothing telling the compiler that the 'old' argument to 
> atomic*_try_cmpcxchg() needs to be naturally aligned, maybe that check 
> should be changed to only test for the ABI-guaranteed alignment? I think 
> that would still be needed on x86-32.
>  

I don't know why we would check the alignment of the 'old' quantity. It's 
going to be loaded into a register before being used, right?

