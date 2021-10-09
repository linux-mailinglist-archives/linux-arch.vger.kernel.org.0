Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F5B427511
	for <lists+linux-arch@lfdr.de>; Sat,  9 Oct 2021 02:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244218AbhJIAk2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Oct 2021 20:40:28 -0400
Received: from mga02.intel.com ([134.134.136.20]:5260 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244224AbhJIAkB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 Oct 2021 20:40:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10131"; a="213756532"
X-IronPort-AV: E=Sophos;i="5.85,358,1624345200"; 
   d="scan'208";a="213756532"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 17:37:47 -0700
X-IronPort-AV: E=Sophos;i="5.85,358,1624345200"; 
   d="scan'208";a="624905390"
Received: from dmsojoza-mobl3.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.251.135.62])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 17:37:45 -0700
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
Subject: [PATCH v5 10/16] PCI: Consolidate pci_iomap_range(), pci_iomap_wc_range()
Date:   Fri,  8 Oct 2021 17:37:05 -0700
Message-Id: <20211009003711.1390019-11-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

pci_iomap_range() and pci_iomap_wc_range() are currently duplicated
code, except that the _wc variant does not support IO ports. So,
implement them using a common helper, pci_iomap_range_map().

Also add wrappers for the maps because some architectures implement
ioremap and friends with macros.

This will allow to add more variants without excessive code
duplication. This patch has no functional changes.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
Changes since v4:
 * Rebased on top of Tom Lendacky's CC guest
   changes (https://www.spinics.net/lists/linux-tip-commits/msg58716.html)
 * Fixed commit log as per Bjorns comments.
 * Added "support_io" argument to pci_iomap_range_map() to support
    __pci_ioport_map() only in pci_iomap_range().

 lib/pci_iomap.c | 86 ++++++++++++++++++++++++++++---------------------
 1 file changed, 49 insertions(+), 37 deletions(-)

diff --git a/lib/pci_iomap.c b/lib/pci_iomap.c
index 2d3eb1cb73b8..57bd92f599ee 100644
--- a/lib/pci_iomap.c
+++ b/lib/pci_iomap.c
@@ -10,6 +10,51 @@
 #include <linux/export.h>
 
 #ifdef CONFIG_PCI
+
+/*
+ * Callback wrappers because some architectures define ioremap et.al.
+ * as macros.
+ */
+static void __iomem *map_ioremap(phys_addr_t addr, size_t size)
+{
+	return ioremap(addr, size);
+}
+
+static void __iomem *map_ioremap_wc(phys_addr_t addr, size_t size)
+{
+	return ioremap_wc(addr, size);
+}
+
+static void __iomem *pci_iomap_range_map(struct pci_dev *dev,
+					 int bar,
+					 unsigned long offset,
+					 unsigned long maxlen,
+					 void __iomem *(*mapm)(phys_addr_t,
+							       size_t),
+					 bool support_io)
+{
+	resource_size_t start = pci_resource_start(dev, bar);
+	resource_size_t len = pci_resource_len(dev, bar);
+	unsigned long flags = pci_resource_flags(dev, bar);
+
+	if (len <= offset || !start)
+		return NULL;
+	len -= offset;
+	start += offset;
+	if (maxlen && len > maxlen)
+		len = maxlen;
+	if (flags & IORESOURCE_IO) {
+		if (support_io)
+			return __pci_ioport_map(dev, start, len);
+
+		return NULL;
+	}
+	if (flags & IORESOURCE_MEM)
+		return mapm(start, len);
+	/* What? */
+	return NULL;
+}
+
 /**
  * pci_iomap_range - create a virtual mapping cookie for a PCI BAR
  * @dev: PCI device that owns the BAR
@@ -30,22 +75,8 @@ void __iomem *pci_iomap_range(struct pci_dev *dev,
 			      unsigned long offset,
 			      unsigned long maxlen)
 {
-	resource_size_t start = pci_resource_start(dev, bar);
-	resource_size_t len = pci_resource_len(dev, bar);
-	unsigned long flags = pci_resource_flags(dev, bar);
-
-	if (len <= offset || !start)
-		return NULL;
-	len -= offset;
-	start += offset;
-	if (maxlen && len > maxlen)
-		len = maxlen;
-	if (flags & IORESOURCE_IO)
-		return __pci_ioport_map(dev, start, len);
-	if (flags & IORESOURCE_MEM)
-		return ioremap(start, len);
-	/* What? */
-	return NULL;
+	return pci_iomap_range_map(dev, bar, offset, maxlen,
+				   map_ioremap, true);
 }
 EXPORT_SYMBOL(pci_iomap_range);
 
@@ -70,27 +101,8 @@ void __iomem *pci_iomap_wc_range(struct pci_dev *dev,
 				 unsigned long offset,
 				 unsigned long maxlen)
 {
-	resource_size_t start = pci_resource_start(dev, bar);
-	resource_size_t len = pci_resource_len(dev, bar);
-	unsigned long flags = pci_resource_flags(dev, bar);
-
-
-	if (flags & IORESOURCE_IO)
-		return NULL;
-
-	if (len <= offset || !start)
-		return NULL;
-
-	len -= offset;
-	start += offset;
-	if (maxlen && len > maxlen)
-		len = maxlen;
-
-	if (flags & IORESOURCE_MEM)
-		return ioremap_wc(start, len);
-
-	/* What? */
-	return NULL;
+	return pci_iomap_range_map(dev, bar, offset, maxlen,
+				   map_ioremap_wc, false);
 }
 EXPORT_SYMBOL_GPL(pci_iomap_wc_range);
 
-- 
2.25.1

