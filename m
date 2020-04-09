Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 407951A365C
	for <lists+linux-arch@lfdr.de>; Thu,  9 Apr 2020 16:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgDIO5Y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Apr 2020 10:57:24 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:32814 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgDIO5Y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Apr 2020 10:57:24 -0400
Received: by mail-ot1-f65.google.com with SMTP id 103so4359182otv.0
        for <linux-arch@vger.kernel.org>; Thu, 09 Apr 2020 07:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MvCVAZWSVpElREbfXb1mt2g3VRvFUkKvrzFHvdRqvkg=;
        b=ebEd4FdYNO+7wzGFzjBvQDg8mK2wrpjmDjuCBjAH9tAbCCg4zgABTbGAxKzQ49JMxn
         kqTYGut6ohJDRAdHangRN4hffUJ4MvJUmXVqHcdUYuhWsOAAhFmddn4uDDLAgZuSwUyx
         in2+ZqI2XFwOOnx/68F1aBghe4TTCvi2K8Jb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MvCVAZWSVpElREbfXb1mt2g3VRvFUkKvrzFHvdRqvkg=;
        b=lF49lorOMK6/1K8F+OlOGk1t+VJr9iRL21mWkqoPraLWMASNLnAJNgnBDdqU0972c8
         nS1h9Z5bvmEB7eHbdam0LjZEC7JonyizaM1EsacmL5NRhd61gIR0XDn1hFdLrdLDMwJX
         na15YSMZjvoT0nZI29VCSl5VPIzwEznuCFix1RNx9Kwq5PrPJQc91F00zzfbdQd/Zrtg
         OfY/PpBs5SAvk53CJfGsXTqppKDSgydq8aRFD6DVO0q8gZ0f3WeUyPJypdSfXDk2Ja44
         B6T0tIi5GXc4XmWKyfNC5ABWWRk8yeqbhnkQNJWm1bybP3p7zuVTn7E8xNx6FdDEZTZa
         fpGQ==
X-Gm-Message-State: AGi0Pubwe3rgAHGoIC4hb3zHemKPqpsrcgnPkEajMBIb2Q4r3x+hNWBA
        BgB+0+bgh3D3GIu0UAmq1o7WaCijhftC2Y9xwSmnsA==
X-Google-Smtp-Source: APiQypIfaMneOW4AjWTG+JPErLig8zTku8dFSxJeBsmrgUZhaXvkSx7h0yWmBa2juZ12CNXUTDblTNSgeRCuieJep64=
X-Received: by 2002:a9d:6e8f:: with SMTP id a15mr251186otr.188.1586444244321;
 Thu, 09 Apr 2020 07:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200408115926.1467567-1-hch@lst.de> <20200408115926.1467567-20-hch@lst.de>
 <20200408122504.GO3456981@phenom.ffwll.local> <eb48f7b6327e482ea9911b129210c0417ab48345.camel@kernel.crashing.org>
 <CAKMK7uHtkLvdsWFGiAtkzVa5mpnDvXkn3CHZQ6bgJ_enbyAc8A@mail.gmail.com> <CADnq5_MjTSm6j=_8huVQ854H6jXY5Rg36wc31QDfOpfjfscWxA@mail.gmail.com>
In-Reply-To: <CADnq5_MjTSm6j=_8huVQ854H6jXY5Rg36wc31QDfOpfjfscWxA@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 9 Apr 2020 16:57:12 +0200
Message-ID: <CAKMK7uESDf446FsdA2KC9sybSKxf5OdXvHZ-d4G3PAt-vvP8zg@mail.gmail.com>
Subject: Re: [PATCH 19/28] gpu/drm: remove the powerpc hack in drm_legacy_sg_alloc
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-hyperv@vger.kernel.org, David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux MM <linux-mm@kvack.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        "open list:GENERIC INCLUDE/A..." <linux-arch@vger.kernel.org>,
        linux-s390@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        X86 ML <x86@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Laura Abbott <labbott@redhat.com>,
        Nitin Gupta <ngupta@vflare.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>, bpf <bpf@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 9, 2020 at 4:19 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Thu, Apr 9, 2020 at 5:41 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Thu, Apr 9, 2020 at 10:54 AM Benjamin Herrenschmidt
