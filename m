Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E8D4C5D42
	for <lists+linux-arch@lfdr.de>; Sun, 27 Feb 2022 17:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbiB0Qb1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 27 Feb 2022 11:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbiB0QbA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 27 Feb 2022 11:31:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121D55C35D;
        Sun, 27 Feb 2022 08:30:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B85E0B80CE4;
        Sun, 27 Feb 2022 16:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939ACC36AE5;
        Sun, 27 Feb 2022 16:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645979420;
        bh=YHBMf6oiN7AKyDQcRFQG6drB0b2sg1GEQLG12pVdvWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GUC/ztJbtzLNu8llpuROUVaZ3E8NyrDFD8yGwy4K8tYgwlx9qdXJqpr8G1CUuJLuL
         SQs9N9tJ6CzjqSEvgs9Q+TmAF2tzmIMQd1dQI3B3UPxULabUxNCkqiYJ/czct+Gq8k
         KuRJjLlgK7fwONb/BsASgTeV3DEsjRYmt6jxDwb7SNswxhumCHq3u385kgUhioQ0Dd
         GHagwTVSEYjk9hyTY2I+qdz6jk0jJtZtezgxQZil86wm9jjug9Y0MLcB7luMCIyN4l
         1F5iB1y8UdGZ0BymhjWAqVsaqnV10+qDR2K6/0tp1NrDeZSHAwDHvotDFZ6/eNGZ9t
         VccjUEfu+whlw==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, arnd@arndb.de,
        anup@brainfault.org, gregkh@linuxfoundation.org,
        liush@allwinnertech.com, wefu@redhat.com, drew@beagleboard.org,
        wangjunqiang@iscas.ac.cn, hch@lst.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V7 15/20] riscv: compat: Add hw capability check for elf
Date:   Mon, 28 Feb 2022 00:28:26 +0800
Message-Id: <20220227162831.674483-16-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220227162831.674483-1-guoren@kernel.org>
References: <20220227162831.674483-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/include/asm/elf.h |  3 ++-
 arch/riscv/kernel/process.c  | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
index aee40040917b..3a4293dc7229 100644
--- a/arch/riscv/include/asm/elf.h
+++ b/arch/riscv/include/asm/elf.h
@@ -40,7 +40,8 @@
  * elf64_hdr e_machine's offset are different. The checker is
  * a little bit simple compare to other architectures.
  */
-#define compat_elf_check_arch(x) ((x)->e_machine == EM_RISCV)
+extern bool compat_elf_check_arch(Elf32_Ehdr *hdr);
+#define compat_elf_check_arch	compat_elf_check_arch
 
 #define CORE_DUMP_USE_REGSET
 #define ELF_EXEC_PAGESIZE	(PAGE_SIZE)
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 54787ca9806a..7bbe4dd95e85 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -83,6 +83,32 @@ void show_regs(struct pt_regs *regs)
 		dump_backtrace(regs, NULL, KERN_DEFAULT);
 }
 
+#ifdef CONFIG_COMPAT
+static bool compat_mode_supported __read_mostly;
+
+bool compat_elf_check_arch(Elf32_Ehdr *hdr)
+{
+	return compat_mode_supported && hdr->e_machine == EM_RISCV;
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

