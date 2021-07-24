Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEC43D47B9
	for <lists+linux-arch@lfdr.de>; Sat, 24 Jul 2021 14:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbhGXMNb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 24 Jul 2021 08:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbhGXMNa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 24 Jul 2021 08:13:30 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85A5C061575
        for <linux-arch@vger.kernel.org>; Sat, 24 Jul 2021 05:54:01 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id y4so4161564ilp.0
        for <linux-arch@vger.kernel.org>; Sat, 24 Jul 2021 05:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZyOIlq8/8a4/YnCKJrblDpGpsH2SIGB/DCRjiBWPi5E=;
        b=EJD+vUp2jo6CEl6vSDVCDJ8EpjX3Iom2tM5Y4djjQBYWAbTmQU2bV8D5dDdeqoBpU+
         wbecwFeq2DHrI1oTAEy3wtOTBoMwZ9FBDkBD5vvxkRKVVyKIbVlLGIuwmXDPYJfS4D22
         ZFOmMIYBBzCOAPsIOGIiG4SKeXlZi01kUtGIQyjaVIKLEdndzTFp/8/11CMhEMp1aG14
         CLblEq7KcybhJZ/wTWHvmAj3WfoXcPMkUztLwNaiEyrlfM32kwW5I5qgOYhC8GxniVOG
         /DynnGKthVuVYs/mBxXgDocsThbvSwfOkM/JhVBMcd+g0/YrWmcULVneiv3H7HSFHQn+
         6sSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZyOIlq8/8a4/YnCKJrblDpGpsH2SIGB/DCRjiBWPi5E=;
        b=l3iKjcBJBj8UlFEkgv7ueDsaHh9aqasia48az1HGzigniOT6NqUDPksplfs6UIHAZC
         +88OHPYRDSLCa/qBGIp3ZjExkBMusvLijSfO2+RK+7MNHZQiL1oDkJqzPHw1aqNFiJf2
         cuUPo/F7cFdKG4lntovQu0OedDDuji6J8msg3EQ7nfTBvHYSoUdtw1x8zuwIiAWvSPaU
         pziVsmRyzm5XXpnDIfPKgtmwW9/SG9KCCLfFFyoQAw8ZuzN1rII7ebDrPUlt0hBHe0+F
         xkuUtjzcDEMqBaE93JHyYvUnSTG9vpvT8FcR6Gr5fnQ8NPdO9WeGj0nF2+aZxy2Z2rzJ
         gqpA==
X-Gm-Message-State: AOAM530puR5gaxms78MnaLLe4QeVJF2V20BbFNf/eHw/7QUoi2+vDe3q
        7VVbgCOzuCFyWznh4mvHaDzzasf7PJ8i88gRVos=
X-Google-Smtp-Source: ABdhPJwDiQe03SdhCb/t7yVqfbbKFXjk5BIWUGbzKriFOKGajXPNHx5GzyY35XOT8UC/dd5+x3EFUa4T1SZLVIWptXA=
X-Received: by 2002:a92:cb52:: with SMTP id f18mr6701120ilq.97.1627131241327;
 Sat, 24 Jul 2021 05:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-13-chenhuacai@loongson.cn> <CAK8P3a0+jk=09mGdnWu9c+JWkwDKM+ffv=QvJs2uMY7WOg85AQ@mail.gmail.com>
 <CAAhV-H6PDr=YZdc=2NJ6hceE7HoKB-WcUHi3GEgtfO8nbxOV3g@mail.gmail.com> <CAK8P3a02R988LdN4Cshhp=sAnwKS+GOwwWwRfvprm36eTb2YqQ@mail.gmail.com>
In-Reply-To: <CAK8P3a02R988LdN4Cshhp=sAnwKS+GOwwWwRfvprm36eTb2YqQ@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sat, 24 Jul 2021 20:53:48 +0800
Message-ID: <CAAhV-H4r1hUOxFek8_tKTO8kKfiTyzxi0QpqEn67=O_f2SxYJQ@mail.gmail.com>
Subject: Re: [PATCH 12/19] LoongArch: Add misc common routines
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Arnd,

