Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4EB469486
	for <lists+linux-arch@lfdr.de>; Mon,  6 Dec 2021 11:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242166AbhLFLA7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Dec 2021 06:00:59 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:46394
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241980AbhLFLA7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Dec 2021 06:00:59 -0500
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DBA6B3F1EE
        for <linux-arch@vger.kernel.org>; Mon,  6 Dec 2021 10:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638788249;
        bh=fuCo6GlipVLANouxdlUj9UPk8z3xqJtBdYt3yi5vrR4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=wBw9FtbqvyqVf2NzmckQeefs2A0DIhe/Gak4VsGochxzEDRjdmF9w4WO9WFVgMPWh
         1acZ1G6UWtrQZN0UciSWRUkEh7NNQyWFnyqbQfH3bSrv/KMbBabmhj1Q+vTdh02qCd
         zkmWT5alUAojuIbGWniC1RFS5s4PcN/mnR+5fMkpwuzTyojx2oPICLK9d+vc6PFqHa
         aewAs4dm6PlO5/c4DM1jR2p0brUvanUoMMm20HZyCbWKvontg9nachw9G3+RLR10nf
         CTR3WTRmKjBIl5mICM5N5upIvN9lRxWq6SUkGGUjp4V+hqwton3o+OZhkCMKnIreQW
         VJSC9/z72DfGg==
Received: by mail-wm1-f72.google.com with SMTP id g11-20020a1c200b000000b003320d092d08so5915205wmg.9
        for <linux-arch@vger.kernel.org>; Mon, 06 Dec 2021 02:57:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fuCo6GlipVLANouxdlUj9UPk8z3xqJtBdYt3yi5vrR4=;
        b=4Qh3MeEuhxrZMxwpO5H/FBkTD8iancf7izl2b/Zj2+yJ//QbWvPa/+Wm31Zyvvo+0D
         lg+LgBiwIaoNgEsCc5xRntCwzcvPW5hx5UmovtU6DgPyex/WEnbg+FmjvhzJBIICvGCh
         LTboiWKUngOZAzVPiEXBegSh33TZqmQ3x4XHqtSxuWYyBrQYLVS4l35sMO+6bK5pC8k9
         nwWvAnk06HF8wxcf23fGanyze4uofvJQaNOAh4xrdsBVGRUOAXZmv5K2bJfPmWYdkET1
         RZ1OGV8beJ6sM7fieoSb8bNB+iXNpP889t+0idz8dIXWYjp7/yPOZjksMlKorQKzvAqz
         iPZg==
X-Gm-Message-State: AOAM530YoDqjnE8Eap3zAqXc4hQvB6cz0fERzqzvKrDZp5RfFX3uNa3S
        36KZhY/Za81L2bclAiOsm+xWXe4Q8y426sKKrYVoKQuT96BnuVIPkmWkUZD0cdhxaCJD7Em5kbJ
        v8t26ueFjkRsh88B7zNvfwoO10OIJod0wYv/k+0w=
X-Received: by 2002:a1c:96:: with SMTP id 144mr38540571wma.126.1638788249419;
        Mon, 06 Dec 2021 02:57:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyruZG1A7uk22DjSFP29x9S3ZyEpMrCehgY/M0vUhz34HCzD1YET1HlEdm0KEK8SVJs3K6xfw==
X-Received: by 2002:a1c:96:: with SMTP id 144mr38540542wma.126.1638788249196;
        Mon, 06 Dec 2021 02:57:29 -0800 (PST)
Received: from localhost.localdomain (lfbn-lyo-1-470-249.w2-7.abo.wanadoo.fr. [2.7.60.249])
        by smtp.gmail.com with ESMTPSA id t127sm13430498wma.9.2021.12.06.02.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 02:57:28 -0800 (PST)
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        Atish Patra <Atish.Patra@rivosinc.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        panqinglin2020@iscas.ac.cn, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org,
        linux-arch@vger.kernel.org
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Subject: [PATCH v3 10/13] riscv: Improve virtual kernel memory layout dump
Date:   Mon,  6 Dec 2021 11:46:54 +0100
Message-Id: <20211206104657.433304-11-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211206104657.433304-1-alexandre.ghiti@canonical.com>
References: <20211206104657.433304-1-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With the arrival of sv48 and its large address space, it would be
cumbersome to statically define the unit size to use to print the different
portions of the virtual memory layout: instead, determine it dynamically.

Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
---
 arch/riscv/mm/init.c               | 67 +++++++++++++++++++++++-------
 drivers/pci/controller/pci-xgene.c |  2 +-
 include/linux/sizes.h              |  1 +
 3 files changed, 54 insertions(+), 16 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 6a19a1b1caf8..28de6ea0a720 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -79,37 +79,74 @@ static void __init zone_sizes_init(void)
 }
 
 #if defined(CONFIG_MMU) && defined(CONFIG_DEBUG_VM)
