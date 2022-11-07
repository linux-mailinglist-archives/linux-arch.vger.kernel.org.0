Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559B561FF22
	for <lists+linux-arch@lfdr.de>; Mon,  7 Nov 2022 21:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbiKGUHR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Nov 2022 15:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbiKGUHN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Nov 2022 15:07:13 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F0327B24
        for <linux-arch@vger.kernel.org>; Mon,  7 Nov 2022 12:07:11 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id hh9so7517724qtb.13
        for <linux-arch@vger.kernel.org>; Mon, 07 Nov 2022 12:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QGhIjGOM7LH5cBL9V+b1Hgf76N1SYrX+psA/lfoLx1k=;
        b=3vfuIqEk6ZZfYKZPgvFEh0TKpQwxwbWGlf3w1SXLpmwnTr9Q3QohuCMGikajtiJRsV
         Rqn5E2cBxwp12teblefpCX8tVIBBriP1i5pj548hy0bbcCtAWud3iCkLJMp+CL32nLSP
         AdumUa0126gxmhGFrJmW3KCUkdjx9UZzo/AUj6gC1CnKdmGQygYG+C4c//sLR8maIdim
         eEtOr6Y+9gl33xQNw6tvOzO8ydyH05g5x3roYQPak14YOfFr0eRmErSsgFmvmCLwLztm
         8WLNcIi/fFoNpT8yk5XWu5RoIeIlnqTxpuIdwm5pv48JXX3xUpiwoOlh8opbI5GJe8Kd
         Mklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGhIjGOM7LH5cBL9V+b1Hgf76N1SYrX+psA/lfoLx1k=;
        b=PMPxaZjUeKqOCRJdQJEy1zX4+v2Irb3xuATGOVg4MbB9Wi/S1kE0g3XeYRWAbUvD2O
         R63m1a5LZo5ZrhEaPec2o/2TDtVosLwrYErZLrWe4A876pYov6IzX7LzK4AtKVcpeN9m
         8HXRoZtbxaQo1E09u/ZG5heBXX860X7yuCVAzWRH/2hS8CX3sx6kOHsiSVhJKetftW8j
         sN1GmGh2iOWRQ4/jhDrZX44gyLFE0Rx42NYeVlL4WxsFuJRdteM3bXYamTTqOKLftx0X
         lNvA0NiECfNsCFNXaSHokAbMRjby2trwRUdBB38QkQgf6/U9jnI6bW2cGA63CnbG8Bm4
         /Hvg==
X-Gm-Message-State: ACrzQf0y33S69KKS0ImCeYRajDD4P03BKA2NkvLYpGzhGh4B2R3miT7t
        v7ffSZJ9GMjIXEA1WCh+l5WChw==
X-Google-Smtp-Source: AMsMyM44eIMhZRpBYWP10QIsv5DCqWT2z0tjrH+JdllBvBGdHc89NcdEhaQwU7qM53N0sj/fKX4BQw==
X-Received: by 2002:a05:622a:1ba5:b0:3a4:ffd9:22d8 with SMTP id bp37-20020a05622a1ba500b003a4ffd922d8mr40753206qtb.356.1667851630723;
        Mon, 07 Nov 2022 12:07:10 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::25f1])
        by smtp.gmail.com with ESMTPSA id u12-20020a05620a454c00b006e16dcf99c8sm7656628qkp.71.2022.11.07.12.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 12:07:09 -0800 (PST)
Date:   Mon, 7 Nov 2022 15:07:13 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>, X86 ML <x86@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Uros Bizjak <ubizjak@gmail.com>,
        Alistair Popple <apopple@nvidia.com>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: mm: delay rmap removal until after TLB flush
