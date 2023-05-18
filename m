Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAF570826D
	for <lists+linux-arch@lfdr.de>; Thu, 18 May 2023 15:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjERNPX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 May 2023 09:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbjERNOc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 May 2023 09:14:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3142C173A;
        Thu, 18 May 2023 06:13:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57DA960B5F;
        Thu, 18 May 2023 13:13:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195B8C433A8;
        Thu, 18 May 2023 13:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684415618;
        bh=fON6vf7tjch1Eg4H78YVWT75FX1UOvgM+cdcVq8dSsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u23kMThXHmJ++BOnqpsZjjQZeLcF6BmMabQ66dcskKDbNxmgadWJ009CTKZ0ZXFO8
         9wmPSgVwfHWqv57McbVpBTo4mvjnqaZkcPO7fLJ/IhhKQuEryBsw7uMNKb+eIvL9IU
         s/X2wT4/I5Nx02zvv6wVapEHBnLfFwa+m6DY4PlGXKNMlQooK2tjDYTvY17nN0DTyp
         rQY4XIlND+PHAHUlGvtIWTP7eWyXNpXmhy4Fc3W23JN2nKnQlCbWZMvw1mM7dvdEMn
         zqDiNXPmTMFKL29ygB/3ORIbk1AwJaKjrCswBNswWrSUibYKu7cMymqqkiU+dfD17L
         16jkhw2h2BCUA==
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
Subject: [RFC PATCH 15/22] riscv: s64ilp32: Enable native atomic64
Date:   Thu, 18 May 2023 09:10:06 -0400
Message-Id: <20230518131013.3366406-16-guoren@kernel.org>
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

The traditional rv32 Linux (s32ilp32) uses a generic version of the
lib/atomic64.c, which are inaccurate atomic64 primitives and couldn't
co-work with READ_ONCE/WRITE_ONCE,  atomic_8/16/32. The s64ilp32 could
use native AMO instructions to implement accurate atomic64 primitives.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/Kconfig              | 2 +-
 arch/riscv/include/asm/atomic.h | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 9c458496ec3a..33fe624ef6d3 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -60,7 +60,7 @@ config RISCV
 	select CPU_PM if CPU_IDLE
 	select EDAC_SUPPORT
 	select GENERIC_ARCH_TOPOLOGY
-	select GENERIC_ATOMIC64 if !64BIT
+	select GENERIC_ATOMIC64 if ARCH_RV32I
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_ENTRY
diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index 0dfe9d857a76..edfa6a74fe04 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -16,6 +16,12 @@
 # endif
 #endif
 
+#ifdef CONFIG_ARCH_RV64ILP32
+typedef struct {
+	s64 counter;
+} atomic64_t;
+#endif
+
 #include <asm/cmpxchg.h>
 #include <asm/barrier.h>
 
-- 
2.36.1

