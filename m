Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9408B37A185
	for <lists+linux-arch@lfdr.de>; Tue, 11 May 2021 10:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhEKIRW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 May 2021 04:17:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31720 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230386AbhEKIRV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 May 2021 04:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620720974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=COxDo3Yia8Lbbq/ZX6V6qen7rUav8+kzpdQa1rdWh04=;
        b=i2sWkyEBm7F3rnyBBJRVXkPmCp23WihA22JU3hd1h3v7ltezHHy8dM/12EDsTa+ypb6xze
        NkQBbKG9Sz5YnsuCcBesJE5H329wlhYIdvHFB44KQnR61pxTg8qeB+3CUsFsBIkf4deYOZ
        HDuYYAaSahG3alJT/V/H9E59JJPfCXI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-EfTpDanMNBOLBbR0c7HnKA-1; Tue, 11 May 2021 04:16:05 -0400
X-MC-Unique: EfTpDanMNBOLBbR0c7HnKA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D848107ACC7;
        Tue, 11 May 2021 08:16:01 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-91.ams2.redhat.com [10.36.115.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 637845D6D1;
        Tue, 11 May 2021 08:15:46 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Max Filippov <jcmvbkbc@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>,
        Rolf Eike Beer <eike-kernel@sf-tec.de>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, Linux API <linux-api@vger.kernel.org>
Subject: [PATCH resend v2 2/5] mm/madvise: introduce MADV_POPULATE_(READ|WRITE) to prefault page tables
Date:   Tue, 11 May 2021 10:15:31 +0200
Message-Id: <20210511081534.3507-3-david@redhat.com>
In-Reply-To: <20210511081534.3507-1-david@redhat.com>
References: <20210511081534.3507-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

I. Background: Sparse Memory Mappings

When we manage sparse memory mappings dynamically in user space - also
sometimes involving MAP_NORESERVE - we want to dynamically populate/
discard memory inside such a sparse memory region. Example users are
hypervisors (especially implementing memory ballooning or similar
technologies like virtio-mem) and memory allocators. In addition, we want
to fail in a nice way (instead of generating SIGBUS) if populating does not
succeed because we are out of backend memory (which can happen easily with
file-based mappings, especially tmpfs and hugetlbfs).

While MADV_DONTNEED, MADV_REMOVE and FALLOC_FL_PUNCH_HOLE allow for
reliably discarding memory for most mapping types, there is no generic
approach to populate page tables and preallocate memory.

Although mmap() supports MAP_POPULATE, it is not applicable to the concept
of sparse memory mappings, where we want to populate/discard
dynamically and avoid expensive/problematic remappings. In addition,
we never actually report errors during the final populate phase - it is
best-effort only.

fallocate() can be used to preallocate file-based memory and fail in a safe
way. However, it cannot really be used for any private mappings on
anonymous files via memfd due to COW semantics. In addition, fallocate()
does not actually populate page tables, so we still always get
pagefaults on first access - which is sometimes undesired (i.e., real-time
workloads) and requires real prefaulting of page tables, not just a
preallocation of backend storage. There might be interesting use cases
for sparse memory regions along with mlockall(MCL_ONFAULT) which
fallocate() cannot satisfy as it does not prefault page tables.

II. On preallcoation/prefaulting from user space

Because we don't have a proper interface, what applications
(like QEMU and databases) end up doing is touching (i.e., reading+writing
one byte to not overwrite existing data) all individual pages.

However, that approach
1) Can result in wear on storage backing, because we end up reading/writing
   each page; this is especially a problem for dax/pmem.
2) Can result in mmap_sem contention when prefaulting via multiple
   threads.
3) Requires expensive signal handling, especially to catch SIGBUS in case
   of hugetlbfs/shmem/file-backed memory. For example, this is
   problematic in hypervisors like QEMU where SIGBUS handlers might already
   be used by other subsystems concurrently to e.g, handle hardware errors.
   "Simply" doing preallocation concurrently from other thread is not that
   easy.

III. On MADV_WILLNEED

Extending MADV_WILLNEED is not an option because
1. It would change the semantics: "Expect access in the near future." and
   "might be a good idea to read some pages" vs. "Definitely populate/
   preallocate all memory and definitely fail on errors.".