+
+#define LOG2_SZ_1K  ilog2(SZ_1K)
+#define LOG2_SZ_1M  ilog2(SZ_1M)
+#define LOG2_SZ_1G  ilog2(SZ_1G)
+#define LOG2_SZ_1T  ilog2(SZ_1T)
+
 static inline void print_mlk(char *name, unsigned long b, unsigned long t)
 {
 	pr_notice("%12s : 0x%08lx - 0x%08lx   (%4ld kB)\n", name, b, t,
-		  (((t) - (b)) >> 10));
+		  (((t) - (b)) >> LOG2_SZ_1K));
 }
 
 static inline void print_mlm(char *name, unsigned long b, unsigned long t)
 {
 	pr_notice("%12s : 0x%08lx - 0x%08lx   (%4ld MB)\n", name, b, t,
-		  (((t) - (b)) >> 20));
+		  (((t) - (b)) >> LOG2_SZ_1M));
+}
+
+static inline void print_mlg(char *name, unsigned long b, unsigned long t)
+{
+	pr_notice("%12s : 0x%08lx - 0x%08lx   (%4ld GB)\n", name, b, t,
+		  (((t) - (b)) >> LOG2_SZ_1G));
+}
+
+#ifdef CONFIG_64BIT
+static inline void print_mlt(char *name, unsigned long b, unsigned long t)
+{
+	pr_notice("%12s : 0x%08lx - 0x%08lx   (%4ld TB)\n", name, b, t,
+		  (((t) - (b)) >> LOG2_SZ_1T));
+}
+#endif
+
+static inline void print_ml(char *name, unsigned long b, unsigned long t)
+{
+	unsigned long diff = t - b;
+
+#ifdef CONFIG_64BIT
+	if ((diff >> LOG2_SZ_1T) >= 10)
+		print_mlt(name, b, t);
+	else
+#endif
+	if ((diff >> LOG2_SZ_1G) >= 10)
+		print_mlg(name, b, t);
+	else if ((diff >> LOG2_SZ_1M) >= 10)
+		print_mlm(name, b, t);
+	else
+		print_mlk(name, b, t);
 }
 
 static void __init print_vm_layout(void)
 {
 	pr_notice("Virtual kernel memory layout:\n");
-	print_mlk("fixmap", (unsigned long)FIXADDR_START,
-		  (unsigned long)FIXADDR_TOP);
-	print_mlm("pci io", (unsigned long)PCI_IO_START,
-		  (unsigned long)PCI_IO_END);
-	print_mlm("vmemmap", (unsigned long)VMEMMAP_START,
-		  (unsigned long)VMEMMAP_END);
-	print_mlm("vmalloc", (unsigned long)VMALLOC_START,
-		  (unsigned long)VMALLOC_END);
-	print_mlm("lowmem", (unsigned long)PAGE_OFFSET,
-		  (unsigned long)high_memory);
+	print_ml("fixmap", (unsigned long)FIXADDR_START,
+		 (unsigned long)FIXADDR_TOP);
+	print_ml("pci io", (unsigned long)PCI_IO_START,
+		 (unsigned long)PCI_IO_END);
+	print_ml("vmemmap", (unsigned long)VMEMMAP_START,
+		 (unsigned long)VMEMMAP_END);
+	print_ml("vmalloc", (unsigned long)VMALLOC_START,
+		 (unsigned long)VMALLOC_END);
+	print_ml("lowmem", (unsigned long)PAGE_OFFSET,
+		 (unsigned long)high_memory);
 #ifdef CONFIG_64BIT
 #ifdef CONFIG_KASAN
-	print_mlm("kasan", KASAN_SHADOW_START, KASAN_SHADOW_END);
+	print_ml("kasan", KASAN_SHADOW_START, KASAN_SHADOW_END);
 #endif
-	print_mlm("kernel", (unsigned long)KERNEL_LINK_ADDR,
-		  (unsigned long)ADDRESS_SPACE_END);
+	print_ml("kernel", (unsigned long)KERNEL_LINK_ADDR,
+		 (unsigned long)ADDRESS_SPACE_END);
 #endif
 }
 #else
diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
index e64536047b65..187dcf8a9694 100644
--- a/drivers/pci/controller/pci-xgene.c
+++ b/drivers/pci/controller/pci-xgene.c
@@ -21,6 +21,7 @@
 #include <linux/pci-ecam.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/sizes.h>
 
 #include "../pci.h"
 
@@ -50,7 +51,6 @@
 #define OB_LO_IO			0x00000002
 #define XGENE_PCIE_VENDORID		0x10E8
 #define XGENE_PCIE_DEVICEID		0xE004
-#define SZ_1T				(SZ_1G*1024ULL)
 #define PIPE_PHY_RATE_RD(src)		((0xc000 & (u32)(src)) >> 0xe)
 
 #define XGENE_V1_PCI_EXP_CAP		0x40
diff --git a/include/linux/sizes.h b/include/linux/sizes.h
index 1ac79bcee2bb..0bc6cf394b08 100644
--- a/include/linux/sizes.h
+++ b/include/linux/sizes.h
@@ -47,6 +47,7 @@
 #define SZ_8G				_AC(0x200000000, ULL)
 #define SZ_16G				_AC(0x400000000, ULL)
 #define SZ_32G				_AC(0x800000000, ULL)
+#define SZ_1T				_AC(0x10000000000, ULL)
 #define SZ_64T				_AC(0x400000000000, ULL)
 
 #endif /* __LINUX_SIZES_H__ */
-- 
2.32.0

