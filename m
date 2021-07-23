Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFCEC3D39B5
	for <lists+linux-arch@lfdr.de>; Fri, 23 Jul 2021 13:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbhGWLDP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Jul 2021 07:03:15 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:37267 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbhGWLDO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Jul 2021 07:03:14 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M597s-1m803T1ZlU-001DD1 for <linux-arch@vger.kernel.org>; Fri, 23 Jul 2021
 13:43:47 +0200
Received: by mail-wm1-f42.google.com with SMTP id m20-20020a05600c4f54b029024e75a15716so480940wmq.2
        for <linux-arch@vger.kernel.org>; Fri, 23 Jul 2021 04:43:47 -0700 (PDT)
X-Gm-Message-State: AOAM5325+uqFY95eiuIsQbkg/SSG9I3daEnoMQq9uCQn2jk24mSKT6g8
        4AFEaMI1GEzUNQLDcfJP4PKJVCds+r0r7LKh72E=
X-Google-Smtp-Source: ABdhPJzmeuHBO9nGu8sL6IPNddEk6IBY4du6yjZ3we5158of97huB3QHDB34brQA+PTEeHB1cjCP8RfqSgzn9J+ZiJU=
X-Received: by 2002:a1c:c90f:: with SMTP id f15mr13753836wmb.142.1627040627011;
 Fri, 23 Jul 2021 04:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-13-chenhuacai@loongson.cn> <CAK8P3a0+jk=09mGdnWu9c+JWkwDKM+ffv=QvJs2uMY7WOg85AQ@mail.gmail.com>
 <CAAhV-H6PDr=YZdc=2NJ6hceE7HoKB-WcUHi3GEgtfO8nbxOV3g@mail.gmail.com>
