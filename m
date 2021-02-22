Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9113217D0
	for <lists+linux-arch@lfdr.de>; Mon, 22 Feb 2021 14:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbhBVNAH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Feb 2021 08:00:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:49322 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231685AbhBVM7L (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Feb 2021 07:59:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613998687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VapX0P1cjmfTsM5vWm6XJfMkWbyfERrb6gAU3Sl6W4Q=;
        b=WJkXS1MRD8pmy72Tqm8tbLj4R9dTBxozMzQZtygXtuV4ch1Z4xqZsV9zWtePWU+3bU2bTa
        o+K5m3839jIF7PigP8a7p2FBcw0YyQiTe/A055r3eVYeXRHhAJ9DL6F0hly9nbPqxMVTqo
        ZD1DSkJ2z7GHZJcsJHgnMOzqIX3Awrc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1D631AE1C;
        Mon, 22 Feb 2021 12:58:07 +0000 (UTC)
Date:   Mon, 22 Feb 2021 13:56:35 +0100
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
Message-ID: <YDOqA9nQHiuIrKBu@dhcp22.suse.cz>
References: <20210217154844.12392-1-david@redhat.com>
 <640738b5-a47e-448b-586d-a1fb80131891@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <640738b5-a47e-448b-586d-a1fb80131891@redhat.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat 20-02-21 10:12:26, David Hildenbrand wrote:
[...]
> Thinking about MADV_POPULATE vs. MADV_POPULATE_WRITE I wonder if it would be
> more versatile to break with existing MAP_POPULATE semantics and directly go
> with
> 
> MADV_POPULATE_READ: simulate user space read access without actually
> reading. Trigger a read fault if required.
> 
> MADV_POPULATE_WRITE: simulate user space write access without actually
> writing. Trigger a write fault if required.
> 
> For my use case, I could use MADV_POPULATE_WRITE on anonymous memory and
> RAM-backed files (shmem/hugetlb) - I would not have a minor fault when the
> guest inside the VM first initializes memory. This mimics how QEMU currently
> preallocates memory.
> 
> However, I would use MADV_POPULATE_READ on any !RAM-backed files where we
> actually have to write-back to a (slow?) device. Dirtying everything
> although the guest might not actually consume it in the near future might be
> undesired.

Isn't what the current mm_populate does?
        if ((vma->vm_flags & (VM_WRITE | VM_SHARED)) == VM_WRITE)
                gup_flags |= FOLL_WRITE;

So it will write fault to shared memory mappings but it will touch
others.

-- 
Michal Hocko
SUSE Labs
