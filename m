Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCC86BFE3C
	for <lists+linux-arch@lfdr.de>; Sun, 19 Mar 2023 01:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjCSATM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Mar 2023 20:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjCSASc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 18 Mar 2023 20:18:32 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CD82A985;
        Sat, 18 Mar 2023 17:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679185041; x=1710721041;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=zgMYcW7jhLowf3LtAX7K40lEhH7jOSIjySbX8LofR4w=;
  b=nejJyKbK8OTQ4nhv1fyYtK6FJRFFBzex9bWu7+CL1dlXDPTOuDZTxo/E
   J/UeUbegClGQZYB2iDLR/g4RlrLfw4nmual8vI3+2Eu337CtWZEq13FLC
   9p88uiKab8xjfGS0NJIo/RHTspn39UONismVf2sbd4iEBo3YQ/a7X/Y6z
   dJv5t5PuP+hzQGta3q+zOsdPPpaxX9G9EuBrAwWM9Cfi2viwHJUTXYPQ4
   nbMj5Hl7IaLHyGwgNxrx994lCktni20kshku3EaSXA1mFU2Yb01ZFNquj
   IR4xQyUY4sm2BrKnpgpKWArN2ZtobhKVHuNQYCfFCEHMZvswzvoxTy2cd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="338491117"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="338491117"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 17:16:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="749672855"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="749672855"
Received: from bmahatwo-mobl1.gar.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.135.34.5])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 17:16:23 -0700
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
        david@redhat.com, debug@rivosinc.com, szabolcs.nagy@arm.com
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v8 18/40] mm: Introduce VM_SHADOW_STACK for shadow stack memory
Date:   Sat, 18 Mar 2023 17:15:13 -0700
Message-Id: <20230319001535.23210-19-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230319001535.23210-1-rick.p.edgecombe@intel.com>
References: <20230319001535.23210-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Yu-cheng Yu <yu-cheng.yu@intel.com>

New hardware extensions implement support for shadow stack memory, such
as x86 Control-flow Enforcement Technology (CET). Add a new VM flag to
identify these areas, for example, to be used to properly indicate shadow
stack PTEs to the hardware.

Shadow stack VMA creation will be tightly controlled and limited to
anonymous memory to make the implementation simpler and since that is all
that is required. The solution will rely on pte_mkwrite() to create the
shadow stack PTEs, so it will not be required for vm_get_page_prot() to
learn how to create shadow stack memory. For this reason document that
VM_SHADOW_STACK should not be mixed with VM_SHARED.

Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
---
v7:
 - Use lightly edited commit log verbiage from (David Hildenbrand)
 - Add explanation for VM_SHARED limitation (David Hildenbrand)

v6:
 - Add comment about VM_SHADOW_STACK not being allowed with VM_SHARED
   (David Hildenbrand)

v3:
 - Drop arch specific change in arch_vma_name(). The memory can show as
   anonymous (Kirill)
 - Change CONFIG_ARCH_HAS_SHADOW_STACK to CONFIG_X86_USER_SHADOW_STACK
   in show_smap_vma_flags() (Boris)
---
 Documentation/filesystems/proc.rst | 1 +
 fs/proc/task_mmu.c                 | 3 +++
 include/linux/mm.h                 | 8 ++++++++
 3 files changed, 12 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 9d5fd9424e8b..8b314df7ccdf 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -564,6 +564,7 @@ encoded manner. The codes are the following:
     mt    arm64 MTE allocation tags are enabled
     um    userfaultfd missing tracking
     uw    userfaultfd wr-protect tracking
+    ss    shadow stack page
     ==    =======================================
 
 Note that there is no guarantee that every flag and associated mnemonic will
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 6a96e1713fd5..324b092c2ac9 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -711,6 +711,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
 		[ilog2(VM_UFFD_MINOR)]	= "ui",
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
+#ifdef CONFIG_X86_USER_SHADOW_STACK
+		[ilog2(VM_SHADOW_STACK)] = "ss",
+#endif
 	};
 	size_t i;
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index a1b31caae013..097544afb1aa 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -326,11 +326,13 @@ extern unsigned int kobjsize(const void *objp);
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
@@ -346,6 +348,12 @@ extern unsigned int kobjsize(const void *objp);
 #endif
 #endif /* CONFIG_ARCH_HAS_PKEYS */
 
+#ifdef CONFIG_X86_USER_SHADOW_STACK
+# define VM_SHADOW_STACK	VM_HIGH_ARCH_5 /* Should not be set with VM_SHARED */
+#else
+# define VM_SHADOW_STACK	VM_NONE
+#endif
+
 #if defined(CONFIG_X86)
 # define VM_PAT		VM_ARCH_1	/* PAT reserves whole VMA at once (x86) */
 #elif defined(CONFIG_PPC)
-- 
2.17.1

