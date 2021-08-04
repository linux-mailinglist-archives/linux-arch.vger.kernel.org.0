Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2D73DFB80
	for <lists+linux-arch@lfdr.de>; Wed,  4 Aug 2021 08:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbhHDGkC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Aug 2021 02:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235419AbhHDGkC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Aug 2021 02:40:02 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FD8C0613D5
        for <linux-arch@vger.kernel.org>; Tue,  3 Aug 2021 23:39:50 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id k4-20020a17090a5144b02901731c776526so7298444pjm.4
        for <linux-arch@vger.kernel.org>; Tue, 03 Aug 2021 23:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=BtfwfkdG35FZn7ied7IlEDffarc6OScgB5ElAoNnM0U=;
        b=rpFULyDvrL8K0pVshBTPz+RnFXYNIygLxpBHlLyZiS4yGCcC6FNh6Yy71+SF4tuKjm
         V56ex+MYAo0qQMbXPkNq/fybOebfQ0W5i0QlfoD/zR4pQ3A397WM3sQM21XWeGL0TAVn
         uuGKSWF9K0D6XcBt7WuG3HBLxVdyLA3ulJXwMc/sPxu+zANPsWPXv6Ww9CVjxo8xT6e+
         q2r4xm0n4yXwK2hmsbvZzQzJ4c7rgCs+icywyXejQX69rNulexariDulnEdtASJ+IXg5
         yWq5rZm5H7I2WnRienThHOFSp9yUPLS9W4cdRessIf0Ox1qUhlZmASXtwVVafhUltod9
         ilqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=BtfwfkdG35FZn7ied7IlEDffarc6OScgB5ElAoNnM0U=;
        b=WV3YRAInAAMwiynzw4kii+TLjz9z4qcFqWzSLc1RjhqPBrYxqOX6yM404qdS0FCq1v
         VJ02C0EvtqleX2mkKv7ldwr8/e0yQAN5JJeqgkwXifwiKuTFjejBR392nxjyZsK8A3wU
         J30DEA1ivil+JilZlhtZ3V7NFtGhM2NCtTz0Ld+h7yTC7po4h871yHadACXunAvg/j5p
         QlHBOyAcUVJWiO6OTP6aOGTJ5YNw8rXyfiUryktHAqqy6HgWcZ1GiipbDb3w5w/op9jn
         fzb6iFSpzikt5u0wMKxCDf9qQZxK3qA7/hHi8Pz9r3/Y6mfStMtmVM2co3ZkCJgtHxGF
         hhnQ==
X-Gm-Message-State: AOAM533tUsls4LTWDTODRld24c+72aTtp/aS8Q4a447hTd6cyHKTgcZB
        8qSG+UEDLO3r2XxwUs7y08UIdY+I6fc=
X-Google-Smtp-Source: ABdhPJyTTRAmsYnlvqdHOjtUcU9CMfpXasKZPvtTLvZZT4nY3PGkGEMb6TcgbW9E8t/u8X1rD3O7iw==
X-Received: by 2002:a17:90a:b38e:: with SMTP id e14mr21705016pjr.170.1628059189803;
        Tue, 03 Aug 2021 23:39:49 -0700 (PDT)
Received: from localhost (60-242-181-102.static.tpgi.com.au. [60.242.181.102])
        by smtp.gmail.com with ESMTPSA id a35sm1523105pgm.66.2021.08.03.23.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 23:39:49 -0700 (PDT)
Date:   Wed, 04 Aug 2021 16:39:44 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH] powerpc/book3s64/radix: Upgrade va tlbie to PID tlbie
 if we cross PMD_SIZE
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
References: <20210803143725.615186-1-aneesh.kumar@linux.ibm.com>
        <1628053302.0qclx0xcj9.astroid@bobo.none>
