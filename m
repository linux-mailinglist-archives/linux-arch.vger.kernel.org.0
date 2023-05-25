Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE487103DE
	for <lists+linux-arch@lfdr.de>; Thu, 25 May 2023 06:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbjEYEKJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 May 2023 00:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235094AbjEYEJ0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 May 2023 00:09:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF381FDB;
        Wed, 24 May 2023 21:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6udzwAg9K4Zo17ilvfnqobn9xHwMSG5Rs7tEzcXAEiI=; b=l6Ua4MgYnFd3mbz5UFnWznqeqa
        aagYos/M7qRPH6QcdREjzrKkxKTQZjwVtjFhnAviSoDuXIfKw8dLIoSH5beMQnn/PizLRHOnz0ntS
        +LXDUFKgQPfvWQSLMeuis0pQxYxGZ5/Zr+ALFMvK2So3uDcp2NqRQBNDX1u4toIi864UB+EqUmUD9
        BiqHDiXQhI/ZdjDmmoU1IZRxSqkabm3+PEJ45yaI23M7eB3CXcgSnRv9joInATNwdE+8q2M5VXqJ/
        iAatOmqEM6GCNzeGlLyc+Cazbq8chA5jsvRZm31M0UQn3EexEb4OlHt2fNHZW7oxWeab+SWZLaNKQ
        6exQRc6A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q22F2-00BpOP-FC; Thu, 25 May 2023 04:06:20 +0000
Date:   Thu, 25 May 2023 05:06:20 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v4 05/36] mm: Add default definition of set_ptes()
Message-ID: <ZG7evKeOquNaxESl@casper.infradead.org>
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-6-willy@infradead.org>
 <10c85f5c-3332-9130-c6f0-d36b9ea4b549@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10c85f5c-3332-9130-c6f0-d36b9ea4b549@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 25, 2023 at 08:31:14AM +0530, Anshuman Khandual wrote:
> > +#ifndef set_ptes
> > +#ifdef PFN_PTE_SHIFT
> > +/**
> > + * set_ptes - Map consecutive pages to a contiguous range of addresses.
> > + * @mm: Address space to map the pages into.
> > + * @addr: Address to map the first page at.
> > + * @ptep: Page table pointer for the first entry.
> > + * @pte: Page table entry for the first page.
> > + * @nr: Number of pages to map.
> > + *
> > + * May be overridden by the architecture, or the architecture can define
> > + * set_pte() and PFN_PTE_SHIFT.
> > + *
> > + * Context: The caller holds the page table lock.  The pages all belong
> > + * to the same folio.  The PTEs are all in the same PMD.
> > + */
> > +static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
> > +		pte_t *ptep, pte_t pte, unsigned int nr)
> > +{
> > +	page_table_check_ptes_set(mm, addr, ptep, pte, nr);
> > +
> > +	for (;;) {
> > +		set_pte(ptep, pte);
> > +		if (--nr == 0)
> > +			break;
> > +		ptep++;
> > +		pte = __pte(pte_val(pte) + (1UL << PFN_PTE_SHIFT));
> > +	}
> > +}
> > +#ifndef set_pte_at
> > +#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
> > +#endif
> 
> Should not there be a build phase call out when both set_ptes() and PFN_PTE_SHIFT
> are not defined on a given platform ?

How does that help?  Either way you get a clear build error.

