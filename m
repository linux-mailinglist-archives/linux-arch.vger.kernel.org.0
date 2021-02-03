Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD47730E661
	for <lists+linux-arch@lfdr.de>; Wed,  3 Feb 2021 23:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbhBCW6H (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Feb 2021 17:58:07 -0500
Received: from mga06.intel.com ([134.134.136.31]:30210 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233231AbhBCW5v (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Feb 2021 17:57:51 -0500
IronPort-SDR: kxBvEZUcfjW5uCkp4v1Zvet28KfEbjqoy+biNtsBOuaIf1FHxfHe48NFqdkC1r+G9xVPt7QWNc
 uS8K7nnz6GOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="242642358"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="242642358"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 14:56:25 -0800
IronPort-SDR: VxMDgpo8ntl1NOx640K14CRRqjsfKgSI1oiQTtUvFoD6drw3sEFcgbTJmR1I6LERWTFeV2oOI+
 b6Z6Liu/264A==
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="507921105"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 14:56:25 -0800
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
Subject: [PATCH v19 10/25] x86/mm: Update pte_modify for _PAGE_COW
Date:   Wed,  3 Feb 2021 14:55:32 -0800
Message-Id: <20210203225547.32221-11-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210203225547.32221-1-yu-cheng.yu@intel.com>
References: <20210203225547.32221-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

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
---
 arch/x86/include/asm/pgtable.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 4b0ec61510dc..4a7fd3e5b7df 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -726,6 +726,21 @@ static inline pmd_t pmd_mkinvalid(pmd_t pmd)
 
 static inline u64 flip_protnone_guard(u64 oldval, u64 val, u64 mask);
 
+static inline pteval_t fixup_dirty_pte(pteval_t pteval)
+{
+	pte_t pte = __pte(pteval);
+
+	if (cpu_feature_enabled(X86_FEATURE_SHSTK) && pte_dirty(pte)) {
+		pte = pte_mkclean(pte);
+
+		if (pte_flags(pte) & _PAGE_RW)
+			pte = pte_set_flags(pte, _PAGE_DIRTY);
+		else
+			pte = pte_set_flags(pte, _PAGE_COW);
+	}
+	return pte_val(pte);
+}
+
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	pteval_t val = pte_val(pte), oldval = val;
@@ -736,16 +751,34 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
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
+	if (cpu_feature_enabled(X86_FEATURE_SHSTK) && pmd_dirty(pmd)) {
+		pmd = pmd_mkclean(pmd);
+
+		if (pmd_flags(pmd) & _PAGE_RW)
+			pmd = pmd_set_flags(pmd, _PAGE_DIRTY);
+		else
+			pmd = pmd_set_flags(pmd, _PAGE_COW);
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
2.21.0

