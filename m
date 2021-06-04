Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9ECE39BB16
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 16:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhFDOtX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 10:49:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:48182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229656AbhFDOtW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Jun 2021 10:49:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E27661417;
        Fri,  4 Jun 2021 14:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622818056;
        bh=rR/M3AdUUihX1IBhGcTwd/czbJxTvbvVyCYM/Z+lUc0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lOABWOHg3awLYQt4uvo1RXkz/lTtLTGFbR/WRUTauRVH14R1ofsL2mPtdY+qc1vY5
         M+xNF7GQWiRqpIbf1F4kOnOPLkOyUVoxsxjqClFfgsSxqEHWVgyH339FhOtZL30QYf
         Lkb0vggPY1qz96ORb2Nf3H1uOLYKfVr9i/P9nMQCuH93E5FDDSXkbrEufIUQFdQZzC
         cBc9uV1QfwNiYoTketvIhuV1xVZEt00XIAGgLed4NlljGE0lCwo0d1pQS9UkaxAhIL
         noAm44tgDZpG1i6i1/gTXBpG/Y5lV3d0tNgjw28fueC0P0mwC7GOlpvjGPOQB7tpz2
         uScpwirVnzKwg==
Received: by mail-lf1-f42.google.com with SMTP id n12so7489801lft.10;
        Fri, 04 Jun 2021 07:47:36 -0700 (PDT)
X-Gm-Message-State: AOAM532WiYrzsfyY+ogqBp/hxjCfvuA2uiyk/8hpPWBrPeMbwR61MdHJ
        B6Ht4BK6YqyUHXwziDnDvOMXlTGk33ApOvlM+FE=
X-Google-Smtp-Source: ABdhPJxCtx4UJ1QpmojiNDq4Wb0bvxaMjenZ4RRwpSwqoQiYAFWz1tgIY5GuzMS/LrMuVE8dno80j5NrSM0QfUmA2b0=
X-Received: by 2002:a05:6512:987:: with SMTP id w7mr2967857lft.41.1622818054362;
 Fri, 04 Jun 2021 07:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <CO6PR04MB7812D8905C6EEBDE8513866F8D3C9@CO6PR04MB7812.namprd04.prod.outlook.com>
 <mhng-3875d1bc-74dd-4dc8-b71d-18a8f004039a@palmerdabbelt-glaptop> <CAK8P3a03sxxnzpZPxNnXLtCFOFBZ6espEj4V5y=K+59dOLJc6A@mail.gmail.com>
In-Reply-To: <CAK8P3a03sxxnzpZPxNnXLtCFOFBZ6espEj4V5y=K+59dOLJc6A@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 4 Jun 2021 22:47:22 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTpurWpPUcA2JkF0rOFztKQgFBhOF9zQyuyi_-sxszhRQ@mail.gmail.com>
Message-ID: <CAJF2gTTpurWpPUcA2JkF0rOFztKQgFBhOF9zQyuyi_-sxszhRQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] riscv: Add DMA_COHERENT support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        Drew Fustini <drew@beagleboard.org>,
        Christoph Hellwig <hch@lst.de>, wefu@redhat.com,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Arnd & Palmer,

Sorry for the delayed reply, I'm working on the next version of the patch.

On Fri, Jun 4, 2021 at 5:56 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Jun 3, 2021 at 5:39 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> > On Wed, 02 Jun 2021 23:00:29 PDT (-0700), Anup Patel wrote:
> > >> This implementation, which adds some Kconfig entries that control page table
> > >> bits, definately isn't suitable for upstream.  Allowing users to set arbitrary
> > >> page table bits will eventually conflict with the standard, and is just going to
> > >> be a mess.  It'll also lead to kernels that are only compatible with specific
> > >> designs, which we're trying very hard to avoid.  At a bare minimum we'll need
> > >> some way to detect systems with these page table bits before setting them,
> > >> and some description of what the bits actually do so we can reason about
> > >> them.
> > >
> > > Yes, vendor specific Kconfig options are strict NO NO. We can't give-up the
> > > goal of unified kernel image for all platforms.
Okay,  Agree. Please help review the next version of the patch.

> >
> > I think this is just a phrasing issue, but just to be sure:
> >
> > IMO it's not that they're vendor-specific Kconfig options, it's that
> > turning them on will conflict with standard systems (and other vendors).
> > We've already got the ability to select sets of Kconfig settings that
> > will only boot on one vendor's system, which is fine, as long as there
> > remains a set of Kconfig settings that will boot on all systems.
> >
> > An example here would be the errata: every system has errata of some
> > sort, so if we start flipping off various vendor's errata Kconfigs
> > you'll end up with kernels that only function properly on some systems.
> > That's fine with me, as long as it's possible to turn on all vendor's
> > errata Kconfigs at the same time and the resulting kernel functions
> > correctly on all systems.
>
> Yes, this is generally the goal, and it would be great to have that
> working in a way where a 'defconfig' build just turns on all the options
> that are needed to use any SoC specific features and drivers while
> still working on all hardware. There are however limits you may run
> into at some point, and other architectures usually only manage to span
> some 10 to 15 years of hardware implementations with a single
> kernel before it get really hard.
I could follow the goal in the next version of the patchset. Please
help review, thx.

>
> To give some common examples that make it break down:
>
> - 32-bit vs 64-bit already violates that rule on risc-v (as it does on
>   most other architectures)
>
> - architectures that support both big-endian and little-endian kernels
>   tend to have platforms that require one or the other (e.g. mips,
>   though not arm). Not an issue for you.
>
> - page table formats are the main cause of incompatibility: arm32
>   and x86-32 require three-level tables for certain features, but those
>   are incompatible with older cores, arm64 supports three different
>   page sizes, but none of them works on all cores (4KB almost works
>   everywhere).
>
> - SMP-enabled ARMv7 kernels can be configured to run on either
>   ARMv6 or ARMv8, but not both, in this case because of incompatible
>   barrier instructions.
>
> - 32-bit Arm has a couple more remaining features that require building
>   a machine specific kernel if enabled because they hardcode physical
>   addresses: early printk (debug_ll, not the normal earlycon), NOMMU,
>   and XIP.
>
>        Arnd



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
