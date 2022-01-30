Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39CF4A39E3
	for <lists+linux-arch@lfdr.de>; Sun, 30 Jan 2022 22:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356527AbiA3VWA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 30 Jan 2022 16:22:00 -0500
Received: from mga06.intel.com ([134.134.136.31]:52029 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356487AbiA3VV5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 30 Jan 2022 16:21:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643577717; x=1675113717;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=HHh4lkLfyu0d0fqFw9G2b577iSJVRa+u0pjug6+8QXs=;
  b=amZqJmuLHKZtS2FgwRnWB0MfOwEq1+9sd3lO13l9Cbt6syHJjKjCftZA
   oREnnzqWUMipU0FI+QUrv7nAWnFSWxA25qzi5LHsKOWpK0pZcYwBOWOLA
   oI6WORC8v35qhSqXqVs+pzdGOE7Ai59tLd+YCPCMWpUdLAwlrrqjnyyZC
   EFxAHRU/cQUpSS/cEbE8qnDS+CJ2h/IxXmhXJxA7xVxVJAhKbUdcRmrk/
   nRQAWC3+Xr7SqwkdgKYTtcBZMcv5RGzeCPE5EpY6VnVVG+CZhdPSSOPKL
   7hS5lOGj9VL/nFwSIXuwZ01iYAxh8qc25tplYgttCKMt0XzFSx0VLmd9Q
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="308104918"
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="308104918"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:21:55 -0800
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="536856751"
Received: from avmallar-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.123.171])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:21:54 -0800
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
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH 11/35] x86/mm: Update pte_modify for _PAGE_COW
Date:   Sun, 30 Jan 2022 13:18:14 -0800
Message-Id: <20220130211838.8382-12-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Yu-cheng Yu <yu-cheng.yu@intel.com>

The read-only and Dirty PTE has been used to indicate copy-on-write pages.
However, newer x86 processors also regard a read-only and Dirty PTE as a
shadow stack page.  In order to separate the two, the software-defined
_PAGE_COW is created to replace _PAGE_DIRTY for the copy-on-write case, and
pte_*() are updated.

Pte_modify() changes a PTE to 'newprot', but it doesn't use the pte_*().
Introduce fixup_dirty_pte(), which sets a dirty PTE, based on _PAGE_RW,
to either _PAGE_DIRTY or _PAGE_COW.

Apply the same changes to pmd_modify().

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/include/asm/pgtable.h | 37 ++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index a4a75e78a934..5c3886f6ccda 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -773,6 +773,23 @@ static inline pmd_t pmd_mkinvalid(pmd_t pmd)
 
 static inline u64 flip_protnone_guard(u64 oldval, u64 val, u64 mask);
 
+static inline pteval_t fixup_dirty_pte(pteval_t pteval)
+{
+	pte_t pte = __pte(pteval);
+
+	/*
+	 * Fix up potential shadow stack page flags because the RO, Dirty
+	 * PTE is special.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
+		if (pte_dirty(pte)) {
+			pte = pte_mkclean(pte);
+			pte = pte_mkdirty(pte);
+		}
+	}
+	return pte_val(pte);
+}
+
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	pteval_t val = pte_val(pte), oldval = val;
@@ -783,16 +800,36 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 	 */
 	val &= _PAGE_CHG_MASK;
 	val |= check_pgprot(newprot) & ~_PAGE_CHG_MASK;
+	val = fixup_dirty_pte(val);
 	val = flip_protnone_guard(oldval, val, PTE_PFN_MASK);
 	return __pte(val);
 }
 
+static inline int pmd_write(pmd_t pmd);
+static inline pmdval_t fixup_dirty_pmd(pmdval_t pmdval)
+{
+	pmd_t pmd = __pmd(pmdval);
+
+	/*
+	 * Fix up potential shadow stack page flags because the RO, Dirty
+	 * PMD is special.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
+		if (pmd_dirty(pmd)) {
+			pmd = pmd_mkclean(pmd);
+			pmd = pmd_mkdirty(pmd);
+		}
+	}
+	return pmd_val(pmd);
+}
+
 static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 {
 	pmdval_t val = pmd_val(pmd), oldval = val;
 
 	val &= _HPAGE_CHG_MASK;
 	val |= check_pgprot(newprot) & ~_HPAGE_CHG_MASK;
+	val = fixup_dirty_pmd(val);
 	val = flip_protnone_guard(oldval, val, PHYSICAL_PMD_PAGE_MASK);
 	return __pmd(val);
 }
-- 
2.17.1

