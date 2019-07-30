Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 010257ACAA
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2019 17:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730132AbfG3PsR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Jul 2019 11:48:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:35266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfG3PsR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 30 Jul 2019 11:48:17 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3900F208E3;
        Tue, 30 Jul 2019 15:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564501696;
        bh=u8G3uu/YLVUjZICLkZ9ngEhNPuxZKK87scZFtu1ZmgY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=i1Lsevi8fySkHyU5LXwS5gZUwf3cfIKuX2KQHwjdzh8snOZu8xwAQ1Wk+8+fvpbdC
         jBuXYUTXy+spMjRuWnCiD5B1+46Kha3w/JXnCYstU7g9vMl1ZrLWov5rLxjmUn8USg
         3Ar6lwmN8o1Fe4irwWkiObgVm27qZRJGEXDTv/Yk=
Received: by mail-wm1-f46.google.com with SMTP id s3so57627350wms.2;
        Tue, 30 Jul 2019 08:48:16 -0700 (PDT)
X-Gm-Message-State: APjAAAUOUyXnBSVUBofNXekrQp5yclIW1m9drkl6066UfqqIf+Z6xhqy
        MC/zy1pzeJ0AGdEmaOVQuyqBzdBy2krf3/r4JBY=
X-Google-Smtp-Source: APXvYqzy094AIRwYpa7T0yizmHQReD9dLlNYBxyC0FmWxogigflCzHYWW1iUGyikNSAoRQRF4+oKPDeKtgn4z6mdlL4=
X-Received: by 2002:a05:600c:20c3:: with SMTP id y3mr108901006wmm.3.1564501694671;
 Tue, 30 Jul 2019 08:48:14 -0700 (PDT)
MIME-Version: 1.0
References: <1564488945-20149-1-git-send-email-guoren@kernel.org>
 <1564488945-20149-4-git-send-email-guoren@kernel.org> <CAK8P3a0v3oVS5cCkORxA7na+VE7ofTQRxiv5o5xNf5v=esnN9A@mail.gmail.com>
 <CAJF2gTQC0e3zGxtCdwvZpen=Gj8CtgjNYCuy3hSupDXt3KM0Zg@mail.gmail.com> <CAK8P3a0miz=yghtqK+1=1APGf4R1-NW64TJTtGiO5pOPBQNgKg@mail.gmail.com>
In-Reply-To: <CAK8P3a0miz=yghtqK+1=1APGf4R1-NW64TJTtGiO5pOPBQNgKg@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 30 Jul 2019 23:48:03 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRf1461+9HgqSPh5UEoVz7J_je3yeg=jji6myE0OKKcKg@mail.gmail.com>
Message-ID: <CAJF2gTRf1461+9HgqSPh5UEoVz7J_je3yeg=jji6myE0OKKcKg@mail.gmail.com>
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

On Tue, Jul 30, 2019 at 11:22 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Jul 30, 2019 at 5:11 PM Guo Ren <guoren@kernel.org> wrote:
> > > > diff --git a/arch/csky/mm/dma-mapping.c b/arch/csky/mm/dma-mapping.c
> > > >                 cache_op(paddr, size, dma_wb_range);
> > > >                 break;
> > > >         case DMA_FROM_DEVICE:
> > > > +               cache_op(paddr, size, dma_inv_range);
> > > > +               break;
> > > >         case DMA_BIDIRECTIONAL:
> > > >                 cache_op(paddr, size, dma_wbinv_range);
> > > >                 break;
> > >
> > > When syncing 'for_cpu', you should not need to write back, because
> > > there won't be any dirty cache lines.
> >
> > I just follow the dma_data_direction param, seems dir param and
> > function are a little bit duplicated. And our cpu won't clear clean
> > cache line into memory, so dma_wb_page won't cause problem.
> > Seems arch_sync_dma_for_cpu with dir=DMA_TO_DEVICE is
> > self-contradictory.
>
> Right, you generally don't need to do cache management for that
> combination.
>
> There might be other things to do here though, e.g. with a strict
> iommu implementation one could tear down the i/o page table
> entry to prevent the device from accessing a buffer while that is
> owned by the cpu.
Tear down i/o page table shouldn't be put here and it's for map/unmap().
And I think arch_sync_dma_for_cpu/device should only do cache issues.

--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