In-Reply-To: <CAAhV-H6PDr=YZdc=2NJ6hceE7HoKB-WcUHi3GEgtfO8nbxOV3g@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 23 Jul 2021 13:43:30 +0200
X-Gmail-Original-Message-ID: <CAK8P3a02R988LdN4Cshhp=sAnwKS+GOwwWwRfvprm36eTb2YqQ@mail.gmail.com>
Message-ID: <CAK8P3a02R988LdN4Cshhp=sAnwKS+GOwwWwRfvprm36eTb2YqQ@mail.gmail.com>
Subject: Re: [PATCH 12/19] LoongArch: Add misc common routines
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
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
X-Provags-ID: V03:K1:UIiOIgdBsDfR4jfxMrnWzrey3QWi+1JQjA9mRgDblr8/dGWU5dQ
 fM5ktcleVsKZdw6somkSgj4UZAtZQ1q2YOyS+DGLys/Ol9QbZGBDuW0q11Q4f4Woj1TWQAH
 F9rwx4csB9ZL1x9pHSOBtHC6F24o40mJvTuEV2pi1QKD6fi1BcTtVS5+CdvON5H6doDa+BY
 fhvbaQGd0pvGUUBP4zXIQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DxmUaBmgsmA=:84TD1/h7rwx7JmziHa7YGO
 RU+OoHRpPJrk7DdzYUQA3RFcMnK2hhMyOJXa8iaWhaqTwIAfVodd/x7MG2dXa0yiAxWxnaAvD
 2RkcK/j531thsrvrqhLQsWNYNXtMqVEI7rceSJa1DJP9JB8/+5lHnSY9trjpR7IDgYixEpLiW
 5m4p0zLdOk6vNulx+bsQ9jKq+am9je+gDa55tQDFM9QOdZP+ZZBag4pJ5Dhsb4YK8dGLNUJNe
 t/cpQSduxnmBq/qIVlKMdF/1q/qaABOBw/GfQE8JCp2MdmtlUbntBnUBNg7wwlTxu8f2iUmub
 g4HGM00LvgavWQkuyIEAPamZurkuHCt09svvBlsHh6/+VlSkAT/sPL0w0njXoLoGMnyRQDRGx
 O/yAT7N/+OLv2hHj+w+OAJwHm4klDgUjN+0lVB9vVUwajvhklu5dYRtQsbydod6JOAhPQDj3d
 lq5WXp/Z/wniXnHlFifHVDacQkU3xF23zVXUV7eU9AoxihRthJFgglyAlozIm6ZAiB76kS4Ql
 oPiq/2L2uIlIZEv+wLJQtYgaG5r14CAWlXCEdKBn+DvN4nAjk0/nGy3l11wBiy97AUkN4xGal
 kzDZFHvPKXUsPnHp2dp4eMQrQuEN3AKWZdlFDIWdHQGdqQ+KzsZWXazokZ1DUvs+Ro0DSxmYS
 ItfdBcVJ6W77sSPMwceE9EjcEf23NdfPpaGxLL4ZCd/nTs7eZnz0hfAA7C3n5cUIGnyp8jchm
 pWZx/+OO4xSEVuh0A0xa7Drmpv1icjLjFkFD8P4yv4BRMkkcyRJVMWxO10sUs4Gtbp3lZl8pj
 ktryRTR7C1c1AC+GWTM2xNml4p2jnRkjXO/wG+PhlBjr1899MYGDcvd+v7y88yUo1xZFgXBu8
 efH/tbWZ6udLbKYB08+GuHRWx7K0euV8JgLr/RWeXpVZFGOpszim2LkZL/xWzvLdxqCONCLln
 WkJiXSH041DVknznn6VHCtuVgY9No+5FJDh0ZJdOzcuzwvNm5EXd4
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 23, 2021 at 12:41 PM Huacai Chen <chenhuacai@gmail.com> wrote:
> On Tue, Jul 6, 2021 at 6:22 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > > +static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
> > > +                                     unsigned long new, unsigned int size)
> > > +{
> > > +       switch (size) {
> > > +       case 1:
> > > +       case 2:
> > > +               return __cmpxchg_small(ptr, old, new, size);
> >
> > Same here.
>
> 16bit cmpxchg is used by qspinlock. Yes, you suggest we should not use
> qspinlock, but our test results show that ticket spinlock is even
> worse... So, we want to keep cmpxchg_small() and qspinlock.

Can you explain in detail how that cmpxchg loop provides the necessary
forward progress guarantees to make qspinlock reliable?

As Peter keeps pointing out, usually this is not actually the case, so
faster-but-broken is not a replacement for a simple working version.

If you already have the ticket spinlock implementation, maybe start out
by using that for the initial submission, and then provide an extra
patch to convert it to qspinlock as a follow-up that can be debated
in more detail regarding correctness and performance.

> > > +static inline void __iomem *ioremap_prot(phys_addr_t offset, unsigned long size,
> > > +       unsigned long prot_val)
> > > +{
> > > +       /* This only works for !HIGHMEM currently */
> >
> > Do you support highmem? I would expect new architectures to no longer
> > implement that. Just use a 64-bit kernel on systems with lots of ram.
>
> Emmm, 64-bit kernel doesn't need highmem.

Yes, that was my point: 32-bit user space is fine if you care a lot about
size constraints of DDR2 or older memory. For any system that has
enough memory to require highmem, it is better to just pick a 64-bit
kernel to start with, if the CPU allows it.

> > > +#define ioremap(offset, size)                                  \
> > > +       ioremap_prot((offset), (size), _CACHE_SUC)
> > > +#define ioremap_uc ioremap
> >
> > Remove ioremap_uc(), it should never be called here.
> It is used by lib/devres.c.

There is a default implementation in include/asm-generic/io.h
that just returns NULL here.

> > > +#define __BUILD_MEMORY_SINGLE(pfx, bwlq, type)                         \
> > > +                                                                       \
> > > +static inline void pfx##write##bwlq(type val,                          \
> > > +                                   volatile void __iomem *mem)         \
> > > +{                                                                      \
> >
> > Please don't add another copy of these macros. Use the version from
> > include/asm-generic, or modify it as needed if it doesn't quite work.
>
> On Loongson platform, we should put a wmb() before MMIO write. The
> generic readw()/readl()/outw()/outl() have wmb(), but the __raw
> versions don't have. I want to know what is the design goal of the
> __raw version, are they supposed to be used in scenarios that the
> ordering needn't be cared?

The __raw versions are mainly meant for accessing memory from
platform specific driver code. They don't provide any particular
endianness or ordering guarantees and generally cannot be used
in portable drivers.

Note that a full wmb() should not be needed, you only have to serialize
between prior memory accesses and a DMA triggered by the device,
but not between multiple CPUs here.

      Arnd
