Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13388754CDA
	for <lists+linux-arch@lfdr.de>; Sun, 16 Jul 2023 02:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjGPAPX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 15 Jul 2023 20:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjGPAPV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 15 Jul 2023 20:15:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB612690;
        Sat, 15 Jul 2023 17:15:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAB0060B9B;
        Sun, 16 Jul 2023 00:15:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB014C433CB;
        Sun, 16 Jul 2023 00:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689466519;
        bh=E/jFfO+retDoLdPOyJc5wmE7Q3RkrIB4bLkvlh5cMyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cXkVAhKOvak//vq4NvrYl/XxauhW+hxgcoEqlbfIhk5u6YsST3l0Y8/WwnaiRBB+N
         zoUDoiPMG1GzOnlMYnAdvJWdXPUCS9ewLprgn1W6oDd+rd9fFeZVgBkRaJioYAx7Gu
         aRNjFMp4gmIM3r7wtXqJbKfMMUFuvq9Kn8c7MaZmEbVgRZTzKfT3UMQemGnUKIPQ35
         oiGi/2zjVxCy2JI8oSa90MiJENKU83yZAPbcZSWUiKdhTRnJzt+WM6Kv83e73bmMB0
         s1UjLKbcd1E+cb4Qt502xDb7nhaYkeGEpdCnY5BOnLU3VGklJpW9TPMFUBa3ZRxHwK
         Su5ONNJ3QNw3w==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@rivosinc.com, paul.walmsley@sifive.com,
        falcon@tinylab.org, bjorn@kernel.org, conor.dooley@microchip.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, stable@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V2 2/2] riscv: stack: Fixup independent softirq stack for CONFIG_FRAME_POINTER=n
Date:   Sat, 15 Jul 2023 20:15:06 -0400
Message-Id: <20230716001506.3506041-3-guoren@kernel.org>
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

The independent softirq stack uses s0 to save & restore sp, but s0 would
be corrupted when CONFIG_FRAME_POINTER=n. So add s0 in the clobber list
to fix the problem.

Fixes: dd69d07a5a6c ("riscv: stack: Support HAVE_SOFTIRQ_ON_OWN_STACK")
Cc: stable@vger.kernel.org
Reported-by: Zhangjin Wu <falcon@tinylab.org>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/kernel/irq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index d0577cc6a081..a8efa053c4a5 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -84,6 +84,9 @@ void do_softirq_own_stack(void)
 		: [sp] "r" (sp)
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

