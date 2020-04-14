Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD351A7498
	for <lists+linux-arch@lfdr.de>; Tue, 14 Apr 2020 09:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406552AbgDNHXT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Apr 2020 03:23:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55848 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406537AbgDNHXR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Apr 2020 03:23:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mdGWbEV2x2kdC5wG9BfGG6AGALuiWCVT7ddOuw0GXRY=; b=qLkt2QBytR7Fe51p8cO9Vf1/b+
        xVWJ54SX12vGaW73vd8QVrGX2oOs6tuvshDuNsiOG092Sk/g+URdUovwJaGYErHwBF5T8E6Lp2fHN
        /WmGdzZtBqaHcPvJJ3Nw6nEmmi7aFjVVA4oUO/cNoZpTLFvrmZI5F8EIVK8CLRuESs4y3wtOIzyZK
        ziMikLkYeLjZRLKMAEpxQUXD4SGIuTB75jdLgURHQtMtOZ1LZvIcplWcWz42HO/zoPsVHPFbsHoX6
        yK2I/42COQYUkVKZqfG3oNqU3bkmZABO/wik26fvtLOpzEv4j87Fc3ohFq5uw9DHocMoxwNPcQZVy
        bemhMBGA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOFue-0002Dm-Hj; Tue, 14 Apr 2020 07:23:16 +0000
Date:   Tue, 14 Apr 2020 00:23:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/4] mm/vmalloc: Hugepage vmalloc mappings
Message-ID: <20200414072316.GA5503@infradead.org>
References: <20200413125303.423864-1-npiggin@gmail.com>
 <20200413125303.423864-5-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413125303.423864-5-npiggin@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 13, 2020 at 10:53:03PM +1000, Nicholas Piggin wrote:
> For platforms that define HAVE_ARCH_HUGE_VMAP and support PMD vmap mappings,
> have vmalloc attempt to allocate PMD-sized pages first, before falling back
> to small pages. Allocations which use something other than PAGE_KERNEL
> protections are not permitted to use huge pages yet, not all callers expect
> this (e.g., module allocations vs strict module rwx).
> 
> This gives a 6x reduction in dTLB misses for a `git diff` (of linux), from
> 45600 to 6500 and a 2.2% reduction in cycles on a 2-node POWER9.
> 
> This can result in more internal fragmentation and memory overhead for a
> given allocation. It can also cause greater NUMA unbalance on hashdist
> allocations.
> 
> There may be other callers that expect small pages under vmalloc but use
> PAGE_KERNEL, I'm not sure if it's feasible to catch them all. An
> alternative would be a new function or flag which enables large mappings,
> and use that in callers.

Why do we even use vmalloc in this case rather than just doing a huge
page allocation?  What callers are you intersted in?