In-Reply-To: <1628053302.0qclx0xcj9.astroid@bobo.none>
MIME-Version: 1.0
Message-Id: <1628058455.rphrivzjzb.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Nicholas Piggin's message of August 4, 2021 3:14 pm:
> Excerpts from Aneesh Kumar K.V's message of August 4, 2021 12:37 am:
>> With shared mapping, even though we are unmapping a large range, the ker=
nel
>> will force a TLB flush with ptl lock held to avoid the race mentioned in
>> commit 1cf35d47712d ("mm: split 'tlb_flush_mmu()' into tlb flushing and =
memory freeing parts")
>> This results in the kernel issuing a high number of TLB flushes even for=
 a large
>> range. This can be improved by making sure the kernel switch to pid base=
d flush if the
>> kernel is unmapping a 2M range.
>=20
> It would be good to have a bit more description here.
>=20
> In any patch that changes a heuristic like this, I would like to see=20
> some justification or reasoning that could be refuted or used as a=20
> supporting argument if we ever wanted to change the heuristic later.
> Ideally with some of the obvious downsides listed as well.
>=20
> This "improves" things here, but what if it hurt things elsewhere, how=20
> would we come in later and decide to change it back?
>=20
> THP flushes for example, I think now they'll do PID flushes (if they=20
> have to be broadcast, which they will tend to be when khugepaged does
> them). So now that might increase jitter for THP and cause it to be a
> loss for more workloads.
>=20
> So where do you notice this? What's the benefit?

For that matter, I wonder if we shouldn't do something like this=20
(untested) so the low level batch flush has visibility to the high
level flush range.

x86 could use this too AFAIKS, just needs to pass the range a bit
further down, but in practice I'm not sure it would ever really
matter for them because the 2MB level exceeds the single page flush
ceiling for 4k pages unlike powerpc with 64k pages. But in corner
cases where the unmap crossed a bunch of small vmas or the ceiling
was increased then in theory it could be of use.

Subject: [PATCH v1] mm/mmu_gather: provide archs with the entire range that=
 is
 to be flushed, not just the particular gather

This allows archs to optimise flushing heuristics better, in the face of
flush operations forcing smaller flush batches. For example, an
architecture may choose a more costly per-page invalidation for small
ranges of pages with the assumption that the full TLB flush cost would
be more expensive in terms of refills. However if a very large range is
forced into flushing small ranges, the faster full-process flush may
have been the better choice.

---
 arch/powerpc/mm/book3s64/radix_tlb.c | 33 ++++++++++++++++------------
 fs/exec.c                            |  3 ++-
 include/asm-generic/tlb.h            |  9 ++++++++
 include/linux/mm_types.h             |  3 ++-
 mm/hugetlb.c                         |  2 +-
 mm/madvise.c                         |  6 ++---
 mm/memory.c                          |  4 ++--
 mm/mmap.c                            |  2 +-
 mm/mmu_gather.c                      | 10 ++++++---
 mm/oom_kill.c                        |  2 +-
 10 files changed, 47 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/book3s6=
4/radix_tlb.c
index aefc100d79a7..e1072d85d72e 100644
--- a/arch/powerpc/mm/book3s64/radix_tlb.c
+++ b/arch/powerpc/mm/book3s64/radix_tlb.c
@@ -1110,12 +1110,13 @@ static unsigned long tlb_single_page_flush_ceiling =
__read_mostly =3D 33;
 static unsigned long tlb_local_single_page_flush_ceiling __read_mostly =3D=
 POWER9_TLB_SETS_RADIX * 2;