2. Existing users (like virtio-balloon in QEMU when deflating the balloon)
   don't want populate/prealloc semantics. They treat this rather as a hint
   to give a little performance boost without too much overhead - and don't
   expect that a lot of memory might get consumed or a lot of time
   might be spent.

IV. MADV_POPULATE_READ and MADV_POPULATE_WRITE

Let's introduce MADV_POPULATE_READ and MADV_POPULATE_WRITE, inspired by
MAP_POPULATE, with the following semantics:
1. MADV_POPULATE_READ can be used to prefault page tables just like
   manually reading each individual page. This will not break any COW
   mappings. The shared zero page might get mapped and no backend storage
   might get preallocated -- allocation might be deferred to
   write-fault time. Especially shared file mappings require an explicit
   fallocate() upfront to actually preallocate backend memory (blocks in
   the file system) in case the file might have holes.
2. If MADV_POPULATE_READ succeeds, all page tables have been populated
   (prefaulted) readable once.
3. MADV_POPULATE_WRITE can be used to preallocate backend memory and
   prefault page tables just like manually writing (or
   reading+writing) each individual page. This will break any COW
   mappings -- e.g., the shared zeropage is never populated.
4. If MADV_POPULATE_WRITE succeeds, all page tables have been populated
   (prefaulted) writable once.
5. MADV_POPULATE_READ and MADV_POPULATE_WRITE cannot be applied to special
   mappings marked with VM_PFNMAP and VM_IO. Also, proper access
   permissions (e.g., PROT_READ, PROT_WRITE) are required. If any such
   mapping is encountered, madvise() fails with -EINVAL.
6. If MADV_POPULATE_READ or MADV_POPULATE_WRITE fails, some page tables
   might have been populated.
7. MADV_POPULATE_READ and MADV_POPULATE_WRITE will return -EHWPOISON
   when encountering a HW poisoned page in the range.
8. Similar to MAP_POPULATE, MADV_POPULATE_READ and MADV_POPULATE_WRITE
   cannot protect from the OOM (Out Of Memory) handler killing the
   process.

While the use case for MADV_POPULATE_WRITE is fairly obvious (i.e.,
preallocate memory and prefault page tables for VMs), one issue is that
whenever we prefault pages writable, the pages have to be marked dirty,
because the CPU could dirty them any time. while not a real problem for
hugetlbfs or dax/pmem, it can be a problem for shared file mappings: each
page will be marked dirty and has to be written back later when evicting.

MADV_POPULATE_READ allows for optimizing this scenario: Pre-read a whole
mapping from backend storage without marking it dirty, such that eviction
won't have to write it back. As discussed above, shared file mappings
might require an explciit fallocate() upfront to achieve
preallcoation+prepopulation.

Although sparse memory mappings are the primary use case, this will
also be useful for other preallocate/prefault use cases where MAP_POPULATE
is not desired or the semantics of MAP_POPULATE are not sufficient: as one
example, QEMU users can trigger preallocation/prefaulting of guest RAM
after the mapping was created -- and don't want errors to be silently
suppressed.

Looking at the history, MADV_POPULATE was already proposed in 2013 [1],
however, the main motivation back than was performance improvements
-- which should also still be the case.

V. Single-threaded performance comparison

I did a short experiment, prefaulting page tables on completely *empty
mappings/files* and repeated the experiment 10 times. The results
correspond to the shortest execution time. In general, the performance
benefit for huge pages is negligible with small mappings.

V.1: Private mappings

POPULATE_READ and POPULATE_WRITE is fastest. Note that
Reading/POPULATE_READ will populate the shared zeropage where applicable
-- which result in short population times.

The fastest way to allocate backend storage (here: swap or huge pages)
and prefault page tables is POPULATE_WRITE.

V.2: Shared mappings

fallocate() is fastest, however, doesn't prefault
page tables. POPULATE_WRITE is faster than simple writes and read/writes.
POPULATE_READ is faster than simple reads.

