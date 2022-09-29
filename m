Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181F35F004C
	for <lists+linux-arch@lfdr.de>; Fri, 30 Sep 2022 00:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiI2Wch (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Sep 2022 18:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiI2WcR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Sep 2022 18:32:17 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDF96715B;
        Thu, 29 Sep 2022 15:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664490634; x=1696026634;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=kQODslNH1nloZ+Qn0eQNHtmSgsYUq5sI4TpgOnIwj+g=;
  b=VFA3sPNw8F0kGIbOV58jE1oeBRmobHUOtLDI7mt+iDHpb1QqaaxRQ276
   6LzGaO7UrxINzJuriymqEJ8Oo9K2XGf7Yh/7oGzHvkC6KFThFUgEVrkde
   /bSGWcXYSOH4wK0E6300WmsCsFEkjO+prw2WksHM/nC8rDkzg2PQi3kYN
   He+pNxF6Fm4Pp26KOBVGRneejLMhV4mXdg+Uay1QMo/WJT7D9qzCVjtj8
   PYKe2lnTVby2lx3a731hj2X/SogeAnNfgrxbRvtJsHMbMiByepYX/vfGX
   0NlcGZMZbfRwLVtyRBTRoaM/RacAf0KRK/7bwtu6YHgvMuV4tcmIILwWX
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="285181967"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="285181967"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:30:24 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="691016227"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="691016227"
Received: from sergungo-mobl.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.251.25.88])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:30:18 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
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
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v2 17/39] mm: Fixup places that call pte_mkwrite() directly
Date:   Thu, 29 Sep 2022 15:29:14 -0700
Message-Id: <20220929222936.14584-18-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Yu-cheng Yu <yu-cheng.yu@intel.com>

With the introduction of shadow stack memory there are two ways a pte can
be writable: regular writable memory and shadow stack memory.

In past patches, maybe_mkwrite() has been updated to apply pte_mkwrite()
or pte_mkwrite_shstk() depending on the VMA flag. This covers most cases
where a PTE is made writable. However, there are places where pte_mkwrite()
is called directly and the logic should now also create a shadow stack PTE
in the case of a shadow stack VMA.

 - do_anonymous_page() and migrate_vma_insert_page() check VM_WRITE
   directly and call pte_mkwrite(), which is the same as maybe_mkwrite()
   in logic and intention. Just change them to maybe_mkwrite().

 - When userfaultfd is creating a PTE after userspace handles the fault
   it calls pte_mkwrite() directly. Teach it about pte_mkwrite_shstk()

In other cases where pte_mkwrite() is called directly, the VMA will not
be VM_SHADOW_STACK, and so shadow stack memory should not be created.
 - In the case of pte_savedwrite(), shadow stack VMA's are excluded.
 - In the case of the "dirty_accountable" optimization in mprotect(),
   shadow stack VMA's won't be VM_SHARED, so it is not nessary.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Kees Cook <keescook@chromium.org>

---

v2:
 - Updated commit log with comment's from Dave Hansen
 - Dave also suggested (I understood) to maybe tweak vm_get_page_prot()
   to avoid having to call maybe_mkwrite(). After playing around with
   this I opted to *not* do this. Shadow stack memory memory is
   effectively writable, so having the default permissions be writable
   ended up mapping the zero page as writable and other surprises. So
   creating shadow stack memory needs to be done with manual logic
   like pte_mkwrite().
 - Drop change in change_pte_range() because it couldn't actually trigger
   for shadow stack VMAs.
 - Clarify reasoning for skipped cases of pte_mkwrite().

Yu-cheng v25:
 - Apply same changes to do_huge_pmd_numa_page() as to do_numa_page().

 mm/migrate_device.c |  3 +--
 mm/userfaultfd.c    | 10 +++++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 27fb37d65476..eba3164736b3 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -606,8 +606,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 			goto abort;
 		}
 		entry = mk_pte(page, vma->vm_page_prot);
-		if (vma->vm_flags & VM_WRITE)
-			entry = pte_mkwrite(pte_mkdirty(entry));
+		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 	}
 
 	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 7327b2573f7c..b49372c7de41 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -63,6 +63,7 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 	int ret;
 	pte_t _dst_pte, *dst_pte;
 	bool writable = dst_vma->vm_flags & VM_WRITE;
+	bool shstk = dst_vma->vm_flags & VM_SHADOW_STACK;
 	bool vm_shared = dst_vma->vm_flags & VM_SHARED;
 	bool page_in_cache = page->mapping;
 	spinlock_t *ptl;
@@ -83,9 +84,12 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 		writable = false;
 	}
 
-	if (writable)
-		_dst_pte = pte_mkwrite(_dst_pte);
-	else
+	if (writable) {
+		if (shstk)
+			_dst_pte = pte_mkwrite_shstk(_dst_pte);
+		else
+			_dst_pte = pte_mkwrite(_dst_pte);
+	} else
 		/*
 		 * We need this to make sure write bit removed; as mk_pte()
 		 * could return a pte with write bit set.
-- 
2.17.1

