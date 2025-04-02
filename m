Return-Path: <linux-arch+bounces-11224-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF39A79346
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 18:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B48A318977EA
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 16:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C8518B484;
	Wed,  2 Apr 2025 16:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aPXkPsRI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n1+9FCz0"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990F418DF80;
	Wed,  2 Apr 2025 16:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743611470; cv=none; b=kyeMEnD6PQSRCqcNNSkfSg496TAjiEz1uvM2+vHhguYzyAR1CBU8to0msxWoErRXzj8lOOIvMrbD4LrtpZ5g13o568U8XtJO5q8iksrkTtuIhCc4Grcd1iC0S40UaS2BMo0EdjTqJaL9VSFNxAdcc4NdEgXG2ChkdvFBuZZEJoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743611470; c=relaxed/simple;
	bh=HIy0hHKXAPReYxd7y9ffbIswkaLgKDknXWgNX8/gO7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYFu67yXnMD//lA+9slyPrO9FvJWfmn3WgMNQRlSYYfNKIYA4E6j100JomxEF4ur2LQumqlU2hYeuECIKvR5DQiZNlrztg7tZpr6YSVfwvKl87UH5Xne+CQ2GWQQlAopbAODsRkXqpd8NTgIgVu3SHYeNnx5ye135etJZ4dY3kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aPXkPsRI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n1+9FCz0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 2 Apr 2025 18:31:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743611465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xd1KphlzMCu4Z6pJqyX+aES04YRk8Sgi26znrqcmoIg=;
	b=aPXkPsRIIO+gk78hNS3UHwVMimopyiRa1u6YCD+0iGOR+lmT6lbaVwOH99yWvYa+WfQxLF
	R51hhQM1N/mhrjLz/aLU294Ce1HMRoGVWJKB5LOhsUdIG99UC9WDsVeWAIut8jOTx9xmSN
	B/i45j3A8a5oIiufsZmj0blDls862jXMfTo+QTqmTCW46OyN7r7mqq59x0oy47iXZ6ca+Y
	oi6Qyr74IKAKJRGksrokIKJF9UD/s2DTABua+W1VDFbT2QfV+Y3kk3DMx8Z8XdesvqZnbY
	4NNnBO9/MVZEK17byNSQ8r6etoNTI0sBKV8HP/1OnYvuoWhWWDF35lq6mzFCCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743611465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xd1KphlzMCu4Z6pJqyX+aES04YRk8Sgi26znrqcmoIg=;
	b=n1+9FCz093xgYuvsHQefw2o4N3FjHh4l9TGgA+vPheErSpZmihg0SZ5/I3Og9Dp0GRR6ox
	+qrb7WjeznoHtOAQ==
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
Message-ID: <20250402181842-f25872a1-00f7-4a8f-ae6d-3927899ee3a6@linutronix.de>
References: <20250313135003.836600-1-rppt@kernel.org>
 <20250313135003.836600-11-rppt@kernel.org>
 <20250402140521-bf9b3743-094e-4097-a189-10cdf1db9255@linutronix.de>
 <Z-0xrWyff9-9bJRf@kernel.org>
 <20250402145330-3ff21a6b-fb03-4bc8-8178-51a535582c6f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250402145330-3ff21a6b-fb03-4bc8-8178-51a535582c6f@linutronix.de>

