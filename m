Return-Path: <linux-arch+bounces-595-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E55AE800AB1
	for <lists+linux-arch@lfdr.de>; Fri,  1 Dec 2023 13:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0F2E1C20F46
	for <lists+linux-arch@lfdr.de>; Fri,  1 Dec 2023 12:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B652554D;
	Fri,  1 Dec 2023 12:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BO162Ot2"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907B4170E
	for <linux-arch@vger.kernel.org>; Fri,  1 Dec 2023 04:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701433025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aIU4mh01NIo3J+0bv0Z7Ok8zfrU9Sy5KFoYboE67XEg=;
	b=BO162Ot2r3i6t0D+IGJdiws8Uq+tp8nza+hMHsmiaTi2+AD+9DOJTw6hCpI3NOHv5BUaZ/
	JRc46Xc901oygR5M39Ckr8C+fe1G934lkf7p+owHYvT5OdXl1v8W95YuIuPNKidfp0uSRo
	CQo9hKpX9vLHa6JpL0YVpldIkoAIr8U=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-EdP2Xf6GMXetcTFGyaaZlg-1; Fri, 01 Dec 2023 07:17:04 -0500
X-MC-Unique: EdP2Xf6GMXetcTFGyaaZlg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-423f2ad71c9so5378131cf.0
        for <linux-arch@vger.kernel.org>; Fri, 01 Dec 2023 04:17:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701433023; x=1702037823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aIU4mh01NIo3J+0bv0Z7Ok8zfrU9Sy5KFoYboE67XEg=;
        b=t1d8gkqhOaAE0unOmM1bSCgOEiy9zXfY7VFU5zkgvAoUIGvBVtLLgtpKOZ3l/fw20S
         aSwclqjTfcNQ1vDMXRAasjBb4grKnYuN3Ex2iyH+5lyj+IUoA8zoAbUApKaKLYoWilGL
         YC6ypIFP6P5zatlRd20+5w4l6evS1yowiQVhkJhswugkGR3IauBP6yDJZjPFapUB0OhL
         TaB2zCJN5jVczpwYIPp5vJKOGtOf0AN9FYfvsrATMIW6WKX+en0HP34Xh7286rtWkrD1
         10NmP4sX7O87gSBL9iFCEM8LegkjuvebMqY8WUF6ZClJMmT/tUNskVIyt1y0ZF6fQrqb
         w1Mg==
X-Gm-Message-State: AOJu0YwdQZ0UFR2183cdt/QpklPSYeYxYJzWLEiMoo5xnOiA71BboJzv
	2WXLIktGw/3sz90KOQyfKueczCtmYLzq2PM5/tnYx2oWuJ16e3KPGgticWQLzmVqwJYg/axO48Y
	f7lO0oyhqxkPTeM35uplHNA==
X-Received: by 2002:a05:622a:5505:b0:423:a6c8:7db9 with SMTP id fj5-20020a05622a550500b00423a6c87db9mr24035883qtb.6.1701433023440;
        Fri, 01 Dec 2023 04:17:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQfSS2UW2A54VtKLLtAF4bxHgHalN5nM46dpZI44qbzDLU3S4OQPiukfxEaRXrK+nRrdI9pQ==
X-Received: by 2002:a05:622a:5505:b0:423:a6c8:7db9 with SMTP id fj5-20020a05622a550500b00423a6c87db9mr24035847qtb.6.1701433023157;
        Fri, 01 Dec 2023 04:17:03 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32e2:4e00:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id b19-20020ac87553000000b00423b8a53641sm1426528qtr.29.2023.12.01.04.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 04:17:02 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Uladzislau Koshchanka <koshchanka@gmail.com>,
	NeilBrown <neilb@suse.de>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	John Sanpe <sanpeqf@gmail.com>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Philipp Stanner <pstanner@redhat.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	David Gow <davidgow@google.com>,
	Yury Norov <yury.norov@gmail.com>,
	"wuqiang.matt" <wuqiang.matt@bytedance.com>,
	Jason Baron <jbaron@akamai.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	dakr@redhat.com
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH v2 4/4] lib, pci: unify generic pci_iounmap()
Date: Fri,  1 Dec 2023 13:16:22 +0100
Message-ID: <20231201121622.16343-5-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231201121622.16343-1-pstanner@redhat.com>
References: <20231201121622.16343-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The implementation of pci_iounmap() is currently scattered over two
files, drivers/pci/iounmap.c and lib/iomap.c. Additionally,
architectures can define their own version.

