Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783762890F7
	for <lists+linux-arch@lfdr.de>; Fri,  9 Oct 2020 20:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390486AbgJISdd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Oct 2020 14:33:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:9542 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390466AbgJISdZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Oct 2020 14:33:25 -0400
IronPort-SDR: KRd8KUjemwLY+81hdU4Ox28LMIftE66bVxf6gOQnGc7tYDJ5wsmj65jSk2zhPi9og9Bzw6U+9F
 GUtYDOdcef9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9769"; a="164736628"
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="164736628"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 11:33:24 -0700
IronPort-SDR: ft9ey/X2dPezFXtXG1CROWRok1s/kjizjQejy/YOe0ly7RCr7xt+vdwUUXgYL2fn+v5HzxrbxZ
 y+A5wYR5JsWA==
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="529031190"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 11:33:22 -0700
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
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v14 18/26] mm: Update can_follow_write_pte() for shadow stack
Date:   Fri,  9 Oct 2020 11:32:22 -0700
Message-Id: <20201009183230.26717-19-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201009183230.26717-1-yu-cheng.yu@intel.com>
References: <20201009183230.26717-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Can_follow_write_pte() ensures a read-only page is COWed by checking the
FOLL_COW flag, and uses pte_dirty() to validate the flag is still valid.

Like a writable data page, a shadow stack page is writable, and becomes
read-only during copy-on-write, but it is always dirty.  Thus, in the
can_follow_write_pte() check, it belongs to the writable page case and
should be excluded from the read-only page pte_dirty() check.  Apply
the same changes to can_follow_write_pmd().

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

v10:
- Reverse name changes to can_follow_write_*().
---
 mm/gup.c         | 8 +++++---
 mm/huge_memory.c | 8 +++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index e869c634cc9a..10e32f574822 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -384,10 +384,12 @@ static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
  * FOLL_FORCE can write to even unwritable pte's, but only
  * after we've gone through a COW cycle and they are dirty.
  */
-static inline bool can_follow_write_pte(pte_t pte, unsigned int flags)
+static inline bool can_follow_write_pte(pte_t pte, unsigned int flags,
+					struct vm_area_struct *vma)
 {
 	return pte_write(pte) ||
-		((flags & FOLL_FORCE) && (flags & FOLL_COW) && pte_dirty(pte));
+		((flags & FOLL_FORCE) && (flags & FOLL_COW) && pte_dirty(pte) &&
+				  !arch_shadow_stack_mapping(vma->vm_flags));
 }
 
 static struct page *follow_page_pte(struct vm_area_struct *vma,
@@ -430,7 +432,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 	}
 	if ((flags & FOLL_NUMA) && pte_protnone(pte))
 		goto no_page;
-	if ((flags & FOLL_WRITE) && !can_follow_write_pte(pte, flags)) {
+	if ((flags & FOLL_WRITE) && !can_follow_write_pte(pte, flags, vma)) {
 		pte_unmap_unlock(ptep, ptl);
 		return NULL;
 	}
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 01252b00cd06..fd22ceaba945 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1324,10 +1324,12 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
  * FOLL_FORCE can write to even unwritable pmd's, but only
  * after we've gone through a COW cycle and they are dirty.
  */
-static inline bool can_follow_write_pmd(pmd_t pmd, unsigned int flags)
+static inline bool can_follow_write_pmd(pmd_t pmd, unsigned int flags,
+					struct vm_area_struct *vma)
 {
 	return pmd_write(pmd) ||
-	       ((flags & FOLL_FORCE) && (flags & FOLL_COW) && pmd_dirty(pmd));
+	       ((flags & FOLL_FORCE) && (flags & FOLL_COW) && pmd_dirty(pmd) &&
+				  !arch_shadow_stack_mapping(vma->vm_flags));
 }
 
 struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
@@ -1340,7 +1342,7 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 
 	assert_spin_locked(pmd_lockptr(mm, pmd));
 
-	if (flags & FOLL_WRITE && !can_follow_write_pmd(*pmd, flags))
+	if (flags & FOLL_WRITE && !can_follow_write_pmd(*pmd, flags, vma))
 		goto out;
 
 	/* Avoid dumping huge zero page */
-- 
2.21.0

