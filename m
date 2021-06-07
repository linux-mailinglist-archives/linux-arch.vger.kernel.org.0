Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C486D39D521
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jun 2021 08:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbhFGGnS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Jun 2021 02:43:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:59402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbhFGGnS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Jun 2021 02:43:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A7CF26121E;
        Mon,  7 Jun 2021 06:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623048087;
        bh=WJHQdy4sxhvqgS0MC5lUqEPV39/gM84OpLAauZzAMsQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=miti1pGf4X8JSTw+5bAKnmC6J/Oj62GADAh/qU5LGizT3e/mguJHZYM/HqQjB9JIC
         kYOIigfg/o2c0kby0ih2HYmQpm24HYwopDiL3sUY0tLTvmmNznCaAsgxm9GLV4Mbis
         mZqLvmGJc7YlE5ocLu7KjJC0SKVop1urwUZyAaQHglZKXQnQTyz1DsATFehEIwFyv3
         UjfoQ5iT8ItqzGwLGejyyPOHpU5BdHQGHEMs4OdvfqtyUQhg/N/R4GEYNMQJGqzZjk
         6UyPivlChb4tunck8+dpZSp+s8/dW/A9h/CokwsPzzfa40Gn2ysp0dFXDHvrn2f+dr
         8QEa7lrAA4jAA==
Received: by mail-lf1-f51.google.com with SMTP id v22so23103384lfa.3;
        Sun, 06 Jun 2021 23:41:27 -0700 (PDT)
X-Gm-Message-State: AOAM532VbGqkfmPt5AnfBI5y5u/+q90dviPrAoYCGpsKtV2PWb9PpYkw
        nDdCzppWJfU8BdsjCXxn9l1M57Io8QqyLh+cCjo=
X-Google-Smtp-Source: ABdhPJzQw6LHnGrCaA99WogkWxVtNvLnTm9mlFy3domKzPtpc2G5ul39vIh3zn+wlblu5LdVLL4Gofw9oNvf17vVTj0=
X-Received: by 2002:a05:6512:987:: with SMTP id w7mr10846468lft.41.1623048085938;
 Sun, 06 Jun 2021 23:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <1621400656-25678-1-git-send-email-guoren@kernel.org>
 <20210519052048.GA24853@lst.de> <CAJF2gTTjwB4U-NxCtfgMA5aR2HzoQtA8a51W5UM1LHGRbjz9pg@mail.gmail.com>
 <20210519064435.GA3076809@x1> <20210519065352.GA31590@lst.de>
 <CAJF2gTR4FXRbp7oky-ypdVJba6btFHpp-+dPyJStRaQX_-5rzg@mail.gmail.com>
 <29733b0931d9dd6a2f0b6919067c7efe@mailhost.ics.forth.gr> <CAJF2gTTpSbNWS4VLHAu4XsV5-Vos=6R9MmPOx8-yzMFJu=wX4A@mail.gmail.com>
 <a8f2e68dcc1a6eb1ff3b95fcb8d0d0d2@mailhost.ics.forth.gr> <CAJF2gTQuQ5bE6HeGSoNaDynA0o3+KEo4snwft42YGzE=+DjKOQ@mail.gmail.com>
 <20210607062701.GB24060@lst.de>
In-Reply-To: <20210607062701.GB24060@lst.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 7 Jun 2021 14:41:14 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRZuER5YbTD=0xWLU0Np6eD8L_z3rZH0i_WXgENUD3nbQ@mail.gmail.com>
Message-ID: <CAJF2gTRZuER5YbTD=0xWLU0Np6eD8L_z3rZH0i_WXgENUD3nbQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] riscv: Add DMA_COHERENT support
To:     Christoph Hellwig <hch@lst.de>
Cc:     Nick Kossifidis <mick@ics.forth.gr>,
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
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 7, 2021 at 2:27 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Jun 07, 2021 at 11:19:03AM +0800, Guo Ren wrote:
> > >From Linux non-coherency view, we need:
> >  - Non-cache + Strong Order PTE attributes to deal with drivers' DMA descriptors
> >  - Non-cache + weak order to deal with framebuffer drivers
> >  - CMO dma_sync to sync cache with DMA devices
>
> This is not strictly true.  At the very minimum you only need cache
> invalidation and writeback instructions.  For example early parisc
> CPUs and some m68knommu SOCs have no support for uncached areas at all,
> and Linux works.  But to be fair this is very painful and supports only
> very limited periphals.  So for modern full Linux support some uncahed
> memory is advisable.  But that doesn't have to be using PTE attributes.
> It could also be physical memory regions that are either totally fixed
Double/Triple the size of physical memory regions can't be accepted by
SOC vendors, because it wastes HW resources.
Some cost-down soc interconnects only have 32bit~34bit width of
physical address, are you sure you could force them to expand it? (I
can't)

> or somewhat dynamic.
How can HW implement with dynamic modifying PMA? What's the granularity?



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
