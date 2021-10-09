Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20672427537
	for <lists+linux-arch@lfdr.de>; Sat,  9 Oct 2021 02:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244297AbhJIAlA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Oct 2021 20:41:00 -0400
Received: from mga02.intel.com ([134.134.136.20]:5254 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244304AbhJIAki (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 Oct 2021 20:40:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10131"; a="213756570"
X-IronPort-AV: E=Sophos;i="5.85,358,1624345200"; 
   d="scan'208";a="213756570"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 17:37:55 -0700
X-IronPort-AV: E=Sophos;i="5.85,358,1624345200"; 
   d="scan'208";a="624905436"
Received: from dmsojoza-mobl3.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.251.135.62])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 17:37:53 -0700
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
        "Michael S . Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter H Anvin <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v5 15/16] x86/tdx: Implement ioremap_host_shared for x86
Date:   Fri,  8 Oct 2021 17:37:10 -0700
Message-Id: <20211009003711.1390019-16-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Implement ioremap_host_shared for x86. In TDX most memory is encrypted,
but some memory that is used to communicate with the host must
be declared shared with special page table attributes and a
special hypercall. Previously all ioremaped memory was declared
shared, but this leads to various BIOS tables and other private
state being shared, which is a security risk.

This patch replaces the unconditional ioremap sharing with an explicit
ioremap_host_shared that enables sharing.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v4:
 * Rebased on top of Tom Lendacky's CC guest
   changes (https://www.spinics.net/lists/linux-tip-commits/msg58716.html)

 arch/x86/include/asm/io.h |  4 ++++
 arch/x86/mm/ioremap.c     | 41 ++++++++++++++++++++++++++++++---------
 2 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 67e0c4a0a0f4..521b239c013f 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -380,6 +380,10 @@ extern void __iomem *ioremap_wc(resource_size_t offset, unsigned long size);
 extern void __iomem *ioremap_wt(resource_size_t offset, unsigned long size);
 #define ioremap_wt ioremap_wt
 
+extern void __iomem *ioremap_host_shared(resource_size_t offset,
+					 unsigned long size);
+#define ioremap_host_shared ioremap_host_shared
+
 extern bool is_early_ioremap_ptep(pte_t *ptep);
 
 #define IO_SPACE_LIMIT 0xffff
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 83daa3f8f39c..a83a69045f61 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -178,7 +178,8 @@ static void __ioremap_check_mem(resource_size_t addr, unsigned long size,
  */
 static void __iomem *
 __ioremap_caller(resource_size_t phys_addr, unsigned long size,
-		 enum page_cache_mode pcm, void *caller, bool encrypted)
+		 enum page_cache_mode pcm, void *caller, bool encrypted,
+		 bool shared)
 {
 	unsigned long offset, vaddr;
 	resource_size_t last_addr;
@@ -248,7 +249,7 @@ __ioremap_caller(resource_size_t phys_addr, unsigned long size,
 	prot = PAGE_KERNEL_IO;
 	if ((io_desc.flags & IORES_MAP_ENCRYPTED) || encrypted)
 		prot = pgprot_encrypted(prot);
-	else if (cc_platform_has(CC_ATTR_GUEST_SHARED_MAPPING_INIT))
+	else if (shared)
 		prot = pgprot_cc_guest(prot);
 
 	switch (pcm) {
@@ -340,7 +341,8 @@ void __iomem *ioremap(resource_size_t phys_addr, unsigned long size)
 	enum page_cache_mode pcm = _PAGE_CACHE_MODE_UC_MINUS;
 
 	return __ioremap_caller(phys_addr, size, pcm,
-				__builtin_return_address(0), false);
+				__builtin_return_address(0), false,
+				false);
 }
 EXPORT_SYMBOL(ioremap);
 
@@ -373,7 +375,8 @@ void __iomem *ioremap_uc(resource_size_t phys_addr, unsigned long size)
 	enum page_cache_mode pcm = _PAGE_CACHE_MODE_UC;
 
 	return __ioremap_caller(phys_addr, size, pcm,
-				__builtin_return_address(0), false);
+				__builtin_return_address(0), false,
+				false);
 }
 EXPORT_SYMBOL_GPL(ioremap_uc);
 
@@ -390,10 +393,29 @@ EXPORT_SYMBOL_GPL(ioremap_uc);
 void __iomem *ioremap_wc(resource_size_t phys_addr, unsigned long size)
 {
 	return __ioremap_caller(phys_addr, size, _PAGE_CACHE_MODE_WC,
-					__builtin_return_address(0), false);
+					__builtin_return_address(0), false,
+					false);
 }
 EXPORT_SYMBOL(ioremap_wc);
 
+/**
+ * ioremap_host_shared - map memory into CPU space shared with host
+ * @phys_addr:	bus address of the memory
+ * @size:	size of the resource to map
+ *
+ * This version of ioremap ensures that the memory is marked shared
+ * with the host. This is useful for confidential guests.
+ *
+ * Must be freed with iounmap.
+ */
+void __iomem *ioremap_host_shared(resource_size_t phys_addr, unsigned long size)
+{
+	return __ioremap_caller(phys_addr, size, _PAGE_CACHE_MODE_UC,
+			__builtin_return_address(0), false,
+			cc_platform_has(CC_ATTR_GUEST_SHARED_MAPPING_INIT));
+}
+EXPORT_SYMBOL(ioremap_host_shared);
+
 /**
  * ioremap_wt	-	map memory into CPU space write through
  * @phys_addr:	bus address of the memory
@@ -407,21 +429,22 @@ EXPORT_SYMBOL(ioremap_wc);
 void __iomem *ioremap_wt(resource_size_t phys_addr, unsigned long size)
 {
 	return __ioremap_caller(phys_addr, size, _PAGE_CACHE_MODE_WT,
-					__builtin_return_address(0), false);
+					__builtin_return_address(0), false,
+					false);
 }
 EXPORT_SYMBOL(ioremap_wt);
 
 void __iomem *ioremap_encrypted(resource_size_t phys_addr, unsigned long size)
 {
 	return __ioremap_caller(phys_addr, size, _PAGE_CACHE_MODE_WB,
-				__builtin_return_address(0), true);
+				__builtin_return_address(0), true, false);
 }
 EXPORT_SYMBOL(ioremap_encrypted);
 
 void __iomem *ioremap_cache(resource_size_t phys_addr, unsigned long size)
 {
 	return __ioremap_caller(phys_addr, size, _PAGE_CACHE_MODE_WB,
-				__builtin_return_address(0), false);
+				__builtin_return_address(0), false, false);
 }
 EXPORT_SYMBOL(ioremap_cache);
 
@@ -430,7 +453,7 @@ void __iomem *ioremap_prot(resource_size_t phys_addr, unsigned long size,
 {
 	return __ioremap_caller(phys_addr, size,
 				pgprot2cachemode(__pgprot(prot_val)),
-				__builtin_return_address(0), false);
+				__builtin_return_address(0), false, false);
 }
 EXPORT_SYMBOL(ioremap_prot);
 
-- 
2.25.1

