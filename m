Return-Path: <linux-arch+bounces-4231-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A548BDBC9
	for <lists+linux-arch@lfdr.de>; Tue,  7 May 2024 08:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86947282A9D
	for <lists+linux-arch@lfdr.de>; Tue,  7 May 2024 06:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4378378C75;
	Tue,  7 May 2024 06:44:45 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216616D1CC;
	Tue,  7 May 2024 06:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715064285; cv=none; b=OiG9wRo0in2stUPhuZbWS3bY1uCaBGey7SZTrZd0mzhJOSdhvD1ddZuloberaSLPeAc5u6UMTQDypNvJMCDy/nkCxNx6QeKJMIbzRqqoOoF5OnwGw4/Jx89wyYSptWWP4XLADO7Ax81wC1AUxeOOZwKTU/XZjirjM8Tq0XNsFNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715064285; c=relaxed/simple;
	bh=1V7K+aUPbBwWZ9MVf0X+WSKhleKpWp++FFeYZHejQg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jzUGraDRV6nxZXeC0kMb+L7fDRgJO2W78GalQ89JrQK0inEaJteSYMHhr0ZMX/ZlvniSmdGZUPzzA61Q4i8UE/0l1VSbA7Lfb+KzsZLrhLgTZfePrBaXYomZJuO22Wnn7aYQhAFjvRGdplRotGuFO8CEw50DWI/Gelx7spjutxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D41C2BBFC;
	Tue,  7 May 2024 06:44:41 +0000 (UTC)
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
Subject: [PATCH] LoongArch: Fix callchain parse error with kernel tracepoint events again
Date: Tue,  7 May 2024 14:44:18 +0800
Message-ID: <20240507064418.3407414-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With commit d3119bc985fb645 ("LoongArch: Fix callchain parse error with
kernel tracepoint events"), perf can parse kernel callchain, but not
complete and sometimes maybe error. The reason is LoongArch's unwinders
(guess, prologue and orc) don't really need fp (i.e., regs[22]), and
they use sp (i.e., regs[3]) as the frame address rather than the current
stack pointer.

Fix that by removing the assignment of regs[22], and instead assign the
__builtin_frame_address(0) to regs[3].

Without fix:

  Children      Self  Command        Shared Object      Symbol
  ........  ........  .............  .................  ................
  33.91%    33.91%    swapper        [kernel.vmlinux]   [k] __schedule
            |
            |--33.04%--__schedule
            |
             --0.87%--__arch_cpu_idle
                       __schedule

With this fix:

  Children      Self  Command        Shared Object      Symbol
  ........  ........  .............  .................  ................
  31.16%    31.16%    swapper        [kernel.vmlinux]   [k] __schedule
            |
            |--20.63%--smpboot_entry
            |          cpu_startup_entry
            |          schedule_idle
            |          __schedule
            |
             --10.53%--start_kernel
                       cpu_startup_entry
                       schedule_idle
                       __schedule

Fixes: d3119bc985fb645 ("LoongArch: Fix callchain parse error with kernel tracepoint events")
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/perf_event.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/loongarch/include/asm/perf_event.h b/arch/loongarch/include/asm/perf_event.h
index 52b638059e40..f948a0676daf 100644
--- a/arch/loongarch/include/asm/perf_event.h
+++ b/arch/loongarch/include/asm/perf_event.h
@@ -13,8 +13,7 @@
 
 #define perf_arch_fetch_caller_regs(regs, __ip) { \
 	(regs)->csr_era = (__ip); \
-	(regs)->regs[3] = current_stack_pointer; \
-	(regs)->regs[22] = (unsigned long) __builtin_frame_address(0); \
+	(regs)->regs[3] = (unsigned long) __builtin_frame_address(0); \
 }
 
 #endif /* __LOONGARCH_PERF_EVENT_H__ */
-- 
2.43.0


