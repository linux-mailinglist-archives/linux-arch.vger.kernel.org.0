Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA2642753F
	for <lists+linux-arch@lfdr.de>; Sat,  9 Oct 2021 02:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244213AbhJIAlN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Oct 2021 20:41:13 -0400
Received: from mga02.intel.com ([134.134.136.20]:5260 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244107AbhJIAkv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 Oct 2021 20:40:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10131"; a="213756576"
X-IronPort-AV: E=Sophos;i="5.85,358,1624345200"; 
   d="scan'208";a="213756576"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 17:37:56 -0700
X-IronPort-AV: E=Sophos;i="5.85,358,1624345200"; 
   d="scan'208";a="624905446"
Received: from dmsojoza-mobl3.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.251.135.62])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 17:37:55 -0700
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
Subject: [PATCH v5 16/16] x86/tdx: Add cmdline option to force use of ioremap_host_shared
Date:   Fri,  8 Oct 2021 17:37:11 -0700
Message-Id: <20211009003711.1390019-17-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add a command line option to force all the enabled drivers to use
shared memory mappings. This will be useful when enabling new drivers
in the confidential guest without making all the required changes to
use shared mappings in it.

Note that this might also allow other non explicitly enabled drivers
to interact with the host, which could cause other security risks.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 .../admin-guide/kernel-parameters.rst         |  1 +
 .../admin-guide/kernel-parameters.txt         | 12 ++++++++++++
 arch/x86/include/asm/io.h                     |  2 ++
 arch/x86/mm/ioremap.c                         | 19 ++++++++++++++++++-
 4 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
index 01ba293a2d70..02e6aae1ad68 100644
--- a/Documentation/admin-guide/kernel-parameters.rst
+++ b/Documentation/admin-guide/kernel-parameters.rst
@@ -102,6 +102,7 @@ parameter is applicable::
 	ARM	ARM architecture is enabled.
 	ARM64	ARM64 architecture is enabled.
 	AX25	Appropriate AX.25 support is enabled.
+	CCG	Confidential Computing guest is enabled.
 	CLK	Common clock infrastructure is enabled.
 	CMA	Contiguous Memory Area support is enabled.
 	DRM	Direct Rendering Management support is enabled.
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 91ba391f9b32..0af19cb1a28c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2076,6 +2076,18 @@
 			1 - Bypass the IOMMU for DMA.
 			unset - Use value of CONFIG_IOMMU_DEFAULT_PASSTHROUGH.
 
+	ioremap_force_shared= [X86_64, CCG]
+			Force the kernel to use shared memory mappings which do
+			not use ioremap_host_shared/pcimap_host_shared to opt-in
+			to shared mappings with the host. This feature is mainly
+			used by a confidential guest when enabling new drivers
+			without proper shared memory related changes. Please note
+			that this option might also allow other non explicitly
+			enabled drivers to interact with the host in confidential
+			guest, which could cause other security risks. This option
+			will also cause BIOS data structures to be shared with the
+			host, which might open security holes.
+
 	io7=		[HW] IO7 for Marvel-based Alpha systems
 			See comment before marvel_specify_io7 in
 			arch/alpha/kernel/core_marvel.c.
diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 521b239c013f..98836c2833e4 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -423,6 +423,8 @@ static inline bool phys_mem_access_encrypted(unsigned long phys_addr,
 }
 #endif
 
+extern bool ioremap_force_shared;
+
 /**
  * iosubmit_cmds512 - copy data to single MMIO location, in 512-bit units
  * @dst: destination, in MMIO space (must be 512-bit aligned)
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index a83a69045f61..d0d2bf5116bc 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -28,6 +28,7 @@
 #include <asm/memtype.h>
 #include <asm/setup.h>
 #include <asm/tdx.h>
+#include <asm/cmdline.h>
 
 #include "physaddr.h"
 
@@ -162,6 +163,17 @@ static void __ioremap_check_mem(resource_size_t addr, unsigned long size,
 	__ioremap_check_other(addr, desc);
 }
 
+/*
+ * Normally only drivers that are hardened for use in confidential guests
+ * force shared mappings. But if device filtering is disabled other
+ * devices can be loaded, and these need shared mappings too. This
+ * variable is set to true if these filters are disabled.
+ *
+ * Note this has some side effects, e.g. various BIOS tables
+ * get shared too which is risky.
+ */
+bool ioremap_force_shared;
+
 /*
  * Remap an arbitrary physical address space into the kernel virtual
  * address space. It transparently creates kernel huge I/O mapping when
@@ -249,7 +261,7 @@ __ioremap_caller(resource_size_t phys_addr, unsigned long size,
 	prot = PAGE_KERNEL_IO;
 	if ((io_desc.flags & IORES_MAP_ENCRYPTED) || encrypted)
 		prot = pgprot_encrypted(prot);
-	else if (shared)
+	else if (shared || ioremap_force_shared)
 		prot = pgprot_cc_guest(prot);
 
 	switch (pcm) {
@@ -847,6 +859,11 @@ void __init early_ioremap_init(void)
 	WARN_ON((fix_to_virt(0) + PAGE_SIZE) & ((1 << PMD_SHIFT) - 1));
 #endif
 
+	/* Parse cmdline params for ioremap_force_shared */
+	if (cmdline_find_option_bool(boot_command_line,
+				     "ioremap_force_shared"))
+		ioremap_force_shared = 1;
+
 	early_ioremap_setup();
 
 	pmd = early_ioremap_pmd(fix_to_virt(FIX_BTMAP_BEGIN));
-- 
2.25.1

