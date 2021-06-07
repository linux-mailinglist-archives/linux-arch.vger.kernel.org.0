Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5303239D35D
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jun 2021 05:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhFGDVJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 23:21:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:47834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230256AbhFGDVH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 6 Jun 2021 23:21:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3B7F61245;
        Mon,  7 Jun 2021 03:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623035956;
        bh=0p29jn++tsF+vUnK/OLUKwo6pJis8eT6cbc/e0CPuzk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B3DZEPCFHj/v5Wh0eE3Hrq81HmDqteDzAiErp79q286leKgx+z/elA3Gbf72nRXQB
         zaixflaXhEyrZss+CvXpW9BjFbENrt3H+Yq34C8eXLfPkdv0KNozsbGtTdJ9FHIoZr
         loQz21dNQobrRvPsJV4pJOpvl89V0jvJ8ydPmziQosrL0I6FATFynyjTISeHWJ/Wha
         EahD8/MbLA6lAQs90DU0SaXc6zzssLCcIO7uTcvFu+d8xmysLhAYpKZUT6pm+SMjne
         4hdXgZZesmaKVv2kqk6NDesMBFJvyw5Wzkxtg+Y8oQyd52Ko04rnb+WC3xdryV93pd
         A5hPljwlG1kRg==
Received: by mail-lj1-f177.google.com with SMTP id m3so20074026lji.12;
        Sun, 06 Jun 2021 20:19:16 -0700 (PDT)
X-Gm-Message-State: AOAM530J8fhciu2GVo+VgGgUgvWxuvybf3q73Q9M5Sz/yeyriVwuE0wU
        J91HvIiUnwDlxlblBrKsn+0ZAZT03BUeiTd2a8Q=
X-Google-Smtp-Source: ABdhPJw+Lf6RNVJ73c+UaqPihugKlQLGVtOJWsQyqACS35169cmAKldJM+82/gsj1c1RaDuUMLbnT9jy5ePND/KI3k8=
X-Received: by 2002:a05:651c:1314:: with SMTP id u20mr13696451lja.18.1623035954992;
 Sun, 06 Jun 2021 20:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <1621400656-25678-1-git-send-email-guoren@kernel.org>
 <20210519052048.GA24853@lst.de> <CAJF2gTTjwB4U-NxCtfgMA5aR2HzoQtA8a51W5UM1LHGRbjz9pg@mail.gmail.com>
 <20210519064435.GA3076809@x1> <20210519065352.GA31590@lst.de>
 <CAJF2gTR4FXRbp7oky-ypdVJba6btFHpp-+dPyJStRaQX_-5rzg@mail.gmail.com>
 <29733b0931d9dd6a2f0b6919067c7efe@mailhost.ics.forth.gr> <CAJF2gTTpSbNWS4VLHAu4XsV5-Vos=6R9MmPOx8-yzMFJu=wX4A@mail.gmail.com>
 <a8f2e68dcc1a6eb1ff3b95fcb8d0d0d2@mailhost.ics.forth.gr>
In-Reply-To: <a8f2e68dcc1a6eb1ff3b95fcb8d0d0d2@mailhost.ics.forth.gr>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 7 Jun 2021 11:19:03 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQuQ5bE6HeGSoNaDynA0o3+KEo4snwft42YGzE=+DjKOQ@mail.gmail.com>
Message-ID: <CAJF2gTQuQ5bE6HeGSoNaDynA0o3+KEo4snwft42YGzE=+DjKOQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] riscv: Add DMA_COHERENT support
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     Christoph Hellwig <hch@lst.de>,
        Drew Fustini <drew@beagleboard.org>,
        Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>, wefu@redhat.com,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Benjamin Koch <snowball@c3pb.de>,
        Matteo Croce <mcroce@linux.microsoft.com>,
        Wei Fu <tekkamanninja@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 7, 2021 at 10:16 AM Nick Kossifidis <mick@ics.forth.gr> wrote:
