Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63F976D424
	for <lists+linux-arch@lfdr.de>; Wed,  2 Aug 2023 18:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbjHBQt4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 12:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbjHBQto (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 12:49:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8D230E0;
        Wed,  2 Aug 2023 09:49:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D92C261A18;
        Wed,  2 Aug 2023 16:49:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE991C433C7;
        Wed,  2 Aug 2023 16:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690994973;
        bh=qTocF+5HifQQ2/cevfHJiy/Dt4gxsiBcGO8u/t7qAjw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HzKhu1rw4zVY83o3aI0QRxuEoefnVtHfGIm54LDyeZfq6g0LxLrXs7I4vNqtzFs6+
         2q8sf2QEoId6+sKw73J7aEIT5YLQLPVa/vzfO+h6M85J04AkY6O7Ww9717CT31VAfz
         pL+nmf8pE/EDqMdwrvEl4pC2GTEn7nWlvDpt2xBBAnqn4xFaeqsL1+2Z7fTA2UiWmV
         h8wzWKSgpZM7N5ip55dDhWMilqgGJn4HLsfjl3vf/97Wq88D754dkMU9ojregLnLNz
         uxMU25MAhuAxaBFytRB/nZn8ozCqw4yybE4TlWd0BStHvq5hgLlpZYJwCbuxOjwIs7
         NuiGKj3a2TZrA==
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
Subject: [PATCH V10 07/19] riscv: qspinlock: errata: Introduce ERRATA_THEAD_QSPINLOCK
Date:   Wed,  2 Aug 2023 12:46:49 -0400
Message-Id: <20230802164701.192791-8-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230802164701.192791-1-guoren@kernel.org>
References: <20230802164701.192791-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

According to qspinlock requirements, RISC-V gives out a weak LR/SC
forward progress guarantee which does not satisfy qspinlock. But
many vendors could produce stronger forward guarantee LR/SC to
ensure the xchg_tail could be finished in time on any kind of
hart. T-HEAD is the vendor which implements strong forward
guarantee LR/SC instruction pairs, so enable qspinlock for T-HEAD
with errata help.

T-HEAD early version of processors has the merge buffer delay
problem, so we need ERRATA_WRITEONCE to support qspinlock.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/Kconfig.errata              | 13 +++++++++++++
 arch/riscv/errata/thead/errata.c       | 24 ++++++++++++++++++++++++
 arch/riscv/include/asm/errata_list.h   | 20 ++++++++++++++++++++
 arch/riscv/include/asm/vendorid_list.h |  3 ++-
 arch/riscv/kernel/cpufeature.c         |  3 ++-
 5 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
index 4745a5c57e7c..eb43677b13cc 100644
--- a/arch/riscv/Kconfig.errata
+++ b/arch/riscv/Kconfig.errata
@@ -96,4 +96,17 @@ config ERRATA_THEAD_WRITE_ONCE
 
 	  If you don't know what to do here, say "Y".
 
+config ERRATA_THEAD_QSPINLOCK
+	bool "Apply T-Head queued spinlock errata"
+	depends on ERRATA_THEAD
+	default y
+	help
+	  The T-HEAD C9xx processors implement strong fwd guarantee LR/SC to
+	  match the xchg_tail requirement of qspinlock.
+
+	  This will apply the QSPINLOCK errata to handle the non-standard
+	  behavior via using qspinlock instead of ticket_lock.
+
+	  If you don't know what to do here, say "Y".
+
 endmenu # "CPU errata selection"
diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
index 881729746d2e..d560dc45c0e7 100644
--- a/arch/riscv/errata/thead/errata.c
+++ b/arch/riscv/errata/thead/errata.c
@@ -86,6 +86,27 @@ static bool errata_probe_write_once(unsigned int stage,
 	return false;
 }
 
+static bool errata_probe_qspinlock(unsigned int stage,
+				   unsigned long arch_id, unsigned long impid)
+{
+	if (!IS_ENABLED(CONFIG_ERRATA_THEAD_QSPINLOCK))
+		return false;
+
+	/*
+	 * The queued_spinlock torture would get in livelock without
+	 * ERRATA_THEAD_WRITE_ONCE fixup for the early versions of T-HEAD
+	 * processors.
+	 */
+	if (arch_id == 0 && impid == 0 &&
+	    !IS_ENABLED(CONFIG_ERRATA_THEAD_WRITE_ONCE))
+		return false;
+
+	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
+		return true;
+
+	return false;
+}
+
 static u32 thead_errata_probe(unsigned int stage,
 			      unsigned long archid, unsigned long impid)
 {
@@ -103,6 +124,9 @@ static u32 thead_errata_probe(unsigned int stage,
 	if (errata_probe_write_once(stage, archid, impid))
 		cpu_req_errata |= BIT(ERRATA_THEAD_WRITE_ONCE);
 
+	if (errata_probe_qspinlock(stage, archid, impid))
+		cpu_req_errata |= BIT(ERRATA_THEAD_QSPINLOCK);
+
 	return cpu_req_errata;
 }
 
diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
index fbb2b8d39321..a696d18d1b0d 100644
--- a/arch/riscv/include/asm/errata_list.h
+++ b/arch/riscv/include/asm/errata_list.h
@@ -141,6 +141,26 @@ asm volatile(ALTERNATIVE(						\
 	: "=r" (__ovl) :						\
 	: "memory")
 
+static __always_inline bool
+riscv_has_errata_thead_qspinlock(void)
+{
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
+		asm_volatile_goto(
+		ALTERNATIVE(
+		"j	%l[l_no]", "nop",
+		THEAD_VENDOR_ID,
+		ERRATA_THEAD_QSPINLOCK,
+		CONFIG_ERRATA_THEAD_QSPINLOCK)
+		: : : : l_no);
+	} else {
+		goto l_no;
+	}
+
+	return true;
+l_no:
+	return false;
+}
+
 #endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/riscv/include/asm/vendorid_list.h b/arch/riscv/include/asm/vendorid_list.h
index 73078cfe4029..1f1d03877f5f 100644
--- a/arch/riscv/include/asm/vendorid_list.h
+++ b/arch/riscv/include/asm/vendorid_list.h
@@ -19,7 +19,8 @@
 #define	ERRATA_THEAD_CMO 1
 #define	ERRATA_THEAD_PMU 2
 #define	ERRATA_THEAD_WRITE_ONCE 3
-#define	ERRATA_THEAD_NUMBER 4
+#define	ERRATA_THEAD_QSPINLOCK 4
+#define	ERRATA_THEAD_NUMBER 5
 #endif
 
 #endif
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index f8dbbe1bbd34..d9694fe40a9a 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -342,7 +342,8 @@ void __init riscv_fill_hwcap(void)
 		 * spinlock value, the only way is to change from queued_spinlock to
 		 * ticket_spinlock, but can not be vice.
 		 */
-		if (!force_qspinlock) {
+		if (!force_qspinlock &&
+		    !riscv_has_errata_thead_qspinlock()) {
 			set_bit(RISCV_ISA_EXT_XTICKETLOCK, isainfo->isa);
 		}
 #endif
-- 
2.36.1

