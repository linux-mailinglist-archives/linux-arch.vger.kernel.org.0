Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDAEA24A7EB
	for <lists+linux-arch@lfdr.de>; Wed, 19 Aug 2020 22:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgHSUtE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Aug 2020 16:49:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727050AbgHSUtE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Aug 2020 16:49:04 -0400
Received: from kernel.org (unknown [87.70.91.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4559022B43;
        Wed, 19 Aug 2020 20:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597870143;
        bh=qGoMJNQU47bi4Lr27Xvnh0/Sq60m3eAX4xqpvHpl7z0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EDED5GsJw4zUuBdGb05pEvujvo8C6rUQNmDr6tFajHgKyq8u0aC1JhmrGGKixlNzr
         iJK0JwajiHl4HBTkAxVXhkjy+fJ4SSitgCYA/knE1HAPx9DykSi5zvv7ufmh3aqaBj
         /RQUWYvoEHKL6x5oDDNaW/gHGb6Yyk2UI/DMzVR8=
Date:   Wed, 19 Aug 2020 23:48:48 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Baoquan He <bhe@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>, Daniel Axtens <dja@axtens.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        clang-built-linux@googlegroups.com,
        iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp, x86@kernel.org
Subject: Re: [PATCH v3 09/17] memblock: make memblock_debug and related
 functionality private
Message-ID: <20200819204848.GX752365@kernel.org>
References: <20200818151634.14343-1-rppt@kernel.org>
 <20200818151634.14343-10-rppt@kernel.org>
 <20200819122405.88e9719e86ac7c3c44b4db32@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819122405.88e9719e86ac7c3c44b4db32@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 19, 2020 at 12:24:05PM -0700, Andrew Morton wrote:
> On Tue, 18 Aug 2020 18:16:26 +0300 Mike Rapoport <rppt@kernel.org> wrote:
> 
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > The only user of memblock_dbg() outside memblock was s390 setup code and it
> > is converted to use pr_debug() instead.
> > This allows to stop exposing memblock_debug and memblock_dbg() to the rest
> > of the kernel.
> > 
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -137,7 +137,10 @@ struct memblock_type physmem = {
> >  	     i < memblock_type->cnt;					\
> >  	     i++, rgn = &memblock_type->regions[i])
> >  
> > -int memblock_debug __initdata_memblock;
> > +#define memblock_dbg(fmt, ...) \
> > +	if (memblock_debug) printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
> > +
> 
> checkpatch doesn't like this much.
> 
> ERROR: Macros starting with if should be enclosed by a do - while loop to avoid possible if/else logic defects
> #101: FILE: mm/memblock.c:140:
> +#define memblock_dbg(fmt, ...) \
> +	if (memblock_debug) printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
> 
> WARNING: Prefer [subsystem eg: netdev]_info([subsystem]dev, ... then dev_info(dev, ... then pr_info(...  to printk(KERN_INFO ...
> #102: FILE: mm/memblock.c:141:
> +	if (memblock_debug) printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
> 
> ERROR: trailing statements should be on next line
> #102: FILE: mm/memblock.c:141:
> +	if (memblock_debug) printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
> 
> 
> The first one is significant:
> 
> 	if (foo)
> 		memblock_dbg(...);
> 	else
> 		save_the_world();
> 
> could end up inadvertently destroying the planet.

Well, it didn't till now ;-)

> This?
> 
> --- a/mm/memblock.c~memblock-make-memblock_debug-and-related-functionality-private-fix
> +++ a/mm/memblock.c
> @@ -137,8 +137,11 @@ struct memblock_type physmem = {
>  	     i < memblock_type->cnt;					\
>  	     i++, rgn = &memblock_type->regions[i])
>  
> -#define memblock_dbg(fmt, ...) \
> -	if (memblock_debug) printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
> +#define memblock_dbg(fmt, ...)						\
> +	do {								\
> +		if (memblock_debug)					\
> +			pr_info(fmt, ##__VA_ARGS__);			\
> +	} while (0)

Sure, thanks!

>  static int memblock_debug __initdata_memblock;
>  static bool system_has_some_mirror __initdata_memblock = false;
> _
> 

-- 
Sincerely yours,
Mike.
