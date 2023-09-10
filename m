Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CD8799D48
	for <lists+linux-arch@lfdr.de>; Sun, 10 Sep 2023 10:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236031AbjIJIcI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 10 Sep 2023 04:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235671AbjIJIcI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 10 Sep 2023 04:32:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863B8170C;
        Sun, 10 Sep 2023 01:31:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06695C433C7;
        Sun, 10 Sep 2023 08:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694334686;
        bh=XRClpokZATGms/5hSmQVWqg3PgTsbj60ag4pgT82d1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DAOn5xYy1snXrOmFmNehUeHzj1Z0ze8me0Irn4+sU5MWVFFo5IVtlgSxXBj+N5x66
         SThfOeVincosujHlIPmZwaPH7xmI30VIyYyLOLJE3Bl/vsoZAaPr1jyY3JN/Ne08Fh
         a2k8iW8/2r/OtbySdghJbCUCJTkyPRaE1dVLz9HACSYHii/unurbLmqg9m5QaHjxLA
         EqJD/2+Sl/GAUpU9Ueyi2qO6xrtIM5p2E/EELjjJFh4Hd8QRVtQXv9J2o0kNjFnfAk
         G0voEZGJh1qlLocmGgE7uF+4hz00VcMN4Cpu/u15U7gqDQYozJOJU9lJUB45CjGWhU
         4c3Ju+DiYrSGw==
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
Subject: [PATCH V11 13/17] RISC-V: paravirt: pvqspinlock: Add SBI implementation
Date:   Sun, 10 Sep 2023 04:29:07 -0400
Message-Id: <20230910082911.3378782-14-guoren@kernel.org>
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

Implement pv_kick with SBI implementation, and add SBI_EXT_PVLOCK
extension detection.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/sbi.h           | 6 ++++++
 arch/riscv/kernel/qspinlock_paravirt.c | 7 ++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index e0233b3d7a5f..3533f8d4f3e2 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -30,6 +30,7 @@ enum sbi_ext_id {
 	SBI_EXT_HSM = 0x48534D,
 	SBI_EXT_SRST = 0x53525354,
 	SBI_EXT_PMU = 0x504D55,
+	SBI_EXT_PVLOCK = 0xAB0401,
 
 	/* Experimentals extensions must lie within this range */
 	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
@@ -243,6 +244,11 @@ enum sbi_pmu_ctr_type {
 /* Flags defined for counter stop function */
 #define SBI_PMU_STOP_FLAG_RESET (1 << 0)
 
+/* SBI PVLOCK (kick cpu out of wfi) */
+enum sbi_ext_pvlock_fid {
+	SBI_EXT_PVLOCK_KICK_CPU = 0,
+};
+
 #define SBI_SPEC_VERSION_DEFAULT	0x1
 #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
 #define SBI_SPEC_VERSION_MAJOR_MASK	0x7f
diff --git a/arch/riscv/kernel/qspinlock_paravirt.c b/arch/riscv/kernel/qspinlock_paravirt.c
index a0ad4657f437..571626f350be 100644
--- a/arch/riscv/kernel/qspinlock_paravirt.c
+++ b/arch/riscv/kernel/qspinlock_paravirt.c
@@ -11,6 +11,8 @@
 
 void pv_kick(int cpu)
 {
+	sbi_ecall(SBI_EXT_PVLOCK, SBI_EXT_PVLOCK_KICK_CPU,
+		  cpuid_to_hartid_map(cpu), 0, 0, 0, 0, 0);
 	return;
 }
 
@@ -25,7 +27,7 @@ void pv_wait(u8 *ptr, u8 val)
 	if (READ_ONCE(*ptr) != val)
 		goto out;
 
-	/* wait_for_interrupt(); */
+	wait_for_interrupt();
 out:
 	local_irq_restore(flags);
 }
@@ -62,6 +64,9 @@ void __init pv_qspinlock_init(void)
 	if(sbi_get_firmware_id() != SBI_EXT_BASE_IMPL_ID_KVM)
 		return;
 
+	if (!sbi_probe_extension(SBI_EXT_PVLOCK))
+		return;
+
 	pr_info("PV qspinlocks enabled\n");
 	__pv_init_lock_hash();
 
-- 
2.36.1

