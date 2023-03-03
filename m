Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2AC6A99A4
	for <lists+linux-arch@lfdr.de>; Fri,  3 Mar 2023 15:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjCCOhH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Mar 2023 09:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjCCOg5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Mar 2023 09:36:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C15C618A0;
        Fri,  3 Mar 2023 06:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RNF7tIvXrJlST0kgsjuf3CReNXFRNJwUAA+6JXLdxxA=; b=djGddxHuTTz+lnBhzse5Zv9A6R
        4PE0Mf/b99KsEleETaVhuWyZV2GcBmsT9v2DM53l92xwzgApSh6dpsxAwy2Bxr3LHJrgvFy30Adk+
        OWSw7vMzkwamYU8ABPIb0zM9hEU7xzmYK64QNUQD5xb5wlT9yVMNCePKbbOP61+lo8yTXn1w24Asn
        IeYo3RoAM6MBuTun6GrSJSXG4N2gTnAW7y6ctc4oxGMB5hYzhTPGJC4mIjYRxucl4/+6sdewQ4PNg
        7a4wmrbtS6ajDcUQecqWOH+lkuoZzeOy7SWvNAj9o63WSefpjgLaeXO9zqvNRwIbLygVV7VGRy0r3
        v4c81f4g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pY6W2-003BLG-H2; Fri, 03 Mar 2023 14:36:10 +0000
Date:   Fri, 3 Mar 2023 14:36:10 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH v3 11/34] ia64: Implement the new page table range API
Message-ID: <ZAIF2t8HxjUm/45d@casper.infradead.org>
References: <20230228213738.272178-1-willy@infradead.org>
 <20230228213738.272178-12-willy@infradead.org>
 <ZAHgdEzqWk4Peyjh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAHgdEzqWk4Peyjh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 03, 2023 at 01:56:36PM +0200, Mike Rapoport wrote:
> On Tue, Feb 28, 2023 at 09:37:14PM +0000, Matthew Wilcox (Oracle) wrote:
> >  void arch_dma_mark_clean(phys_addr_t paddr, size_t size)
> >  {
> > -	unsigned long pfn = PHYS_PFN(paddr);
> > +	struct folio *folio = page_folio(phys_to_page(paddr));
> > +	ssize_t left = size;
> > +	size_t offset = offset_in_folio(folio, paddr);
> 
> Build of defconfig failed miserably for me without this:
> 
> diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
> index 12aef25944aa..0775e7870257 100644
> --- a/arch/ia64/mm/init.c
> +++ b/arch/ia64/mm/init.c
> @@ -69,7 +69,8 @@ __ia64_sync_icache_dcache (pte_t pte)
>   */
>  void arch_dma_mark_clean(phys_addr_t paddr, size_t size)
>  {
> -	struct folio *folio = page_folio(phys_to_page(paddr));
> +	unsigned long pfn = __phys_to_pfn(paddr);
> +	struct folio *folio = page_folio(pfn_to_page(pfn));

Huh, TIL that only some architectures have phys_to_page().  Thanks.
I'm going to use PHYS_PFN instead of __phys_to_pfn just to reduce the
diff.
