Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A0E61A47F
	for <lists+linux-arch@lfdr.de>; Fri,  4 Nov 2022 23:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiKDWmi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Nov 2022 18:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiKDWlh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Nov 2022 18:41:37 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E6E4E43F;
        Fri,  4 Nov 2022 15:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667601582; x=1699137582;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=4aVCw5ODNp+SkJKgvPAW6TwS6KUC24UPNM4SuYiLUfg=;
  b=QOaLeC5hksoUbpgOqXEw0SygnmAo8GB4E2veLGgHokb83WqMo9qKmclN
   A5PkTqwoDrJ5DfvLC1pX3Gn5xaZe/IwPpSqXGrJbSYNHBVXD1v+bUcqOP
   Zib9IqyjDCv0z8EUx/Jj6muWAcQHcD7Tkwqq7vjJQTbmHt3CRI4vrABnY
   i9AU+UwabwTZk47lzfLJK7g7llXp2ZDr4RPf86aW6B1V2L/zILFlPHbMM
   VpiRpUzwVmBrcaGfqe3j0WoB1QC5mNbmCjrOPklGxP45H8FHajhL2ae19
   VBEzDXbOddrcXqSutRnoECIEEz2gWBm+BBaHOUfyeUYoxbPP0ishNiA9F
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="311840561"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="311840561"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:39:40 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="668514089"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="668514089"
Received: from adhjerms-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.227.68])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:39:39 -0700
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
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v3 20/37] mm/mprotect: Exclude shadow stack from preserve_write
Date:   Fri,  4 Nov 2022 15:35:47 -0700
Message-Id: <20221104223604.29615-21-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Yu-cheng Yu <yu-cheng.yu@intel.com>

The x86 Control-flow Enforcement Technology (CET) feature includes a new
type of memory called shadow stack. This shadow stack memory has some
unusual properties, which requires some core mm changes to function
properly.

In change_pte_range(), when a PTE is changed for prot_numa, _PAGE_RW is
preserved to avoid the additional write fault after the NUMA hinting fault.
However, pte_write() now includes both normal writable and shadow stack
(Write=0, Dirty=1) PTEs, but the latter does not have _PAGE_RW and has no
need to preserve it.

Exclude shadow stack from preserve_write test, and apply the same change to
change_huge_pmd().

Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

---

Yu-cheng v25:
 - Move is_shadow_stack_mapping() to a separate line.

Yu-cheng v24:
 - Change arch_shadow_stack_mapping() to is_shadow_stack_mapping().

 mm/huge_memory.c | 7 +++++++
 mm/mprotect.c    | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 73b9b78f8cf4..7643a4db1b50 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1803,6 +1803,13 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		return 0;
 
 	preserve_write = prot_numa && pmd_write(*pmd);
+
+	/*
+	 * Preserve only normal writable huge PMD, but not shadow
+	 * stack (RW=0, Dirty=1).
+	 */
+	if (vma->vm_flags & VM_SHADOW_STACK)
+		preserve_write = false;
 	ret = 1;
 
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 668bfaa6ed2a..ea82ce5f38fe 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -115,6 +115,13 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
 			pte_t ptent;
 			bool preserve_write = prot_numa && pte_write(oldpte);
 
+			/*
+			 * Preserve only normal writable PTE, but not shadow
+			 * stack (RW=0, Dirty=1).
+			 */
+			if (vma->vm_flags & VM_SHADOW_STACK)
+				preserve_write = false;
+
 			/*
 			 * Avoid trapping faults against the zero or KSM
 			 * pages. See similar comment in change_huge_pmd.
-- 
2.17.1

