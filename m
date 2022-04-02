Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B3E4F0358
	for <lists+linux-arch@lfdr.de>; Sat,  2 Apr 2022 15:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355982AbiDBN4f (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 2 Apr 2022 09:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356013AbiDBN4M (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 2 Apr 2022 09:56:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF96E13E28;
        Sat,  2 Apr 2022 06:54:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C93761469;
        Sat,  2 Apr 2022 13:54:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4E1C340EE;
        Sat,  2 Apr 2022 13:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648907643;
        bh=mPzTkgatSK8CCYcJZRjjnRIhaMHdvygHIPXND8TxesM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aqyg1+SuT47jW0l0Z95gDGTCWRx0sbbee6U5vQdylwsfXlX0GVU7N7EANgaKwWAzk
         PhQu7eBbPpwFQxnsa0h1PWbUrGbIZ9fHVcD6zSC40lS0IS6YhYEgAwc+fRShN4wPIE
         5SmkcKUvT1m7959oBzosRRky8DCiitQ7pIIlWMx63//7Lk+vzIBiMB7OAxeXFc/3Ce
         0VkxcGF+lRuIE7BWMnx8LDMzAcc3mDfO/ztazSidmPOWD2v4F6Yn3i5YB5w2kB81bq
         7mJsZvnVUD5LqDuAexqkWJZq1mKvi9Wg+iHDI0G8MOGOSKxm3V7zYART6SG2yhMLlj
         5rbrosHcu4URQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, hch@lst.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, heiko@sntech.de, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V11 10/20] riscv: compat: Support TASK_SIZE for compat mode
Date:   Sat,  2 Apr 2022 21:52:46 +0800
Message-Id: <20220402135256.2691868-11-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220402135256.2691868-1-guoren@kernel.org>
References: <20220402135256.2691868-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Make TASK_SIZE from const to dynamic detect TIF_32BIT flag
function. Refer to arm64 to implement DEFAULT_MAP_WINDOW_64 for
efi-stub.

Limit 32-bit compatible process in 0-2GB virtual address range
(which is enough for real scenarios), because it could avoid
address sign extend problem when 32-bit enter 64-bit and ease
software design.

The standard 32-bit TASK_SIZE is 0x9dc00000:FIXADDR_START, and
compared to a compatible 32-bit, it increases 476MB for the
application's virtual address.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/riscv/include/asm/pgtable.h   | 13 +++++++++++--
 arch/riscv/include/asm/processor.h |  6 +++++-
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index e3549e50de95..afdc9ece2ba4 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -705,8 +705,17 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
  * 63–48 all equal to bit 47, or else a page-fault exception will occur."
  */
 #ifdef CONFIG_64BIT
-#define TASK_SIZE      (PGDIR_SIZE * PTRS_PER_PGD / 2)
-#define TASK_SIZE_MIN  (PGDIR_SIZE_L3 * PTRS_PER_PGD / 2)
+#define TASK_SIZE_64	(PGDIR_SIZE * PTRS_PER_PGD / 2)
+#define TASK_SIZE_MIN	(PGDIR_SIZE_L3 * PTRS_PER_PGD / 2)
+
+#ifdef CONFIG_COMPAT
+#define TASK_SIZE_32	(_AC(0x80000000, UL) - PAGE_SIZE)
+#define TASK_SIZE	(test_thread_flag(TIF_32BIT) ? \
+			 TASK_SIZE_32 : TASK_SIZE_64)
+#else
+#define TASK_SIZE	TASK_SIZE_64
+#endif
+
 #else
 #define TASK_SIZE	FIXADDR_START
 #define TASK_SIZE_MIN	TASK_SIZE
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 0749924d9e55..21c8072dce17 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -19,7 +19,11 @@
 #define TASK_UNMAPPED_BASE	PAGE_ALIGN(TASK_SIZE / 3)
 
 #define STACK_TOP		TASK_SIZE
-#define STACK_TOP_MAX		STACK_TOP
+#ifdef CONFIG_64BIT
+#define STACK_TOP_MAX		TASK_SIZE_64
+#else
+#define STACK_TOP_MAX		TASK_SIZE
+#endif
 #define STACK_ALIGN		16
 
 #ifndef __ASSEMBLY__
-- 
2.25.1

