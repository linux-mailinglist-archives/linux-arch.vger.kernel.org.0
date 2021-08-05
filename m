Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C259A3E0B9B
	for <lists+linux-arch@lfdr.de>; Thu,  5 Aug 2021 02:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236963AbhHEAx4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Aug 2021 20:53:56 -0400
Received: from mga02.intel.com ([134.134.136.20]:12131 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236633AbhHEAxp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 4 Aug 2021 20:53:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10066"; a="201215435"
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="201215435"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 17:53:31 -0700
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="437617216"
Received: from mjkendri-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.17.117])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 17:53:29 -0700
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
Subject: [PATCH v4 05/15] x86/tdx: Make DMA pages shared
Date:   Wed,  4 Aug 2021 17:52:08 -0700
Message-Id: <20210805005218.2912076-6-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210805005218.2912076-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210805005218.2912076-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Just like MKTME, TDX reassigns bits of the physical address for
metadata.  MKTME used several bits for an encryption KeyID. TDX
uses a single bit in guests to communicate whether a physical page
should be protected by TDX as private memory (bit set to 0) or
unprotected and shared with the VMM (bit set to 1).

__set_memory_enc_dec() is now aware about TDX and sets Shared bit
accordingly following with relevant TDX hypercall.

Also, Do TDACCEPTPAGE on every 4k page after mapping the GPA range
when converting memory to private. Using 4k page size limit is due
to current TDX spec restriction. Also, If the GPA (range) was
already mapped as an active, private page, the host VMM may remove
the private page from the TD by following the “Removing TD Private
Pages” sequence in the Intel TDX-module specification [1] to safely
block the mapping(s), flush the TLB and cache, and remove the
mapping(s).

BUG() if TDACCEPTPAGE fails (except "previously accepted page" case)
, as the guest is completely hosed if it can't access memory. 

[1] https://software.intel.com/content/dam/develop/external/us/en/documents/tdx-module-1eas-v0.85.039.pdf

Tested-by: Kai Huang <kai.huang@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v3:
 * Rebased on top of Tom Lendacky's protected guest
   changes (https://lore.kernel.org/patchwork/cover/1468760/)
 * Fixed TDX_PAGE_ALREADY_ACCEPTED error code as per latest
   spec update.

Changes since v1:
 * Removed "we" or "I" usages in comment section.
 * Replaced is_tdx_guest() checks with prot_guest_has() checks.

 arch/x86/include/asm/pgtable.h   |  1 +
 arch/x86/kernel/tdx.c            | 35 +++++++++++++++++++++----
 arch/x86/mm/mem_encrypt_common.c |  9 ++++++-
 arch/x86/mm/pat/set_memory.c     | 45 +++++++++++++++++++++++++++-----
 4 files changed, 77 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 2d4d518651d2..f341bf6b8b93 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -24,6 +24,7 @@
 /* Make the page accesable by VMM for protected guests */
 #define pgprot_protected_guest(prot) __pgprot(pgprot_val(prot) |	\
 					      tdg_shared_mask())
+#define pgprot_pg_shared_mask() __pgprot(tdg_shared_mask())
 
 #ifndef __ASSEMBLY__
 #include <asm/x86_init.h>
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index ccbad600a422..b91740a485d6 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -17,10 +17,16 @@
 /* TDX Module call Leaf IDs */
 #define TDINFO				1
 #define TDGETVEINFO			3
+#define TDACCEPTPAGE			6
 
 /* TDX hypercall Leaf IDs */
 #define TDVMCALL_MAP_GPA		0x10001
 
+/* TDX Module call error codes */
+#define TDX_PAGE_ALREADY_ACCEPTED	0x00000b0a00000000
+#define TDCALL_RETURN_CODE_MASK		0xFFFFFFFF00000000
+#define TDCALL_RETURN_CODE(a)		((a) & TDCALL_RETURN_CODE_MASK)
+
 #define VE_IS_IO_OUT(exit_qual)		(((exit_qual) & 8) ? 0 : 1)
 #define VE_GET_IO_SIZE(exit_qual)	(((exit_qual) & 7) + 1)
 #define VE_GET_PORT_NUM(exit_qual)	((exit_qual) >> 16)
@@ -100,26 +106,45 @@ static void tdg_get_info(void)
 	physical_mask &= ~tdg_shared_mask();
 }
 
+static void tdg_accept_page(phys_addr_t gpa)
+{
+	u64 ret;
+
+	ret = __tdx_module_call(TDACCEPTPAGE, gpa, 0, 0, 0, NULL);
+
+	BUG_ON(ret && TDCALL_RETURN_CODE(ret) != TDX_PAGE_ALREADY_ACCEPTED);
+}
+
 /*
  * Inform the VMM of the guest's intent for this physical page:
  * shared with the VMM or private to the guest.  The VMM is
  * expected to change its mapping of the page in response.
- *
- * Note: shared->private conversions require further guest
- * action to accept the page.
  */
 int tdx_hcall_gpa_intent(phys_addr_t gpa, int numpages,
 			 enum tdx_map_type map_type)
 {
-	u64 ret;
+	u64 ret = 0;
+	int i;
 
 	if (map_type == TDX_MAP_SHARED)
 		gpa |= tdg_shared_mask();
 
 	ret = _tdx_hypercall(TDVMCALL_MAP_GPA, gpa, PAGE_SIZE * numpages, 0, 0,
 			     NULL);
+	if (ret)
+		ret = -EIO;
 
-	return ret ? -EIO : 0;
+	if (ret || map_type == TDX_MAP_SHARED)
+		return ret;
+
+	/*
+	 * For shared->private conversion, accept the page using TDACCEPTPAGE
+	 * TDX module call.
+	 */
+	for (i = 0; i < numpages; i++)
+		tdg_accept_page(gpa + i * PAGE_SIZE);
+
+	return 0;
 }
 
 static __cpuidle void tdg_halt(void)
