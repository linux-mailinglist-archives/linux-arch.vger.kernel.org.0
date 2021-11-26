Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D94F45E7B9
	for <lists+linux-arch@lfdr.de>; Fri, 26 Nov 2021 07:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343891AbhKZGOR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Nov 2021 01:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345645AbhKZGMI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Nov 2021 01:12:08 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D18C061574;
        Thu, 25 Nov 2021 22:08:56 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 71so7250954pgb.4;
        Thu, 25 Nov 2021 22:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=/v+ZevPO8Jeofw86ZAQaEHKzZ1qKhCceNSzVJc9Z12Q=;
        b=UIy7z7iVwE7tUICcJH2q7jARYJn6VoA6oNyeTrxv4T4rHZDBp6HiE6NrU+T3ObS0fB
         Sf77pgkLph2vRbhMeF/FRAPMERxuUpvDk61niFN3CgPs6paceUbgwmN1axTzN/WXJ4Ye
         Ujf2mTElVrPIxLJbHCrH0/HzlnLwC8fCHwZTmA8J0N539dXIhsVCVpWz4BCVnP7Hj+oP
         4FcG88XAt2O+T4ojzGa7Nf6ORTP1VW9YOhkgKgIsGv/EABeJutogGCGYZiJ02JtIc/8C
         lQGLH/eg0TG7mpqmIoPjdKhO9HlT9JJgzRymo5xA1Sw5JWbuc3EycMBfTWKcV9F7fti0
         W/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=/v+ZevPO8Jeofw86ZAQaEHKzZ1qKhCceNSzVJc9Z12Q=;
        b=Zx53IqJzCdhhUEBX09lJFGmQqMLbWHjZ8juRD7He/7Hpi3bttRs/EVPALpde2vDjBD
         ImdVyPtyq/wl0ORsbnNQmnE5vArN/R0Bg5ycyJ+6V5HKyDlOwYvBbXZ2MXkdm4xiajv0
         PwFDhwPqahgWrJjKpCUTPHOwAsUVdelDG9OjcNFiaV7tLJvgK2Uvf2EpNCyWC4dA6rIk
         Ojbp16Mql6+s53SN5w2jArfnNyz5ulLfCkiesqB6DnBrHIWyODqRe07mCNHb/MhHKKeQ
         fkvbWh1fgm247OGMUF4IUSn3rPFeCTNvxsH8V0ZKg0YS3zVHgKtcUtGOK/ETwRdqXFES
         RE0g==
X-Gm-Message-State: AOAM532jwDGzweCFoMSgmTgmV8bws1WjhiYv93L+rpkjW/T3NoLgwhiC
        PC3c/ABlEPfLR1RWCfJ20KZiOubKRj0=
X-Google-Smtp-Source: ABdhPJx4dDHLcmkO130v8wn++TLKMCP/CPF7Joomza+RmNBK/VG/eB0IgOWERwI4/Wtk02i6LQhT/w==
X-Received: by 2002:a63:91ca:: with SMTP id l193mr5982241pge.488.1637906935685;
        Thu, 25 Nov 2021 22:08:55 -0800 (PST)
Received: from smtpclient.apple ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id pc10sm5106275pjb.9.2021.11.25.22.08.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Nov 2021 22:08:55 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: [PATCH 4.9] hugetlbfs: flush TLBs correctly after  huge_pmd_unshare
Message-Id: <3BD89231-2CB9-4CE5-B0FA-5B58419D7CB8@gmail.com>
Date:   Thu, 25 Nov 2021 22:08:53 -0800
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
To:     Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Below is a patch to address CVE-2021-4002 [1] that I created to backport
to 4.9. The stable kernels of 4.14 and prior ones do not have unified
TLB flushing code, and I managed to mess up the arch code a couple of
times.

Now that the CVE is public, I would appreciate your review of this
patch. I send 4.9 for review - the other ones (4.14 and prior) are
pretty similar.

[1] https://www.openwall.com/lists/oss-security/2021/11/25/1

Thanks,
Nadav

-- >8 --

From: Nadav Amit <namit@vmware.com>
Date: Sat, 20 Nov 2021 12:55:21 -0800
Subject: [kernel v4.9 ] hugetlbfs: flush TLBs correctly after
 huge_pmd_unshare

When __unmap_hugepage_range() calls to huge_pmd_unshare() succeed, a TLB
flush is missing. This TLB flush must be performed before releasing the
i_mmap_rwsem, in order to prevent an unshared PMDs page from being
released and reused before the TLB flush took place.

Arguably, a comprehensive solution would use mmu_gather interface to
batch the TLB flushes and the PMDs page release, however it is not an
easy solution: (1) try_to_unmap_one() and try_to_migrate_one() also call
huge_pmd_unshare() and they cannot use the mmu_gather interface; and (2)
deferring the release of the page reference for the PMDs page until
after i_mmap_rwsem is dropeed can confuse huge_pmd_unshare() into
thinking PMDs are shared when they are not.

