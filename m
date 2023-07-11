Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFED74E447
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jul 2023 04:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjGKCds (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jul 2023 22:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGKCdr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2023 22:33:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C661A2;
        Mon, 10 Jul 2023 19:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eBi5Sle1mhrJmlnMF1Qke0Mk1HZnEVe25yA516AMawM=; b=Q4EthXJNHeEea8o3FgrQLtG1sd
        y54Z8zBaxl82GvbRcHWj2OmpbYe5Uit5tGKK2T5WgLLBQkXQqdhESakQvUG/Vu6rRWbb3Vi3vGk8x
        ZEQmFOraO9nlytl+rH8xjYx0XcIjgwkf/okiniPZGJUAa2W4o1MCTLKDcH5X+SJVmrp2cwkyoDRKt
        tLRlzFKz0nBEXq/9dXdfO/DXIIXh4l+VJ84dlZcqnrj8ChN07FJAZI9YTm1lzuMAoM/N7cdSsYJnV
        G6YcYKf2DdhpmkTFX/mpmEE/+g/SiTge2ODujFR0sLl0fpUc8w1HkT3yl4kNthLyIPTupv8UgR+5L
        smyFHClQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJ3CA-00FDgX-Uj; Tue, 11 Jul 2023 02:33:42 +0000
Date:   Tue, 11 Jul 2023 03:33:42 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v5 04/38] mm: Add folio_flush_mapping()
Message-ID: <ZKy/hk/tdPftCOyc@casper.infradead.org>
References: <20230710204339.3554919-1-willy@infradead.org>
 <20230710204339.3554919-5-willy@infradead.org>
 <20230710161727.7a676996b64e9885cc15eaeb@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710161727.7a676996b64e9885cc15eaeb@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 10, 2023 at 04:17:27PM -0700, Andrew Morton wrote:
> On Mon, 10 Jul 2023 21:43:05 +0100 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:
> > +static inline struct address_space *folio_flush_mapping(struct folio *folio)
> > +{
> > +	if (unlikely(folio_test_swapcache(folio)))
> > +		return NULL;
> > +
> > +	return folio_mapping(folio);
> > +}
> 
> The name makes it sound like it flushes something.  Wouldn't
> folio_flushable_mapping() be clearer?

Yes; I wasn't a big fan of the name, but I wasn't a fan of perpetuating
the page_file_mapping / page_mapping_file confusio either.  Do you want
me to send you a set of fixup patches, or will you run them through sed
-i ?  ;-)

