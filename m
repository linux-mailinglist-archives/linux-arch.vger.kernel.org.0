Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EF864126B
	for <lists+linux-arch@lfdr.de>; Sat,  3 Dec 2022 01:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbiLCAkr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Dec 2022 19:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235092AbiLCAkN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2022 19:40:13 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA6A3D921;
        Fri,  2 Dec 2022 16:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670027879; x=1701563879;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Fk/Qne5mwiZTFgT2silFS8+68/JE0zNL0yZ7bHwxdtU=;
  b=ReqmpWP1KY58qsQ6NYgt+TzVK2SD/G95+GFzCdAfRgaoFmal9cCBzKDP
   D1gYn8dhT/YpWlQp6w6zaZcBcJILoLcLENeYm6pGCu0loZviXZaphMx3t
   kqytYxgQ01iZibaevSIbK4OeRhvbM1Q13pWZgRVaIwXu5kGEA6mqgVpp2
   YGZePMiRxda3N4yuBCnpWiFuqdWyw96aOdRFDHV7eDCpo3GBcuyxvWH/W
   i+E/rYjFKOfWaPpozvOz6wqSLLsEldBf42pzU/LKsdleMeNPQdjQuJDnD
   /AGTu5LgEnxBHAZlrXMWpdayAIkqDuNs8ZOPdQeaQqSLckD0Zbk7F7U1X
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="313711168"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="313711168"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:37:20 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="787479924"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="787479924"
Received: from bgordon1-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.211.211])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:37:18 -0800
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
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v4 21/39] mm/mprotect: Exclude shadow stack from preserve_write
Date:   Fri,  2 Dec 2022 16:35:48 -0800
Message-Id: <20221203003606.6838-22-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

v4:
 - Add "why" to comments in code (Peterz)

Yu-cheng v25:
 - Move is_shadow_stack_mapping() to a separate line.

Yu-cheng v24:
 - Change arch_shadow_stack_mapping() to is_shadow_stack_mapping().

 mm/huge_memory.c | 8 ++++++++
 mm/mprotect.c    | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 60451e588955..b6294c4ad471 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1803,6 +1803,14 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		return 0;
 
 	preserve_write = prot_numa && pmd_write(*pmd);
+
+	/*
+	 * Preserve only normal writable huge PMD, but not shadow
+	 * stack (RW=0, Dirty=1), so the restoring code doesn't
+	 * make the shadow stack memory conventionally writable.
+	 */
+	if (vma->vm_flags & VM_SHADOW_STACK)
+		preserve_write = false;
 	ret = 1;
 
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
diff --git a/mm/mprotect.c b/mm/mprotect.c
index de7351631e21..026347f1f1ee 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -115,6 +115,14 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
 			pte_t ptent;
 			bool preserve_write = prot_numa && pte_write(oldpte);
 
+			/*
+			 * Preserve only normal writable PTE, but not shadow
+			 * stack (RW=0, Dirty=1), so the restoring code doesn't
+			 * make the shadow stack memory conventionally writable.
+			 */
+			if (vma->vm_flags & VM_SHADOW_STACK)
+				preserve_write = false;
+
 			/*
 			 * Avoid trapping faults against the zero or KSM
 			 * pages. See similar comment in change_huge_pmd.
-- 
2.17.1

