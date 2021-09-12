Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39375407B09
	for <lists+linux-arch@lfdr.de>; Sun, 12 Sep 2021 02:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbhILALy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 11 Sep 2021 20:11:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:52608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230435AbhILALy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 11 Sep 2021 20:11:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D09CE61205;
        Sun, 12 Sep 2021 00:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631405440;
        bh=rjXQJPoGjJXG/Hc2aV6Aw8sNh7EVkz9yWcAzCNbbEjs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eXuEzLq6GWHkqS3CpXkj35rzzLmxtu2nj5NqNytbZT/1eFTIsvL4Y4RTc/JBBAv3q
         rxBBSupQIwdCxZduZrnRITpU7VCaLA2MIi0fQOaTBaw4cnorgMbjtcqn8rXABv/LPA
         a2XvU4N/hAd7xNdxkcmcDE/h/OP3R7/KZC7qWCLZhuGseNlzFvGfgrltPlHAndUddF
         DkZ28vkxhg4a4AclC/WiGdgvGnuGGRlvN6/6GvyBno6TK8/StfVRE+hcC+28CYaTH4
         UwznNCQh89sEPHMiHR4nzmK+9xQPcEGQ5DMvKuqDZGrHz6OsXPXWu9zwtPW+fJv4zO
         69retl15t86nw==
Received: by mail-lj1-f170.google.com with SMTP id l18so9903847lji.12;
        Sat, 11 Sep 2021 17:10:40 -0700 (PDT)
X-Gm-Message-State: AOAM530HuNSpE7/FRL8aDkPtSSS4BuVCpc/TRLLm0uvW8aC44e7CSVcO
        IYP/Q/CBuuUGzBTqnOpQfwl7XMT1sAauexXlln0=
X-Google-Smtp-Source: ABdhPJyiHODPdJ5L+2w4cbm1L9+Glebe7aq/6/Mw/j2r8k2lENKIx6D84Fb19m9zndoBsG51bmqUM7eRWPUwrBRFmpM=
X-Received: by 2002:a2e:9ac7:: with SMTP id p7mr4002766ljj.72.1631405439084;
 Sat, 11 Sep 2021 17:10:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAFnufp0eVejrDJoGE900D2U5-9qi-srVEmPOc9zHC5mSH4DgLg@mail.gmail.com>
 <mhng-22e6331c-16e1-40cc-b431-4990fda46ecf@palmerdabbelt-glaptop>
In-Reply-To: <mhng-22e6331c-16e1-40cc-b431-4990fda46ecf@palmerdabbelt-glaptop>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 12 Sep 2021 08:10:27 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTJ8M5FpL4=PDnPQgrrPaLxVhsZCTO2rXqaOm6MEn=gnA@mail.gmail.com>
Message-ID: <CAJF2gTTJ8M5FpL4=PDnPQgrrPaLxVhsZCTO2rXqaOm6MEn=gnA@mail.gmail.com>
Subject: Re: [PATCH] riscv: use the generic string routines
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Matteo Croce <mcroce@linux.microsoft.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        Bin Meng <bmeng.cn@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Sep 11, 2021 at 11:49 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Thu, 05 Aug 2021 03:31:04 PDT (-0700), mcroce@linux.microsoft.com wrote:
> > On Wed, Aug 4, 2021 at 10:40 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> >>
> >> On Tue, 03 Aug 2021 09:54:34 PDT (-0700), mcroce@linux.microsoft.com wrote:
> >> > On Mon, Jul 19, 2021 at 1:44 PM Matteo Croce <mcroce@linux.microsoft.com> wrote:
> >> >>
> >> >> From: Matteo Croce <mcroce@microsoft.com>
> >> >>
> >> >> Use the generic routines which handle alignment properly.
> >> >>
> >> >> These are the performances measured on a BeagleV machine for a
> >> >> 32 mbyte buffer:
> >> >>
> >> >> memcpy:
> >> >> original aligned:        75 Mb/s
> >> >> original unaligned:      75 Mb/s
> >> >> new aligned:            114 Mb/s
> >> >> new unaligned:          107 Mb/s
> >> >>
> >> >> memset:
> >> >> original aligned:       140 Mb/s
> >> >> original unaligned:     140 Mb/s
> >> >> new aligned:            241 Mb/s
> >> >> new unaligned:          241 Mb/s
> >> >>
> >> >> TCP throughput with iperf3 gives a similar improvement as well.
> >> >>
> >> >> This is the binary size increase according to bloat-o-meter:
> >> >>
> >> >> add/remove: 0/0 grow/shrink: 4/2 up/down: 432/-36 (396)
> >> >> Function                                     old     new   delta
> >> >> memcpy                                        36     324    +288
> >> >> memset                                        32     148    +116
> >> >> strlcpy                                      116     132     +16
> >> >> strscpy_pad                                   84      96     +12
> >> >> strlcat                                      176     164     -12
> >> >> memmove                                       76      52     -24
> >> >> Total: Before=1225371, After=1225767, chg +0.03%
> >> >>
> >> >> Signed-off-by: Matteo Croce <mcroce@microsoft.com>
> >> >> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> >> >> ---
> >> >
> >> > Hi,
> >> >
> >> > can someone have a look at this change and share opinions?
> >>
> >> This LGTM.  How are the generic string routines landing?  I'm happy to
> >> take this into my for-next, but IIUC we need the optimized generic
> >> versions first so we don't have a performance regression falling back to
> >> the trivial ones for a bit.  Is there a shared tag I can pull in?
> >
> > Hi,
> >
> > I see them only in linux-next by now.
>
> These ended up getting rejected by Linus, so I'm going to hold off on
> this for now.  If they're really out of lib/ then I'll take the C
> routines in arch/riscv, but either way it's an issue for the next
> release.
Agree, we should take the C routine in arch/riscv for common
implementation. If any vendor what custom implementation they could
use the alternative framework in errata for string operations.

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