Besides one unified version being desirable in the first place, the old
version in drivers/pci/iounmap.c contained a bug and could leak memory
mappings. The bug was that #ifdef ARCH_HAS_GENERIC_IOPORT_MAP should not
have guarded iounmap(p); in addition to the preceding code.

To have only one version, it's necessary to create a helper function,
iomem_is_ioport(), that tells pci_iounmap() whether the passed address
points to an ioport or normal memory.

iomem_is_ioport() can be provided through three different ways:
  1. The architecture itself provides it.
  2. As a default version in include/asm-generic/io.h for those
     architectures that don't use CONFIG_GENERIC_IOMAP, but also don't
     provide their own version of iomem_is_ioport().
  3. As a default version in lib/iomap.c for those architectures that
     define and use CONFIG_GENERIC_IOMAP (currently, only x86 really
     uses the functions in lib/iomap.c)

Create a unified version of pci_iounmap() in drivers/pci/iomap.c.
Provide the function iomem_is_ioport() in include/asm-generic/io.h and
lib/iomap.c.

Remove the CONFIG_GENERIC_IOMAP guard around
ARCH_WANTS_GENERIC_PCI_IOUNMAP so that configs that set
CONFIG_GENERIC_PCI_IOMAP without CONFIG_GENERIC_IOMAP still get the
function.

Fixes: 316e8d79a095 ("pci_iounmap'2: Electric Boogaloo: try to make sense of it all")
Suggested-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/iomap.c      | 40 +++++++++++-----------------------------
 include/asm-generic/io.h | 37 ++++++++++++++++++++++++++++++++++---
 lib/iomap.c              | 16 +++++++++-------
 3 files changed, 54 insertions(+), 39 deletions(-)

diff --git a/drivers/pci/iomap.c b/drivers/pci/iomap.c
index 0a9d503ba533..cb7f86371b7d 100644
--- a/drivers/pci/iomap.c
+++ b/drivers/pci/iomap.c
@@ -135,42 +135,24 @@ void __iomem *pci_iomap_wc(struct pci_dev *dev, int bar, unsigned long maxlen)
 EXPORT_SYMBOL_GPL(pci_iomap_wc);
 
 /*
- * pci_iounmap() somewhat illogically comes from lib/iomap.c for the
- * CONFIG_GENERIC_IOMAP case, because that's the code that knows about
- * the different IOMAP ranges.
+ * Generic version of pci_iounmap() that is used if the architecture does not
+ * provide its own version.
  *
- * But if the architecture does not use the generic iomap code, and if
- * it has _not_ defined it's own private pci_iounmap function, we define
- * it here.
- *
- * NOTE! This default implementation assumes that if the architecture
- * support ioport mapping (HAS_IOPORT_MAP), the ioport mapping will
- * be fixed to the range [ PCI_IOBASE, PCI_IOBASE+IO_SPACE_LIMIT [,
- * and does not need unmapping with 'ioport_unmap()'.
- *
- * If you have different rules for your architecture, you need to
- * implement your own pci_iounmap() that knows the rules for where
- * and how IO vs MEM get mapped.
- *
- * This code is odd, and the ARCH_HAS/ARCH_WANTS #define logic comes
- * from legacy <asm-generic/io.h> header file behavior. In particular,
- * it would seem to make sense to do the iounmap(p) for the non-IO-space
- * case here regardless, but that's not what the old header file code
- * did. Probably incorrectly, but this is meant to be bug-for-bug
- * compatible.
+ * If you have special rules for your architecture, you need to implement your
+ * own pci_iounmap() in ARCH/asm/io.h that knows the rules for where and how IO
+ * vs MEM get mapped.
  */
 #if defined(ARCH_WANTS_GENERIC_PCI_IOUNMAP)
 
