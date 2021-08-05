Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C353E0B80
	for <lists+linux-arch@lfdr.de>; Thu,  5 Aug 2021 02:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236698AbhHEAxr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Aug 2021 20:53:47 -0400
Received: from mga02.intel.com ([134.134.136.20]:12127 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235659AbhHEAxl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 4 Aug 2021 20:53:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10066"; a="201215425"
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="201215425"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 17:53:27 -0700
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="437617195"
Received: from mjkendri-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.17.117])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 17:53:24 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Richard Henderson <rth@twiddle.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        James E J Bottomley <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "Michael S . Tsirkin" <mst@redhat.com>
Cc:     Peter H Anvin <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v4 03/15] x86/tdx: Make pages shared in ioremap()
Date:   Wed,  4 Aug 2021 17:52:06 -0700
Message-Id: <20210805005218.2912076-4-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210805005218.2912076-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210805005218.2912076-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

All ioremap()ed pages that are not backed by normal memory (NONE or
RESERVED) have to be mapped as shared.

Reuse the infrastructure from AMD SEV code.

Note that DMA code doesn't use ioremap() to convert memory to shared as
DMA buffers backed by normal memory. DMA code make buffer shared with
set_memory_decrypted().

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v3:
 * Rebased on top of Tom Lendacky's protected guest
   changes (https://lore.kernel.org/patchwork/cover/1468760/)

Changes since v1:
 * Fixed format issues in commit log.

 arch/x86/include/asm/pgtable.h  | 4 ++++
 arch/x86/mm/ioremap.c           | 8 ++++++--
 include/linux/protected_guest.h | 1 +
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 448cd01eb3ec..2d4d518651d2 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -21,6 +21,10 @@
 #define pgprot_encrypted(prot)	__pgprot(__sme_set(pgprot_val(prot)))
 #define pgprot_decrypted(prot)	__pgprot(__sme_clr(pgprot_val(prot)))
 
+/* Make the page accesable by VMM for protected guests */
+#define pgprot_protected_guest(prot) __pgprot(pgprot_val(prot) |	\
+					      tdg_shared_mask())
+
 #ifndef __ASSEMBLY__
 #include <asm/x86_init.h>
 #include <asm/pkru.h>
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 60ade7dd71bd..69a60f240124 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -17,6 +17,7 @@
 #include <linux/mem_encrypt.h>
 #include <linux/efi.h>
 #include <linux/pgtable.h>
+#include <linux/protected_guest.h>
 
 #include <asm/set_memory.h>
 #include <asm/e820/api.h>
@@ -26,6 +27,7 @@
 #include <asm/pgalloc.h>
 #include <asm/memtype.h>
 #include <asm/setup.h>
+#include <asm/tdx.h>
 
 #include "physaddr.h"
 
@@ -87,8 +89,8 @@ static unsigned int __ioremap_check_ram(struct resource *res)
 }
 
 /*
- * In a SEV guest, NONE and RESERVED should not be mapped encrypted because
- * there the whole memory is already encrypted.
+ * In a SEV or TDX guest, NONE and RESERVED should not be mapped encrypted (or
+ * private in TDX case) because there the whole memory is already encrypted.
  */
 static unsigned int __ioremap_check_encrypted(struct resource *res)
 {
@@ -246,6 +248,8 @@ __ioremap_caller(resource_size_t phys_addr, unsigned long size,
 	prot = PAGE_KERNEL_IO;
 	if ((io_desc.flags & IORES_MAP_ENCRYPTED) || encrypted)
 		prot = pgprot_encrypted(prot);
+	else if (prot_guest_has(PATTR_GUEST_SHARED_MAPPING_INIT))
+		prot = pgprot_protected_guest(prot);
 
 	switch (pcm) {
 	case _PAGE_CACHE_MODE_UC:
diff --git a/include/linux/protected_guest.h b/include/linux/protected_guest.h
index 1a350c3fcfe2..14255f801100 100644
--- a/include/linux/protected_guest.h
+++ b/include/linux/protected_guest.h
@@ -17,6 +17,7 @@
 #define PATTR_GUEST_MEM_ENCRYPT		2	/* Guest encrypted memory */
 #define PATTR_GUEST_PROT_STATE		3	/* Guest encrypted state */
 #define PATTR_GUEST_UNROLL_STRING_IO	4	/* Unrolled string IO */
+#define PATTR_GUEST_SHARED_MAPPING_INIT	5	/* Late shared mapping init*/
 
 /* 0x800 - 0x8ff reserved for AMD */
 #define PATTR_SME			0x800
-- 
2.25.1

