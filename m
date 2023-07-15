Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D387548DB
	for <lists+linux-arch@lfdr.de>; Sat, 15 Jul 2023 15:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjGONqG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 15 Jul 2023 09:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjGONqF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 15 Jul 2023 09:46:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FF72700;
        Sat, 15 Jul 2023 06:46:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C30C60B92;
        Sat, 15 Jul 2023 13:46:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60112C433CB;
        Sat, 15 Jul 2023 13:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689428763;
        bh=Z6IXikB2xTgV8aYzF3GbO/0brO1/H9AkrMucoZoD3Ik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t8RkxRTlJ15k4v+MjMu0jzuGCrNDCMTt5XSbdm+0/caeiQpPODQh7DnFoficDzxEX
         X/BOiOQC+KFSDvSpqnhC6RnWmhRprvJVMsqWD2u4IRO2yhNOPxWBhzBukbQw70tM5+
         p11YHT1ZOLA+mrJu067BFoqLna4RAuUj2n02POOBVY8T6chyW9SkITux56S4UhD/wL
         Z9b5Hm2P/720IHBEe6Z6ODBtwSrM9nwiQ36InXVp445ngTUjx0SUF9y7Em+lJX5HDs
         WQANHaIl4RXLqfvhMFqUnAHWA//pEQXr2RI+62ADB4WPl/DKYzMMoe6H3wq6fJtxa7
         2QOqTbUNK9X4w==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@rivosinc.com, paul.walmsley@sifive.com,
        falcon@tinylab.org, bjorn@kernel.org, conor.dooley@microchip.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, stable@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 1/2] riscv: stack: Fixup independent irq stack for CONFIG_FRAME_POINTER=n
Date:   Sat, 15 Jul 2023 09:45:51 -0400
Message-Id: <20230715134552.3437933-2-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230715134552.3437933-1-guoren@kernel.org>
References: <20230715134552.3437933-1-guoren@kernel.org>
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
Reported-by: Zhangjin Wu <falcon@tinylab.org>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index f910dfccbf5d..f75d97de518a 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -371,7 +371,7 @@ asmlinkage void noinstr do_irq(struct pt_regs *regs)
 		:
 		: [sp] "r" (sp), [regs] "r" (regs)
 		: "a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7",
-		  "t0", "t1", "t2", "t3", "t4", "t5", "t6",
+		  "t0", "t1", "t2", "t3", "t4", "t5", "t6", "s0",
 		  "memory");
 	} else
 #endif
-- 
2.36.1

