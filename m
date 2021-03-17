Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC75F33EF41
	for <lists+linux-arch@lfdr.de>; Wed, 17 Mar 2021 12:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbhCQLID (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Mar 2021 07:08:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32647 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231301AbhCQLHe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 17 Mar 2021 07:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615979254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ktfl7NR4FksYGfkTq8gShRzL1kUauXiOQZu0DL+L4HQ=;
        b=VrgOGCK5Bsg72KYEvOhmqwF0xw4S69alSjQAHCgMF6P8wEDAq0Z6nAL1Iwv3nsnMOCBxV7
        diJXANdvpi3pRcbbgQGfcVL3lxaG5JEfXltwSOBAiPv3bE9oJksP212SObf26TpY89K7Tk
        UJwMK/GGxVife/C9oL9lMvrhCbiIZOU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-pkf4LK6bNayvWM0WgC-5lw-1; Wed, 17 Mar 2021 07:07:30 -0400
X-MC-Unique: pkf4LK6bNayvWM0WgC-5lw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FF2518C8C00;
        Wed, 17 Mar 2021 11:07:26 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-124.ams2.redhat.com [10.36.112.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B152850FAF;
        Wed, 17 Mar 2021 11:07:10 +0000 (UTC)
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
Subject: [PATCH v1 2/5] mm/madvise: introduce MADV_POPULATE_(READ|WRITE) to prefault/prealloc memory
Date:   Wed, 17 Mar 2021 12:06:41 +0100
Message-Id: <20210317110644.25343-3-david@redhat.com>
In-Reply-To: <20210317110644.25343-1-david@redhat.com>
References: <20210317110644.25343-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
reliably discarding memory, there is no generic approach to populate
page tables and preallocate memory.

Although mmap() supports MAP_POPULATE, it is not applicable to the concept
of sparse memory mappings, where we want to do populate/discard
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
1) Can result in wear on storage backing, because we end up writing
   and thereby dirtying each page --- i.e., disks or pmem.
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

Let's introduce MADV_POPULATE_READ and MADV_POPULATE_WRITE with the
following semantics:
1. MADV_POPULATE_READ can be used to preallocate backend memory and
   prefault page tables just like manually reading each individual page.
   This will not break any COW mappings -- e.g., it will populate the
   shared zeropage when applicable.
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
   might have been populated. In that case, madvise() fails with
   -ENOMEM.
7. MADV_POPULATE_READ and MADV_POPULATE_WRITE will return -EHWPOISON
   when encountering a HW poisoned page in the range.
8. Similar to MAP_POPULATE, MADV_POPULATE_READ and MADV_POPULATE_WRITE
   cannot protect from the OOM (Out Of Memory) handler killing the
   process.

While the use case for MADV_POPULATE_WRITE is fairly obvious (i.e.,
preallocate memory and prefault page tables for VMs), there are valid use
cases for MADV_POPULATE_READ:
1. Efficiently populate page tables with zero pages (i.e., shared
   zeropage). This is necessary when using userfaultfd() WP (Write-Protect
   to properly catch all modifications within a mapping: for
   write-protection to be effective for a virtual address, there has to be
   a page already mapped -- even if it's the shared zeropage.
2. Pre-read a whole mapping from backend storage without marking it
   dirty, such that eviction won't have to write it back. If no backend
   memory has been allocated yet, allocate the backend memory. Helpful
   when preallocating/prefaulting a file stored on disk without having
   to writeback each and every page on eviction.

Although sparse memory mappings are the primary use case, this will
also be useful for ordinary preallocations where MAP_POPULATE is not
desired especially in QEMU, where users can trigger preallocation of
guest RAM after the mapping was created.

Looking at the history, MADV_POPULATE was already proposed in 2013 [1],
however, the main motivation back than was performance improvements
(which should also still be the case, but it is a secondary concern).

V. Single-threaded performance comparison

There is a performance benefit when using POPULATE_READ / POPULATE_WRITE
already when only using a single thread to do prefaulting/preallocation. As
we have less pagefaults for huge pages, the performance benefit is
negligible with small mappings.

Using fallocate() to preallocate shared files is the fastest approach,
however as discussed, we get pagefaults at runtime on actual access
which might or might not be relevant depending on the actual use case.

Average across 10 iterations each:
==================================================
2 MiB MAP_PRIVATE:
**************************************************
Anon 4 KiB     : Read           :     0.117 ms
Anon 4 KiB     : Write          :     0.240 ms
Anon 4 KiB     : Read+Write     :     0.386 ms
Anon 4 KiB     : POPULATE_READ  :     0.063 ms
Anon 4 KiB     : POPULATE_WRITE :     0.163 ms
Memfd 4 KiB    : Read           :     0.077 ms
Memfd 4 KiB    : Write          :     0.375 ms
Memfd 4 KiB    : Read+Write     :     0.464 ms
Memfd 4 KiB    : POPULATE_READ  :     0.080 ms
Memfd 4 KiB    : POPULATE_WRITE :     0.301 ms
Memfd 2 MiB    : Read           :     0.042 ms
Memfd 2 MiB    : Write          :     0.032 ms
Memfd 2 MiB    : Read+Write     :     0.032 ms
Memfd 2 MiB    : POPULATE_READ  :     0.031 ms
Memfd 2 MiB    : POPULATE_WRITE :     0.032 ms
tmpfs          : Read           :     0.086 ms
tmpfs          : Write          :     0.351 ms
tmpfs          : Read+Write     :     0.427 ms
tmpfs          : POPULATE_READ  :     0.041 ms
tmpfs          : POPULATE_WRITE :     0.298 ms
file           : Read           :     0.077 ms
file           : Write          :     0.368 ms
file           : Read+Write     :     0.466 ms
file           : POPULATE_READ  :     0.079 ms
file           : POPULATE_WRITE :     0.303 ms
**************************************************
2 MiB MAP_SHARED:
**************************************************
Memfd 4 KiB    : Read           :     0.418 ms
Memfd 4 KiB    : Write          :     0.367 ms
Memfd 4 KiB    : Read+Write     :     0.428 ms
Memfd 4 KiB    : POPULATE_READ  :     0.347 ms
Memfd 4 KiB    : POPULATE_WRITE :     0.286 ms
Memfd 4 KiB    : FALLOCATE      :     0.140 ms
Memfd 2 MiB    : Read           :     0.031 ms
Memfd 2 MiB    : Write          :     0.030 ms
Memfd 2 MiB    : Read+Write     :     0.030 ms
Memfd 2 MiB    : POPULATE_READ  :     0.030 ms
Memfd 2 MiB    : POPULATE_WRITE :     0.030 ms
Memfd 2 MiB    : FALLOCATE      :     0.030 ms
tmpfs          : Read           :     0.434 ms
tmpfs          : Write          :     0.367 ms
tmpfs          : Read+Write     :     0.435 ms
tmpfs          : POPULATE_READ  :     0.349 ms
tmpfs          : POPULATE_WRITE :     0.291 ms
tmpfs          : FALLOCATE      :     0.144 ms
file           : Read           :     0.423 ms
file           : Write          :     0.367 ms
file           : Read+Write     :     0.432 ms
file           : POPULATE_READ  :     0.351 ms
file           : POPULATE_WRITE :     0.290 ms
file           : FALLOCATE      :     0.144 ms
hugetlbfs      : Read           :     0.032 ms
hugetlbfs      : Write          :     0.030 ms
hugetlbfs      : Read+Write     :     0.031 ms
hugetlbfs      : POPULATE_READ  :     0.030 ms
hugetlbfs      : POPULATE_WRITE :     0.030 ms
hugetlbfs      : FALLOCATE      :     0.030 ms
**************************************************
4096 MiB MAP_PRIVATE:
**************************************************
Anon 4 KiB     : Read           :   237.099 ms
Anon 4 KiB     : Write          :   708.062 ms
Anon 4 KiB     : Read+Write     :  1057.147 ms
Anon 4 KiB     : POPULATE_READ  :   124.942 ms
Anon 4 KiB     : POPULATE_WRITE :   575.082 ms
Memfd 4 KiB    : Read           :   237.593 ms
Memfd 4 KiB    : Write          :   984.245 ms
Memfd 4 KiB    : Read+Write     :  1149.859 ms
Memfd 4 KiB    : POPULATE_READ  :   166.066 ms
Memfd 4 KiB    : POPULATE_WRITE :   856.914 ms
Memfd 2 MiB    : Read           :   352.202 ms
Memfd 2 MiB    : Write          :   352.029 ms
Memfd 2 MiB    : Read+Write     :   352.198 ms
Memfd 2 MiB    : POPULATE_READ  :   351.033 ms
Memfd 2 MiB    : POPULATE_WRITE :   351.181 ms
tmpfs          : Read           :   230.796 ms
tmpfs          : Write          :   936.138 ms
tmpfs          : Read+Write     :  1065.565 ms
tmpfs          : POPULATE_READ  :    80.823 ms
tmpfs          : POPULATE_WRITE :   803.829 ms
file           : Read           :   231.055 ms
file           : Write          :   980.575 ms
file           : Read+Write     :  1208.742 ms
file           : POPULATE_READ  :   167.808 ms
file           : POPULATE_WRITE :   859.270 ms
**************************************************
4096 MiB MAP_SHARED:
**************************************************
Memfd 4 KiB    : Read           :  1095.979 ms
Memfd 4 KiB    : Write          :   958.777 ms
Memfd 4 KiB    : Read+Write     :  1120.127 ms
Memfd 4 KiB    : POPULATE_READ  :   937.689 ms
Memfd 4 KiB    : POPULATE_WRITE :   811.594 ms
Memfd 4 KiB    : FALLOCATE      :   309.438 ms
Memfd 2 MiB    : Read           :   353.045 ms
Memfd 2 MiB    : Write          :   353.356 ms
Memfd 2 MiB    : Read+Write     :   352.829 ms
Memfd 2 MiB    : POPULATE_READ  :   351.954 ms
Memfd 2 MiB    : POPULATE_WRITE :   351.840 ms
Memfd 2 MiB    : FALLOCATE      :   351.274 ms
tmpfs          : Read           :  1096.222 ms
tmpfs          : Write          :   980.651 ms
tmpfs          : Read+Write     :  1114.757 ms
tmpfs          : POPULATE_READ  :   939.181 ms
tmpfs          : POPULATE_WRITE :   817.255 ms
tmpfs          : FALLOCATE      :   312.521 ms
file           : Read           :  1112.135 ms
file           : Write          :   967.688 ms
file           : Read+Write     :  1111.620 ms
file           : POPULATE_READ  :   951.175 ms
file           : POPULATE_WRITE :   818.380 ms
file           : FALLOCATE      :   313.008 ms
hugetlbfs      : Read           :   353.710 ms
hugetlbfs      : Write          :   353.309 ms
hugetlbfs      : Read+Write     :   353.280 ms
hugetlbfs      : POPULATE_READ  :   353.138 ms
hugetlbfs      : POPULATE_WRITE :   352.620 ms
hugetlbfs      : FALLOCATE      :   352.204 ms
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
 mm/gup.c                               | 54 ++++++++++++++++++++
 mm/internal.h                          |  3 ++
 mm/madvise.c                           | 69 ++++++++++++++++++++++++++
 8 files changed, 141 insertions(+)

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
index e40579624f10..80fad8578066 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1403,6 +1403,60 @@ long populate_vma_page_range(struct vm_area_struct *vma,
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
index 3f22c4ceb7b5..ee398696380f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -335,6 +335,9 @@ void __vma_unlink_list(struct mm_struct *mm, struct vm_area_struct *vma);
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
index 01fef79ac761..857460873f7a 100644
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
@@ -822,6 +824,64 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
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
+			case -EBUSY:
+			case -EAGAIN:
+				continue;
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
@@ -935,6 +995,9 @@ madvise_vma(struct vm_area_struct *vma, struct vm_area_struct **prev,
 	case MADV_FREE:
 	case MADV_DONTNEED:
 		return madvise_dontneed_free(vma, prev, start, end, behavior);
+	case MADV_POPULATE_READ:
+	case MADV_POPULATE_WRITE:
+		return madvise_populate(vma, prev, start, end, behavior);
 	default:
 		return madvise_behavior(vma, prev, start, end, behavior);
 	}
@@ -955,6 +1018,8 @@ madvise_behavior_valid(int behavior)
 	case MADV_FREE:
 	case MADV_COLD:
 	case MADV_PAGEOUT:
+	case MADV_POPULATE_READ:
+	case MADV_POPULATE_WRITE:
 #ifdef CONFIG_KSM
 	case MADV_MERGEABLE:
 	case MADV_UNMERGEABLE:
@@ -1042,6 +1107,10 @@ process_madvise_behavior_valid(int behavior)
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
2.29.2

