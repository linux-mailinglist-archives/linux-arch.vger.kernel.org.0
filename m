Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E21698B6B
	for <lists+linux-arch@lfdr.de>; Thu, 16 Feb 2023 05:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjBPE0l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Feb 2023 23:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBPE0k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Feb 2023 23:26:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D15A279B6;
        Wed, 15 Feb 2023 20:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9IVaVEssNR1Z/xVlw2ViDA0u+idnnENfCzM0p7ONhTQ=; b=cO/RpxJ6MbGG9NDBInzvT+5LU9
        pW/78jvZtKVH3JYvQOhmjchLBex7AungcS3M7cVyIkHjLR81MOoYZ5JGINoaLhCYD3Yft2U+UVaXa
        Yw/9HJmMQ2GkZq/QQEjHzXdlAs67RQDwf1qwE8iWVb9+WP86B3lRlQUVkyjv+Uz+vSj3eTssI7Xt4
        i4N8n8bTDvzHTCgtg6iChWV/NHINr3PIL9FqIHAbyvfeJ6XQT+Yj1NYS35IG3jq/hknnq6OaJSuV2
        IqEaNkHRXUzLcHrbjWE4VWtVP4FnQW47y2ZGvFZOWK8toz0Lvqm1/8AVhS/SlW0QyjR5sJSlHyaxD
        s8lidsKw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pSVqn-0085Gc-9F; Thu, 16 Feb 2023 04:26:29 +0000
Date:   Thu, 16 Feb 2023 04:26:29 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     linux-mm@kvack.org, linux-m68k@lists.linux-m68k.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 15/17] m68k: Implement the new page table range API
Message-ID: <Y+2wdSxVgS6HmFRy@casper.infradead.org>
References: <20230215000446.1655635-1-willy@infradead.org>
 <20230215200920.1849567-1-willy@infradead.org>
 <20230215200920.1849567-2-willy@infradead.org>
 <84c923f7-c60b-068d-bb06-48aea1412f53@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84c923f7-c60b-068d-bb06-48aea1412f53@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 16, 2023 at 01:59:44PM +1300, Michael Schmitz wrote:
> Matthew,
> 
> On 16/02/23 09:09, Matthew Wilcox (Oracle) wrote:
> > Add set_ptes(), update_mmu_cache_range(), flush_icache_pages() and
> > flush_dcache_folio().  I'm not entirely certain that the 040/060 case
> > in __flush_pages_to_ram() is correct.
> 
> I'm pretty sure you need to iterate to hit each of the pages - the code as
> is will only push cache entries for the first page.
> 
> Quoting the 040 UM:
> 
> "Both instructions [cinv, cpush] allow operation on a single cache line, all
> cache lines in a specific page, or an entire cache, and can select one or
> both caches for the operation. For line and page operations, a physical
> address in an address register specifies the memory address."

I actually found that!  What I didn't find was how to tell if this
cpush insn is the one which is operating on a single cache line,
a single page, or the entire cache.

So I should do a loop around this asm and call it once for each page
we're flushing?

