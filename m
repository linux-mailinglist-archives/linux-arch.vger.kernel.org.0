Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70DDE40F27D
	for <lists+linux-arch@lfdr.de>; Fri, 17 Sep 2021 08:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhIQGhx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Sep 2021 02:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhIQGhw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Sep 2021 02:37:52 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4CCC061574;
        Thu, 16 Sep 2021 23:36:31 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id t19so3290342vkk.2;
        Thu, 16 Sep 2021 23:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9St3W9ubimN8L6gZQXG874m9f14pnm3rcTIuDrdphRI=;
        b=U38WWX4gXkeSr5qdQReZ9TZU9+KbpSFhxt0X0RgRtW+XOpM6ycOGqFmmmxXLHbsB8k
         gTRypsl9BO767n5szrJaW6TA+SJndMspx0+zV+g7zjAUWXDbqLpSwOQI7H/0BeMJLY/J
         nkjnZ3c3D4p69iU34JmahdKpeHBi/JKUyzK51OMWC2JMoXj9AUrF6XmktayFS4VU83q5
         qWq3jW8rSVpWulee/GRlbx55ls6Fe9auE5Fc1A5ffMO278isgL4ZzNyu2fD/IS+QMzcX
         tGPCx3G8ATArjx1h2JqaJzHOioMIGHYR24wjg9M2r9topGdtml0Mh/JsBHS2iMnCGDlu
         VO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9St3W9ubimN8L6gZQXG874m9f14pnm3rcTIuDrdphRI=;
        b=w7qLMUQ/qZoiANcODdSrtKAQhaQ2dl/WRrBrEhfgskwBeOzefc9g2Ka2saoTQLGCFm
         FF32YphhA0cCcqfugQisH+5dOEQ97057BxL01IaOjkyYAUUksDzY5kb/Kt8hmbFJxNza
         8HNn8DM6MHF+KTmKWz5Bi0fhKD62s6pN3MlkiHAwrP/9RweoaoD0vTNncXku1w3KqB4w
         SstHkRE8Sv4DxcagpJbLAaHuiyzO9qCq6GFHlMJaqYSsCydFbdinDrDIWhhA6xA1wHxy
         OyABoVN7smuUxRJAj7Ff5tqOGbD+jH13uXqBZHdVUVlalidJdorXJhy5Y7fTulxOAT76
         MCoA==
X-Gm-Message-State: AOAM533VVq+1c8UhnWzJLR7hKl/kplZbSVCBFt8xhPKxn4YY3YtW8hPA
        gt0AXmwINtiGszNuktwmfxLNY0cfERVKR0phCHlW95EEvNM=
X-Google-Smtp-Source: ABdhPJxw1efKocc+2TzyC2YelrNEWZq0maTFU8QbYTgXCcvBVuZ851H3D4vO21DuwpyweEpCYVlWtlhmQ4VyRnZs85Q=
X-Received: by 2002:a1f:1283:: with SMTP id 125mr7070315vks.2.1631860590393;
 Thu, 16 Sep 2021 23:36:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210917035736.3934017-1-chenhuacai@loongson.cn>
 <20210917035736.3934017-17-chenhuacai@loongson.cn> <YUQxUgN5AseF7k8F@infradead.org>
In-Reply-To: <YUQxUgN5AseF7k8F@infradead.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Fri, 17 Sep 2021 14:36:18 +0800
Message-ID: <CAAhV-H5jE6RdiLm2PZ=3K+dKXcLay+4B1qZx1jQMBJcQM0hHAQ@mail.gmail.com>
Subject: Re: [PATCH V3 16/22] LoongArch: Add misc common routines
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Christoph,

On Fri, Sep 17, 2021 at 2:12 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> > +
> > +/*
> > + * Change "struct page" to physical address.
> > + */
> > +#define page_to_phys(page)   ((dma_addr_t)page_to_pfn(page) << PAGE_SHIFT)
>
> Why is this using a dma_addr_t?  phys_addr_t would be the right type
> here.
Sorry, this is a mistake, I will change to phys_addr_t.

>
> > +
> > +extern void __init __iomem *early_ioremap(u64 phys_addr, unsigned long size);
> > +extern void __init early_iounmap(void __iomem *addr, unsigned long size);
> > +
> > +#define early_memremap early_ioremap
> > +#define early_memunmap early_iounmap
> > +
> > +static inline void __iomem *ioremap_prot(phys_addr_t offset, unsigned long size,
> > +                                      unsigned long prot_val)
> > +{
> > +     if (prot_val == _CACHE_CC)
> > +             return (void __iomem *)(unsigned long)(CAC_BASE + offset);
> > +     else
> > +             return (void __iomem *)(unsigned long)(UNCAC_BASE + offset);
> > +}
>
> There is no real need for this ioremap_prot multiplexer
>
> > +/*
> > + * ioremap_cache -  map bus memory into CPU space
> > + * @offset:      bus address of the memory
> > + * @size:        size of the resource to map
> > + *
> > + * ioremap_cache performs a platform specific sequence of operations to
> > + * make bus memory CPU accessible via the readb/readw/readl/writeb/
> > + * writew/writel functions and the other mmio helpers. The returned
> > + * address is not guaranteed to be usable directly as a virtual
> > + * address.
> > + *
> > + * This version of ioremap ensures that the memory is marked cachable by
> > + * the CPU.  Also enables full write-combining.       Useful for some
> > + * memory-like regions on I/O busses.
> > + */
> > +#define ioremap_cache(offset, size)                          \
> > +     ioremap_prot((offset), (size), _CACHE_CC)
>
> Please don't add ioremap_cache to new ports.
I found there are several call sites in drivers, and I think they
really need a cacheable map.

Huacai
