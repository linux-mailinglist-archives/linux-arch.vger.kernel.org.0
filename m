Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7555931F7DD
	for <lists+linux-arch@lfdr.de>; Fri, 19 Feb 2021 12:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhBSLFG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Feb 2021 06:05:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:58844 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhBSLE5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 19 Feb 2021 06:04:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613732650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OTRsVckBIhgURh1wxvOHqT48RQQtvbtsDf7sZwxEivU=;
        b=iSROlCUJQA9gueV+ezC2yyYDcpEhx8Vh+WhCRSdUWxpE/9VFt5VFScTbjGqRuQkrp1QXHH
        M6XYcgl0KS/xAXWJZGmBVLP9W/IprMjZbr+n2aRHsSUOd14Zidae5Fxvqt4A88kyOGfK4f
        jVq2JqTX5yQL2QMHzk+gOp6bbOK2FaY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C8A8DAC6E;
        Fri, 19 Feb 2021 11:04:09 +0000 (UTC)
Date:   Fri, 19 Feb 2021 12:04:09 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>, Jann Horn <jannh@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dave Hansen <dave.hansen@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Rik van Riel <riel@surriel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, linux-alpha@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH RFC] mm/madvise: introduce MADV_POPULATE to
 prefault/prealloc memory
Message-ID: <YC+bKSQdepXhqo0T@dhcp22.suse.cz>
References: <20210217154844.12392-1-david@redhat.com>
 <YC+UaTVUn0o4Zynz@dhcp22.suse.cz>
 <6e5a5bde-cedb-9d0a-f8c1-22406085b6b9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e5a5bde-cedb-9d0a-f8c1-22406085b6b9@redhat.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri 19-02-21 11:43:48, David Hildenbrand wrote:
> On 19.02.21 11:35, Michal Hocko wrote:
> > On Wed 17-02-21 16:48:44, David Hildenbrand wrote:
> > [...]
> > 
> > I only got  to the implementation now.
> > 
> > > +static long madvise_populate(struct vm_area_struct *vma,
> > > +			     struct vm_area_struct **prev,
> > > +			     unsigned long start, unsigned long end)
> > > +{
> > > +	struct mm_struct *mm = vma->vm_mm;
> > > +	unsigned long tmp_end;
> > > +	int locked = 1;
> > > +	long pages;
> > > +
> > > +	*prev = vma;
> > > +
> > > +	while (start < end) {
> > > +		/*
> > > +		 * We might have temporarily dropped the lock. For example,
> > > +		 * our VMA might have been split.
> > > +		 */
> > > +		if (!vma || start >= vma->vm_end) {
> > > +			vma = find_vma(mm, start);
> > > +			if (!vma)
> > > +				return -ENOMEM;
> > > +		}
> > 
> > Why do you need to find a vma when you already have one. do_madvise will
> > give you your vma already. I do understand that you want to finish the
> > vma for some errors but that shouldn't require handling vmas. You should
> > be in the shope of one here unless I miss anything.
> 
> See below, we might temporary drop the lock while not having processed all
> pages
> 
> > 
> > > +
> > > +		/* Bail out on incompatible VMA types. */
> > > +		if (vma->vm_flags & (VM_IO | VM_PFNMAP) ||
> > > +		    !vma_is_accessible(vma)) {
> > > +			return -EINVAL;
> > > +		}
> > > +
> > > +		/*
> > > +		 * Populate pages and take care of VM_LOCKED: simulate user
> > > +		 * space access.
> > > +		 *
> > > +		 * For private, writable mappings, trigger a write fault to
> > > +		 * break COW (i.e., shared zeropage). For other mappings (i.e.,
> > > +		 * read-only, shared), trigger a read fault.
> > > +		 */
> > > +		tmp_end = min_t(unsigned long, end, vma->vm_end);
> > > +		pages = populate_vma_page_range(vma, start, tmp_end, &locked);
> > > +		if (!locked) {
> > > +			mmap_read_lock(mm);
> > > +			*prev = NULL;
> > > +			vma = NULL;
> 
> ^ here
> 
> so, the VMA might have been replaced/split/... in the meantime.
> 
> So to make forward progress, I have to lookup again. (similar. but different
> to madvise_dontneed_free()).

Right. Missed that.
-- 
Michal Hocko
SUSE Labs
