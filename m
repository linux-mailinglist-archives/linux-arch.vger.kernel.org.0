Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2621A254C
	for <lists+linux-arch@lfdr.de>; Wed,  8 Apr 2020 17:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgDHPgJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Apr 2020 11:36:09 -0400
Received: from verein.lst.de ([213.95.11.211]:42880 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726709AbgDHPgI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 8 Apr 2020 11:36:08 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0291668C4E; Wed,  8 Apr 2020 17:36:02 +0200 (CEST)
Date:   Wed, 8 Apr 2020 17:36:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
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
Message-ID: <20200408153602.GA28081@lst.de>
References: <20200408115926.1467567-1-hch@lst.de> <20200408115926.1467567-11-hch@lst.de> <c0c86feb-b3d8-78f2-127f-71d682ffc51f@infradead.org> <20200408151203.GN20730@hirez.programming.kicks-ass.net> <20200408151519.GQ21484@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408151519.GQ21484@bombadil.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 08, 2020 at 08:15:19AM -0700, Matthew Wilcox wrote:
> > > >  config ZSMALLOC_PGTABLE_MAPPING
> > > >  	bool "Use page table mapping to access object in zsmalloc"
> > > > -	depends on ZSMALLOC
> > > > +	depends on ZSMALLOC=y
> > > 
> > > It's a bool so this shouldn't matter... not needed.
> > 
> > My mm/Kconfig has:
> > 
> > config ZSMALLOC
> > 	tristate "Memory allocator for compressed pages"
> > 	depends on MMU
> > 
> > which I think means it can be modular, no?
> 
> Randy means that ZSMALLOC_PGTABLE_MAPPING is a bool, so I think hch's patch
> is wrong ... if ZSMALLOC is 'm' then ZSMALLOC_PGTABLE_MAPPING would become
> 'n' instead of 'y'.

In Linus' tree you can select PGTABLE_MAPPING=y with ZSMALLOC=m,
and that fits my understanding of the kbuild language.  With this
patch I can't anymore.
