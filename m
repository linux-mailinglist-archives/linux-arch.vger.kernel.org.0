Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D510264A35F
	for <lists+linux-arch@lfdr.de>; Mon, 12 Dec 2022 15:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbiLLObN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Dec 2022 09:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiLLObI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Dec 2022 09:31:08 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137B012AC5
        for <linux-arch@vger.kernel.org>; Mon, 12 Dec 2022 06:31:06 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id h12so12258502wrv.10
        for <linux-arch@vger.kernel.org>; Mon, 12 Dec 2022 06:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9bjSaY0dKPU8rRmLG4CBmPCq2fIXi0xyi4TtR3RdYl0=;
        b=Mn9j3vPjJawT1NzX8GEXtEEehu7HPVzgFDXBPpGcJscM2WIuoB0+59SYDB/Wanl0XO
         XYBbZl+iXE4I7+LiPLWTqcSidC20qLv4zqT9xbd0Ut7XfUCujklQ/MZKI8qHfLZkMfCD
         t52g0IA+6gRU+p0ngE49sE3KgSF6sUeresTThc20MiHMzT7K+PrYMhtQqVtQ2mZOVkuV
         3E/m5ZKuQoBXfOmymwAFP94Nj/E32q67jh87RAWSV8FO37y7PvR9nGqpkc8aWsdy4UWM
         bJyeZPoUHCKMeHNBQpODGOkkG3+jTVHvzbqv0t8IAtnS6fbpZ/Gqk+10hPP9otUmXplS
         mNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9bjSaY0dKPU8rRmLG4CBmPCq2fIXi0xyi4TtR3RdYl0=;
        b=OcCV0kyzYCYTSESyP3gDAYUtR4I4AM5YEqneFCztMfFs0qrrDWXm9n/x+2jOYq7I9/
         SP4npQ+uooaZ+X1ddhhQIFLc92cAtepVbyenq68AKsTIGFT3zzlX4Gf8hImA4xxrcgXy
         faea9DRGXy2/bQWuOnzchQ29ElNBvUoIlJ4zAutu1Vb5l1F02gZCzml48LOTFZt4NN6X
         FR9SVhj1PYhb+do/8qOfHCTHdDMNROTy8FghWZruE3FPqgrr9zc8MPch0Vs6vf2R4HlM
         Mldip2Fz2wsjV0QzMKk+YzROvfZwwcKgyT1ZbJ4yxZm15zN6Q3cxQ9HdzXYHk11xIZL7
         0Kvw==
X-Gm-Message-State: ANoB5pkSlxdqq4VHAE6nc+KP0u8B+m7JGTwXdjENIcUN8eCdT5cc0cO1
        G9pHOKCeCX8+w4nvKhBU4YMW8BBP5vrc2WSr
X-Google-Smtp-Source: AA0mqf6is7skwt1eIjtz1whXl+4EWNYW5O1NDnvHFCNOSEPzPBtn7Ez4dHtMxelDNz8/S15bfCZtkw==
X-Received: by 2002:a05:6000:1f1c:b0:24f:dbcd:7714 with SMTP id bv28-20020a0560001f1c00b0024fdbcd7714mr2115792wrb.50.1670855464551;
        Mon, 12 Dec 2022 06:31:04 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (lfbn-gre-1-201-46.w90-112.abo.wanadoo.fr. [90.112.163.46])
        by smtp.gmail.com with ESMTPSA id l11-20020a5d526b000000b002422202fa7fsm8978069wrc.39.2022.12.12.06.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 06:31:04 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2] riscv: Use PUD/P4D/PGD pages for the linear mapping
Date:   Mon, 12 Dec 2022 15:31:02 +0100
Message-Id: <20221212143102.175065-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

During the early page table creation, we used to set the mapping for
PAGE_OFFSET to the kernel load address: but the kernel load address is
always offseted by PMD_SIZE which makes it impossible to use PUD/P4D/PGD
pages as this physical address is not aligned on PUD/P4D/PGD size (whereas
PAGE_OFFSET is).

