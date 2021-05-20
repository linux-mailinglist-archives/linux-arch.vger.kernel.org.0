Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330C3389B05
	for <lists+linux-arch@lfdr.de>; Thu, 20 May 2021 03:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbhETBrT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 May 2021 21:47:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:36236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229808AbhETBrT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 May 2021 21:47:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 173306023C;
        Thu, 20 May 2021 01:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621475159;
        bh=QVDdQASuS8d9nfiPodUILwkkCeDcq435J2Gdpya1/ks=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aph4t/OpytN2td2rihSkPJpvAJmj3uRO97MpUkypnltNuu65Hws5hw0roDgsvXnoe
         C1rB8CAqcXJeDT4LXV44wliD6TUvEB5QZKJhEo0nKPvqU2Yg75uf/qKgwz66wnE+83
         V8Oenk4Kv29uKcK56VKcJAN0cxw4AfW2JNBjtM8DCYH2Wr3nQEHgHQBPB0A4Wl1IHP
         A4B6iKVTsPD6rAhRBh02GZ3LYknkrvap1HdQLSa81EH8egwbdYSLzcObSKu2bHhIyM
         NW3kdhC4/S8F4G1/xtDqCPZVVcyLr/Gd3YI+TWCkMfNpQwHe4EdeZ/tywUm+dXO9Za
         OJ6M2+obNBfPQ==
Received: by mail-lf1-f52.google.com with SMTP id v8so16979995lft.8;
        Wed, 19 May 2021 18:45:58 -0700 (PDT)
X-Gm-Message-State: AOAM530n/RtSz1pAZYdux+cz+jcI2SBE8e1XTHLWiwWOMRTqpjQkbxJd
        AjA3l7Td5r9j5MlNbpnKZF9lrGNs1Tv/Vxn94dI=
X-Google-Smtp-Source: ABdhPJxvtxM93jgsgXbzFfEJugjs4lSYYrFCIibVxmW1z4FBvYEZG3re1CeFqZabsg3qTIpZ9JXvpLiBbrRPU2sVGHY=
X-Received: by 2002:a19:ccc:: with SMTP id 195mr1668868lfm.24.1621475157363;
 Wed, 19 May 2021 18:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <1621400656-25678-1-git-send-email-guoren@kernel.org>
 <20210519052048.GA24853@lst.de> <CAJF2gTTjwB4U-NxCtfgMA5aR2HzoQtA8a51W5UM1LHGRbjz9pg@mail.gmail.com>
 <20210519064435.GA3076809@x1> <20210519065352.GA31590@lst.de>
In-Reply-To: <20210519065352.GA31590@lst.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 20 May 2021 09:45:45 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR4FXRbp7oky-ypdVJba6btFHpp-+dPyJStRaQX_-5rzg@mail.gmail.com>
Message-ID: <CAJF2gTR4FXRbp7oky-ypdVJba6btFHpp-+dPyJStRaQX_-5rzg@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] riscv: Add DMA_COHERENT support
To:     Christoph Hellwig <hch@lst.de>
Cc:     Drew Fustini <drew@beagleboard.org>,
        Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>, wefu@redhat.com,
        lazyparser@gmail.com,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Benjamin Koch <snowball@c3pb.de>,
        Matteo Croce <mcroce@linux.microsoft.com>,
        Wei Fu <tekkamanninja@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 19, 2021 at 2:53 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, May 18, 2021 at 11:44:35PM -0700, Drew Fustini wrote:
> > This patch series looks like it might be useful for the StarFive JH7100
> > [1] [2] too as it has peripherals on a non-coherent interconnect. GMAC,
> > USB and SDIO require that the L2 cache must be manually flushed after
> > DMA operations if the data is intended to be shared with U74 cores [2].
>
> Not too much, given that the SiFive lineage CPUs have an uncached
> window, that is a totally different way to allocate uncached memory.
It's a very big MIPS smell. What's the attribute of the uncached
window? (uncached + strong-order/ uncached + weak, most vendors still
use AXI interconnect, how to deal with a bufferable attribute?) In
fact, customers' drivers use different ways to deal with DMA memory in
non-coherent SOC. Most riscv SOC vendors are from ARM, so giving them
the same way in DMA memory is a smart choice. So using PTE attributes
is more suitable.

See: https://github.com/riscv/virtual-memory/blob/main/specs/611-virtual-memory-diff.pdf
4.4.1
The draft supports custom attribute bits in PTE.

Although I do not agree with uncached windows, this patchset does not
conflict with SiFive uncached windows.

>
> > There is the RISC-V Cache Management Operation, or CMO, task group [3]
> > but I am not sure if that can help the SoC's that have already been
> > fabbed like the the D1 and the JH7100.
>
> It does, because unimplemented instructions trap into M-mode, where they
> can be emulated.
>
> Or to summarize things.  Non-coherent DMA (and not coherent as title in
> this series) requires two things:
>
>  1) allocating chunks of memory that is marked as not cachable
>  2) instructions to invalidate and/or writeback cache lines
Maybe sbi_ecall (dma_sync) is enough and let the vendor deal with it
in opensbi. From a hardware view, CMO instruction only could deal with
one cache line, then CMO-trap is not a good idea.

>
> none of which currently exists in RISV-V.  Hacking vendor specific
> cruft into the kernel doesn't scale, as shown perfectly by this
> series which requires to hard code vendor-specific non-standardized
> extensions in a kernel that makes it specific to that implementation.
>
> What we need to do is to standardize a way to do this properly, and then
> after that figure out a way to quirk in non-compliant implementations
> in a way that does not harm the general kernel.


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
