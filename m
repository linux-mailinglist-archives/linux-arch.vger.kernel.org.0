Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6A131EAF3
	for <lists+linux-arch@lfdr.de>; Thu, 18 Feb 2021 15:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhBRO00 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Feb 2021 09:26:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38964 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232723AbhBRMYI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 18 Feb 2021 07:24:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613650960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yhLVfX0fB/D8R1zKoQVO+TMTBrUwUHt7HIxasf2kZek=;
        b=Al081Z3aHbE5jdQK80eTI7QmH5Gpc/UmEcSCSp1N+3NUc118lXFA6lW6iJyXCYP6gcSESU
        e/egyXlvEUcFkwth4sJUkP+tD1LLTpzJcYdfjrGICmpRH0ilBSE8tjvof/2oSg/OvFyq4w
        HpxBShX6FYU7dN0k1lgM59mtkZ0I1Lg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-nqPI8Ju-OrO5-wTceZ7uYA-1; Thu, 18 Feb 2021 07:22:36 -0500
X-MC-Unique: nqPI8Ju-OrO5-wTceZ7uYA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A694835E25;
        Thu, 18 Feb 2021 12:22:32 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-59.ams2.redhat.com [10.36.114.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A9F02C01F;
        Thu, 18 Feb 2021 12:22:17 +0000 (UTC)
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
Subject: [PATCH RFC] madvise.2: Document MADV_POPULATE
Date:   Thu, 18 Feb 2021 13:22:16 +0100
Message-Id: <20210218122216.12424-1-david@redhat.com>
In-Reply-To: <20210217154844.12392-1-david@redhat.com>
References: <20210217154844.12392-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Preview of MADV_POPULATE documentation, which is still under discussion:
https://lkml.kernel.org/r/20210217154844.12392-1-david@redhat.com

Once/if merged, there will be an official patch to man-page folks.

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
 man2/madvise.2 | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/man2/madvise.2 b/man2/madvise.2
index 2af407212..ff08768a3 100644
--- a/man2/madvise.2
+++ b/man2/madvise.2
@@ -469,6 +469,48 @@ If a page is file-backed and dirty, it will be written back to the backing
 storage.
 The advice might be ignored for some pages in the range when it is not
 applicable.
+.TP
+.BR MADV_POPULATE " (since Linux 5.13)
+Populate (prefault) page tables for the whole range.
+Depending on the underlying mapping, preallocate memory or read the
+underlying file.
+Do not generate
+.B SIGBUS
+when populating fails, return an error instead.
+The populate semantics match
+.BR MAP_POPULATE
+(see
+.BR mmap (2))
+with the exception that
+.B MADV_POPULATE
+fails if there is a proplem populating page tables.
+.B MADV_POPULATE
+simulates user space access to all pages in the range without actually
+reading/writing the pages.
+For private, writable mappings, simulate a write access; for all other
+mappings, simulate a read access.
+.IP
+If
+.B MADV_POPULATE
+succeeds, all page tables have been populated (prefaulted) once.
+If
+.B MADV_POPULATE
+fails, some page tables might have been populated.
+.IP
+.B MADV_POPULATE
+cannot be applied to
+.B PROT_NONE
+and special mappings marked with the kernel-internal
+.B VM_PFNMAP
+and
+.BR VM_IO .
+.IP
+Note that
+.B MADV_POPULATE
+will ignore any poisoned pages in the range.
+Similar to
+.BR MAP_POPULATE ,
+it cannot protect from the OOM (Out Of Memory) handler killing the process.
 .SH RETURN VALUE
 On success,
 .BR madvise ()
@@ -533,6 +575,17 @@ or
 .BR VM_PFNMAP
 ranges.
 .TP
+.B EINVAL
+.I advice
+is
+.BR MADV_POPULATE ,
+but the specified address range includes
+.BR PROT_NONE ,
+.B VM_IO
+or
+.B VM_PFNMAP
+ranges.
+.TP
 .B EIO
 (for
 .BR MADV_WILLNEED )
@@ -548,6 +601,12 @@ Not enough memory: paging in failed.
 Addresses in the specified range are not currently
 mapped, or are outside the address space of the process.
 .TP
+.B ENOMEM
+.I advice
+is
+.BR MADV_POPULATE ,
+but populating (prefaulting) page tables failed.
+.TP
 .B EPERM
 .I advice
 is
-- 
2.29.2

