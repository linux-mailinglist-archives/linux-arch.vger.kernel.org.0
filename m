Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB341A35C4
	for <lists+linux-arch@lfdr.de>; Thu,  9 Apr 2020 16:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgDIOTn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Apr 2020 10:19:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40243 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgDIOTn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Apr 2020 10:19:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id s8so12105071wrt.7;
        Thu, 09 Apr 2020 07:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZUmhXgHoG6HvjILgsbXz8GHCgll+LOxrRpBdz13V/lg=;
        b=BC90dwXA5AK4WR90ooTtvULwZnu4ZsRVQnQLV9NzDFZ7lKqicRXsEGPNedNOxy+3QI
         a1kmoOXSFteeDxdRL+7e8P62DjjD9bQZg3s3fofRhJoe7L1J9a46LbUxrQ6AtBTORXKV
         NDIKSoT9CEStlFz6MiX3tbzgvTr7KX9SEjLdYBH0eiP7EZNSClTpfzc0SSPSYynPiChj
         rYQTfJjtkntOCwrv+a6GMvAsCqYj/CQkd4PMEIkllHf9XhpKzORn/6xDs0+pafSbvmxv
         oU2GBI4+6mAQrXmQRuIHv6FAH1pdnq+zGKXLFmqILm/RS3QETgMEHnp/o0W7dlcGkPIh
         SqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZUmhXgHoG6HvjILgsbXz8GHCgll+LOxrRpBdz13V/lg=;
        b=RDl7sinI4dbRLE8IkhQIZeGMRk2aHuMnCINsz8Wfzhl7mEMFNJLbCCydSPrdXp6W8K
         gosKEnsjgExDQ56dHzsLcgIYm8IFhVy9KSZ4q3M6q9W/wVsr1pJ5H81zdjyGpEOSFGKQ
         8j/uOjdAwMQdReqkvnd6TDre4bOBIiEH253W3dyp8fkRydqABjZquNos1prT7pJxCY02
         DHvr94MXV9YqYt5cGOj3xLjLr5v28LTQx7TQ7gReJSYNYxwkVmVf0Efop9NC4CXWDjTl
         LrhwjYrUk2o+Y6sVkMzl4KYDP/kecuop6JyOzQVNiC9gjvQySeFnpvUiGD22DObQ9NoU
         or0Q==
X-Gm-Message-State: AGi0PuZad56Av4AwNmGHlJRjGilIQr9qJcNh0DEOD3sHhkBt6/Mu43AY
        /v5LiTr8x+IJq5bXuTTZjfmuFSFnfqTBxb+gCEp5JQ==
X-Google-Smtp-Source: APiQypLOoBbfys5GjBpuB2sw0gQny4RebKmCrdoglSc09SupmnqmNJDVTgB3bGVTn0oBHL2+TIHKXrenRgwfEr3zhLg=
X-Received: by 2002:a5d:4145:: with SMTP id c5mr9091691wrq.362.1586441981450;
 Thu, 09 Apr 2020 07:19:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200408115926.1467567-1-hch@lst.de> <20200408115926.1467567-20-hch@lst.de>
 <20200408122504.GO3456981@phenom.ffwll.local> <eb48f7b6327e482ea9911b129210c0417ab48345.camel@kernel.crashing.org>
 <CAKMK7uHtkLvdsWFGiAtkzVa5mpnDvXkn3CHZQ6bgJ_enbyAc8A@mail.gmail.com>
In-Reply-To: <CAKMK7uHtkLvdsWFGiAtkzVa5mpnDvXkn3CHZQ6bgJ_enbyAc8A@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 9 Apr 2020 10:19:30 -0400
Message-ID: <CADnq5_MjTSm6j=_8huVQ854H6jXY5Rg36wc31QDfOpfjfscWxA@mail.gmail.com>
Subject: Re: [PATCH 19/28] gpu/drm: remove the powerpc hack in drm_legacy_sg_alloc
To:     Daniel Vetter <daniel@ffwll.ch>
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

On Thu, Apr 9, 2020 at 5:41 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Thu, Apr 9, 2020 at 10:54 AM Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> >
> > On Wed, 2020-04-08 at 14:25 +0200, Daniel Vetter wrote:
> > > On Wed, Apr 08, 2020 at 01:59:17PM +0200, Christoph Hellwig wrote:
> > > > If this code was broken for non-coherent caches a crude powerpc hack
> > > > isn't going to help anyone else.  Remove the hack as it is the last
> > > > user of __vmalloc passing a page protection flag other than PAGE_KERNEL.
> > >
> > > Well Ben added this to make stuff work on ppc, ofc the home grown dma
> > > layer in drm from back then isn't going to work in other places. I guess
> > > should have at least an ack from him, in case anyone still cares about
> > > this on ppc. Adding Ben to cc.
> >
> > This was due to some drivers (radeon ?) trying to use vmalloc pages for
> > coherent DMA, which means on those 4xx powerpc's need to be non-cached.
> >
> > There were machines using that (440 based iirc), though I honestly
> > can't tell if anybody still uses any of it.
>
> agp subsystem still seems to happily do that (vmalloc memory for
> device access), never having been ported to dma apis (or well
> converted to iommu drivers, which they kinda are really). So I think
> this all still works exactly as back then, even with the kms radeon
> drivers. Question really is whether we have users left, and I have no
> clue about that either.
>
> Now if these boxes didn't ever have agp then I think we can get away
> with deleting this, since we've already deleted the legacy radeon
> driver. And that one used vmalloc for everything. The new kms one does
> use the dma-api if the gpu isn't connected through agp.

All radeons have a built in remapping table to handle non-AGP systems.
On the earlier radeons it wasn't quite as performant as AGP, but it
was always more reliable because AGP is AGP.  Maybe it's time to let
AGP go?

Alex

> -Daniel
>
> > Cheers,
> > Ben.
> >
> > > -Daniel
> > >
> > > >
> > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > > ---
> > > >  drivers/gpu/drm/drm_scatter.c | 11 +----------
> > > >  1 file changed, 1 insertion(+), 10 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/drm_scatter.c b/drivers/gpu/drm/drm_scatter.c
> > > > index ca520028b2cb..f4e6184d1877 100644
> > > > --- a/drivers/gpu/drm/drm_scatter.c
> > > > +++ b/drivers/gpu/drm/drm_scatter.c
> > > > @@ -43,15 +43,6 @@
> > > >
> > > >  #define DEBUG_SCATTER 0
> > > >
> > > > -static inline void *drm_vmalloc_dma(unsigned long size)
> > > > -{
> > > > -#if defined(__powerpc__) && defined(CONFIG_NOT_COHERENT_CACHE)
> > > > -   return __vmalloc(size, GFP_KERNEL, pgprot_noncached_wc(PAGE_KERNEL));
> > > > -#else
> > > > -   return vmalloc_32(size);
> > > > -#endif
> > > > -}
> > > > -
> > > >  static void drm_sg_cleanup(struct drm_sg_mem * entry)
> > > >  {
> > > >     struct page *page;
> > > > @@ -126,7 +117,7 @@ int drm_legacy_sg_alloc(struct drm_device *dev, void *data,
> > > >             return -ENOMEM;
> > > >     }
> > > >
> > > > -   entry->virtual = drm_vmalloc_dma(pages << PAGE_SHIFT);
> > > > +   entry->virtual = vmalloc_32(pages << PAGE_SHIFT);
> > > >     if (!entry->virtual) {
> > > >             kfree(entry->busaddr);
> > > >             kfree(entry->pagelist);
> > > > --
> > > > 2.25.1
> > > >
> > >
> > >
> >
>
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
