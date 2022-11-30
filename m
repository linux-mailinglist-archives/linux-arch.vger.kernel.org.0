Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4614063CE03
	for <lists+linux-arch@lfdr.de>; Wed, 30 Nov 2022 04:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbiK3Doi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Nov 2022 22:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbiK3DoO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Nov 2022 22:44:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C41776175;
        Tue, 29 Nov 2022 19:43:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B7DF6190D;
        Wed, 30 Nov 2022 03:43:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92625C433B5;
        Wed, 30 Nov 2022 03:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669779807;
        bh=ZDyU4TTOJsyVKdnctf0t8XpryX5dMXPuOjIV8A9Fjb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NZwnT0m2d3IK0C8nylUmtgnnbbhi7Ly+qczv0bnk9ieSYucysDPDqW4Hk2vOmiVsR
         4agpwBTCQxrpVP1TruVfjGdvoMPim4X1uKG22KwmCh5TShQI44QAcLE+hFOn1Tx8ru
         cwT/qTlttm22xF8vXfj2O7TD5OI5ldR0gkiKnnRbsE8DZVC3NE5mn+SI467HCxTpV5
         TNx8c/hzlJxcsdf869+hQLsVn1HHU6NLWQFbuqLUDQTPYSaAnackto5fahOeD1gymg
         TwdkWedfA/VTaYXQB4knI7fmsSjSvoAt+p3xxFcjO0H6MnZvoKLkm+rxExlnPRw1Sy
         DJEGXl/JTbKXw==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
        apatel@ventanamicro.com, atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mark.rutland@arm.com,
        zouyipeng@huawei.com, bigeasy@linutronix.de,
        David.Laight@aculab.com, chenzhongjin@huawei.com,
        greentime.hu@sifive.com, andy.chiu@sifive.com, ben@decadent.org.uk
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Dao Lu <daolu@rivosinc.com>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        Conor Dooley <Conor.Dooley@microchip.com>
Subject: [PATCH -next V9 11/14] riscv: Add support for STACKLEAK gcc plugin
Date:   Tue, 29 Nov 2022 22:40:56 -0500
Message-Id: <20221130034059.826599-12-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221130034059.826599-1-guoren@kernel.org>
References: <20221130034059.826599-1-guoren@kernel.org>
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

From: Dao Lu <daolu@rivosinc.com>

Add support for STACKLEAK gcc plugin to riscv based heavily on the arm64
version, and modifying the entry.S. Additionally, this disables the
plugin for EFI stub code for riscv. All modifications base on
generic_entry.

The stackleak_erase_on_task_stack() is called in irq disabled context
before return to user space.

Here is the test result with LKDTM:
echo STACKLEAK_ERASING > /sys/kernel/debug/provoke-crash/DIRECT
[   53.110405] lkdtm: Performing direct entry STACKLEAK_ERASING
[   53.111630] lkdtm: stackleak stack usage:
[   53.111630]   high offset: 288 bytes
[   53.111630]   current:     592 bytes
[   53.111630]   lowest:      1136 bytes
[   53.111630]   tracked:     1136 bytes
[   53.111630]   untracked:   576 bytes
[   53.111630]   poisoned:    14376 bytes
[   53.111630]   low offset:  8 bytes
[   53.115078] lkdtm: OK: the rest of the thread stack is properly
erased

Performance impact (tested on qemu env with 1 riscv64 hart, 1GB mem)
    hackbench -s 512 -l 200 -g 15 -f 25 -P
    2.0% slowdown

Signed-off-by: Dao Lu <daolu@rivosinc.com>
Co-developed-by: Xianting Tian <xianting.tian@linux.alibaba.com>
Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
Co-developed-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Conor Dooley <Conor.Dooley@microchip.com>
---
Dao Lu gave the first patch at [1], and Xianting missed the previous
patch and gave the second one [2]. Guo Ren tried to move
stackleak into common generic entry codes [3], but Mark Rutland pointed
out the problem. Combine the Dao Lu's patch with the GENEIRC_ENTRY
patchset series, with some modifications (fit GENEIRC_ENTRY, directly
using stackleak_erase_on_task_stack).

[1] https://lore.kernel.org/linux-riscv/20220615213834.3116135-1-daolu@rivosinc.com/
[2] https://lore.kernel.org/linux-riscv/20220828135407.3897717-1-xianting.tian@linux.alibaba.com/
[3] https://lore.kernel.org/lkml/20220907014809.919979-1-guoren@kernel.org/
---
 arch/riscv/Kconfig                    | 1 +
 arch/riscv/kernel/entry.S             | 3 +++
 drivers/firmware/efi/libstub/Makefile | 2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index df067b225757..b15df48d9d31 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -85,6 +85,7 @@ config RISCV
 	select HAVE_ARCH_MMAP_RND_BITS if MMU
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
 	select HAVE_ARCH_SECCOMP_FILTER
+	select HAVE_ARCH_STACKLEAK
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if 64BIT && MMU
 	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 03655577e26f..b1babad5f829 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -145,6 +145,9 @@ ENTRY(ret_from_exception)
 	andi s0, s0, SR_SPP
 #endif
 	bnez s0, 1f
+#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
+	call stackleak_erase_on_task_stack
+#endif
 
 	/* Save unwound kernel stack pointer in thread_info */
 	addi s0, sp, PT_SIZE_ON_STACK
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index b1601aad7e1a..28170707fa6f 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -25,7 +25,7 @@ cflags-$(CONFIG_ARM)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
 				   -fno-builtin -fpic \
 				   $(call cc-option,-mno-single-pic-base)
 cflags-$(CONFIG_RISCV)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
-				   -fpic
+				   -fpic $(DISABLE_STACKLEAK_PLUGIN)
 cflags-$(CONFIG_LOONGARCH)	:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
 				   -fpie
 
-- 
2.36.1

