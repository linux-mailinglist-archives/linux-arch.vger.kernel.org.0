Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B924274DA
	for <lists+linux-arch@lfdr.de>; Sat,  9 Oct 2021 02:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244102AbhJIAjh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Oct 2021 20:39:37 -0400
Received: from mga02.intel.com ([134.134.136.20]:5254 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244070AbhJIAje (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 Oct 2021 20:39:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10131"; a="213756502"
X-IronPort-AV: E=Sophos;i="5.85,358,1624345200"; 
   d="scan'208";a="213756502"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 17:37:37 -0700
X-IronPort-AV: E=Sophos;i="5.85,358,1624345200"; 
   d="scan'208";a="624905354"
Received: from dmsojoza-mobl3.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.251.135.62])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 17:37:36 -0700
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
Subject: [PATCH v5 05/16] x86/tdx: Add helper to do MapGPA hypercall
Date:   Fri,  8 Oct 2021 17:37:00 -0700
Message-Id: <20211009003711.1390019-6-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

MapGPA hypercall is used by TDX guests to request VMM convert the
existing mapping of given GPA address range between private/shared.

tdx_hcall_gpa_intent() is the wrapper used for making MapGPA hypercall.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v4:
 * Added required comments in tdx_hcall_gpa_intent().

Changes since v3:
 * None

Changes since v1:
 * Modified tdx_hcall_gpa_intent() to use _tdx_hypercall() instead of
   tdx_hypercall().

 arch/x86/include/asm/tdx.h | 18 ++++++++++++++++++
 arch/x86/kernel/tdx.c      | 30 ++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index b8f758dbbea9..a931c317e37d 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -56,6 +56,15 @@ struct ve_info {
 	u32 instr_info;
 };
 
+/*
+ * Page mapping type enum. This is software construct not
+ * part of any hardware or VMM ABI.
+ */
+enum tdx_map_type {
+	TDX_MAP_PRIVATE,
+	TDX_MAP_SHARED,
+};
+
 #ifdef CONFIG_INTEL_TDX_GUEST
 
 bool is_tdx_guest(void);
@@ -78,6 +87,9 @@ bool tdx_early_handle_ve(struct pt_regs *regs);
 
 extern phys_addr_t tdx_shared_mask(void);
 
+extern int tdx_hcall_gpa_intent(phys_addr_t gpa, int numpages,
+				enum tdx_map_type map_type);
+
 /*
  * To support I/O port access in decompressor or early kernel init
  * code, since #VE exception handler cannot be used, use paravirt
@@ -145,6 +157,12 @@ static inline bool tdx_early_handle_ve(struct pt_regs *regs) { return false; }
 
 static inline phys_addr_t tdx_shared_mask(void) { return 0; }
 
+static inline int tdx_hcall_gpa_intent(phys_addr_t gpa, int numpages,
+				       enum tdx_map_type map_type)
+{
+	return -ENODEV;
+}
+
 #endif /* CONFIG_INTEL_TDX_GUEST */
 
 #if defined(CONFIG_KVM_GUEST) && defined(CONFIG_INTEL_TDX_GUEST)
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 8a37ab0c6cbf..c3e4cc5d631b 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -17,6 +17,9 @@
 #define TDX_GET_INFO			1
 #define TDX_GET_VEINFO			3
 
+/* TDX hypercall Leaf IDs */
+#define TDVMCALL_MAP_GPA		0x10001
+
 #define VE_IS_IO_OUT(exit_qual)		(((exit_qual) & 8) ? 0 : 1)
 #define VE_GET_IO_SIZE(exit_qual)	(((exit_qual) & 7) + 1)
 #define VE_GET_PORT_NUM(exit_qual)	((exit_qual) >> 16)
@@ -105,6 +108,33 @@ static void tdx_get_info(void)
 	physical_mask &= ~tdx_shared_mask();
 }
 
+/*
+ * Inform the VMM of the guest's intent for this physical page:
+ * shared with the VMM or private to the guest.  The VMM is
+ * expected to change its mapping of the page in response.
+ *
+ * Note: shared->private conversions require further guest
+ * action to accept the page.
+ */
+int tdx_hcall_gpa_intent(phys_addr_t gpa, int numpages,
+			 enum tdx_map_type map_type)
+{
+	u64 ret;
+
+	if (map_type == TDX_MAP_SHARED)
+		gpa |= tdx_shared_mask();
+
+	/*
+	 * Notify VMM about page mapping conversion. More info
+	 * about ABI can be found in TDX Guest-Host-Communication
+	 * Interface (GHCI), sec 3.2.
+	 */
+	ret = _tdx_hypercall(TDVMCALL_MAP_GPA, gpa, PAGE_SIZE * numpages, 0, 0,
+			     NULL);
+
+	return ret ? -EIO : 0;
+}
+
 static __cpuidle void _tdx_halt(const bool irq_disabled, const bool do_sti)
 {
 	u64 ret;
-- 
2.25.1

