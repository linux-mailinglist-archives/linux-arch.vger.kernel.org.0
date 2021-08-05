Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA363E0B72
	for <lists+linux-arch@lfdr.de>; Thu,  5 Aug 2021 02:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbhHEAxj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Aug 2021 20:53:39 -0400
Received: from mga02.intel.com ([134.134.136.20]:12119 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234733AbhHEAxg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 4 Aug 2021 20:53:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10066"; a="201215417"
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="201215417"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 17:53:22 -0700
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="437617174"
Received: from mjkendri-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.17.117])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 17:53:20 -0700
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
Subject: [PATCH v4 01/15] x86/mm: Move force_dma_unencrypted() to common code
Date:   Wed,  4 Aug 2021 17:52:04 -0700
Message-Id: <20210805005218.2912076-2-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210805005218.2912076-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210805005218.2912076-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Intel TDX doesn't allow VMM to access guest private memory.
Any memory that is required for communication with VMM must
be shared explicitly by setting the bit in page table entry.
After setting the shared bit, the conversion must be completed
with MapGPA hypercall. You can find details about MapGPA
hypercall in [1], sec 3.2.

The call informs VMM about the conversion between
private/shared mappings. The shared memory is similar to
unencrypted memory in AMD SME/SEV terminology but the
underlying process of sharing/un-sharing the memory is
different for Intel TDX guest platform.

SEV assumes that I/O devices can only do DMA to "decrypted"
physical addresses without the C-bit set. In order for the CPU
to interact with this memory, the CPU needs a decrypted mapping.
To add this support, AMD SME code forces force_dma_unencrypted()
to return true for platforms that support AMD SEV feature. It
will be used for DMA memory allocation API to trigger
set_memory_decrypted() for platforms that support AMD SEV
feature.

TDX is similar. So, to communicate with I/O devices, related
pages need to be marked as shared. As mentioned above, shared
memory in TDX architecture is similar to decrypted memory in
AMD SME/SEV. So similar to AMD SEV, force_dma_unencrypted() has
to forced to return true. This support is added in other patches
in this series.

So move force_dma_unencrypted() out of AMD specific code and call
AMD specific (amd_force_dma_unencrypted()) initialization function
from it. force_dma_unencrypted() will be modified by later patches
to include Intel TDX guest platform specific initialization.

Also, introduce new config option X86_MEM_ENCRYPT_COMMON that has
to be selected by all x86 memory encryption features. This will be
selected by both AMD SEV and Intel TDX guest config options.

This is preparation for TDX changes in DMA code and it has no
functional change.

[1] - https://software.intel.com/content/dam/develop/external/us/en/documents/intel-tdx-guest-hypervisor-communication-interface.pdf

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Change since v3:
 * None

Changes since v1:
 * Removed sev_active(), sme_active() checks in force_dma_unencrypted().

 arch/x86/Kconfig                          |  8 ++++++--
 arch/x86/include/asm/mem_encrypt_common.h | 18 ++++++++++++++++++
 arch/x86/mm/Makefile                      |  2 ++
 arch/x86/mm/mem_encrypt.c                 |  3 ++-
 arch/x86/mm/mem_encrypt_common.c          | 17 +++++++++++++++++
 5 files changed, 45 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/include/asm/mem_encrypt_common.h
 create mode 100644 arch/x86/mm/mem_encrypt_common.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b500f2afacce..d66a8a2f3c97 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1524,16 +1524,20 @@ config X86_CPA_STATISTICS
 	  helps to determine the effectiveness of preserving large and huge
 	  page mappings when mapping protections are changed.
 
+config X86_MEM_ENCRYPT_COMMON
+	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
+	select DYNAMIC_PHYSICAL_MASK
+	def_bool n
+
 config AMD_MEM_ENCRYPT
 	bool "AMD Secure Memory Encryption (SME) support"
 	depends on X86_64 && CPU_SUP_AMD
 	select DMA_COHERENT_POOL
-	select DYNAMIC_PHYSICAL_MASK
 	select ARCH_USE_MEMREMAP_PROT
-	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
 	select INSTRUCTION_DECODER
 	select ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
 	select ARCH_HAS_PROTECTED_GUEST
+	select X86_MEM_ENCRYPT_COMMON
 	help
 	  Say yes to enable support for the encryption of system memory.
 	  This requires an AMD processor that supports Secure Memory
diff --git a/arch/x86/include/asm/mem_encrypt_common.h b/arch/x86/include/asm/mem_encrypt_common.h
new file mode 100644
index 000000000000..697bc40a4e3d
--- /dev/null
+++ b/arch/x86/include/asm/mem_encrypt_common.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2020 Intel Corporation */
+#ifndef _ASM_X86_MEM_ENCRYPT_COMMON_H
+#define _ASM_X86_MEM_ENCRYPT_COMMON_H
+
+#include <linux/mem_encrypt.h>
+#include <linux/device.h>
+
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+bool amd_force_dma_unencrypted(struct device *dev);
+#else /* CONFIG_AMD_MEM_ENCRYPT */
+static inline bool amd_force_dma_unencrypted(struct device *dev)
+{
+	return false;
+}
+#endif /* CONFIG_AMD_MEM_ENCRYPT */
+
+#endif
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 5864219221ca..b31cb52bf1bd 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -52,6 +52,8 @@ obj-$(CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS)	+= pkeys.o
 obj-$(CONFIG_RANDOMIZE_MEMORY)			+= kaslr.o
 obj-$(CONFIG_PAGE_TABLE_ISOLATION)		+= pti.o
 
+obj-$(CONFIG_X86_MEM_ENCRYPT_COMMON)	+= mem_encrypt_common.o
+
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_identity.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_boot.o
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 7d3b2c6f5f88..1f7a72ce9d66 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -31,6 +31,7 @@
 #include <asm/processor-flags.h>
 #include <asm/msr.h>
 #include <asm/cmdline.h>
+#include <asm/mem_encrypt_common.h>
 
 #include "mm_internal.h"
 
@@ -415,7 +416,7 @@ bool amd_prot_guest_has(unsigned int attr)
 EXPORT_SYMBOL(amd_prot_guest_has);
 
 /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
-bool force_dma_unencrypted(struct device *dev)
+bool amd_force_dma_unencrypted(struct device *dev)
 {
 	/*
 	 * For SEV, all DMA must be to unencrypted addresses.
diff --git a/arch/x86/mm/mem_encrypt_common.c b/arch/x86/mm/mem_encrypt_common.c
new file mode 100644
index 000000000000..f063c885b0a5
--- /dev/null
+++ b/arch/x86/mm/mem_encrypt_common.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Memory Encryption Support Common Code
+ *
+ * Copyright (C) 2021 Intel Corporation
+ *
+ * Author: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
+ */
+
+#include <asm/mem_encrypt_common.h>
+#include <linux/dma-mapping.h>
+
+/* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
+bool force_dma_unencrypted(struct device *dev)
+{
+	return amd_force_dma_unencrypted(dev);
+}
-- 
2.25.1

