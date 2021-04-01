Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5D535224B
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 00:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbhDAWMM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Apr 2021 18:12:12 -0400
Received: from mga11.intel.com ([192.55.52.93]:34674 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235702AbhDAWLu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 1 Apr 2021 18:11:50 -0400
IronPort-SDR: wdOY/stPVv3L58Wurk10jldMPS46mYOD0ArLoHual6dxA+uFuw0ORLAHuaKsTNsHiShTdrj59N
 cfxrko8XG+mw==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="189084602"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="189084602"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 15:11:25 -0700
IronPort-SDR: sTX5EcqB6UoM1GQbqIQAS2KqnI1IFu/iUCzmeuQS8gLIVyp0R8L/oDLZD3dX1q725MoNJpacjv
 0ebazLkWEmnw==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="517513929"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 15:11:25 -0700
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
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v24 20/30] mm/mprotect: Exclude shadow stack from preserve_write
Date:   Thu,  1 Apr 2021 15:10:54 -0700
Message-Id: <20210401221104.31584-21-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210401221104.31584-1-yu-cheng.yu@intel.com>
References: <20210401221104.31584-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In change_pte_range(), when a PTE is changed for prot_numa, _PAGE_RW is
preserved to avoid the additional write fault after the NUMA hinting fault.
However, pte_write() now includes both normal writable and shadow stack
(RW=0, Dirty=1) PTEs, but the latter does not have _PAGE_RW and has no need
to preserve it.

Exclude shadow stack from preserve_write test, and apply the same change to
change_huge_pmd().

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
v24:
- Change arch_shadow_stack_mapping() to is_shadow_stack_mapping().

 mm/huge_memory.c | 7 ++++++-
 mm/mprotect.c    | 9 ++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 65fc0aedd577..1d41138c4f74 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1812,12 +1812,17 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 	bool prot_numa = cp_flags & MM_CP_PROT_NUMA;
 	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
 	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
+	bool shstk = is_shadow_stack_mapping(vma->vm_flags);
 
 	ptl = __pmd_trans_huge_lock(pmd, vma);
 	if (!ptl)
 		return 0;
 
-	preserve_write = prot_numa && pmd_write(*pmd);
+	/*
+	 * Preserve only normal writable huge PMD, but not shadow
+	 * stack (RW=0, Dirty=1).
+	 */
+	preserve_write = prot_numa && pmd_write(*pmd) && !shstk;
 	ret = 1;
 
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
diff --git a/mm/mprotect.c b/mm/mprotect.c
index c1ce78d688b6..550448dc5ff1 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -75,7 +75,14 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		oldpte = *pte;
 		if (pte_present(oldpte)) {
 			pte_t ptent;
-			bool preserve_write = prot_numa && pte_write(oldpte);
+			bool shstk = is_shadow_stack_mapping(vma->vm_flags);
+			bool preserve_write;
+
+			/*
+			 * Preserve only normal writable PTE, but not shadow
+			 * stack (RW=0, Dirty=1).
+			 */
+			preserve_write = prot_numa && pte_write(oldpte) && !shstk;
 
 			/*
 			 * Avoid trapping faults against the zero or KSM
-- 
2.21.0

