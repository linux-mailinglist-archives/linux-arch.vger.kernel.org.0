Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBCA5773C0
	for <lists+linux-arch@lfdr.de>; Sun, 17 Jul 2022 05:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbiGQDf0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 16 Jul 2022 23:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiGQDfU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 16 Jul 2022 23:35:20 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFAB165A9;
        Sat, 16 Jul 2022 20:35:19 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 72so7846893pge.0;
        Sat, 16 Jul 2022 20:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xv2PvDmoyOL9LB+6uvx+zPygvIwvBJhKrGc5MQCkb40=;
        b=ZWVQHPWoRcjOaDC1WJd99IHoPIdfuDS5WO0w6MPg3RfLuHAN49GW4jC9rGrvMm+XFv
         jifUaIssay+7+Wc66UNuSO4F2Q+tAtuPVxkKx+tIxrmRHDIdjSlEk9oqyJXpN7jW4xYo
         lhra752D95aaAQDco7zsWBQUJ0eGdbJpfsYrs7/wioQLCKUVEmwytfZAhy9x0jEiXsXO
         iy6hYeYPGwXXeQm3Yxi0jfA0yNX2B88vCUClPG648+QSoCX/SAebiBX3lCD9n+eNUIkm
         FFUW7z6jbXlYFMkaykePVPgnRMczSPDT4W85HCUGK8R/Ei4+BqRkg5l32zScIpZ1Aprp
         +bYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xv2PvDmoyOL9LB+6uvx+zPygvIwvBJhKrGc5MQCkb40=;
        b=c/rlTddqugGgudeGquD2uuXoyUEkSm0URsd+oqHm2h/XgnyaBnA3RMK+Ya+7En/zDU
         GcqYixSxewpDoF8SLQSzIYCFogorjVF3Wpp0VmcKICpYxC15kmgj80eMsosAlEL8Azv3
         1F3wJTfAkhLCITcEqZyujYSQr4QPou+mwE+U7AviQNgorn2L0sKYIvflfhOZnD/f4CwU
         cFJCX+3WOgy70ynXR6VJAqtmS1FIanj1zBNAjJEX0Ecj2ai0wyCmbXNnJjpxeHv33LGx
         FxVLYXzT7ghNVuFkLwekF7fmhI6+Z8AWFQ0VPCqOh/MCam6stoH0UYPzXl35f/OOZUYo
         PpwA==
X-Gm-Message-State: AJIora8FHMBg+Mr6uFzEiJmc9g4MEsw125EkfNjSgLys2Cq10EO35PAB
        RcogG0SOE0vqX8PLOG5isQrREL22zOo3vg==
X-Google-Smtp-Source: AGRyM1v2om8t0UM8MyVaid0Ngu+307Bu4Jr6afHyZaBkUkJHozBAsL+a+jvIFpzs5xOBn/jDmVm1FQ==
X-Received: by 2002:a63:210:0:b0:419:c604:2c2b with SMTP id 16-20020a630210000000b00419c6042c2bmr12673684pgc.190.1658028918439;
        Sat, 16 Jul 2022 20:35:18 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id x6-20020a170902ec8600b0016bedb7ed1esm6421111plg.116.2022.07.16.20.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 20:35:18 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Stafford Horne <shorne@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-um@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 2/2] asm-generic: Add new pci.h and use it
Date:   Sun, 17 Jul 2022 12:34:53 +0900
Message-Id: <20220717033453.2896843-3-shorne@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220717033453.2896843-1-shorne@gmail.com>
References: <20220717033453.2896843-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The asm/pci.h used for many newer architectures share similar
definitions.  Move the common parts to asm-generic/pci.h to allow for
sharing code.

Two things to note are:

 - isa_dma_bridge_buggy, traditionally this is defined in asm/dma.h but
   these architectures avoid creating that file and add the definition
   to asm/pci.h.
 - ARCH_GENERIC_PCI_MMAP_RESOURCE, csky does not define this so we
   undefine it after including asm-generic/pci.h.  Why doesn't csky
   define it?
 - pci_get_legacy_ide_irq, This function is only used on architectures
   that support PNP.  It is only maintained for arm64, in other
   architectures it is removed.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/lkml/CAK8P3a0JmPeczfmMBE__vn=Jbvf=nkbpVaZCycyv40pZNCJJXQ@mail.gmail.com/
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/arm64/include/asm/pci.h | 12 +++---------
 arch/csky/include/asm/pci.h  | 24 ++++--------------------
 arch/riscv/include/asm/pci.h | 25 +++----------------------
 arch/um/include/asm/pci.h    | 24 ++----------------------
 include/asm-generic/pci.h    | 36 ++++++++++++++++++++++++++++++++++++
 5 files changed, 48 insertions(+), 73 deletions(-)
 create mode 100644 include/asm-generic/pci.h

diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
index b33ca260e3c9..1180e83712f5 100644
--- a/arch/arm64/include/asm/pci.h
+++ b/arch/arm64/include/asm/pci.h
@@ -9,7 +9,6 @@
 #include <asm/io.h>
 
 #define PCIBIOS_MIN_IO		0x1000
-#define PCIBIOS_MIN_MEM		0
 
 /*
  * Set to 1 if the kernel should re-assign all PCI bus numbers
@@ -18,9 +17,6 @@
 	(pci_has_flag(PCI_REASSIGN_ALL_BUS))
 
 #define arch_can_pci_mmap_wc() 1
-#define ARCH_GENERIC_PCI_MMAP_RESOURCE	1
-
-extern int isa_dma_bridge_buggy;
 
 #ifdef CONFIG_PCI
 static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
@@ -28,11 +24,9 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 	/* no legacy IRQ on arm64 */
 	return -ENODEV;
 }
