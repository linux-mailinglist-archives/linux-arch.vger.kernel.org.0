Return-Path: <linux-arch+bounces-632-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28504803320
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 13:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82E8AB20ACF
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 12:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EF0241EC;
	Mon,  4 Dec 2023 12:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fiINL/X+"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEAD90
	for <linux-arch@vger.kernel.org>; Mon,  4 Dec 2023 04:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701693553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vSfJU5AxXUdyVx/htC/H0+cAAvvT3AP5StW1LLbD/a8=;
	b=fiINL/X+toFrkMGdAorzpH4S4Sn8z6B7u+6eud8fxecpzrjZ8p6g4rs54Xzz5umBtkWMwb
	D+ykk9iuVkLpGC8Aaq26ZqOKRf9HgBNINM2ABXEYvOOg/vxZTjLAGSQTwBAck0wPDmAITT
	6CHa0VxDc1FwgcbX77itrFtWPKFtH4M=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-n8MDxcPDP-K_hhdXGZ33sg-1; Mon, 04 Dec 2023 07:39:12 -0500
X-MC-Unique: n8MDxcPDP-K_hhdXGZ33sg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2c9947db19bso8175721fa.1
        for <linux-arch@vger.kernel.org>; Mon, 04 Dec 2023 04:39:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701693551; x=1702298351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vSfJU5AxXUdyVx/htC/H0+cAAvvT3AP5StW1LLbD/a8=;
        b=Sw1EsmEbrC5n6Q5MT+dW9QlTCbdIjesgXL5w/lg2gNF58Z4vXO/sUBoigPp7ZgqCB7
         BZzwOJi2zCbaUoOP9aHfT+YZLXkj5U/M2Uhc+sVq6ADHYpnBBNvrre49Gm9VFhZDeJwQ
         Hi4/CUXWj69dlQbovaKURzkuRLg7DQYDzvf2nQHYzMzp4TgkcMxJeou3pgmc1sQFmrHd
         sSRgX4nbcUq4nryvmzm+yOBHoIuNTZ49cSacFdNaGhKtRL2SYy8M3urlYabAOFdUFOa5
         kgQukiH77B5tqbwoHGfDIx7dxK660rNz+tEY9fA/yIaJVpTUXtWqmxc2/PSnSsmKcBK9
         66TA==
X-Gm-Message-State: AOJu0Yz6E5K0/jCV9ghw+FbqmqL00oGXiDGNdOdfxbMB1HVTYYqMbu6v
	g35n7xg2bdb47rkH+Ea8qL7PIAiC7s9EV+HBs8d2xfKzPQfUj0fZob+4wHXoskQVpEKZawoEzBl
	N3ASSqRtJuyPzttYsTKEFyw==
X-Received: by 2002:a05:651c:210d:b0:2ca:350:9339 with SMTP id a13-20020a05651c210d00b002ca03509339mr1723630ljq.3.1701693550553;
        Mon, 04 Dec 2023 04:39:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbQtiSWPYoXrcD/+ujrZu015mcHRIXmc5QzHlOST7P0gs0l7/hRhl0lchBMHyGlaPxqTGfXA==
X-Received: by 2002:a05:651c:210d:b0:2ca:350:9339 with SMTP id a13-20020a05651c210d00b002ca03509339mr1723612ljq.3.1701693550276;
        Mon, 04 Dec 2023 04:39:10 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32c8:b00:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id d4-20020a05600c3ac400b0040b538047b4sm18355935wms.3.2023.12.04.04.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 04:39:09 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	NeilBrown <neilb@suse.de>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Uladzislau Koshchanka <koshchanka@gmail.com>,
	John Sanpe <sanpeqf@gmail.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Philipp Stanner <pstanner@redhat.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	David Gow <davidgow@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"wuqiang.matt" <wuqiang.matt@bytedance.com>,
	Yury Norov <yury.norov@gmail.com>,
	Jason Baron <jbaron@akamai.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	dakr@redhat.com
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH v3 5/5] lib, pci: unify generic pci_iounmap()
Date: Mon,  4 Dec 2023 13:38:32 +0100
Message-ID: <20231204123834.29247-6-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231204123834.29247-1-pstanner@redhat.com>
References: <20231204123834.29247-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The implementation of pci_iounmap() is currently scattered over two
files, drivers/pci/iomap.c and lib/iomap.c. Additionally,
architectures can define their own version.

