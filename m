Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51BF13E0BA4
	for <lists+linux-arch@lfdr.de>; Thu,  5 Aug 2021 02:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237007AbhHEAx6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Aug 2021 20:53:58 -0400
Received: from mga02.intel.com ([134.134.136.20]:12127 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236666AbhHEAxr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 4 Aug 2021 20:53:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10066"; a="201215437"
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="201215437"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 17:53:34 -0700
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="437617221"
Received: from mjkendri-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.17.117])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 17:53:31 -0700
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
Subject: [PATCH v4 06/15] x86/kvm: Use bounce buffers for TD guest
Date:   Wed,  4 Aug 2021 17:52:09 -0700
Message-Id: <20210805005218.2912076-7-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210805005218.2912076-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210805005218.2912076-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Intel TDX doesn't allow VMM to directly access guest private
memory. Any memory that is required for communication with
VMM must be shared explicitly. The same rule applies for any
any DMA to and fromTDX guest. All DMA pages had to marked as
shared pages. A generic way to achieve this without any changes
to device drivers is to use the SWIOTLB framework.

This method of handling is similar to AMD SEV. So extend this
support for TDX guest as well. Also since there are some common
code between AMD SEV and TDX guest in mem_encrypt_init(), move it
to mem_encrypt_common.c and call AMD specific init function from
it

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
Changes since v3:
 * Rebased on top of Tom Lendacky's protected guest
   changes (https://lore.kernel.org/patchwork/cover/1468760/)

Changes since v1:
 * Removed sme_me_mask check for amd_mem_encrypt_init() in mem_encrypt_init().

 arch/x86/include/asm/mem_encrypt_common.h |  2 ++
 arch/x86/kernel/tdx.c                     |  3 +++
 arch/x86/mm/mem_encrypt.c                 |  5 +----
 arch/x86/mm/mem_encrypt_common.c          | 14 ++++++++++++++
 4 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/mem_encrypt_common.h b/arch/x86/include/asm/mem_encrypt_common.h
index 697bc40a4e3d..48d98a3d64fd 100644
--- a/arch/x86/include/asm/mem_encrypt_common.h
+++ b/arch/x86/include/asm/mem_encrypt_common.h
@@ -8,11 +8,13 @@
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 bool amd_force_dma_unencrypted(struct device *dev);
+void __init amd_mem_encrypt_init(void);
 #else /* CONFIG_AMD_MEM_ENCRYPT */
 static inline bool amd_force_dma_unencrypted(struct device *dev)
 {
 	return false;
 }
+static inline void amd_mem_encrypt_init(void) {}
 #endif /* CONFIG_AMD_MEM_ENCRYPT */
 
 #endif
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index b91740a485d6..01b758496e84 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -13,6 +13,7 @@
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
 #include <linux/sched/signal.h> /* force_sig_fault() */
+#include <linux/swiotlb.h>
 
 /* TDX Module call Leaf IDs */
 #define TDINFO				1
@@ -517,6 +518,8 @@ void __init tdx_early_init(void)
 
 	legacy_pic = &null_legacy_pic;
 
+	swiotlb_force = SWIOTLB_FORCE;
+
 	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "tdg:cpu_hotplug",
 			  NULL, tdg_cpu_offline_prepare);
 
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 1f7a72ce9d66..cab68d8cc5b0 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -491,14 +491,11 @@ static void print_mem_encrypt_feature_info(void)
 }
 
 /* Architecture __weak replacement functions */
-void __init mem_encrypt_init(void)
+void __init amd_mem_encrypt_init(void)
 {
 	if (!sme_me_mask)
 		return;
 
-	/* Call into SWIOTLB to update the SWIOTLB DMA buffers */
-	swiotlb_update_mem_attributes();
-
 	/*
 	 * With SEV, we need to unroll the rep string I/O instructions,
 	 * but SEV-ES supports them through the #VC handler.
diff --git a/arch/x86/mm/mem_encrypt_common.c b/arch/x86/mm/mem_encrypt_common.c
index fdaf09b4a658..2ba19476dc26 100644
--- a/arch/x86/mm/mem_encrypt_common.c
+++ b/arch/x86/mm/mem_encrypt_common.c
@@ -10,6 +10,7 @@
 #include <asm/mem_encrypt_common.h>
 #include <linux/dma-mapping.h>
 #include <linux/protected_guest.h>
+#include <linux/swiotlb.h>
 
 /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
 bool force_dma_unencrypted(struct device *dev)
@@ -22,3 +23,16 @@ bool force_dma_unencrypted(struct device *dev)
 
 	return false;
 }
+
+/* Architecture __weak replacement functions */
+void __init mem_encrypt_init(void)
+{
+	/*
+	 * For TDX guest or SEV/SME, call into SWIOTLB to update
+	 * the SWIOTLB DMA buffers
+	 */
+	if (sme_me_mask || prot_guest_has(PATTR_GUEST_MEM_ENCRYPT))
+		swiotlb_update_mem_attributes();
+
+	amd_mem_encrypt_init();
+}
-- 
2.25.1

