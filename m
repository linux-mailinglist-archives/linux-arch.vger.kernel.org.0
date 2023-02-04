Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F3A68A89A
	for <lists+linux-arch@lfdr.de>; Sat,  4 Feb 2023 07:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjBDGfr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 4 Feb 2023 01:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBDGfr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 4 Feb 2023 01:35:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD0789344;
        Fri,  3 Feb 2023 22:35:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03B7EB82B47;
        Sat,  4 Feb 2023 06:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907ADC433D2;
        Sat,  4 Feb 2023 06:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675492543;
        bh=u/0MMX/IZLs1pjerWY5ETcVWivvex5xaBMMULMjK8+E=;
        h=From:To:Cc:Subject:Date:From;
        b=sd8EfC78IdaDn6c5domvcB8NDIJXxVniylK8Y11+3En5RRyoiSP4wKnCaJy8bZ/Ld
         OAgcbJUEiKq5a1Kz+zVXgyJf//qS/DSD4JJt6USNiteahyA5u63+UpvHkYdqo39oYH
         Xn0HYWK5+OBQ74TbrPTT/Q0TwWR+kJGR0IwjrRN8ObGChSW7v1oeytKhYc0wFYhEIg
         18jisQbXphAFWSSQDQRxKx7NJM6HTwB9nuWx92j80hYcQcnP+tsz6PaxXG3BMeQvQ8
         h5ActU4U/14qHc++M9NKCz8YRRCXfvGajvXdirvn0utSbiQfCHnbhwvf5RUMt9Y7ob
         OLekOkFY4YGkg==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@rivosinc.com, conor.dooley@microchip.com,
        liaochang1@huawei.com, bjorn@kernel.org, jrtc27@jrtc27.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Bjorn Topel <bjorn.topel@gmail.com>
Subject: [PATCH V2] riscv: kprobe: Fixup misaligned load text
Date:   Sat,  4 Feb 2023 01:35:31 -0500
Message-Id: <20230204063531.740220-1-guoren@kernel.org>
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
Cc: Jessica Clarke <jrtc27@jrtc27.com>
---
Changelog
V2:
 - Optimize coding convention (Thx Bjorn & Jessica)
---
 arch/riscv/kernel/probes/kprobes.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index c41bd8509032..d3b18e868f30 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -71,16 +71,18 @@ static bool __kprobes arch_check_kprobe(struct kprobe *p)
 
 int __kprobes arch_prepare_kprobe(struct kprobe *p)
 {
-	unsigned long probe_addr = (unsigned long)p->addr;
+	u16 *insn = (u16 *)p->addr;
 
-	if (probe_addr & 0x1)
+	if ((unsigned long)insn & 0x1)
 		return -EILSEQ;
 
 	if (!arch_check_kprobe(p))
 		return -EILSEQ;
 
 	/* copy instruction */
-	p->opcode = *p->addr;
+	p->opcode = (kprobe_opcode_t)(*insn++);
+	if (GET_INSN_LENGTH(p->opcode) == 4)
+		p->opcode |= (kprobe_opcode_t)(*insn) << 16;
 
 	/* decode instruction */
 	switch (riscv_probe_decode_insn(p->addr, &p->ainsn.api)) {
-- 
2.36.1