Fix __unmap_hugepage_range() by adding the missing TLB flush, and
forcing a flush when unshare is successful.

Fixes: 24669e58477e ("hugetlb: use mmu_gather instead of a temporary =
linked list for accumulating pages)" # 3.6
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/arm/include/asm/tlb.h  |  8 ++++++++
 arch/ia64/include/asm/tlb.h | 10 ++++++++++
 arch/s390/include/asm/tlb.h | 14 ++++++++++++++
 arch/sh/include/asm/tlb.h   | 10 ++++++++++
 arch/um/include/asm/tlb.h   | 12 ++++++++++++
 include/asm-generic/tlb.h   |  2 ++
 mm/hugetlb.c                | 19 +++++++++++++++++++
 mm/memory.c                 | 16 ++++++++++++++++
 8 files changed, 91 insertions(+)

diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index 1e25cd80589e..1cee2d540956 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -278,6 +278,14 @@ tlb_remove_pmd_tlb_entry(struct mmu_gather *tlb, =
pmd_t *pmdp, unsigned long addr
 	tlb_add_flush(tlb, addr);
 }
=20
+static inline void
+tlb_flush_pmd_range(struct mmu_gather *tlb, unsigned long address,
+		    unsigned long size)
+{
+	tlb_add_flush(tlb, address);
+	tlb_add_flush(tlb, address + size - PMD_SIZE);
+}
+
 #define pte_free_tlb(tlb, ptep, addr)	__pte_free_tlb(tlb, ptep, addr)
 #define pmd_free_tlb(tlb, pmdp, addr)	__pmd_free_tlb(tlb, pmdp, addr)
 #define pud_free_tlb(tlb, pudp, addr)	pud_free((tlb)->mm, pudp)
diff --git a/arch/ia64/include/asm/tlb.h b/arch/ia64/include/asm/tlb.h
index 77e541cf0e5d..34f4a5359561 100644
--- a/arch/ia64/include/asm/tlb.h
+++ b/arch/ia64/include/asm/tlb.h
@@ -272,6 +272,16 @@ __tlb_remove_tlb_entry (struct mmu_gather *tlb, =
pte_t *ptep, unsigned long addre
 	tlb->end_addr =3D address + PAGE_SIZE;
 }
=20
+static inline void
+tlb_flush_pmd_range(struct mmu_gather *tlb, unsigned long address,
+		    unsigned long size)
+{
+	if (tlb->start_addr > address)
+		tlb->start_addr =3D address;
+	if (tlb->end_addr < address + size)
+		tlb->end_addr =3D address + size;
+}
+
 #define tlb_migrate_finish(mm)	platform_tlb_migrate_finish(mm)
=20
 #define tlb_start_vma(tlb, vma)			do { } while (0)
diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
index 15711de10403..d2681d5a3d5a 100644
--- a/arch/s390/include/asm/tlb.h
+++ b/arch/s390/include/asm/tlb.h
@@ -116,6 +116,20 @@ static inline void tlb_remove_page_size(struct =
mmu_gather *tlb,
 	return tlb_remove_page(tlb, page);
 }
