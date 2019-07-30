Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4887AC2C
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2019 17:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbfG3PWU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Jul 2019 11:22:20 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34513 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbfG3PWU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Jul 2019 11:22:20 -0400
Received: by mail-qt1-f193.google.com with SMTP id k10so63499017qtq.1;
        Tue, 30 Jul 2019 08:22:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OO/c2yP4uoM3ppaExnLB+KAvV4cUlurSN+r0MW83xlg=;
        b=WihixSBZsSk4tuW4mTArRd//LjzwXTlTekMEaBoM01+VFMHSMGwlNwTGRtO5bgVKXf
         uhzUFRTaI9TO2W4wl4FyVjvrsNQSTAN7uKxpByoPE191KJ9x1O56QSms8jFiA1C05dKn
         m9shLV8G6TZCoyAcpKLix1l/DVO5RZoOGtkbRGjRS9qDu63S7aBPDC+XcD9t6OnxbTjl
         h09JHJY0Q8TnHOgRaj3QNrqZ7s7A0f1p+KEQ/FEv3Y8uYIMLOb1VimOAzCV4AUNb+1Ou
         8M7mTuORHyJJIDwE1kY3ATO0RKnum7hOTA2l0BFWwO3UOmiQy40NBq1290EAsdbXKJZ9
         b6rQ==
X-Gm-Message-State: APjAAAUhCrYl2S02psQlxyuEIXSuHttZ+Yp/MrTm1flJHBVdf6TMzscL
        ZowGEAFyzfjJ0PcgH3aPV4W3AXVwcUdN7LptHEI=
X-Google-Smtp-Source: APXvYqyNaVmHsewzA5uGAkmwyujcInHVc5NafBq6UZp+mxjp0XLZGFtJJ1W0M6qb4L13sIRzLVc0fGBFSXk7dc+Z+iU=
X-Received: by 2002:ac8:f99:: with SMTP id b25mr74385867qtk.142.1564500139259;
 Tue, 30 Jul 2019 08:22:19 -0700 (PDT)
MIME-Version: 1.0
References: <1564488945-20149-1-git-send-email-guoren@kernel.org>
 <1564488945-20149-4-git-send-email-guoren@kernel.org> <CAK8P3a0v3oVS5cCkORxA7na+VE7ofTQRxiv5o5xNf5v=esnN9A@mail.gmail.com>
 <CAJF2gTQC0e3zGxtCdwvZpen=Gj8CtgjNYCuy3hSupDXt3KM0Zg@mail.gmail.com>
In-Reply-To: <CAJF2gTQC0e3zGxtCdwvZpen=Gj8CtgjNYCuy3hSupDXt3KM0Zg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 30 Jul 2019 17:22:03 +0200
Message-ID: <CAK8P3a0miz=yghtqK+1=1APGf4R1-NW64TJTtGiO5pOPBQNgKg@mail.gmail.com>
Subject: Re: [PATCH 4/4] csky: Add dma_inv_range for DMA_FROM_DEVICE
To:     Guo Ren <guoren@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-csky@vger.kernel.org, feng_shizhu@dahuatech.com,
        zhang_jian5@dahuatech.com, zheng_xingjian@dahuatech.com,
        zhu_peng@dahuatech.com, Guo Ren <ren_guo@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 30, 2019 at 5:11 PM Guo Ren <guoren@kernel.org> wrote:
> > > diff --git a/arch/csky/mm/dma-mapping.c b/arch/csky/mm/dma-mapping.c
> > >                 cache_op(paddr, size, dma_wb_range);
> > >                 break;
> > >         case DMA_FROM_DEVICE:
> > > +               cache_op(paddr, size, dma_inv_range);
> > > +               break;
> > >         case DMA_BIDIRECTIONAL:
> > >                 cache_op(paddr, size, dma_wbinv_range);
> > >                 break;
> >
> > When syncing 'for_cpu', you should not need to write back, because
> > there won't be any dirty cache lines.
>
> I just follow the dma_data_direction param, seems dir param and
> function are a little bit duplicated. And our cpu won't clear clean
> cache line into memory, so dma_wb_page won't cause problem.
> Seems arch_sync_dma_for_cpu with dir=DMA_TO_DEVICE is
> self-contradictory.

Right, you generally don't need to do cache management for that
combination.

There might be other things to do here though, e.g. with a strict
iommu implementation one could tear down the i/o page table
entry to prevent the device from accessing a buffer while that is
owned by the cpu.

> Do you want me modfiy like these:
> @@ -88,6 +90,8 @@ void arch_sync_dma_for_cpu(struct device *dev,
> phys_addr_t paddr,
>         case DMA_TO_DEVICE:
>         case DMA_FROM_DEVICE:
>         case DMA_BIDIRECTIONAL:
>                cache_op(paddr, size, dma_inv_range);
>                break;
>
> @@ -72,6 +72,8 @@ void arch_sync_dma_for_device(struct device *dev,
> phys_addr_t paddr,
>         case DMA_TO_DEVICE:
>                 cache_op(paddr, size, dma_wb_range);
>                 break;
>         case DMA_FROM_DEVICE:
>         case DMA_BIDIRECTIONAL:
>                 cache_op(paddr, size, dma_wbinv_range);
>                 break;
>
> >
> > If you have a CPU core that does not do speculative loads, you also don't
> > need to invalidate here, because you have already done that in the
> > _for_device() case, the only reason to invalidate the CPU cache
> > again is if a speculative load created a stale cache line that now
> > shadows the data received from the device.
> Our CPU support speculative loads :)

Ok, then you both invalidations are indeed needed.
I was guessing that CK610 had no speculation.

       Arnd
