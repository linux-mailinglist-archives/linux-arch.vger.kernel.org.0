Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9640D32C862
	for <lists+linux-arch@lfdr.de>; Thu,  4 Mar 2021 02:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239928AbhCDAtR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Mar 2021 19:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239338AbhCCR3a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Mar 2021 12:29:30 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C8FC061764;
        Wed,  3 Mar 2021 09:27:00 -0800 (PST)
Received: from zn.tnic (p200300ec2f086d000d273eec19a1f357.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:6d00:d27:3eec:19a1:f357])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D6C9B1EC0300;
        Wed,  3 Mar 2021 18:26:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614792418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4ibLcnOd4K0tYTtc82E0TWwQeSANPgQebYcD/0eumSw=;
        b=fZN/EdJwGpouJQ1EYJJuFKYMPR3wGDQgjNMM/pTBNKL59wEOirstsgN7mKM8OyeoyKou1i
        HGktvIYgCwElZrpEtMPzSViQ6wOytsMrrX738nFT6eAj1GoSTfQHGXvVd8SHtaowHM5TAR
        eEiSsLKgC1unJF+Xny+UH7GSFR/ThdA=
Date:   Wed, 3 Mar 2021 18:26:52 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
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
Subject: Re: [PATCH v21 08/26] x86/mm: Introduce _PAGE_COW
Message-ID: <20210303172652.GF22305@zn.tnic>
References: <20210217222730.15819-1-yu-cheng.yu@intel.com>
 <20210217222730.15819-9-yu-cheng.yu@intel.com>
 <20210301155234.GF6699@zn.tnic>
 <167f58a3-20ef-7210-1d66-cf25f4a9bbef@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <167f58a3-20ef-7210-1d66-cf25f4a9bbef@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 02, 2021 at 03:46:31PM -0800, Yu, Yu-cheng wrote:
> There is a problem of doing that: pmd_write() is defined after this
> function.  Maybe we can declare it first, or leave this as-is?

Or a third option: you lift those two functions in a prepatch and then
in this patch use them directly.

Combined diff ontop:

---
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 1a6c0784af0a..b7e4d031ce22 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -209,6 +209,18 @@ static inline int pte_write(pte_t pte)
 	return (pte_flags(pte) & _PAGE_RW) || pte_shstk(pte);
 }
 
+#define pmd_write pmd_write
+static inline int pmd_write(pmd_t pmd)
+{
+	return (pmd_flags(pmd) & _PAGE_RW) || pmd_shstk(pmd);
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
@@ -540,7 +552,7 @@ static inline pmd_t pmd_mkdirty(pmd_t pmd)
 	pmdval_t dirty = _PAGE_DIRTY;
 
 	/* Avoid creating (HW)Dirty=1, Write=0 PMDs */
-	if (cpu_feature_enabled(X86_FEATURE_SHSTK) && !(pmd_flags(pmd) & _PAGE_RW))
+	if (cpu_feature_enabled(X86_FEATURE_SHSTK) && !pmd_write(pmd))
 		dirty = _PAGE_COW;
 
 	return pmd_set_flags(pmd, dirty | _PAGE_SOFT_DIRTY);
@@ -636,7 +648,7 @@ static inline pud_t pud_mkdirty(pud_t pud)
 	pudval_t dirty = _PAGE_DIRTY;
 
 	/* Avoid creating (HW)Dirty=1, Write=0 PUDs */
-	if (cpu_feature_enabled(X86_FEATURE_SHSTK) && !(pud_flags(pud) & _PAGE_RW))
+	if (cpu_feature_enabled(X86_FEATURE_SHSTK) && !pud_write(pud))
 		dirty = _PAGE_COW;
 
 	return pud_set_flags(pud, dirty | _PAGE_SOFT_DIRTY);
@@ -1273,12 +1285,6 @@ extern int pmdp_clear_flush_young(struct vm_area_struct *vma,
 				  unsigned long address, pmd_t *pmdp);
 
 
-#define pmd_write pmd_write
-static inline int pmd_write(pmd_t pmd)
-{
-	return (pmd_flags(pmd) & _PAGE_RW) || pmd_shstk(pmd);
-}
-
 #define __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR
 static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm, unsigned long addr,
 				       pmd_t *pmdp)
@@ -1300,12 +1306,6 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm,
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
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
