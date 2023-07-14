Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53987753DA1
	for <lists+linux-arch@lfdr.de>; Fri, 14 Jul 2023 16:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236065AbjGNOhp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Jul 2023 10:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236039AbjGNOho (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Jul 2023 10:37:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30DB134;
        Fri, 14 Jul 2023 07:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fwMtJhD650GS2lSKMkJ/a0kXZxCufQOcNDJN76I6F4A=; b=s6y4CQQfqU01g9T0DiOQ44nh71
        zXoHA7GnnmatL3Nm7jZ+VAdR8IWWw4X+D5NfISmpI8Qabv6QQhQyOhHHlQp1kmrjP0tW6EFRhVZhw
        2DngGxMq+0yQSLpZJUMkTo59y2j7lj/m1XcMdsHAvM0ai5f4fsKe+r+fUWuiXTuOhZt4J2ZBHU2q3
        8X7kOVa3KGZuMTvNkNEuSonLYMx1lGU+EDRAWmlI8EOkoGhWl3v0dCeXnWXUfhOy9+2Z6TYT2VB68
        9wcLAAEq0/gGV5Yo/vw+C3jHt/68QKWIXsB5H615s6jLq9FqwD7fLZmRPFG+EWxwBNRRxPzgLztuq
        rb5jZfmQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qKJvO-0017zR-It; Fri, 14 Jul 2023 14:37:38 +0000
Date:   Fri, 14 Jul 2023 15:37:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, axboe@kernel.dk, linux-kernel@vger.kernel.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: Re: [RFC][PATCH 05/10] mm: Add vmalloc_huge_node()
Message-ID: <ZLFdstLtPGcNsLGL@casper.infradead.org>
References: <20230714133859.305719029@infradead.org>
 <20230714141218.947137012@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714141218.947137012@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 14, 2023 at 03:39:04PM +0200, Peter Zijlstra wrote:
> +void *vmalloc_huge_node(unsigned long size, gfp_t gfp_mask, int node)
> +{
> +	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
> +				    gfp_mask, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
> +				    node, __builtin_return_address(0));
> +}
> +
>  /**
>   * vmalloc_huge - allocate virtually contiguous memory, allow huge pages
>   * @size:      allocation size
> @@ -3430,9 +3437,7 @@ EXPORT_SYMBOL(vmalloc);
>   */
>  void *vmalloc_huge(unsigned long size, gfp_t gfp_mask)
>  {
> -	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
> -				    gfp_mask, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
> -				    NUMA_NO_NODE, __builtin_return_address(0));
> +	return vmalloc_huge_node(size, gfp_mask, NUMA_NO_NODE);
>  }

Isn't this going to result in the "caller" being always recorded as
vmalloc_huge() instead of the caller of vmalloc_huge()?
