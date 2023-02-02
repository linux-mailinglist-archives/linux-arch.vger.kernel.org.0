Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187FE6888D6
	for <lists+linux-arch@lfdr.de>; Thu,  2 Feb 2023 22:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbjBBVO1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Feb 2023 16:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjBBVO1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Feb 2023 16:14:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9867D5A373
        for <linux-arch@vger.kernel.org>; Thu,  2 Feb 2023 13:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=6gOmrh6KL+tVKssvgltz89sdjPllEw7CiVRL9HRHcFs=; b=jdCCdDnhIdyx9NMQjJbhl3GGlC
        0e5dQ2o9tFhAPmeoe/nn/Ig54P05PiOmN8xl83uKlIEaYignMdKlC9oT2Ga+l+wZHDlqqptHydY5R
        ojo/dWUZm+Fi86iQlNOTp9WdqKSscd/owCjDqbb5vZI1l6iRRiiIRr9GC3eS/vPKdlAYgCsi7un0u
        l6z0mc3bhlM+ObclMlvhsIfyD6hzHWodlkdYoe7T9KUxTgpqIdUdjVKrrWYPijvZbkrRj6o2CyKx2
        7Obyw7DiXVnUCpyinvs4Zsf5Kwax/QzXtPta8RvLR9qhrQ+eDQh4S88geRhYyN1GVge42GVUvHzF8
        dj52WncQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNguV-00DjIY-MF; Thu, 02 Feb 2023 21:14:23 +0000
Date:   Thu, 2 Feb 2023 21:14:23 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-arch@vger.kernel.org
Cc:     Yin Fengwei <fengwei.yin@intel.com>, linux-mm@kvack.org
Subject: API for setting multiple PTEs at once
Message-ID: <Y9wnr8SGfGGbi/bk@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

For those of you not subscribed, linux-mm is currently discussing
how best to handle page faults on large folios.  I simply made it work
when adding large folio support.  Now Yin Fengwei is working on
making it fast.

https://lore.kernel.org/linux-mm/Y9qjn0Y+1ir787nc@casper.infradead.org/
is perhaps the best place to start as it pertains to what the
architecture will see.

At the bottom of that function, I propose

+       for (i = 0; i < nr; i++) {
+               set_pte_at(vma->vm_mm, addr, vmf->pte + i, entry);
+               /* no need to invalidate: a not-present page won't be cached */
+               update_mmu_cache(vma, addr, vmf->pte + i);
+               addr += PAGE_SIZE;
+		entry = pte_next(entry);
+	}

(or I would have, had I not forgotten that pte_t isn't an integral type)

But I think that some architectures want to mark PTEs specially for
"This is part of a contiguous range" -- ARM, perhaps?  So would you like
an API like:

	arch_set_ptes(mm, addr, vmf->pte, entry, nr);
	update_mmu_cache_range(vma, addr, vmf->pte, nr);

There are some challenges here.  For example, folios may be mapped
askew (ie not naturally aligned).  Another problem is that folios may
be unmapped in part (eg mmap(), fault, followed by munmap() of one of
the pages in the folio), and I presume you'd need to go and unmark the
other PTEs in that case.  So it's not as simple as just checking whether
'addr' and 'nr' are in some way compatible.
