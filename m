Return-Path: <linux-arch+bounces-11240-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7344AA79669
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 22:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62CAE3B5C11
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 20:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84D21EFF8C;
	Wed,  2 Apr 2025 20:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNsGv5RE"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6241925AB;
	Wed,  2 Apr 2025 20:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743625150; cv=none; b=lCo4UbHg2iwt5DnMJTWE8KrmNCkXYYuMMxZLNqJTDdpn+YhPgv0kI1Mvmi16hYF6d67V5aKOocxh0IRieSOrmwxbKypUbdfVa+Nxlr9nkDA4KCtmmQfmsO10/zU9UIa4blMN/A9RvMRtv/78lX11qGDMfSHpOTpaqveY4dsE7vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743625150; c=relaxed/simple;
	bh=PBAlCXXoeZYK4hLqIaAvGTjwa5glXZM1tJS6eSjSSww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fj+LJsDdHWGyBOc2IKv6FE29RfFdLPiGTJOZgRpNQPyEBAA7/1mNxBb2oH5bHFd+Tz9vnZCQmJMvCQ3TRqHfkzoVwSf/OrFO7iUkgoaL3kUd7i4UWnECPtkD1XJc2DNJrmbaSoju/aiwDSfn//DRO+nak/4yA8xPURyj1XGMySM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNsGv5RE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5554BC4CEDD;
	Wed,  2 Apr 2025 20:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743625150;
	bh=PBAlCXXoeZYK4hLqIaAvGTjwa5glXZM1tJS6eSjSSww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TNsGv5REBUv5cCT3Y6XQje0aF3DB0+YmNtT4Z8Guj8UnqP9RDvNkPh30jZCNJ6ym/
	 ZYe5NowHojMJrVjp7O1ai7s2tjouVNUHS0RUE7OZayzmNTZNGUgq36PRUDhK0aZaFU
	 ujflV2XCHpWTbN2b6vk/r5o9Ttku8oPuqsL8H1j410RsfZ4NlTatOVmbdm4guXXZqp
	 bVKxgqmn5hngT7OjGOvj5fCLkUw0lcHgNdtXqygBbwQaJl+A9AwUNeCv70o9iFpba5
	 4yoqbCjOIKhAZBP1SyDDZKiTsH2KyjMsLt9ILHAC85utAuq/POgnQVkBFhnZ21G4md
	 h4MoLQ9RrqesQ==
Date: Wed, 2 Apr 2025 23:18:55 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
	"David S. Miller" <davem@davemloft.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>
Subject: Re: [PATCH v2 10/13] arch, mm: set high_memory in free_area_init()
Message-ID: <Z-2br1vk8lf9V40T@kernel.org>
References: <20250313135003.836600-1-rppt@kernel.org>
 <20250313135003.836600-11-rppt@kernel.org>
 <20250402140521-bf9b3743-094e-4097-a189-10cdf1db9255@linutronix.de>
 <Z-0xrWyff9-9bJRf@kernel.org>
 <20250402145330-3ff21a6b-fb03-4bc8-8178-51a535582c6f@linutronix.de>
 <20250402181842-f25872a1-00f7-4a8f-ae6d-3927899ee3a6@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250402181842-f25872a1-00f7-4a8f-ae6d-3927899ee3a6@linutronix.de>

