Return-Path: <linux-arch+bounces-1341-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6DC82AA7C
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jan 2024 10:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81D8D1C26A11
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jan 2024 09:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CD314F7A;
	Thu, 11 Jan 2024 09:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dS9a/Fx8"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DA814F67
	for <linux-arch@vger.kernel.org>; Thu, 11 Jan 2024 09:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704963870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dyerj4wk/ZFwQTySswA1kbRd7v7F1+vxDBdnemG6spU=;
	b=dS9a/Fx8YZpD6k6poe/vPiErPQOFxcK2K4P51CStOH+5LPX0QSfheAAk5hmOd/i7ZYMbmD
	N1ny19EzkeuaDUWhveDkh4Z+A35tEPGghfOVh0Oo41SZO/+o5PRQ8QtUjqOOYnuCtLSoqL
	6X1tAyRQOq15HKW8CPOGciJL34s7wn4=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-MvNOw-c8Nbu2itk-utFEoA-1; Thu, 11 Jan 2024 04:04:29 -0500
X-MC-Unique: MvNOw-c8Nbu2itk-utFEoA-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-20407fffbfdso1687022fac.0
        for <linux-arch@vger.kernel.org>; Thu, 11 Jan 2024 01:04:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704963868; x=1705568668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dyerj4wk/ZFwQTySswA1kbRd7v7F1+vxDBdnemG6spU=;
        b=ku9IOUVyM6ccGYEmxKBp+YEcEK7zJJkX3iK8gae/08motK5yhXAmUkkFdmdvfA2WMy
         jKFaTmc1Hcnf9oW3QVdBjKbV7oeNAOdCqVIOV3ASlMMnBplb3oYJtQ6NAyA+6rdCHXpC
         bwweVR40iJyRQimYonnd5pekXgUWcjhWf/JqFuPRA0BLuKI72ZF5TXI3B0HCJeXCBPMh
         PJ4Z3jRerV8m34hHWc1n5nptrxjYjRBWkePuT9phtqmivE1yYJGAiUWEWac3cmP8Zpub
         wzWovTkExQ4IzoSkqy0Iyg2AkADj3PLzYB/gGIVn7w+GYfRUNiBA2HSRoIKeMD0+afqO
         ybgg==
X-Gm-Message-State: AOJu0Yxz4KMkZPQhnvVST6DtxhD8HrenwSsCyXYfHogprn7ToWQ/5+GE
	+f3I4y5YxE+R+A/mUnaCDg6sPeG7vjqjfPrVgdxvgdRqDhW3I00FiNKrzllyEeJOCN7FWC+t1Nv
	jxNxP6CP52MNe1EFRrYz1iNmLK/DEm5iLSP5HNA==
X-Received: by 2002:a05:6870:93c3:b0:206:7460:2ce0 with SMTP id c3-20020a05687093c300b0020674602ce0mr1654170oal.2.1704963868677;
        Thu, 11 Jan 2024 01:04:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGaZnYbDoS5I7/1KUL/F8Saq2pTStHQV2Zo+9dX0ScI1cevpCrRPF9RAtMIG32jhJbPeEbnAg==
X-Received: by 2002:a05:6102:224b:b0:467:cec3:dda5 with SMTP id e11-20020a056102224b00b00467cec3dda5mr1505588vsb.0.1704963369517;
        Thu, 11 Jan 2024 00:56:09 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id e16-20020a0cd650000000b0067f7d131256sm168341qvj.17.2024.01.11.00.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 00:56:09 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Johannes Berg <johannes@sipsolutions.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	NeilBrown <neilb@suse.de>,
	John Sanpe <sanpeqf@gmail.com>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Uladzislau Koshchanka <koshchanka@gmail.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	David Gow <davidgow@google.com>,
	Kees Cook <keescook@chromium.org>,
	Rae Moar <rmoar@google.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"wuqiang.matt" <wuqiang.matt@bytedance.com>,
	Yury Norov <yury.norov@gmail.com>,
	Jason Baron <jbaron@akamai.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marco Elver <elver@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	dakr@redhat.com
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v5 RESEND 2/5] lib: move pci_iomap.c to drivers/pci/
Date: Thu, 11 Jan 2024 09:55:37 +0100
Message-ID: <20240111085540.7740-3-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111085540.7740-1-pstanner@redhat.com>
References: <20240111085540.7740-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This file is guarded by an #ifdef CONFIG_PCI. It, consequently, does not
belong to lib/ because it is not generic infrastructure.

