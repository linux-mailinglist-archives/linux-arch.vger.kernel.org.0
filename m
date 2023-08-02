Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A8776D454
	for <lists+linux-arch@lfdr.de>; Wed,  2 Aug 2023 18:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjHBQxO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 12:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbjHBQwg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 12:52:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033AE30E9;
        Wed,  2 Aug 2023 09:51:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F80261908;
        Wed,  2 Aug 2023 16:51:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8079C433C8;
        Wed,  2 Aug 2023 16:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690995103;
        bh=JHp6Qjv2j2L5yGDwaLMLoclwEyHeCzWtLnvdae52dY8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XGxIQYG3X/Qxf61mdxd0nkNtxlOKIqUxTzKy2Iy5j9R40n6pMtZuxEMoTnmWzPFal
         6erBZnxtXplixtxjAI14gHKWh7bWpa+VYQnSylkL8twtIZeBjO9M0mQN8lqqbhSkUm
         rM51X8dPdeolxLSAOeSQTFOT1WC9gSfUIiKTue36Dswah4389rsBzD7Mp67PcCVRZq
         nLiD0M2LIXm0Xib4XjMwxXVBCgkRVCNvq/y/XCkHgQA3b7flv1XlZgfv1nzyUnrkM3
         W6T5DBCZCxBxhktENBH7MTh3tvUN99FApLkFhO6yITo5mBMZMsZIuBi7bEMHDk3ijR
         miiinner3tOnw==
From:   guoren@kernel.org
To:     paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, paulmck@kernel.org, rostedt@goodmis.org,
        rdunlap@infradead.org, catalin.marinas@arm.com,
        conor.dooley@microchip.com, xiaoguang.xing@sophgo.com,
        bjorn@rivosinc.com, alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn
Cc:     linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH V10 15/19] RISC-V: paravirt: pvqspinlock: Add SBI implementation
Date:   Wed,  2 Aug 2023 12:46:57 -0400
Message-Id: <20230802164701.192791-16-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230802164701.192791-1-guoren@kernel.org>
References: <20230802164701.192791-1-guoren@kernel.org>
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

Implement pv_kick with SBI implementation, and add SBI_EXT_PVLOCK
extension detection.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/sbi.h | 6 ++++++
 arch/riscv/kernel/paravirt.c | 7 ++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index b7ced34b79a3..26b4ec039f32 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -31,6 +31,7 @@ enum sbi_ext_id {
 	SBI_EXT_SRST = 0x53525354,
 	SBI_EXT_PMU = 0x504D55,
 	SBI_EXT_STA = 0x535441,
+	SBI_EXT_PVLOCK = 0xAB0401,
 
 	/* Experimentals extensions must lie within this range */
 	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
@@ -244,6 +245,11 @@ enum sbi_pmu_ctr_type {
 /* Flags defined for counter stop function */
 #define SBI_PMU_STOP_FLAG_RESET (1 << 0)
 
+/* SBI PVLOCK (kick cpu out of wfi) */
+enum sbi_ext_pvlock_fid {
+	SBI_EXT_PVLOCK_KICK_CPU = 0,
+};
+
 /* SBI STA (steal-time accounting) extension */
 enum sbi_ext_sta_fid {
 	SBI_EXT_STA_STEAL_TIME_SET_SHMEM = 0,
diff --git a/arch/riscv/kernel/paravirt.c b/arch/riscv/kernel/paravirt.c
index b55c3d3c0c17..564d64f11e4f 100644
--- a/arch/riscv/kernel/paravirt.c
+++ b/arch/riscv/kernel/paravirt.c
@@ -136,6 +136,8 @@ int __init pv_time_init(void)
 
 void pv_kick(int cpu)
 {
+	sbi_ecall(SBI_EXT_PVLOCK, SBI_EXT_PVLOCK_KICK_CPU,
+		  cpuid_to_hartid_map(cpu), 0, 0, 0, 0, 0);
 	return;
 }
 
@@ -150,7 +152,7 @@ void pv_wait(u8 *ptr, u8 val)
 	if (READ_ONCE(*ptr) != val)
 		goto out;
 
-	/* wait_for_interrupt(); */
+	wait_for_interrupt();
 out:
 	local_irq_restore(flags);
 }
@@ -186,6 +188,9 @@ void __init pv_qspinlock_init(void)
 	if(sbi_get_firmware_id() != SBI_EXT_BASE_IMPL_ID_KVM)
 		return;
 
+	if (!sbi_probe_extension(SBI_EXT_PVLOCK))
+		return;
+
 	pr_info("PV qspinlocks enabled\n");
 	__pv_init_lock_hash();
 
-- 
2.36.1

