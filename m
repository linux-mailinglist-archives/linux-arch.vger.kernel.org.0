Return-Path: <linux-arch+bounces-13615-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02626B5757D
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 12:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 623021AA0418
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 10:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C18A2F90C5;
	Mon, 15 Sep 2025 10:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jq14LWgC"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A958221DA5;
	Mon, 15 Sep 2025 10:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757930774; cv=none; b=u/t1rOIQFmTwtEeVYtsGTJ4ZIvtix44tjCVUNbu/CcRDpxk2zeAXhriWlX263H7nJTvVHFiYQM0IsoAxw+oFyAp8Lj0BFmuhW2nBFz0rSDxVJCusWx7lKl71rf/ptiW6qVLz+odj/oimcj3prJnYDa58oSfIsUr9QXey40j5Ttg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757930774; c=relaxed/simple;
	bh=GvdVNftmJ4BLsmRTY+O4IdSScT4A5MItclZk4Rky85I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNzudbNtfRAnsGBZnHASuIdiYaVmz8Zxh0aFQQHXa5YGW6gCZ7o56/PBMeCsd85EXADV8VsMO0jFTMozeAtbgzJwy0LW3FTuOBft40ZgF8uWtMNA6Kpog8bVs94dsUPf4UrCNJ7TiFd6RryjwzS6aPzgKaogEnpwkMteoLCdubc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jq14LWgC; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mf/tFV46HWfDni09P3y3GXXAMD+xCRlLP1MgaKMxEA4=; b=jq14LWgCXg3rYJiE+C3g1DF47y
	tuAXag/3QK7TpHUzxyKyvqDVKKrLb9YEec+wUU5oogxTzp4odZplpTuEUrTHQ8L3MZ+sX2w9SfSDw
	wzCQ8VK7QvSWVegCcNL+zd7+nlXhcZ3yeGyFsQ86wgtUcXXxASAeVkQM9V021MX0Yx02jDFx4lr46
	pwvJv/89kAxTWJscTvbyBppt6GyVKhZzklpD7nUsPvH6CDLBJjDxsq8eprQ+rENsvDdJpiPtBBqxp
	E+i4A6hXa3tnUVNim+Y1yjYzb0J87iIP+CGtJnWpuoGp1Rs2vtYduKc9I5PdIDhhy7uNwqoD4UAXk
	ayxQgR5A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy661-00000006ugF-2nOT;
	Mon, 15 Sep 2025 10:06:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 84A3F300212; Mon, 15 Sep 2025 12:06:04 +0200 (CEST)
Date: Mon, 15 Sep 2025 12:06:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Finn Thain <fthain@linux-m68k.org>
Cc: Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@vger.kernel.org
Subject: Re: [RFC v2 3/3] atomic: Add alignment check to instrumented atomic
 operations
Message-ID: <20250915100604.GZ3245006@noisy.programming.kicks-ass.net>
References: <cover.1757810729.git.fthain@linux-m68k.org>
 <e5a38b0ccf2d37185964a69b6e8657c992966ff7.1757810729.git.fthain@linux-m68k.org>
 <20250915080054.GS3419281@noisy.programming.kicks-ass.net>
 <4b687706-a8f1-5f51-6e64-6eb09ae3eb5b@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b687706-a8f1-5f51-6e64-6eb09ae3eb5b@linux-m68k.org>

On Mon, Sep 15, 2025 at 07:38:52PM +1000, Finn Thain wrote:
> 
> On Mon, 15 Sep 2025, Peter Zijlstra wrote:
> 
> > On Sun, Sep 14, 2025 at 10:45:29AM +1000, Finn Thain wrote:
> > > From: Peter Zijlstra <peterz@infradead.org>
> > > 
> > > Add a Kconfig option for debug builds which logs a warning when an
> > > instrumented atomic operation takes place at some location that isn't
> > > a long word boundary. Some platforms don't trap for this.
> > > 
> > > Link: https://lore.kernel.org/lkml/20250901093600.GF4067720@noisy.programming.kicks-ass.net/
> > > ---
> > > This patch differs slightly from Peter's code which checked for natural
> > > alignment.
> > > ---
> > >  include/linux/instrumented.h |  4 ++++
> > >  lib/Kconfig.debug            | 10 ++++++++++
> > >  2 files changed, 14 insertions(+)
> > > 
> > > diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
> > > index 711a1f0d1a73..55f5685971a1 100644
> > > --- a/include/linux/instrumented.h
> > > +++ b/include/linux/instrumented.h
> > > @@ -7,6 +7,7 @@
> > >  #ifndef _LINUX_INSTRUMENTED_H
> > >  #define _LINUX_INSTRUMENTED_H
> > >  
> > > +#include <linux/bug.h>
> > >  #include <linux/compiler.h>
> > >  #include <linux/kasan-checks.h>
> > >  #include <linux/kcsan-checks.h>
> > > @@ -67,6 +68,7 @@ static __always_inline void instrument_atomic_read(const volatile void *v, size_
> > >  {
> > >  	kasan_check_read(v, size);
> > >  	kcsan_check_atomic_read(v, size);
> > > +	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (sizeof(long) - 1)));
> > >  }
> > >  
> > >  /**
> > > @@ -81,6 +83,7 @@ static __always_inline void instrument_atomic_write(const volatile void *v, size
> > >  {
> > >  	kasan_check_write(v, size);
> > >  	kcsan_check_atomic_write(v, size);
> > > +	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (sizeof(long) - 1)));
> > >  }
> > >  
> > >  /**
> > > @@ -95,6 +98,7 @@ static __always_inline void instrument_atomic_read_write(const volatile void *v,
> > >  {
> > >  	kasan_check_write(v, size);
> > >  	kcsan_check_atomic_read_write(v, size);
> > > +	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (sizeof(long) - 1)));
> > >  }
> > 
> > Right, so why aren't we trusting the size argument? And instead
> > mandating a possibly larger alignment?
> > 
> 
> It wasn't supposed to mandate a larger alignment in practice. I considered 
> doing something like (unsigned long)v & (size - 1) & (sizeof(long) - 1) 
> but decided that the extra overhead probably wouldn't be worthwhile, if in 
> practice, no-one is doing atomic ops on shorts or chars. I will revisit 
> this.

atomic_t is aligned at 4 bytes, you're now mandating it is aligned at 8
bytes (on LP64), this cannot be right.

kernel/locking/qspinlock.c:xchg_tail() does xchg_relaxed(&lock->tail,
...) which is u16. Again, you cannot mandate 8 bytes here.

> When you do atomic operations on atomic_t or atomic64_t, (sizeof(long)
> - 1) probably doesn't make much sense. But atomic operations get used on 
> scalar types (aside from atomic_t and atomic64_t) that don't have natural 
> alignment. Please refer to the other thread about this: 
> https://lore.kernel.org/all/ed1e0896-fd85-5101-e136-e4a5a37ca5ff@linux-m68k.org/

Perhaps set ARCH_SLAB_MINALIGN ?