Without a fd, the fastest way to allocate backend storage and prefault page
tables is POPULATE_WRITE. With an fd, the fastest way is usually
FALLOCATE+POPULATE_READ or FALLOCATE+POPULATE_WRITE respectively; one
exception are actual files: FALLOCATE+Read is slightly faster than
FALLOCATE+POPULATE_READ.

The fastest way to allocate backend storage prefault page tables is
FALLOCATE+POPULATE_WRITE -- except when dealing with actual files; then,
FALLOCATE+POPULATE_READ is fastest and won't directly mark all pages as
dirty.

v.3: Detailed results

==================================================
2 MiB MAP_PRIVATE:
**************************************************
Anon 4 KiB     : Read                     :     0.119 ms
Anon 4 KiB     : Write                    :     0.222 ms
Anon 4 KiB     : Read/Write               :     0.380 ms
Anon 4 KiB     : POPULATE_READ            :     0.060 ms
Anon 4 KiB     : POPULATE_WRITE           :     0.158 ms
Memfd 4 KiB    : Read                     :     0.034 ms
Memfd 4 KiB    : Write                    :     0.310 ms
Memfd 4 KiB    : Read/Write               :     0.362 ms
Memfd 4 KiB    : POPULATE_READ            :     0.039 ms
Memfd 4 KiB    : POPULATE_WRITE           :     0.229 ms
Memfd 2 MiB    : Read                     :     0.030 ms
Memfd 2 MiB    : Write                    :     0.030 ms
Memfd 2 MiB    : Read/Write               :     0.030 ms
Memfd 2 MiB    : POPULATE_READ            :     0.030 ms
Memfd 2 MiB    : POPULATE_WRITE           :     0.030 ms
tmpfs          : Read                     :     0.033 ms
tmpfs          : Write                    :     0.313 ms
tmpfs          : Read/Write               :     0.406 ms
tmpfs          : POPULATE_READ            :     0.039 ms
tmpfs          : POPULATE_WRITE           :     0.285 ms
file           : Read                     :     0.033 ms
file           : Write                    :     0.351 ms
file           : Read/Write               :     0.408 ms
file           : POPULATE_READ            :     0.039 ms
file           : POPULATE_WRITE           :     0.290 ms
hugetlbfs      : Read                     :     0.030 ms
hugetlbfs      : Write                    :     0.030 ms
hugetlbfs      : Read/Write               :     0.030 ms
hugetlbfs      : POPULATE_READ            :     0.030 ms
hugetlbfs      : POPULATE_WRITE           :     0.030 ms
**************************************************
4096 MiB MAP_PRIVATE:
**************************************************
Anon 4 KiB     : Read                     :   237.940 ms
Anon 4 KiB     : Write                    :   708.409 ms
Anon 4 KiB     : Read/Write               :  1054.041 ms
Anon 4 KiB     : POPULATE_READ            :   124.310 ms
Anon 4 KiB     : POPULATE_WRITE           :   572.582 ms
Memfd 4 KiB    : Read                     :   136.928 ms
Memfd 4 KiB    : Write                    :   963.898 ms
Memfd 4 KiB    : Read/Write               :  1106.561 ms
Memfd 4 KiB    : POPULATE_READ            :    78.450 ms
Memfd 4 KiB    : POPULATE_WRITE           :   805.881 ms
Memfd 2 MiB    : Read                     :   357.116 ms
Memfd 2 MiB    : Write                    :   357.210 ms
Memfd 2 MiB    : Read/Write               :   357.606 ms
Memfd 2 MiB    : POPULATE_READ            :   356.094 ms
Memfd 2 MiB    : POPULATE_WRITE           :   356.937 ms
tmpfs          : Read                     :   137.536 ms
tmpfs          : Write                    :   954.362 ms
tmpfs          : Read/Write               :  1105.954 ms
tmpfs          : POPULATE_READ            :    80.289 ms
tmpfs          : POPULATE_WRITE           :   822.826 ms
file           : Read                     :   137.874 ms
file           : Write                    :   987.025 ms
file           : Read/Write               :  1107.439 ms
file           : POPULATE_READ            :    80.413 ms
file           : POPULATE_WRITE           :   857.622 ms
hugetlbfs      : Read                     :   355.607 ms
hugetlbfs      : Write                    :   355.729 ms
hugetlbfs      : Read/Write               :   356.127 ms
hugetlbfs      : POPULATE_READ            :   354.585 ms
hugetlbfs      : POPULATE_WRITE           :   355.138 ms
**************************************************
2 MiB MAP_SHARED:
**************************************************
Anon 4 KiB     : Read                     :     0.394 ms
Anon 4 KiB     : Write                    :     0.348 ms
Anon 4 KiB     : Read/Write               :     0.400 ms
Anon 4 KiB     : POPULATE_READ            :     0.326 ms
Anon 4 KiB     : POPULATE_WRITE           :     0.273 ms
Anon 2 MiB     : Read                     :     0.030 ms
Anon 2 MiB     : Write                    :     0.030 ms
Anon 2 MiB     : Read/Write               :     0.030 ms
Anon 2 MiB     : POPULATE_READ            :     0.030 ms
Anon 2 MiB     : POPULATE_WRITE           :     0.030 ms
Memfd 4 KiB    : Read                     :     0.412 ms
Memfd 4 KiB    : Write                    :     0.372 ms
Memfd 4 KiB    : Read/Write               :     0.419 ms
Memfd 4 KiB    : POPULATE_READ            :     0.343 ms
Memfd 4 KiB    : POPULATE_WRITE           :     0.288 ms
Memfd 4 KiB    : FALLOCATE                :     0.137 ms
Memfd 4 KiB    : FALLOCATE+Read           :     0.446 ms
Memfd 4 KiB    : FALLOCATE+Write          :     0.330 ms
Memfd 4 KiB    : FALLOCATE+Read/Write     :     0.454 ms
Memfd 4 KiB    : FALLOCATE+POPULATE_READ  :     0.379 ms
Memfd 4 KiB    : FALLOCATE+POPULATE_WRITE :     0.268 ms
Memfd 2 MiB    : Read                     :     0.030 ms
Memfd 2 MiB    : Write                    :     0.030 ms
Memfd 2 MiB    : Read/Write               :     0.030 ms
Memfd 2 MiB    : POPULATE_READ            :     0.030 ms
Memfd 2 MiB    : POPULATE_WRITE           :     0.030 ms
Memfd 2 MiB    : FALLOCATE                :     0.030 ms
Memfd 2 MiB    : FALLOCATE+Read           :     0.031 ms
Memfd 2 MiB    : FALLOCATE+Write          :     0.031 ms
Memfd 2 MiB    : FALLOCATE+Read/Write     :     0.031 ms
Memfd 2 MiB    : FALLOCATE+POPULATE_READ  :     0.030 ms
Memfd 2 MiB    : FALLOCATE+POPULATE_WRITE :     0.030 ms
tmpfs          : Read                     :     0.416 ms
tmpfs          : Write                    :     0.369 ms
tmpfs          : Read/Write               :     0.425 ms
tmpfs          : POPULATE_READ            :     0.346 ms
tmpfs          : POPULATE_WRITE           :     0.295 ms
tmpfs          : FALLOCATE                :     0.139 ms
tmpfs          : FALLOCATE+Read           :     0.447 ms
tmpfs          : FALLOCATE+Write          :     0.333 ms
tmpfs          : FALLOCATE+Read/Write     :     0.454 ms
tmpfs          : FALLOCATE+POPULATE_READ  :     0.380 ms
tmpfs          : FALLOCATE+POPULATE_WRITE :     0.272 ms
file           : Read                     :     0.191 ms
file           : Write                    :     0.511 ms
file           : Read/Write               :     0.524 ms
file           : POPULATE_READ            :     0.196 ms
file           : POPULATE_WRITE           :     0.434 ms
file           : FALLOCATE                :     0.004 ms
file           : FALLOCATE+Read           :     0.197 ms
file           : FALLOCATE+Write          :     0.554 ms
file           : FALLOCATE+Read/Write     :     0.480 ms
file           : FALLOCATE+POPULATE_READ  :     0.201 ms
file           : FALLOCATE+POPULATE_WRITE :     0.381 ms
hugetlbfs      : Read                     :     0.030 ms
hugetlbfs      : Write                    :     0.030 ms
hugetlbfs      : Read/Write               :     0.030 ms
hugetlbfs      : POPULATE_READ            :     0.030 ms
hugetlbfs      : POPULATE_WRITE           :     0.030 ms
hugetlbfs      : FALLOCATE                :     0.030 ms
hugetlbfs      : FALLOCATE+Read           :     0.031 ms
hugetlbfs      : FALLOCATE+Write          :     0.031 ms
hugetlbfs      : FALLOCATE+Read/Write     :     0.030 ms
hugetlbfs      : FALLOCATE+POPULATE_READ  :     0.030 ms
hugetlbfs      : FALLOCATE+POPULATE_WRITE :     0.030 ms
**************************************************
4096 MiB MAP_SHARED:
**************************************************
Anon 4 KiB     : Read                     :  1053.090 ms
Anon 4 KiB     : Write                    :   913.642 ms
Anon 4 KiB     : Read/Write               :  1060.350 ms
Anon 4 KiB     : POPULATE_READ            :   893.691 ms
Anon 4 KiB     : POPULATE_WRITE           :   782.885 ms
Anon 2 MiB     : Read                     :   358.553 ms
Anon 2 MiB     : Write                    :   358.419 ms
Anon 2 MiB     : Read/Write               :   357.992 ms
Anon 2 MiB     : POPULATE_READ            :   357.533 ms
Anon 2 MiB     : POPULATE_WRITE           :   357.808 ms
Memfd 4 KiB    : Read                     :  1078.144 ms
Memfd 4 KiB    : Write                    :   942.036 ms
Memfd 4 KiB    : Read/Write               :  1100.391 ms
Memfd 4 KiB    : POPULATE_READ            :   925.829 ms
Memfd 4 KiB    : POPULATE_WRITE           :   804.394 ms
Memfd 4 KiB    : FALLOCATE                :   304.632 ms
Memfd 4 KiB    : FALLOCATE+Read           :  1163.359 ms
Memfd 4 KiB    : FALLOCATE+Write          :   933.186 ms
Memfd 4 KiB    : FALLOCATE+Read/Write     :  1187.304 ms
Memfd 4 KiB    : FALLOCATE+POPULATE_READ  :  1013.660 ms
Memfd 4 KiB    : FALLOCATE+POPULATE_WRITE :   794.560 ms
Memfd 2 MiB    : Read                     :   358.131 ms
Memfd 2 MiB    : Write                    :   358.099 ms
Memfd 2 MiB    : Read/Write               :   358.250 ms
Memfd 2 MiB    : POPULATE_READ            :   357.563 ms
Memfd 2 MiB    : POPULATE_WRITE           :   357.334 ms
Memfd 2 MiB    : FALLOCATE                :   356.735 ms
Memfd 2 MiB    : FALLOCATE+Read           :   358.152 ms
Memfd 2 MiB    : FALLOCATE+Write          :   358.331 ms
Memfd 2 MiB    : FALLOCATE+Read/Write     :   358.018 ms
Memfd 2 MiB    : FALLOCATE+POPULATE_READ  :   357.286 ms
Memfd 2 MiB    : FALLOCATE+POPULATE_WRITE :   357.523 ms
tmpfs          : Read                     :  1087.265 ms
tmpfs          : Write                    :   950.840 ms
tmpfs          : Read/Write               :  1107.567 ms
tmpfs          : POPULATE_READ            :   922.605 ms
tmpfs          : POPULATE_WRITE           :   810.094 ms
tmpfs          : FALLOCATE                :   306.320 ms
tmpfs          : FALLOCATE+Read           :  1169.796 ms
tmpfs          : FALLOCATE+Write          :   933.730 ms
tmpfs          : FALLOCATE+Read/Write     :  1191.610 ms
tmpfs          : FALLOCATE+POPULATE_READ  :  1020.474 ms
tmpfs          : FALLOCATE+POPULATE_WRITE :   798.945 ms
file           : Read                     :   654.101 ms
file           : Write                    :  1259.142 ms
file           : Read/Write               :  1289.509 ms
file           : POPULATE_READ            :   661.642 ms
file           : POPULATE_WRITE           :  1106.816 ms
file           : FALLOCATE                :     1.864 ms
file           : FALLOCATE+Read           :   656.328 ms
file           : FALLOCATE+Write          :  1153.300 ms
file           : FALLOCATE+Read/Write     :  1180.613 ms
file           : FALLOCATE+POPULATE_READ  :   668.347 ms
file           : FALLOCATE+POPULATE_WRITE :   996.143 ms
hugetlbfs      : Read                     :   357.245 ms
hugetlbfs      : Write                    :   357.413 ms
hugetlbfs      : Read/Write               :   357.120 ms
hugetlbfs      : POPULATE_READ            :   356.321 ms
hugetlbfs      : POPULATE_WRITE           :   356.693 ms
hugetlbfs      : FALLOCATE                :   355.927 ms
hugetlbfs      : FALLOCATE+Read           :   357.074 ms
hugetlbfs      : FALLOCATE+Write          :   357.120 ms
hugetlbfs      : FALLOCATE+Read/Write     :   356.983 ms
hugetlbfs      : FALLOCATE+POPULATE_READ  :   356.413 ms
hugetlbfs      : FALLOCATE+POPULATE_WRITE :   356.266 ms
**************************************************

