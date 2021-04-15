Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C323614FA
	for <lists+linux-arch@lfdr.de>; Fri, 16 Apr 2021 00:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237096AbhDOWSB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Apr 2021 18:18:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:22384 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235152AbhDOWRQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Apr 2021 18:17:16 -0400
IronPort-SDR: UlHYXNPTwePtTWvyOVAhERq8xAUNUHOis/P4V8u7ukTvBrjVotNar1igVeghwgcxXPXQeEwrIA
 M3tFzbZpbJ+w==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="194513375"
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="194513375"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 15:15:38 -0700
IronPort-SDR: vhn1Z324SBbr0lQ2D1W71SPNqDVsbykgutpkzrQbxq8+1kfgJIwf4rH1poI7LfaUjjrCQXERLk
 cNRlOzYa9Vdw==
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="451270926"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 15:15:38 -0700
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
Subject: [PATCH v25 20/30] mm/mprotect: Exclude shadow stack from preserve_write
Date:   Thu, 15 Apr 2021 15:14:09 -0700
Message-Id: <20210415221419.31835-21-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210415221419.31835-1-yu-cheng.yu@intel.com>
References: <20210415221419.31835-1-yu-cheng.yu@intel.com>
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
v25:
- Move is_shadow_stack_mapping() to a separate line.
v24:
- Change arch_shadow_stack_mapping() to is_shadow_stack_mapping().

 mm/huge_memory.c | 7 +++++++
 mm/mprotect.c    | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a0858eac0320..9e51cae35aad 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1824,6 +1824,13 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
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
index c1ce78d688b6..3b2f0d75519f 100644
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

