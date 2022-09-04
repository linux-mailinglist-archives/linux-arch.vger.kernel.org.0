Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2295AC335
	for <lists+linux-arch@lfdr.de>; Sun,  4 Sep 2022 09:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbiIDH2P (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 4 Sep 2022 03:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbiIDH1y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 4 Sep 2022 03:27:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561B145F73;
        Sun,  4 Sep 2022 00:27:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06F23B80D08;
        Sun,  4 Sep 2022 07:27:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9BEC433C1;
        Sun,  4 Sep 2022 07:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662276469;
        bh=SH3odaE6GEvQpUHPIHgK0HsZ+i7j0oLK9zGMjCOZqwY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S6Uk2vKyyFzTRAbEMqBc9RwhWgCbjPNCSWWgEp4wtltpB7dH6Mu70SuSR9Qg3+PjV
         mNl5a2rjf1CiO5A1lOMdFTMExg5dGJV1Hmwxugay2z4gkOthjQobifP0bfVEVyCIqB
         DytWtlElaR96/73q9c796K1jtpxwIGHpj0C2xTISiFgVMmdahNI7Tx7fIjGQDn+6kI
         b45Y7NW/QH39kVOfnwgJA0lnt3pof4/Rr4Rz/iHgYtYsA8gkfy772XT/6JBgZHj/2T
         xjIcGdvANFtSFD3m/NxEHGzBMkPfyXKfpkHRI0F5jw5mWIgUkNwfyOFvQ1tHqq+K5C
         M2z/EeC3wUQLg==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
        apatel@ventanamicro.com, atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH V2 5/6] riscv: elf_kexec: Fixup compile warning
Date:   Sun,  4 Sep 2022 03:26:36 -0400
Message-Id: <20220904072637.8619-6-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220904072637.8619-1-guoren@kernel.org>
References: <20220904072637.8619-1-guoren@kernel.org>
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

COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1
O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/

../arch/riscv/kernel/elf_kexec.c: In function 'elf_kexec_load':
../arch/riscv/kernel/elf_kexec.c:185:23: warning: variable
'kernel_start' set but not used [-Wunused-but-set-variable]
  185 |         unsigned long kernel_start;
      |                       ^~~~~~~~~~~~

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
---
 arch/riscv/kernel/elf_kexec.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
index 0cb94992c15b..bba3723a0914 100644
--- a/arch/riscv/kernel/elf_kexec.c
+++ b/arch/riscv/kernel/elf_kexec.c
@@ -182,7 +182,9 @@ static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
 	unsigned long new_kernel_pbase = 0UL;
 	unsigned long initrd_pbase = 0UL;
 	unsigned long headers_sz;
+#ifdef CONFIG_ARCH_HAS_KEXEC_PURGATORY
 	unsigned long kernel_start;
+#endif /* CONFIG_ARCH_HAS_KEXEC_PURGATORY */
 	void *fdt, *headers;
 	struct elfhdr ehdr;
 	struct kexec_buf kbuf;
@@ -197,7 +199,9 @@ static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
 			     &old_kernel_pbase, &new_kernel_pbase);
 	if (ret)
 		goto out;
+#ifdef CONFIG_ARCH_HAS_KEXEC_PURGATORY
 	kernel_start = image->start;
+#endif /* CONFIG_ARCH_HAS_KEXEC_PURGATORY */
 	pr_notice("The entry point of kernel at 0x%lx\n", image->start);
 
 	/* Add the kernel binary to the image */
-- 
2.36.1

