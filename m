Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F01D427516
	for <lists+linux-arch@lfdr.de>; Sat,  9 Oct 2021 02:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244277AbhJIAkc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Oct 2021 20:40:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:5261 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244132AbhJIAkF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 Oct 2021 20:40:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10131"; a="213756539"
X-IronPort-AV: E=Sophos;i="5.85,358,1624345200"; 
   d="scan'208";a="213756539"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 17:37:48 -0700
X-IronPort-AV: E=Sophos;i="5.85,358,1624345200"; 
   d="scan'208";a="624905394"
Received: from dmsojoza-mobl3.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.251.135.62])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 17:37:47 -0700
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
Subject: [PATCH v5 11/16] asm/io.h: Add ioremap_host_shared fallback
Date:   Fri,  8 Oct 2021 17:37:06 -0700
Message-Id: <20211009003711.1390019-12-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

This function is for declaring memory that should be shared with
a hypervisor in a confidential guest. If the architecture doesn't
implement it it's just ioremap.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v4:
 * Renamed ioremap_shared to ioremap_host_shared
 * Added documentation for ioremap_host_shared().

 Documentation/driver-api/device-io.rst | 7 +++++++
 arch/alpha/include/asm/io.h            | 2 ++
 arch/mips/include/asm/io.h             | 2 ++
 arch/parisc/include/asm/io.h           | 2 ++
 arch/sparc/include/asm/io_64.h         | 2 ++
 include/asm-generic/io.h               | 5 +++++
 6 files changed, 20 insertions(+)

diff --git a/Documentation/driver-api/device-io.rst b/Documentation/driver-api/device-io.rst
index e9f04b1815d1..9f77a036fc2f 100644
--- a/Documentation/driver-api/device-io.rst
+++ b/Documentation/driver-api/device-io.rst
@@ -429,6 +429,13 @@ of the linear kernel memory area to a regular pointer.
 
 Portable drivers should avoid the use of ioremap_cache().
 
+ioremap_host_shared()
+---------------------
+
+ioremap_host_shared() maps I/O memory so that it can be shared with the host
+in a confidential guest platform. It is mainly used in platforms like
+Trusted Domain Extensions (TDX).
+
 Architecture example
 --------------------
 
diff --git a/arch/alpha/include/asm/io.h b/arch/alpha/include/asm/io.h
index 0fab5ac90775..81952ef50667 100644
--- a/arch/alpha/include/asm/io.h
+++ b/arch/alpha/include/asm/io.h
@@ -283,6 +283,8 @@ static inline void __iomem *ioremap(unsigned long port, unsigned long size)
 }
 
 #define ioremap_wc ioremap
+/* Share memory with host in confidential guest platforms */
+#define ioremap_host_shared ioremap
 #define ioremap_uc ioremap
 
 static inline void iounmap(volatile void __iomem *addr)
diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 6f5c86d2bab4..83f638fb48c5 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -179,6 +179,8 @@ void iounmap(const volatile void __iomem *addr);
 #define ioremap(offset, size)						\
 	ioremap_prot((offset), (size), _CACHE_UNCACHED)
 #define ioremap_uc		ioremap
+/* Share memory with host in confidential guest platforms */
+#define ioremap_host_shared	ioremap
 
 /*
  * ioremap_cache -	map bus memory into CPU space
diff --git a/arch/parisc/include/asm/io.h b/arch/parisc/include/asm/io.h
index 0b5259102319..ef516ee06238 100644
--- a/arch/parisc/include/asm/io.h
+++ b/arch/parisc/include/asm/io.h
@@ -129,6 +129,8 @@ static inline void gsc_writeq(unsigned long long val, unsigned long addr)
  */
 void __iomem *ioremap(unsigned long offset, unsigned long size);
 #define ioremap_wc			ioremap
+/* Share memory with host in confidential guest platforms */
+#define ioremap_host_shared		ioremap
 #define ioremap_uc			ioremap
 
 extern void iounmap(const volatile void __iomem *addr);
diff --git a/arch/sparc/include/asm/io_64.h b/arch/sparc/include/asm/io_64.h
index 5ffa820dcd4d..5b73b877f832 100644
--- a/arch/sparc/include/asm/io_64.h
+++ b/arch/sparc/include/asm/io_64.h
@@ -409,6 +409,8 @@ static inline void __iomem *ioremap(unsigned long offset, unsigned long size)
 #define ioremap_uc(X,Y)			ioremap((X),(Y))
 #define ioremap_wc(X,Y)			ioremap((X),(Y))
 #define ioremap_wt(X,Y)			ioremap((X),(Y))
+/* Share memory with host in confidential guest platforms */
+#define ioremap_host_shared(X, Y)	ioremap((X), (Y))
 static inline void __iomem *ioremap_np(unsigned long offset, unsigned long size)
 {
 	return NULL;
diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index e93375c710b9..26b48fe23769 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -982,6 +982,11 @@ static inline void __iomem *ioremap(phys_addr_t addr, size_t size)
 #define ioremap_wt ioremap
 #endif
 
+/* Share memory with host in confidential guest platforms */
+#ifndef ioremap_host_shared
+#define ioremap_host_shared ioremap
+#endif
+
 /*
  * ioremap_uc is special in that we do require an explicit architecture
  * implementation.  In general you do not want to use this function in a
-- 
2.25.1

