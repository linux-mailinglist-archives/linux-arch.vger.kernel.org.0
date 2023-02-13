Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8957694AD5
	for <lists+linux-arch@lfdr.de>; Mon, 13 Feb 2023 16:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjBMPQe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Feb 2023 10:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjBMPQc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Feb 2023 10:16:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AA01E5E8
        for <linux-arch@vger.kernel.org>; Mon, 13 Feb 2023 07:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=V8mVIgS1WiaMF9eNsPnfVifYmMvN5+MFQdtCI1uWXnc=; b=NUGzBDPfDygATgByXS5fWC9PfF
        8AY3wPQBs21++97GyKYnNUId6Lc3j+9jqddifXMJxz0e4rl87hWhTu4QO9sYTn+biQYtsA1v1Pu69
        wA4HDD4N3M/FmbJHdf7VVZTznMQHkOxJlIay0SkR/PPVmj20dfAsJsjmQ5AjNoJ+PByJ/V8CmIfh4
        eb+8KAr+oLjtXESTLZ+AzIE91Nk6EA20Ogjr7OW4SisEh9JEAWarJ0qT4kKQxHWCwENMUrEl99j3v
        fWhYM5Y7HweXoG3rll00ZXES2PMUYvOpLWcuHwcROycpbDYyFmzNL+Osexk2MPTDcczuDoJY5Pt2u
        bsWudaFg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRaYr-005sKE-8N; Mon, 13 Feb 2023 15:16:09 +0000
Date:   Mon, 13 Feb 2023 15:16:09 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 6/7] arc: Implement the new page table range API
Message-ID: <Y+pUOVc4DFPX6119@casper.infradead.org>
References: <20230211033948.891959-1-willy@infradead.org>
 <20230211033948.891959-7-willy@infradead.org>
 <8a84172a5007b568392b2040e889780da198e20f.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a84172a5007b568392b2040e889780da198e20f.camel@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 13, 2023 at 03:09:37AM +0000, Yin, Fengwei wrote:
> > +++ b/arch/arc/include/asm/cacheflush.h
> > @@ -25,17 +25,20 @@
> >   * in update_mmu_cache()
> >   */
> >  #define flush_icache_page(vma, page)
> > +#define flush_icache_pages(vma, page, nr)
> Maybe just remove these two definitions because general
> implementation is just no-op?

Then arc would have to include asm-generic/cacheflush.h and I don't
particularly want to debug any issues that might cause.  This is
easier.

Long term, asm-generic/cacheflush.h's contents should be moved into
linux/cacheflush.h, but I've lacked the time to do that work.

To answer your question from the other email, the documentation says:

  ``void flush_icache_page(struct vm_area_struct *vma, struct page *page)``

        All the functionality of flush_icache_page can be implemented in
        flush_dcache_page and update_mmu_cache_range. In the future, the hope
        is to remove this interface completely.

I'm not planning on doing that to an architecture that I'm not set up
to test ...

> > +void flush_dcache_page(struct page *page)
> > +{
> > +       return flush_dcache_folio(page_folio(page));
> > +}
> I am wondering whether we should add flush_dcache_folio_range()
> because it's possible just part of folio needs be flush. Thanks.

We could.  I think it's up to the maintainers of architectures that
need their caches flushing to let us know what would be good for them.
Since I primarily work on x86, I have no personal desire to do this ;-)

One of the things that I've always found a little weird about
flush_dcache_page() (and now flush_dcache_folio()) is that it's used both
for flushing userspace writes (eg in filemap_read()) and for flushing
kernel writes (eg in __iomap_write_end()).  Probably it was designed for
an architecture that flushes by physical address rather than by virtual.

Anyway, if we do have a flush_dcache_folio_kernel(), I'd like it
to take byte offsets.  That would work well for __iomap_write_end();
it could be:

	flush_dcache_folio_kernel(folio, offset_in_folio(folio, pos), len);

But I'm not volunteering to do this work.
