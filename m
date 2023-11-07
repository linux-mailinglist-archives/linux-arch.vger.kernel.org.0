Return-Path: <linux-arch+bounces-53-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA897E3B4A
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 12:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A36C0280F8E
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 11:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0272D7AD;
	Tue,  7 Nov 2023 11:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F81F1FA6;
	Tue,  7 Nov 2023 11:47:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2726EC433C8;
	Tue,  7 Nov 2023 11:47:15 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Arnd Bergmann <arnd@arndb.de>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-arch@vger.kernel.org,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch/smp: Call rcutree_report_cpu_starting() earlier
Date: Tue,  7 Nov 2023 19:47:04 +0800
Message-Id: <20231107114704.2751316-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rcutree_report_cpu_starting() must be called before cpu_probe() to avoid
the following lockdep splat that triggered by calling __alloc_pages() when
CONFIG_PROVE_RCU_LIST=y:

 =============================
 WARNING: suspicious RCU usage
 6.6.0+ #980 Not tainted
 -----------------------------
 kernel/locking/lockdep.c:3761 RCU-list traversed in non-reader section!!
 other info that might help us debug this:
 RCU used illegally from offline CPU!
 rcu_scheduler_active = 1, debug_locks = 1
 1 lock held by swapper/1/0:
  #0: 900000000c82ef98 (&pcp->lock){+.+.}-{2:2}, at: get_page_from_freelist+0x894/0x1790
 CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.6.0+ #980
 Stack : 0000000000000001 9000000004f79508 9000000004893670 9000000100310000
         90000001003137d0 0000000000000000 90000001003137d8 9000000004f79508
         0000000000000000 0000000000000001 0000000000000000 90000000048a3384
         203a656d616e2065 ca43677b3687e616 90000001002c3480 0000000000000008
         000000000000009d 0000000000000000 0000000000000001 80000000ffffe0b8
         000000000000000d 0000000000000033 0000000007ec0000 13bbf50562dad831
         9000000005140748 0000000000000000 9000000004f79508 0000000000000004
         0000000000000000 9000000005140748 90000001002bad40 0000000000000000
         90000001002ba400 0000000000000000 9000000003573ec8 0000000000000000
         00000000000000b0 0000000000000004 0000000000000000 0000000000070000
         ...
 Call Trace:
 [<9000000003573ec8>] show_stack+0x38/0x150
 [<9000000004893670>] dump_stack_lvl+0x74/0xa8
 [<900000000360d2bc>] lockdep_rcu_suspicious+0x14c/0x190
 [<900000000361235c>] __lock_acquire+0xd0c/0x2740
 [<90000000036146f4>] lock_acquire+0x104/0x2c0
 [<90000000048a955c>] _raw_spin_lock_irqsave+0x5c/0x90
 [<900000000381cd5c>] rmqueue_bulk+0x6c/0x950
 [<900000000381fc0c>] get_page_from_freelist+0xd4c/0x1790
 [<9000000003821c6c>] __alloc_pages+0x1bc/0x3e0
 [<9000000003583b40>] tlb_init+0x150/0x2a0
 [<90000000035742a0>] per_cpu_trap_init+0xf0/0x110
 [<90000000035712fc>] cpu_probe+0x3dc/0x7a0
 [<900000000357ed20>] start_secondary+0x40/0xb0
 [<9000000004897138>] smpboot_entry+0x54/0x58

raw_smp_processor_id() is required in order to avoid calling into lockdep
before RCU has declared the CPU to be watched for readers.

See also commit 29368e093921 ("x86/smpboot: Move rcu_cpu_starting() earlier"),
commit de5d9dae150c ("s390/smp: move rcu_cpu_starting() earlier") and commit
99f070b62322 ("powerpc/smp: Call rcu_cpu_starting() earlier").

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/smp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index ef35c871244f..5bca12d16e06 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -504,8 +504,9 @@ asmlinkage void start_secondary(void)
 	unsigned int cpu;
 
 	sync_counter();
-	cpu = smp_processor_id();
+	cpu = raw_smp_processor_id();
 	set_my_cpu_offset(per_cpu_offset(cpu));
+	rcutree_report_cpu_starting(cpu);
 
 	cpu_probe();
 	constant_clockevent_init();
-- 
2.39.3


