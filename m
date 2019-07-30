Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6F6B7AC06
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2019 17:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732218AbfG3PLk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Jul 2019 11:11:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:38410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732206AbfG3PLj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 30 Jul 2019 11:11:39 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 533B2208E4;
        Tue, 30 Jul 2019 15:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564499498;
        bh=kBZ37nlb4VhxPyIAOWHFVNI5VUA3imokEetW1pDJ2gg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Dm8kfwqHqlrXDnSiH+kDR8m3E9PUsQyxfvAX+y0cW/6ZlowXzwElyRMlMbYvN39Jn
         bMnBSIHcz/vrJNnV35iZpxIUj3E73zZ05OdLaTgLuef9J8JF9elrFrAKUQQtNRrNQT
         lda915zXunMZSBl/0Iplyiid+28DtyQrWP+wzyxc=
Received: by mail-wr1-f54.google.com with SMTP id n4so66263410wrs.3;
        Tue, 30 Jul 2019 08:11:38 -0700 (PDT)
X-Gm-Message-State: APjAAAX8rwz7NK+xsbvwUJTbz4jrdCDmWcICn0vGZlg3A3laH3ZsZFKF
        T3uV/uwLcsKH+EaUaZgKO8iHfPJT8ff/d0AjDtA=
X-Google-Smtp-Source: APXvYqwbIAje/Evb2w8oDL9BHbfuCOSPBlw7Fw3pr5jC162KBu/yRlsMcLKz5p4CpZDNVLbYYiSo8/Ou7FvXYRg4gBw=
X-Received: by 2002:adf:dc51:: with SMTP id m17mr25888475wrj.256.1564499496830;
 Tue, 30 Jul 2019 08:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <1564488945-20149-1-git-send-email-guoren@kernel.org>
 <1564488945-20149-4-git-send-email-guoren@kernel.org> <CAK8P3a0v3oVS5cCkORxA7na+VE7ofTQRxiv5o5xNf5v=esnN9A@mail.gmail.com>
In-Reply-To: <CAK8P3a0v3oVS5cCkORxA7na+VE7ofTQRxiv5o5xNf5v=esnN9A@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 30 Jul 2019 23:11:25 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQC0e3zGxtCdwvZpen=Gj8CtgjNYCuy3hSupDXt3KM0Zg@mail.gmail.com>
Message-ID: <CAJF2gTQC0e3zGxtCdwvZpen=Gj8CtgjNYCuy3hSupDXt3KM0Zg@mail.gmail.com>
Subject: Re: [PATCH 4/4] csky: Add dma_inv_range for DMA_FROM_DEVICE
To:     Arnd Bergmann <arnd@arndb.de>
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

Thx Arnd,

On Tue, Jul 30, 2019 at 9:43 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Jul 30, 2019 at 2:16 PM <guoren@kernel.org> wrote:
> > From: Guo Ren <ren_guo@c-sky.com>
>
> > diff --git a/arch/csky/mm/dma-mapping.c b/arch/csky/mm/dma-mapping.c
> > index 3f1ff9d..d8f0f81 100644
> > --- a/arch/csky/mm/dma-mapping.c
> > +++ b/arch/csky/mm/dma-mapping.c
> > @@ -72,6 +72,8 @@ void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
> >                 cache_op(paddr, size, dma_wb_range);
> >                 break;
> >         case DMA_FROM_DEVICE:
> > +               cache_op(paddr, size, dma_inv_range);
> > +               break;
> >         case DMA_BIDIRECTIONAL:
> >                 cache_op(paddr, size, dma_wbinv_range);
> >                 break;
> > @@ -88,6 +90,8 @@ void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
> >                 cache_op(paddr, size, dma_wb_range);
> >                 break;
> >         case DMA_FROM_DEVICE:
> > +               cache_op(paddr, size, dma_inv_range);
> > +               break;
> >         case DMA_BIDIRECTIONAL:
> >                 cache_op(paddr, size, dma_wbinv_range);
> >                 break;
>
> When syncing 'for_cpu', you should not need to write back, because
> there won't be any dirty cache lines.
I just follow the dma_data_direction param, seems dir param and
function are a little bit duplicated. And our cpu won't clear clean
cache line into memory, so dma_wb_page won't cause problem.
Seems arch_sync_dma_for_cpu with dir=DMA_TO_DEVICE is self-contradictory.

Do you want me modfiy like these:
@@ -88,6 +90,8 @@ void arch_sync_dma_for_cpu(struct device *dev,
phys_addr_t paddr,
        case DMA_TO_DEVICE:
        case DMA_FROM_DEVICE:
        case DMA_BIDIRECTIONAL:
               cache_op(paddr, size, dma_inv_range);
               break;

@@ -72,6 +72,8 @@ void arch_sync_dma_for_device(struct device *dev,
phys_addr_t paddr,
        case DMA_TO_DEVICE:
                cache_op(paddr, size, dma_wb_range);
                break;
        case DMA_FROM_DEVICE:
        case DMA_BIDIRECTIONAL:
                cache_op(paddr, size, dma_wbinv_range);
                break;

>
> If you have a CPU core that does not do speculative loads, you also don't
> need to invalidate here, because you have already done that in the
> _for_device() case, the only reason to invalidate the CPU cache
> again is if a speculative load created a stale cache line that now
> shadows the data received from the device.
Our CPU support speculative loads :)

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