Message-ID: <Y2llcRiDLHc2kg/N@cmpxchg.org>
References: <CAHk-=wjX_P78xoNcGDTjhkgffs-Bhzcwp-mdsE1maeF57Sh0MA@mail.gmail.com>
 <CAHk-=wio=UKK9fX4z+0CnyuZG7L+U9OB7t7Dcrg4FuFHpdSsfw@mail.gmail.com>
 <CAHk-=wgz0QQd6KaRYQ8viwkZBt4xDGuZTFiTB8ifg7E3F2FxHg@mail.gmail.com>
 <CAHk-=wiwt4LC-VmqvYrphraF0=yQV=CQimDCb0XhtXwk8oKCCA@mail.gmail.com>
 <Y1+XCALog8bW7Hgl@hirez.programming.kicks-ass.net>
 <CAHk-=wjnvPA7mi-E3jVEfCWXCNJNZEUjm6XODbbzGOh9c8mhgw@mail.gmail.com>
 <CAHk-=wjjXQP7PTEXO4R76WPy1zfQad_DLKw1GKU_4yWW1N4n7w@mail.gmail.com>
 <Y2SyJuohLFLqIhlZ@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <CAHk-=wjzp65=-QE1dg8KfqG-tVHiT+yAfHXGx9sro=8yOceELg@mail.gmail.com>
 <8a1e97c9-bd5-7473-6da8-2aa75198fbe8@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a1e97c9-bd5-7473-6da8-2aa75198fbe8@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello,

On Sun, Nov 06, 2022 at 01:06:19PM -0800, Hugh Dickins wrote:
> lock_page_memcg (uncertain)
> ---------------------------
> Johannes, please help! Linus has got quite upset by lock_page_memcg(),
> its calls from mm/rmap.c anyway, and most particularly by the way
> in which it is called at the start of page_remove_rmap(), before
> anyone's critical atomic_add_negative(), yet its use is to guarantee
> the stability of page memcg while doing the stats updates, done only
> when atomic_add_negative() says so.

As you mentioned, the pte lock historically wasn't always taken on the
move side. And so the reason lock_page_memcg() covers the mapcount
update is that move_account() needs to atomically see either a) the
page is mapped and counted, or b) unmapped and uncounted. If we lock
after mapcountdec, move_account() could miss pending updates that need
transferred, and it would break the scheme breaks thusly:

memcg1->nr_mapped = 1
memcg2->nr_mapped = 0

page_remove_rmap:                              mem_cgroup_move_account():
  if atomic_add_negative(page->mapcount):
                                                 lock_page_memcg()
                                                 if page->mapcount: // NOT TAKEN
                                                   memcg1->nr_mapped--
                                                   memcg2->nr_mapped++
                                                 page->memcg = memcg2
                                                 unlock_page_memcg()
    lock_page_memcg()
    page->memcg->nr_mapped-- // UNDERFLOW memcg2->nr_mapped
    unlock_page_memcg()

> I do have one relevant insight on this.  It (or its antecedents under
> other names) date from the days when we did "reparenting" of memcg
> charges from an LRU: and in those days the lock_page_memcg() before
> mapcount adjustment was vital, to pair with the uses of folio_mapped()
> or page_mapped() in mem_cgroup_move_account() - those "mapped" checks
> are precisely around the stats which the rmap functions affect.
> 
> But nowadays mem_cgroup_move_account() is only called, with page table
> lock held, on matching pages found in a task's page table: so its
> "mapped" checks are redundant - I've sometimes thought in the past of
> removing them, but held back, because I always have the notion (not
> hope!) that "reparenting" may one day be brought back from the grave.
> I'm too out of touch with memcg to know where that notion stands today.
>
> I've gone through a multiverse of opinions on those lock_page_memcg()s
> in the last day: I currently believe that Linus is right, that the
> lock_page_memcg()s could and should be moved just before the stats
> updates.  But I am not 100% certain of that - is there still some
> reason why it's important that the page memcg at the instant of the
> critical mapcount transition be kept unchanged until the stats are
> updated?  I've tried running scenarios through my mind but given up.

Okay, I think there are two options.

- If we don't want to codify the pte lock requirement on the move
  side, then moving the lock_page_memcg() like that would break the
  locking scheme, as per above.

- If we DO want to codify the pte lock requirement, we should just
  remove the lock_page_memcg() altogether, as it's fully redundant.

I'm leaning toward the second option. If somebody brings back
reparenting they can bring the lock back along with it.

[ If it's even still necessary by then.

  It's conceivable reparenting is brought back only for cgroup2, where
  the race wouldn't matter because of the hierarchical stats. The
  reparenting side wouldn't have to move page state to the parent -
  it's already there. And whether rmap would see the dying child or
  the parent doesn't matter much either: the parent will see the
  update anyway, directly or recursively, and we likely don't care to
  balance the books on a dying cgroup.

  It's then just a matter of lifetime - which should be guaranteed
  also, as long as the pte lock prevents an RCU quiescent state. ]

So how about something like below?

UNTESTED, just for illustration. This is cgroup1 code, which I haven't
looked at too closely in a while. If you can't spot an immediate hole
in it, I'd go ahead and test it and send a proper patch.

