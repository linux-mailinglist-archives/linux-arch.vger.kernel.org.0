Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647FA31E94F
	for <lists+linux-arch@lfdr.de>; Thu, 18 Feb 2021 12:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhBRLtj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Feb 2021 06:49:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:48272 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231136AbhBRLox (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 18 Feb 2021 06:44:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613647635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zuwQBQ0eN1vbAJ0hrPHQrgVEhJ4oyo21RiNIpApCdo4=;
        b=tXVhBYqNnIFX8gt1HeRn+uWTPOK96S7hlT8FsyCadH6e5Hl59Gyp172qIE2s8Kie9JrZb8
        ndlq6z1B8i2FHdFFuo206gbqxJXVeN81eqORk2/x7s8xHSl+bWdjhitpSggZGKIwW/X3iY
        rQf5Fom5nfM69pdLPY6I0Z3pF3UIXs8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 461D6ADE3;
        Thu, 18 Feb 2021 11:27:15 +0000 (UTC)
Date:   Thu, 18 Feb 2021 12:27:12 +0100
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
Message-ID: <YC5PEBiGKT5LUt/I@dhcp22.suse.cz>
References: <20210217154844.12392-1-david@redhat.com>
 <YC5Am6a4KMSA8XoK@dhcp22.suse.cz>
 <3763a505-02d6-5efe-a9f5-40381acfbdfd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3763a505-02d6-5efe-a9f5-40381acfbdfd@redhat.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu 18-02-21 11:44:41, David Hildenbrand wrote:
> On 18.02.21 11:25, Michal Hocko wrote:
> > On Wed 17-02-21 16:48:44, David Hildenbrand wrote:
> > > When we manage sparse memory mappings dynamically in user space - also
> > > sometimes involving MADV_NORESERVE - we want to dynamically populate/
> > 
> > Just wondering what is MADV_NORESERVE? I do not see anything like that
> > in the Linus tree. Did you mean MAP_NORESERVE?
> 
> Most certainly, thanks :)

OK, good, I thought I have missed something.
[...]
> > > 2. Errors during MADV_POPULATED (especially OOM) are reported.
> > 
> > How do you want to achieve that? gup/page fault handler will allocate
> > memory and trigger the oom without caller noticing that. You would
> > somehow have to weaken the allocation context to GFP_RETRY_MAYFAIL or
> > NORETRY to achieve the error handling.
> 
> Okay, I should be more clear here (again, I'm realizing this as well while I
> create the man page), OOM is confusing: avoid SIGBUS at runtime - like we
> would get on actual file systems/shmem/hugetlbfs when preallocating.

Yes, preventing SIGBUS for unreserved mappings is a reasonable
expectation. Regarding OOM chances are off I am afraid. We used to have
a weaker model for MAP_POPULATE for memcg oom in the past and it turned
out more problematic than useful.
 
> It cannot save us from the actual OOM killer. To handle anonymous memory
> more reliable I'll need other means as well (dynamic swap space allocation
> for sparse mappings).
> 
> > 
> > >     If we hit
> > >     hardware errors on pages, ignore them - nothing we really can or
> > >     should do.
> > > 3. On errors during MADV_POPULATED, some memory might have been
> > >     populated. Callers have to clean up if they care.
> > 
> > How does caller find out? madvise reports 0 on success so how do you
> > find out how much has been populated?
> 
> If there is an error, something might have been populated. In my QEMU
> implementation, I simply discard the range again, good enough. I don't think
> we need to really indicate "error and populated" or "error and not
> populated".

Agreed. The wording just suggests that the syscall actually provides any
means for an effective way to handle those errors. Maybe you should just
stick with the first sentence and drop the second.
 
> > > 4. Concurrent changes to the virtual memory layour are tolerated - we
> > >     process each and every PFN only once, though.
> > 
> > I do not understand this. madvise is about virtual address space not a
> > physical address space.
> 
> What I wanted to express: if we detect a change in the mapping we don't
> restart at the beginning, we always make forward progress. We process each
> virtual address once (on a per-page basis, thus I accidentally used "PFN").

This is an implicit assumption. Your range can have the same page mapped
several times in the given address range and all you care about is that
you fault those which are not present during the virtual address space
walk. Your syscall can return and large part of the address space might
be unpopulated because memory reclaim just dropped those pages and that
would be fine. This shouldn't really imply memory presence - mlock does
that.

> > > 5. If MADV_POPULATE succeeds, all memory in the range can be accessed
> > >     without SIGBUS. (of course, not if user space changed mappings in the
> > >     meantime or KSM kicked in on anonymous memory).
> > 
> > I do not see how KSM would change anything here and maybe it is not
> > really important to mention it. KSM should be really transparent from
> > the users space POV. Parallel and destructive virtual address space
> > operations are also expected to change the outcome and there is nothing
> > kernel do about at and provide any meaningful guarantees. I guess we
> > want to assume a reasonable userspace behavior here.
> 
> It's just a note that we cannot protect from someone interfering
> (discard/ksm/whatever). I'm making that clearer in the cover letter.

Again that is implicit expectation. madvise will not work for anybody
shooting an own foot.

-- 
Michal Hocko
SUSE Labs
