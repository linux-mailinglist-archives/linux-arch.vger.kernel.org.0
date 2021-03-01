Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 807C13280E1
	for <lists+linux-arch@lfdr.de>; Mon,  1 Mar 2021 15:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236329AbhCAOan (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Mar 2021 09:30:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:57258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232960AbhCAOam (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Mar 2021 09:30:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5331D64DF5;
        Mon,  1 Mar 2021 14:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614609001;
        bh=yJODrusALU+6lGK3sTBTBJlwkQywsg5kKkp+JdY5FlY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GT4Zb990BBV21L5216of6GW7Ifg/KewOZqZ9YV3HlxJ91EG1P2uadJ68FjQf+nMnD
         2GLHjGQMPDubUtQqe2x3Rd0B5zWnys94b5cc2dwQ6cYEGDxSDIV4krPFuwM9ypW8Gr
         uBisMEypw1sy19olWb4jIqD1bvR9Rd8V5ucmvLnVKBkIrzLrPX0pd8mwaQn3StSjWU
         YQzjDC50XFYq9j5Qqmb9/xFiwxYS75+nR8df/9OnsSdO1jv6rrGaz8fB1lnkEIR+hI
         aj1Y+f3pwrcDNzmaS3BRR3r4zhkX3i1quWyPVPrsqXHZBVs/htwPyO+9w5hnPjZmiR
         G7CUfzABALFjQ==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3/4] clocksource: csky: Using CPUHP_AP_ONLINE_DYN
Date:   Mon,  1 Mar 2021 14:28:21 +0000
Message-Id: <1614608902-85038-3-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614608902-85038-1-git-send-email-guoren@kernel.org>
References: <1614608902-85038-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Remove C-SKY clocksource custom definitions in hotplug.h:
 - CPUHP_AP_CSKY_TIMER_STARTING

For coding convention.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Tested-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Link: https://lore.kernel.org/lkml/CAHk-=wjM+kCsKqNdb=c0hKsv=J7-3Q1zmM15vp6_=8S5XfGMtA@mail.gmail.com/
---
 drivers/clocksource/timer-mp-csky.c | 4 ++--
 include/linux/cpuhotplug.h          | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-mp-csky.c b/drivers/clocksource/timer-mp-csky.c
index 183a995..fc17d77 100644
--- a/drivers/clocksource/timer-mp-csky.c
+++ b/drivers/clocksource/timer-mp-csky.c
@@ -151,11 +151,11 @@ static int __init csky_mptimer_init(struct device_node *np)
 	clocksource_register_hz(&csky_clocksource, timer_of_rate(to));
 	sched_clock_register(sched_clock_read, 32, timer_of_rate(to));
 
-	ret = cpuhp_setup_state(CPUHP_AP_CSKY_TIMER_STARTING,
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
 				"clockevents/csky/timer:starting",
 				csky_mptimer_starting_cpu,
 				csky_mptimer_dying_cpu);
-	if (ret)
+	if (ret < 0)
 		return -EINVAL;
 
 	return 0;
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index f60538b..7f25b44 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -131,7 +131,6 @@ enum cpuhp_state {
 	CPUHP_AP_MIPS_GIC_TIMER_STARTING,
 	CPUHP_AP_ARC_TIMER_STARTING,
 	CPUHP_AP_CLINT_TIMER_STARTING,
-	CPUHP_AP_CSKY_TIMER_STARTING,
 	CPUHP_AP_HYPERV_TIMER_STARTING,
 	CPUHP_AP_KVM_STARTING,
 	CPUHP_AP_KVM_ARM_VGIC_INIT_STARTING,
-- 
2.7.4