---
From 88a32b1b5737630fb981114f6333d8fd057bd8e9 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Mon, 7 Nov 2022 12:05:09 -0500
Subject: [PATCH] mm: remove lock_page_memcg() from rmap

rmap changes (mapping and unmapping) of a page currently take
lock_page_memcg() to serialize 1) update of the mapcount and the
cgroup mapped counter with 2) cgroup moving the page and updating the
old cgroup and the new cgroup counters based on page_mapped().

Before b2052564e66d ("mm: memcontrol: continue cache reclaim from
offlined groups"), we used to reassign all pages that could be found
on a cgroup's LRU list on deletion - something that rmap didn't
naturally serialize against. Since that commit, however, the only
pages that get moved are those mapped into page tables of a task
that's being migrated. In that case, the pte lock is always held (and
we know the page is mapped), which keeps rmap changes at bay already.

The additional lock_page_memcg() by rmap is redundant. Remove it.

NOT-Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 27 ++++++++++++---------------
 mm/rmap.c       | 30 ++++++++++++------------------
 2 files changed, 24 insertions(+), 33 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2d8549ae1b30..f7716e9038e9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5666,7 +5666,10 @@ static struct page *mc_handle_file_pte(struct vm_area_struct *vma,
  * @from: mem_cgroup which the page is moved from.
  * @to:	mem_cgroup which the page is moved to. @from != @to.
  *
- * The caller must make sure the page is not on LRU (isolate_page() is useful.)
+ * This function acquires folio_lock() and folio_lock_memcg(). The
+ * caller must exclude all other possible ways of accessing
+ * page->memcg, such as LRU isolation (to lock out isolation) and
+ * having the page mapped and pte-locked (to lock out rmap).
  *
  * This function doesn't do "charge" to new cgroup and doesn't do "uncharge"
  * from old cgroup.
@@ -5685,6 +5688,7 @@ static int mem_cgroup_move_account(struct page *page,
 	VM_BUG_ON(from == to);
 	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
 	VM_BUG_ON(compound && !folio_test_large(folio));
+	VM_WARN_ON_ONCE(!folio_mapped(folio));
 
 	/*
 	 * Prevent mem_cgroup_migrate() from looking at
@@ -5705,30 +5709,23 @@ static int mem_cgroup_move_account(struct page *page,
 	folio_memcg_lock(folio);
 
 	if (folio_test_anon(folio)) {
-		if (folio_mapped(folio)) {
-			__mod_lruvec_state(from_vec, NR_ANON_MAPPED, -nr_pages);
-			__mod_lruvec_state(to_vec, NR_ANON_MAPPED, nr_pages);
-			if (folio_test_transhuge(folio)) {
-				__mod_lruvec_state(from_vec, NR_ANON_THPS,
-						   -nr_pages);
-				__mod_lruvec_state(to_vec, NR_ANON_THPS,
-						   nr_pages);
-			}
+		__mod_lruvec_state(from_vec, NR_ANON_MAPPED, -nr_pages);
+		__mod_lruvec_state(to_vec, NR_ANON_MAPPED, nr_pages);
+		if (folio_test_transhuge(folio)) {
+			__mod_lruvec_state(from_vec, NR_ANON_THPS, -nr_pages);
+			__mod_lruvec_state(to_vec, NR_ANON_THPS, nr_pages);
 		}
 	} else {
 		__mod_lruvec_state(from_vec, NR_FILE_PAGES, -nr_pages);
 		__mod_lruvec_state(to_vec, NR_FILE_PAGES, nr_pages);
+		__mod_lruvec_state(from_vec, NR_FILE_MAPPED, -nr_pages);
+		__mod_lruvec_state(to_vec, NR_FILE_MAPPED, nr_pages);
 
 		if (folio_test_swapbacked(folio)) {
 			__mod_lruvec_state(from_vec, NR_SHMEM, -nr_pages);
 			__mod_lruvec_state(to_vec, NR_SHMEM, nr_pages);
 		}
 
-		if (folio_mapped(folio)) {
-			__mod_lruvec_state(from_vec, NR_FILE_MAPPED, -nr_pages);
-			__mod_lruvec_state(to_vec, NR_FILE_MAPPED, nr_pages);
-		}
-
 		if (folio_test_dirty(folio)) {
 			struct address_space *mapping = folio_mapping(folio);
 
diff --git a/mm/rmap.c b/mm/rmap.c
index 2ec925e5fa6a..60c31375f274 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1197,11 +1197,6 @@ void page_add_anon_rmap(struct page *page,
 	bool compound = flags & RMAP_COMPOUND;
 	bool first;
 
-	if (unlikely(PageKsm(page)))
-		lock_page_memcg(page);
-	else
-		VM_BUG_ON_PAGE(!PageLocked(page), page);
-
 	if (compound) {
 		atomic_t *mapcount;
 		VM_BUG_ON_PAGE(!PageLocked(page), page);
@@ -1217,19 +1212,19 @@ void page_add_anon_rmap(struct page *page,
 	if (first) {
 		int nr = compound ? thp_nr_pages(page) : 1;
 		/*
-		 * We use the irq-unsafe __{inc|mod}_zone_page_stat because
-		 * these counters are not modified in interrupt context, and
-		 * pte lock(a spinlock) is held, which implies preemption
-		 * disabled.
+		 * We use the irq-unsafe __{inc|mod}_zone_page_stat
+		 * because these counters are not modified in
+		 * interrupt context, and pte lock(a spinlock) is
+		 * held, which implies preemption disabled.
+		 *
+		 * The pte lock also stabilizes page->memcg wrt
+		 * mem_cgroup_move_account().
 		 */
 		if (compound)
 			__mod_lruvec_page_state(page, NR_ANON_THPS, nr);
 		__mod_lruvec_page_state(page, NR_ANON_MAPPED, nr);
 	}
 
-	if (unlikely(PageKsm(page)))
-		unlock_page_memcg(page);
-
 	/* address might be in next vma when migration races vma_adjust */
 	else if (first)
 		__page_set_anon_rmap(page, vma, address,
@@ -1290,7 +1285,6 @@ void page_add_file_rmap(struct page *page,
 	int i, nr = 0;
 
 	VM_BUG_ON_PAGE(compound && !PageTransHuge(page), page);
-	lock_page_memcg(page);
 	if (compound && PageTransHuge(page)) {
 		int nr_pages = thp_nr_pages(page);
 
@@ -1311,6 +1305,7 @@ void page_add_file_rmap(struct page *page,
 		if (nr == nr_pages && PageDoubleMap(page))
 			ClearPageDoubleMap(page);
 
+		/* The pte lock stabilizes page->memcg */
 		if (PageSwapBacked(page))
 			__mod_lruvec_page_state(page, NR_SHMEM_PMDMAPPED,
 						nr_pages);
@@ -1328,7 +1323,6 @@ void page_add_file_rmap(struct page *page,
 out:
 	if (nr)
 		__mod_lruvec_page_state(page, NR_FILE_MAPPED, nr);
-	unlock_page_memcg(page);
 
 	mlock_vma_page(page, vma, compound);
 }
@@ -1356,6 +1350,7 @@ static void page_remove_file_rmap(struct page *page, bool compound)
 		}
 		if (!atomic_add_negative(-1, compound_mapcount_ptr(page)))
 			goto out;
+		/* The pte lock stabilizes page->memcg */
 		if (PageSwapBacked(page))
 			__mod_lruvec_page_state(page, NR_SHMEM_PMDMAPPED,
 						-nr_pages);
@@ -1423,8 +1418,6 @@ static void page_remove_anon_compound_rmap(struct page *page)
 void page_remove_rmap(struct page *page,
 	struct vm_area_struct *vma, bool compound)
 {
-	lock_page_memcg(page);
-
 	if (!PageAnon(page)) {
 		page_remove_file_rmap(page, compound);
 		goto out;
@@ -1443,6 +1436,9 @@ void page_remove_rmap(struct page *page,
 	 * We use the irq-unsafe __{inc|mod}_zone_page_stat because
 	 * these counters are not modified in interrupt context, and
 	 * pte lock(a spinlock) is held, which implies preemption disabled.
+	 *
+	 * The pte lock also stabilizes page->memcg wrt
+	 * mem_cgroup_move_account().
 	 */
 	__dec_lruvec_page_state(page, NR_ANON_MAPPED);
 
@@ -1459,8 +1455,6 @@ void page_remove_rmap(struct page *page,
 	 * faster for those pages still in swapcache.
 	 */
 out:
-	unlock_page_memcg(page);
-
 	munlock_vma_page(page, vma, compound);
 }
 
-- 
2.38.1
