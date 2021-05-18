Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C226A38761A
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 12:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242182AbhERKJV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 06:09:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:37960 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348390AbhERKJU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 May 2021 06:09:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621332481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gigLto3lPv80FBXCxS3AVF3qLiXYEjmKtIPmgS5Cpus=;
        b=rO1X3eI4OIacPcCVcwRsqXTr7RBYSjw1S9LpAfLKyZFW7yqJTB5gDPbzF+U9Tt1ai2tN3Q
        JKfht12ARMgFgTtq52DowvkKXf3UiQV9CBdNqcwLR9X3GPBHdhqPg1io7tGbr5bzKIyiMU
        7AHrYmrt5Gsl7DQ5vh15i/vJ2SvvL28=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CDC14B1F7;
        Tue, 18 May 2021 10:08:00 +0000 (UTC)
Date:   Tue, 18 May 2021 12:07:59 +0200
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
Message-ID: <YKOR/8LzEaOgCvio@dhcp22.suse.cz>
References: <20210511081534.3507-1-david@redhat.com>
 <20210511081534.3507-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511081534.3507-3-david@redhat.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

[sorry for a long silence on this]

On Tue 11-05-21 10:15:31, David Hildenbrand wrote:
[...]

Thanks for the extensive usecase description. That is certainly useful
background. I am sorry to bring this up again but I am still not
convinced that READ/WRITE variant are the best interface.
 
> While the use case for MADV_POPULATE_WRITE is fairly obvious (i.e.,
> preallocate memory and prefault page tables for VMs), one issue is that
> whenever we prefault pages writable, the pages have to be marked dirty,
> because the CPU could dirty them any time. while not a real problem for
> hugetlbfs or dax/pmem, it can be a problem for shared file mappings: each
> page will be marked dirty and has to be written back later when evicting.
> 
> MADV_POPULATE_READ allows for optimizing this scenario: Pre-read a whole
> mapping from backend storage without marking it dirty, such that eviction
> won't have to write it back. As discussed above, shared file mappings
> might require an explciit fallocate() upfront to achieve
> preallcoation+prepopulation.

This means that you want to have two different uses depending on the
underlying mapping type. MADV_POPULATE_READ seems rather weak for
anonymous/private mappings. Memory backed by zero pages seems rather
unhelpful as the PF would need to do all the heavy lifting anyway.
Or is there any actual usecase when this is desirable?

So the split into these two modes seems more like gup interface
shortcomings bubbling up to the interface. I do expect userspace only
cares about pre-faulting the address range. No matter what the backing
storage is. 

Or do I still misunderstand all the usecases?
-- 
Michal Hocko
SUSE Labs
