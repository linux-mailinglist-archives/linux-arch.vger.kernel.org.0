Return-Path: <linux-arch+bounces-1892-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAF4843A38
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 10:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D98F1C22604
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 09:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB13676905;
	Wed, 31 Jan 2024 09:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MXtcTxvf"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B450374E15
	for <linux-arch@vger.kernel.org>; Wed, 31 Jan 2024 09:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691653; cv=none; b=jIeG7ySX3Gh9IYhTGy0gDU/owdQ/4L9LtIwC0uvWtmU2ZaoTubaDOxvkzIkoT6Z5FyLiJXhr6HMKcNfGTQGvZgfq5lHqQu2YbgomTau9VhUmnfpy44M6zs3euL9dwcZt3avoQBKR4l3r//QVJKzu8Sk/nf4WiDguZVsph8rrKAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691653; c=relaxed/simple;
	bh=RaHu28swfGeK4PAcsHpJVCWgBI9Fl85IjX62PHnbSPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iW8Vkt6Dk1lHYLTM1JS5ECotefGIES4KBBaVVGCkzpE4hmgvWvpLgIfvyJfP2sqrBYan5WGDtLKe8zh4bjIcntWkveuynuU4LiZwVSyibY1kNNtoHAPo5dxGSn/OkqZSlnrTkCv9QkkHM4FMQK7R5HDn1IhtfAsHYKdcFec/RGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MXtcTxvf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706691650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b5ptHDBDyk/TuifsYW9hzTMONsgcOhj5PH/CL7IQ+VE=;
	b=MXtcTxvf2oqwZUXCSr3LixBbnkBZp3olFjtwQfFZewHx1ewewxeYp2kj11zMMhDXW1nd8u
	zqWX+wWSLsvu0ITn8B+sR8zA/DbzfVflCnkvL6OfgE/br74xigv1SWTrLAnvX3SgWJly2I
	ioHVeSBvSQsETCYKAzBuzuNa+G7zd5c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-rRfdfr8fMySV4io5C1zVFg-1; Wed, 31 Jan 2024 04:00:48 -0500
X-MC-Unique: rRfdfr8fMySV4io5C1zVFg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33ae2dd7d4aso119452f8f.1
        for <linux-arch@vger.kernel.org>; Wed, 31 Jan 2024 01:00:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706691647; x=1707296447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b5ptHDBDyk/TuifsYW9hzTMONsgcOhj5PH/CL7IQ+VE=;
        b=WcfJvhsJ1i5Nul5+qSRATf/RxCsArb7jRoOK6boQN5Ae+Um8dpjAvPWyXsoBirGYDA
         NW28u4T0ZcEWKuUSMGWmq3wOBvez6thPdd6J/yRETy41GyV/pQSzzDyks+k7lIeJoieT
         FQh/Y1RR6+7Ysaz8GzsNxK0pXZkSPBzwCUtZzqYYVAVF7hSA7bIlisIK44yLUcfP54Kr
         IYnxo284AmhKl9VkfNhahThHfbbsWmHNYrAcSO/zNuyJ6kGKo2KXo1QMtkzXwENLu25j
         RJjWU9cCnYpHxiHwQx5sUqEoLxiCa310JlXGw3i1Y62PLq2EAe9fIoP2oFs9dyMFjXia
         pPqg==
X-Forwarded-Encrypted: i=0; AJvYcCULQyGTAfOTAaEv0xwnUPHATtDdG09TLBHT5L7WL4jj2iYSRrfU3+iIihWUMINCv6ySeRARSyYY7UmGQFTUNt/CgtlomkKuhdU3Ng==
X-Gm-Message-State: AOJu0YzOcIPu+6pl+OFERp7PzrLzkgAebyTwQSJCVAankKHMd6vKou4N
	DdwgS3CYQytlzmCC4gtqguuX82uCP+cSpIUpiqeT8A6v/7a6YhSMgi6Lciun66sNil4NDL7y8zE
	JMVkSNLF849H2VTKby7DBrqZxi7MuH3Gx1LPyUbPFTuoXlJCF+iaBtEG0/Cs=