[1] https://lkml.org/lkml/2013/6/27/698

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: linux-alpha@vger.kernel.org
Cc: linux-mips@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linux-xtensa@linux-xtensa.org
Cc: linux-arch@vger.kernel.org
Cc: Linux API <linux-api@vger.kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/alpha/include/uapi/asm/mman.h     |  3 ++
 arch/mips/include/uapi/asm/mman.h      |  3 ++
 arch/parisc/include/uapi/asm/mman.h    |  3 ++
 arch/xtensa/include/uapi/asm/mman.h    |  3 ++
 include/uapi/asm-generic/mman-common.h |  3 ++
 mm/gup.c                               | 58 ++++++++++++++++++++++
 mm/internal.h                          |  3 ++
 mm/madvise.c                           | 66 ++++++++++++++++++++++++++
 8 files changed, 142 insertions(+)

diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uapi/asm/mman.h
index a18ec7f63888..56b4ee5a6c9e 100644
--- a/arch/alpha/include/uapi/asm/mman.h
+++ b/arch/alpha/include/uapi/asm/mman.h
@@ -71,6 +71,9 @@
 #define MADV_COLD	20		/* deactivate these pages */
 #define MADV_PAGEOUT	21		/* reclaim these pages */
 
+#define MADV_POPULATE_READ	22	/* populate (prefault) page tables readable */
+#define MADV_POPULATE_WRITE	23	/* populate (prefault) page tables writable */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/arch/mips/include/uapi/asm/mman.h b/arch/mips/include/uapi/asm/mman.h
index 57dc2ac4f8bd..40b210c65a5a 100644
--- a/arch/mips/include/uapi/asm/mman.h
+++ b/arch/mips/include/uapi/asm/mman.h
@@ -98,6 +98,9 @@
 #define MADV_COLD	20		/* deactivate these pages */
 #define MADV_PAGEOUT	21		/* reclaim these pages */
 
