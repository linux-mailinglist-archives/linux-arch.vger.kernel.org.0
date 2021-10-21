Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC8F436A4D
	for <lists+linux-arch@lfdr.de>; Thu, 21 Oct 2021 20:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhJUSRj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Oct 2021 14:17:39 -0400
Received: from mga14.intel.com ([192.55.52.115]:33021 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230103AbhJUSRj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 21 Oct 2021 14:17:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10144"; a="229377372"
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="229377372"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 11:15:20 -0700
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="527582109"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.202])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 11:15:19 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 2/2] x86/mm: nuke PAGE_KERNEL_IO
Date:   Thu, 21 Oct 2021 11:15:11 -0700
Message-Id: <20211021181511.1533377-3-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211021181511.1533377-1-lucas.demarchi@intel.com>
References: <20211021181511.1533377-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

PAGE_KERNEL_IO is only defined for x86 and nowadays is the same as
PAGE_KERNEL. It was different for some time, OR'ing a `_PAGE_IOMAP` flag
in commit be43d72835ba ("x86: add _PAGE_IOMAP pte flag for IO
mappings").  This got removed in commit f955371ca9d3 ("x86: remove the
Xen-specific _PAGE_IOMAP PTE flag"), so today they are just the same.

With the last users outside arch/x86 being remove we can now remove
PAGE_KERNEL_IO.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 arch/x86/include/asm/fixmap.h        | 2 +-
 arch/x86/include/asm/pgtable_types.h | 7 -------
 arch/x86/mm/ioremap.c                | 2 +-
 arch/x86/xen/setup.c                 | 2 +-
 include/asm-generic/fixmap.h         | 2 +-
 5 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
index d0dcefb5cc59..5e186a69db10 100644
--- a/arch/x86/include/asm/fixmap.h
+++ b/arch/x86/include/asm/fixmap.h
@@ -173,7 +173,7 @@ static inline void __set_fixmap(enum fixed_addresses idx,
  * supported for MMIO addresses, so make sure that the memory encryption
  * mask is not part of the page attributes.
  */
-#define FIXMAP_PAGE_NOCACHE PAGE_KERNEL_IO_NOCACHE
+#define FIXMAP_PAGE_NOCACHE PAGE_KERNEL_NOCACHE
 
 /*
  * Early memremap routines used for in-place encryption. The mappings created
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 40497a9020c6..a87224767ff3 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -199,10 +199,6 @@ enum page_cache_mode {
 #define __PAGE_KERNEL_WP	 (__PP|__RW|   0|___A|__NX|___D|   0|___G| __WP)
 
 
-#define __PAGE_KERNEL_IO		__PAGE_KERNEL
-#define __PAGE_KERNEL_IO_NOCACHE	__PAGE_KERNEL_NOCACHE
-
-
 #ifndef __ASSEMBLY__
 
 #define __PAGE_KERNEL_ENC	(__PAGE_KERNEL    | _ENC)
@@ -223,9 +219,6 @@ enum page_cache_mode {
 #define PAGE_KERNEL_LARGE_EXEC	__pgprot_mask(__PAGE_KERNEL_LARGE_EXEC | _ENC)
 #define PAGE_KERNEL_VVAR	__pgprot_mask(__PAGE_KERNEL_VVAR       | _ENC)
 
-#define PAGE_KERNEL_IO		__pgprot_mask(__PAGE_KERNEL_IO)
-#define PAGE_KERNEL_IO_NOCACHE	__pgprot_mask(__PAGE_KERNEL_IO_NOCACHE)
-
 #endif	/* __ASSEMBLY__ */
 
 /*         xwr */
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 026031b3b782..3102dda4b152 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -243,7 +243,7 @@ __ioremap_caller(resource_size_t phys_addr, unsigned long size,
 	 * make sure the memory encryption attribute is enabled in the
 	 * resulting mapping.
 	 */
-	prot = PAGE_KERNEL_IO;
+	prot = PAGE_KERNEL;
 	if ((io_desc.flags & IORES_MAP_ENCRYPTED) || encrypted)
 		prot = pgprot_encrypted(prot);
 
diff --git a/arch/x86/xen/setup.c b/arch/x86/xen/setup.c
index 8bfc10330107..5dc0771a50f3 100644
--- a/arch/x86/xen/setup.c
+++ b/arch/x86/xen/setup.c
@@ -435,7 +435,7 @@ static unsigned long __init xen_set_identity_and_remap_chunk(
 	for (pfn = start_pfn; pfn <= max_pfn_mapped && pfn < end_pfn; pfn++)
 		(void)HYPERVISOR_update_va_mapping(
 			(unsigned long)__va(pfn << PAGE_SHIFT),
-			mfn_pte(pfn, PAGE_KERNEL_IO), 0);
+			mfn_pte(pfn, PAGE_KERNEL), 0);
 
 	return remap_pfn;
 }
diff --git a/include/asm-generic/fixmap.h b/include/asm-generic/fixmap.h
index 8cc7b09c1bc7..f1b0c6f3d0be 100644
--- a/include/asm-generic/fixmap.h
+++ b/include/asm-generic/fixmap.h
@@ -54,7 +54,7 @@ static inline unsigned long virt_to_fix(const unsigned long vaddr)
 #define FIXMAP_PAGE_NOCACHE PAGE_KERNEL_NOCACHE
 #endif
 #ifndef FIXMAP_PAGE_IO
-#define FIXMAP_PAGE_IO PAGE_KERNEL_IO
+#define FIXMAP_PAGE_IO PAGE_KERNEL
 #endif
 #ifndef FIXMAP_PAGE_CLEAR
 #define FIXMAP_PAGE_CLEAR __pgprot(0)
-- 
2.33.1

