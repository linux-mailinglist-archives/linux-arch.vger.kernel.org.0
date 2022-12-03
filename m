Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E77641240
	for <lists+linux-arch@lfdr.de>; Sat,  3 Dec 2022 01:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbiLCAig (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Dec 2022 19:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235100AbiLCAhw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2022 19:37:52 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CE3FB896;
        Fri,  2 Dec 2022 16:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670027818; x=1701563818;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=VdMyMevhZAddtRomIPqld9oZXe9pcHrfJ+wDgFx8LIU=;
  b=gjfbeWdtx1oNZa+0OtnjeIbaXPdUTg6OfgceMuLjfFP6LiLnEX9GMsFr
   7GSxW+hLK3uyM6hR2vYcs+py6P9nyHkiEIFNhvfbdSTsIqn7N53tYtK46
   XOvq9ToE7VpPwQrifs/89GRKDaP5Kmv9D2lMJN/doVjsPxCyCbk9tWPIF
   DkYqr0VaLOUheF1MXC5+aOhGtC1N6neVWU8qaB8Hi7YRM0SQIdoooEW70
   pvNUUYMpKzTDCSdT7KzddWDwLjMQPaKMfROWnmvSyzC2DYH+bJVD7TRJN
   PAuOGQmZo8ZX4yH4lBbLf/IXxVy9hjyIPHxRYIBzBcNz9UqxAY2DsokjO
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="313710914"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="313710914"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:36:57 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="787479818"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="787479818"
Received: from bgordon1-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.211.211])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:36:52 -0800
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
Subject: [PATCH v4 11/39] x86/mm: Update pte_modify for _PAGE_COW
Date:   Fri,  2 Dec 2022 16:35:38 -0800
Message-Id: <20221203003606.6838-12-rick.p.edgecombe@intel.com>
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

Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---

v4:
 - Fix an issue in soft-dirty test, where pte_modify() would detect
   _PAGE_COW in pte_dirty() and set the soft dirty bit in pte_mkdirty().

v2:
 - Update commit log with text and suggestions from (Dave Hansen)
 - Drop fixup_dirty_pte() in favor of clearing the HW dirty bit along
   with the _PAGE_CHG_MASK masking, then calling pte_mkdirty() (Dave
   Hansen)

 arch/x86/include/asm/pgtable.h | 40 +++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index ee5fbdc2615f..67bd2627c293 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -698,26 +698,54 @@ static inline u64 flip_protnone_guard(u64 oldval, u64 val, u64 mask);
 
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
+	 * needs to set _PAGE_COW. pte_mkcow() will do this in
+	 * the case of shadow stack.
+	 */
+	if (pte_dirty(pte_result))
+		pte_result = pte_mkcow(pte_result);
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
+	 * needs to set _PAGE_COW. pmd_mkcow() will do this in
+	 * the case of shadow stack.
+	 */
+	if (pmd_dirty(pmd_result))
+		pmd_result = pmd_mkcow(pmd_result);
+
+	return pmd_result;
 }
 
 /*
-- 
2.17.1

