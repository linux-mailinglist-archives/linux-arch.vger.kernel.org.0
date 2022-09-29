Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDBF5F005E
	for <lists+linux-arch@lfdr.de>; Fri, 30 Sep 2022 00:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiI2Wdh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Sep 2022 18:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiI2Wcj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Sep 2022 18:32:39 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF58A0317;
        Thu, 29 Sep 2022 15:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664490656; x=1696026656;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=9UWqqA5zjHhGRdDkC9YrucJaLkwFDjky53Grbijfra4=;
  b=izG0hZTumiT6niFgCl0c6eK4m8ok7Zz1+F53GGP4Tm5f7CYvKPAuGpr7
   hQOxmpQI0XRuGKSALDm/YPQfgYXHcS/TfiEBT4c7QDHm6BTyIjhVXJ7pj
   C0JlKsgwBjka4StcAOeGHSZrkP5C4afsbir/NfXfsRD08Xou5dCH6C3H8
   SUumAhQCf8s5cDt1uyvghRfi3Bg13E7FbEnmV95zc+GkPquIX9F1fGIk1
   KXZahgMgfqSadqGUHQhFTmNOh+QocU/dVglRwEAS1llGvkib8x9E2wIfa
   QimQBI5JIGgCJJQjw+DQp7LpdAZ7R9cLJfL2CBaZfrKrzUsBR0QwCo2l3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="303531396"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="303531396"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:30:08 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="691016179"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="691016179"
Received: from sergungo-mobl.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.251.25.88])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:30:06 -0700
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
Subject: [PATCH v2 11/39] x86/mm: Update pte_modify for _PAGE_COW
Date:   Thu, 29 Sep 2022 15:29:08 -0700
Message-Id: <20220929222936.14584-12-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
pte_*(). Modify it to also move _PAGE_DIRTY to _PAGE_COW. Apply the same
changes to pmd_modify().

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

---

v2:
 - Update commit log with text and suggestions from (Dave Hansen)
 - Drop fixup_dirty_pte() in favor of clearing the HW dirty bit along
   with the _PAGE_CHG_MASK masking, then calling pte_mkdirty() (Dave
   Hansen)

 arch/x86/include/asm/pgtable.h | 41 +++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index ad201dae7316..2f2963429f48 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -790,26 +790,55 @@ static inline u64 flip_protnone_guard(u64 oldval, u64 val, u64 mask);
 
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
+	 * needs to set _PAGE_COW. pte_mkdirty() will do this in
+	 * the case of shadow stack.
+	 */
+	if (pte_dirty(pte))
+		pte_result = pte_mkdirty(pte_result);
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
+
+	pmd_result = __pmd(val);
+
+	/*
+	 * Dirty bit is not preserved above so it can be done
+	 * specially for the shadow stack case. It needs to move
+	 * the HW dirty bit to the software COW bit. Set in the
+	 * result if it was set in the original value.
+	 */
+	if (pmd_dirty(pmd))
+		pmd_result = pmd_mkdirty(pmd_result);
+
+	return pmd_result;
 }
 
 /*
-- 
2.17.1

