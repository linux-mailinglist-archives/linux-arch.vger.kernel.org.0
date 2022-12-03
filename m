Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F20164124E
	for <lists+linux-arch@lfdr.de>; Sat,  3 Dec 2022 01:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbiLCAjR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Dec 2022 19:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbiLCAib (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2022 19:38:31 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B881FC2BB;
        Fri,  2 Dec 2022 16:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670027834; x=1701563834;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=/8ygfG70rYB7SEC4SbN3orD5L3ZmTAS2ypn+csy1744=;
  b=Ql96+BegosplW52c00P7hjzptjjiv90ulfuDWJBg0CFGq1VeuprcR+be
   nW2IT3TSo1+bVP3YTaBeWHX2BtW7wFEmZ3ANIrlRVr7E69v8SFmwYMweh
   Ot7Pfp78GhBv47Z7QQ4GiiVsjD/1XkKuqbtlmD5f4nig4Ufw70T4ken67
   XeCf7wFGTq2gcp2s0i2qxxqfxiKgA+HCpzwULdHNSl2O2vdLiML5UpBXG
   EfynPrY0JtjTzomHzF5WYmBjzWPcCQrC2aup3CExk16Y2eHl7ViRGDiK9
   eLy4TNz4BXbBYKk1rY1dDCCgZFyMmum1cc0So2cr88wZSCyDYL7txquR/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="313711017"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="313711017"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:37:07 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="787479877"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="787479877"
Received: from bgordon1-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.211.211])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:37:04 -0800
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
Subject: [PATCH v4 15/39] mm: Introduce VM_SHADOW_STACK for shadow stack memory
Date:   Fri,  2 Dec 2022 16:35:42 -0800
Message-Id: <20221203003606.6838-16-rick.p.edgecombe@intel.com>
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

The x86 Control-flow Enforcement Technology (CET) feature includes a new
type of memory called shadow stack. This shadow stack memory has some
unusual properties, which requires some core mm changes to function
properly.

A shadow stack PTE must be read-only and have _PAGE_DIRTY set. However,
read-only and Dirty PTEs also exist for copy-on-write (COW) pages. These
two cases are handled differently for page faults. Introduce
VM_SHADOW_STACK to track shadow stack VMAs.

Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Kees Cook <keescook@chromium.org>
---

v3:
 - Drop arch specific change in arch_vma_name(). The memory can show as
   anonymous (Kirill)
 - Change CONFIG_ARCH_HAS_SHADOW_STACK to CONFIG_X86_USER_SHADOW_STACK
   in show_smap_vma_flags() (Boris)

 Documentation/filesystems/proc.rst | 1 +
 fs/proc/task_mmu.c                 | 3 +++
 include/linux/mm.h                 | 8 ++++++++
 3 files changed, 12 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 898c99eae8e4..05506dfa0480 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -560,6 +560,7 @@ encoded manner. The codes are the following:
     mt    arm64 MTE allocation tags are enabled
     um    userfaultfd missing tracking
     uw    userfaultfd wr-protect tracking
+    ss    shadow stack page
     ==    =======================================
 
 Note that there is no guarantee that every flag and associated mnemonic will
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index fa3eea895210..9c17502e9746 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -703,6 +703,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
 		[ilog2(VM_UFFD_MINOR)]	= "ui",
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
+#ifdef CONFIG_X86_USER_SHADOW_STACK
+		[ilog2(VM_SHADOW_STACK)] = "ss",
+#endif
 	};
 	size_t i;
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9ae6bc38d0b7..b982c2749e7b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -303,11 +303,13 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_HIGH_ARCH_BIT_2	34	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_BIT_3	35	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_BIT_4	36	/* bit only usable on 64-bit architectures */
+#define VM_HIGH_ARCH_BIT_5	37	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_0	BIT(VM_HIGH_ARCH_BIT_0)
 #define VM_HIGH_ARCH_1	BIT(VM_HIGH_ARCH_BIT_1)
 #define VM_HIGH_ARCH_2	BIT(VM_HIGH_ARCH_BIT_2)
 #define VM_HIGH_ARCH_3	BIT(VM_HIGH_ARCH_BIT_3)
 #define VM_HIGH_ARCH_4	BIT(VM_HIGH_ARCH_BIT_4)
+#define VM_HIGH_ARCH_5	BIT(VM_HIGH_ARCH_BIT_5)
 #endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
 
 #ifdef CONFIG_ARCH_HAS_PKEYS
@@ -323,6 +325,12 @@ extern unsigned int kobjsize(const void *objp);
 #endif
 #endif /* CONFIG_ARCH_HAS_PKEYS */
 
+#ifdef CONFIG_X86_USER_SHADOW_STACK
+# define VM_SHADOW_STACK	VM_HIGH_ARCH_5
+#else
+# define VM_SHADOW_STACK	VM_NONE
+#endif
+
 #if defined(CONFIG_X86)
 # define VM_PAT		VM_ARCH_1	/* PAT reserves whole VMA at once (x86) */
 #elif defined(CONFIG_PPC)
-- 
2.17.1

