Return-Path: <linux-arch+bounces-13614-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38098B574FD
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 11:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22AEC7A48AF
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 09:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FA52F6186;
	Mon, 15 Sep 2025 09:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BYtfg+VH"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFDF2DF130;
	Mon, 15 Sep 2025 09:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757929149; cv=none; b=EfllLxfqYx2NXUsgblAHFL+QAHaEESZrt9MBQE0KZZzD+tN+FqLTmAxGMmQ2a/maX2dncKmyhG0P5BoZZAFONevCeV5NngdRBm1qadSLPzT038shQs28LXEGJ0+HWLr+jeI3DMGeS3agTKvytxuvKuks8E8aYirZJ9g4nC1nHbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757929149; c=relaxed/simple;
	bh=BQwYGcHNBQ1BmDRJXt1DNc713xmDY9Wj4ssgjhnfXTM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=l2CxtqWIgHhMnoxLBebKq5sBH/U9ZzA5Kl8PoYNNXI5BUW7E3VZODqHN+dl0BGOISkFQg/ZZRHbxTRqaisdRivzd5eeCNHFHOEo03QpsROhU7QwCzRC2VHLLEMt9zTDxgEcm+o4jtWVNRumN8zq6NA8FN0c0TFYxJrRwcCrWZbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BYtfg+VH; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 97A431400077;
	Mon, 15 Sep 2025 05:39:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 15 Sep 2025 05:39:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757929146; x=1758015546; bh=Xzv4ncO1zU/K/YeH9PySzOP75hWc1nUY8kb
	bOKbt8uI=; b=BYtfg+VHE6Uf8gELuzDCpwraF6ozymRKarHo1V+MmmEF3W7U7sH
	zifUToFNusTsPr5+amdvCkdOHBYgJKEr4+f79p/dvt4sIesdIcMcgUIXZfvxVZXA
	BqMfDnbRbzLXpRjghj1xP0CRrNHg+A9ZLg2lgpsILRBR3woQ6bNA0RIhcn2a2iZT
	sk71jPDLLF0xRsRN7C1GWl/LRfqxsepJji1rpDkNZYGJs7WIG1L5GPNfKsDfutgD
	Fn+AUZ7jomxa99YTYmOdUPKLraX7SVjJto7jMN2PPd1/j2j1QKTRQ+C9k8aO+jUY
	RhLKA8OoHNqJCVDtof75Zx/sdB1p+mSz4gg==
X-ME-Sender: <xms:ut7HaMuwLBtL9YLIoNNOYhiskPYrlbRtY8arZnFN1S8Sx1CVAkt8DA>
    <xme:ut7HaFQTM3seokj0F0GQddsvqRSbUnZKgIborlM3DCWd6exejhdBA4pml3ZHX70N4
    FHXLg-O2lPx4k6jJH8>
X-ME-Received: <xmr:ut7HaDLs3cn55SEYg8EtvJR4YwmM8aKbsBI5GRimS9GqYfPzewv0GFTxt-vXN1ixH9bz4CymBmMkaJ3C4BuTt3420c3937JhNEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfvhhgr
    ihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepfeeiheejvdetgfeitddutefhkeeilefhveehgfdvtdekkedvkeehffdtkeevvdeu
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrghinheslhhinhhugidqmheikehkrdho
    rhhgpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepfihilhhlsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrth
    hiohhnrdhorhhgpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhm
    pdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtohepmhgrrhhkrd
    hruhhtlhgrnhgusegrrhhmrdgtohhmpdhrtghpthhtoheprghrnhgusegrrhhnuggsrdgu
    vgdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:ut7HaIu6eKLXy6ReEiy2bkuso1aKu0q_4zf33-82EGXTdEvaLmKGEQ>
    <xmx:ut7HaK_lrm0kexEbJOwpuSaFSIcIEWsOxYjAG_NmHIzXyZ3zfTEzLA>
    <xmx:ut7HaC3XJYD_dAWESZ1ArJZpxfxRGf4bKWu7VnHASxcfRqPGHbidYg>
    <xmx:ut7HaPgZhLyvzRmV1j5T253EDgs4mBYIMT1kFPvHR44Nbcwp-LOXRA>
    <xmx:ut7HaDrOcj7fegOd3YenYqroNOLS3JW2RlKxY43cN-6Z2X5x7vLJdNG7>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 05:39:03 -0400 (EDT)
