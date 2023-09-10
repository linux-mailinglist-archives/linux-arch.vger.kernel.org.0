Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B12799D4D
	for <lists+linux-arch@lfdr.de>; Sun, 10 Sep 2023 10:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239521AbjIJIcO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 10 Sep 2023 04:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235671AbjIJIcO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 10 Sep 2023 04:32:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073B01728;
        Sun, 10 Sep 2023 01:31:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E823CC433C8;
        Sun, 10 Sep 2023 08:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694334692;
        bh=tGHFuxIP3SbPPf/Epb/Xnkxu5WfdeddjXtXxQeK/obc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YUKo/luMDwQ8ZTHKumNn75SdYE5FDukIjOgss5a5AbXFbueaYWrxKwu9Qkyj8QpzH
         6ZTe9MLwdEREPEFTO+BHHd0E1QiUV/q/RCTlcE04SMv7lx+zDLCynlX3vKHZt2z7va
         E/11VNyj8a4aIGWv24FBkPQordBCQuvBtQNul7krmNBWS3/gMvved/HvortUZXOw1B
         HHCp8xJQaao+4BHm+WuJofLhiQSVvwQG3eqADFFZTcafRLFP/1waYYPh0PlZUpFy+J
         VzQ8ykVD7bRApcaRbqsfoR8egd0/EE0OxCXQL4dsYaYUykxPJHUg9F7Cy83ImCsGQ2
         qLELasFU6ESIg==
From:   guoren@kernel.org
To:     paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, paulmck@kernel.org, rostedt@goodmis.org,
        rdunlap@infradead.org, catalin.marinas@arm.com,
        conor.dooley@microchip.com, xiaoguang.xing@sophgo.com,
        bjorn@rivosinc.com, alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn,
        leobras@redhat.com
Cc:     linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH V11 14/17] RISC-V: paravirt: pvqspinlock: Add kconfig entry
Date:   Sun, 10 Sep 2023 04:29:08 -0400
Message-Id: <20230910082911.3378782-15-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230910082911.3378782-1-guoren@kernel.org>
References: <20230910082911.3378782-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Add kconfig entry for paravirt_spinlock, an unfair qspinlock
virtualization-friendly backend, by halting the virtual CPU rather
than spinning.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/Kconfig         | 12 ++++++++++++
 arch/riscv/kernel/Makefile |  1 +
 2 files changed, 13 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 4bcff2860f48..ec0da24ed6fb 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -813,6 +813,18 @@ config RELOCATABLE
 
           If unsure, say N.
 
+config PARAVIRT_SPINLOCKS
+	bool "Paravirtualization layer for spinlocks"
+	depends on QUEUED_SPINLOCKS
+	default y
+	help
+	  Paravirtualized spinlocks allow a unfair qspinlock to replace the
+	  test-set kvm-guest virt spinlock implementation with something
+	  virtualization-friendly, for example, halt the virtual CPU rather
+	  than spinning.
+
+	  If you are unsure how to answer this question, answer Y.
+
 endmenu # "Kernel features"
 
 menu "Boot options"
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 671ad85f28f2..114b29234c46 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -103,3 +103,4 @@ obj-$(CONFIG_ARCH_RV64ILP32)	+= compat_signal.o
 
 obj-$(CONFIG_64BIT)		+= pi/
 obj-$(CONFIG_ACPI)		+= acpi.o
+obj-$(CONFIG_PARAVIRT_SPINLOCKS) += qspinlock_paravirt.o
-- 
2.36.1

