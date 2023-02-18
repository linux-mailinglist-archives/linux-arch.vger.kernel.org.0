Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E0269BCCB
	for <lists+linux-arch@lfdr.de>; Sat, 18 Feb 2023 22:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjBRVVF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Feb 2023 16:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjBRVUA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 18 Feb 2023 16:20:00 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138CE1114C;
        Sat, 18 Feb 2023 13:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676755080; x=1708291080;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=ECFpkrFmLdwFWEoO9V0RJS5m7s8m94UVjRDo+XGZ7qk=;
  b=kqEWwUqyuGu3GEPWQidmQyEuBTuT4U4rYpfDZD9fLYOO/ZygnxZEKq1A
   HSJVB300oDnOMk1Yequ4XHcy+/XzhvMZU4/3fWrWJ9vhzH3h3Q1PzSR+r
   8TdTZ+09lqPNSUFs5Zwg3r8eeFx5Ln3kXcyiVTZpjVnkCNiNld0GB3Q4W
   E0QwOaGp0/EeyAjDqoDzfzbjHIX4iOemCAc2b5qLkGPYh8ghmomnuYzmf
   /o9PFMOANghyDA3puajNqFtrrjmR/q7DgbPZIweasIw54POY4zgRblEFj
   /uSu3B1wjByDH3qeIHn3jb6kw6h36pj3y9tlKlOfhfECK9jJA0Dc/LKXk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="418427614"
X-IronPort-AV: E=Sophos;i="5.97,309,1669104000"; 
   d="scan'208";a="418427614"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2023 13:16:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="664241685"
X-IronPort-AV: E=Sophos;i="5.97,309,1669104000"; 
   d="scan'208";a="664241685"
Received: from adityava-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.80.223])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2023 13:16:15 -0800
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
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, debug@rivosinc.com
Cc:     rick.p.edgecombe@intel.com
Subject: [PATCH v6 24/41] mm: Don't allow write GUPs to shadow stack memory
Date:   Sat, 18 Feb 2023 13:14:16 -0800
Message-Id: <20230218211433.26859-25-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The x86 Control-flow Enforcement Technology (CET) feature includes a new
type of memory called shadow stack. This shadow stack memory has some
unusual properties, which requires some core mm changes to function
properly.

Shadow stack memory is writable only in very specific, controlled ways.
However, since it is writable, the kernel treats it as such. As a result
there remain many ways for userspace to trigger the kernel to write to
shadow stack's via get_user_pages(, FOLL_WRITE) operations. To make this a
little less exposed, block writable GUPs for shadow stack VMAs.

Still allow FOLL_FORCE to write through shadow stack protections, as it
does for read-only protections.

Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

---
v3:
 - Add comment in __pte_access_permitted() (Dave)
 - Remove unneeded shadow stack specific check in
   __pte_access_permitted() (Jann)
---
 arch/x86/include/asm/pgtable.h | 5 +++++
 mm/gup.c                       | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 6b7106457bfb..20d0df494269 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1641,6 +1641,11 @@ static inline bool __pte_access_permitted(unsigned long pteval, bool write)
 {
 	unsigned long need_pte_bits = _PAGE_PRESENT|_PAGE_USER;
 
+	/*
+	 * Write=0,Dirty=1 PTEs are shadow stack, which the kernel
+	 * shouldn't generally allow access to, but since they
+	 * are already Write=0, the below logic covers both cases.
+	 */
 	if (write)
 		need_pte_bits |= _PAGE_RW;
 
diff --git a/mm/gup.c b/mm/gup.c
index f45a3a5be53a..bfd33d9edb89 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -982,7 +982,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 		return -EFAULT;
 
 	if (write) {
-		if (!(vm_flags & VM_WRITE)) {
+		if (!(vm_flags & VM_WRITE) || (vm_flags & VM_SHADOW_STACK)) {
 			if (!(gup_flags & FOLL_FORCE))
 				return -EFAULT;
 			/* hugetlb does not support FOLL_FORCE|FOLL_WRITE. */
-- 
2.17.1

