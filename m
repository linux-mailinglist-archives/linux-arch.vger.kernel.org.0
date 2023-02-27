Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7197F6A4FD7
	for <lists+linux-arch@lfdr.de>; Tue, 28 Feb 2023 00:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjB0Xu7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Feb 2023 18:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB0Xu7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Feb 2023 18:50:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED87E1CF78;
        Mon, 27 Feb 2023 15:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hhWZAIlF6fKDyP0S3ixh+SYLF7C8k6DfSQC71GqLDbo=; b=h7ru2jVjhP1Mih+iVVS4dfvE5M
        khcalHp6b5AL5G5v+ZNog4NPOgDwbb/RKRbf3hwYrQ38q7lpueSts6B2JB78Z5x8tmMsbglDKDUB0
        zqOT1w6Gl4DVvypUwkIty/3QOJcINRhwmPKNGkmRnJUOoL9nZHcw2sPGdceYV6x9oFMyBTVPiVXpA
        Z/SubpBTl/6EC7vHG480+SspytkBU7I1q9pevrl9NcEx8fMiZk3GweGr7c3HI5cRfcVWixsBquGCF
        kxMUkyT5QSE83ptxH1ezTjzFCiqeC/RRP8fPC+ou2Taf21tWaJEXGqC0MWzCCxW1uU6JF+aj8fptr
        73EikYlQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWnGe-000U9E-MG; Mon, 27 Feb 2023 23:50:52 +0000
Date:   Mon, 27 Feb 2023 23:50:52 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     John David Anglin <dave.anglin@bell.net>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Subject: Re: [PATCH v2 17/30] parisc: Implement the new page table range API
Message-ID: <Y/1B3BhgZp5aHry6@casper.infradead.org>
References: <20230227175741.71216-1-willy@infradead.org>
 <20230227175741.71216-18-willy@infradead.org>
 <d97b8a56-89cc-1eb4-1298-7b16079b3b46@bell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d97b8a56-89cc-1eb4-1298-7b16079b3b46@bell.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 27, 2023 at 05:49:18PM -0500, John David Anglin wrote:
> > @@ -104,13 +104,17 @@ __update_cache(pte_t pte)
> >   	if (!pfn_valid(pfn))
> >   		return;
> > -	page = pfn_to_page(pfn);
> > -	if (page_mapping_file(page) &&
> > -	    test_bit(PG_dcache_dirty, &page->flags)) {
> > -		flush_kernel_dcache_page_addr(pfn_va(pfn));
> > -		clear_bit(PG_dcache_dirty, &page->flags);
> > +	folio = page_folio(pfn_to_page(pfn));
> > +	pfn = folio_pfn(folio);
> > +	nr = folio_nr_pages(folio);
> > +	if (folio_flush_mapping(folio) &&
> Shouldn't this call be to folio_mapping()?

For pages in the swap cache, folio_mapping() will return the swap cache
mapping, which isn't what we want.  folio_file_mapping() will return the
swap file mapping, which is also not what we want.  folio_flush_mapping()
returns NULL, which is what we want.

