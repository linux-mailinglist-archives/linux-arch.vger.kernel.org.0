Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9682B334A8A
	for <lists+linux-arch@lfdr.de>; Wed, 10 Mar 2021 23:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbhCJWBo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Mar 2021 17:01:44 -0500
Received: from mga04.intel.com ([192.55.52.120]:4738 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233699AbhCJWBQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Mar 2021 17:01:16 -0500
IronPort-SDR: KF9kYG7yGED1nXyr1DHrzo47EZhFMhLd6eR7TwhBAnpxIVWGgkZbtsxNhJ14i+Ku/Swzv49A6B
 DNLaJf+3Ij3A==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="186193134"
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="186193134"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 14:01:15 -0800
IronPort-SDR: dzLhrxnnWCqFrtgCha4JCLnZfeyW1tMK5mj66/v7y7b0whNH0MTj373NFq4dndfiw1NaFyzT8U
 6lH6bBIs13Eg==
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="403847612"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 14:01:15 -0800
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
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v22 11/28] x86/mm: Update pte_modify for _PAGE_COW
Date:   Wed, 10 Mar 2021 14:00:29 -0800
Message-Id: <20210310220046.15866-12-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210310220046.15866-1-yu-cheng.yu@intel.com>
References: <20210310220046.15866-1-yu-cheng.yu@intel.com>
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
 arch/x86/include/asm/pgtable.h | 37 ++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 9c056d5815de..e1739f590ca6 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -799,6 +799,23 @@ static inline pmd_t pmd_mkinvalid(pmd_t pmd)
 
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
@@ -809,16 +826,36 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
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
2.21.0