+#define MADV_POPULATE_READ	22	/* populate (prefault) page tables readable */
+#define MADV_POPULATE_WRITE	23	/* populate (prefault) page tables writable */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/arch/parisc/include/uapi/asm/mman.h b/arch/parisc/include/uapi/asm/mman.h
index ab78cba446ed..9e3c010c0f61 100644
--- a/arch/parisc/include/uapi/asm/mman.h
+++ b/arch/parisc/include/uapi/asm/mman.h
@@ -52,6 +52,9 @@
 #define MADV_COLD	20		/* deactivate these pages */
 #define MADV_PAGEOUT	21		/* reclaim these pages */
 
+#define MADV_POPULATE_READ	22	/* populate (prefault) page tables readable */
+#define MADV_POPULATE_WRITE	23	/* populate (prefault) page tables writable */
+
 #define MADV_MERGEABLE   65		/* KSM may merge identical pages */
 #define MADV_UNMERGEABLE 66		/* KSM may not merge identical pages */
 
diff --git a/arch/xtensa/include/uapi/asm/mman.h b/arch/xtensa/include/uapi/asm/mman.h
index e5e643752947..b3a22095371b 100644
--- a/arch/xtensa/include/uapi/asm/mman.h
+++ b/arch/xtensa/include/uapi/asm/mman.h
@@ -106,6 +106,9 @@
 #define MADV_COLD	20		/* deactivate these pages */
 #define MADV_PAGEOUT	21		/* reclaim these pages */
 
