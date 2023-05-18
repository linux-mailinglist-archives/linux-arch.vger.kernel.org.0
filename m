Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE77970826F
	for <lists+linux-arch@lfdr.de>; Thu, 18 May 2023 15:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjERNPY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 May 2023 09:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbjERNOz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 May 2023 09:14:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DBB19A7;
        Thu, 18 May 2023 06:14:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AD4664F49;
        Thu, 18 May 2023 13:13:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA3FC4339B;
        Thu, 18 May 2023 13:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684415596;
        bh=it/txvlY5/L57R5itWfhNoNKfONs7t6egYUyVObkMZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fu30wSyFsEk4AzAWQrWkefaN5GBStqjKJ+S3xJm90Aj9gpTam01WCSkm9IRyy3BeU
         irjDzBzWYaP/ZaTR+BOle+q9IC1eZEe4KkuJGTFwao++OZpA53GT9++zVzUKGxYRzL
         zlFgocF4KScOb7vkpUKs/keoHoihtjDWB2KZ3DL6Arauk6NJfUAtiDM+tk9Anb680x
         PdThj9dHO3hw/y+j+J+YofQk9cU40VP3vHXSB8JoP7Xqf3yn6z56kO/AVyGmVVCY9c
         sTXbVULljhjm63Bq21tX80E+oQaInLrpwCtOin5JGfYI/Nl7MUMUqpyWjETf7jBV/k
         VZdzOywzG2uAw==
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
Subject: [RFC PATCH 13/22] riscv: s64ilp32: Add ARCH RV64 ILP32 compiling framework
Date:   Thu, 18 May 2023 09:10:04 -0400
Message-Id: <20230518131013.3366406-14-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230518131013.3366406-1-guoren@kernel.org>
References: <20230518131013.3366406-1-guoren@kernel.org>
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

Just the same as ARCH_RV64I & ARCH_RV32I, add ARCH_RV64ILP32 config
for s64ilp32 and turn on the s64ilp32 compile switch in the
arch/riscv/Makefile.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/Kconfig  | 6 ++++++
 arch/riscv/Makefile | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 4d4fac81390f..d824fcf3cc1c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -300,6 +300,12 @@ config ARCH_RV64I
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
 	select SWIOTLB if MMU
 
+config ARCH_RV64ILP32
+	bool "RV64ILP32"
+	depends on NONPORTABLE
+	select 32BIT
+	select MMU
+
 endchoice
 
 # We must be able to map all physical memory into the kernel, but the compiler
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index dafe958c4217..d47ba6b09b41 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -57,6 +57,7 @@ endif
 # ISA string setting
 riscv-march-$(CONFIG_ARCH_RV32I)	:= rv32ima
 riscv-march-$(CONFIG_ARCH_RV64I)	:= rv64ima
+riscv-march-$(CONFIG_ARCH_RV64ILP32)	:= rv64ima
 riscv-march-$(CONFIG_FPU)		:= $(riscv-march-y)fd
 riscv-march-$(CONFIG_RISCV_ISA_C)	:= $(riscv-march-y)c
 
@@ -107,7 +108,11 @@ stack_protector_prepare: prepare0
 endif
 
 # arch specific predefines for sparse
+ifeq ($(CONFIG_ARCH_RV64ILP32),y)
+CHECKFLAGS += -D__riscv
+else
 CHECKFLAGS += -D__riscv -D__riscv_xlen=$(BITS)
+endif
 
 # Default target when executing plain make
 boot		:= arch/riscv/boot
-- 
2.36.1

