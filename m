Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC54741C792
	for <lists+linux-arch@lfdr.de>; Wed, 29 Sep 2021 16:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344677AbhI2O7Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Sep 2021 10:59:25 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:60396
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344800AbhI2O7Y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Sep 2021 10:59:24 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 230D240603
        for <linux-arch@vger.kernel.org>; Wed, 29 Sep 2021 14:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632927463;
        bh=OQKNU2zsWxm9Jo/LuBgWw8xEdpf0SBZ+oU39CLxAstw=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=Efdf0ixdBezoNZH6rdVsJR1NZPjs5HRENkR71h6pI7bGNZ5qhPrur4JNGQhsl9ft5
         lBb6Lmjsx6yyGpbfp9p1jwA52lSdtfXu4hJoKxHMLjMtWyq2WY+a2iol2c6XOj2fos
         nsY1GpHBmuLr0EQ+ajKS0HW+45WCdzZ5uEw1IhzHqzQ/u8yfjYZ5s6ry/NliNkiXQT
         5PAKDDAE7jYyqsTwyCAuPXFrZhPWSG86ybNjsLN1JFIYv3yG5hZnDcOTb6aWRP8S9f
         k1nBlKodOLVNXDIo3OrAlJ0lrFpSYLrcLja5uNgcdUwv4GHj0MwLxWSayafX9eGxpq
         ObcSOtwZj5Waw==
Received: by mail-wm1-f72.google.com with SMTP id n30-20020a05600c3b9e00b002fbbaada5d7so2819457wms.7
        for <linux-arch@vger.kernel.org>; Wed, 29 Sep 2021 07:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OQKNU2zsWxm9Jo/LuBgWw8xEdpf0SBZ+oU39CLxAstw=;
        b=OpmIoMHBzmkrlAgtQFK984kwrGIMqGnjL/QNCZtGFhaAn0UvzESxTU8rxgsr0QzMSL
         mda1fgFotsrRKnC2vJHrQaxIIPtF2BHJcEyHYiKejzY/EOk+k91Xh8wSspfzXfKETNrn
         HVvdXN7OShwM6KW9IxOAvm9PjHxVwOFQ2zGtupEQTDPGAUuHEt5iVAsiy1AJLLd3ZE43
         oZoQoN2vHK98H3m+yBt1Ethw6DVc5IRUZcpoGa77AsyHUxcnjuIUT5OHN3EC7kcJ+pKc
         6BluNFQWG2BPJjgwD/EF8GK+2cGxxWF4Yc3ZWxJEk6JLYlvm4LSeKnMA9As/YQF8nH11
         yZlA==
X-Gm-Message-State: AOAM530+zDce78yVtLmuQWCntfY2P78zjcxMyrk1w0B3ox9ANySKdEkT
        5XzviGi09EOZrC6rpq/22qkk26sC748+vQ15VX5k9gY9DHtwpbVLjjxv/tfyMZdoA/P2fUsZSwO
        8PaV8iYjkrLsTdXsNemAV3xoU69u1yrs2JI8n3rQ=
X-Received: by 2002:adf:a4cf:: with SMTP id h15mr370300wrb.56.1632927462556;
        Wed, 29 Sep 2021 07:57:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWeSWC8Cet11Ro5/xO8f14KgL4rhrNIaUyTxHnc/lR/+aHCeqyv0GI/LbfJlrDouaKDo8Q7w==
X-Received: by 2002:adf:a4cf:: with SMTP id h15mr370287wrb.56.1632927462418;
        Wed, 29 Sep 2021 07:57:42 -0700 (PDT)
Received: from alex.home (lfbn-lyo-1-470-249.w2-7.abo.wanadoo.fr. [2.7.60.249])
        by smtp.gmail.com with ESMTPSA id a25sm1888009wmj.34.2021.09.29.07.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 07:57:42 -0700 (PDT)
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
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH v2 06/10] riscv: Explicit comment about user virtual address space size
Date:   Wed, 29 Sep 2021 16:51:09 +0200
Message-Id: <20210929145113.1935778-7-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210929145113.1935778-1-alexandre.ghiti@canonical.com>
References: <20210929145113.1935778-1-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Define precisely the size of the user accessible virtual space size
for sv32/39/48 mmu types and explain why the whole virtual address
space is split into 2 equal chunks between kernel and user space.

Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/include/asm/pgtable.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 2f92d61237b4..fd37cc45ef2a 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -664,6 +664,15 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 /*
  * Task size is 0x4000000000 for RV64 or 0x9fc00000 for RV32.
  * Note that PGDIR_SIZE must evenly divide TASK_SIZE.
+ * Task size is:
+ * -     0x9fc00000 (~2.5GB) for RV32.
+ * -   0x4000000000 ( 256GB) for RV64 using SV39 mmu
+ * - 0x800000000000 ( 128TB) for RV64 using SV48 mmu
+ *
+ * Note that PGDIR_SIZE must evenly divide TASK_SIZE since "RISC-V
+ * Instruction Set Manual Volume II: Privileged Architecture" states that
+ * "load and store effective addresses, which are 64bits, must have bits
+ * 63–48 all equal to bit 47, or else a page-fault exception will occur."
  */
 #ifdef CONFIG_64BIT
 #define TASK_SIZE      (PGDIR_SIZE * PTRS_PER_PGD / 2)
-- 
2.30.2

