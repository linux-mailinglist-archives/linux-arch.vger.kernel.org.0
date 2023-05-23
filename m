Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70F970E2EA
	for <lists+linux-arch@lfdr.de>; Tue, 23 May 2023 19:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238007AbjEWRGj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 May 2023 13:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237980AbjEWRGZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 May 2023 13:06:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFCCDA;
        Tue, 23 May 2023 10:06:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0B91634C3;
        Tue, 23 May 2023 17:06:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4BE7C4339B;
        Tue, 23 May 2023 17:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684861583;
        bh=J4geLF9/wB/nci7eyTPzHGp1IQrIjTH306iCGvwIsQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tzqNIne/apjydPkehRRhk/0O0hkReo4pjcZtGnV4WX7abAD5K4e3kuBRAVahk8os8
         NaRieZa7LqgDjJyjU1AXbv8j08bEFYKRnT2K5WaUoYsQG7u6dbZmYRa4w1lrVkLGKk
         AfNwCokEOjU34OHzwDt15ZOWzmY2EYcrAgK1lSiNg/G/2OrctV9LzlJcKjD0Xx2O5K
         5QLRx+rWuzOuVStoft7q68LYRA02Ic6uHJtnWRJcDd5b682rKLWJKDIChj3ot3PNGU
         Oph96bKhybNTihKFHNrXw/h8maDWRzFbCZ2O4FrUuNE1nqNc9I2eedAOXS8Uji5dXA
         KoeOlvBux09Rg==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Zhangjin Wu <falcon@tinylab.org>,
        Guo Ren <guoren@kernel.org>, Bin Meng <bmeng@tinylab.org>
Subject: [PATCH v2 4/4] riscv: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Date:   Wed, 24 May 2023 00:55:02 +0800
Message-Id: <20230523165502.2592-5-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230523165502.2592-1-jszhang@kernel.org>
References: <20230523165502.2592-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Zhangjin Wu <falcon@tinylab.org>

Select CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION for RISC-V, allowing
the user to enable dead code elimination. In order for this to work,
ensure that we keep the alternative table by annotating them with KEEP.

This boots well on qemu with both rv32_defconfig & rv64 defconfig, but
it only shrinks their builds by ~1%, a smaller config is thereforce
customized to test this feature:

          | rv32                   | rv64
  --------|------------------------|---------------------
   No DCE | 4460684                | 4893488
      DCE | 3986716                | 4376400
   Shrink |  473968 (~10.6%)       |  517088 (~10.5%)

The config used above only reserves necessary options to boot on qemu
with serial console, more like the size-critical embedded scenes:

  - rv64 config: https://pastebin.com/crz82T0s
  - rv32 config: rv64 config + 32-bit.config

Here is Jisheng's original commit-msg:
When trying to run linux with various opensource riscv core on
resource limited FPGA platforms, for example, those FPGAs with less
than 16MB SDRAM, I want to save mem as much as possible. One of the
major technologies is kernel size optimizations, I found that riscv
does not currently support HAVE_LD_DEAD_CODE_DATA_ELIMINATION, which
passes -fdata-sections, -ffunction-sections to CFLAGS and passes the
--gc-sections flag to the linker.

This not only benefits my case on FPGA but also benefits defconfigs.
Here are some notable improvements from enabling this with defconfigs:

nommu_k210_defconfig:
   text    data     bss     dec     hex
1112009  410288   59837 1582134  182436     before
 962838  376656   51285 1390779  1538bb     after

rv32_defconfig:
   text    data     bss     dec     hex
8804455 2816544  290577 11911576 b5c198     before
8692295 2779872  288977 11761144 b375f8     after

defconfig:
   text    data     bss     dec     hex
9438267 3391332  485333 13314932 cb2b74     before
9285914 3350052  483349 13119315 c82f53     after

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
Co-developed-by: Jisheng Zhang <jszhang@kernel.org>
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Guo Ren <guoren@kernel.org>
Tested-by: Bin Meng <bmeng@tinylab.org>
---
 arch/riscv/Kconfig              | 1 +
 arch/riscv/kernel/vmlinux.lds.S | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 8f55aa4aae34..62e84fee2cfd 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -115,6 +115,7 @@ config RISCV
 	select HAVE_KPROBES if !XIP_KERNEL
 	select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
 	select HAVE_KRETPROBES if !XIP_KERNEL
+	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
 	select HAVE_MOVE_PMD
 	select HAVE_MOVE_PUD
 	select HAVE_PCI
diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index e5f9f4677bbf..492dd4b8f3d6 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -85,11 +85,11 @@ SECTIONS
 	INIT_DATA_SECTION(16)
 
 	.init.pi : {
-		*(.init.pi*)
+		KEEP(*(.init.pi*))
 	}
 
 	.init.bss : {
-		*(.init.bss)	/* from the EFI stub */
+		KEEP(*(.init.bss*))	/* from the EFI stub */
 	}
 	.exit.data :
 	{
@@ -112,7 +112,7 @@ SECTIONS
 	. = ALIGN(8);
 	.alternative : {
 		__alt_start = .;
-		*(.alternative)
+		KEEP(*(.alternative))
 		__alt_end = .;
 	}
 	__init_end = .;
-- 
2.40.1