> > <benh@kernel.crashing.org> wrote:
> > >
> > > On Wed, 2020-04-08 at 14:25 +0200, Daniel Vetter wrote:
> > > > On Wed, Apr 08, 2020 at 01:59:17PM +0200, Christoph Hellwig wrote:
> > > > > If this code was broken for non-coherent caches a crude powerpc hack
> > > > > isn't going to help anyone else.  Remove the hack as it is the last
> > > > > user of __vmalloc passing a page protection flag other than PAGE_KERNEL.
> > > >
> > > > Well Ben added this to make stuff work on ppc, ofc the home grown dma
> > > > layer in drm from back then isn't going to work in other places. I guess
> > > > should have at least an ack from him, in case anyone still cares about
> > > > this on ppc. Adding Ben to cc.
> > >
> > > This was due to some drivers (radeon ?) trying to use vmalloc pages for
> > > coherent DMA, which means on those 4xx powerpc's need to be non-cached.
> > >
> > > There were machines using that (440 based iirc), though I honestly
> > > can't tell if anybody still uses any of it.
> >
> > agp subsystem still seems to happily do that (vmalloc memory for
> > device access), never having been ported to dma apis (or well
> > converted to iommu drivers, which they kinda are really). So I think
> > this all still works exactly as back then, even with the kms radeon
> > drivers. Question really is whether we have users left, and I have no
> > clue about that either.
> >
> > Now if these boxes didn't ever have agp then I think we can get away
> > with deleting this, since we've already deleted the legacy radeon
> > driver. And that one used vmalloc for everything. The new kms one does
> > use the dma-api if the gpu isn't connected through agp.
>
> All radeons have a built in remapping table to handle non-AGP systems.
> On the earlier radeons it wasn't quite as performant as AGP, but it
> was always more reliable because AGP is AGP.  Maybe it's time to let
> AGP go?

I'd be very much in favour of that, if we can just use the integrated
gart and drop agp fast writes wobbliness on the floor. I think the
only other modern driver using agp would be nouveau at that point.
-Daniel

>
> Alex
>
> > -Daniel
> >
> > > Cheers,
> > > Ben.
> > >
> > > > -Daniel
> > > >
> > > > >
> > > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > > > ---
> > > > >  drivers/gpu/drm/drm_scatter.c | 11 +----------
> > > > >  1 file changed, 1 insertion(+), 10 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/drm_scatter.c b/drivers/gpu/drm/drm_scatter.c
> > > > > index ca520028b2cb..f4e6184d1877 100644
> > > > > --- a/drivers/gpu/drm/drm_scatter.c
> > > > > +++ b/drivers/gpu/drm/drm_scatter.c
> > > > > @@ -43,15 +43,6 @@
> > > > >
> > > > >  #define DEBUG_SCATTER 0
> > > > >
> > > > > -static inline void *drm_vmalloc_dma(unsigned long size)
> > > > > -{
> > > > > -#if defined(__powerpc__) && defined(CONFIG_NOT_COHERENT_CACHE)
> > > > > -   return __vmalloc(size, GFP_KERNEL, pgprot_noncached_wc(PAGE_KERNEL));
> > > > > -#else
> > > > > -   return vmalloc_32(size);
> > > > > -#endif
> > > > > -}
> > > > > -
> > > > >  static void drm_sg_cleanup(struct drm_sg_mem * entry)
> > > > >  {
> > > > >     struct page *page;
> > > > > @@ -126,7 +117,7 @@ int drm_legacy_sg_alloc(struct drm_device *dev, void *data,
> > > > >             return -ENOMEM;
> > > > >     }
> > > > >
> > > > > -   entry->virtual = drm_vmalloc_dma(pages << PAGE_SHIFT);
> > > > > +   entry->virtual = vmalloc_32(pages << PAGE_SHIFT);
> > > > >     if (!entry->virtual) {
> > > > >             kfree(entry->busaddr);
> > > > >             kfree(entry->pagelist);
> > > > > --
> > > > > 2.25.1
> > > > >
> > > >
> > > >
> > >
> >
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > +41 (0) 79 365 57 48 - http://blog.ffwll.ch
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
