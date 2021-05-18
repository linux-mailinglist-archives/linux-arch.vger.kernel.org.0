Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1813238774D
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 13:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348803AbhERLTI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 07:19:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:38910 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237443AbhERLTE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 May 2021 07:19:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621336665; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=htqqSuziJ3XS9X+MDWVgpvZ0mawTjFOdRU1/fBxrQ+s=;
        b=pnHF7k6CQQbOV5RHgq7RrNLxWJrStiO8vlJjmGpwtxcxdRXPxV9qh10HYpis86wlkklfxx
        r9UknxcH6JjrK6RDrLP/P0e64UHS5OsqnlcZ402Jw6HsZ8V4JjnF2P23tAhWilJ8kQTvZb
        G2cqTXwc6VQe/dUAduYPQu+ZDaQy96Y=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 15527B127;
        Tue, 18 May 2021 11:17:45 +0000 (UTC)
Date:   Tue, 18 May 2021 13:17:43 +0200
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
        Max Filippov <jcmvbkbc@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>,
        Rolf Eike Beer <eike-kernel@sf-tec.de>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH resend v2 2/5] mm/madvise: introduce
 MADV_POPULATE_(READ|WRITE) to prefault page tables
Message-ID: <YKOiV9VkEdYFM9nB@dhcp22.suse.cz>
References: <20210511081534.3507-1-david@redhat.com>
 <20210511081534.3507-3-david@redhat.com>
 <YKOR/8LzEaOgCvio@dhcp22.suse.cz>
 <bb0e2ebb-e66d-176c-b20a-fbadd95cde98@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb0e2ebb-e66d-176c-b20a-fbadd95cde98@redhat.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue 18-05-21 12:32:12, David Hildenbrand wrote:
> On 18.05.21 12:07, Michal Hocko wrote:
> > [sorry for a long silence on this]
> > 
> > On Tue 11-05-21 10:15:31, David Hildenbrand wrote:
> > [...]
> > 
> > Thanks for the extensive usecase description. That is certainly useful
> > background. I am sorry to bring this up again but I am still not
> > convinced that READ/WRITE variant are the best interface.
> 
> Thanks for having time to look into this.
> 
> > > While the use case for MADV_POPULATE_WRITE is fairly obvious (i.e.,
> > > preallocate memory and prefault page tables for VMs), one issue is that
> > > whenever we prefault pages writable, the pages have to be marked dirty,
> > > because the CPU could dirty them any time. while not a real problem for
> > > hugetlbfs or dax/pmem, it can be a problem for shared file mappings: each
> > > page will be marked dirty and has to be written back later when evicting.
> > > 
> > > MADV_POPULATE_READ allows for optimizing this scenario: Pre-read a whole
> > > mapping from backend storage without marking it dirty, such that eviction
> > > won't have to write it back. As discussed above, shared file mappings
> > > might require an explciit fallocate() upfront to achieve
> > > preallcoation+prepopulation.
> > 
> > This means that you want to have two different uses depending on the
> > underlying mapping type. MADV_POPULATE_READ seems rather weak for
> > anonymous/private mappings. Memory backed by zero pages seems rather
> > unhelpful as the PF would need to do all the heavy lifting anyway.
> > Or is there any actual usecase when this is desirable?
> 
> Currently, userfaultfd-wp, which requires "some mapping" to be able to arm
> successfully. In QEMU, we currently have to prefault the shared zeropage for
> userfaultfd-wp to work as expected.

Just for clarification. The aim is to reduce the memory footprint at the
same time, right? If that is really the case then this is worth adding.

> I expect that use case might vanish over
> time (eventually with new kernels and updated user space), but it might
> stick for a bit.

Could you elaborate some more please?

> Apart from that, populating the shared zeropage might be relevant in some
> corner cases: I remember there are sparse matrix algorithms that operate
> heavily on the shared zeropage.

I am not sure I see why this would be a useful interface for those? Zero
page read fault is really low cost. Or are you worried about cummulative
overhead by entering the kernel many times?

> > So the split into these two modes seems more like gup interface
> > shortcomings bubbling up to the interface. I do expect userspace only
> > cares about pre-faulting the address range. No matter what the backing
> > storage is.
> > 
> > Or do I still misunderstand all the usecases?
> 
> Let me give you an example where we really cannot tell what would be best
> from a kernel perspective.
> 
> a) Mapping a file into a VM to be used as RAM. We might expect the guest
> writing all memory immediately (e.g., booting Windows). We would want
> MADV_POPULATE_WRITE as we expect a write access immediately.
> 
> b) Mapping a file into a VM to be used as fake-NVDIMM, for example, ROOTFS
> or just data storage. We expect mostly reading from this memory, thus, we
> would want MADV_POPULATE_READ.

I am afraid I do not follow. Could you be more explicit about advantages
of using those two modes for those example usecases? Is that to share
resources (e.g. by not breaking CoW)?

> Instead of trying to be smart in the kernel, I think for this case it makes
> much more sense to provide user space the options. IMHO it doesn't really
> hurt to let user space decide on what it thinks is best.

I am mostly worried that this will turn out to be more confusing than
helpful. People will need to grasp non trivial concepts and kernel
internal implementation details about how read/write faults are handled.

Thanks!
-- 
Michal Hocko
SUSE Labs
