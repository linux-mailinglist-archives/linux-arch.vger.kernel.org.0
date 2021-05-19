Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602713887D4
	for <lists+linux-arch@lfdr.de>; Wed, 19 May 2021 08:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhESGzQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 May 2021 02:55:16 -0400
Received: from verein.lst.de ([213.95.11.211]:36955 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231147AbhESGzQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 May 2021 02:55:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C1D4B67373; Wed, 19 May 2021 08:53:52 +0200 (CEST)
Date:   Wed, 19 May 2021 08:53:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Drew Fustini <drew@beagleboard.org>
Cc:     Guo Ren <guoren@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>, wefu@redhat.com,
        lazyparser@gmail.com,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>,
        paul.walmsley@sifive.com, Nick Kossifidis <mick@ics.forth.gr>,
        Benjamin Koch <snowball@c3pb.de>,
        Matteo Croce <mcroce@linux.microsoft.com>,
        Wei Fu <tekkamanninja@gmail.com>
Subject: Re: [PATCH RFC 0/3] riscv: Add DMA_COHERENT support
Message-ID: <20210519065352.GA31590@lst.de>
References: <1621400656-25678-1-git-send-email-guoren@kernel.org> <20210519052048.GA24853@lst.de> <CAJF2gTTjwB4U-NxCtfgMA5aR2HzoQtA8a51W5UM1LHGRbjz9pg@mail.gmail.com> <20210519064435.GA3076809@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519064435.GA3076809@x1>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 18, 2021 at 11:44:35PM -0700, Drew Fustini wrote:
> This patch series looks like it might be useful for the StarFive JH7100
> [1] [2] too as it has peripherals on a non-coherent interconnect. GMAC,
> USB and SDIO require that the L2 cache must be manually flushed after
> DMA operations if the data is intended to be shared with U74 cores [2].

Not too much, given that the SiFive lineage CPUs have an uncached
window, that is a totally different way to allocate uncached memory.

> There is the RISC-V Cache Management Operation, or CMO, task group [3]
> but I am not sure if that can help the SoC's that have already been
> fabbed like the the D1 and the JH7100.

It does, because unimplemented instructions trap into M-mode, where they
can be emulated.

Or to summarize things.  Non-coherent DMA (and not coherent as title in
this series) requires two things:

 1) allocating chunks of memory that is marked as not cachable
 2) instructions to invalidate and/or writeback cache lines

none of which currently exists in RISV-V.  Hacking vendor specific
cruft into the kernel doesn't scale, as shown perfectly by this
series which requires to hard code vendor specific non-standardized
extensions in a kernel that makes it specific to that implementation.

What we need to do is to standardize a way to do this properly, and then
after that figure out a way to quirk in non-compliant implementations
in a way that does not harm the general kernel.
