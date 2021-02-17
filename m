Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9DA31DCB2
	for <lists+linux-arch@lfdr.de>; Wed, 17 Feb 2021 16:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbhBQPui (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Feb 2021 10:50:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57811 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233845AbhBQPuf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 17 Feb 2021 10:50:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613576947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yAWDsPHL6qVi6EQFSh9JjZtDjXH6VNWvFfdhBEAIS5U=;
        b=UxQkMfRkHNGmHRwBqLg16/7SHP5tgRFbW5291CR+HAa0w9VO5P3QX24bEIz5vcC8s+zpqp
        PliLyE1qvIe1TsToPZW14tG9Ynbl+WmshhSn4SsLo26koidiZk6eWh100icFrkvm0/e2Cz
        bKalmvqe2tYNSLgVM45Vh+pgCGhytgo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-kNffKRMnOdqMBusloKeOcg-1; Wed, 17 Feb 2021 10:49:02 -0500
X-MC-Unique: kNffKRMnOdqMBusloKeOcg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DBDB107ACF7;
        Wed, 17 Feb 2021 15:48:58 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-178.ams2.redhat.com [10.36.114.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 884435C3E4;
        Wed, 17 Feb 2021 15:48:45 +0000 (UTC)
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
        Max Filippov <jcmvbkbc@gmail.com>, linux-alpha@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org
Subject: [PATCH RFC] mm/madvise: introduce MADV_POPULATE to prefault/prealloc memory
Date:   Wed, 17 Feb 2021 16:48:44 +0100
Message-Id: <20210217154844.12392-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When we manage sparse memory mappings dynamically in user space - also
sometimes involving MADV_NORESERVE - we want to dynamically populate/
discard memory inside such a sparse memory region. Example users are
hypervisors (especially implementing memory ballooning or similar
technologies like virtio-mem) and memory allocators. In addition, we want
to fail in a nice way if populating does not succeed because we are out of
backend memory (which can happen easily with file-based mappings,
especially tmpfs and hugetlbfs).

While MADV_DONTNEED and FALLOC_FL_PUNCH_HOLE provide us ways to reliably
discard memory, there is no generic approach to populate ("preallocate")
memory.

Although mmap() supports MAP_POPULATE, it is not applicable to the concept
of sparse memory mappings, where we want to do populate/discard
dynamically and avoid expensive/problematic remappings. In addition,
we never actually report error during the final populate phase - it is
best-effort only.

fallocate() can be used to preallocate file-based memory and fail in a safe
way. However, it is less useful for private mappings on anonymous files
due to COW semantics. For example, using fallocate() to preallocate memory
on an anonymous memfd files that are mapped MAP_PRIVATE results in a double
memory consumption when actually writing via the mapping. In addition,
fallocate() does not actually populate page tables, so we still always
have to resolve minor faults on first access.

Because we don't have a proper interface, what applications
(like QEMU and databases) end up doing is touching (i.e., writing) all
individual pages. However, it requires expensive signal handling (SIGBUS);
for example, this is problematic in hypervisors like QEMU where SIGBUS
handlers might already be used by other subsystems concurrently to e.g,
handle hardware errors. "Simply" doing preallocation from another thread
is not that easy.

Let's introduce MADV_POPULATE with the following semantics
1. MADV_POPULATED does not work on PROT_NONE and special VMAs. It works
   on everything else.
2. Errors during MADV_POPULATED (especially OOM) are reported. If we hit
   hardware errors on pages, ignore them - nothing we really can or
   should do.
3. On errors during MADV_POPULATED, some memory might have been
   populated. Callers have to clean up if they care.
4. Concurrent changes to the virtual memory layour are tolerated - we
   process each and every PFN only once, though.
5. If MADV_POPULATE succeeds, all memory in the range can be accessed
   without SIGBUS. (of course, not if user space changed mappings in the
   meantime or KSM kicked in on anonymous memory).

Although sparse memory mappings are the primary use case, this will
also be useful for ordinary preallocations where MAP_POPULATE is not
desired (e.g., in QEMU, where users can trigger preallocation of
guest RAM after the mapping was created).

Looking at the history, MADV_POPULATE was already proposed in 2013 [1],
however, the main motivation back than was performance improvements
(which should also still be the case, but it's a seconary concern).

Basic functionality was tested with:
- anonymous memory
- MAP_PRIVATE on anonymous file via memfd
- MAP_SHARED on anonymous file via memf
- MAP_PRIVATE on anonymous hugetlbfs file via memfd
- MAP_SHARED on anonymous hugetlbfs file via memfd
- MAP_PRIVATE on tmpfs/shmem file (we end up with double memory consumption
  though, as the actual file gets populated with zeroes)
- MAP_SHARED on tmpfs/shmem file

Note: For populating/preallocating zeroed-out memory while userfaultfd is
active, it's even faster to use first fallocate() or placing zeroed pages
via userfaultfd APIs. Otherwise, we'll have to route every fault while
populating via the userfaultfd handler.

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
Cc: linux-alpha@vger.kernel.org
Cc: linux-mips@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linux-xtensa@linux-xtensa.org
Cc: linux-arch@vger.kernel.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---

If we agree that this makes sense I'll do more testing to see if we
are missing any return value handling and prepare a man page update to
document the semantics.

Thoughts?

---
 arch/alpha/include/uapi/asm/mman.h     |  2 +
 arch/mips/include/uapi/asm/mman.h      |  2 +
 arch/parisc/include/uapi/asm/mman.h    |  2 +
 arch/xtensa/include/uapi/asm/mman.h    |  2 +
 include/uapi/asm-generic/mman-common.h |  2 +
 mm/madvise.c                           | 70 ++++++++++++++++++++++++++
 6 files changed, 80 insertions(+)

diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uapi/asm/mman.h
index a18ec7f63888..e90eeb5e6cf1 100644
--- a/arch/alpha/include/uapi/asm/mman.h
+++ b/arch/alpha/include/uapi/asm/mman.h
@@ -71,6 +71,8 @@
 #define MADV_COLD	20		/* deactivate these pages */
 #define MADV_PAGEOUT	21		/* reclaim these pages */
 
+#define MADV_POPULATE	22		/* populate pages */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/arch/mips/include/uapi/asm/mman.h b/arch/mips/include/uapi/asm/mman.h
index 57dc2ac4f8bd..b928becc5308 100644
--- a/arch/mips/include/uapi/asm/mman.h
+++ b/arch/mips/include/uapi/asm/mman.h
@@ -98,6 +98,8 @@
 #define MADV_COLD	20		/* deactivate these pages */
 #define MADV_PAGEOUT	21		/* reclaim these pages */
 
+#define MADV_POPULATE	22		/* populate pages */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/arch/parisc/include/uapi/asm/mman.h b/arch/parisc/include/uapi/asm/mman.h
index ab78cba446ed..9d3a56044287 100644
--- a/arch/parisc/include/uapi/asm/mman.h
+++ b/arch/parisc/include/uapi/asm/mman.h
@@ -52,6 +52,8 @@
 #define MADV_COLD	20		/* deactivate these pages */
 #define MADV_PAGEOUT	21		/* reclaim these pages */
 
+#define MADV_POPULATE	22		/* populate pages */
+
 #define MADV_MERGEABLE   65		/* KSM may merge identical pages */
 #define MADV_UNMERGEABLE 66		/* KSM may not merge identical pages */
 
diff --git a/arch/xtensa/include/uapi/asm/mman.h b/arch/xtensa/include/uapi/asm/mman.h
index e5e643752947..3169b1be8920 100644
--- a/arch/xtensa/include/uapi/asm/mman.h
+++ b/arch/xtensa/include/uapi/asm/mman.h
@@ -106,6 +106,8 @@
 #define MADV_COLD	20		/* deactivate these pages */
 #define MADV_PAGEOUT	21		/* reclaim these pages */
 
+#define MADV_POPULATE	22		/* populate pages */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index f94f65d429be..fa617fd0d733 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -72,6 +72,8 @@
 #define MADV_COLD	20		/* deactivate these pages */
 #define MADV_PAGEOUT	21		/* reclaim these pages */
 
+#define MADV_POPULATE	22		/* populate pages */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/mm/madvise.c b/mm/madvise.c
index 6a660858784b..f76fdd6fcf10 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -53,6 +53,7 @@ static int madvise_need_mmap_write(int behavior)
 	case MADV_COLD:
 	case MADV_PAGEOUT:
 	case MADV_FREE:
+	case MADV_POPULATE:
 		return 0;
 	default:
 		/* be safe, default to 1. list exceptions explicitly */
@@ -821,6 +822,72 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 		return -EINVAL;
 }
 
+static long madvise_populate(struct vm_area_struct *vma,
+			     struct vm_area_struct **prev,
+			     unsigned long start, unsigned long end)
+{
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
+			if (!vma)
+				return -ENOMEM;
+		}
+
+		/* Bail out on incompatible VMA types. */
+		if (vma->vm_flags & (VM_IO | VM_PFNMAP) ||
+		    !vma_is_accessible(vma)) {
+			return -EINVAL;
+		}
+
+		/*
+		 * Populate pages and take care of VM_LOCKED: simulate user
+		 * space access.
+		 *
+		 * For private, writable mappings, trigger a write fault to
+		 * break COW (i.e., shared zeropage). For other mappings (i.e.,
+		 * read-only, shared), trigger a read fault.
+		 */
+		tmp_end = min_t(unsigned long, end, vma->vm_end);
+		pages = populate_vma_page_range(vma, start, tmp_end, &locked);
+		if (!locked) {
+			mmap_read_lock(mm);
+			*prev = NULL;
+			vma = NULL;
+		}
+		if (pages < 0) {
+			switch (pages) {
+			case -EINTR:
+			case -ENOMEM:
+				return pages;
+			case -EHWPOISON:
+				/* Skip over any poisoned pages. */
+				start += PAGE_SIZE;
+				continue;
+			case -EBUSY:
+			case -EAGAIN:
+				continue;
+			default:
+				pr_warn_once("%s: unhandled return value: %ld\n",
+					     __func__, pages);
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
@@ -934,6 +1001,8 @@ madvise_vma(struct vm_area_struct *vma, struct vm_area_struct **prev,
 	case MADV_FREE:
 	case MADV_DONTNEED:
 		return madvise_dontneed_free(vma, prev, start, end, behavior);
+	case MADV_POPULATE:
+		return madvise_populate(vma, prev, start, end);
 	default:
 		return madvise_behavior(vma, prev, start, end, behavior);
 	}
@@ -954,6 +1023,7 @@ madvise_behavior_valid(int behavior)
 	case MADV_FREE:
 	case MADV_COLD:
 	case MADV_PAGEOUT:
+	case MADV_POPULATE:
 #ifdef CONFIG_KSM
 	case MADV_MERGEABLE:
 	case MADV_UNMERGEABLE:
-- 
2.29.2

