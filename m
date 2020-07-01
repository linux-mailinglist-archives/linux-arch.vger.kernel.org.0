Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770A12111F0
	for <lists+linux-arch@lfdr.de>; Wed,  1 Jul 2020 19:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgGARaH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Jul 2020 13:30:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726432AbgGARaH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 1 Jul 2020 13:30:07 -0400
Received: from gaia (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAE4020771;
        Wed,  1 Jul 2020 17:30:04 +0000 (UTC)
Date:   Wed, 1 Jul 2020 18:30:02 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v5 06/25] mm: Add PG_ARCH_2 page flag
Message-ID: <20200701173001.GG5191@gaia>
References: <20200624175244.25837-1-catalin.marinas@arm.com>
 <20200624175244.25837-7-catalin.marinas@arm.com>
 <20200624113307.6165b3db2404c9d37b870a90@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624113307.6165b3db2404c9d37b870a90@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 24, 2020 at 11:33:07AM -0700, Andrew Morton wrote:
> On Wed, 24 Jun 2020 18:52:25 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:
> > From: Steven Price <steven.price@arm.com>
> > For arm64 MTE support it is necessary to be able to mark pages that
> > contain user space visible tags that will need to be saved/restored e.g.
> > when swapped out.
> > 
> > To support this add a new arch specific flag (PG_ARCH_2) that arch code
> > can opt into using ARCH_USES_PG_ARCH_2.
> > 
> > ...
> >
> > --- a/fs/proc/page.c
> > +++ b/fs/proc/page.c
> > @@ -217,6 +217,9 @@ u64 stable_page_flags(struct page *page)
> >  	u |= kpf_copy_bit(k, KPF_PRIVATE_2,	PG_private_2);
> >  	u |= kpf_copy_bit(k, KPF_OWNER_PRIVATE,	PG_owner_priv_1);
> >  	u |= kpf_copy_bit(k, KPF_ARCH,		PG_arch_1);
> > +#ifdef CONFIG_ARCH_USES_PG_ARCH_2
> > +	u |= kpf_copy_bit(k, KPF_ARCH_2,	PG_arch_2);
> > +#endif
> 
> Do we need CONFIG_ARCH_USES_PG_ARCH_2?  What would be the downside to
> giving every architecture a PG_arch_2, but only arm64 uses it (at
> present)?

It turns out we have another issue with this flag. PG_arch_2 in the
arm64 MTE patches is used to mark a page as having valid tags. During
set_pte_at(), if the mapping type is tagged, we set PG_arch_2 (also
setting it in other cases like copy_page). In combination with THP and
swap (and some stress-testing to force swap-out), the kernel ends up
clearing PG_arch_2 in __split_huge_page_tail(), causing a subsequent
set_pte_at() to zero valid tags stored by user.

The quick fix is to add an arch_huge_page_flags_split_preserve macro
(need to think of a shorter name) which adds 1L << PG_arch_2 to the
preserve list in the above mentioned function. However, I wonder whether
it's safe to add both PG_arch_1 and PG_arch_2 to this list. At least on
arm and arm64, PG_arch_1 is used to mark a page as D-cache clean (and
don't need to do this again after splitting a pmd):

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 78c84bee7e29..22b3236a6dd8 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2364,6 +2364,10 @@ static void __split_huge_page_tail(struct page *head, int tail,
 			 (1L << PG_workingset) |
 			 (1L << PG_locked) |
 			 (1L << PG_unevictable) |
+			 (1L << PG_arch_1) |
+#ifdef CONFIG_64BIT
+			 (1L << PG_arch_2) |
+#endif
 			 (1L << PG_dirty)));
 
 	/* ->mapping in first tail page is compound_mapcount */

Thanks.

-- 
Catalin
