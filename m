Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5EF3E0B74
	for <lists+linux-arch@lfdr.de>; Thu,  5 Aug 2021 02:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbhHEAxk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Aug 2021 20:53:40 -0400
Received: from mga02.intel.com ([134.134.136.20]:12125 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234968AbhHEAxi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 4 Aug 2021 20:53:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10066"; a="201215423"
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="201215423"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 17:53:25 -0700
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="437617186"
Received: from mjkendri-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.17.117])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 17:53:22 -0700
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
Subject: [PATCH v4 02/15] x86/tdx: Exclude Shared bit from physical_mask
Date:   Wed,  4 Aug 2021 17:52:05 -0700
Message-Id: <20210805005218.2912076-3-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210805005218.2912076-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210805005218.2912076-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
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

Add a helper, tdg_shared_mask() to generate the mask.  The processor
enumerates its physical address width to include the shared bit, which
means it gets included in __PHYSICAL_MASK by default.

Remove the shared mask from 'physical_mask' since any bits in
tdg_shared_mask() are not used for physical addresses in page table
entries.

Also, note that shared mapping configuration cannot be clubbed between
AMD SME and Intel TDX Guest platforms in common function. SME has
to do it very early in __startup_64() as it sets the bit on all
memory, except what is used for communication. TDX can postpone it,
as it don't need any shared mapping in very early boot.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v3:
 * None

Changes since v1:
 * Fixed format issues in commit log.

 arch/x86/Kconfig           | 1 +
 arch/x86/include/asm/tdx.h | 4 ++++
 arch/x86/kernel/tdx.c      | 9 +++++++++
 3 files changed, 14 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d66a8a2f3c97..8eada36694b6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -872,6 +872,7 @@ config INTEL_TDX_GUEST
 	select X86_X2APIC
 	select SECURITY_LOCKDOWN_LSM
 	select ARCH_HAS_PROTECTED_GUEST
+	select X86_MEM_ENCRYPT_COMMON
 	help
 	  Provide support for running in a trusted domain on Intel processors
 	  equipped with Trusted Domain eXtensions. TDX is a new Intel
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 72154d3f63c2..1e2a1c6a1898 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -77,6 +77,8 @@ int tdg_handle_virtualization_exception(struct pt_regs *regs,
 
 bool tdg_early_handle_ve(struct pt_regs *regs);
 
+extern phys_addr_t tdg_shared_mask(void);
+
 /*
  * To support I/O port access in decompressor or early kernel init
  * code, since #VE exception handler cannot be used, use paravirt
@@ -145,6 +147,8 @@ static inline bool tdx_prot_guest_has(unsigned long flag) { return false; }
 
 static inline bool tdg_early_handle_ve(struct pt_regs *regs) { return false; }
 
+static inline phys_addr_t tdg_shared_mask(void) { return 0; }
+
 #endif /* CONFIG_INTEL_TDX_GUEST */
 
 #ifdef CONFIG_INTEL_TDX_GUEST_KVM
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 0c24439774b4..d316fe33f52f 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -75,6 +75,12 @@ bool tdx_prot_guest_has(unsigned long flag)
 }
 EXPORT_SYMBOL_GPL(tdx_prot_guest_has);
 
+/* The highest bit of a guest physical address is the "sharing" bit */
+phys_addr_t tdg_shared_mask(void)
+{
+	return 1ULL << (td_info.gpa_width - 1);
+}
+
 static void tdg_get_info(void)
 {
 	u64 ret;
@@ -86,6 +92,9 @@ static void tdg_get_info(void)
 
 	td_info.gpa_width = out.rcx & GENMASK(5, 0);
 	td_info.attributes = out.rdx;
+
+	/* Exclude Shared bit from the __PHYSICAL_MASK */
+	physical_mask &= ~tdg_shared_mask();
 }
 
 static __cpuidle void tdg_halt(void)
-- 
2.25.1

