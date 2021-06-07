Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F7939D251
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jun 2021 02:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhFGAGn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 20:06:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:42352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229772AbhFGAGn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 6 Jun 2021 20:06:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2419161244;
        Mon,  7 Jun 2021 00:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623024293;
        bh=atz/fcsESOx4m+4QdyLdkqW2IvLkfkghNsC8hMHMoCA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KurZTjpisOGAbiz8svMmX6uc4+SaRSwiEJJH43yI/4co87lGcqFgAAS4k6LCPkroD
         lHv1jHyzy7HV08taRk5MiYDAW/mWOr34psAtqjYh53vwxwdXV7PGnZw2mkkizTbvst
         fPOaZgRm/0/tRQcego1vRCK0JWhYbMd0L2sqlr5iKhZbYEKQwbxE0dWlLA8Qo1bOL4
         Rni2BcHIbw53+0fLUm2WOqAFJO8ZqlVVbATNhg+e4pq8fOxApd7kzKAQbaOJ4A06mW
         iSOqOvVTZVOZE1hVm0gdM6256I/ydU8WXp8Txm6QT0h/6BvgKZeAVsiX7OMZ/Cr3mb
         Xhs8u93K9lyLw==
Received: by mail-lf1-f49.google.com with SMTP id v22so21871577lfa.3;
        Sun, 06 Jun 2021 17:04:53 -0700 (PDT)
X-Gm-Message-State: AOAM531LfmJv7F0SygchUyUpQ/i+MnLdK/zY4aydNvlp8ojhssQUG89Y
        H7Hbb+99bJI5UADRt0TwGMx1UrsQ8sr60vS66jw=
X-Google-Smtp-Source: ABdhPJwuQllzav+cgeOOUIngf06MsoU9QTjK26Dvhvo+prT7F1wWL0rZ9xfVmzD2sZ6rrVJ00qzd3egZjVUgtaov0Vw=
X-Received: by 2002:a05:6512:218d:: with SMTP id b13mr10221837lft.346.1623024291473;
 Sun, 06 Jun 2021 17:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <1621400656-25678-1-git-send-email-guoren@kernel.org>
 <20210519052048.GA24853@lst.de> <CAJF2gTTjwB4U-NxCtfgMA5aR2HzoQtA8a51W5UM1LHGRbjz9pg@mail.gmail.com>
 <20210519064435.GA3076809@x1> <20210519065352.GA31590@lst.de>
 <CAJF2gTR4FXRbp7oky-ypdVJba6btFHpp-+dPyJStRaQX_-5rzg@mail.gmail.com> <29733b0931d9dd6a2f0b6919067c7efe@mailhost.ics.forth.gr>
In-Reply-To: <29733b0931d9dd6a2f0b6919067c7efe@mailhost.ics.forth.gr>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 7 Jun 2021 08:04:40 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTpSbNWS4VLHAu4XsV5-Vos=6R9MmPOx8-yzMFJu=wX4A@mail.gmail.com>
Message-ID: <CAJF2gTTpSbNWS4VLHAu4XsV5-Vos=6R9MmPOx8-yzMFJu=wX4A@mail.gmail.com>
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

On Mon, Jun 7, 2021 at 2:14 AM Nick Kossifidis <mick@ics.forth.gr> wrote:
>
> =CE=A3=CF=84=CE=B9=CF=82 2021-05-20 04:45, Guo Ren =CE=AD=CE=B3=CF=81=CE=
=B1=CF=88=CE=B5:
> > On Wed, May 19, 2021 at 2:53 PM Christoph Hellwig <hch@lst.de> wrote:
> >>
> >> On Tue, May 18, 2021 at 11:44:35PM -0700, Drew Fustini wrote:
> >> > This patch series looks like it might be useful for the StarFive JH7=
100
> >> > [1] [2] too as it has peripherals on a non-coherent interconnect. GM=
AC,
> >> > USB and SDIO require that the L2 cache must be manually flushed afte=
r
> >> > DMA operations if the data is intended to be shared with U74 cores [=
2].
> >>
> >> Not too much, given that the SiFive lineage CPUs have an uncached
> >> window, that is a totally different way to allocate uncached memory.
> > It's a very big MIPS smell. What's the attribute of the uncached
> > window? (uncached + strong-order/ uncached + weak, most vendors still
> > use AXI interconnect, how to deal with a bufferable attribute?) In
> > fact, customers' drivers use different ways to deal with DMA memory in
> > non-coherent SOC. Most riscv SOC vendors are from ARM, so giving them
> > the same way in DMA memory is a smart choice. So using PTE attributes
> > is more suitable.
> >
> > See:
> > https://github.com/riscv/virtual-memory/blob/main/specs/611-virtual-mem=
ory-diff.pdf
> > 4.4.1
> > The draft supports custom attribute bits in PTE.
> >
>
> Not only it doesn't support custom attributes on PTEs:
>
> "Bits63=E2=80=9354 are reserved for future standard use and must be zeroe=
d by
> software for forward compatibility."
>
> It also goes further to say that:
>
> "if any of these bits are set, a page-fault exception is raised"

In RISC-V VM TG, A C-bit discussion is raised. So it's a comm idea to
support it.

Let Linux support custom PTE attributes won't get any side effect in practi=
ce.

IMO:
We needn't waste a bit in PTE, but the custom idea in PTE reserved
bits is necessary. Because Allwinner D1 needs custom PTE bits in
reserved bits to work around.
So I recommend just remove the "C" bit in PTE, but allow vendors to
define their own PTE attributes in reserved bits. I've found a way to
compact different PTE attributes of different vendors during the Linux
boot stage. That means we still could use One Image for all vendors in
Linux



--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
