Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F83674483
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jan 2023 22:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjASVco (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Jan 2023 16:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjASVb1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Jan 2023 16:31:27 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616ACA8393;
        Thu, 19 Jan 2023 13:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674163552; x=1705699552;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=0xRZR4lTYh6NOOM79Ggd51EdLXNXPAUjGASZ+kAeGKM=;
  b=duB0BEmlqw+ygPNkvMxSD1o+dnTZME0CnvbBTESXHyjxDrbbKpuGv4am
   lBKW4UPNwndUCTNGsrlGsEQNmKmAOwOJIWBP8RrPD+brqhcs1zc+tDurJ
   BuQkU67vPKPOeV1jIHSkWjJy+cLdLcEmc55g2vaVuk0hqnZpdxVwMAl6k
   3xMdThUepL4voIWiXJjeSOb/4v/hSnV3lmRuk53yS4i5kK+bCd9uMIJ3f
   gZofpixT+VuWu3ryIhCgEJ0lDk6lS+E5zT5XTqPNX7V73vP6t9ANk9Tp/
   Ctk17W3o+3KqGbzmxo0FF6aQS4NWDTbTCz8QoYIXSGz/chn+yoWYCfNLa
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="323119409"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="323119409"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 13:23:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="989139038"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="989139038"
Received: from hossain3-mobl.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.252.128.187])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 13:23:41 -0800
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
Subject: [PATCH v5 11/39] x86/mm: Update pte_modify for _PAGE_COW
Date:   Thu, 19 Jan 2023 13:22:49 -0800
Message-Id: <20230119212317.8324-12-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Yu-cheng Yu <yu-cheng.yu@intel.com>

The Write=0,Dirty=1 PTE has been used to indicate copy-on-write pages.
However, newer x86 processors also regard a Write=0,Dirty=1 PTE as a
shadow stack page. In order to separate the two, the software-defined
_PAGE_DIRTY is changed to _PAGE_COW for the copy-on-write case, and
pte_*() are updated to do this.

pte_modify() takes a "raw" pgprot_t which was not necessarily created
with any of the existing PTE bit helpers. That means that it can return a
pte_t with Write=0,Dirty=1, a shadow stack PTE, when it did not intend to
create one.

However pte_modify() changes a PTE to 'newprot', but it doesn't use the
pte_*(). Modify it to also move _PAGE_DIRTY to _PAGE_COW. Do this by
using the pte_mkdirty() helper. Since pte_mkdirty() also sets the soft
dirty bit, extract a helper that optionally doesn't set
_PAGE_SOFT_DIRTY. This helper will allow future logic for deciding when to
move _PAGE_DIRTY to _PAGE_COW can live in one place.

Apply the same changes to pmd_modify().

Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---

v5:
 - Fix pte_modify() again, to not lose _PAGE_DIRTY, but still not set
   _PAGE_SOFT_DIRTY as was fixed in v4.

v4:
 - Fix an issue in soft-dirty test, where pte_modify() would detect
   _PAGE_COW in pte_dirty() and set the soft dirty bit in pte_mkdirty().

v2:
 - Update commit log with text and suggestions from (Dave Hansen)
 - Drop fixup_dirty_pte() in favor of clearing the HW dirty bit along
   with the _PAGE_CHG_MASK masking, then calling pte_mkdirty() (Dave
   Hansen)

 arch/x86/include/asm/pgtable.h | 64 +++++++++++++++++++++++++++++-----
 1 file changed, 56 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 6d2f612c04b5..7942eff2af50 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -392,9 +392,19 @@ static inline pte_t pte_mkexec(pte_t pte)
 	return pte_clear_flags(pte, _PAGE_NX);
 }
 
+static inline pte_t __pte_mkdirty(pte_t pte, bool soft)
+{
+	pteval_t dirty = _PAGE_DIRTY;
+
+	if (soft)
+		dirty |= _PAGE_SOFT_DIRTY;
+
+	return pte_set_flags(pte, dirty);
+}
+
 static inline pte_t pte_mkdirty(pte_t pte)
 {
-	return pte_set_flags(pte, _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
+	return __pte_mkdirty(pte, true);
 }
 
 static inline pte_t pte_mkyoung(pte_t pte)
@@ -503,9 +513,19 @@ static inline pmd_t pmd_wrprotect(pmd_t pmd)
 	return pmd_clear_flags(pmd, _PAGE_RW);
 }
 
+static inline pmd_t __pmd_mkdirty(pmd_t pmd, bool soft)
+{
+	pmdval_t dirty = _PAGE_DIRTY;
+
+	if (soft)
+		dirty |= _PAGE_SOFT_DIRTY;
+
+	return pmd_set_flags(pmd, dirty);
+}
+
 static inline pmd_t pmd_mkdirty(pmd_t pmd)
 {
-	return pmd_set_flags(pmd, _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
+	return __pmd_mkdirty(pmd, true);
 }
 
 static inline pmd_t pmd_mkdevmap(pmd_t pmd)
@@ -715,26 +735,54 @@ static inline u64 flip_protnone_guard(u64 oldval, u64 val, u64 mask);
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
+	pteval_t _page_chg_mask_no_dirty = _PAGE_CHG_MASK & ~_PAGE_DIRTY;
 	pteval_t val = pte_val(pte), oldval = val;
+	pte_t pte_result;
 
 	/*
 	 * Chop off the NX bit (if present), and add the NX portion of
 	 * the newprot (if present):
 	 */
-	val &= _PAGE_CHG_MASK;
-	val |= check_pgprot(newprot) & ~_PAGE_CHG_MASK;
+	val &= _page_chg_mask_no_dirty;
+	val |= check_pgprot(newprot) & ~_page_chg_mask_no_dirty;
 	val = flip_protnone_guard(oldval, val, PTE_PFN_MASK);
-	return __pte(val);
+
+	pte_result = __pte(val);
+
+	/*
+	 * Dirty bit is not preserved above so it can be done
+	 * in a special way for the shadow stack case, where it
+	 * may need to set _PAGE_COW. __pte_mkdirty() will do this in
+	 * the case of shadow stack.
+	 */
+	if (pte_dirty(pte))
+		pte_result = __pte_mkdirty(pte_result, false);
+
+	return pte_result;
 }
 
 static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 {
+	pteval_t _hpage_chg_mask_no_dirty = _HPAGE_CHG_MASK & ~_PAGE_DIRTY;
 	pmdval_t val = pmd_val(pmd), oldval = val;
+	pmd_t pmd_result;
 
-	val &= _HPAGE_CHG_MASK;
-	val |= check_pgprot(newprot) & ~_HPAGE_CHG_MASK;
+	val &= _hpage_chg_mask_no_dirty;
+	val |= check_pgprot(newprot) & ~_hpage_chg_mask_no_dirty;
 	val = flip_protnone_guard(oldval, val, PHYSICAL_PMD_PAGE_MASK);
-	return __pmd(val);
+
+	pmd_result = __pmd(val);
+
+	/*
+	 * Dirty bit is not preserved above so it can be done
+	 * in a special way for the shadow stack case, where it
+	 * may need to set _PAGE_COW. __pmd_mkdirty() will do this in
+	 * the case of shadow stack.
+	 */
+	if (pmd_dirty(pmd))
+		pmd_result = __pmd_mkdirty(pmd_result, false);
+
+	return pmd_result;
 }
 
 /*
-- 
2.17.1

