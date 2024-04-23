Return-Path: <linux-arch+bounces-3907-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 384D58ADE70
	for <lists+linux-arch@lfdr.de>; Tue, 23 Apr 2024 09:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69F531C21722
	for <lists+linux-arch@lfdr.de>; Tue, 23 Apr 2024 07:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D240647F45;
	Tue, 23 Apr 2024 07:43:38 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A1347A5D;
	Tue, 23 Apr 2024 07:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713858218; cv=none; b=crupKciJ2tLehGcOcKUEhPkdbWVjvOTmwaikcPFUcH6GBYoj4NvPzQ5CE6/yqcfKcroj4j3USjXUUk5BOQZIemsoLZd0GW4W6A8wtD8SN8mn9giUcJnIFdmQk1h9KOH0DVLfoEdbwPiG9vu3Np6S73JvLrEc6rdvHXQJYT5VKAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713858218; c=relaxed/simple;
	bh=zpqXzeN1h9+yujdqercMpcnT15Uwq0O3FUcKIyg2OOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f0cwPgC/aZhjYjDSe+x2IeWRuwgnIDPcIY/XcBtDSF7HQJrmbe5jmOJ/bJaPYhW/gV+dwjkIsLYxaBolHXz3RmZBH8CZX3gdWluOfC25CdifWzSJjdZ1Y6xCMxTURT969jlCeWsZNEfEX7YMjhXKHXGA566QYpeRbcxlki+WwbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896E0C116B1;
	Tue, 23 Apr 2024 07:43:35 +0000 (UTC)
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
	Huacai Chen <chenhuacai@loongson.cn>,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH] LoongArch: Fix callchain parse error with kernel tracepoint events
Date: Tue, 23 Apr 2024 15:43:22 +0800
Message-ID: <20240423074322.2480319-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to fix perf's callchain parse error for LoongArch, we implement
perf_arch_fetch_caller_regs() which fills several necessary registers
used for callchain unwinding, including sp, fp, and era. This is similar
to the following commits.

commit b3eac0265bf6:
("arm: perf: Fix callchain parse error with kernel tracepoint events")

commit 5b09a094f2fb:
("arm64: perf: Fix callchain parse error with kernel tracepoint events")

commit 9a7e8ec0d4cc:
("riscv: perf: Fix callchain parse error with kernel tracepoint events")

Test with commands:

 perf record -e sched:sched_switch -g --call-graph dwarf
 perf report

Without this patch:

 Children      Self  Command        Shared Object      Symbol
 ........  ........  .............  .................  ....................

 43.41%    43.41%  swapper          [unknown]          [k] 0000000000000000

 10.94%    10.94%  loong-container  [unknown]          [k] 0000000000000000
         |
         |--5.98%--0x12006ba38
         |
         |--2.56%--0x12006bb84
         |
          --2.40%--0x12006b6b8

With this patch, callchain can be parsed correctly:

 Children      Self  Command        Shared Object      Symbol
 ........  ........  .............  .................  ....................

 47.57%    47.57%  swapper          [kernel.vmlinux]   [k] __schedule
         |
         ---__schedule

 26.76%    26.76%  loong-container  [kernel.vmlinux]   [k] __schedule
         |
         |--13.78%--0x12006ba38
         |          |
         |          |--9.19%--__schedule
         |          |
         |           --4.59%--handle_syscall
         |                     do_syscall
         |                     sys_futex
         |                     do_futex
         |                     futex_wait
         |                     futex_wait_queue_me
         |                     hrtimer_start_range_ns
         |                     __schedule
         |
         |--8.38%--0x12006bb84
         |          handle_syscall
         |          do_syscall
         |          sys_epoll_pwait
         |          do_epoll_wait
         |          schedule_hrtimeout_range_clock
         |          hrtimer_start_range_ns
         |          __schedule
         |
          --4.59%--0x12006b6b8
                    handle_syscall
                    do_syscall
                    sys_nanosleep
                    hrtimer_nanosleep
                    do_nanosleep
                    hrtimer_start_range_ns
                    __schedule

Reported-by: Youling Tang <tangyouling@kylinos.cn>
Suggested-by: Youling Tang <tangyouling@kylinos.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/perf_event.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/loongarch/include/asm/perf_event.h b/arch/loongarch/include/asm/perf_event.h
index 2a35a0bc2aaa..157c4ace69d0 100644
--- a/arch/loongarch/include/asm/perf_event.h
+++ b/arch/loongarch/include/asm/perf_event.h
@@ -9,4 +9,10 @@
 
 #define perf_arch_bpf_user_pt_regs(regs) (struct user_pt_regs *)regs
 
+#define perf_arch_fetch_caller_regs(regs, __ip) { \
+	(regs)->csr_era = (__ip); \
+	(regs)->regs[3] = current_stack_pointer; \
+	(regs)->regs[22] = (unsigned long) __builtin_frame_address(0); \
+}
+
 #endif /* __LOONGARCH_PERF_EVENT_H__ */
-- 
2.43.0


