Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3852C3280DE
	for <lists+linux-arch@lfdr.de>; Mon,  1 Mar 2021 15:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236347AbhCAOaX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Mar 2021 09:30:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:56892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236334AbhCAOaV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Mar 2021 09:30:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4874164DA3;
        Mon,  1 Mar 2021 14:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614608980;
        bh=OArrRIuC6qn8rHGJqrdoBqnUGJ5tnNzIJ9KKzMe2piE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hu91S+8zTjYMGojrOYDPV5ZNI3asCKh/MSTSyMNzUKh4vy4hwLNcdt49KpGgVh2Ca
         OBE8dcgLFkgW6xVO2cL5N+IvQB4zUsZNzoATofycfRe4/eMqNi+G2PXv2pKa2Z9T9r
         2OU8R6nNttlvksUmWuKwUx0i40u+lcjZQot85JTuYim9QhK+dVMzqK+1/9vvwxNkTJ
         V1MD+HO+V8BPs85pLyKHxDkncBO40y0yrVq77LdiIObDQuksCfHnI2STLzFYbffNgz
         0euFHxT3oOgNlyVX3DjHNAPKoY6TBEUTqf21oYO0CxDSTDUNJ2gwvE9cCu9WnD7s4/
         eUhDtb7ND4lFA==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Anup Patel <anup.patel@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH 2/4] clocksource: riscv: Using CPUHP_AP_ONLINE_DYN
Date:   Mon,  1 Mar 2021 14:28:20 +0000
Message-Id: <1614608902-85038-2-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614608902-85038-1-git-send-email-guoren@kernel.org>
References: <1614608902-85038-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Remove RISC-V clocksource custom definitions in hotplug.h:
 - CPUHP_AP_RISCV_TIMER_STARTING

For coding convention.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Anup Patel <anup.patel@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
Tested-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Link: https://lore.kernel.org/lkml/CAHk-=wjM+kCsKqNdb=c0hKsv=J7-3Q1zmM15vp6_=8S5XfGMtA@mail.gmail.com/
---
 drivers/clocksource/timer-riscv.c | 4 ++--
 include/linux/cpuhotplug.h        | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index c51c5ed..43aee27 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -150,10 +150,10 @@ static int __init riscv_timer_init_dt(struct device_node *n)
 		return error;
 	}
 
-	error = cpuhp_setup_state(CPUHP_AP_RISCV_TIMER_STARTING,
+	error = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
 			 "clockevents/riscv/timer:starting",
 			 riscv_timer_starting_cpu, riscv_timer_dying_cpu);
-	if (error)
+	if (error < 0)
 		pr_err("cpu hp setup state failed for RISCV timer [%d]\n",
 		       error);
 	return error;
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 14f49fd..f60538b 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -130,7 +130,6 @@ enum cpuhp_state {
 	CPUHP_AP_MARCO_TIMER_STARTING,
 	CPUHP_AP_MIPS_GIC_TIMER_STARTING,
 	CPUHP_AP_ARC_TIMER_STARTING,
-	CPUHP_AP_RISCV_TIMER_STARTING,
 	CPUHP_AP_CLINT_TIMER_STARTING,
 	CPUHP_AP_CSKY_TIMER_STARTING,
 	CPUHP_AP_HYPERV_TIMER_STARTING,
-- 
2.7.4

