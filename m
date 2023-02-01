Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F2F685FE7
	for <lists+linux-arch@lfdr.de>; Wed,  1 Feb 2023 07:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjBAGrC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Feb 2023 01:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjBAGrB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Feb 2023 01:47:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBB534C2E;
        Tue, 31 Jan 2023 22:46:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6166461343;
        Wed,  1 Feb 2023 06:46:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C69C433D2;
        Wed,  1 Feb 2023 06:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675234009;
        bh=gTXbxviqwiipAfrlkTcVTx4LMrjxFY0gn9AiSEXRjEE=;
        h=From:To:Cc:Subject:Date:From;
        b=eCghh/6SgHVgxYCyz3WcktFEU3qWMlkrXdIptT5sbgaK9kcLJ9bVRRnO9rAsD4FLD
         bDbjATRN4x1gxo4p++R2Rcb5DyE438+8mqZCkUeOMO7ZsBbvVrMNSIwOJoWmygTYLd
         +gHMiP6xmfG2lj8eY3JtTYSz/8kQJJda4euN/X1ws3mbRyM2hJmR+6CHMDOzxyAjtC
         iGx3yLa6bd84w6HMwkafXHz0rwszeSqMaNQ6Bqct+wgV8EYhLWKIrJSK9KGWp2V8ey
         gFjCsf6QAVbFMk+KPrNqVPgXSF25fE8xBi9tk4OaDDqlNC4APrSbZGHvAT9kLXTCfF
         xDuEwPzKN5mdQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@rivosinc.com, conor.dooley@microchip.com,
        liaochang1@huawei.com, bjorn@kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Bjorn Topel <bjorn.topel@gmail.com>
Subject: [PATCH] riscv: kprobe: Fixup misaligned load text
Date:   Wed,  1 Feb 2023 01:46:08 -0500
Message-Id: <20230201064608.3486136-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The current kprobe would cause a misaligned load for the probe point.
This patch fixup it with two half-word loads instead.

Fixes: c22b0bcb1dd0 ("riscv: Add kprobes supported")
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Link: https://lore.kernel.org/linux-riscv/878rhig9zj.fsf@all.your.base.are.belong.to.us/
Reported-by: Bjorn Topel <bjorn.topel@gmail.com>
---
 arch/riscv/kernel/probes/kprobes.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index 41c7481afde3..c1160629cef4 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -74,7 +74,9 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 		return -EILSEQ;
 
 	/* copy instruction */
-	p->opcode = *p->addr;
+	p->opcode = (kprobe_opcode_t)(*(u16 *)probe_addr);
+	if (GET_INSN_LENGTH(p->opcode) == 4)
+		p->opcode |= (kprobe_opcode_t)(*(u16 *)(probe_addr + 2)) << 16;
 
 	/* decode instruction */
 	switch (riscv_probe_decode_insn(p->addr, &p->ainsn.api)) {
-- 
2.36.1

