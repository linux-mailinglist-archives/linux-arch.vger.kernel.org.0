Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C30708270
	for <lists+linux-arch@lfdr.de>; Thu, 18 May 2023 15:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjERNPY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 May 2023 09:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjERNOh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 May 2023 09:14:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E2A1991;
        Thu, 18 May 2023 06:13:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9942364F3A;
        Thu, 18 May 2023 13:13:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566E6C433A1;
        Thu, 18 May 2023 13:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684415630;
        bh=8Y/3tw7LBtz2gYHWlOFw83dhZ7e45+M8w9YD/Nh3m5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FXqmOW0KY+kh3dWehn3iktiaucY523D75j1oLEu2DkJNTYeHrG0CTGeI+pQW5p9WT
         1VhHU8LKJg4V8guunv0uOqgA/bIkKJOerF+5A4BtxBY2lyKbPLXTc5wPcJSH9FXtjt
         syM7rD68B1355HMu7rGTlmhLpynWC52buCnMOTkGGe24fYGTyiauFRixNFibs0613T
         5ys81zV8nXJbNU1Ypt5BY/i8IHnPTJypnlsgdrIQfEjxBD7huYczviHNM8U0bA2pR5
         ydMN/D5jsIdvQ6d45fn5yx6DatgXTxVkPS5HyWR//xLGcPvG0FgCgCrPzlS3aFR0aD
         TvLYgcecSet9A==
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
Subject: [RFC PATCH 16/22] riscv: s64ilp32: Add TImode (128 int) support
Date:   Thu, 18 May 2023 09:10:07 -0400
Message-Id: <20230518131013.3366406-17-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230518131013.3366406-1-guoren@kernel.org>
References: <20230518131013.3366406-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The s64ilp32 uses 64bit compiler, so it could support “Tetra
Integer” mode, which represents a sixteen-byte (128) integer.

It's the first 32BIT linux support TImode :)

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/Kconfig      | 1 +
 arch/riscv/lib/Makefile | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 33fe624ef6d3..e0c3dee68510 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -305,6 +305,7 @@ config ARCH_RV64I
 config ARCH_RV64ILP32
 	bool "RV64ILP32"
 	depends on NONPORTABLE
+	select ARCH_SUPPORTS_INT128 if !$(cc-option,$(m64-flag) -D__SIZEOF_INT128__=0)
 	select 32BIT
 	select MMU
 
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index 26cb2502ecf8..68af463795e1 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -9,5 +9,6 @@ lib-y			+= strncmp.o
 lib-$(CONFIG_MMU)	+= uaccess.o
 lib-$(CONFIG_64BIT)	+= tishift.o
 lib-$(CONFIG_RISCV_ISA_ZICBOZ)	+= clear_page.o
+lib-$(CONFIG_ARCH_RV64ILP32) += tishift.o
 
 obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
-- 
2.36.1

