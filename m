Return-Path: <linux-arch+bounces-13616-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C07B9B576AF
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 12:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1FCD200D97
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 10:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88ECA2FE590;
	Mon, 15 Sep 2025 10:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SCP1d7Dl"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C974E2FE56F;
	Mon, 15 Sep 2025 10:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757932667; cv=none; b=UnXD3EdW3mmvDtGgaN2VjUZ4XjW66FhyYqaDGhlmmpGXBrtiabe9pGH2rIiQ0753VGCRqdDOqBHy2Z463jhjw37eS32g5ykLidCNQtnDsnhjri73aWTL75zcqHq1UiKqND1K1O6IXGHgq+Ak1Y+/pU/gfUdEKpNqfeRWiHWv8cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757932667; c=relaxed/simple;
	bh=KedPFyvTS9CkoIRXAH7XdeX5q7bM89mAHx8MYznoCa4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=T7QxMf1iH6wNHNQgkPO6y5Yj5q2v1ubPtgxUW7PkwvHkrVcOC5KUxExQXOeFn+GggyHRxNhLpV5v/VRd2Hn470RXX6AHwObGBL3wu+kv/8D7zxs1Y+1u93pHsByfwYhJkQ8uszGllNzs4VmG2pQugo4b4r342dl7gYUDc5O5YSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SCP1d7Dl; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id AA0F4EC01FA;
	Mon, 15 Sep 2025 06:37:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 15 Sep 2025 06:37:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757932663; x=1758019063; bh=S3tkyveM8KAf6AU1pjfVZqhckIwKnWLO+1I
	U/3AsN/M=; b=SCP1d7Dl/xOAG/sAR/0ofNgoAwG2s4O6y8jk9H3/FzM39/wpQ8R
	nRGbn3uRLuHYTdwH1h0oBbNgl9BcAMO5HjNSycypodbYpUzrEkNknSYNQmeE4UGH
	OVPn5/fvhDUVvP4EORf/XfNn2YpxW9L7TPTkakUiM6UQ+G99S5GKriRC6bJwEGCh
	EXsEmiiEkTnwRk8RHKYtiVxMA1fD1q5jyqBOaATfRu/FVitHynBzpYpgDhh9iwOb
	zpJvT6ibimjwSYDTT9z3vvCUZJNvZnl03o0Z7e+EyDsKD8mu8hUVf9oB0nkE4o1W
	hTNoVtWwS4gPDMT79O5hLOJKMTWLV4c3R1Q==
X-ME-Sender: <xms:duzHaBKeXKRSaqvXzswr3pjowu3x3kw5PYsQKYQei9KrCyv70ZDiuw>
    <xme:duzHaMWU1lXyJLdLYNYXcV-4NyM4NYH3dBOsYurxujj-72fuEGxreHKb7RBQd3BUr
    xt6fKpZMvHCkGO6mvg>
X-ME-Received: <xmr:duzHaMbA0w4KNlQOFGC1hKmvcoC8ixo51WKbLNwnMyiHO-sZ-qIVd7b7nb35v2qgQ0vD53Lrl0x2UzWo2LHcpKdTUBGNcCzhO_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeegjecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:d-zHaLwxNMLQIdUVqU6nfjI5ynam_kWzVG5uPALNrcuXlo9O16kKmw>
    <xmx:d-zHaE1S5qhO5m7TAI0Fu9DSBpcrzvZv4e10dXVXoX1LX3qXl3gYTg>
    <xmx:d-zHaEnPiMN8rIHlCXzO3l-U9mHCUXLIU-WJLeUqPE1gy0UJzcY9Tw>
    <xmx:d-zHaL-pxruKADvgL7oCtZhffBbL1O7S8tMH3V0qL__XyRtc0D1KTg>
    <xmx:d-zHaBMm-mRTYs-D--hsVAJpYdRnGJ2nlEwCvLHcE9DZDzBKJPyfctqm>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 06:37:39 -0400 (EDT)
Date: Mon, 15 Sep 2025 20:37:34 +1000 (AEST)
From: Finn Thain <fthain@linux-m68k.org>
To: Peter Zijlstra <peterz@infradead.org>
cc: Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
    Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
    Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
    linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
    Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org
Subject: Re: [RFC v2 3/3] atomic: Add alignment check to instrumented atomic
 operations
In-Reply-To: <20250915100604.GZ3245006@noisy.programming.kicks-ass.net>
Message-ID: <8247e3bd-13c2-e28c-87d8-5fd1bfed7104@linux-m68k.org>
References: <cover.1757810729.git.fthain@linux-m68k.org> <e5a38b0ccf2d37185964a69b6e8657c992966ff7.1757810729.git.fthain@linux-m68k.org> <20250915080054.GS3419281@noisy.programming.kicks-ass.net> <4b687706-a8f1-5f51-6e64-6eb09ae3eb5b@linux-m68k.org>
 <20250915100604.GZ3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Mon, 15 Sep 2025, Peter Zijlstra wrote:

