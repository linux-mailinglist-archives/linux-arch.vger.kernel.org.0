Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF06138D0D2
	for <lists+linux-arch@lfdr.de>; Sat, 22 May 2021 00:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhEUWPI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 May 2021 18:15:08 -0400
Received: from mga09.intel.com ([134.134.136.24]:55678 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229951AbhEUWOm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 May 2021 18:14:42 -0400
IronPort-SDR: Aa9TpWdcGaHhXNomFgxR4urSDFvHhO7bvmDhmVwUGXBGav408TyB5gvz+SjBhOp/WH9oFjSz1J
 VsitL3LHSrqg==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="201618773"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="201618773"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 15:13:18 -0700
IronPort-SDR: pFp866Wpq88ihiXAjvK+wcRVVm5I144OqqPhnh+aNGtNAFZ+A3opzOtPZD/vvzcpAbYGxaiaLf
 cvgGZYx8gULg==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="441116208"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 15:13:17 -0700
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
Subject: [PATCH v27 21/31] mm/mprotect: Exclude shadow stack from preserve_write
Date:   Fri, 21 May 2021 15:12:01 -0700
Message-Id: <20210521221211.29077-22-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210521221211.29077-1-yu-cheng.yu@intel.com>
References: <20210521221211.29077-1-yu-cheng.yu@intel.com>
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
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
v25:
- Move is_shadow_stack_mapping() to a separate line.

v24:
- Change arch_shadow_stack_mapping() to is_shadow_stack_mapping().

 mm/huge_memory.c | 7 +++++++
 mm/mprotect.c    | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 99352caf7188..1d414d94c69a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1822,6 +1822,13 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 		return 0;
 
 	preserve_write = prot_numa && pmd_write(*pmd);
+
+	/*
+	 * Preserve only normal writable huge PMD, but not shadow
+	 * stack (RW=0, Dirty=1).
+	 */
+	if (is_shadow_stack_mapping(vma->vm_flags))
+		preserve_write = false;
 	ret = 1;
 
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 819dd14c962a..40428e8536bb 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -77,6 +77,13 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 			pte_t ptent;
 			bool preserve_write = prot_numa && pte_write(oldpte);
 
+			/*
+			 * Preserve only normal writable PTE, but not shadow
+			 * stack (RW=0, Dirty=1).
+			 */
+			if (is_shadow_stack_mapping(vma->vm_flags))
+				preserve_write = false;
+
 			/*
 			 * Avoid trapping faults against the zero or KSM
 			 * pages. See similar comment in change_huge_pmd.
-- 
2.21.0

