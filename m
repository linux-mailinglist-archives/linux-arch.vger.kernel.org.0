Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1301839CE51
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jun 2021 11:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhFFJHl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 05:07:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230178AbhFFJHe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 6 Jun 2021 05:07:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6CFD61429;
        Sun,  6 Jun 2021 09:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622970345;
        bh=up6MI09XxUOny0rsrKOJu1japPKIJnaYG9XFipf9Ric=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QDyGyevpWmoRQQnZeg+GC1blL4gLIm6F+O2h7coAarAwFi1UbAdal76AOAdtdKTAd
         0YavnUi0Fp1tQNs2BFAIz4eDq4rSPPxS2HnGRftJ5VENFj5Fa8Y4vePN+0YnapzJHs
         nmByx4jFku0vrNN0uZCTkDaVdgxc58lW21Ag1yMWnSrB2XQr2FRVUau0UTsL98HGb9
         3kIWbW4+yjH0eqfSrO2HByUBDAiB37iH+r9JgEA8P3KhUyEdCwDhENXnDeo+JANNEf
         wQtrkAXlPqxcF3mBaCydUv46FDYFOrFcfTP9G0UVr+/3rH+Wg/Ldni+IGRzbotkCJh
         ew07KYtkyu42w==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup.patel@wdc.com, palmerdabbelt@google.com,
        arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        drew@beagleboard.org, liush@allwinnertech.com,
        lazyparser@gmail.com, wefu@redhat.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Guo Ren <guoren@linux.alibaba.com>,
        Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [RFC PATCH v2 10/11] riscv: soc: Add Allwinner SoC kconfig option
Date:   Sun,  6 Jun 2021 09:04:08 +0000
Message-Id: <1622970249-50770-14-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622970249-50770-1-git-send-email-guoren@kernel.org>
References: <1622970249-50770-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Add Allwinner kconfig option which selects SoC specific and common
drivers that is required for this SoC.

Allwinner D1 uses custom PTE attributes to solve non-coherency SOC
interconnect issues for dma synchronization, so we set the default
value when SOC_SUNXI selected.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Co-Developed-by: Liu Shaohua <liush@allwinnertech.com>
Signed-off-by: Liu Shaohua <liush@allwinnertech.com>
Cc: Anup Patel <anup.patel@wdc.com>
Cc: Atish Patra <atish.patra@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Drew Fustini <drew@beagleboard.org>
Cc: Maxime Ripard <maxime@cerno.tech>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
Cc: Wei Fu <wefu@redhat.com>
Cc: Wei Wu <lazyparser@gmail.com>
---
 arch/riscv/Kconfig.socs      | 12 ++++++++++++
 arch/riscv/configs/defconfig |  1 +
 2 files changed, 13 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index ed96376..055fb3e 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -69,4 +69,16 @@ config SOC_CANAAN_K210_DTB_SOURCE
 
 endif
 
+config SOC_SUNXI
+	bool "Allwinner SoCs"
+	depends on MMU
+	select DWMAC_GENERIC
+	select SERIAL_8250
+	select SERIAL_8250_CONSOLE
+	select SERIAL_8250_DW
+	select SIFIVE_PLIC
+	select STMMAC_ETH
+	help
+	  This enables support for Allwinner SoC platforms like the D1.
+
 endmenu
diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 1f2be23..9e83d14 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -15,6 +15,7 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 CONFIG_BPF_SYSCALL=y
 CONFIG_SOC_SIFIVE=y
+CONFIG_SOC_SUNXI=y
 CONFIG_SOC_VIRT=y
 CONFIG_SOC_MICROCHIP_POLARFIRE=y
 CONFIG_SMP=y
-- 
2.7.4

