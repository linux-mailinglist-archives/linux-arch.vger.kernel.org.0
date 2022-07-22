Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF7E57E932
	for <lists+linux-arch@lfdr.de>; Fri, 22 Jul 2022 23:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236602AbiGVVvJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Jul 2022 17:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236627AbiGVVuz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Jul 2022 17:50:55 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015762A270;
        Fri, 22 Jul 2022 14:50:43 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id q41-20020a17090a1b2c00b001f2043c727aso5282204pjq.1;
        Fri, 22 Jul 2022 14:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=opf4EMRMh4I0YmxiAyi1MscDFCrIPkcNmv8YQAkh2ao=;
        b=fELg5U1xtAOHG3uTLq0PRWRiu1yi7aDmCgircsSneYfwOpEHhb/XVMEnVivrTjJnmk
         zROQHtUPvgYPOUZSJJaB9DzGrDtWJ5iaTIS8NzbHfnB11LZ+ZNnWChsHf5J7AF46+U3o
         yJOGUzBRXJ9ww5b/EqwLrMTy85qqGsDMCBj1ePLZKn2iP3G+Zlphi/ugl5Lefk0hY4Wm
         OKJZxRwGlzLrA+8a/MM1TKb45H9boOLxiNczzrw/1Mxb6debAP9pNvoUEEtANu/0eTrh
         h6XM3K2UiM3ORSvgddpOqnL98vn6UNVUUYirZlP6fzlkQGseYWZ9OomXFU2n3WIuMUcq
         zs7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=opf4EMRMh4I0YmxiAyi1MscDFCrIPkcNmv8YQAkh2ao=;
        b=igzgA0p+4ccWiMDtlYUH/YgpSIVz/Msshm9iZlZw5YdP0CfXEhOmX33QBZz/kzvlYX
         TCd2JLtxWHZLlTXMVW/N4ROPVCeqQgLNjtsacXQGR3f4/SEEetKoH6e13P8XHeN02oWm
         j1kRS/VBjxH4C49HqsEU9DXrxtlA19DYh8meqVln4ssGPLq5tZy8VvfyoOygo5+0pBis
         rbbSiHMgJ3l7d+V5IFROdlJHfBxEl+Y5ngG0mZlj7Vn/+34lyNsiRDMA1k0nrfTX7xek
         KpslyrjLco0uKlrThjBp9xfa9u+io6TGfgCSiI//TfrIgHd4gTH5JKuGYVCI4qRk8BYS
         b7Aw==
X-Gm-Message-State: AJIora/+GNLHe3g9KNuBLjUHYoCOgdyBNHmb2ZShzcw7qKCcGpdSf7c2
        h1AiEtET3mTxefZF9hzfJQktyW3HGEdomA==
X-Google-Smtp-Source: AGRyM1tdkXaOC3fGkZTHqh9ZtEr1gPMB8LC64i4HKBbSQRtmAiOGR82kxFOKaLrbA/orJU7uH4KPZg==
X-Received: by 2002:a17:902:f80e:b0:16d:4e52:5290 with SMTP id ix14-20020a170902f80e00b0016d4e525290mr708001plb.39.1658526642989;
        Fri, 22 Jul 2022 14:50:42 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id b7-20020a17090a6ac700b001f20859b74csm5974608pjm.54.2022.07.22.14.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 14:50:42 -0700 (PDT)
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
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-um@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v6 4/4] asm-generic: Add new pci.h and use it
Date:   Sat, 23 Jul 2022 06:49:44 +0900
Message-Id: <20220722214944.831438-5-shorne@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220722214944.831438-1-shorne@gmail.com>
References: <20220722214944.831438-1-shorne@gmail.com>
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

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/lkml/CAK8P3a0JmPeczfmMBE__vn=Jbvf=nkbpVaZCycyv40pZNCJJXQ@mail.gmail.com/
Acked-by: Pierre Morel <pmorel@linux.ibm.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
Since v5:
 - Remove unneeded include in asm-generic/pci.h

 arch/arm64/include/asm/pci.h | 10 ++--------
 arch/csky/include/asm/pci.h  | 17 ++---------------
 arch/riscv/include/asm/pci.h | 23 ++++-------------------
 arch/um/include/asm/pci.h    | 14 ++------------
 include/asm-generic/pci.h    | 30 ++++++++++++++++++++++++++++++
 5 files changed, 40 insertions(+), 54 deletions(-)
 create mode 100644 include/asm-generic/pci.h

diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
index 682c922b5658..016eb6b46dc0 100644
--- a/arch/arm64/include/asm/pci.h
+++ b/arch/arm64/include/asm/pci.h
@@ -9,7 +9,6 @@
 #include <asm/io.h>
 
 #define PCIBIOS_MIN_IO		0x1000
-#define PCIBIOS_MIN_MEM		0
 
 /*
  * Set to 1 if the kernel should re-assign all PCI bus numbers
@@ -18,13 +17,8 @@
 	(pci_has_flag(PCI_REASSIGN_ALL_BUS))
 
 #define arch_can_pci_mmap_wc() 1
-#define ARCH_GENERIC_PCI_MMAP_RESOURCE	1
 
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
index 875bc028f8f6..42724c630d30 100644
--- a/arch/csky/include/asm/pci.h
+++ b/arch/csky/include/asm/pci.h
@@ -9,20 +9,7 @@
 
 #include <asm/io.h>
 
-#define PCIBIOS_MIN_IO		0
-#define PCIBIOS_MIN_MEM		0
-
-/* C-SKY shim does not initialize PCI bus */
-#define pcibios_assign_all_busses() 1
-
-#define ARCH_GENERIC_PCI_MMAP_RESOURCE	1
-
-#ifdef CONFIG_PCI
-static inline int pci_proc_domain(struct pci_bus *bus)
-{
-	/* always show the domain in /proc */
-	return 1;
-}
-#endif  /* CONFIG_PCI */
+/* Generic PCI */
+#include <asm-generic/pci.h>
 
 #endif  /* __ASM_CSKY_PCI_H */
diff --git a/arch/riscv/include/asm/pci.h b/arch/riscv/include/asm/pci.h
index f904df586c03..6ef4a1426194 100644
--- a/arch/riscv/include/asm/pci.h
+++ b/arch/riscv/include/asm/pci.h
@@ -12,23 +12,7 @@
 
 #include <asm/io.h>
 
-#define PCIBIOS_MIN_IO		0
-#define PCIBIOS_MIN_MEM		0
-
-/* RISC-V shim does not initialize PCI bus */
-#define pcibios_assign_all_busses() 1
-
-#define ARCH_GENERIC_PCI_MMAP_RESOURCE 1
-
-#ifdef CONFIG_PCI
-static inline int pci_proc_domain(struct pci_bus *bus)
-{
-	/* always show the domain in /proc */
-	return 1;
-}
-
-#ifdef	CONFIG_NUMA
-
+#if defined(CONFIG_PCI) && defined(CONFIG_NUMA)
 static inline int pcibus_to_node(struct pci_bus *bus)
 {
 	return dev_to_node(&bus->dev);
@@ -38,8 +22,9 @@ static inline int pcibus_to_node(struct pci_bus *bus)
 				 cpu_all_mask :				\
 				 cpumask_of_node(pcibus_to_node(bus)))
 #endif
-#endif	/* CONFIG_NUMA */
+#endif /* defined(CONFIG_PCI) && defined(CONFIG_NUMA) */
 
-#endif  /* CONFIG_PCI */
+/* Generic PCI */
+#include <asm-generic/pci.h>
 
 #endif  /* _ASM_RISCV_PCI_H */
diff --git a/arch/um/include/asm/pci.h b/arch/um/include/asm/pci.h
index 1211855aff34..34fe4921b5fa 100644
--- a/arch/um/include/asm/pci.h
+++ b/arch/um/include/asm/pci.h
@@ -4,18 +4,8 @@
 #include <linux/types.h>
 #include <asm/io.h>
 
-#define PCIBIOS_MIN_IO		0
-#define PCIBIOS_MIN_MEM		0
-
-#define pcibios_assign_all_busses() 1
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
index 000000000000..6869f1061528
--- /dev/null
+++ b/include/asm-generic/pci.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __ASM_GENERIC_PCI_H
+#define __ASM_GENERIC_PCI_H
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

