Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B971209E25
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jun 2020 14:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404485AbgFYMJy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Jun 2020 08:09:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404466AbgFYMJx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Jun 2020 08:09:53 -0400
Received: from gaia (unknown [2.26.170.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6109A20720;
        Thu, 25 Jun 2020 12:09:51 +0000 (UTC)
Date:   Thu, 25 Jun 2020 13:09:48 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>
Subject: Re: [PATCH v5 21/25] mm: Add arch hooks for saving/restoring tags
Message-ID: <20200625120931.GB14812@gaia>
References: <20200624175244.25837-1-catalin.marinas@arm.com>
 <20200624175244.25837-22-catalin.marinas@arm.com>
 <20200624114534.9520ba5ed235bc32bf1af3a2@linux-foundation.org>
 <40250ed8-50fe-3945-d7d3-331e03b2abe8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40250ed8-50fe-3945-d7d3-331e03b2abe8@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 25, 2020 at 10:04:59AM +0100, Steven Price wrote:
> On 24/06/2020 19:45, Andrew Morton wrote:
> > On Wed, 24 Jun 2020 18:52:40 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:
> > 
> > > From: Steven Price <steven.price@arm.com>
> > > 
> > > Arm's Memory Tagging Extension (MTE) adds some metadata (tags) to
> > > every physical page, when swapping pages out to disk it is necessary to
> > > save these tags, and later restore them when reading the pages back.
> > > 
> > > Add some hooks along with dummy implementations to enable the
> > > arch code to handle this.
> > > 
> > > Three new hooks are added to the swap code:
> > >   * arch_prepare_to_swap() and
> > >   * arch_swap_invalidate_page() / arch_swap_invalidate_area().
> > > One new hook is added to shmem:
> > >   * arch_swap_restore_tags()
> > > 
> > > ...
> > > 
> > > --- a/include/linux/pgtable.h
> > > +++ b/include/linux/pgtable.h
> > > @@ -631,6 +631,29 @@ static inline int arch_unmap_one(struct mm_struct *mm,
> > >   }
> > >   #endif
> > > +#ifndef __HAVE_ARCH_PREPARE_TO_SWAP
> > > +static inline int arch_prepare_to_swap(struct page *page)
> > > +{
> > > +	return 0;
> > > +}
> > > +#endif
> > > +
> > > +#ifndef __HAVE_ARCH_SWAP_INVALIDATE
> > > +static inline void arch_swap_invalidate_page(int type, pgoff_t offset)
> > > +{
> > > +}
> > > +
> > > +static inline void arch_swap_invalidate_area(int type)
> > > +{
> > > +}
> > > +#endif
> > > +
> > > +#ifndef __HAVE_ARCH_SWAP_RESTORE_TAGS
> > > +static inline void arch_swap_restore_tags(swp_entry_t entry, struct page *page)
> > > +{
> > > +}
> > > +#endif
> > 
> > Presumably these three __HAVE_ARCH_ macros are to be defined in asm/pgtable.h?
> 
> That would be the idea (see patch 22). However:
> 
> Catalin - you've renamed __HAVE_ARCH_SWAP_RESTORE_TAGS in patch 22, but not
> here!

This was meant to be arch_swap_restore() and __HAVE_ARCH_SWAP_RESTORE
(no tags suffix) and it was originally in include/asm-generic/pgtable.h.
With Mike's recent reworking getting rid of this file, I messed up the
conflict resolution during rebase and re-introduced this file in patch
22. I'll fix it up, it needs to be only in include/linux/pgtable.h.

-- 
Catalin