-void pci_iounmap(struct pci_dev *dev, void __iomem *p)
+void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
 {
-#ifdef ARCH_HAS_GENERIC_IOPORT_MAP
-	uintptr_t start = (uintptr_t) PCI_IOBASE;
-	uintptr_t addr = (uintptr_t) p;
-
-	if (addr >= start && addr < start + IO_SPACE_LIMIT)
+#ifdef CONFIG_HAS_IOPORT
+	if (iomem_is_ioport(addr)) {
+		ioport_unmap(addr);
 		return;
-	iounmap(p);
+	}
 #endif
+	iounmap(addr);
 }
 EXPORT_SYMBOL(pci_iounmap);
 
diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index bac63e874c7b..4177d6b97e0b 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -1129,11 +1129,42 @@ extern void ioport_unmap(void __iomem *p);
 #endif /* CONFIG_GENERIC_IOMAP */
 #endif /* CONFIG_HAS_IOPORT_MAP */
 
-#ifndef CONFIG_GENERIC_IOMAP
 #ifndef pci_iounmap
+#define pci_iounmap pci_iounmap
 #define ARCH_WANTS_GENERIC_PCI_IOUNMAP
-#endif
-#endif
+#endif /* pci_iounmap */
+
+
+/*
+ * This function is a helper only needed for the generic pci_iounmap().
+ * It's provided here if the architecture does not select GENERIC_IOMAP and does
+ * not provide its own version.
+ */
+#ifdef CONFIG_HAS_IOPORT
+#ifndef iomem_is_ioport /* i.e., if the architecture hasn't defined its own. */
+#define iomem_is_ioport iomem_is_ioport
+
+#ifndef CONFIG_GENERIC_IOMAP
+static inline bool iomem_is_ioport(void __iomem *addr)
+{
+	unsigned long port = (unsigned long __force)addr;
+
+	// TODO: do we have to take IO_SPACE_LIMIT and PCI_IOBASE into account
+	// similar as in ioport_map() ?
+
+	if (port > MMIO_UPPER_LIMIT)
+		return false;
+
+	return true;
+}
+#else /* CONFIG_GENERIC_IOMAP. Version from lib/iomap.c will be used. */
+bool iomem_is_ioport(void __iomem *addr);
+#define ARCH_WANTS_GENERIC_IOMEM_IS_IOPORT
+#endif /* CONFIG_GENERIC_IOMAP */
+
+#endif /* iomem_is_ioport */
+#endif /* CONFIG_HAS_IOPORT */
+
 
 #ifndef xlate_dev_mem_ptr
 #define xlate_dev_mem_ptr xlate_dev_mem_ptr
diff --git a/lib/iomap.c b/lib/iomap.c
index 4f8b31baa575..adaf6246f892 100644
--- a/lib/iomap.c
+++ b/lib/iomap.c
@@ -418,12 +418,14 @@ EXPORT_SYMBOL(ioport_map);
 EXPORT_SYMBOL(ioport_unmap);
 #endif /* CONFIG_HAS_IOPORT_MAP */
 
-#ifdef CONFIG_PCI
-/* Hide the details if this is a MMIO or PIO address space and just do what
- * you expect in the correct way. */
-void pci_iounmap(struct pci_dev *dev, void __iomem * addr)
+#if defined(ARCH_WANTS_GENERIC_IOMEM_IS_IOPORT)
+bool iomem_is_ioport(void __iomem *addr)
 {
-	IO_COND(addr, /* nothing */, iounmap(addr));
+	unsigned long port = (unsigned long __force)addr;
+
+	if (port > PIO_OFFSET && port < PIO_RESERVED)
+		return true;
+
+	return false;
 }
-EXPORT_SYMBOL(pci_iounmap);
-#endif /* CONFIG_PCI */
+#endif /* ARCH_WANTS_GENERIC_IOMEM_IS_IOPORT */
-- 
2.43.0