To have only one version, it's necessary to create a helper function,
iomem_is_ioport(), that tells pci_iounmap() whether the passed address
points to an ioport or normal memory.

iomem_is_ioport() can be provided through two different ways:
  1. The architecture itself provides it. As of today, the version
     coming from lib/iomap.c de facto is the x86-specific version and
     comes into play when CONFIG_GENERIC_IOMAP is selected. This rather
     confusing naming is an artifact left by the removal of IA64.
  2. As a default version in include/asm-generic/io.h for those
     architectures that don't use CONFIG_GENERIC_IOMAP, but also don't
     provide their own version of iomem_is_ioport().

Once all architectures that support ports provide iomem_is_ioport(), the
arch-specific definitions for pci_iounmap() can be removed and the archs
can use the generic implementation, instead.

Create a unified version of pci_iounmap() in drivers/pci/iomap.c.
Provide the function iomem_is_ioport() in include/asm-generic/io.h
(generic) and lib/iomap.c ("pseudo-generic" for x86).

Remove the CONFIG_GENERIC_IOMAP guard around
ARCH_WANTS_GENERIC_PCI_IOUNMAP so that configs that set
CONFIG_GENERIC_PCI_IOMAP without CONFIG_GENERIC_IOMAP still get the
function.

Add TODOs for follow-up work on the "generic is not generic but
x86-spcific"-Problem.

Suggested-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/iomap.c         | 46 ++++++++++++-------------------------
 include/asm-generic/io.h    | 27 ++++++++++++++++++++--
 include/asm-generic/iomap.h | 21 +++++++++++++++++
 lib/iomap.c                 | 28 ++++++++++++++++------
 4 files changed, 82 insertions(+), 40 deletions(-)

diff --git a/drivers/pci/iomap.c b/drivers/pci/iomap.c
index 91285fcff1ba..439ba2e9710f 100644
--- a/drivers/pci/iomap.c
+++ b/drivers/pci/iomap.c
@@ -135,44 +135,28 @@ void __iomem *pci_iomap_wc(struct pci_dev *dev, int bar, unsigned long maxlen)
 EXPORT_SYMBOL_GPL(pci_iomap_wc);
 
 /*
- * pci_iounmap() somewhat illogically comes from lib/iomap.c for the
- * CONFIG_GENERIC_IOMAP case, because that's the code that knows about
- * the different IOMAP ranges.
+ * This check is still necessary due to legacy reasons.
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
+ * TODO: Have all architectures that provide their own pci_iounmap() provide
+ * iomem_is_ioport() instead. Remove this #if afterwards.
  */
 #if defined(ARCH_WANTS_GENERIC_PCI_IOUNMAP)
 
