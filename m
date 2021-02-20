Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2263B3204A4
	for <lists+linux-arch@lfdr.de>; Sat, 20 Feb 2021 10:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhBTJON (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 20 Feb 2021 04:14:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32903 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229724AbhBTJOL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sat, 20 Feb 2021 04:14:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613812363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q+4sbPhwjmEGA0Ylf/8EG+5ZbWARkZJc1n0ED7XVLRQ=;
        b=ENzDBrQoYwgTGD7n+ApQ93cytz1VbZtIYsELrFNgXXM8K5pqracVmBKCZOv165vxmmgwg0
        BQibKmc1w63vPtkLkgcovJd251bJMvd+C5kZbPHK3e9PmgpHAgJb7FQeg4bhUxTmfvXpkp
        YZ6xgCzMJWM+k/Nmj6gC750DGW9dmw8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-HQenhpFIOhyHNBOxr81O4g-1; Sat, 20 Feb 2021 04:12:39 -0500
X-MC-Unique: HQenhpFIOhyHNBOxr81O4g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42E988030B7;
        Sat, 20 Feb 2021 09:12:36 +0000 (UTC)
Received: from [10.36.112.45] (ovpn-112-45.ams2.redhat.com [10.36.112.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E79E15C238;
        Sat, 20 Feb 2021 09:12:26 +0000 (UTC)
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Michal Hocko <mhocko@suse.com>,
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
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, linux-alpha@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org
References: <20210217154844.12392-1-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH RFC] mm/madvise: introduce MADV_POPULATE to
 prefault/prealloc memory
Message-ID: <640738b5-a47e-448b-586d-a1fb80131891@redhat.com>
Date:   Sat, 20 Feb 2021 10:12:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210217154844.12392-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 17.02.21 16:48, David Hildenbrand wrote:
> When we manage sparse memory mappings dynamically in user space - also
> sometimes involving MADV_NORESERVE - we want to dynamically populate/
> discard memory inside such a sparse memory region. Example users are
> hypervisors (especially implementing memory ballooning or similar
> technologies like virtio-mem) and memory allocators. In addition, we want
> to fail in a nice way if populating does not succeed because we are out of
> backend memory (which can happen easily with file-based mappings,
> especially tmpfs and hugetlbfs).
> 
> While MADV_DONTNEED and FALLOC_FL_PUNCH_HOLE provide us ways to reliably
> discard memory, there is no generic approach to populate ("preallocate")
> memory.
> 
> Although mmap() supports MAP_POPULATE, it is not applicable to the concept
> of sparse memory mappings, where we want to do populate/discard
> dynamically and avoid expensive/problematic remappings. In addition,
> we never actually report error during the final populate phase - it is
> best-effort only.
> 
> fallocate() can be used to preallocate file-based memory and fail in a safe
> way. However, it is less useful for private mappings on anonymous files
> due to COW semantics. For example, using fallocate() to preallocate memory
> on an anonymous memfd files that are mapped MAP_PRIVATE results in a double
> memory consumption when actually writing via the mapping. In addition,
> fallocate() does not actually populate page tables, so we still always
> have to resolve minor faults on first access.
> 
> Because we don't have a proper interface, what applications
> (like QEMU and databases) end up doing is touching (i.e., writing) all
> individual pages. However, it requires expensive signal handling (SIGBUS);
> for example, this is problematic in hypervisors like QEMU where SIGBUS
> handlers might already be used by other subsystems concurrently to e.g,
> handle hardware errors. "Simply" doing preallocation from another thread
> is not that easy.
> 
> Let's introduce MADV_POPULATE with the following semantics
> 1. MADV_POPULATED does not work on PROT_NONE and special VMAs. It works
>     on everything else.
> 2. Errors during MADV_POPULATED (especially OOM) are reported. If we hit
>     hardware errors on pages, ignore them - nothing we really can or
>     should do.
> 3. On errors during MADV_POPULATED, some memory might have been
>     populated. Callers have to clean up if they care.
> 4. Concurrent changes to the virtual memory layour are tolerated - we
>     process each and every PFN only once, though.
> 5. If MADV_POPULATE succeeds, all memory in the range can be accessed
>     without SIGBUS. (of course, not if user space changed mappings in the
>     meantime or KSM kicked in on anonymous memory).
> 
> Although sparse memory mappings are the primary use case, this will
> also be useful for ordinary preallocations where MAP_POPULATE is not
> desired (e.g., in QEMU, where users can trigger preallocation of
> guest RAM after the mapping was created).
> 
> Looking at the history, MADV_POPULATE was already proposed in 2013 [1],
> however, the main motivation back than was performance improvements
> (which should also still be the case, but it's a seconary concern).
> 
> Basic functionality was tested with:
> - anonymous memory
> - MAP_PRIVATE on anonymous file via memfd
> - MAP_SHARED on anonymous file via memf
> - MAP_PRIVATE on anonymous hugetlbfs file via memfd
> - MAP_SHARED on anonymous hugetlbfs file via memfd
> - MAP_PRIVATE on tmpfs/shmem file (we end up with double memory consumption
>    though, as the actual file gets populated with zeroes)
> - MAP_SHARED on tmpfs/shmem file
> 
> Note: For populating/preallocating zeroed-out memory while userfaultfd is
> active, it's even faster to use first fallocate() or placing zeroed pages
> via userfaultfd APIs. Otherwise, we'll have to route every fault while
> populating via the userfaultfd handler.
> 
> [1] https://lkml.org/lkml/2013/6/27/698
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-mips@vger.kernel.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linux-xtensa@linux-xtensa.org
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> If we agree that this makes sense I'll do more testing to see if we
> are missing any return value handling and prepare a man page update to
> document the semantics.
> 
> Thoughts?

Thinking about MADV_POPULATE vs. MADV_POPULATE_WRITE I wonder if it 
would be more versatile to break with existing MAP_POPULATE semantics 
and directly go with

MADV_POPULATE_READ: simulate user space read access without actually 
reading. Trigger a read fault if required.

MADV_POPULATE_WRITE: simulate user space write access without actually 
writing. Trigger a write fault if required.

For my use case, I could use MADV_POPULATE_WRITE on anonymous memory and 
RAM-backed files (shmem/hugetlb) - I would not have a minor fault when 
the guest inside the VM first initializes memory. This mimics how QEMU 
currently preallocates memory.

However, I would use MADV_POPULATE_READ on any !RAM-backed files where 
we actually have to write-back to a (slow?) device. Dirtying everything 
although the guest might not actually consume it in the near future 
might be undesired.

MADV_POPULATE_READ could also come in handy in combination with 
userfaulfd-wp() [1], when handling unpopulated memory via ordinary 
userfaultfd MISSING events in undesired. I could imagine it can speed up 
live migration of VMs in general, where we might end up reading a lot of 
unpopulated memory to figure out it's all zeroes after faulting in the 
shared zeropage. Especially relevant with a shared zeropage.

Thoughts?

[1] https://lkml.kernel.org/r/20210219211054.GL6669@xz-x1

-- 
Thanks,

David / dhildenb