>
> =CE=A3=CF=84=CE=B9=CF=82 2021-06-07 03:04, Guo Ren =CE=AD=CE=B3=CF=81=CE=
=B1=CF=88=CE=B5:
> > On Mon, Jun 7, 2021 at 2:14 AM Nick Kossifidis <mick@ics.forth.gr>
> > wrote:
> >>
> >> =CE=A3=CF=84=CE=B9=CF=82 2021-05-20 04:45, Guo Ren =CE=AD=CE=B3=CF=81=
=CE=B1=CF=88=CE=B5:
> >> > On Wed, May 19, 2021 at 2:53 PM Christoph Hellwig <hch@lst.de> wrote=
:
> >> >>
> >> >> On Tue, May 18, 2021 at 11:44:35PM -0700, Drew Fustini wrote:
> >> >> > This patch series looks like it might be useful for the StarFive =
JH7100
> >> >> > [1] [2] too as it has peripherals on a non-coherent interconnect.=
 GMAC,
> >> >> > USB and SDIO require that the L2 cache must be manually flushed a=
fter
> >> >> > DMA operations if the data is intended to be shared with U74 core=
s [2].
> >> >>
> >> >> Not too much, given that the SiFive lineage CPUs have an uncached
> >> >> window, that is a totally different way to allocate uncached memory=
.
> >> > It's a very big MIPS smell. What's the attribute of the uncached
> >> > window? (uncached + strong-order/ uncached + weak, most vendors stil=
l
> >> > use AXI interconnect, how to deal with a bufferable attribute?) In
> >> > fact, customers' drivers use different ways to deal with DMA memory =
in
> >> > non-coherent SOC. Most riscv SOC vendors are from ARM, so giving the=
m
> >> > the same way in DMA memory is a smart choice. So using PTE attribute=
s
> >> > is more suitable.
> >> >
> >> > See:
> >> > https://github.com/riscv/virtual-memory/blob/main/specs/611-virtual-=
memory-diff.pdf
> >> > 4.4.1
> >> > The draft supports custom attribute bits in PTE.
> >> >
> >>
> >> Not only it doesn't support custom attributes on PTEs:
> >>
> >> "Bits63=E2=80=9354 are reserved for future standard use and must be ze=
roed by
> >> software for forward compatibility."
> >>
> >> It also goes further to say that:
> >>
> >> "if any of these bits are set, a page-fault exception is raised"
> >
> > In RISC-V VM TG, A C-bit discussion is raised. So it's a comm idea to
> > support it.
> >
>
> The C-bit was recently dropped, there is a new proposal for Page Based
> Memory Attributes (PBMT) that we can work on / push for.
C-bit still needs discussion, we shouldn't drop it directly.

>
> > Let Linux support custom PTE attributes won't get any side effect in
> > practice.
> >
> > IMO:
> > We needn't waste a bit in PTE, but the custom idea in PTE reserved
> > bits is necessary. Because Allwinner D1 needs custom PTE bits in
> > reserved bits to work around.
> > So I recommend just remove the "C" bit in PTE, but allow vendors to
> > define their own PTE attributes in reserved bits. I've found a way to
> > compact different PTE attributes of different vendors during the Linux
> > boot stage. That means we still could use One Image for all vendors in
> > Linux
>
> The spec is clear, those attributes are for standard use only, not for
> custom/platform use. It's one thing to implement custom CMOs where the
> ISA doesn't have anything for it and doesn't prevent you to do so (so
> you are not violating anything, it's just a custom extension), and we
> can hide them behind SBI calls etc, and another to violate the current
> Privilege Spec by using bits on PTEs that are reserved for standard use
> only. The intentions of the VM TG are clear, not only those bits are
> reserved but if software uses them the hw will result a page fault in
> future revisions of the spec. What's the idea here, to support
> non-compliant implementations on mainline ?
Raise a page fault won't solve anything. We still need access to the
page with proper performance.

> I'm sure you have a good
> idea on how to make this work, but as long as it violates the spec it
> can't go in IMHO.

We need PTEs to provide a non-coherency solution, and only CMO
instructions are not enough. We can't modify so many Linux drivers to
fit it.
From Linux non-coherency view, we need:
 - Non-cache + Strong Order PTE attributes to deal with drivers' DMA descri=
ptors
 - Non-cache + weak order to deal with framebuffer drivers
 - CMO dma_sync to sync cache with DMA devices
 - Userspace icache_sync solution, which prevents calls to S-mode with
IPI fence.i. (Necessary to JIT java scenarios.)

All above are not in spec, but the real chips are done.
(Actually, these have been talked about for more than five years, we
still haven't the uniform idea.)

The idea of C-bit is really important for us which prevents our chips
violates the spec.

--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
