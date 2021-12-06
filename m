Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A433469451
	for <lists+linux-arch@lfdr.de>; Mon,  6 Dec 2021 11:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240289AbhLFKyw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Dec 2021 05:54:52 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:47728
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241532AbhLFKyv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Dec 2021 05:54:51 -0500
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0D7053F1F8
        for <linux-arch@vger.kernel.org>; Mon,  6 Dec 2021 10:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638787882;
        bh=RhDgG2MxbU+/Y0zOamju9twdysjbp89/nSRpYLjOzDo=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=EZSOK1AVJxLzFhy1hQndtmSno+l8c0w2dBLT1LdgxKGfGeRIevhudllsKmH/7Wbzj
         gNQNx2h7n5EkoKQa3g9WUM/aJTq1OrYgI8gt8Zj/f2AjoFxBjGbpp4IWhFzVfptY+K
         tE58tSIvdR8pBYejOFcicRG5vlqBjuLymw/yWO+G2dlBBuDGu3ewrdK21NXrdqk9XO
         gfOQInChsiB3aRtD2ofmlt9wdC/lLkFkT4N4ZEtX+HfAcIcPfMgc4F2QQuPT9GQHh+
         idsB39ZNf0aY3gRYV7HOgLUTl9qgXBMHvFIckC71dRKPEnuodqlr3wz2fBpxD3y4Cg
         hzWbUEnAbhjYA==
Received: by mail-wm1-f70.google.com with SMTP id v62-20020a1cac41000000b0033719a1a714so5912783wme.6
        for <linux-arch@vger.kernel.org>; Mon, 06 Dec 2021 02:51:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RhDgG2MxbU+/Y0zOamju9twdysjbp89/nSRpYLjOzDo=;
        b=q2548bbHCh5daRAZ3HKfxs7/Th95ICoGrsRKdqOe/vy75o2GWF7qE0l6xXBautjphB
         NH+ipZztJ7kXyhr6760y83ukn96iSmcL7SryV8yq9LqW9OTo98VGw0O68+Ffm9z+dv0d
         yNDJ0c97KlqPl2oI3mmAZ+MI4+TIjOXSOSYSuDmctSDjs5XY3k5ccpJwgHlI22lC3+gb
         QUOQ5H2X5YuDMkcR3DfUPICptJ5D7F5MeXAoikX6NUCNH4MtXJsO9Twn6vCUWJzwCiXJ
         dDZ1fgoXrqFPFw9zJo3VVELHkORwb6f/eyCUsTFtj82Lyk6hPb4yjG6leBFXx8Nk9VwB
         7IMg==
X-Gm-Message-State: AOAM530zH39Ktp0ydp9ofsQlZiYAPRwHhJu1TDDy4thZD3KaEWgIxBFA
        cqjnjzAbMdctiPxcd0kB6gC4haFLohENayspSGlBvA8wKecoiTb7QDvZ6v+ch+lH9sjYX9srtAp
        X67z6z4N0+NbgEecsmhnBdDBPmAJoF+Dp/URBDbE=
X-Received: by 2002:a1c:a503:: with SMTP id o3mr38875020wme.98.1638787881587;
        Mon, 06 Dec 2021 02:51:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwPNUdS2gHzFpdP33u94EGT3zHNk81HnKWbQmnp6Sv+KE5A/wBLYQgSvy6gAW+sq9ArPIrD7Q==
X-Received: by 2002:a1c:a503:: with SMTP id o3mr38874988wme.98.1638787881428;
        Mon, 06 Dec 2021 02:51:21 -0800 (PST)
