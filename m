Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4C51A3841
	for <lists+linux-arch@lfdr.de>; Thu,  9 Apr 2020 18:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgDIQvA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Apr 2020 12:51:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40948 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgDIQvA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Apr 2020 12:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PkxaeFIVCfsrSeEEx8LVvo4pS30j4LAzfUOxmZwXge8=; b=GGka1vwlLS5MYPkTsGxdsFzTuS
        DS3rDOfcUb9HLd/6b5SzwWrTADDVOx+0LMT07aKgtVPr0kLJtgCbA+XGpR2mfVKdM0lLjJkIQgK4y
        JJeb53TiZpO2ZclH17Kurq5SVEpz5LXzF1wWUnNNKS1WGzPcvxRb9wmHrQyxFtRy+uyqP24cIe0KY
        pOG0lsOHBWcprrx3Gv3iiQRWTZ33466s6rwrhNnc3MB6T0ncOjpk58lBhF98CB6EkIqA1yDHRsSWh
        wWIOFqpiUn8qqReI/bzkBn05Ww7Pt2yi1wt87V0Jos7AemDE3ibOYANc7V5Qh5so5rDdLtn63Ocq5
        lv9xW10Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMaNt-0003gC-0y; Thu, 09 Apr 2020 16:50:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B26BC3012D8;
        Thu,  9 Apr 2020 18:50:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 962822BA1D82B; Thu,  9 Apr 2020 18:50:30 +0200 (CEST)
Date:   Thu, 9 Apr 2020 18:50:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
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
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        sergey.senozhatsky@gmail.com
Subject: Re: [PATCH 10/28] mm: only allow page table mappings for built-in
 zsmalloc
Message-ID: <20200409165030.GG20713@hirez.programming.kicks-ass.net>
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-11-hch@lst.de>
 <20200409160826.GC247701@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409160826.GC247701@google.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 09, 2020 at 09:08:26AM -0700, Minchan Kim wrote:
> On Wed, Apr 08, 2020 at 01:59:08PM +0200, Christoph Hellwig wrote:
> > This allows to unexport map_vm_area and unmap_kernel_range, which are
> > rather deep internal and should not be available to modules.
> 
> Even though I don't know how many usecase we have using zsmalloc as
> module(I heard only once by dumb reason), it could affect existing
> users. Thus, please include concrete explanation in the patch to
> justify when the complain occurs.

The justification is 'we can unexport functions that have no sane reason
of being exported in the first place'.

The Changelog pretty much says that.