But actually we don't have to establish this mapping (ie set va_pa_offset)
that early in the boot process because:

- first, setup_vm installs a temporary kernel mapping and among other
  things, discovers the system memory,
- then, setup_vm_final creates the final kernel mapping and takes
  advantage of the discovered system memory to create the linear
  mapping.

During the first phase, we don't know the start of the system memory and
then until the second phase is finished, we can't use the linear mapping at
all and phys_to_virt/virt_to_phys translations must not be used because it
would result in a different translation from the 'real' one once the final
mapping is installed.

So here we simply delay the initialization of va_pa_offset to after the
system memory discovery. But to make sure noone uses the linear mapping
before, we add some guard in the DEBUG_VIRTUAL config.

Finally we can use PUD/P4D/PGD hugepages when possible, which will result
in a better TLB utilization.

Note that we rely on the firmware to protect itself using PMP.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---

v2:
- Add a comment on why RISCV64 does not need to set initrd_start/end that
  early in the boot process, as asked by Rob

Note that this patch is rebased on top of:
[PATCH v1 1/1] riscv: mm: call best_map_size many times during linear-mapping

 arch/riscv/include/asm/page.h | 16 ++++++++++++++++
 arch/riscv/mm/init.c          | 25 +++++++++++++++++++------
 arch/riscv/mm/physaddr.c      | 16 ++++++++++++++++
 drivers/of/fdt.c              |  7 ++++++-
 4 files changed, 57 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index ac70b0fd9a9a..f3af526a149f 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -90,6 +90,14 @@ typedef struct page *pgtable_t;
 #define PTE_FMT "%08lx"
 #endif
 
+#ifdef CONFIG_64BIT
+/*
+ * We override this value as its generic definition uses __pa too early in
+ * the boot process (before kernel_map.va_pa_offset is set).
+ */
+#define MIN_MEMBLOCK_ADDR      0
+#endif
+
 #ifdef CONFIG_MMU
 extern unsigned long riscv_pfn_base;
 #define ARCH_PFN_OFFSET		(riscv_pfn_base)
@@ -122,7 +130,11 @@ extern phys_addr_t phys_ram_base;
 #define is_linear_mapping(x)	\
 	((x) >= PAGE_OFFSET && (!IS_ENABLED(CONFIG_64BIT) || (x) < PAGE_OFFSET + KERN_VIRT_SIZE))
 
+#ifndef CONFIG_DEBUG_VIRTUAL
 #define linear_mapping_pa_to_va(x)	((void *)((unsigned long)(x) + kernel_map.va_pa_offset))
+#else
+void *linear_mapping_pa_to_va(unsigned long x);
+#endif
 #define kernel_mapping_pa_to_va(y)	({						\
 	unsigned long _y = y;								\
 	(IS_ENABLED(CONFIG_XIP_KERNEL) && _y < phys_ram_base) ?					\
@@ -131,7 +143,11 @@ extern phys_addr_t phys_ram_base;
 	})
 #define __pa_to_va_nodebug(x)		linear_mapping_pa_to_va(x)
 
+#ifndef CONFIG_DEBUG_VIRTUAL
 #define linear_mapping_va_to_pa(x)	((unsigned long)(x) - kernel_map.va_pa_offset)
+#else
+phys_addr_t linear_mapping_va_to_pa(unsigned long x);
+#endif
 #define kernel_mapping_va_to_pa(y) ({						\
 	unsigned long _y = y;							\
 	(IS_ENABLED(CONFIG_XIP_KERNEL) && _y < kernel_map.virt_addr + XIP_OFFSET) ?	\
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 1b76d3fe4e26..58bcf395efdc 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -213,6 +213,14 @@ static void __init setup_bootmem(void)
 	phys_ram_end = memblock_end_of_DRAM();
 	if (!IS_ENABLED(CONFIG_XIP_KERNEL))
 		phys_ram_base = memblock_start_of_DRAM();
