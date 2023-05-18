Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FB8708255
	for <lists+linux-arch@lfdr.de>; Thu, 18 May 2023 15:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjERNN1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 May 2023 09:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjERNM6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 May 2023 09:12:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FEB1FD3;
        Thu, 18 May 2023 06:12:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6724464F4F;
        Thu, 18 May 2023 13:12:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFD7C433D2;
        Thu, 18 May 2023 13:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684415526;
        bh=2yJXkd2hwfR0ToSY6iQDYPlEkk80m0hSWx77JwFLWNM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FHiXdUubawrcsGRCSebfkII36mJn6Bezsg4mGrpfXAfcUI8FC+UTxqM0kKMt86Aij
         w5MZIrc8ft6FKEJJPKNUHDBPEx/bnBYOKLK0q07NGMaQ5L/t95TMQS6BfbfSdpRHSI
         r3cMD/7LIKmJD21+KeM0lnmwFGVLf5Qm6JUgg1czx+jn/rzlTLfjvAL/kZ4IPGHRat
         gJcf73V5ZGJXJnUH2nRrtJqreD3LwAhzyxGTJgbDa5v0UPb+4g2DDQKZQcpNShtL09
         TXBs8g7irmjfnnEbOWpWcM0znHPzfZeg59rnaK3TnYI+BMSIKpLCPEh9htVrmP/5R4
         AGAv/8A32cLtA==
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
Subject: [RFC PATCH 07/22] riscv: s64ilp32: Add sbi support
Date:   Thu, 18 May 2023 09:09:58 -0400
Message-Id: <20230518131013.3366406-8-guoren@kernel.org>
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

The sbi uses xlen as base argument elements to connect m-mode and
s-mode. The previous implementation assumes sizeof(xlen_t) =
sizeof(long), but the s64ilp32's are different. So modify the sbi code
suitable with the s64ilp32 change.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/cpu_ops_sbi.h |  4 ++--
 arch/riscv/include/asm/sbi.h         | 24 ++++++++++++------------
 arch/riscv/kernel/cpu_ops_sbi.c      |  4 ++--
 arch/riscv/kernel/sbi.c              | 24 ++++++++++++------------
 4 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/riscv/include/asm/cpu_ops_sbi.h b/arch/riscv/include/asm/cpu_ops_sbi.h
index d6e4665b3195..d967adad6b48 100644
--- a/arch/riscv/include/asm/cpu_ops_sbi.h
+++ b/arch/riscv/include/asm/cpu_ops_sbi.h
@@ -19,8 +19,8 @@ extern const struct cpu_operations cpu_ops_sbi;
  * @stack_ptr: A pointer to the hart specific sp
  */
 struct sbi_hart_boot_data {
-	void *task_ptr;
-	void *stack_ptr;
+	xlen_t task_ptr;
+	xlen_t stack_ptr;
 };
 #endif
 
diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 945b7be249c1..d31135715f0e 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -123,16 +123,16 @@ enum sbi_ext_pmu_fid {
 };
 
 union sbi_pmu_ctr_info {
-	unsigned long value;
+	xlen_t value;
 	struct {
-		unsigned long csr:12;
-		unsigned long width:6;
+		xlen_t csr:12;
+		xlen_t width:6;
 #if __riscv_xlen == 32
-		unsigned long reserved:13;
+		xlen_t reserved:13;
 #else
-		unsigned long reserved:45;
+		xlen_t reserved:45;
 #endif
-		unsigned long type:1;
+		xlen_t type:1;
 	};
 };
 
@@ -254,15 +254,15 @@ enum sbi_pmu_ctr_type {
 
 extern unsigned long sbi_spec_version;
 struct sbiret {
-	long error;
-	long value;
+	xlen_t error;
+	xlen_t value;
 };
 
 void sbi_init(void);
-struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
-			unsigned long arg1, unsigned long arg2,
-			unsigned long arg3, unsigned long arg4,
-			unsigned long arg5);
+struct sbiret sbi_ecall(int ext, int fid, xlen_t arg0,
+			xlen_t arg1, xlen_t arg2,
+			xlen_t arg3, xlen_t arg4,
+			xlen_t arg5);
 
 void sbi_console_putchar(int ch);
 int sbi_console_getchar(void);
diff --git a/arch/riscv/kernel/cpu_ops_sbi.c b/arch/riscv/kernel/cpu_ops_sbi.c
index efa0f0816634..01a1e270ec1d 100644
--- a/arch/riscv/kernel/cpu_ops_sbi.c
+++ b/arch/riscv/kernel/cpu_ops_sbi.c
@@ -71,8 +71,8 @@ static int sbi_cpu_start(unsigned int cpuid, struct task_struct *tidle)
 
 	/* Make sure tidle is updated */
 	smp_mb();
-	bdata->task_ptr = tidle;
-	bdata->stack_ptr = task_stack_page(tidle) + THREAD_SIZE;
+	bdata->task_ptr = (ulong)tidle;
+	bdata->stack_ptr = (ulong)task_stack_page(tidle) + THREAD_SIZE;
 	/* Make sure boot data is updated */
 	smp_mb();
 	hsm_data = __pa(bdata);
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 5c87db8fdff2..b649562aff61 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -22,21 +22,21 @@ static int (*__sbi_rfence)(int fid, const struct cpumask *cpu_mask,
 			   unsigned long start, unsigned long size,
 			   unsigned long arg4, unsigned long arg5) __ro_after_init;
 
-struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
-			unsigned long arg1, unsigned long arg2,
-			unsigned long arg3, unsigned long arg4,
-			unsigned long arg5)
+struct sbiret sbi_ecall(int ext, int fid, xlen_t arg0,
+			xlen_t arg1, xlen_t arg2,
+			xlen_t arg3, xlen_t arg4,
+			xlen_t arg5)
 {
 	struct sbiret ret;
 
-	register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);
-	register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);
-	register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);
-	register uintptr_t a3 asm ("a3") = (uintptr_t)(arg3);
-	register uintptr_t a4 asm ("a4") = (uintptr_t)(arg4);
-	register uintptr_t a5 asm ("a5") = (uintptr_t)(arg5);
-	register uintptr_t a6 asm ("a6") = (uintptr_t)(fid);
-	register uintptr_t a7 asm ("a7") = (uintptr_t)(ext);
+	register xlen_t a0 asm ("a0") = arg0;
+	register xlen_t a1 asm ("a1") = arg1;
+	register xlen_t a2 asm ("a2") = arg2;
+	register xlen_t a3 asm ("a3") = arg3;
+	register xlen_t a4 asm ("a4") = arg4;
+	register xlen_t a5 asm ("a5") = arg5;
+	register xlen_t a6 asm ("a6") = fid;
+	register xlen_t a7 asm ("a7") = ext;
 	asm volatile ("ecall"
 		      : "+r" (a0), "+r" (a1)
 		      : "r" (a2), "r" (a3), "r" (a4), "r" (a5), "r" (a6), "r" (a7)
-- 
2.36.1

