Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 685E11A24CA
	for <lists+linux-arch@lfdr.de>; Wed,  8 Apr 2020 17:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgDHPPf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Apr 2020 11:15:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59280 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbgDHPPf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Apr 2020 11:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5Zyr+e9ojNxPf0UJbZ9u+v/X52sgt1i2sd8hmR6F47U=; b=L32SowMkDY1Nvkk1P+JH95Mz1a
        GuD4zRqv2dPCcJVwSn1QwymJ24KIDAK1RGhAyV/QQ+p2QbBtRHvi/a1FYE3qfogJFrnBZkDlThFzK
        IqCB93D/bsMtpUeC4hD3PyzdzrsUqcglZldNwu/V0g0eR8ChVF9oZFNzWsry73hFTny3aFVqoOety
        mJ0SNj2FV0h0akd26thCyTTJlDnP3cVMyV9RDiMHzwxr89F3pcghAW072S9K43a3CAhduPy/Qqxhj
        9VZc0gmBwmCxm9pi6xN0ggQWrzvceGDE2Tt7CjnyWIReAaTLibi/4WD/2QFbaSK0YWgfUD4jZuoHs
        1qhQI+Mw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMCQB-0000vd-W6; Wed, 08 Apr 2020 15:15:19 +0000
Date:   Wed, 8 Apr 2020 08:15:19 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, x86@kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/28] mm: only allow page table mappings for built-in
 zsmalloc
Message-ID: <20200408151519.GQ21484@bombadil.infradead.org>
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-11-hch@lst.de>
 <c0c86feb-b3d8-78f2-127f-71d682ffc51f@infradead.org>
 <20200408151203.GN20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408151203.GN20730@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 08, 2020 at 05:12:03PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 08, 2020 at 08:01:00AM -0700, Randy Dunlap wrote:
> > Hi,
> > 
> > On 4/8/20 4:59 AM, Christoph Hellwig wrote:
> > > diff --git a/mm/Kconfig b/mm/Kconfig
> > > index 36949a9425b8..614cc786b519 100644
> > > --- a/mm/Kconfig
> > > +++ b/mm/Kconfig
> > > @@ -702,7 +702,7 @@ config ZSMALLOC
> > >  
> > >  config ZSMALLOC_PGTABLE_MAPPING
> > >  	bool "Use page table mapping to access object in zsmalloc"
> > > -	depends on ZSMALLOC
> > > +	depends on ZSMALLOC=y
> > 
> > It's a bool so this shouldn't matter... not needed.
> 
> My mm/Kconfig has:
> 
> config ZSMALLOC
> 	tristate "Memory allocator for compressed pages"
> 	depends on MMU
> 
> which I think means it can be modular, no?

Randy means that ZSMALLOC_PGTABLE_MAPPING is a bool, so I think hch's patch
is wrong ... if ZSMALLOC is 'm' then ZSMALLOC_PGTABLE_MAPPING would become
'n' instead of 'y'.