+
+	/*
+	 * Any use of __va/__pa before this point is wrong as we did not know the
+	 * start of DRAM before.
+	 */
+	kernel_map.va_pa_offset = PAGE_OFFSET - phys_ram_base;
+	riscv_pfn_base = PFN_DOWN(phys_ram_base);
+
 	/*
 	 * memblock allocator is not aware of the fact that last 4K bytes of
 	 * the addressable memory can not be mapped because of IS_ERR_VALUE
@@ -672,9 +680,16 @@ void __init create_pgd_mapping(pgd_t *pgdp,
 
 static uintptr_t __init best_map_size(phys_addr_t base, phys_addr_t size)
 {
-	/* Upgrade to PMD_SIZE mappings whenever possible */
-	base &= PMD_SIZE - 1;
-	if (!base && size >= PMD_SIZE)
+	if (!(base & (PGDIR_SIZE - 1)) && size >= PGDIR_SIZE)
+		return PGDIR_SIZE;
+
+	if (!(base & (P4D_SIZE - 1)) && size >= P4D_SIZE)
+		return P4D_SIZE;
+
+	if (!(base & (PUD_SIZE - 1)) && size >= PUD_SIZE)
+		return PUD_SIZE;
+
+	if (!(base & (PMD_SIZE - 1)) && size >= PMD_SIZE)
 		return PMD_SIZE;
 
 	return PAGE_SIZE;
@@ -983,11 +998,9 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	set_satp_mode();
 #endif
 
-	kernel_map.va_pa_offset = PAGE_OFFSET - kernel_map.phys_addr;
+	kernel_map.va_pa_offset = 0UL;
 	kernel_map.va_kernel_pa_offset = kernel_map.virt_addr - kernel_map.phys_addr;
 
-	riscv_pfn_base = PFN_DOWN(kernel_map.phys_addr);
-
 	/*
 	 * The default maximal physical memory size is KERN_VIRT_SIZE for 32-bit
 	 * kernel, whereas for 64-bit kernel, the end of the virtual address
diff --git a/arch/riscv/mm/physaddr.c b/arch/riscv/mm/physaddr.c
index 19cf25a74ee2..5ae4bd166e25 100644
--- a/arch/riscv/mm/physaddr.c
+++ b/arch/riscv/mm/physaddr.c
@@ -33,3 +33,19 @@ phys_addr_t __phys_addr_symbol(unsigned long x)
 	return __va_to_pa_nodebug(x);
 }
 EXPORT_SYMBOL(__phys_addr_symbol);
+
+phys_addr_t linear_mapping_va_to_pa(unsigned long x)
+{
+	BUG_ON(!kernel_map.va_pa_offset);
+
+	return ((unsigned long)(x) - kernel_map.va_pa_offset);
+}
+EXPORT_SYMBOL(linear_mapping_va_to_pa);
+
+void *linear_mapping_pa_to_va(unsigned long x)
+{
+	BUG_ON(!kernel_map.va_pa_offset);
+
+	return ((void *)((unsigned long)(x) + kernel_map.va_pa_offset));
+}
+EXPORT_SYMBOL(linear_mapping_pa_to_va);
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 7b571a631639..012554445054 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -895,8 +895,13 @@ static void __early_init_dt_declare_initrd(unsigned long start,
 	 * enabled since __va() is called too early. ARM64 does make use
 	 * of phys_initrd_start/phys_initrd_size so we can skip this
 	 * conversion.
+	 * On RISCV64, the usage of __va() before the linear mapping exists
+	 * is wrong and RISCV64 rightly calls reserve_initrd_mem after it is
+	 * available where it actually resets the translation that is done
+	 * here and re-computes it.
 	 */
-	if (!IS_ENABLED(CONFIG_ARM64)) {
+	if (!IS_ENABLED(CONFIG_ARM64) &&
+	    !(IS_ENABLED(CONFIG_RISCV) && IS_ENABLED(CONFIG_64BIT))) {
 		initrd_start = (unsigned long)__va(start);
 		initrd_end = (unsigned long)__va(end);
 		initrd_below_start_ok = 1;
-- 
2.37.2

