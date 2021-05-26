Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4A2390EBA
	for <lists+linux-arch@lfdr.de>; Wed, 26 May 2021 05:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhEZDOY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 May 2021 23:14:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230075AbhEZDOX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 May 2021 23:14:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0AA9A6113D;
        Wed, 26 May 2021 03:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621998773;
        bh=MXpvYaTxrBbMYL5TsCq9ZgmO4Fjlx82C4mGQi4aVHMQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RDS16tZOAnUn3k9cCdeS2YltDG71HjGjF6DshnjdQerRxKvMbluLiTGgeKMxti/HG
         7aKfQDnvbRY3cSrRZK+yXr6iuD8WR5/SRnfFqMSe44afXIsBS2Z1t6xEXTYCDPBATs
         E87XsLrS8I6B0/n3jVVRThZrNOUSRVY3D/qk2yfygT2s7KZpyKz9VDAKsBZTLZ7Aoo
         +3xGTx54NhFKpj3TJdNXy3znpnsv8gv6jYMUh+Owo7BDQfeHqo1LpBAgKoCTvfddYy
         6EhEnBQaMhzLO5EfCyV9KgzVCtYPjHNWJ1lPNjwbaVRqJUAXpbjwkTLUbJd303vhgd
         V5ksjA8Rh0m6g==
Received: by mail-lf1-f51.google.com with SMTP id i9so249783lfe.13;
        Tue, 25 May 2021 20:12:52 -0700 (PDT)
X-Gm-Message-State: AOAM532hlIGlshwFJ+CMiVID0z+98Fenj6g8IBslvaCpYOyW/+oVAkQQ
        lpZNQ5CeQPYdWqnrTX8ERvzpeImVieamVgTsk+U=
X-Google-Smtp-Source: ABdhPJxKd0AZEQrvaUMDv5kZQPzNDqbPCo1Mhq9I+ttONfouWDsr+H6nCx4ue2MWBb0o0jMYAc3c4zelSHKaO+tByNU=
X-Received: by 2002:a19:c49:: with SMTP id 70mr579450lfm.555.1621998771385;
 Tue, 25 May 2021 20:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <1621945447-38820-1-git-send-email-guoren@kernel.org>
 <1621945447-38820-3-git-send-email-guoren@kernel.org> <20210525123556.GB4842@lst.de>
In-Reply-To: <20210525123556.GB4842@lst.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 26 May 2021 11:12:40 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSa3LJKTRBv6NOvg0HtoKPL-5YyP6wY2=AJhQtAZwBBzg@mail.gmail.com>
Message-ID: <CAJF2gTSa3LJKTRBv6NOvg0HtoKPL-5YyP6wY2=AJhQtAZwBBzg@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] riscv: Use use_asid_allocator flush TLB
To:     Christoph Hellwig <hch@lst.de>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 25, 2021 at 8:35 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, May 25, 2021 at 12:24:07PM +0000, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Use static_branch_unlikely(&use_asid_allocator) to keep the origin
> > tlb flush style, so it's no effect on the existing machine. Here
> > are the optimized functions:
> >  - flush_tlb_mm
> >  - flush_tlb_page
> >  - flush_tlb_range
> >
> > All above are based on the below new implement functions:
> >  - __sbi_tlb_flush_range_asid
> >  - local_flush_tlb_range_asid
>
>
> This mentiones what functions you're changing, but not what the
> substantial change is, and more importantly why you change it.
>
> > +static inline void local_flush_tlb_range_asid(unsigned long start, unsigned long size,
> > +                                           unsigned long asid)
>
> Crazy long line.  Should be:
>
> static inline void local_flush_tlb_range_asid(unsigned long start,
>                 unsigned long size, unsigned long asid)
>
> > +{
> > +     unsigned long tmp = start & PAGE_MASK;
> > +     unsigned long end = ALIGN(start + size, PAGE_SIZE);
> > +
> > +     if (size == -1) {
> > +             __asm__ __volatile__ ("sfence.vma x0, %0" : : "r" (asid) : "memory");
> > +             return;
>
> Please split the global (size == -1) case into separate helpers.
Do you mean:
        if (size == -1) {
                __asm__ __volatile__ ("sfence.vma x0, %0"
                                :
                                : "r" (asid)
                                : "memory");
        } else {
                for (tmp = start & PAGE_MASK; tmp < end; tmp += PAGE_SIZE) {
                        __asm__ __volatile__ ("sfence.vma %0, %1"
                                        :
                                        : "r" (tmp), "r" (asid)
                                        : "memory");
                        tmp += PAGE_SIZE;
                }
        }

>
> > +     while(tmp < end) {
>
> Missing whitespace befre the (.
>
> Also I think this would read nicer as:
>
>         for (tmp = start & PAGE_MASK; tmp < end; tmp += PAGE_SIZE)
>
> > +static void __sbi_tlb_flush_range_asid(struct cpumask *cmask, unsigned long start,
> > +                                    unsigned long size, unsigned long asid)
>
> Another overly long line.
>
> Also for all thee __sbi_* functions, why the __ prefix?
I just follow the previous coding convention by __sbi_tlb_flush_range.
If you don't like it, I think it should be another coding convention
patchset.
This patchset is only to add the functions of tlb_flush_with_asid.

>
> > +     if (cpumask_any_but(cmask, cpuid) >= nr_cpu_ids) {
> > +             local_flush_tlb_range_asid(start, size, asid);
> > +     } else {
> > +             riscv_cpuid_to_hartid_mask(cmask, &hmask);
> > +             sbi_remote_sfence_vma_asid(cpumask_bits(&hmask), start, size, asid);
>
> Another long line (and a few more later).



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