On Wed, Apr 02, 2025 at 03:07:51PM +0200, Thomas Weißschuh wrote:
> On Wed, Apr 02, 2025 at 03:46:37PM +0300, Mike Rapoport wrote:
> > On Wed, Apr 02, 2025 at 02:19:01PM +0200, Thomas Weißschuh wrote:
> > > (drop all the non-x86 and non-mm recipients)
> > > 
> > > On Thu, Mar 13, 2025 at 03:50:00PM +0200, Mike Rapoport wrote:
> > > > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > > > 
> > > > high_memory defines upper bound on the directly mapped memory.
> > > > This bound is defined by the beginning of ZONE_HIGHMEM when a system has
> > > > high memory and by the end of memory otherwise.
> > > > 
> > > > All this is known to generic memory management initialization code that
> > > > can set high_memory while initializing core mm structures.
> > > > 
> > > > Add a generic calculation of high_memory to free_area_init() and remove
> > > > per-architecture calculation except for the architectures that set and
> > > > use high_memory earlier than that.
> > > 
> > > This change (in mainline as commit e120d1bc12da ("arch, mm: set high_memory in free_area_init()")
> > > breaks booting i386 on QEMU for me (and others [0]).
> > > The boot just hangs without output.
> > > 
> > > It's easily reproducible with kunit:
> > > ./tools/testing/kunit/kunit.py run --arch i386
> > > 
> > > See below for the specific problematic hunk.
> > > 
> > > [0] https://lore.kernel.org/lkml/CA+G9fYtdXHVuirs3v6at3UoKNH5keuq0tpcvpz0tJFT4toLG4g@mail.gmail.com/
> > > 
> > > 
> > > > diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
> > > > index 6d2f8cb9451e..801b659ead0c 100644
> > > > --- a/arch/x86/mm/init_32.c
> > > > +++ b/arch/x86/mm/init_32.c
> > > > @@ -643,9 +643,6 @@ void __init initmem_init(void)
> > > >  		highstart_pfn = max_low_pfn;
> > > >  	printk(KERN_NOTICE "%ldMB HIGHMEM available.\n",
> > > >  		pages_to_mb(highend_pfn - highstart_pfn));
> > > > -	high_memory = (void *) __va(highstart_pfn * PAGE_SIZE - 1) + 1;
> > > > -#else
> > > > -	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE - 1) + 1;
> > > >  #endif
> > > 
> > > Reverting this hunk fixes the issue for me.
> >  
> > This is already done by d893aca973c3 ("x86/mm: restore early initialization
> > of high_memory for 32-bits").
> 
> Thanks. Of course I only noticed this shortly after sending my mail.
> But this usecase is indeed broken on mainline.
> Some further bisecting lead to the mm merge commit being broken, while both its
> parents work. That lead the bisection astray.
> eb0ece16027f ("Merge tag 'mm-stable-2025-03-30-16-52' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm")
> 
> As unlikely as it sounds, it's reproducible. I'll investigate a bit.

The issue is fixed with the following diff:

diff --git a/mm/memblock.c b/mm/memblock.c
index 284154445409..8cd95f60015d 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2165,7 +2165,8 @@ static unsigned long __init __free_memory_core(phys_addr_t start,
                                 phys_addr_t end)
 {
        unsigned long start_pfn = PFN_UP(start);
-       unsigned long end_pfn = PFN_DOWN(end);
+       unsigned long end_pfn = min_t(unsigned long,
+                                     PFN_DOWN(end), max_low_pfn);

        if (start_pfn >= end_pfn)
                return 0;


Background:

This reverts part of commit 6faea3422e3b ("arch, mm: streamline HIGHMEM freeing")
which is the direct child of the partially reverted 
commit e120d1bc12da ("arch, mm: set high_memory in free_area_init()").
The assumptions the former commit became invalid with the partial revert the latter.

This bug only triggers when CONFIG_HIGHMEM=n. When mm was branched from mainline
the i386 configuration generated by kunit ended up with CONFIG_HIGHMEM=y.
With some recent changes in mainline the kunit configuration switched to
CONFIG_HIGHMEM=n, triggering this specific reproducer only when mm got merged
into mainline again.

New kunit reproducer:
./tools/testing/kunit/kunit.py run --arch i386 example --timeout 10 --kconfig_add CONFIG_HIGHMEM=n

Does this sound reasonable?  If so I'll send a patch tomorrow.

@Naresh, could you test this, too?


Thomas