diff --git a/arch/x86/mm/mem_encrypt_common.c b/arch/x86/mm/mem_encrypt_common.c
index f063c885b0a5..fdaf09b4a658 100644
--- a/arch/x86/mm/mem_encrypt_common.c
+++ b/arch/x86/mm/mem_encrypt_common.c
@@ -9,9 +9,16 @@
 
 #include <asm/mem_encrypt_common.h>
 #include <linux/dma-mapping.h>
+#include <linux/protected_guest.h>
 
 /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
 bool force_dma_unencrypted(struct device *dev)
 {
-	return amd_force_dma_unencrypted(dev);
+	if (prot_guest_has(PATTR_SEV) || prot_guest_has(PATTR_SME))
+		return amd_force_dma_unencrypted(dev);
+
+	if (prot_guest_has(PATTR_GUEST_MEM_ENCRYPT))
+		return true;
+
+	return false;
 }
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index ad8a5c586a35..52c93923b947 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -29,6 +29,7 @@
 #include <asm/proto.h>
 #include <asm/memtype.h>
 #include <asm/set_memory.h>
+#include <asm/tdx.h>
 
 #include "../mm_internal.h"
 
@@ -1980,9 +1981,11 @@ int set_memory_global(unsigned long addr, int numpages)
 				    __pgprot(_PAGE_GLOBAL), 0);
 }
 
-static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
+static int __set_memory_protect(unsigned long addr, int numpages, bool protect)
 {
+	pgprot_t mem_protected_bits, mem_plain_bits;
 	struct cpa_data cpa;
+	enum tdx_map_type map_type;
 	int ret;
 
 	/* Nothing to do if memory encryption is not active */
@@ -1996,8 +1999,25 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 	memset(&cpa, 0, sizeof(cpa));
 	cpa.vaddr = &addr;
 	cpa.numpages = numpages;
-	cpa.mask_set = enc ? __pgprot(_PAGE_ENC) : __pgprot(0);
-	cpa.mask_clr = enc ? __pgprot(0) : __pgprot(_PAGE_ENC);
+
+	if (prot_guest_has(PATTR_GUEST_SHARED_MAPPING_INIT)) {
+		mem_protected_bits = __pgprot(0);
+		mem_plain_bits = pgprot_pg_shared_mask();
+	} else {
+		mem_protected_bits = __pgprot(_PAGE_ENC);
+		mem_plain_bits = __pgprot(0);
+	}
+
+	if (protect) {
+		cpa.mask_set = mem_protected_bits;
+		cpa.mask_clr = mem_plain_bits;
+		map_type = TDX_MAP_PRIVATE;
+	} else {
+		cpa.mask_set = mem_plain_bits;
+		cpa.mask_clr = mem_protected_bits;
+		map_type = TDX_MAP_SHARED;
+	}
+
 	cpa.pgd = init_mm.pgd;
 
 	/* Must avoid aliasing mappings in the highmem code */
@@ -2005,9 +2025,17 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 	vm_unmap_aliases();
 
 	/*
-	 * Before changing the encryption attribute, we need to flush caches.
+	 * Before changing the encryption attribute, flush caches.
+	 *
+	 * For TDX, guest is responsible for flushing caches on private->shared
+	 * transition. VMM is responsible for flushing on shared->private.
 	 */
-	cpa_flush(&cpa, !this_cpu_has(X86_FEATURE_SME_COHERENT));
+	if (prot_guest_has(PATTR_GUEST_TDX)) {
+		if (map_type == TDX_MAP_SHARED)
+			cpa_flush(&cpa, 1);
+	} else {
+		cpa_flush(&cpa, !this_cpu_has(X86_FEATURE_SME_COHERENT));
+	}
 
 	ret = __change_page_attr_set_clr(&cpa, 1);
 
@@ -2020,18 +2048,21 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 	 */
 	cpa_flush(&cpa, 0);
 
+	if (!ret && prot_guest_has(PATTR_GUEST_SHARED_MAPPING_INIT))
+		ret = tdx_hcall_gpa_intent(__pa(addr), numpages, map_type);
+
 	return ret;
 }
 
 int set_memory_encrypted(unsigned long addr, int numpages)
 {
-	return __set_memory_enc_dec(addr, numpages, true);
+	return __set_memory_protect(addr, numpages, true);
 }
 EXPORT_SYMBOL_GPL(set_memory_encrypted);
 
 int set_memory_decrypted(unsigned long addr, int numpages)
 {
-	return __set_memory_enc_dec(addr, numpages, false);
+	return __set_memory_protect(addr, numpages, false);
 }
 EXPORT_SYMBOL_GPL(set_memory_decrypted);
 
-- 
2.25.1