+#define MADV_POPULATE_READ	22	/* populate (prefault) page tables readable */
+#define MADV_POPULATE_WRITE	23	/* populate (prefault) page tables writable */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index f94f65d429be..1567a3294c3d 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -72,6 +72,9 @@
 #define MADV_COLD	20		/* deactivate these pages */
 #define MADV_PAGEOUT	21		/* reclaim these pages */
 
+#define MADV_POPULATE_READ	22	/* populate (prefault) page tables readable */
+#define MADV_POPULATE_WRITE	23	/* populate (prefault) page tables writable */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/mm/gup.c b/mm/gup.c
index ef7d2da9f03f..632d12469deb 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1403,6 +1403,64 @@ long populate_vma_page_range(struct vm_area_struct *vma,
 				NULL, NULL, locked);
 }
 
+/*
+ * faultin_vma_page_range() - populate (prefault) page tables inside the
+ *			      given VMA range readable/writable
+ *
+ * This takes care of mlocking the pages, too, if VM_LOCKED is set.
+ *
+ * @vma: target vma
+ * @start: start address
+ * @end: end address
+ * @write: whether to prefault readable or writable
+ * @locked: whether the mmap_lock is still held
+ *
+ * Returns either number of processed pages in the vma, or a negative error
+ * code on error (see __get_user_pages()).
+ *
+ * vma->vm_mm->mmap_lock must be held. The range must be page-aligned and
+ * covered by the VMA.
+ *
+ * If @locked is NULL, it may be held for read or write and will be unperturbed.
+ *
+ * If @locked is non-NULL, it must held for read only and may be released.  If
+ * it's released, *@locked will be set to 0.
+ */
+long faultin_vma_page_range(struct vm_area_struct *vma, unsigned long start,
+			    unsigned long end, bool write, int *locked)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	unsigned long nr_pages = (end - start) / PAGE_SIZE;
+	int gup_flags;
+
+	VM_BUG_ON(!PAGE_ALIGNED(start));
+	VM_BUG_ON(!PAGE_ALIGNED(end));
+	VM_BUG_ON_VMA(start < vma->vm_start, vma);
+	VM_BUG_ON_VMA(end > vma->vm_end, vma);
+	mmap_assert_locked(mm);
+
+	/*
+	 * FOLL_TOUCH: Mark page accessed and thereby young; will also mark
+	 * 	       the page dirty with FOLL_WRITE -- which doesn't make a
+	 * 	       difference with !FOLL_FORCE, because the page is writable
+	 * 	       in the page table.
+	 * FOLL_HWPOISON: Return -EHWPOISON instead of -EFAULT when we hit
+	 *		  a poisoned page.
+	 * FOLL_POPULATE: Always populate memory with VM_LOCKONFAULT.
+	 * !FOLL_FORCE: Require proper access permissions.
+	 */
+	gup_flags = FOLL_TOUCH | FOLL_POPULATE | FOLL_MLOCK | FOLL_HWPOISON;
+	if (write)
+		gup_flags |= FOLL_WRITE;
+
+	/*
+	 * See check_vma_flags(): Will return -EFAULT on incompatible mappings
+	 * or with insufficient permissions.
+	 */
+	return __get_user_pages(mm, start, nr_pages, gup_flags,
+				NULL, NULL, locked);
+}
+
 /*
  * __mm_populate - populate and/or mlock pages within a range of address space.
  *
diff --git a/mm/internal.h b/mm/internal.h
index bbf1c1274983..41e8d41a5d1e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -355,6 +355,9 @@ void __vma_unlink_list(struct mm_struct *mm, struct vm_area_struct *vma);
 #ifdef CONFIG_MMU
 extern long populate_vma_page_range(struct vm_area_struct *vma,
 		unsigned long start, unsigned long end, int *locked);
+extern long faultin_vma_page_range(struct vm_area_struct *vma,
+				   unsigned long start, unsigned long end,
+				   bool write, int *locked);
 extern void munlock_vma_pages_range(struct vm_area_struct *vma,
 			unsigned long start, unsigned long end);
 static inline void munlock_vma_pages_all(struct vm_area_struct *vma)
diff --git a/mm/madvise.c b/mm/madvise.c
index 01fef79ac761..a02cbda942ba 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -53,6 +53,8 @@ static int madvise_need_mmap_write(int behavior)
 	case MADV_COLD:
 	case MADV_PAGEOUT:
 	case MADV_FREE:
+	case MADV_POPULATE_READ:
+	case MADV_POPULATE_WRITE:
 		return 0;
 	default:
 		/* be safe, default to 1. list exceptions explicitly */
