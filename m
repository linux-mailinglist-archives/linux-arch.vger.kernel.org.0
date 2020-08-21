Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A466B24CD55
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 07:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbgHUFpP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 01:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgHUFpP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 01:45:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7ACEC061385;
        Thu, 20 Aug 2020 22:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WaEdaKZ9Jv/QnxXxEOWWfi60iYosVWWRHu3++tbASqo=; b=i4twJXEIVwSlfld6iIvFef/uqg
        y9UKKflerwqRH5AmnCIyXg1N5elyS3i9zqg92AqxKo7cQJ4rSCU5dRoPrjlIWCwBmq6f84ynWcMbk
        UzwC6VuCzjDB+Q3tRfcTy4PzDPuLJ+ncoi8YrLKkHX611e76E9Pv4Tm8nqYtiJYy/3UBhp3Yol2p/
        1FPvgIBlCfb0Whxsa7T31/HHg5WCBgPIOROEw8U5+0WAiDtMY6SC00sAPaxNJInpDmy4leg8QYuX/
        5O+ifcPc4kaSC4dnZo+YJT7hIDRh6wUC8dnrDYNW/gmnTlFUoDYAaf8Ycj9ebe/prEpWrTLD8zycE
        7CFDF7hg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8zrQ-0007Um-WD; Fri, 21 Aug 2020 05:45:09 +0000
Date:   Fri, 21 Aug 2020 06:45:08 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v5 3/8] mm/vmalloc: rename vmap_*_range vmap_pages_*_range
Message-ID: <20200821054508.GA28291@infradead.org>
References: <20200821044427.736424-1-npiggin@gmail.com>
 <20200821044427.736424-4-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821044427.736424-4-npiggin@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 21, 2020 at 02:44:22PM +1000, Nicholas Piggin wrote:
> The vmalloc mapper operates on a struct page * array rather than a
> linear physical address, re-name it to make this distinction clear.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  mm/vmalloc.c | 28 ++++++++++++----------------
>  1 file changed, 12 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 49f225b0f855..3a1e45fd1626 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -190,9 +190,8 @@ void unmap_kernel_range_noflush(unsigned long start, unsigned long size)
>  		arch_sync_kernel_mappings(start, end);
>  }
>  
> -static int vmap_pte_range(pmd_t *pmd, unsigned long addr,
> -		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
> -		pgtbl_mod_mask *mask)
> +static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
> +		pgprot_t prot, struct page **pages, int *nr, pgtbl_mod_mask *mask)

Please don't add > 80 lines without any good reason.