-void pci_iounmap(struct pci_dev *dev, void __iomem *p)
+/**
+ * pci_iounmap - Unmapp a mapping
+ * @dev: PCI device the mapping belongs to
+ * @addr: start address of the mapping
+ *
+ * Unmapp a PIO or MMIO mapping.
+ */
+void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
 {
-#ifdef ARCH_HAS_GENERIC_IOPORT_MAP
-	uintptr_t start = (uintptr_t) PCI_IOBASE;
-	uintptr_t addr = (uintptr_t) p;
-
-	if (addr >= start && addr < start + IO_SPACE_LIMIT) {
-		ioport_unmap(p);
+	if (iomem_is_ioport(addr)) {
+		ioport_unmap(addr);
 		return;
 	}
-#endif
-	iounmap(p);
+
+	iounmap(addr);
 }
 EXPORT_SYMBOL(pci_iounmap);
 
diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index bac63e874c7b..58c7bf4080da 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -1129,11 +1129,34 @@ extern void ioport_unmap(void __iomem *p);
 #endif /* CONFIG_GENERIC_IOMAP */
 #endif /* CONFIG_HAS_IOPORT_MAP */
 
-#ifndef CONFIG_GENERIC_IOMAP
+/*
+ * TODO:
+ * remove this once all architectures replaced their pci_iounmap() with
+ * a custom implementation of iomem_is_ioport().
+ */
 #ifndef pci_iounmap
+#define pci_iounmap pci_iounmap
 #define ARCH_WANTS_GENERIC_PCI_IOUNMAP
+#endif /* pci_iounmap */
+
+/*
+ * This function is a helper only needed for the generic pci_iounmap().
+ * It's provided here if the architecture does not provide its own version.
+ */
+#ifndef iomem_is_ioport
+#define iomem_is_ioport iomem_is_ioport
+static inline bool iomem_is_ioport(void __iomem *addr_raw)
+{
+#ifdef CONFIG_HAS_IOPORT
+	uintptr_t start = (uintptr_t)PCI_IOBASE;
+	uintptr_t addr = (uintptr_t)addr_raw;
+
+	if (addr >= start && addr < start + IO_SPACE_LIMIT)
+		return true;
 #endif
-#endif
+	return false;
+}
+#endif /* iomem_is_ioport */
 
 #ifndef xlate_dev_mem_ptr
 #define xlate_dev_mem_ptr xlate_dev_mem_ptr
diff --git a/include/asm-generic/iomap.h b/include/asm-generic/iomap.h
index 196087a8126e..2cdc6988a102 100644
--- a/include/asm-generic/iomap.h
+++ b/include/asm-generic/iomap.h
@@ -110,6 +110,27 @@ static inline void __iomem *ioremap_np(phys_addr_t offset, size_t size)
 }
 #endif
 
+/*
+ * If CONFIG_GENERIC_IOMAP is selected and the architecture does NOT provide its
+ * own version, ARCH_WANTS_GENERIC_IOMEM_IS_IOPORT makes sure that the generic
+ * version from asm-generic/io.h is NOT used and instead the second "generic"
+ * version from lib/iomap.c is used.
+ *
+ * There are currently two generic versions because of a difficult cleanup
+ * process. Namely, the version in lib/iomap.c once was really generic when IA64
+ * still existed. Today, it's only really used by x86.
+ *
+ * TODO: Move the version from lib/iomap.c to x86 specific code. Then, remove
+ * this ARCH_WANTS_GENERIC_IOMEM_IS_IOPORT-mechanism.
+ */
+#ifdef CONFIG_GENERIC_IOMAP
+#ifndef iomem_is_ioport
+#define iomem_is_ioport iomem_is_ioport
+bool iomem_is_ioport(void __iomem *addr);
+#define ARCH_WANTS_GENERIC_IOMEM_IS_IOPORT
+#endif /* iomem_is_ioport */
+#endif /* CONFIG_GENERIC_IOMAP */
+
 #include <asm-generic/pci_iomap.h>
 
 #endif
diff --git a/lib/iomap.c b/lib/iomap.c
index 4f8b31baa575..eb9a879ebf42 100644
--- a/lib/iomap.c
+++ b/lib/iomap.c
@@ -418,12 +418,26 @@ EXPORT_SYMBOL(ioport_map);
 EXPORT_SYMBOL(ioport_unmap);
 #endif /* CONFIG_HAS_IOPORT_MAP */
 
-#ifdef CONFIG_PCI
-/* Hide the details if this is a MMIO or PIO address space and just do what
- * you expect in the correct way. */
-void pci_iounmap(struct pci_dev *dev, void __iomem * addr)
+/*
+ * If CONFIG_GENERIC_IOMAP is selected and the architecture does NOT provide its
+ * own version, ARCH_WANTS_GENERIC_IOMEM_IS_IOPORT makes sure that the generic
+ * version from asm-generic/io.h is NOT used and instead the second "generic"
+ * version from this file here is used.
+ *
+ * There are currently two generic versions because of a difficult cleanup
+ * process. Namely, the version in lib/iomap.c once was really generic when IA64
+ * still existed. Today, it's only really used by x86.
+ *
+ * TODO: Move this function to x86-specific code.
+ */
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