X-Received: by 2002:a05:600c:5103:b0:40f:b642:d58f with SMTP id o3-20020a05600c510300b0040fb642d58fmr114037wms.2.1706691647609;
        Wed, 31 Jan 2024 01:00:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMAW5epOuQxL91EcU+mfLdMu7OkL1AxdYAqXSHW8Go1HR5JdDFcdZJJjGAPI9uvy5SBYnj7Q==
X-Received: by 2002:a05:600c:5103:b0:40f:b642:d58f with SMTP id o3-20020a05600c510300b0040fb642d58fmr114021wms.2.1706691647282;
        Wed, 31 Jan 2024 01:00:47 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id t15-20020a05600c198f00b0040ee51f1025sm940261wmq.43.2024.01.31.01.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 01:00:46 -0800 (PST)
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
Subject: [PATCH v6 2/4] lib: move pci_iomap.c to drivers/pci/
Date: Wed, 31 Jan 2024 10:00:21 +0100
Message-ID: <20240131090023.12331-3-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131090023.12331-1-pstanner@redhat.com>
References: <20240131090023.12331-1-pstanner@redhat.com>
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

Update Documentation.

Suggested-by: Danilo Krummrich <dakr@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/driver-api/device-io.rst | 2 +-
 Documentation/driver-api/pci/pci.rst   | 3 +++
 MAINTAINERS                            | 1 -
 drivers/pci/Kconfig                    | 5 +++++
 drivers/pci/Makefile                   | 1 +
 lib/pci_iomap.c => drivers/pci/iomap.c | 3 ---
 lib/Kconfig                            | 3 ---
 lib/Makefile                           | 1 -
 8 files changed, 10 insertions(+), 9 deletions(-)
 rename lib/pci_iomap.c => drivers/pci/iomap.c (99%)

diff --git a/Documentation/driver-api/device-io.rst b/Documentation/driver-api/device-io.rst
index d55384b106bd..d9ba2dfd1239 100644
--- a/Documentation/driver-api/device-io.rst
+++ b/Documentation/driver-api/device-io.rst
@@ -518,5 +518,5 @@ Public Functions Provided
 .. kernel-doc:: arch/x86/include/asm/io.h
    :internal:
 
-.. kernel-doc:: lib/pci_iomap.c
+.. kernel-doc:: drivers/pci/iomap.c
    :export:
diff --git a/Documentation/driver-api/pci/pci.rst b/Documentation/driver-api/pci/pci.rst
index 4843cfad4f60..bacf23bf1343 100644
--- a/Documentation/driver-api/pci/pci.rst
+++ b/Documentation/driver-api/pci/pci.rst
@@ -4,6 +4,9 @@ PCI Support Library
 .. kernel-doc:: drivers/pci/pci.c
    :export:
 
+.. kernel-doc:: drivers/pci/iomap.c
+   :export:
+
 .. kernel-doc:: drivers/pci/pci-driver.c
    :export:
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 8d1052fa6a69..395fcaad63e7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16954,7 +16954,6 @@ F:	include/asm-generic/pci*
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
index 2829ddb0e316..c9725428e387 100644
--- a/lib/pci_iomap.c
+++ b/drivers/pci/iomap.c
@@ -9,7 +9,6 @@
 
 #include <linux/export.h>
 
-#ifdef CONFIG_PCI
 /**
  * pci_iomap_range - create a virtual mapping cookie for a PCI BAR
  * @dev: PCI device that owns the BAR
@@ -176,5 +175,3 @@ void pci_iounmap(struct pci_dev *dev, void __iomem *p)
 EXPORT_SYMBOL(pci_iounmap);
 
 #endif /* ARCH_WANTS_GENERIC_PCI_IOUNMAP */
-
-#endif /* CONFIG_PCI */
diff --git a/lib/Kconfig b/lib/Kconfig
index 5ddda7c2ed9b..4557bb8a5256 100644
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


