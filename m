Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3C54A39E6
	for <lists+linux-arch@lfdr.de>; Sun, 30 Jan 2022 22:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356517AbiA3VV7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 30 Jan 2022 16:21:59 -0500
Received: from mga06.intel.com ([134.134.136.31]:52029 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356477AbiA3VV4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 30 Jan 2022 16:21:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643577716; x=1675113716;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=oKgQSRP9S/kqW3HSqD2DF7a0CZx0ho0AcrTJmlbuSJk=;
  b=OoB5wgpcPEv5ssTOO89fn0qldMkY+FjjH0COjGx+Bza4QAEjJ46P1Ycj
   ROdF9DA5uTNiurg/mQ1GnXqGk9StnAcZb8aeH5Q7bN4xGzMmJNusv+H3a
   fkPAyfgxE+esUGTsWIz//woiij93BFS8QzuVd++i6ZynYGopVCymAPkGh
   +KmNEUATQ/9Y9ZFxI/sw2CMmHC0VWBLL9I2AcJmbQvAF5iLJOVf9Lmya1
   4NKVP9Co+YrzlQAB5vxwBm3eAz8okvR28vHWrO/UpEHGF3G4LNOycCEp0
   Jv+DQw3JwfmpJNwThuyonUnOB6Zyma5cuFPtnKi1m3h3ECleChdcev8qJ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="308104910"
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="308104910"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:21:52 -0800
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="536856724"
Received: from avmallar-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.123.171])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:21:51 -0800
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
Subject: [PATCH 08/35] x86/mm: Move pmd_write(), pud_write() up in the file
Date:   Sun, 30 Jan 2022 13:18:11 -0800
Message-Id: <20220130211838.8382-9-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Yu-cheng Yu <yu-cheng.yu@intel.com>

To prepare the introduction of _PAGE_COW, move pmd_write() and
pud_write() up in the file, so that they can be used by other
helpers below.  No functional changes.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/include/asm/pgtable.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 8a9432fb3802..aff5e489ff17 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -158,6 +158,18 @@ static inline int pte_write(pte_t pte)
 	return pte_flags(pte) & _PAGE_RW;
 }
 
+#define pmd_write pmd_write
+static inline int pmd_write(pmd_t pmd)
+{
+	return pmd_flags(pmd) & _PAGE_RW;
+}
+
+#define pud_write pud_write
+static inline int pud_write(pud_t pud)
+{
+	return pud_flags(pud) & _PAGE_RW;
+}
+
 static inline int pte_huge(pte_t pte)
 {
 	return pte_flags(pte) & _PAGE_PSE;
@@ -1116,12 +1128,6 @@ extern int pmdp_clear_flush_young(struct vm_area_struct *vma,
 				  unsigned long address, pmd_t *pmdp);
 
 
-#define pmd_write pmd_write
-static inline int pmd_write(pmd_t pmd)
-{
-	return pmd_flags(pmd) & _PAGE_RW;
-}
-
 #define __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR
 static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm, unsigned long addr,
 				       pmd_t *pmdp)
@@ -1151,12 +1157,6 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm,
 	clear_bit(_PAGE_BIT_RW, (unsigned long *)pmdp);
 }
 
-#define pud_write pud_write
-static inline int pud_write(pud_t pud)
-{
-	return pud_flags(pud) & _PAGE_RW;
-}
-
 #ifndef pmdp_establish
 #define pmdp_establish pmdp_establish
 static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
-- 
2.17.1

