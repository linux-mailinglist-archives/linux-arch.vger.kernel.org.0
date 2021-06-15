Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63DA23A7A7F
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jun 2021 11:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhFOJap (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Jun 2021 05:30:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:53974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230242AbhFOJao (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 15 Jun 2021 05:30:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE92261433;
        Tue, 15 Jun 2021 09:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623749320;
        bh=j5S6FfkLlDjYfSjyx+hqYrqgXmhxauWUu0zvHyqD00k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a3KhUZlHloUuEb42snthxC1h+pJDOlnHi4MWxz/lgwZ17fOZVYJQHYIxl/roiHKnx
         i1HWHDotfuPDtd2w7T0yAaaMFKUH89b3Z/e6rXVJ441KfI+GHtCmljbYFhO+YRfOwX
         r+NOcgcG1vXMCYCJ6KZrCUKvSY6IcM2EmBXWUtKCGl/TRYnWZ9ta83SdB1hzOeE+GT
         uHmwgfh4kYvx5DdAA/YmGp0VSzsLQL7SGmG1UKVHbnOgLox7m/4/4eSH0AZ9tBQPRz
         7MjjryBFnUdzRNu7dQoUgvHjb5fziEH/oG1u0MjVBINp2njjb09eVJOmCQ5D8bAipA
         q8aXQxOuXGrWw==
Received: by mail-lf1-f49.google.com with SMTP id x24so20285907lfr.10;
        Tue, 15 Jun 2021 02:28:40 -0700 (PDT)
X-Gm-Message-State: AOAM530sw9Q7BPkydwFrLbYZDalstZ1QxGhJVRZ5G0fo4kyQ3M2Ad8dI
        GAjn2CvO4Pj2g1j6/2LZzwtVS40Tarlngi/+ev4=
X-Google-Smtp-Source: ABdhPJzNz1ykPpmEfVQJ9wH1ea7bPl9WQPbFKW5ePg0Hnp7r2VMDIEQIjgiBB4veo+d3GAXdlMX6TxF51nDUbucH0sk=
X-Received: by 2002:a05:6512:3d13:: with SMTP id d19mr14982734lfv.41.1623749319009;
 Tue, 15 Jun 2021 02:28:39 -0700 (PDT)
MIME-Version: 1.0
References: <1623693067-53886-1-git-send-email-guoren@kernel.org>
 <1623693067-53886-3-git-send-email-guoren@kernel.org> <CAAhSdy2NTw2fHmCztXHXi+FExC12qHH0nziO7wuHOp+Ufk08KA@mail.gmail.com>
In-Reply-To: <CAAhSdy2NTw2fHmCztXHXi+FExC12qHH0nziO7wuHOp+Ufk08KA@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 15 Jun 2021 17:28:27 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT8BFyCNP4OtAaQLDYCPH+v5w5o3u02g9pQbBaE=kA_mw@mail.gmail.com>
Message-ID: <CAJF2gTT8BFyCNP4OtAaQLDYCPH+v5w5o3u02g9pQbBaE=kA_mw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/2] riscv: pgtable: Add "PBMT" extension supported
To:     Anup Patel <anup@brainfault.org>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Drew Fustini <drew@beagleboard.org>,
        liush <liush@allwinnertech.com>,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        wefu@redhat.com, linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>,
        Daniel Lustig <dlustig@nvidia.com>,
        Greg Favor <gfavor@ventanamicro.com>,
        Andrea Mondelli <andrea.mondelli@huawei.com>,
        Jonathan Behrens <behrensj@mit.edu>,
        Xinhaoqu <xinhaoqu@huawei.com>,
        Bill Huffman <huffman@cadence.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Allen Baum <allen.baum@esperantotech.com>,
        Josh Scheid <jscheid@ventanamicro.com>,
        Richard Trauben <rtrauben@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 15, 2021 at 12:11 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Mon, Jun 14, 2021 at 11:22 PM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > "PBMT" - Page-Based Memory Types (see Link for detail), current it
> > has defined 3 memory types [62:61] in PTE:
> >  - WB 00 "Cacheable 'main memory'"
> >  - NC 01 "Noncacheable 'main memory'"
> >  - IO 11 "Non-cacheable non-idempotent 'I/O'"
> >
> > The patch not only implements the current PBMT extension but also
> > considers future scalability. It uses 3 words of image header to
> > store 8 memory types' values plus a mask value. That means there
> > are still 5 memory types reserved for future scalability.
>
> This is the worst work-around to the Linux RISC-V patch acceptance
> policy.
>
> Passing PTE attributes in the Linux Image header means boot-loaders
> will have to update the image header before jumping to Linux kernel.
> Basically, this is changing the Linux boot-process by adding platform
> specific image header updation step.
>
> Further, this patch is doing too many things in one-go. I needs to be
> broken down into smaller fine-grained patches.
Next time, I'll separate it into below patches:
 - riscv: pgtable: Fixup _PAGE_CHG_MASK usage
 - riscv: pgtable: Add "PBMT" extension supported
 - riscv: pgtable: Add vendor custom "PBMT" definitions interface
How?

>
> I totally disapprove of this patch in it's current shape since the
> Linux boot-protocol should not have any platform specific part.
I think you mean we shouldn't modify the uImage header.

How about parsing dtb before setup_vm (It's a very early stage before
mmu enabled)?  eg:
        cpus {
                ...
                rv64-pbmt-extension;
                rv64-pbmt-custom-remapping = <[mask] [type0] [type1] [type2]>;

>
> Also, please don't CC RVI mailing list for Linux patches because
> the people can post to RVI mailing list only by joining it.
Okay, I'll remove the RVI mailing list. If I needed to, I would send a
notification email to RVI separately.

--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