On Wed, Apr 02, 2025 at 06:31:02PM +0200, Thomas Weißschuh wrote:
> On Wed, Apr 02, 2025 at 03:07:51PM +0200, Thomas Weißschuh wrote:
> > On Wed, Apr 02, 2025 at 03:46:37PM +0300, Mike Rapoport wrote:
> > > On Wed, Apr 02, 2025 at 02:19:01PM +0200, Thomas Weißschuh wrote:
> > > > (drop all the non-x86 and non-mm recipients)
> > > > 
> > > > On Thu, Mar 13, 2025 at 03:50:00PM +0200, Mike Rapoport wrote:
> > > > > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > > > > 
> > > > > high_memory defines upper bound on the directly mapped memory.
> > > > > This bound is defined by the beginning of ZONE_HIGHMEM when a system has
> > > > > high memory and by the end of memory otherwise.
> > > > > 
> > > > > All this is known to generic memory management initialization code that
> > > > > can set high_memory while initializing core mm structures.
> > > > > 
> > > > > Add a generic calculation of high_memory to free_area_init() and remove
> > > > > per-architecture calculation except for the architectures that set and
> > > > > use high_memory earlier than that.
> > > > 
> > > > This change (in mainline as commit e120d1bc12da ("arch, mm: set high_memory in free_area_init()")
> > > > breaks booting i386 on QEMU for me (and others [0]).
> > > > The boot just hangs without output.
> > > > 
> > > > It's easily reproducible with kunit:
> > > > ./tools/testing/kunit/kunit.py run --arch i386
> > > > 
> > > > See below for the specific problematic hunk.
> > > > 
> > > > [0] https://lore.kernel.org/lkml/CA+G9fYtdXHVuirs3v6at3UoKNH5keuq0tpcvpz0tJFT4toLG4g@mail.gmail.com/
> > > > 
> > > > 
> > > > > diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
> > > > > index 6d2f8cb9451e..801b659ead0c 100644
> > > > > --- a/arch/x86/mm/init_32.c
> > > > > +++ b/arch/x86/mm/init_32.c
> > > > > @@ -643,9 +643,6 @@ void __init initmem_init(void)
> > > > >  		highstart_pfn = max_low_pfn;
> > > > >  	printk(KERN_NOTICE "%ldMB HIGHMEM available.\n",
> > > > >  		pages_to_mb(highend_pfn - highstart_pfn));
> > > > > -	high_memory = (void *) __va(highstart_pfn * PAGE_SIZE - 1) + 1;
> > > > > -#else
> > > > > -	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE - 1) + 1;
> > > > >  #endif
> > > > 
> > > > Reverting this hunk fixes the issue for me.
> > >  
> > > This is already done by d893aca973c3 ("x86/mm: restore early initialization
> > > of high_memory for 32-bits").
> > 
> > Thanks. Of course I only noticed this shortly after sending my mail.
> > But this usecase is indeed broken on mainline.
> > Some further bisecting lead to the mm merge commit being broken, while both its
> > parents work. That lead the bisection astray.
> > eb0ece16027f ("Merge tag 'mm-stable-2025-03-30-16-52' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm")
> > 
> > As unlikely as it sounds, it's reproducible. I'll investigate a bit.
> 
> The issue is fixed with the following diff:
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 284154445409..8cd95f60015d 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2165,7 +2165,8 @@ static unsigned long __init __free_memory_core(phys_addr_t start,
>                                  phys_addr_t end)
>  {
>         unsigned long start_pfn = PFN_UP(start);
> -       unsigned long end_pfn = PFN_DOWN(end);
> +       unsigned long end_pfn = min_t(unsigned long,
> +                                     PFN_DOWN(end), max_low_pfn);

This will leave HIGHMEM completely unusable. The proper fix is

diff --git a/mm/memblock.c b/mm/memblock.c
index 64ae678cd1d1..d7ff8dfe5f88 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2166,6 +2166,9 @@ static unsigned long __init __free_memory_core(phys_addr_t start,
 	unsigned long start_pfn = PFN_UP(start);
 	unsigned long end_pfn = PFN_DOWN(end);
 
+	if (!IS_ENABLED(CONFIG_HIGHMEM) && end_pfn > max_low_pfn)
+		end_pfn = max_low_pfn;
+
 	if (start_pfn >= end_pfn)
 		return 0;

I've sent it along with the fix for x86 [1] (commit 7790c9c9265e
("memblock: don't release high memory to page allocator when HIGHMEM is
off") in mm-unstable), but for some reason it didn't make it to the Linus
tree :/

@Andrew, are you going to send it to Linus or you prefer if I take it via
memblock tree? 

[1] https://lore.kernel.org/all/20250325114928.1791109-3-rppt@kernel.org/

>         if (start_pfn >= end_pfn)
>                 return 0;
> 
> 
> Background:
> 
> This reverts part of commit 6faea3422e3b ("arch, mm: streamline HIGHMEM freeing")
> which is the direct child of the partially reverted 
> commit e120d1bc12da ("arch, mm: set high_memory in free_area_init()").
> The assumptions the former commit became invalid with the partial revert the latter.
> 
> This bug only triggers when CONFIG_HIGHMEM=n. When mm was branched from mainline
> the i386 configuration generated by kunit ended up with CONFIG_HIGHMEM=y.
> With some recent changes in mainline the kunit configuration switched to
> CONFIG_HIGHMEM=n, triggering this specific reproducer only when mm got merged
> into mainline again.
> 
> New kunit reproducer:
> ./tools/testing/kunit/kunit.py run --arch i386 example --timeout 10 --kconfig_add CONFIG_HIGHMEM=n
> 
> Does this sound reasonable?  If so I'll send a patch tomorrow.
> 
> @Naresh, could you test this, too?
> 
> 
> Thomas

-- 
Sincerely yours,
Mike.

