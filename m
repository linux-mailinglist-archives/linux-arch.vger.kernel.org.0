Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614284F0268
	for <lists+linux-arch@lfdr.de>; Sat,  2 Apr 2022 15:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355789AbiDBNjx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 2 Apr 2022 09:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355654AbiDBNjf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 2 Apr 2022 09:39:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1473100E37;
        Sat,  2 Apr 2022 06:37:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85A7161481;
        Sat,  2 Apr 2022 13:37:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605D6C34110;
        Sat,  2 Apr 2022 13:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648906646;
        bh=UEwTRlZAy4kLlmbBNaeoYiWupFPI5fJMOID0/hv13uY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QTnIZy0YhYFXQ9utl0bKoNuLWtbPgY+e5FekJ0ZuB8OA1oah/wyqrw/RhQ/6JhrxX
         hHR5t1Ycmd2XwH8vu1d6ryDvl9hdMhee4pUbFH8UZafMPmhtw2XovNZkgjG988WRee
         m6SgYyBcWC7bn0CnkVX9NMJjyabByjixe1JbxD/S/pDiUm6OOqgzyxJJnak6Cp5bXY
         ljTOodtzHT9HbhP1WkV0zJy34qXnC+wHf75rmkCBcCV4e4U9DrBjCd6a2PNSTfwioV
         ByuYHArHmLZuuJQSA9NRhncEB8qZMIbYigG3PhtfJiWSJY8q1s/v+xNaQ3e6FRrQhA
         d6GiN9xj4fqYQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, hch@lst.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, heiko@sntech.de, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V10 15/20] riscv: compat: Add hw capability check for elf
Date:   Sat,  2 Apr 2022 21:35:39 +0800
Message-Id: <20220402133544.2690231-16-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220402133544.2690231-1-guoren@kernel.org>
References: <20220402133544.2690231-1-guoren@kernel.org>
MIME-Version: 1.0
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

Detect hardware COMPAT (32bit U-mode) capability in rv64. If not
support COMPAT mode in hw, compat_elf_check_arch would return
false by compat_binfmt_elf.c

Add CLASS to enhance (compat_)elf_check_arch to distinguish
32BIT/64BIT elf.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/include/asm/elf.h |  6 ++++--
 arch/riscv/kernel/process.c  | 28 ++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
index a234656cfb5d..754fdb8cee96 100644
--- a/arch/riscv/include/asm/elf.h
+++ b/arch/riscv/include/asm/elf.h
@@ -33,9 +33,11 @@
 /*
  * This is used to ensure we don't load something for the wrong architecture.
  */
-#define elf_check_arch(x) ((x)->e_machine == EM_RISCV)
+#define elf_check_arch(x) (((x)->e_machine == EM_RISCV) && \
+			   ((x)->e_ident[EI_CLASS] == ELF_CLASS))
 
-#define compat_elf_check_arch(x) ((x)->e_machine == EM_RISCV)
+extern bool compat_elf_check_arch(Elf32_Ehdr *hdr);
+#define compat_elf_check_arch	compat_elf_check_arch
 
 #define CORE_DUMP_USE_REGSET
 #define ELF_EXEC_PAGESIZE	(PAGE_SIZE)
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 8c7665481a9f..203fdaa3f9e2 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -83,6 +83,34 @@ void show_regs(struct pt_regs *regs)
 		dump_backtrace(regs, NULL, KERN_DEFAULT);
 }
 
+#ifdef CONFIG_COMPAT
+static bool compat_mode_supported __read_mostly;
+
+bool compat_elf_check_arch(Elf32_Ehdr *hdr)
+{
+	return compat_mode_supported &&
+	       hdr->e_machine == EM_RISCV &&
+	       hdr->e_ident[EI_CLASS] == ELFCLASS32;
+}
+
+static int __init compat_mode_detect(void)
+{
+	unsigned long tmp = csr_read(CSR_STATUS);
+
+	csr_write(CSR_STATUS, (tmp & ~SR_UXL) | SR_UXL_32);
+	compat_mode_supported =
+			(csr_read(CSR_STATUS) & SR_UXL) == SR_UXL_32;
+
+	csr_write(CSR_STATUS, tmp);
+
+	pr_info("riscv: ELF compat mode %s",
+			compat_mode_supported ? "supported" : "failed");
+
+	return 0;
+}
+early_initcall(compat_mode_detect);
+#endif
+
 void start_thread(struct pt_regs *regs, unsigned long pc,
 	unsigned long sp)
 {
-- 
2.25.1

