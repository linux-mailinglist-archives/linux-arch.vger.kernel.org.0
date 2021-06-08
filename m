Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8714C39FB93
	for <lists+linux-arch@lfdr.de>; Tue,  8 Jun 2021 18:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbhFHQDH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Jun 2021 12:03:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27925 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233695AbhFHQDF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Jun 2021 12:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623168072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ny0GQOcOMIJ9f9GtQNBSHCKyJm/TZJpAh/jRCTYyLxE=;
        b=VhaNSBSVb4jHaq2EckzEVHFOZSGnmlnIZpU8X35kUOjRBdI/CGQneuZV5Wv5a0/H37RNwS
        F2zPzNnPed9fYMWgM3RxJ0QpAjBMPZCwwumqz9LCeoZ0cJuV6hzijQ1JopueVkN+LfhDLN
        f+C1B09sEp1IFDD2bbV525HsinfMVEo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-4Lo9xQCRPVGWI_y5gK4qVQ-1; Tue, 08 Jun 2021 12:01:08 -0400
X-MC-Unique: 4Lo9xQCRPVGWI_y5gK4qVQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB2EC501F4;
        Tue,  8 Jun 2021 16:01:04 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-132.ams2.redhat.com [10.36.115.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F1584189C7;
        Tue,  8 Jun 2021 16:00:49 +0000 (UTC)
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
        Rolf Eike Beer <eike-kernel@sf-tec.de>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, Linux API <linux-api@vger.kernel.org>
Subject: [PATCH] madvise.2: Document MADV_POPULATE_READ and MADV_POPULATE_WRITE
Date:   Tue,  8 Jun 2021 18:00:49 +0200
Message-Id: <20210608160049.24685-1-david@redhat.com>
In-Reply-To: <20210511081534.3507-1-david@redhat.com>
References: <20210511081534.3507-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Let's document MADV_POPULATE_READ and MADV_POPULATE_WRITE behavior and
error conditions.

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
Cc: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: linux-alpha@vger.kernel.org
Cc: linux-mips@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linux-xtensa@linux-xtensa.org
Cc: linux-arch@vger.kernel.org
Cc: Linux API <linux-api@vger.kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

Not for upstream man pages yet, only for linux-mm and linux-api review
purposes. Once/if the linux changes are merged upstream, I'll send it to
the proper man list/maintainers.

---
 man2/madvise.2 | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/man2/madvise.2 b/man2/madvise.2
index f1f384c0c..3ec8c53a7 100644
--- a/man2/madvise.2
+++ b/man2/madvise.2
@@ -469,6 +469,59 @@ If a page is file-backed and dirty, it will be written back to the backing
 storage.
 The advice might be ignored for some pages in the range when it is not
 applicable.
+.TP
+.BR MADV_POPULATE_READ " (since Linux 5.14)
+Populate (prefault) page tables readable for the whole range without actually
+reading. Depending on the underlying mapping, map the shared zeropage,
+preallocate memory or read the underlying file; files with holes might or
+might not preallocate blocks.
+Do not generate
+.B SIGBUS
+when populating fails, return an error instead.
+.IP
+If
+.B MADV_POPULATE_READ
+succeeds, all page tables have been populated (prefaulted) readable once.
+If
+.B MADV_POPULATE_READ
+fails, some page tables might have been populated.
+.IP
+.B MADV_POPULATE_READ
+cannot be applied to mappings without read permissions
+and special mappings marked with the kernel-internal
+.B VM_PFNMAP
+and
+.BR VM_IO .
+.IP
+Note that with
+.BR MADV_POPULATE_READ ,
+the process can be killed at any moment when the system runs out of memory.
+.TP
+.BR MADV_POPULATE_WRITE " (since Linux 5.14)
+Populate (prefault) page tables writable for the whole range without actually
+writing. Depending on the underlying mapping, preallocate memory or read the
+underlying file; files with holes will preallocate blocks.
+Do not generate
+.B SIGBUS
+when populating fails, return an error instead.
+.IP
+If
+.B MADV_POPULATE_WRITE
+succeeds, all page tables have been populated (prefaulted) writable once.
+If
+.B MADV_POPULATE_WRITE
+fails, some page tables might have been populated.
+.IP
+.B MADV_POPULATE_WRITE
+cannot be applied to mappings without write permissions
+and special mappings marked with the kernel-internal
+.B VM_PFNMAP
+and
+.BR VM_IO .
+.IP
+Note that
+.BR MADV_POPULATE_WRITE ,
+the process can be killed at any moment when the system runs out of memory.
 .SH RETURN VALUE
 On success,
 .BR madvise ()
@@ -533,6 +586,17 @@ or
 .BR VM_PFNMAP
 ranges.
 .TP
+.B EINVAL
+.I advice
+is
+.B MADV_POPULATE_READ
+or
+.BR MADV_POPULATE_WRITE ,
+but the specified address range includes ranges with insufficient permissions,
+.B VM_IO
+or
+.BR VM_PFNMAP.
+.TP
 .B EIO
 (for
 .BR MADV_WILLNEED )
@@ -548,6 +612,14 @@ Not enough memory: paging in failed.
 Addresses in the specified range are not currently
 mapped, or are outside the address space of the process.
 .TP
+.B ENOMEM
+.I advice
+is
+.B MADV_POPULATE_READ
+or
+.BR MADV_POPULATE_WRITE ,
+but populating (prefaulting) page tables failed.
+.TP
 .B EPERM
 .I advice
 is
@@ -555,6 +627,14 @@ is
 but the caller does not have the
 .B CAP_SYS_ADMIN
 capability.
+.TP
+.B EHWPOISON
+.I advice
+is
+.B MADV_POPULATE_READ
+or
+.BR MADV_POPULATE_WRITE ,
+and a HW poisoned page is encountered.
 .SH VERSIONS
 Since Linux 3.18,
 .\" commit d3ac21cacc24790eb45d735769f35753f5b56ceb
-- 
2.31.1

