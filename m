Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E7124CD5B
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 07:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgHUFq4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 01:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgHUFq4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 01:46:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E93DC061385;
        Thu, 20 Aug 2020 22:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VGKvwxaQDiLZ+z37bijIYhoz/siCPi3OExDmTDYH7nw=; b=wC3e5XpWvIWwRrMAoxzR+b2PiV
        z2iL40tRUvmYqeJL2njjkYiwldy8/QjNlLBDodSEkKhGdYnKN+vfERf/y3xYrBq4ZN7A41b5VPdpu
        hW2w9ZlKXGK2YdMyBoy0Oi8JSF3D1n00ROt/mOGgHUmLSBvsS5Coq6GgAfXqp9rIPBcG/YnVzJqJ+
        9EDBa2dkPeYJ2+ptbTxuV7fSkwS/vspYT7qYRufcu8LzH2tLSyCmOPdyc0aqp1C5YrycPg8+S2SZU
        hHFGfai1g55qIDHxdfEzT9/QAHI+fyvVw9kTqpJ53Lw2DuU9H/qoc5FgqUAUyrAQCEAz3DUEM4SYv
        i7VMp5PA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8zt7-0007aH-FN; Fri, 21 Aug 2020 05:46:53 +0000
Date:   Fri, 21 Aug 2020 06:46:53 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v5 6/8] mm: Move vmap_range from lib/ioremap.c to
 mm/vmalloc.c
Message-ID: <20200821054653.GD28291@infradead.org>
References: <20200821044427.736424-1-npiggin@gmail.com>
 <20200821044427.736424-7-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821044427.736424-7-npiggin@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 21, 2020 at 02:44:25PM +1000, Nicholas Piggin wrote:
> This is a generic kernel virtual memory mapper, not specific to ioremap.

lib/ioremap doesn't exist any more.

> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  include/linux/vmalloc.h |   2 +
>  mm/ioremap.c            | 192 ----------------------------------------
>  mm/vmalloc.c            | 191 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 193 insertions(+), 192 deletions(-)
> 
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 787d77ad7536..e3590e93bfff 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -181,6 +181,8 @@ extern struct vm_struct *remove_vm_area(const void *addr);
>  extern struct vm_struct *find_vm_area(const void *addr);
>  
>  #ifdef CONFIG_MMU
> +extern int vmap_range(unsigned long addr, unsigned long end, phys_addr_t phys_addr, pgprot_t prot,
> +			unsigned int max_page_shift);

Please avoid the pointlessly long line.  And don't add the pointless
extern.