Move the file to drivers/pci/ and implement the necessary changes to
Makefiles and Kconfigs.

Update MAINTAINERS file.

Suggested-by: Danilo Krummrich <dakr@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 MAINTAINERS                            | 1 -
 drivers/pci/Kconfig                    | 5 +++++
 drivers/pci/Makefile                   | 1 +
 lib/pci_iomap.c => drivers/pci/iomap.c | 3 ---
 lib/Kconfig                            | 3 ---
 lib/Makefile                           | 1 -
 6 files changed, 6 insertions(+), 8 deletions(-)
 rename lib/pci_iomap.c => drivers/pci/iomap.c (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index edae86acdfdc..efa37ee81d30 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16762,7 +16762,6 @@ F:	include/asm-generic/pci*
 F:	include/linux/of_pci.h
 F:	include/linux/pci*
 F:	include/uapi/linux/pci*
-F:	lib/pci*
 
 PCIE DRIVER FOR AMAZON ANNAPURNA LABS
 M:	Jonathan Chocron <jonnyc@amazon.com>
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 74147262625b..d35001589d88 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -13,6 +13,11 @@ config FORCE_PCI
 	select HAVE_PCI
 	select PCI
 
+# select this to provide a generic PCI iomap,
+# without PCI itself having to be defined
+config GENERIC_PCI_IOMAP
+	bool
+
 menuconfig PCI
 	bool "PCI support"
 	depends on HAVE_PCI
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index cc8b4e01e29d..64dcedccfc87 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -14,6 +14,7 @@ ifdef CONFIG_PCI
 obj-$(CONFIG_PROC_FS)		+= proc.o
 obj-$(CONFIG_SYSFS)		+= slot.o
 obj-$(CONFIG_ACPI)		+= pci-acpi.o
+obj-$(CONFIG_GENERIC_PCI_IOMAP) += iomap.o
 endif
 
 obj-$(CONFIG_OF)		+= of.o
diff --git a/lib/pci_iomap.c b/drivers/pci/iomap.c
similarity index 99%
rename from lib/pci_iomap.c
rename to drivers/pci/iomap.c
index 6e144b017c48..91285fcff1ba 100644
--- a/lib/pci_iomap.c
+++ b/drivers/pci/iomap.c
@@ -9,7 +9,6 @@
 
 #include <linux/export.h>
 
-#ifdef CONFIG_PCI
 /**
  * pci_iomap_range - create a virtual mapping cookie for a PCI BAR
  * @dev: PCI device that owns the BAR
@@ -178,5 +177,3 @@ void pci_iounmap(struct pci_dev *dev, void __iomem *p)
 EXPORT_SYMBOL(pci_iounmap);
 
 #endif /* ARCH_WANTS_GENERIC_PCI_IOUNMAP */
-
-#endif /* CONFIG_PCI */
diff --git a/lib/Kconfig b/lib/Kconfig
index 3ea1c830efab..1bf859166ac7 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -70,9 +70,6 @@ source "lib/math/Kconfig"
 config NO_GENERIC_PCI_IOPORT_MAP
 	bool
 
-config GENERIC_PCI_IOMAP
-	bool
-
 config GENERIC_IOMAP
 	bool
 	select GENERIC_PCI_IOMAP
diff --git a/lib/Makefile b/lib/Makefile
index 6b09731d8e61..0800289ec6c5 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -153,7 +153,6 @@ CFLAGS_debug_info.o += $(call cc-option, -femit-struct-debug-detailed=any)
 obj-y += math/ crypto/
 
 obj-$(CONFIG_GENERIC_IOMAP) += iomap.o
-obj-$(CONFIG_GENERIC_PCI_IOMAP) += pci_iomap.o
 obj-$(CONFIG_HAS_IOMEM) += iomap_copy.o devres.o
 obj-$(CONFIG_CHECK_SIGNATURE) += check_signature.o
 obj-$(CONFIG_DEBUG_LOCKING_API_SELFTESTS) += locking-selftest.o
-- 
2.43.0


