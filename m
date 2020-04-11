Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2711A4E7B
	for <lists+linux-arch@lfdr.de>; Sat, 11 Apr 2020 09:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgDKHU5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 11 Apr 2020 03:20:57 -0400
Received: from verein.lst.de ([213.95.11.211]:52955 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgDKHU4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 11 Apr 2020 03:20:56 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4505168BFE; Sat, 11 Apr 2020 09:20:52 +0200 (CEST)
Date:   Sat, 11 Apr 2020 09:20:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20200411072052.GA31242@lst.de>
References: <20200408115926.1467567-1-hch@lst.de> <20200408115926.1467567-11-hch@lst.de> <20200409160826.GC247701@google.com> <20200409165030.GG20713@hirez.programming.kicks-ass.net> <20200409170813.GD247701@google.com> <20200410023845.GA2354@jagdpanzerIV.localdomain> <20200410231136.GA101325@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410231136.GA101325@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Minchan,

On Fri, Apr 10, 2020 at 04:11:36PM -0700, Minchan Kim wrote:
> It doesn't mean we couldn't use zsmalloc as module any longer. It means
> we couldn't use zsmalloc as module with pgtable mapping whcih was little
> bit faster on microbenchmark in some architecutre(However, I usually temped
> to remove it since it had several problems). However, we could still use
> zsmalloc as module as copy way instead of pgtable mapping. Thus, if someone
> really want to rollback the feature, they should provide reasonable reason
> why it doesn't work for them. "A little fast" wouldn't be enough to exports
> deep internal to the module.

do you have any data how much faster it is on arm (and does that include
arm64 as well)?  Besides the exports which were my prime concern,
zsmalloc with pgtable mappings also is the only user of map_kernel_range
outside of vmalloc.c, if it really is another code base for tiny
improvements we could mark map_kernel_range or in fact remove it entirely
and open code it in the remaining callers.

(unmap_kernel_range is a different story, it has a bunch of callers,
and most look odd)
