Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276C1753E78
	for <lists+linux-arch@lfdr.de>; Fri, 14 Jul 2023 17:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235801AbjGNPKI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Jul 2023 11:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235895AbjGNPKH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Jul 2023 11:10:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB1F2724;
        Fri, 14 Jul 2023 08:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gtOHiVU4MC1CWYa2sukSd0YzsCkfXWPduX4uiAi2UOQ=; b=uTP4jZTQmOWrVidF24KTuuVnua
        CFMjO/OR3oKBLtm81FmuxrP9w7NjbluwYP6YoVUnxAqTqTNJTzTQCXouHqGmcVgBaMvmC4NqvbFid
        yJSd4i8J+R5ZryZOH7mjHHnnnABU9Uk83/1wnAseadgJ6qVSzn1DPTYro4vJg1p0mmFybt2cQrrEb
        Bg+wENmWT4UgOrO3NWWXaTDivThenPExGKStEB34YUXnGaNmSVk4EKvkzL11QeSuBaaQXcRb/gJ6a
        7/ax+cP8dfUZ3VSPfMpQpP9wLhzIgytCJVXV4h+oVA/Z9BY0Uh3NVQzGZdM52RBdGDaQ+dfr26YAY
        831RyStg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qKKQY-0019L5-An; Fri, 14 Jul 2023 15:09:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B4CAC3001E7;
        Fri, 14 Jul 2023 17:09:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A47292BD04925; Fri, 14 Jul 2023 17:09:48 +0200 (CEST)
Date:   Fri, 14 Jul 2023 17:09:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     tglx@linutronix.de, axboe@kernel.dk, linux-kernel@vger.kernel.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: Re: [RFC][PATCH 05/10] mm: Add vmalloc_huge_node()
Message-ID: <20230714150948.GC3261758@hirez.programming.kicks-ass.net>
References: <20230714133859.305719029@infradead.org>
 <20230714141218.947137012@infradead.org>
 <ZLFdstLtPGcNsLGL@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLFdstLtPGcNsLGL@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 14, 2023 at 03:37:38PM +0100, Matthew Wilcox wrote:
> On Fri, Jul 14, 2023 at 03:39:04PM +0200, Peter Zijlstra wrote:
> > +void *vmalloc_huge_node(unsigned long size, gfp_t gfp_mask, int node)
> > +{
> > +	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
> > +				    gfp_mask, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
> > +				    node, __builtin_return_address(0));
> > +}
> > +
> >  /**
> >   * vmalloc_huge - allocate virtually contiguous memory, allow huge pages
> >   * @size:      allocation size
> > @@ -3430,9 +3437,7 @@ EXPORT_SYMBOL(vmalloc);
> >   */
> >  void *vmalloc_huge(unsigned long size, gfp_t gfp_mask)
> >  {
> > -	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
> > -				    gfp_mask, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
> > -				    NUMA_NO_NODE, __builtin_return_address(0));
> > +	return vmalloc_huge_node(size, gfp_mask, NUMA_NO_NODE);
> >  }
> 
> Isn't this going to result in the "caller" being always recorded as
> vmalloc_huge() instead of the caller of vmalloc_huge()?

Durr, I missed that, but it depends, not if the compiler inlines it.

I'll make a common __always_inline helper to cure this.
