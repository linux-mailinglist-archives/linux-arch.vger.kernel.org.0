Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162C6685E27
	for <lists+linux-arch@lfdr.de>; Wed,  1 Feb 2023 05:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjBAEGS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Jan 2023 23:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBAEGR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 Jan 2023 23:06:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D8653B1E;
        Tue, 31 Jan 2023 20:06:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1DC5BB80D50;
        Wed,  1 Feb 2023 04:06:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15BE2C433EF;
        Wed,  1 Feb 2023 04:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675224372;
        bh=9lL8tq6WYJ4419UUBwmrU3ts13QvrafA4MrEPG10cP4=;
        h=From:To:Cc:Subject:Date:From;
        b=kLnLLOLemgxLnF5LHv9xce36WDQuVTpnidJmtZQ41pRBql66gcNNcl2IdhnXmlZCw
         xr3jpQ5/wbqCmKsd6TUt9lQuj/0tkRhFLxQmuW4p22epyJg7WsNW+FMD1NDc3Mv26e
         yGBM6RwGeqGjtoigjpMLOV17+kgiJagFqbdevwEjkjQOajVS/mMLZll7vYCJ85PRpB
         fbROS3ed7WPQrYMCH+rXYZxxUsnCWN/TZRfX6M+Jwe8wzS8gSkq0yCzBeIb9u1O7fI
         92jyus9XyIoUU7b7pK0jp9qgeevvAeisJnObKGTEON5yNSNy9uOl/8HlK0tU1qx1hw
         FSum8unn/d4/A==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@rivosinc.com, conor.dooley@microchip.com,
        liaochang1@huawei.com, bjorn@kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V2] riscv: kprobe: Fixup kernel panic when probing an illegal position
Date:   Tue, 31 Jan 2023 23:06:04 -0500
Message-Id: <20230201040604.3390509-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
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

The kernel would panic when probed for an illegal position. eg:

(CONFIG_RISCV_ISA_C=n)

echo 'p:hello kernel_clone+0x16 a0=%a0' >> kprobe_events
echo 1 > events/kprobes/hello/enable
cat trace

Kernel panic - not syncing: stack-protector: Kernel stack
is corrupted in: __do_sys_newfstatat+0xb8/0xb8
CPU: 0 PID: 111 Comm: sh Not tainted
6.2.0-rc1-00027-g2d398fe49a4d #490
Hardware name: riscv-virtio,qemu (DT)
Call Trace:
[<ffffffff80007268>] dump_backtrace+0x38/0x48
[<ffffffff80c5e83c>] show_stack+0x50/0x68
[<ffffffff80c6da28>] dump_stack_lvl+0x60/0x84
[<ffffffff80c6da6c>] dump_stack+0x20/0x30
[<ffffffff80c5ecf4>] panic+0x160/0x374
[<ffffffff80c6db94>] generic_handle_arch_irq+0x0/0xa8
[<ffffffff802deeb0>] sys_newstat+0x0/0x30
[<ffffffff800158c0>] sys_clone+0x20/0x30
[<ffffffff800039e8>] ret_from_syscall+0x0/0x4
---[ end Kernel panic - not syncing: stack-protector:
Kernel stack is corrupted in: __do_sys_newfstatat+0xb8/0xb8 ]---

That is because the kprobe's ebreak instruction broke the kernel's
original code. The user should guarantee the correction of the probe
position, but it couldn't make the kernel panic.

This patch adds arch_check_kprobe in arch_prepare_kprobe to prevent an
illegal position (Such as the middle of an instruction).

Fixes: c22b0bcb1dd0 ("riscv: Add kprobes supported")
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
Changelog
V2:
 - Fixup misaligned load (Thx Bjorn)
---
 arch/riscv/kernel/probes/kprobes.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index f21592d20306..41c7481afde3 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -48,6 +48,21 @@ static void __kprobes arch_simulate_insn(struct kprobe *p, struct pt_regs *regs)
 	post_kprobe_handler(p, kcb, regs);
 }
 
+static bool __kprobes arch_check_kprobe(struct kprobe *p)
+{
+	unsigned long tmp  = (unsigned long)p->addr - p->offset;
+	unsigned long addr = (unsigned long)p->addr;
+
+	while (tmp <= addr) {
+		if (tmp == addr)
+			return true;
+
+		tmp += GET_INSN_LENGTH(*(u16 *)tmp);
+	}
+
+	return false;
+}
+
 int __kprobes arch_prepare_kprobe(struct kprobe *p)
 {
 	unsigned long probe_addr = (unsigned long)p->addr;
@@ -55,6 +70,9 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 	if (probe_addr & 0x1)
 		return -EILSEQ;
 
+	if (!arch_check_kprobe(p))
+		return -EILSEQ;
+
 	/* copy instruction */
 	p->opcode = *p->addr;
 
-- 
2.36.1

