Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549F9361525
	for <lists+linux-arch@lfdr.de>; Fri, 16 Apr 2021 00:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234940AbhDOWTJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Apr 2021 18:19:09 -0400
Received: from mga14.intel.com ([192.55.52.115]:22365 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235093AbhDOWSX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Apr 2021 18:18:23 -0400
IronPort-SDR: vXtTCGxKUYE2sz/IBieKRIDqh1qQ/Qq8oXhjbX9Kts8sioV4mOeyds9OLpSkOGGkkUGEZHXy3c
 M3JIF6c9cIsw==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="194513400"
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="194513400"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 15:15:41 -0700
IronPort-SDR: BGq2GgTjYFjNWk0FdG1FOzczjG8pUrhcXDgcUitGZRaB1Pbj9afE9Rj9CXYalJstxYRTlHCyuF
 8aKvOcDGn6iw==
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="451270962"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 15:15:41 -0700
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
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v25 29/30] mm: Update arch_validate_flags() to include vma anonymous
Date:   Thu, 15 Apr 2021 15:14:18 -0700
Message-Id: <20210415221419.31835-30-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210415221419.31835-1-yu-cheng.yu@intel.com>
References: <20210415221419.31835-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When newer VM flags are being created, such as VM_MTE, it becomes necessary
for mmap/mprotect to verify if certain flags are being applied to an
anonymous VMA.

To solve this, one approach is adding a VM flag to track that MAP_ANONYMOUS
is specified [1], and then using the flag in arch_validate_flags().

Another approach is passing vma_is_anonymous() to arch_validate_flags().
To prepare the introduction of PROT_SHSTK, which creates a shadow stack
mapping and can only be applied to an anonymous VMA, update arch_validate_
flags() to include anonymous VMA information.

[1] commit 9f3419315f3c ("arm64: mte: Add PROT_MTE support to mmap() and mprotect()"),

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/mman.h | 4 ++--
 arch/sparc/include/asm/mman.h | 4 ++--
 include/linux/mman.h          | 2 +-
 mm/mmap.c                     | 2 +-
 mm/mprotect.c                 | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
index e3e28f7daf62..44add1a09041 100644
--- a/arch/arm64/include/asm/mman.h
+++ b/arch/arm64/include/asm/mman.h
@@ -74,7 +74,7 @@ static inline bool arch_validate_prot(unsigned long prot,
 }
 #define arch_validate_prot(prot, addr) arch_validate_prot(prot, addr)
 
-static inline bool arch_validate_flags(unsigned long vm_flags)
+static inline bool arch_validate_flags(unsigned long vm_flags, bool is_anon)
 {
 	if (!system_supports_mte())
 		return true;
@@ -82,6 +82,6 @@ static inline bool arch_validate_flags(unsigned long vm_flags)
 	/* only allow VM_MTE if VM_MTE_ALLOWED has been set previously */
 	return !(vm_flags & VM_MTE) || (vm_flags & VM_MTE_ALLOWED);
 }
-#define arch_validate_flags(vm_flags) arch_validate_flags(vm_flags)
+#define arch_validate_flags(vm_flags, is_anon) arch_validate_flags(vm_flags, is_anon)
 
 #endif /* ! __ASM_MMAN_H__ */
diff --git a/arch/sparc/include/asm/mman.h b/arch/sparc/include/asm/mman.h
index 274217e7ed70..4a897c8a3f1a 100644
--- a/arch/sparc/include/asm/mman.h
+++ b/arch/sparc/include/asm/mman.h
@@ -60,11 +60,11 @@ static inline int sparc_validate_prot(unsigned long prot, unsigned long addr)
 	return 1;
 }
 
-#define arch_validate_flags(vm_flags) arch_validate_flags(vm_flags)
+#define arch_validate_flags(vm_flags, is_anon) arch_validate_flags(vm_flags, is_anon)
 /* arch_validate_flags() - Ensure combination of flags is valid for a
  *	VMA.
  */
-static inline bool arch_validate_flags(unsigned long vm_flags)
+static inline bool arch_validate_flags(unsigned long vm_flags, bool is_anon)
 {
 	/* If ADI is being enabled on this VMA, check for ADI
 	 * capability on the platform and ensure VMA is suitable
diff --git a/include/linux/mman.h b/include/linux/mman.h
index 629cefc4ecba..a22ed4495d13 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -114,7 +114,7 @@ static inline bool arch_validate_prot(unsigned long prot, unsigned long addr)
  *
  * Returns true if the VM_* flags are valid.
  */
-static inline bool arch_validate_flags(unsigned long flags)
+static inline bool arch_validate_flags(unsigned long flags, bool is_anonymous)
 {
 	return true;
 }
diff --git a/mm/mmap.c b/mm/mmap.c
index 7b2992ef8ee0..db849e3ed9d3 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1850,7 +1850,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	}
 
 	/* Allow architectures to sanity-check the vm_flags */
-	if (!arch_validate_flags(vma->vm_flags)) {
+	if (!arch_validate_flags(vma->vm_flags, vma_is_anonymous(vma))) {
 		error = -EINVAL;
 		if (file)
 			goto unmap_and_free_vma;
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 3b2f0d75519f..64378b963548 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -611,7 +611,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 		}
 
 		/* Allow architectures to sanity-check the new flags */
-		if (!arch_validate_flags(newflags)) {
+		if (!arch_validate_flags(newflags, vma_is_anonymous(vma))) {
 			error = -EINVAL;
 			goto out;
 		}
-- 
2.21.0

