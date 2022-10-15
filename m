Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227905FF9EC
	for <lists+linux-arch@lfdr.de>; Sat, 15 Oct 2022 13:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiJOLv5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 15 Oct 2022 07:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiJOLvR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 15 Oct 2022 07:51:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3D2476EA;
        Sat, 15 Oct 2022 04:51:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 404EE60B10;
        Sat, 15 Oct 2022 11:51:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71ECEC4347C;
        Sat, 15 Oct 2022 11:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665834669;
        bh=mGaiEStOgcPC4tu/pIinKmWA56gqdSEPvVhCdyZKWTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IDvgNIHLV8fI9L7nLFL+j7y9yKvpBlfK2MlciQ9ot5koa0BLLCyCRAM6EqoYXsHHe
         1bEkWfARgEqYs7zt3LYRF7zH87QmIsXDAwLp72n+uSPTzTVl4qV1ZeaHvaXRecfNxx
         76rXd60vPSe6/x14HmPHF2gmxQN9IhS/DqEoORdo8Q0EyZ0golgMUqZ3JpWXBgTOGx
         7ZxBfsyjogieFS57g+3RiIp631o5pxye3Qcrvl0r3BX+pRFFwrjy6762vOC+bb5Sxd
         RPGckv9iSpPZ+HMk97FO0AUIPINFf86rZOch+9j0Eh55ZXH6DkUBZLQEIOzSRnHjqg
         dvCz4kOpqJCiQ==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
        apatel@ventanamicro.com, atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mark.rutland@arm.com,
        zouyipeng@huawei.com, bigeasy@linutronix.de,
        David.Laight@aculab.com, chenzhongjin@huawei.com,
        greentime.hu@sifive.com, andy.chiu@sifive.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Dao Lu <daolu@rivosinc.com>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        Conor Dooley <Conor.Dooley@microchip.com>
Subject: [PATCH V7 09/12] riscv: Add support for STACKLEAK gcc plugin
Date:   Sat, 15 Oct 2022 07:46:59 -0400
Message-Id: <20221015114702.3489989-10-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221015114702.3489989-1-guoren@kernel.org>
References: <20221015114702.3489989-1-guoren@kernel.org>
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
index 04d2d20fb0ab..7476ce9c72d5 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -83,6 +83,7 @@ config RISCV
 	select HAVE_ARCH_MMAP_RND_BITS if MMU
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
 	select HAVE_ARCH_SECCOMP_FILTER
+	select HAVE_ARCH_STACKLEAK
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if 64BIT && MMU
 	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 9864e784d6a6..167ae41ae4a8 100644
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

