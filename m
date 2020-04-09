Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B86131A31F9
	for <lists+linux-arch@lfdr.de>; Thu,  9 Apr 2020 11:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgDIJld (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Apr 2020 05:41:33 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35111 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgDIJlc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Apr 2020 05:41:32 -0400
Received: by mail-ot1-f65.google.com with SMTP id v2so9864028oto.2
        for <linux-arch@vger.kernel.org>; Thu, 09 Apr 2020 02:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AAmPcakirZ+49aStGKItq0c+j+VEsXqfcBH/BMyGspk=;
        b=WXfJC2xvujS1NMEJmo8auNqU+zz3KoHNnFI/ZwIoQGqsenIlj1/rLp7i8g0wrHhNMA
         tB4UaPYqL8fo1FBLJD1QspR85zqLl/OHQQ2XW2wZhxbVmnvXaj4OEg2HGRtpK4xkfIA5
         QryyOXVdb1eBXsQfmBlDoe7W6QRuDag4YOw+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AAmPcakirZ+49aStGKItq0c+j+VEsXqfcBH/BMyGspk=;
        b=cfjMOUKPkIrYBkZDyEbHb4sDi/JyCooiRd8Y0WsiZO/mcE0tYI664OIqqkjN+tHYYB
         s1wEO0pTQ0wFy5ASJmc24W9NLWmm9GKelaXvnrY07kIVqP22FDTXdZ9rZp7sG6JNM+hc
         P9tGTIWrAW1OGocsUHAakAcQI+lqg/c/gnTeObqlcYyKeFZNRn0zVrccf0YlrmRNiKzh
         qu0UK9u7X+gAfnNO14Xr22vpLv4fwZs+gF9T0K0TLwkOeUY56EZEFhbCKITEkkS6tYyN
         L9c1VP9u0I4PbmxoZ3CMLpW6R1Khk1FHbSC6x7MLg3YAPn2Q5bYujqsUv570Ax+qypC+
         sXGA==
X-Gm-Message-State: AGi0PuZzNiiwq6SVffvkYgRfcKKFigox99yxGCxYQM2Nc7pGHQij5EfC
        1tmDG1aow7dyqXYw1Ep2RDJ5SXphOX2erfhKRECrNQ==
X-Google-Smtp-Source: APiQypLHBVJAv55CZxyRjUHHZPFErxI7m2EAB+edMw28HekqHKAMU8pcbynFySqYUgFQY0OpR/l48dylQu4jTtXwGxw=
X-Received: by 2002:a4a:4190:: with SMTP id x138mr9186341ooa.35.1586425291875;
 Thu, 09 Apr 2020 02:41:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200408115926.1467567-1-hch@lst.de> <20200408115926.1467567-20-hch@lst.de>
 <20200408122504.GO3456981@phenom.ffwll.local> <eb48f7b6327e482ea9911b129210c0417ab48345.camel@kernel.crashing.org>
In-Reply-To: <eb48f7b6327e482ea9911b129210c0417ab48345.camel@kernel.crashing.org>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 9 Apr 2020 11:41:20 +0200
Message-ID: <CAKMK7uHtkLvdsWFGiAtkzVa5mpnDvXkn3CHZQ6bgJ_enbyAc8A@mail.gmail.com>
Subject: Re: [PATCH 19/28] gpu/drm: remove the powerpc hack in drm_legacy_sg_alloc
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, X86 ML <x86@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-hyperv@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        "open list:GENERIC INCLUDE/A..." <linux-arch@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-s390@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 9, 2020 at 10:54 AM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> On Wed, 2020-04-08 at 14:25 +0200, Daniel Vetter wrote:
> > On Wed, Apr 08, 2020 at 01:59:17PM +0200, Christoph Hellwig wrote:
> > > If this code was broken for non-coherent caches a crude powerpc hack
> > > isn't going to help anyone else.  Remove the hack as it is the last
> > > user of __vmalloc passing a page protection flag other than PAGE_KERNEL.
> >
> > Well Ben added this to make stuff work on ppc, ofc the home grown dma
> > layer in drm from back then isn't going to work in other places. I guess
> > should have at least an ack from him, in case anyone still cares about
> > this on ppc. Adding Ben to cc.
>
> This was due to some drivers (radeon ?) trying to use vmalloc pages for
> coherent DMA, which means on those 4xx powerpc's need to be non-cached.
>
> There were machines using that (440 based iirc), though I honestly
> can't tell if anybody still uses any of it.

agp subsystem still seems to happily do that (vmalloc memory for
device access), never having been ported to dma apis (or well
converted to iommu drivers, which they kinda are really). So I think
this all still works exactly as back then, even with the kms radeon
drivers. Question really is whether we have users left, and I have no
clue about that either.

Now if these boxes didn't ever have agp then I think we can get away
with deleting this, since we've already deleted the legacy radeon
driver. And that one used vmalloc for everything. The new kms one does
use the dma-api if the gpu isn't connected through agp.
-Daniel

> Cheers,
> Ben.
>
> > -Daniel
> >
> > >
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  drivers/gpu/drm/drm_scatter.c | 11 +----------
> > >  1 file changed, 1 insertion(+), 10 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/drm_scatter.c b/drivers/gpu/drm/drm_scatter.c
> > > index ca520028b2cb..f4e6184d1877 100644
> > > --- a/drivers/gpu/drm/drm_scatter.c
> > > +++ b/drivers/gpu/drm/drm_scatter.c
> > > @@ -43,15 +43,6 @@
> > >
> > >  #define DEBUG_SCATTER 0
> > >
> > > -static inline void *drm_vmalloc_dma(unsigned long size)
> > > -{
> > > -#if defined(__powerpc__) && defined(CONFIG_NOT_COHERENT_CACHE)
> > > -   return __vmalloc(size, GFP_KERNEL, pgprot_noncached_wc(PAGE_KERNEL));
> > > -#else
> > > -   return vmalloc_32(size);
> > > -#endif
> > > -}
> > > -
> > >  static void drm_sg_cleanup(struct drm_sg_mem * entry)
> > >  {
> > >     struct page *page;
> > > @@ -126,7 +117,7 @@ int drm_legacy_sg_alloc(struct drm_device *dev, void *data,
> > >             return -ENOMEM;
> > >     }
> > >
> > > -   entry->virtual = drm_vmalloc_dma(pages << PAGE_SHIFT);
> > > +   entry->virtual = vmalloc_32(pages << PAGE_SHIFT);
> > >     if (!entry->virtual) {
> > >             kfree(entry->busaddr);
> > >             kfree(entry->pagelist);
> > > --
> > > 2.25.1
> > >
> >
> >
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
