Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006CF645625
	for <lists+linux-arch@lfdr.de>; Wed,  7 Dec 2022 10:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiLGJLv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Dec 2022 04:11:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiLGJLd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Dec 2022 04:11:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E902EF49;
        Wed,  7 Dec 2022 01:11:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F45160AD9;
        Wed,  7 Dec 2022 09:11:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5C7C433C1;
        Wed,  7 Dec 2022 09:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670404291;
        bh=+J9p7r7GyvB7mtC2Mdp1scaM+ReAbPChQfWFGWWj1h0=;
        h=From:To:Cc:Subject:Date:From;
        b=tl/xFYFy8V/+HKRLUzMbUO6Uee5tvFcSoxaeua2JXpWVeYh8NpSHm/4lKQONTO2w5
         DpvaDNG1PV48NhUtybqbXDczK/IXTrnlGiv+mOtkAr2Lx7rPHg/X+9elCx2/ryxESZ
         Vvht0+A7QKoYiAyNEiEyvzlGKSXOgMLuYuRFgpKlfGyaIo9kfB3nlJZExSQXbsKKJV
         oOGJxqurKmJmyEPSXPWdukJtFIKY/n4of/0B5MpWU2k2sPXuuC/GeG60OuPndh7sLM
         6FdsH46Ff8ySPucL2aQYCjRsgKCVIsWVami23clsBioEvq2Fzo6GjhmNxpSk7yBcpa
         kzHIDBzQ6d8rQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@rivosinc.com, conor.dooley@microchip.com,
        liaochang1@huawei.com, lizhengyu3@huawei.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Conor Dooley <conor@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] riscv: Fixup compile error with !MMU
Date:   Wed,  7 Dec 2022 04:11:12 -0500
Message-Id: <20221207091112.2258674-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Current nommu_virt_defconfig can't compile:

In file included from
arch/riscv/kernel/crash_core.c:3:
arch/riscv/kernel/crash_core.c:
In function 'arch_crash_save_vmcoreinfo':
arch/riscv/kernel/crash_core.c:8:27:
error: 'VA_BITS' undeclared (first use in this function)
    8 |         VMCOREINFO_NUMBER(VA_BITS);
      |                           ^~~~~~~

Add MMU dependency for KEXEC_FILE.

Fixes: 6261586e0c91 ("RISC-V: Add kexec_file support")
Reported-by: Conor Dooley <conor@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/riscv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index ef8d66de5f38..91319044fd13 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -496,7 +496,7 @@ config KEXEC_FILE
 	select KEXEC_CORE
 	select KEXEC_ELF
 	select HAVE_IMA_KEXEC if IMA
-	depends on 64BIT
+	depends on 64BIT && MMU
 	help
 	  This is new version of kexec system call. This system call is
 	  file based and takes file descriptors as system call argument
-- 
2.36.1

