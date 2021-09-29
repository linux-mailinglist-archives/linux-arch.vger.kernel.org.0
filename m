Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFFD41C75B
	for <lists+linux-arch@lfdr.de>; Wed, 29 Sep 2021 16:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344734AbhI2OyS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Sep 2021 10:54:18 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:59954
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344730AbhI2OyR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Sep 2021 10:54:17 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E897B40602
        for <linux-arch@vger.kernel.org>; Wed, 29 Sep 2021 14:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632927155;
        bh=w+ItQrTCaMVUbpdrDeVWHNI7WQYLMpa9OWlT3PsgkZk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=jLgiigb2Vwqoeg/f6t/hPp3LnBahYrX+h9T7RAVmMAUP4uavoezOXeZj/pmr0TrG4
         s/Mo19GDJUlWXBgDSFo3HkslBe5R32uqzNEPr4pc6eJMzAmpa9XGrqTA/JMfu4mYEi
         BVVGkU7IrDCkAg5qsx+fCtLRMVy9RVV1Rwh98fkVFnrxFnDgzwFqXUCMyEAdy7aREG
         Sl8MUDuj/U6+kM6MDk0OtyEk8KLdvc/Fd8R9YIbK0C4w98As8C1sdfXyOUMiTPGQiQ
         vegu0TNFNhi8Tj4qg78CNpu7WBbQzKfUrmDG3VETqdHivt8VjVoL8PG8HYF1gC7u64
         PRgOiz1B4O0uQ==
Received: by mail-wr1-f70.google.com with SMTP id c2-20020adfa302000000b0015e4260febdso684893wrb.20
        for <linux-arch@vger.kernel.org>; Wed, 29 Sep 2021 07:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w+ItQrTCaMVUbpdrDeVWHNI7WQYLMpa9OWlT3PsgkZk=;
        b=qhUZsbsNK5MQtqGLWukRODU0gyB4280ZExgpSLt/B6QwH2p8U4fKd+pSjKQUm3hgx9
         Nn8cAuMzPasEeWRB1ZPxX2/GIHZMZpU1PMI+gQkU4ptsjkC6NEzAmUqNdtD19jl7TIKT
         vDyw+uir5G4qoBpZRty9psge7q7m9/bFIKEj3SWR1se63sfSbSy3HCZfXU2F+xJzVq3d
         Kne+lrMePb7hfEjo9tmdN1CIbvM0iWfGstyi9CXa36AbtVThGg3EpWC6UMpLfqqSGXdf
         LdVVYz2attgCZbYtsX80UnDb9RI4o1wwPz3Q1ZWPDy9q3j8k7e6YU3VTKZd7P7w14DZY
         2j9A==
X-Gm-Message-State: AOAM5331qZOxFoASrHZMlzS3BJlNwOggQTGvQqYw7E2UP4HZPK10UbnF
        UPMCRyFOT3vRf7+sE0SXY7XOA4jMK8bur71g2t3QHp7p9F1SRuqDFzZysXc4WYdbQA3/S8KIrnZ
        5W+HG54vVzOL8B6MkkHomqJhhsL0B5xGUI0xsrMQ=
X-Received: by 2002:adf:de86:: with SMTP id w6mr253968wrl.287.1632927155217;
        Wed, 29 Sep 2021 07:52:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtHf+BUoKNP9WjhKmbVbOYrY4zs5f5NWeWpOsBJLJB1JCsonTpkjp5Ui+UI2TvrZXfYZZpmg==
X-Received: by 2002:adf:de86:: with SMTP id w6mr253923wrl.287.1632927155024;
        Wed, 29 Sep 2021 07:52:35 -0700 (PDT)
Received: from alex.home (lfbn-lyo-1-470-249.w2-7.abo.wanadoo.fr. [2.7.60.249])
        by smtp.gmail.com with ESMTPSA id k11sm104889wrn.84.2021.09.29.07.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 07:52:34 -0700 (PDT)
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        Atish Patra <Atish.Patra@wdc.com>,
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
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-efi@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Subject: [PATCH v2 01/10] riscv: Allow to dynamically define VA_BITS
Date:   Wed, 29 Sep 2021 16:51:04 +0200
Message-Id: <20210929145113.1935778-2-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210929145113.1935778-1-alexandre.ghiti@canonical.com>
References: <20210929145113.1935778-1-alexandre.ghiti@canonical.com>
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
 arch/riscv/include/asm/pgtable.h   | 10 ++++++++--
 arch/riscv/include/asm/sparsemem.h |  6 +++++-
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c1abbc876e5b..ee61ecae3ae0 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -145,16 +145,6 @@ config MMU
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
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 39b550310ec6..e3e03226a50a 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -48,8 +48,14 @@
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
@@ -651,7 +657,7 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
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
2.30.2

