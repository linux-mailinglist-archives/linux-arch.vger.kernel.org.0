Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF97A799D3C
	for <lists+linux-arch@lfdr.de>; Sun, 10 Sep 2023 10:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346542AbjIJIbr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 10 Sep 2023 04:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbjIJIbq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 10 Sep 2023 04:31:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002F2E7E;
        Sun, 10 Sep 2023 01:31:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B89C433AD;
        Sun, 10 Sep 2023 08:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694334668;
        bh=rVLNDURpOo6qyHiuDOTv1S9pmkvmttipsDX3ZB78S3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J4vv6ZK4m8+ZAYwWtLVLh0MGfPo2+DIhTEV60AiAjhHORFtDmWtIkS+BlESCUmkEo
         mXfGVL2xe+CW+Cw/i1vYBvg149LAmnA/Sm/7SYj7BinnCDfFR8xqmrKiSB7IEuZHoG
         L0d04TaCfcKTbiCn3rGUimhpuT7v+Y4/NG9+vXxA0CRX5Tyk2mOHA2hMjOojDrAkVp
         +k1ByKdKCbaA0SV5+tafSpELg24ZkI1yV2ErBGv7QZQhSNtRNOIMtfx1Xiuj0tQgze
         0o/Utrj89jmKhS4VOu/9A/1NwYpSKxiuWJKAlyzGG05mhN+Y7XKQrKXBsGUZ1r0dsS
         uA04kMd6m4fdA==
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
Subject: [PATCH V11 10/17] riscv: qspinlock: errata: Enable qspinlock for T-HEAD processors
Date:   Sun, 10 Sep 2023 04:29:04 -0400
Message-Id: <20230910082911.3378782-11-guoren@kernel.org>
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

According to qspinlock requirements, RISC-V gives out a weak LR/SC
forward progress guarantee which does not satisfy qspinlock. But
many vendors could produce stronger forward guarantee LR/SC to
ensure the xchg_tail could be finished in time on any kind of
hart. T-HEAD is the vendor which implements strong forward
guarantee LR/SC instruction pairs, so enable qspinlock for T-HEAD
with errata init help.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/errata/thead/errata.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
index 751eb5a7f614..0df6a67302c0 100644
--- a/arch/riscv/errata/thead/errata.c
+++ b/arch/riscv/errata/thead/errata.c
@@ -86,6 +86,13 @@ static bool errata_probe_write_once(unsigned int stage,
 	return false;
 }
 
+extern bool enable_qspinlock_key;
+static void errata_probe_qspinlock(unsigned int stage)
+{
+	if (stage == RISCV_ALTERNATIVES_BOOT)
+		enable_qspinlock_key = true;
+}
+
 static u32 thead_errata_probe(unsigned int stage,
 			      unsigned long archid, unsigned long impid)
 {
@@ -103,6 +110,8 @@ static u32 thead_errata_probe(unsigned int stage,
 	if (errata_probe_write_once(stage, archid, impid))
 		cpu_req_errata |= BIT(ERRATA_THEAD_WRITE_ONCE);
 
+	errata_probe_qspinlock(stage);
+
 	return cpu_req_errata;
 }
 
-- 
2.36.1