Received: from localhost.localdomain (lfbn-lyo-1-470-249.w2-7.abo.wanadoo.fr. [2.7.60.249])
        by smtp.gmail.com with ESMTPSA id d2sm13816061wmb.24.2021.12.06.02.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 02:51:21 -0800 (PST)
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
Subject: [PATCH v3 04/13] riscv: Allow to dynamically define VA_BITS
Date:   Mon,  6 Dec 2021 11:46:48 +0100
Message-Id: <20211206104657.433304-5-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211206104657.433304-1-alexandre.ghiti@canonical.com>
References: <20211206104657.433304-1-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With 4-level page table folding at runtime, we don't know at compile time
the size of the virtual address space so we must set VA_BITS dynamically
so that sparsemem reserves the right amount of memory for struct pages.

Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
---
 arch/riscv/Kconfig                 | 10 ----------
 arch/riscv/include/asm/kasan.h     |  2 +-
 arch/riscv/include/asm/pgtable.h   | 10 ++++++++--
 arch/riscv/include/asm/sparsemem.h |  6 +++++-
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 6cd98ade5ebc..c3a167eea011 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -146,16 +146,6 @@ config MMU
 	  Select if you want MMU-based virtualised addressing space
 	  support by paged memory management. If unsure, say 'Y'.
 
-config VA_BITS
-	int
-	default 32 if 32BIT
-	default 39 if 64BIT
-
-config PA_BITS
-	int
-	default 34 if 32BIT
-	default 56 if 64BIT
-
 config PAGE_OFFSET
 	hex
 	default 0xC0000000 if 32BIT && MAXPHYSMEM_1GB
diff --git a/arch/riscv/include/asm/kasan.h b/arch/riscv/include/asm/kasan.h
index 2788e2c46609..743e6ff57996 100644
--- a/arch/riscv/include/asm/kasan.h
+++ b/arch/riscv/include/asm/kasan.h
@@ -27,7 +27,7 @@
  */
 #define KASAN_SHADOW_SCALE_SHIFT	3
 
-#define KASAN_SHADOW_SIZE	(UL(1) << ((CONFIG_VA_BITS - 1) - KASAN_SHADOW_SCALE_SHIFT))
+#define KASAN_SHADOW_SIZE	(UL(1) << ((VA_BITS - 1) - KASAN_SHADOW_SCALE_SHIFT))
 #define KASAN_SHADOW_START	(KASAN_SHADOW_END - KASAN_SHADOW_SIZE)
 #define KASAN_SHADOW_END	MODULES_LOWEST_VADDR
 #define KASAN_SHADOW_OFFSET	_AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index d34f3a7a9701..e1a52e22ad7e 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -50,8 +50,14 @@
  * struct pages to map half the virtual address space. Then
  * position vmemmap directly below the VMALLOC region.
  */
+#ifdef CONFIG_64BIT
+#define VA_BITS		39
+#else
+#define VA_BITS		32
+#endif
+
 #define VMEMMAP_SHIFT \
-	(CONFIG_VA_BITS - PAGE_SHIFT - 1 + STRUCT_PAGE_MAX_SHIFT)
+	(VA_BITS - PAGE_SHIFT - 1 + STRUCT_PAGE_MAX_SHIFT)
 #define VMEMMAP_SIZE	BIT(VMEMMAP_SHIFT)
 #define VMEMMAP_END	(VMALLOC_START - 1)
 #define VMEMMAP_START	(VMALLOC_START - VMEMMAP_SIZE)
@@ -653,7 +659,7 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
  * and give the kernel the other (upper) half.
  */
 #ifdef CONFIG_64BIT
-#define KERN_VIRT_START	(-(BIT(CONFIG_VA_BITS)) + TASK_SIZE)
+#define KERN_VIRT_START	(-(BIT(VA_BITS)) + TASK_SIZE)
 #else
 #define KERN_VIRT_START	FIXADDR_START
 #endif
diff --git a/arch/riscv/include/asm/sparsemem.h b/arch/riscv/include/asm/sparsemem.h
index 45a7018a8118..63acaecc3374 100644
--- a/arch/riscv/include/asm/sparsemem.h
+++ b/arch/riscv/include/asm/sparsemem.h
@@ -4,7 +4,11 @@
 #define _ASM_RISCV_SPARSEMEM_H
 
 #ifdef CONFIG_SPARSEMEM
-#define MAX_PHYSMEM_BITS	CONFIG_PA_BITS
+#ifdef CONFIG_64BIT
+#define MAX_PHYSMEM_BITS	56
+#else
+#define MAX_PHYSMEM_BITS	34
+#endif /* CONFIG_64BIT */
 #define SECTION_SIZE_BITS	27
 #endif /* CONFIG_SPARSEMEM */
 
-- 
2.32.0

