Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743A242751F
	for <lists+linux-arch@lfdr.de>; Sat,  9 Oct 2021 02:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244305AbhJIAki (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Oct 2021 20:40:38 -0400
Received: from mga02.intel.com ([134.134.136.20]:5254 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244246AbhJIAkG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 Oct 2021 20:40:06 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10131"; a="213756548"
X-IronPort-AV: E=Sophos;i="5.85,358,1624345200"; 
   d="scan'208";a="213756548"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 17:37:50 -0700
X-IronPort-AV: E=Sophos;i="5.85,358,1624345200"; 
   d="scan'208";a="624905404"
Received: from dmsojoza-mobl3.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.251.135.62])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 17:37:48 -0700
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
Subject: [PATCH v5 12/16] PCI: Add pci_iomap_host_shared(), pci_iomap_host_shared_range()
Date:   Fri,  8 Oct 2021 17:37:07 -0700
Message-Id: <20211009003711.1390019-13-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

For Confidential VM guests like TDX, the host is untrusted and hence
the devices emulated by the host or any data coming from the host
cannot be trusted. So the drivers that interact with the outside world
have to be hardened by sharing memory with host on need basis
with proper hardening fixes.

For the PCI driver case, to share the memory with the host add
pci_iomap_host_shared() and pci_iomap_host_shared_range() APIs.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 Changes since v4:
 * Replaced "_shared" with "_host_shared" in pci_iomap* APIs
 * Fixed commit log as per review comments.

 include/asm-generic/pci_iomap.h |  6 +++++
 lib/pci_iomap.c                 | 47 +++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/include/asm-generic/pci_iomap.h b/include/asm-generic/pci_iomap.h
index df636c6d8e6c..a4a83c8ab3cf 100644
--- a/include/asm-generic/pci_iomap.h
+++ b/include/asm-generic/pci_iomap.h
@@ -18,6 +18,12 @@ extern void __iomem *pci_iomap_range(struct pci_dev *dev, int bar,
 extern void __iomem *pci_iomap_wc_range(struct pci_dev *dev, int bar,
 					unsigned long offset,
 					unsigned long maxlen);
+extern void __iomem *pci_iomap_host_shared(struct pci_dev *dev, int bar,
+					   unsigned long max);
+extern void __iomem *pci_iomap_host_shared_range(struct pci_dev *dev, int bar,
+						 unsigned long offset,
+						 unsigned long maxlen);
+
 /* Create a virtual mapping cookie for a port on a given PCI device.
  * Do not call this directly, it exists to make it easier for architectures
  * to override */
diff --git a/lib/pci_iomap.c b/lib/pci_iomap.c
index 57bd92f599ee..2816dc8715da 100644
--- a/lib/pci_iomap.c
+++ b/lib/pci_iomap.c
@@ -25,6 +25,11 @@ static void __iomem *map_ioremap_wc(phys_addr_t addr, size_t size)
 	return ioremap_wc(addr, size);
 }
 
+static void __iomem *map_ioremap_host_shared(phys_addr_t addr, size_t size)
+{
+	return ioremap_host_shared(addr, size);
+}
+
 static void __iomem *pci_iomap_range_map(struct pci_dev *dev,
 					 int bar,
 					 unsigned long offset,
@@ -106,6 +111,48 @@ void __iomem *pci_iomap_wc_range(struct pci_dev *dev,
 }
 EXPORT_SYMBOL_GPL(pci_iomap_wc_range);
 
+/**
+ * pci_iomap_host_shared_range - create a virtual shared mapping cookie
+ *				 for a PCI BAR
+ * @dev: PCI device that owns the BAR
+ * @bar: BAR number
+ * @offset: map memory at the given offset in BAR
+ * @maxlen: max length of the memory to map
+ *
+ * Remap a pci device's resources shared in a confidential guest.
+ * For more details see pci_iomap_range's documentation.
+ *
+ * @maxlen specifies the maximum length to map. To get access to
+ * the complete BAR from offset to the end, pass %0 here.
+ */
+void __iomem *pci_iomap_host_shared_range(struct pci_dev *dev, int bar,
+					  unsigned long offset,
+					  unsigned long maxlen)
+{
+	return pci_iomap_range_map(dev, bar, offset, maxlen,
+				   map_ioremap_host_shared, true);
+}
+EXPORT_SYMBOL_GPL(pci_iomap_host_shared_range);
+
+/**
+ * pci_iomap_host_shared - create a virtual shared mapping cookie for a PCI BAR
+ * @dev: PCI device that owns the BAR
+ * @bar: BAR number
+ * @maxlen: length of the memory to map
+ *
+ * See pci_iomap for details. This function creates a shared mapping
+ * with the host for confidential hosts.
+ *
+ * @maxlen specifies the maximum length to map. To get access to the
+ * complete BAR without checking for its length first, pass %0 here.
+ */
+void __iomem *pci_iomap_host_shared(struct pci_dev *dev, int bar,
+			       unsigned long maxlen)
+{
+	return pci_iomap_host_shared_range(dev, bar, 0, maxlen);
+}
+EXPORT_SYMBOL_GPL(pci_iomap_host_shared);
+
 /**
  * pci_iomap - create a virtual mapping cookie for a PCI BAR
  * @dev: PCI device that owns the BAR
-- 
2.25.1

