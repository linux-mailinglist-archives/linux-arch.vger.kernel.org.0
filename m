Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 478871A318B
	for <lists+linux-arch@lfdr.de>; Thu,  9 Apr 2020 11:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgDIJJF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Apr 2020 05:09:05 -0400
Received: from kernel.crashing.org ([76.164.61.194]:42184 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgDIJJF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Apr 2020 05:09:05 -0400
X-Greylist: delayed 767 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Apr 2020 05:09:04 EDT
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 0398s3us004063
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 9 Apr 2020 03:54:07 -0500
Message-ID: <eb48f7b6327e482ea9911b129210c0417ab48345.camel@kernel.crashing.org>
Subject: Re: [PATCH 19/28] gpu/drm: remove the powerpc hack in
 drm_legacy_sg_alloc
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Daniel Vetter <daniel@ffwll.ch>, Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, x86@kernel.org,
        David Airlie <airlied@linux.ie>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 09 Apr 2020 18:54:01 +1000
In-Reply-To: <20200408122504.GO3456981@phenom.ffwll.local>
References: <20200408115926.1467567-1-hch@lst.de>
         <20200408115926.1467567-20-hch@lst.de>
         <20200408122504.GO3456981@phenom.ffwll.local>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2020-04-08 at 14:25 +0200, Daniel Vetter wrote:
> On Wed, Apr 08, 2020 at 01:59:17PM +0200, Christoph Hellwig wrote:
> > If this code was broken for non-coherent caches a crude powerpc hack
> > isn't going to help anyone else.  Remove the hack as it is the last
> > user of __vmalloc passing a page protection flag other than PAGE_KERNEL.
> 
> Well Ben added this to make stuff work on ppc, ofc the home grown dma
> layer in drm from back then isn't going to work in other places. I guess
> should have at least an ack from him, in case anyone still cares about
> this on ppc. Adding Ben to cc.

This was due to some drivers (radeon ?) trying to use vmalloc pages for
coherent DMA, which means on those 4xx powerpc's need to be non-cached.

There were machines using that (440 based iirc), though I honestly
can't tell if anybody still uses any of it.

Cheers,
Ben.

> -Daniel
> 
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  drivers/gpu/drm/drm_scatter.c | 11 +----------
> >  1 file changed, 1 insertion(+), 10 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_scatter.c b/drivers/gpu/drm/drm_scatter.c
> > index ca520028b2cb..f4e6184d1877 100644
> > --- a/drivers/gpu/drm/drm_scatter.c
> > +++ b/drivers/gpu/drm/drm_scatter.c
> > @@ -43,15 +43,6 @@
> >  
> >  #define DEBUG_SCATTER 0
> >  
> > -static inline void *drm_vmalloc_dma(unsigned long size)
> > -{
> > -#if defined(__powerpc__) && defined(CONFIG_NOT_COHERENT_CACHE)
> > -	return __vmalloc(size, GFP_KERNEL, pgprot_noncached_wc(PAGE_KERNEL));
> > -#else
> > -	return vmalloc_32(size);
> > -#endif
> > -}
> > -
> >  static void drm_sg_cleanup(struct drm_sg_mem * entry)
> >  {
> >  	struct page *page;
> > @@ -126,7 +117,7 @@ int drm_legacy_sg_alloc(struct drm_device *dev, void *data,
> >  		return -ENOMEM;
> >  	}
> >  
> > -	entry->virtual = drm_vmalloc_dma(pages << PAGE_SHIFT);
> > +	entry->virtual = vmalloc_32(pages << PAGE_SHIFT);
> >  	if (!entry->virtual) {
> >  		kfree(entry->busaddr);
> >  		kfree(entry->pagelist);
> > -- 
> > 2.25.1
> > 
> 
> 

