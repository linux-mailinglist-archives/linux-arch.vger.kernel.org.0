Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7F657B747
	for <lists+linux-arch@lfdr.de>; Wed, 20 Jul 2022 15:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiGTNUi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Jul 2022 09:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbiGTNU3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Jul 2022 09:20:29 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56EE28733;
        Wed, 20 Jul 2022 06:20:19 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id l124so16451076pfl.8;
        Wed, 20 Jul 2022 06:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CAvGAUGfD4yEriU2e+6H/aIlJES74/b5I+im3RNoGrs=;
        b=p3wXeUZfzksHJTjRN3TbKh0YY/y9vXPhBOz1E9Qx+OIZAdzTNAophS2Llu2IX0tbhc
         OZyJroI3k6DSfhl2e40+zNH+BrwZGcei+Yej7z/I+s+WclFoYh/tZsOLs+pVRXoayr3U
         PIS3qOeixSitSMIYqzT6F7061+ThLmpF5rl7X1xZ79PqFLljKFI1AkLvUCSnQKV8MJ6z
         J2ePRdoxNIiT+F7Xx/+545n5YoTnigWFR36AgknMvGpPAcAjA+ZpcFbnICQp/VcaxMkN
         MHKhfELNUfrSrwbvQggMQf/TVwmKcHyfBRn4bjuFPe9DkvKYjuToMdUAmIkuACQxYJkW
         /OLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CAvGAUGfD4yEriU2e+6H/aIlJES74/b5I+im3RNoGrs=;
        b=2MBxImBerB4kQh8jh52pMbfwa5LGTArqcXuQfowY6PJ69mlOk4f5WBE05DbzB3MVEj
         7zAQ8D8Sx/PQdXHqtrZpdeyuRStntev80VMwXGaAJS9nWuovsD33MZcAkTlQ/PoECGE0
         q3/ieBolWx3kU/vAweDw+IkptOeJelhuORbBtOxDfgszOLQUItc7bnS7ftEeI1hf6WSW
         IoeSv7lVF62+Up2p5dXxWmTuFb8Ovhl5GV1NL6VZiCqkK4F3iq0w7wzYkWOOtlih7Hpr
         VRbbVZTDTvZrTPzwPfkYAiE6UoYqRnTf69L6AGbMtHBm3Wv1XzE2o+fop+HX+IIO/hbh
         jd4Q==
X-Gm-Message-State: AJIora/g3M/8PLO22wj+QNfKYRMETF4ExkUGE5LMdLUIdD/27TemlGBM
        Rqv6YqlphwFy2Tvc8yGw5bp4tJP+oJppAA==
X-Google-Smtp-Source: AGRyM1tdmS3W6AEHPZVvhwfu9X7/ePXNVtvfP36y43KWJu4Jr7+8pY5vWvOgEhR3qjIkgSvWNtwz9Q==
X-Received: by 2002:a63:f143:0:b0:41a:5c8a:915c with SMTP id o3-20020a63f143000000b0041a5c8a915cmr4398046pgk.369.1658323218892;
        Wed, 20 Jul 2022 06:20:18 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id p29-20020a635b1d000000b0041a67913d5bsm1267044pgb.71.2022.07.20.06.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 06:20:18 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Stafford Horne <shorne@gmail.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
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
Subject: [PATCH v4 3/3] asm-generic: Add new pci.h and use it
Date:   Wed, 20 Jul 2022 22:19:34 +0900
Message-Id: <20220720131934.373932-4-shorne@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220720131934.373932-1-shorne@gmail.com>
References: <20220720131934.373932-1-shorne@gmail.com>
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

One thing to note:

 - ARCH_GENERIC_PCI_MMAP_RESOURCE, csky does not define this so we
   undefine it after including asm-generic/pci.h.  Why doesn't csky
   define it?

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/lkml/CAK8P3a0JmPeczfmMBE__vn=Jbvf=nkbpVaZCycyv40pZNCJJXQ@mail.gmail.com/
Acked-by: Pierre Morel <pmorel@linux.ibm.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
Since v3:
 - Remove notes about pci_get_legacy_ide_irq and isa_dma_bridge_buggy.
 - Change ifdef around pci_proc_domain to use CONFIG_PCI_DOMAINS to avoid
   compile failure on User Mode linux.

 arch/arm64/include/asm/pci.h | 12 ++----------
 arch/csky/include/asm/pci.h  | 24 ++++--------------------
 arch/riscv/include/asm/pci.h | 25 +++----------------------
 arch/um/include/asm/pci.h    | 24 ++----------------------
 include/asm-generic/pci.h    | 32 ++++++++++++++++++++++++++++++++
 5 files changed, 43 insertions(+), 74 deletions(-)
 create mode 100644 include/asm-generic/pci.h

diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
index 0aebc3488c32..016eb6b46dc0 100644
--- a/arch/arm64/include/asm/pci.h
+++ b/arch/arm64/include/asm/pci.h
@@ -9,7 +9,6 @@
 #include <asm/io.h>
 
 #define PCIBIOS_MIN_IO		0x1000
-#define PCIBIOS_MIN_MEM		0
 
 /*
  * Set to 1 if the kernel should re-assign all PCI bus numbers
@@ -18,15 +17,8 @@
 	(pci_has_flag(PCI_REASSIGN_ALL_BUS))
 
 #define arch_can_pci_mmap_wc() 1
-#define ARCH_GENERIC_PCI_MMAP_RESOURCE	1
 
-extern int isa_dma_bridge_buggy;
-
-#ifdef CONFIG_PCI
-static inline int pci_proc_domain(struct pci_bus *bus)
-{
-	return 1;
-}
-#endif  /* CONFIG_PCI */
+/* Generic PCI */
+#include <asm-generic/pci.h>
 
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
index 000000000000..3ceb0cb12321
--- /dev/null
+++ b/include/asm-generic/pci.h
@@ -0,0 +1,32 @@
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
+/* Enable generic resource mapping code in drivers/pci/ */
+#define ARCH_GENERIC_PCI_MMAP_RESOURCE
+
+#ifdef CONFIG_PCI_DOMAINS
+static inline int pci_proc_domain(struct pci_bus *bus)
+{
+	/* always show the domain in /proc */
+	return 1;
+}
+#endif /* CONFIG_PCI_DOMAINS */
+
+#endif /* __ASM_GENERIC_PCI_H */
-- 
2.36.1