-
-static inline int pci_proc_domain(struct pci_bus *bus)
-{
-	return 1;
-}
 #endif  /* CONFIG_PCI */
 
+/* Generic PCI */
+#include <asm-generic/pci.h>
+
 #endif  /* __ASM_PCI_H */
diff --git a/arch/csky/include/asm/pci.h b/arch/csky/include/asm/pci.h
index ebc765b1f78b..44866c1ad461 100644
--- a/arch/csky/include/asm/pci.h
+++ b/arch/csky/include/asm/pci.h
@@ -9,26 +9,10 @@
 
 #include <asm/io.h>
 
-#define PCIBIOS_MIN_IO		0
-#define PCIBIOS_MIN_MEM		0
+/* Generic PCI */
+#include <asm-generic/pci.h>
 
-/* C-SKY shim does not initialize PCI bus */
-#define pcibios_assign_all_busses() 1
-
-extern int isa_dma_bridge_buggy;
-
-#ifdef CONFIG_PCI
-static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
-{
-	/* no legacy IRQ on csky */
-	return -ENODEV;
-}
-
-static inline int pci_proc_domain(struct pci_bus *bus)
-{
-	/* always show the domain in /proc */
-	return 1;
-}
-#endif  /* CONFIG_PCI */
+/* csky doesn't use generic pci resource mapping */
+#undef ARCH_GENERIC_PCI_MMAP_RESOURCE
 
 #endif  /* __ASM_CSKY_PCI_H */
diff --git a/arch/riscv/include/asm/pci.h b/arch/riscv/include/asm/pci.h
index 7fd52a30e605..12ce8150cfb0 100644
--- a/arch/riscv/include/asm/pci.h
+++ b/arch/riscv/include/asm/pci.h
@@ -12,29 +12,7 @@
 
 #include <asm/io.h>
 
-#define PCIBIOS_MIN_IO		0
-#define PCIBIOS_MIN_MEM		0
-
-/* RISC-V shim does not initialize PCI bus */
-#define pcibios_assign_all_busses() 1
-
-#define ARCH_GENERIC_PCI_MMAP_RESOURCE 1
-
-extern int isa_dma_bridge_buggy;
-
 #ifdef CONFIG_PCI
-static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
-{
-	/* no legacy IRQ on risc-v */
-	return -ENODEV;
-}
-
-static inline int pci_proc_domain(struct pci_bus *bus)
-{
-	/* always show the domain in /proc */
-	return 1;
-}
-
 #ifdef	CONFIG_NUMA
 
 static inline int pcibus_to_node(struct pci_bus *bus)
@@ -50,4 +28,7 @@ static inline int pcibus_to_node(struct pci_bus *bus)
 
 #endif  /* CONFIG_PCI */
 
+/* Generic PCI */
+#include <asm-generic/pci.h>
+
 #endif  /* _ASM_RISCV_PCI_H */
diff --git a/arch/um/include/asm/pci.h b/arch/um/include/asm/pci.h
index da13fd5519ef..34fe4921b5fa 100644
--- a/arch/um/include/asm/pci.h
+++ b/arch/um/include/asm/pci.h
@@ -4,28 +4,8 @@
 #include <linux/types.h>
 #include <asm/io.h>
 
-#define PCIBIOS_MIN_IO		0
-#define PCIBIOS_MIN_MEM		0
-
-#define pcibios_assign_all_busses() 1
-
-extern int isa_dma_bridge_buggy;
-
-#ifdef CONFIG_PCI
-static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
-{
-	/* no legacy IRQs */
-	return -ENODEV;
-}
-#endif
-
-#ifdef CONFIG_PCI_DOMAINS
-static inline int pci_proc_domain(struct pci_bus *bus)
-{
-	/* always show the domain in /proc */
-	return 1;
-}
-#endif  /* CONFIG_PCI */
+/* Generic PCI */
+#include <asm-generic/pci.h>
 
 #ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
 /*
diff --git a/include/asm-generic/pci.h b/include/asm-generic/pci.h
new file mode 100644
index 000000000000..fbc25741696a
--- /dev/null
+++ b/include/asm-generic/pci.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __ASM_GENERIC_PCI_H
+#define __ASM_GENERIC_PCI_H
+
+#include <linux/types.h>
+
+#ifndef PCIBIOS_MIN_IO
+#define PCIBIOS_MIN_IO		0
+#endif
+
+#ifndef PCIBIOS_MIN_MEM
+#define PCIBIOS_MIN_MEM		0
+#endif
+
+#ifndef pcibios_assign_all_busses
+/* For bootloaders that do not initialize the PCI bus */
+#define pcibios_assign_all_busses() 1
+#endif
+
+extern int isa_dma_bridge_buggy;
+
+/* Enable generic resource mapping code in drivers/pci/ */
+#define ARCH_GENERIC_PCI_MMAP_RESOURCE
+
+#ifdef CONFIG_PCI
+
+static inline int pci_proc_domain(struct pci_bus *bus)
+{
+	/* always show the domain in /proc */
+	return 1;
+}
+
+#endif /* CONFIG_PCI */
+
+#endif /* __ASM_GENERIC_PCI_H */
-- 
2.36.1

