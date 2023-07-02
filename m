Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA04744C0E
	for <lists+linux-arch@lfdr.de>; Sun,  2 Jul 2023 04:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjGBC52 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 1 Jul 2023 22:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjGBC51 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 1 Jul 2023 22:57:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415601705;
        Sat,  1 Jul 2023 19:57:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A160760AE8;
        Sun,  2 Jul 2023 02:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D74C433C7;
        Sun,  2 Jul 2023 02:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688266644;
        bh=KVAMyfKWjVwwLKGxATgxHTcW5xvo69PZktIxihAIbBw=;
        h=From:To:Cc:Subject:Date:From;
        b=jsdwgGk96dt3I47o1PYBrvECOCVIDHA3vugLsQJRAfRPn5ULpsltjeB5JVuBECQgk
         z39LttKtf0epErz0P5dJqlC3thXTyxja+sCTpZepc92xXFBimh58gthiJuo9X1O7qi
         HeKA2OsetQLQgOfR3lE/6NSHPEFsvJdCD4MuQDh5fuS7iKzm7ejhwfpp+HllnP7/mF
         IzP6S68/4wG4yHeCp3/iYfoRBivLjtd8OrUiez+cdeA6lA3KLShqGfygRnXm98n36S
         Z0Z8/heQEPuovLOYSuDKgb70Exc+jdumgvab2cPF8tZxYPl0b6ehlcvo/kXeUcTQ/N
         xbccNOBE0o75g==
From:   guoren@kernel.org
To:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
        falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, mark.rutland@arm.com, bjorn@kernel.org,
        palmer@dabbelt.com, guoren@kernel.org, bjorn@rivosinc.com,
        daniel.thompson@linaro.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, stable@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH] riscv: entry: Fixup do_trap_break from kernel side
Date:   Sat,  1 Jul 2023 22:57:07 -0400
Message-Id: <20230702025708.784106-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The irqentry_nmi_enter/exit would force the current context into in_interrupt.
That would trigger the kernel to dead panic, but the kdb still needs "ebreak" to
debug the kernel.

Move irqentry_nmi_enter/exit to exception_enter/exit could correct handle_break
of the kernel side.

Before the fixup:
$echo BUG > /sys/kernel/debug/provoke-crash/DIRECT
  lkdtm: Performing direct entry BUG
  ------------[ cut here ]------------
  kernel BUG at drivers/misc/lkdtm/bugs.c:78!
  handle_break, 256.
  Kernel BUG [#1]
  Modules linked in:
  CPU: 0 PID: 104 Comm: echo Not tainted 6.4.0-rc1-00055-g0ca05a4b079f-dirty #30
  Hardware name: riscv-virtio,qemu (DT)
  epc : lkdtm_BUG+0x6/0x8
   ra : lkdtm_do_action+0x14/0x1c
  epc : ffffffff8055c730 ra : ffffffff8087e188 sp : ff200000007dbd40
   gp : ffffffff81500878 tp : ff600000028ebac0 t0 : 6500000000000000
   t1 : 000000000000006c t2 : 6550203a6d74646b s0 : ff200000007dbd50
   s1 : ffffffff814bfc80 a0 : ffffffff814bfc80 a1 : ff6000001ffd8608
   a2 : ff6000001ffdb870 a3 : 0000000000000000 a4 : 0000000000000000
   a5 : ffffffff8055c72a a6 : 0000000000000032 a7 : 0000000000000038
   s2 : 0000000000000004 s3 : 00000000556371a0 s4 : ff200000007dbe70
   s5 : ff60000002090000 s6 : 00000000556371a0 s7 : 0000000000000030
   s8 : 000000007fffec78 s9 : 0000000000000007 s10: 0000000055637530
   s11: 0000000000000001 t3 : ffffffff81513ed7 t4 : ffffffff81513ed7
   t5 : ffffffff81513ed8 t6 : ff200000007dbb88
  status: 0000000100000120 badaddr: 0000000000000000 cause: 0000000000000003
  [<ffffffff8055c730>] lkdtm_BUG+0x6/0x8
  Code: 0513 6b05 b097 0031 80e7 e960 b705 1141 e422 0800 (9002) 1141
  ---[ end trace 0000000000000000 ]---
  Kernel panic - not syncing: Aiee, killing interrupt handler!
  ---[ end Kernel panic - not syncing: Aiee, killing interrupt handler! ]---

(Dead in the kernel side.)

After the fixup:
$echo BUG > /sys/kernel/debug/provoke-crash/DIRECT
  lkdtm: Performing direct entry BUG
  ------------[ cut here ]------------
  kernel BUG at drivers/misc/lkdtm/bugs.c:78!
  Kernel BUG [#13]
  Modules linked in:
  CPU: 0 PID: 129 Comm: echo Tainted: G D 6.4.0-rc1-00055-g0ca05a4b079f-dirty #34
  Hardware name: riscv-virtio,qemu (DT)
  epc : lkdtm_BUG+0x6/0x8
   ra : lkdtm_do_action+0x14/0x1c
  epc : ffffffff8055c71c ra : ffffffff8087e170 sp : ff200000007e3d40
   gp : ffffffff81500878 tp : ff600000028ebac0 t0 : 6500000000000000
   t1 : 000000000000006c t2 : 6550203a6d74646b s0 : ff200000007e3d50
   s1 : ffffffff814bfc80 a0 : ffffffff814bfc80 a1 : ff6000001ffd8608
   a2 : ff6000001ffdb870 a3 : 0000000000000000 a4 : 0000000000000000
   a5 : ffffffff8055c716 a6 : 0000000000000032 a7 : 0000000000000038
   s2 : 0000000000000004 s3 : 00000000556371a0 s4 : ff200000007e3e70
   s5 : ff60000002090000 s6 : 00000000556371a0 s7 : 0000000000000030
   s8 : 000000007fffec78 s9 : 0000000000000007 s10: 0000000055637530
   s11: 0000000000000001 t3 : ffffffff81513ed7 t4 : ffffffff81513ed7
   t5 : ffffffff81513ed8 t6 : ff200000007e3b88
  status: 0000000100000120 badaddr: 0000000000000000 cause: 0000000000000003
  [<ffffffff8055c71c>] lkdtm_BUG+0x6/0x8
  Code: 0513 6945 b097 0031 80e7 e920 b705 1141 e422 0800 (9002) 1141
  ---[ end trace 0000000000000000 ]---
  note: echo[129] exited with irqs disabled
  Segmentation fault

(Resume to the shell normally.)

Fixes: f0bddf50586d ("riscv: entry: Convert to generic entry")
Reported-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/riscv/kernel/traps.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index efc6b649985a..ed0eb9452f9e 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -18,6 +18,7 @@
 #include <linux/irq.h>
 #include <linux/kexec.h>
 #include <linux/entry-common.h>
+#include <linux/context_tracking.h>
 
 #include <asm/asm-prototypes.h>
 #include <asm/bug.h>
@@ -257,11 +258,11 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
 
 		irqentry_exit_to_user_mode(regs);
 	} else {
-		irqentry_state_t state = irqentry_nmi_enter(regs);
+		enum ctx_state prev_state = exception_enter();
 
 		handle_break(regs);
 
-		irqentry_nmi_exit(regs, state);
+		exception_exit(prev_state);
 	}
 }
 
-- 
2.36.1