@@ -822,6 +824,61 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 		return -EINVAL;
 }
 
+static long madvise_populate(struct vm_area_struct *vma,
+			     struct vm_area_struct **prev,
+			     unsigned long start, unsigned long end,
+			     int behavior)
+{
+	const bool write = behavior == MADV_POPULATE_WRITE;
+	struct mm_struct *mm = vma->vm_mm;
+	unsigned long tmp_end;
+	int locked = 1;
+	long pages;
+
+	*prev = vma;
+
+	while (start < end) {
+		/*
+		 * We might have temporarily dropped the lock. For example,
+		 * our VMA might have been split.
+		 */
+		if (!vma || start >= vma->vm_end) {
+			vma = find_vma(mm, start);
+			if (!vma || start < vma->vm_start)
+				return -ENOMEM;
+		}
+
+		tmp_end = min_t(unsigned long, end, vma->vm_end);
+		/* Populate (prefault) page tables readable/writable. */
+		pages = faultin_vma_page_range(vma, start, tmp_end, write,
+					       &locked);
+		if (!locked) {
+			mmap_read_lock(mm);
+			locked = 1;
+			*prev = NULL;
+			vma = NULL;
+		}
+		if (pages < 0) {
+			switch (pages) {
+			case -EINTR:
+				return -EINTR;
+			case -EFAULT: /* Incompatible mappings / permissions. */
+				return -EINVAL;
+			case -EHWPOISON:
+				return -EHWPOISON;
+			default:
+				pr_warn_once("%s: unhandled return value: %ld\n",
+					     __func__, pages);
+				fallthrough;
+			case -ENOMEM:
+				return -ENOMEM;
+			}
+		}
+		start += pages * PAGE_SIZE;
+	}
+	return 0;
+}
+
 /*
  * Application wants to free up the pages and associated backing store.
  * This is effectively punching a hole into the middle of a file.
@@ -935,6 +992,9 @@ madvise_vma(struct vm_area_struct *vma, struct vm_area_struct **prev,
 	case MADV_FREE:
 	case MADV_DONTNEED:
 		return madvise_dontneed_free(vma, prev, start, end, behavior);
+	case MADV_POPULATE_READ:
+	case MADV_POPULATE_WRITE:
+		return madvise_populate(vma, prev, start, end, behavior);
 	default:
 		return madvise_behavior(vma, prev, start, end, behavior);
 	}
@@ -955,6 +1015,8 @@ madvise_behavior_valid(int behavior)
 	case MADV_FREE:
 	case MADV_COLD:
 	case MADV_PAGEOUT:
+	case MADV_POPULATE_READ:
+	case MADV_POPULATE_WRITE:
 #ifdef CONFIG_KSM
 	case MADV_MERGEABLE:
 	case MADV_UNMERGEABLE:
@@ -1042,6 +1104,10 @@ process_madvise_behavior_valid(int behavior)
  *		easily if memory pressure hanppens.
  *  MADV_PAGEOUT - the application is not expected to use this memory soon,
  *		page out the pages in this range immediately.
+ *  MADV_POPULATE_READ - populate (prefault) page tables readable by
+ *		triggering read faults if required
+ *  MADV_POPULATE_WRITE - populate (prefault) page tables writable by
+ *		triggering write faults if required
  *
  * return values:
  *  zero    - success
-- 
2.30.2

