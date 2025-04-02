Return-Path: <linux-arch+bounces-11222-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAA0A78F74
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 15:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A1D3A97E3
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 13:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FCD238D22;
	Wed,  2 Apr 2025 13:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qJ+t6SGu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NiG1u7Az"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298425BAF0;
	Wed,  2 Apr 2025 13:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743599275; cv=none; b=U/AVTif4GGVZHo9f1UQPU6ym3ZYsYbiQ3CZxGQfehYYoYeGXMH/C2GIlH587Ur5+2diydHUx0ZkMguDbvgnK58KMb89/KzOqK/mvAtEmaTxnQYOgir8M3I/3PunmOCTx7M4lqVuzRypbnHnSJNaC6tT4eg2nh+1ALqy0ZYxwvRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743599275; c=relaxed/simple;
	bh=mfOHJodd9Ix+904JZn6Bb6pxHxbK7pb4BM8dh/9iDp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRDU4QK6dnYNaCx05kTPbLQETTLmuwkg6lnkEhWUVEmbavo6AVMrtDVY2b1pU1/ZISJKQYRVKYLB51vuiG48DBT+wGKHettDMFq5W6p8wQx+tJsxVVyKK32r6lCaFOxfqIr29NZSXnyjKDaDhCAcerS+8KOq0ic6DB4u0JrXaK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qJ+t6SGu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NiG1u7Az; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 2 Apr 2025 15:07:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743599271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1X5wKZymmcKMOD5wz7WhMq48v9AtCOzb7Bp+Wejqjt8=;
	b=qJ+t6SGuwcs0fcyTCbz3+CsuGvBvpcjRYcRy/lpyBhR+xNgkf0K9rJPWuH0Ai+vKzYoypW
	hqrNELPyFAyCERAgiBi7wAA54c3Chm8qfwjjDzhdUPZRvvAMPqKEo4uSn+n+whHb0reT8i
	wbUReQVouPVIqlxZ6r8BTrHhifDE2WHyP3Wy9EL8f/yEnnGI5zIKUPIBCYSUrVyAaQXsra
	KeQDShbcfQn2CDTOO5A+IHd7IX+XVzqSQsZnteNmyMY4FkI9MYmdiIlJnoGRg+W2QYUy8p
	UZSllggqcCZAQ0lxGVyI18oFzgzoD5Sxv/zkJj3Z1jCPpaYXFavROx6jN2z7yA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743599271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1X5wKZymmcKMOD5wz7WhMq48v9AtCOzb7Bp+Wejqjt8=;
	b=NiG1u7AzlJl1SUEGEOjj7BJBgsegHE66/nZ7RMmUJd1+EAbdhFi4oSlsDCHU/zRo4c/EEd
	L5aOdKtWP/pNZrAA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, 
	"David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, x86@kernel.org, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Subject: Re: [PATCH v2 10/13] arch, mm: set high_memory in free_area_init()
Message-ID: <20250402145330-3ff21a6b-fb03-4bc8-8178-51a535582c6f@linutronix.de>
References: <20250313135003.836600-1-rppt@kernel.org>
 <20250313135003.836600-11-rppt@kernel.org>
 <20250402140521-bf9b3743-094e-4097-a189-10cdf1db9255@linutronix.de>
 <Z-0xrWyff9-9bJRf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z-0xrWyff9-9bJRf@kernel.org>

On Wed, Apr 02, 2025 at 03:46:37PM +0300, Mike Rapoport wrote:
> On Wed, Apr 02, 2025 at 02:19:01PM +0200, Thomas Weißschuh wrote:
> > (drop all the non-x86 and non-mm recipients)
> > 
> > On Thu, Mar 13, 2025 at 03:50:00PM +0200, Mike Rapoport wrote:
> > > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > > 
> > > high_memory defines upper bound on the directly mapped memory.
> > > This bound is defined by the beginning of ZONE_HIGHMEM when a system has
> > > high memory and by the end of memory otherwise.
> > > 
> > > All this is known to generic memory management initialization code that
> > > can set high_memory while initializing core mm structures.
> > > 
> > > Add a generic calculation of high_memory to free_area_init() and remove
> > > per-architecture calculation except for the architectures that set and
> > > use high_memory earlier than that.
> > 
> > This change (in mainline as commit e120d1bc12da ("arch, mm: set high_memory in free_area_init()")
> > breaks booting i386 on QEMU for me (and others [0]).
> > The boot just hangs without output.
> > 
> > It's easily reproducible with kunit:
> > ./tools/testing/kunit/kunit.py run --arch i386
> > 
> > See below for the specific problematic hunk.
> > 
> > [0] https://lore.kernel.org/lkml/CA+G9fYtdXHVuirs3v6at3UoKNH5keuq0tpcvpz0tJFT4toLG4g@mail.gmail.com/
> > 
> > 
> > > diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
> > > index 6d2f8cb9451e..801b659ead0c 100644
> > > --- a/arch/x86/mm/init_32.c
> > > +++ b/arch/x86/mm/init_32.c
> > > @@ -643,9 +643,6 @@ void __init initmem_init(void)
> > >  		highstart_pfn = max_low_pfn;
> > >  	printk(KERN_NOTICE "%ldMB HIGHMEM available.\n",
> > >  		pages_to_mb(highend_pfn - highstart_pfn));
> > > -	high_memory = (void *) __va(highstart_pfn * PAGE_SIZE - 1) + 1;
> > > -#else
> > > -	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE - 1) + 1;
> > >  #endif
> > 
> > Reverting this hunk fixes the issue for me.
>  
> This is already done by d893aca973c3 ("x86/mm: restore early initialization
> of high_memory for 32-bits").

Thanks. Of course I only noticed this shortly after sending my mail.
But this usecase is indeed broken on mainline.
Some further bisecting lead to the mm merge commit being broken, while both its
parents work. That lead the bisection astray.
eb0ece16027f ("Merge tag 'mm-stable-2025-03-30-16-52' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm")

As unlikely as it sounds, it's reproducible. I'll investigate a bit.

> > >  	memblock_set_node(0, PHYS_ADDR_MAX, &memblock.memory, 0);

