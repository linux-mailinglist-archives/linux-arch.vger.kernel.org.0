Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0A05B1273
	for <lists+linux-arch@lfdr.de>; Thu,  8 Sep 2022 04:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiIHCZb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Sep 2022 22:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiIHCZa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Sep 2022 22:25:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC6375383;
        Wed,  7 Sep 2022 19:25:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB737B81F9C;
        Thu,  8 Sep 2022 02:25:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6A6C43470;
        Thu,  8 Sep 2022 02:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662603926;
        bh=8F+Kx4X5IE8S8oO8XnXHjQy0E8HHBWecQqZQdnIaKB8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rYWzICvCoZ8dzW1XXbreUfthCkBdaO0GI5Iz8Cqu28p1eurnOp/dvs/DIH7cPJy0x
         /FSQPIORtyWOyGPLEnZWfQ0MwFmcMwkdvXwTSz/Y2xMcIe+Rotjty/jiDGw/oSvv83
         CxOURbwYchepSDqiYXDIPPpo92x9hTsEIOxuzNDklR6QKhhU4YFdwJBe9zmkrEt6Is
         qy4qbNQR2aFgHkeHIIL+6v2RchRkbxJFvTkBcY0/Tb5FxkFAH13dkdCwvT74ylcIxK
         6bO3oLp0myYp/geHVvuIzJrRsO6CXAJ2rQHa3ECanzEQKd+I9+Uh8kuy5UO3Nu2pn8
         yDa9C5AiSzwcg==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
        apatel@ventanamicro.com, atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, bigeasy@linutronix.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH V4 1/8] riscv: elf_kexec: Fixup compile warning
Date:   Wed,  7 Sep 2022 22:24:59 -0400
Message-Id: <20220908022506.1275799-2-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220908022506.1275799-1-guoren@kernel.org>
References: <20220908022506.1275799-1-guoren@kernel.org>
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

If CRYTPO or CRYPTO_SHA256 or KEXE_FILE is not enabled, then:

COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1
O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/

../arch/riscv/kernel/elf_kexec.c: In function 'elf_kexec_load':
../arch/riscv/kernel/elf_kexec.c:185:23: warning: variable
'kernel_start' set but not used [-Wunused-but-set-variable]
  185 |         unsigned long kernel_start;
      |                       ^~~~~~~~~~~~

Fixes: 838b3e28488f ("RISC-V: Load purgatory in kexec_file")
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 arch/riscv/kernel/elf_kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
index 0cb94992c15b..4b9264340b78 100644
--- a/arch/riscv/kernel/elf_kexec.c
+++ b/arch/riscv/kernel/elf_kexec.c
@@ -198,7 +198,7 @@ static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
 	if (ret)
 		goto out;
 	kernel_start = image->start;
-	pr_notice("The entry point of kernel at 0x%lx\n", image->start);
+	pr_notice("The entry point of kernel at 0x%lx\n", kernel_start);
 
 	/* Add the kernel binary to the image */
 	ret = riscv_kexec_elf_load(image, &ehdr, &elf_info,
-- 
2.36.1