> On Mon, Sep 15, 2025 at 07:38:52PM +1000, Finn Thain wrote:
> > 
> > On Mon, 15 Sep 2025, Peter Zijlstra wrote:
> > 
> > > On Sun, Sep 14, 2025 at 10:45:29AM +1000, Finn Thain wrote:
> > > > From: Peter Zijlstra <peterz@infradead.org>
> > > > 
> > > > Add a Kconfig option for debug builds which logs a warning when an
> > > > instrumented atomic operation takes place at some location that isn't
> > > > a long word boundary. Some platforms don't trap for this.
> > > > 
> > > > Link: https://lore.kernel.org/lkml/20250901093600.GF4067720@noisy.programming.kicks-ass.net/
> > > > ---
> > > > This patch differs slightly from Peter's code which checked for natural
> > > > alignment.
> > > > ---
> > > >  include/linux/instrumented.h |  4 ++++
> > > >  lib/Kconfig.debug            | 10 ++++++++++
> > > >  2 files changed, 14 insertions(+)
> > > > 
> > > > diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
> > > > index 711a1f0d1a73..55f5685971a1 100644
> > > > --- a/include/linux/instrumented.h
> > > > +++ b/include/linux/instrumented.h
> > > > @@ -7,6 +7,7 @@
> > > >  #ifndef _LINUX_INSTRUMENTED_H
> > > >  #define _LINUX_INSTRUMENTED_H
> > > >  
> > > > +#include <linux/bug.h>
> > > >  #include <linux/compiler.h>
> > > >  #include <linux/kasan-checks.h>
> > > >  #include <linux/kcsan-checks.h>
> > > > @@ -67,6 +68,7 @@ static __always_inline void instrument_atomic_read(const volatile void *v, size_
> > > >  {
> > > >  	kasan_check_read(v, size);
> > > >  	kcsan_check_atomic_read(v, size);
> > > > +	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (sizeof(long) - 1)));
> > > >  }
> > > >  
> > > >  /**
> > > > @@ -81,6 +83,7 @@ static __always_inline void instrument_atomic_write(const volatile void *v, size
> > > >  {
> > > >  	kasan_check_write(v, size);
> > > >  	kcsan_check_atomic_write(v, size);
> > > > +	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (sizeof(long) - 1)));
> > > >  }
> > > >  
> > > >  /**
> > > > @@ -95,6 +98,7 @@ static __always_inline void instrument_atomic_read_write(const volatile void *v,
> > > >  {
> > > >  	kasan_check_write(v, size);
> > > >  	kcsan_check_atomic_read_write(v, size);
> > > > +	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (sizeof(long) - 1)));
> > > >  }
> > > 
> > > Right, so why aren't we trusting the size argument? And instead
> > > mandating a possibly larger alignment?
> > > 
> > 
> > It wasn't supposed to mandate a larger alignment in practice. I considered 
> > doing something like (unsigned long)v & (size - 1) & (sizeof(long) - 1) 
> > but decided that the extra overhead probably wouldn't be worthwhile, if in 
> > practice, no-one is doing atomic ops on shorts or chars. I will revisit 
> > this.
> 
> atomic_t is aligned at 4 bytes, you're now mandating it is aligned at 8
> bytes (on LP64), this cannot be right.
> 
> kernel/locking/qspinlock.c:xchg_tail() does xchg_relaxed(&lock->tail,
> ...) which is u16. Again, you cannot mandate 8 bytes here.
> 

OK. I will change it back to your code (i.e. mandate natural alignment).

> > When you do atomic operations on atomic_t or atomic64_t, (sizeof(long)
> > - 1) probably doesn't make much sense. But atomic operations get used on 
> > scalar types (aside from atomic_t and atomic64_t) that don't have natural 
> > alignment. Please refer to the other thread about this: 
> > https://lore.kernel.org/all/ed1e0896-fd85-5101-e136-e4a5a37ca5ff@linux-m68k.org/
> 
> Perhaps set ARCH_SLAB_MINALIGN ?
> 

That's not going to help much. The 850 byte offset of task_works into 
struct task_struct and the 418 byte offset of exit_state in struct 
task_struct are already misaligned.

But that's all moot, if you intended that CONFIG_DEBUG_ATOMIC should 
complain about any deviation from natural alignment. I still don't have 
any performance measurements but I'm willing to assume there's a penalty 
for such deviation.

