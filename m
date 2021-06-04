Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F42439B645
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 11:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhFDJ5T (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 05:57:19 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:54809 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhFDJ5S (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jun 2021 05:57:18 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MStT6-1lxFW92Wvm-00UIut; Fri, 04 Jun 2021 11:55:31 +0200
Received: by mail-wr1-f46.google.com with SMTP id n4so8693614wrw.3;
        Fri, 04 Jun 2021 02:55:31 -0700 (PDT)
X-Gm-Message-State: AOAM530G01n//Al712oHcoMIMzVLTZxFDqgmFw0SjcZgKvc0CmI1nopl
        uB5yQNLOdSO8sS8frGfs7BOsGpO7ZuloHmNwS5s=
X-Google-Smtp-Source: ABdhPJxshE3+Uw6+fWuekuuwJhK8oE6TcJIBm0QrwrkRRuWDjLhV71VM+ZrxsXwvq+Gqd5ead+heu/mutRyeZaqbM2U=
X-Received: by 2002:a5d:5084:: with SMTP id a4mr3045824wrt.286.1622800531222;
 Fri, 04 Jun 2021 02:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <CO6PR04MB7812D8905C6EEBDE8513866F8D3C9@CO6PR04MB7812.namprd04.prod.outlook.com>
 <mhng-3875d1bc-74dd-4dc8-b71d-18a8f004039a@palmerdabbelt-glaptop>
In-Reply-To: <mhng-3875d1bc-74dd-4dc8-b71d-18a8f004039a@palmerdabbelt-glaptop>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 4 Jun 2021 11:53:48 +0200
X-Gmail-Original-Message-ID: <CAK8P3a03sxxnzpZPxNnXLtCFOFBZ6espEj4V5y=K+59dOLJc6A@mail.gmail.com>
Message-ID: <CAK8P3a03sxxnzpZPxNnXLtCFOFBZ6espEj4V5y=K+59dOLJc6A@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] riscv: Add DMA_COHERENT support
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>, Guo Ren <guoren@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Drew Fustini <drew@beagleboard.org>,
        Christoph Hellwig <hch@lst.de>, wefu@redhat.com,
        lazyparser@gmail.com,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ujRpXPvNy6Jxro+egqdLKAw5vJR180w7QwlpXdBCHfIrGqxinQz
 nQR6+KvWR5sJYROEuH+FIIRH7X5P5IFQfZluaWm0Xb5kyNaV0B7BaOLps8CU3h3XVMBAM7P
 sKR34naXwcGgeXlVXbcuOEoJERzv7eIIjYr6lcDFIOI20I1iBL0sUaGb9LCmNr3+vYkq44f
 BZ6xm+eanWz4z78eCRBMQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jAKJ4I7p/2A=:QHvYiqwgjPgKFMmyiSeKYu
 S5rKt7mk11ggGKf8g/VCPt+F29wFssyG7Zhp5YYohJ9JI/2fJTZQvxvzw+zZ/wgqSQF4Z52tY
 U9yVnOv1UtRm0q0rxlVM9MOxjhgdAcaue1a1fBafAnvE689xK3+uhaFUzQ7xZIgK5KxtYc+aI
 2iSmArr6eOAYc2TNeB1usZ+tfqiLsaBEsC2EIhePp3JyzHTjE7fDQzNasEKXjc4dSasMs6ldR
 OISdpDtE3rsZZfMH+XAB6G7FnwehxwB/e+ZIFULx6bGZRxD+DQxdTzWRKYXvkGOQJon6ypsZw
 t84J0z8nlYGp6LQjIKZuxoxxA35HN04Lhj7/h1K1vCL7HpbRFC546GBkTjohKw7b0JS4SgKRd
 feDXme/jATzM2I+OcM5vpnizamXT23ETgrBG5L+DDGZ3pjlWwPdYEm4FzhBDda23/l2stzWpG
 4d9+KVUP2VXyhjO8yItd5SJ67bXmCPRr0EtVgi6y2qzTHUd9R5YvnlgTO4+dM2IvoaOhBmVUK
 pBmTQ/bOhEapuxjWmOINIdLUSH58z+cckD/Ouj653zmPU0SB24TxIL0OkE5nYFD68kZPuJBuK
 iIChdF/JDVn2DCBObSi1NyQYbHAhNNT7+F83RYVjmwOcHYs0diCe8WSd0QbigeNUbjhzo/yJP
 wkGM=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 3, 2021 at 5:39 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> On Wed, 02 Jun 2021 23:00:29 PDT (-0700), Anup Patel wrote:
> >> This implementation, which adds some Kconfig entries that control page table
> >> bits, definately isn't suitable for upstream.  Allowing users to set arbitrary
> >> page table bits will eventually conflict with the standard, and is just going to
> >> be a mess.  It'll also lead to kernels that are only compatible with specific
> >> designs, which we're trying very hard to avoid.  At a bare minimum we'll need
> >> some way to detect systems with these page table bits before setting them,
> >> and some description of what the bits actually do so we can reason about
> >> them.
> >
> > Yes, vendor specific Kconfig options are strict NO NO. We can't give-up the
> > goal of unified kernel image for all platforms.
>
> I think this is just a phrasing issue, but just to be sure:
>
> IMO it's not that they're vendor-specific Kconfig options, it's that
> turning them on will conflict with standard systems (and other vendors).
> We've already got the ability to select sets of Kconfig settings that
> will only boot on one vendor's system, which is fine, as long as there
> remains a set of Kconfig settings that will boot on all systems.
>
> An example here would be the errata: every system has errata of some
> sort, so if we start flipping off various vendor's errata Kconfigs
> you'll end up with kernels that only function properly on some systems.
> That's fine with me, as long as it's possible to turn on all vendor's
> errata Kconfigs at the same time and the resulting kernel functions
> correctly on all systems.

Yes, this is generally the goal, and it would be great to have that
working in a way where a 'defconfig' build just turns on all the options
that are needed to use any SoC specific features and drivers while
still working on all hardware. There are however limits you may run
into at some point, and other architectures usually only manage to span
some 10 to 15 years of hardware implementations with a single
kernel before it get really hard.

To give some common examples that make it break down:

- 32-bit vs 64-bit already violates that rule on risc-v (as it does on
  most other architectures)

- architectures that support both big-endian and little-endian kernels
  tend to have platforms that require one or the other (e.g. mips,
  though not arm). Not an issue for you.

- page table formats are the main cause of incompatibility: arm32
  and x86-32 require three-level tables for certain features, but those
  are incompatible with older cores, arm64 supports three different
  page sizes, but none of them works on all cores (4KB almost works
  everywhere).

- SMP-enabled ARMv7 kernels can be configured to run on either
  ARMv6 or ARMv8, but not both, in this case because of incompatible
  barrier instructions.

- 32-bit Arm has a couple more remaining features that require building
  a machine specific kernel if enabled because they hardcode physical
  addresses: early printk (debug_ll, not the normal earlycon), NOMMU,
  and XIP.

       Arnd
