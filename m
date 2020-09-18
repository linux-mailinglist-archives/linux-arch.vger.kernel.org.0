Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27858270536
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 21:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgIRTXb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 15:23:31 -0400
Received: from mga18.intel.com ([134.134.136.126]:41776 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgIRTWr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 Sep 2020 15:22:47 -0400
IronPort-SDR: BerIo87wLnh0kJ2339l1b+IEC3oqZCdQMTmkwupTeuF8Tk6NleVxaPp92CHhwuhg24jE/EWAml
 I6KV4i6H7ZRg==
X-IronPort-AV: E=McAfee;i="6000,8403,9748"; a="147766246"
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="147766246"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 12:22:20 -0700
IronPort-SDR: Q8RkjPj1oFBO89KpfbrQ5fhVg8Cs5Ep2QmTuOXoD9vIypHa13K847KKq0fzk/w0c0uSxAqivB9
 rrcwHHYGvvOA==
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="484331870"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 12:22:20 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v12 15/26] mm: Fixup places that call pte_mkwrite() directly
Date:   Fri, 18 Sep 2020 12:21:13 -0700
Message-Id: <20200918192125.25473-16-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200918192125.25473-1-yu-cheng.yu@intel.com>
References: <20200918192125.25473-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

A shadow stack page is made writable by pte_mkwrite_shstk(), which sets
_PAGE_DIRTY_HW.  There are a few places that call pte_mkwrite() directly
and miss the maybe_mkwrite() fixup in the previous patch.  Fix them with
maybe_mkwrite():

- do_anonymous_page() and migrate_vma_insert_page() check VM_WRITE directly
  and call pte_mkwrite(), which is the same as maybe_mkwrite().  Change
  them to maybe_mkwrite().

- In do_numa_page(), if the numa entry 'was-writable', then pte_mkwrite()
  is called directly.  Fix it by doing maybe_mkwrite().

- In change_pte_range(), pte_mkwrite() is called directly.  Replace it with
  maybe_mkwrite().

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 mm/memory.c   | 5 ++---
 mm/migrate.c  | 3 +--
 mm/mprotect.c | 2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 469af373ae76..c7c9d2d1118a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3374,8 +3374,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 
 	entry = mk_pte(page, vma->vm_page_prot);
 	entry = pte_sw_mkyoung(entry);
-	if (vma->vm_flags & VM_WRITE)
-		entry = pte_mkwrite(pte_mkdirty(entry));
+	entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
 			&vmf->ptl);
@@ -4029,7 +4028,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	pte = pte_modify(old_pte, vma->vm_page_prot);
 	pte = pte_mkyoung(pte);
 	if (was_writable)
-		pte = pte_mkwrite(pte);
+		pte = maybe_mkwrite(pte, vma);
 	ptep_modify_prot_commit(vma, vmf->address, vmf->pte, old_pte, pte);
 	update_mmu_cache(vma, vmf->address, vmf->pte);
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 941b89383cf3..dd55d8669de5 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2904,8 +2904,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 		}
 	} else {
 		entry = mk_pte(page, vma->vm_page_prot);
-		if (vma->vm_flags & VM_WRITE)
-			entry = pte_mkwrite(pte_mkdirty(entry));
+		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 	}
 
 	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index ce8b8a5eacbb..a8edbcb3af99 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -135,7 +135,7 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 			if (dirty_accountable && pte_dirty(ptent) &&
 					(pte_soft_dirty(ptent) ||
 					 !(vma->vm_flags & VM_SOFTDIRTY))) {
-				ptent = pte_mkwrite(ptent);
+				ptent = maybe_mkwrite(ptent, vma);
 			}
 			ptep_modify_prot_commit(vma, addr, pte, oldpte, ptent);
 			pages++;
-- 
2.21.0