=20
 static inline void __radix__flush_tlb_range(struct mm_struct *mm,
-					    unsigned long start, unsigned long end)
+					    unsigned long start, unsigned long end,
+					    unsigned long entire_range)
 {
 	unsigned long pid;
 	unsigned int page_shift =3D mmu_psize_defs[mmu_virtual_psize].shift;
 	unsigned long page_size =3D 1UL << page_shift;
-	unsigned long nr_pages =3D (end - start) >> page_shift;
+	unsigned long entire_nr_pages =3D entire_range >> page_shift;
 	bool fullmm =3D (end =3D=3D TLB_FLUSH_ALL);
 	bool flush_pid, flush_pwc =3D false;
 	enum tlb_flush_type type;
@@ -1133,9 +1134,9 @@ static inline void __radix__flush_tlb_range(struct mm=
_struct *mm,
 	if (fullmm)
 		flush_pid =3D true;
 	else if (type =3D=3D FLUSH_TYPE_GLOBAL)
-		flush_pid =3D nr_pages > tlb_single_page_flush_ceiling;
+		flush_pid =3D entire_nr_pages > tlb_single_page_flush_ceiling;
 	else
-		flush_pid =3D nr_pages > tlb_local_single_page_flush_ceiling;
+		flush_pid =3D entire_nr_pages > tlb_local_single_page_flush_ceiling;
 	/*
 	 * full pid flush already does the PWC flush. if it is not full pid
 	 * flush check the range is more than PMD and force a pwc flush
@@ -1220,7 +1221,7 @@ void radix__flush_tlb_range(struct vm_area_struct *vm=
a, unsigned long start,
 		return radix__flush_hugetlb_tlb_range(vma, start, end);
 #endif
=20
-	__radix__flush_tlb_range(vma->vm_mm, start, end);
+	__radix__flush_tlb_range(vma->vm_mm, start, end, end - start);
 }
 EXPORT_SYMBOL(radix__flush_tlb_range);
=20
@@ -1278,6 +1279,11 @@ void radix__flush_all_lpid_guest(unsigned int lpid)
 	_tlbie_lpid_guest(lpid, RIC_FLUSH_ALL);
 }
=20
+static void __radix__flush_tlb_range_psize(struct mm_struct *mm,
+				unsigned long start, unsigned long end,
+				unsigned long entire_range,
+				int psize, bool also_pwc);
+
 void radix__tlb_flush(struct mmu_gather *tlb)
 {
 	int psize =3D 0;
@@ -1285,6 +1291,7 @@ void radix__tlb_flush(struct mmu_gather *tlb)
 	int page_size =3D tlb->page_size;
 	unsigned long start =3D tlb->start;
 	unsigned long end =3D tlb->end;
+	unsigned long entire_range =3D tlb->entire_end - tlb->entire_start;
=20
 	/*
 	 * if page size is not something we understand, do a full mm flush
@@ -1301,21 +1308,19 @@ void radix__tlb_flush(struct mmu_gather *tlb)
 		else
 			radix__flush_all_mm(mm);
 	} else {
-		if (!tlb->freed_tables)
-			radix__flush_tlb_range_psize(mm, start, end, psize);
-		else
-			radix__flush_tlb_pwc_range_psize(mm, start, end, psize);
+		__radix__flush_tlb_range_psize(mm, start, end, entire_range, psize, tlb-=
>freed_tables);
 	}
 }
=20
 static void __radix__flush_tlb_range_psize(struct mm_struct *mm,
 				unsigned long start, unsigned long end,
+				unsigned long entire_range,
 				int psize, bool also_pwc)
 {
 	unsigned long pid;
 	unsigned int page_shift =3D mmu_psize_defs[psize].shift;
 	unsigned long page_size =3D 1UL << page_shift;
-	unsigned long nr_pages =3D (end - start) >> page_shift;
+	unsigned long entire_nr_pages =3D entire_range >> page_shift;
 	bool fullmm =3D (end =3D=3D TLB_FLUSH_ALL);
 	bool flush_pid;
 	enum tlb_flush_type type;
@@ -1335,9 +1340,9 @@ static void __radix__flush_tlb_range_psize(struct mm_=
struct *mm,
 	if (fullmm)
 		flush_pid =3D true;
 	else if (type =3D=3D FLUSH_TYPE_GLOBAL)
-		flush_pid =3D nr_pages > tlb_single_page_flush_ceiling;
+		flush_pid =3D entire_nr_pages > tlb_single_page_flush_ceiling;
 	else
-		flush_pid =3D nr_pages > tlb_local_single_page_flush_ceiling;
+		flush_pid =3D entire_nr_pages > tlb_local_single_page_flush_ceiling;
=20
 	if (!mmu_has_feature(MMU_FTR_GTSE) && type =3D=3D FLUSH_TYPE_GLOBAL) {
 		unsigned long tgt =3D H_RPTI_TARGET_CMMU;
@@ -1381,13 +1386,13 @@ static void __radix__flush_tlb_range_psize(struct m=
m_struct *mm,
 void radix__flush_tlb_range_psize(struct mm_struct *mm, unsigned long star=
t,
 				  unsigned long end, int psize)
 {
-	return __radix__flush_tlb_range_psize(mm, start, end, psize, false);
+	return __radix__flush_tlb_range_psize(mm, start, end, end - start, psize,=
 false);
 }
=20
 void radix__flush_tlb_pwc_range_psize(struct mm_struct *mm, unsigned long =
start,
 				      unsigned long end, int psize)
 {
-	__radix__flush_tlb_range_psize(mm, start, end, psize, true);
+	__radix__flush_tlb_range_psize(mm, start, end, end - start, psize, true);
 }
=20
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
diff --git a/fs/exec.c b/fs/exec.c
index 38f63451b928..c769c12bdf56 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -705,11 +705,11 @@ static int shift_arg_pages(struct vm_area_struct *vma=
, unsigned long shift)
 		return -ENOMEM;
=20
 	lru_add_drain();
-	tlb_gather_mmu(&tlb, mm);
 	if (new_end > old_start) {
 		/*
 		 * when the old and new regions overlap clear from new_end.
 		 */
+		tlb_gather_mmu(&tlb, mm, new_end, old_end);
 		free_pgd_range(&tlb, new_end, old_end, new_end,
 			vma->vm_next ? vma->vm_next->vm_start : USER_PGTABLES_CEILING);
 	} else {
@@ -719,6 +719,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
 		 * have constraints on va-space that make this illegal (IA64) -
 		 * for the others its just a little faster.
 		 */
+		tlb_gather_mmu(&tlb, mm, old_start, old_end);
 		free_pgd_range(&tlb, old_start, old_end, new_end,
 			vma->vm_next ? vma->vm_next->vm_start : USER_PGTABLES_CEILING);
 	}
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 2c68a545ffa7..857fd83af695 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -256,6 +256,15 @@ struct mmu_gather {
 	struct mmu_table_batch	*batch;
 #endif
=20
+	/*
+	 * This is the range of the "entire" logical flush
+	 * operation being performed. It does not relate to
+	 * the current batch to flush, but it can inform
+	 * heuristics that choose the best flushing strategy.
+	 */
+	unsigned long		entire_start;
+	unsigned long		entire_end;
+
 	unsigned long		start;
 	unsigned long		end;
 	/*
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 52bbd2b7cb46..9d2ff06b574c 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -599,7 +599,8 @@ static inline cpumask_t *mm_cpumask(struct mm_struct *m=
m)
 }
=20
 struct mmu_gather;
-extern void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm);
+extern void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
+				unsigned long start, unsigned long end);
 extern void tlb_gather_mmu_fullmm(struct mmu_gather *tlb, struct mm_struct=
 *mm);
 extern void tlb_finish_mmu(struct mmu_gather *tlb);
=20
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index dfc940d5221d..e41106eb4df7 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4458,7 +4458,7 @@ void unmap_hugepage_range(struct vm_area_struct *vma,=
 unsigned long start,
 {
 	struct mmu_gather tlb;
=20
-	tlb_gather_mmu(&tlb, vma->vm_mm);
+	tlb_gather_mmu(&tlb, vma->vm_mm, start, end);
 	__unmap_hugepage_range(&tlb, vma, start, end, ref_page);
 	tlb_finish_mmu(&tlb);
 }
diff --git a/mm/madvise.c b/mm/madvise.c
index 6d3d348b17f4..b3634672aeb9 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -508,7 +508,7 @@ static long madvise_cold(struct vm_area_struct *vma,
 		return -EINVAL;
=20
 	lru_add_drain();
-	tlb_gather_mmu(&tlb, mm);
+	tlb_gather_mmu(&tlb, mm, start_addr, end_addr);
 	madvise_cold_page_range(&tlb, vma, start_addr, end_addr);
 	tlb_finish_mmu(&tlb);
=20
@@ -561,7 +561,7 @@ static long madvise_pageout(struct vm_area_struct *vma,
 		return 0;
=20
 	lru_add_drain();
-	tlb_gather_mmu(&tlb, mm);
+	tlb_gather_mmu(&tlb, mm, start_addr, end_addr);
 	madvise_pageout_page_range(&tlb, vma, start_addr, end_addr);
 	tlb_finish_mmu(&tlb);
=20
@@ -726,7 +726,7 @@ static int madvise_free_single_vma(struct vm_area_struc=
t *vma,
 				range.start, range.end);
=20
 	lru_add_drain();
-	tlb_gather_mmu(&tlb, mm);
+	tlb_gather_mmu(&tlb, mm, range.start, range.end);
 	update_hiwater_rss(mm);
=20
 	mmu_notifier_invalidate_range_start(&range);
diff --git a/mm/memory.c b/mm/memory.c
index 25fc46e87214..61c303e84baf 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1647,7 +1647,7 @@ void zap_page_range(struct vm_area_struct *vma, unsig=
ned long start,
 	lru_add_drain();
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
 				start, start + size);
-	tlb_gather_mmu(&tlb, vma->vm_mm);
+	tlb_gather_mmu(&tlb, vma->vm_mm, range.start, range.end);
 	update_hiwater_rss(vma->vm_mm);
 	mmu_notifier_invalidate_range_start(&range);
 	for ( ; vma && vma->vm_start < range.end; vma =3D vma->vm_next)
@@ -1674,7 +1674,7 @@ static void zap_page_range_single(struct vm_area_stru=
ct *vma, unsigned long addr
 	lru_add_drain();
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
 				address, address + size);
-	tlb_gather_mmu(&tlb, vma->vm_mm);
+	tlb_gather_mmu(&tlb, vma->vm_mm, address, range.end);
 	update_hiwater_rss(vma->vm_mm);
 	mmu_notifier_invalidate_range_start(&range);
 	unmap_single_vma(&tlb, vma, address, range.end, details);
diff --git a/mm/mmap.c b/mm/mmap.c
index ca54d36d203a..f2808febde40 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2672,7 +2672,7 @@ static void unmap_region(struct mm_struct *mm,
 	struct mmu_gather tlb;
=20
 	lru_add_drain();
-	tlb_gather_mmu(&tlb, mm);
+	tlb_gather_mmu(&tlb, mm, start, end);
 	update_hiwater_rss(mm);
 	unmap_vmas(&tlb, vma, start, end);
 	free_pgtables(&tlb, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 1b9837419bf9..863a5bd7e650 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -250,9 +250,12 @@ void tlb_flush_mmu(struct mmu_gather *tlb)
 }
=20
 static void __tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
+			     unsigned long start, unsigned long end,
 			     bool fullmm)
 {
 	tlb->mm =3D mm;
+	tlb->entire_start =3D start;
+	tlb->entire_end =3D end;
 	tlb->fullmm =3D fullmm;
=20
 #ifndef CONFIG_MMU_GATHER_NO_GATHER
@@ -281,9 +284,10 @@ static void __tlb_gather_mmu(struct mmu_gather *tlb, s=
truct mm_struct *mm,
  * Called to initialize an (on-stack) mmu_gather structure for page-table
  * tear-down from @mm.
  */
-void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm)
+void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
+		    unsigned long start, unsigned long end)
 {
-	__tlb_gather_mmu(tlb, mm, false);
+	__tlb_gather_mmu(tlb, mm, start, end, false);
 }
=20
 /**
@@ -299,7 +303,7 @@ void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_s=
truct *mm)
  */
 void tlb_gather_mmu_fullmm(struct mmu_gather *tlb, struct mm_struct *mm)
 {
-	__tlb_gather_mmu(tlb, mm, true);
+	__tlb_gather_mmu(tlb, mm, 0, ~0UL, true);
 }
=20
 /**
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index c729a4c4a1ac..bfcc9cbdfb20 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -545,7 +545,7 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
 			mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0,
 						vma, mm, vma->vm_start,
 						vma->vm_end);
-			tlb_gather_mmu(&tlb, mm);
+			tlb_gather_mmu(&tlb, mm, vma->vm_start, vma->vm_end);
 			if (mmu_notifier_invalidate_range_start_nonblock(&range)) {
 				tlb_finish_mmu(&tlb);
 				ret =3D false;
--=20
2.23.0

