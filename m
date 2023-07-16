Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7940C754CDB
	for <lists+linux-arch@lfdr.de>; Sun, 16 Jul 2023 02:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjGPAPX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 15 Jul 2023 20:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjGPAPS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 15 Jul 2023 20:15:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A18D212E;
        Sat, 15 Jul 2023 17:15:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17C6460B9B;
        Sun, 16 Jul 2023 00:15:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505A3C433C8;
        Sun, 16 Jul 2023 00:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689466516;
        bh=0yILc+bANh026I06UBWabz1Zup8MksYUpsntgobli2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ADnjw515pP16FV2I8lpnFC4dPNwxJnjxawWW2RJhS0BtI5ZRTMZllmD7yXzN4VKzp
         qtKiRpQ2iS/p2Td7bOzS+gDfGXZp2tNIPbkBfQpQoVgqlmsBMmH7ivEymtyQxhjo3N
         h/au2xs9HvGh2XUujZUC1hpYljDrdAYDm+e+OBigu+JgYbifOXbY5ozwg33xq2miOH
         hB1d2XJATM6/TW/eVtDcOO4x9IqTpzs75bsGlf0dJrMY3/g2/m5PxTCCygre0wLexf
         1xMstyE4xarLBYldCA2GduHG22sby3niDx9Z4qWThaO3FrhbCnm4IbnXtY0mP2ghJQ
         w6A1WCUepkXEQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@rivosinc.com, paul.walmsley@sifive.com,
        falcon@tinylab.org, bjorn@kernel.org, conor.dooley@microchip.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, stable@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V2 1/2] riscv: stack: Fixup independent irq stack for CONFIG_FRAME_POINTER=n
Date:   Sat, 15 Jul 2023 20:15:05 -0400
Message-Id: <20230716001506.3506041-2-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230716001506.3506041-1-guoren@kernel.org>
References: <20230716001506.3506041-1-guoren@kernel.org>
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

The independent irq stack uses s0 to save & restore sp, but s0 would be
corrupted when CONFIG_FRAME_POINTER=n. So add s0 in the clobber list to
fix the problem.

Fixes: 163e76cc6ef4 ("riscv: stack: Support HAVE_IRQ_EXIT_ON_IRQ_STACK")
Cc: stable@vger.kernel.org
Reported-by: Zhangjin Wu <falcon@tinylab.org>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/kernel/traps.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index f910dfccbf5d..927347a19847 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -372,6 +372,9 @@ asmlinkage void noinstr do_irq(struct pt_regs *regs)
 		: [sp] "r" (sp), [regs] "r" (regs)
 		: "a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7",
 		  "t0", "t1", "t2", "t3", "t4", "t5", "t6",
+#ifndef CONFIG_FRAME_POINTER
+		  "s0",
+#endif
 		  "memory");
 	} else
 #endif
-- 
2.36.1

