Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD5D70827E
	for <lists+linux-arch@lfdr.de>; Thu, 18 May 2023 15:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjERNQs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 May 2023 09:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjERNQW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 May 2023 09:16:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D5F2129;
        Thu, 18 May 2023 06:15:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3A3E60B5F;
        Thu, 18 May 2023 13:14:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591ACC4339B;
        Thu, 18 May 2023 13:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684415674;
        bh=qCpMPb52tthAzWjTWrS3Ez2Gh56jo5/cV/qoXhNQ0vM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SLWWWIPvdfekKIZ2DxDQt3ndwgs9Elm0COQLac0Rt9k1JespW6tf+PvRnJOQVd7tg
         lncnDcGrZbv7tZRJqImpTAd0dGU0mlf7gW2HmKzWHk7/voeo3Nx55OuPWH0mxjAwA/
         0CvUsOr48QIsVUrcLiY/Jk04fBahXRUnwHGUVhNQ65P3p0QVW0MtMu6d3JzqbdeIJU
         TSx0eo63ZrKxmVnbIQOB33Vzs0D4X9Ds0UGZMS+i6RB9lblXdE1VEcvKNoPp0puZ1s
         8wiPjcn2n+bAjfX4rTVMn3OGCVhwhS8MWg0zREQSOha7VukOMSvbaIuFNO9QMhzLvn
         5DvA0X36Fyv2w==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, mark.rutland@arm.com, bjorn@kernel.org,
        paul.walmsley@sifive.com, catalin.marinas@arm.com, will@kernel.org,
        rppt@kernel.org, anup@brainfault.org, shihua@iscas.ac.cn,
        jiawei@iscas.ac.cn, liweiwei@iscas.ac.cn, luxufan@iscas.ac.cn,
        chunyu@iscas.ac.cn, tsu.yubo@gmail.com, wefu@redhat.com,
        wangjunqiang@iscas.ac.cn, kito.cheng@sifive.com,
        andy.chiu@sifive.com, vincent.chen@sifive.com,
        greentime.hu@sifive.com, corbet@lwn.net, wuwei2016@iscas.ac.cn,
        jrtc27@jrtc27.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [RFC PATCH 20/22] riscv: s64ilp32: Add rv64ilp32_defconfig
Date:   Thu, 18 May 2023 09:10:11 -0400
Message-Id: <20230518131013.3366406-21-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230518131013.3366406-1-guoren@kernel.org>
References: <20230518131013.3366406-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Follow the rv32_defconfig rule to add rv64ilp32_defconfig; the only
difference is:
-CONFIG_ARCH_RV32I=y
+CONFIG_ARCH_RV64ILP32=y

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/Makefile               | 4 ++++
 arch/riscv/configs/64ilp32.config | 2 ++
 2 files changed, 6 insertions(+)
 create mode 100644 arch/riscv/configs/64ilp32.config

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index d47ba6b09b41..22b62de62192 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -187,3 +187,7 @@ rv32_defconfig:
 PHONY += rv32_nommu_virt_defconfig
 rv32_nommu_virt_defconfig:
 	$(Q)$(MAKE) -f $(srctree)/Makefile nommu_virt_defconfig 32-bit.config
+
+PHONY += rv64ilp32_defconfig
+rv64ilp32_defconfig:
+	$(Q)$(MAKE) -f $(srctree)/Makefile defconfig 64ilp32.config
diff --git a/arch/riscv/configs/64ilp32.config b/arch/riscv/configs/64ilp32.config
new file mode 100644
index 000000000000..7d836aa2fae7
--- /dev/null
+++ b/arch/riscv/configs/64ilp32.config
@@ -0,0 +1,2 @@
+CONFIG_ARCH_RV64ILP32=y
+CONFIG_NONPORTABLE=y
-- 
2.36.1