On Fri, Jul 23, 2021 at 7:43 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Jul 23, 2021 at 12:41 PM Huacai Chen <chenhuacai@gmail.com> wrote:
> > On Tue, Jul 6, 2021 at 6:22 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > > > +static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
> > > > +                                     unsigned long new, unsigned int size)
> > > > +{
> > > > +       switch (size) {
> > > > +       case 1:
> > > > +       case 2:
> > > > +               return __cmpxchg_small(ptr, old, new, size);
> > >
> > > Same here.
> >
> > 16bit cmpxchg is used by qspinlock. Yes, you suggest we should not use
> > qspinlock, but our test results show that ticket spinlock is even
> > worse... So, we want to keep cmpxchg_small() and qspinlock.
>
> Can you explain in detail how that cmpxchg loop provides the necessary
> forward progress guarantees to make qspinlock reliable?
>
> As Peter keeps pointing out, usually this is not actually the case, so
> faster-but-broken is not a replacement for a simple working version.
>
> If you already have the ticket spinlock implementation, maybe start out
> by using that for the initial submission, and then provide an extra
> patch to convert it to qspinlock as a follow-up that can be debated
> in more detail regarding correctness and performance.
After reading the existing topics on qspinlock from mail list, I have
done an offline discussion with Jiaxun Yang and Rui Wang. Then we
think that if we use the _Q_PENDING_BITS=1 definition, those archs
without sub-word xchg/cmpxchg can use qspinlock as well. Plese see my
RFC patches:
https://lore.kernel.org/linux-arch/20210724123617.3525377-1-chenhuacai@loongson.cn/T/#t

Huacai
>
> > > > +static inline void __iomem *ioremap_prot(phys_addr_t offset, unsigned long size,
> > > > +       unsigned long prot_val)
> > > > +{
> > > > +       /* This only works for !HIGHMEM currently */
> > >
> > > Do you support highmem? I would expect new architectures to no longer
> > > implement that. Just use a 64-bit kernel on systems with lots of ram.
> >
> > Emmm, 64-bit kernel doesn't need highmem.
>
> Yes, that was my point: 32-bit user space is fine if you care a lot about
> size constraints of DDR2 or older memory. For any system that has
> enough memory to require highmem, it is better to just pick a 64-bit
> kernel to start with, if the CPU allows it.
>
> > > > +#define ioremap(offset, size)                                  \
> > > > +       ioremap_prot((offset), (size), _CACHE_SUC)
> > > > +#define ioremap_uc ioremap
> > >
> > > Remove ioremap_uc(), it should never be called here.
> > It is used by lib/devres.c.
>
> There is a default implementation in include/asm-generic/io.h
> that just returns NULL here.
>
> > > > +#define __BUILD_MEMORY_SINGLE(pfx, bwlq, type)                         \
> > > > +                                                                       \
> > > > +static inline void pfx##write##bwlq(type val,                          \
> > > > +                                   volatile void __iomem *mem)         \
> > > > +{                                                                      \
> > >
> > > Please don't add another copy of these macros. Use the version from
> > > include/asm-generic, or modify it as needed if it doesn't quite work.
> >
> > On Loongson platform, we should put a wmb() before MMIO write. The
> > generic readw()/readl()/outw()/outl() have wmb(), but the __raw
> > versions don't have. I want to know what is the design goal of the
> > __raw version, are they supposed to be used in scenarios that the
> > ordering needn't be cared?
>
> The __raw versions are mainly meant for accessing memory from
> platform specific driver code. They don't provide any particular
> endianness or ordering guarantees and generally cannot be used
> in portable drivers.
>
> Note that a full wmb() should not be needed, you only have to serialize
> between prior memory accesses and a DMA triggered by the device,
> but not between multiple CPUs here.
>
>       Arnd