Date: Mon, 15 Sep 2025 19:38:52 +1000 (AEST)
From: Finn Thain <fthain@linux-m68k.org>
To: Peter Zijlstra <peterz@infradead.org>
cc: Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
    Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
    Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
    linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
    Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org
Subject: Re: [RFC v2 3/3] atomic: Add alignment check to instrumented atomic
 operations
In-Reply-To: <20250915080054.GS3419281@noisy.programming.kicks-ass.net>
Message-ID: <4b687706-a8f1-5f51-6e64-6eb09ae3eb5b@linux-m68k.org>
References: <cover.1757810729.git.fthain@linux-m68k.org> <e5a38b0ccf2d37185964a69b6e8657c992966ff7.1757810729.git.fthain@linux-m68k.org> <20250915080054.GS3419281@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Mon, 15 Sep 2025, Peter Zijlstra wrote:

> On Sun, Sep 14, 2025 at 10:45:29AM +1000, Finn Thain wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> > 
> > Add a Kconfig option for debug builds which logs a warning when an
> > instrumented atomic operation takes place at some location that isn't
> > a long word boundary. Some platforms don't trap for this.
> > 
> > Link: https://lore.kernel.org/lkml/20250901093600.GF4067720@noisy.programming.kicks-ass.net/
> > ---
> > This patch differs slightly from Peter's code which checked for natural
> > alignment.
> > ---
> >  include/linux/instrumented.h |  4 ++++
> >  lib/Kconfig.debug            | 10 ++++++++++
> >  2 files changed, 14 insertions(+)
> > 
> > diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
> > index 711a1f0d1a73..55f5685971a1 100644
> > --- a/include/linux/instrumented.h
> > +++ b/include/linux/instrumented.h
> > @@ -7,6 +7,7 @@
> >  #ifndef _LINUX_INSTRUMENTED_H
> >  #define _LINUX_INSTRUMENTED_H
> >  
> > +#include <linux/bug.h>
> >  #include <linux/compiler.h>
> >  #include <linux/kasan-checks.h>
> >  #include <linux/kcsan-checks.h>
> > @@ -67,6 +68,7 @@ static __always_inline void instrument_atomic_read(const volatile void *v, size_
> >  {
> >  	kasan_check_read(v, size);
> >  	kcsan_check_atomic_read(v, size);
> > +	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (sizeof(long) - 1)));
> >  }
> >  
> >  /**
> > @@ -81,6 +83,7 @@ static __always_inline void instrument_atomic_write(const volatile void *v, size
> >  {
> >  	kasan_check_write(v, size);
> >  	kcsan_check_atomic_write(v, size);
> > +	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (sizeof(long) - 1)));
> >  }
> >  
> >  /**
> > @@ -95,6 +98,7 @@ static __always_inline void instrument_atomic_read_write(const volatile void *v,
> >  {
> >  	kasan_check_write(v, size);
> >  	kcsan_check_atomic_read_write(v, size);
> > +	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (sizeof(long) - 1)));
> >  }
> 
> Right, so why aren't we trusting the size argument? And instead
> mandating a possibly larger alignment?
> 

It wasn't supposed to mandate a larger alignment in practice. I considered 
doing something like (unsigned long)v & (size - 1) & (sizeof(long) - 1) 
but decided that the extra overhead probably wouldn't be worthwhile, if in 
practice, no-one is doing atomic ops on shorts or chars. I will revisit 
this.

When you do atomic operations on atomic_t or atomic64_t, (sizeof(long)
- 1) probably doesn't make much sense. But atomic operations get used on 
scalar types (aside from atomic_t and atomic64_t) that don't have natural 
alignment. Please refer to the other thread about this: 
https://lore.kernel.org/all/ed1e0896-fd85-5101-e136-e4a5a37ca5ff@linux-m68k.org/