=20
+static inline void tlb_flush_pmd_range(struct mmu_gather *tlb,
+				unsigned long address, unsigned long =
size)
+{
+	/*
+	 * the range might exceed the original range that was provided =
to
+	 * tlb_gather_mmu(), so we need to update it despite the fact it =
is
+	 * usually not updated.
+	 */
+	if (tlb->start > address)
+		tlb->start =3D address;
+	if (tlb->end < address + size)
+		tlb->end =3D address + size;
+}
+
 /*
  * pte_free_tlb frees a pte table and clears the CRSTE for the
  * page table from the tlb.
diff --git a/arch/sh/include/asm/tlb.h b/arch/sh/include/asm/tlb.h
index 025cdb1032f6..7aba716fd9a5 100644
--- a/arch/sh/include/asm/tlb.h
+++ b/arch/sh/include/asm/tlb.h
@@ -115,6 +115,16 @@ static inline bool __tlb_remove_page_size(struct =
mmu_gather *tlb,
 	return __tlb_remove_page(tlb, page);
 }
=20
+static inline voide
+tlb_flush_pmd_range(struct mmu_gather *tlb, unsigned long address,
+		    unsigned long size)
+{
+	if (tlb->start > address)
+		tlb->start =3D address;
+	if (tlb->end < address + size)
+		tlb->end =3D address + size;
+}
+
 static inline bool __tlb_remove_pte_page(struct mmu_gather *tlb,
 					 struct page *page)
 {
diff --git a/arch/um/include/asm/tlb.h b/arch/um/include/asm/tlb.h
index 821ff0acfe17..6fb47b17179f 100644
--- a/arch/um/include/asm/tlb.h
+++ b/arch/um/include/asm/tlb.h
@@ -128,6 +128,18 @@ static inline void tlb_remove_page_size(struct =
mmu_gather *tlb,
 	return tlb_remove_page(tlb, page);
 }
=20
+static inline void
+tlb_flush_pmd_range(struct mmu_gather *tlb, unsigned long address,
+		    unsigned long size)
+{
+	tlb->need_flush =3D 1;
+
+	if (tlb->start > address)
+		tlb->start =3D address;
+	if (tlb->end < address + size)
+		tlb->end =3D address + size;
+}
+
 /**
  * tlb_remove_tlb_entry - remember a pte unmapping for later tlb =
invalidation.
  *
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index c6d667187608..e9851100c0f7 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -123,6 +123,8 @@ void tlb_finish_mmu(struct mmu_gather *tlb, unsigned =
long start,
 							unsigned long =
end);
 extern bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page =
*page,
 				   int page_size);
+void tlb_flush_pmd_range(struct mmu_gather *tlb, unsigned long address,
+			 unsigned long size);
=20
 static inline void __tlb_adjust_range(struct mmu_gather *tlb,
 				      unsigned long address)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index de89e9295f6c..7d51211995b9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3395,6 +3395,7 @@ void __unmap_hugepage_range(struct mmu_gather =
*tlb, struct vm_area_struct *vma,
 	unsigned long sz =3D huge_page_size(h);
 	const unsigned long mmun_start =3D start;	/* For =
mmu_notifiers */
 	const unsigned long mmun_end   =3D end;	/* For mmu_notifiers */
+	bool force_flush =3D false;
=20
 	WARN_ON(!is_vm_hugetlb_page(vma));
 	BUG_ON(start & ~huge_page_mask(h));
@@ -3411,6 +3412,8 @@ void __unmap_hugepage_range(struct mmu_gather =
*tlb, struct vm_area_struct *vma,
 		ptl =3D huge_pte_lock(h, mm, ptep);
 		if (huge_pmd_unshare(mm, &address, ptep)) {
 			spin_unlock(ptl);
+			tlb_flush_pmd_range(tlb, address & PUD_MASK, =
PUD_SIZE);
+			force_flush =3D true;
 			continue;
 		}
=20
@@ -3467,6 +3470,22 @@ void __unmap_hugepage_range(struct mmu_gather =
*tlb, struct vm_area_struct *vma,
 	}
 	mmu_notifier_invalidate_range_end(mm, mmun_start, mmun_end);
 	tlb_end_vma(tlb, vma);
+
+	/*
+	 * If we unshared PMDs, the TLB flush was not recorded in =
mmu_gather. We
+	 * could defer the flush until now, since by holding =
i_mmap_rwsem we
+	 * guaranteed that the last refernece would not be dropped. But =
we must
+	 * do the flushing before we return, as otherwise i_mmap_rwsem =
will be
+	 * dropped and the last reference to the shared PMDs page might =
be
+	 * dropped as well.
+	 *
+	 * In theory we could defer the freeing of the PMD pages as =
well, but
+	 * huge_pmd_unshare() relies on the exact page_count for the PMD =
page to
+	 * detect sharing, so we cannot defer the release of the page =
either.
+	 * Instead, do flush now.
+	 */
+	if (force_flush)
+		tlb_flush_mmu(tlb);
 }
=20
 void __unmap_hugepage_range_final(struct mmu_gather *tlb,
diff --git a/mm/memory.c b/mm/memory.c
index be592d434ad8..c2890dc104d9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -320,6 +320,22 @@ bool __tlb_remove_page_size(struct mmu_gather *tlb, =
struct page *page, int page_
 	return false;
 }
=20
+void tlb_flush_pmd_range(struct mmu_gather *tlb, unsigned long address,
+			 unsigned long size)
+{
+	if (tlb->page_size !=3D 0 && tlb->page_size !=3D PMD_SIZE)
+		tlb_flush_mmu(tlb);
+
+	tlb->page_size =3D PMD_SIZE;
+	tlb->start =3D min(tlb->start, address);
+	tlb->end =3D max(tlb->end, address + size);
+	/*
+	 * Track the last address with which we adjusted the range. This
+	 * will be used later to adjust again after a mmu_flush due to
+	 * failed __tlb_remove_page
+	 */
+	tlb->addr =3D address + size - PMD_SIZE;
+}
 #endif /* HAVE_GENERIC_MMU_GATHER */
=20
 #ifdef CONFIG_HAVE_RCU_TABLE_FREE
--=20
2.25.1

