Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38A43280E5
	for <lists+linux-arch@lfdr.de>; Mon,  1 Mar 2021 15:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235783AbhCAObO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Mar 2021 09:31:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:57406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236359AbhCAOaw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Mar 2021 09:30:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D90D64DBA;
        Mon,  1 Mar 2021 14:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614609011;
        bh=MucoJTNiFHCFYNwN2fx6G+sQ2VpQS44c0zeeuezrTos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rbx8gdTS4v7hg0KO2eaeQK1DKUK2N5PyUae0bKPtj1xcqfwK9GuL3iA5dRfa87Md5
         yqhDHWsH0V28RXC65G0kbq5pd2YTh0WydUc44+d8gFB7N+Y0SvVXNK3oiy73qAlNA3
         I1wVEcFmeulFH7Ya+U/4kgKkzP0vvDBbQmESCSa2vii3yNwTAvOEJOPxDBjA0KHZFE
         NLfGwF45GTKehISWdoCSRBJWI0pCPAKXxgMs1xedQcSUKAEv+RvP9qI8YuLeTmoJkJ
         UE4rElruxCD9TKEF2DkIfI8qDzIzvPZSPk4fFBl8A9kLBpaFJsMczC8rD+kXiLoB+b
         h9vPdPtctGERA==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4/4] perf: csky: Using CPUHP_AP_ONLINE_DYN
Date:   Mon,  1 Mar 2021 14:28:22 +0000
Message-Id: <1614608902-85038-4-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614608902-85038-1-git-send-email-guoren@kernel.org>
References: <1614608902-85038-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Remove C-SKY perf custom definitions in hotplug.h:
 - CPUHP_AP_PERF_CSKY_ONLINE

For coding convention.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Tested-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Link: https://lore.kernel.org/lkml/CAHk-=wjM+kCsKqNdb=c0hKsv=J7-3Q1zmM15vp6_=8S5XfGMtA@mail.gmail.com/
---
 arch/csky/kernel/perf_event.c | 4 ++--
 include/linux/cpuhotplug.h    | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/csky/kernel/perf_event.c b/arch/csky/kernel/perf_event.c
index e5f1842..ccc27c3 100644
--- a/arch/csky/kernel/perf_event.c
+++ b/arch/csky/kernel/perf_event.c
@@ -1319,10 +1319,10 @@ int csky_pmu_device_probe(struct platform_device *pdev,
 		pr_notice("[perf] PMU request irq fail!\n");
 	}
 
-	ret = cpuhp_setup_state(CPUHP_AP_PERF_CSKY_ONLINE, "AP_PERF_ONLINE",
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "arch/csky/perf_event:starting",
 				csky_pmu_starting_cpu,
 				csky_pmu_dying_cpu);
-	if (ret) {
+	if (ret < 0) {
 		csky_pmu_free_irq();
 		free_percpu(csky_pmu.hw_events);
 		return ret;
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 7f25b44..3a76019 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -182,7 +182,6 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_POWERPC_TRACE_IMC_ONLINE,
 	CPUHP_AP_PERF_POWERPC_HV_24x7_ONLINE,
 	CPUHP_AP_PERF_POWERPC_HV_GPCI_ONLINE,
-	CPUHP_AP_PERF_CSKY_ONLINE,
 	CPUHP_AP_WATCHDOG_ONLINE,
 	CPUHP_AP_WORKQUEUE_ONLINE,
 	CPUHP_AP_RCUTREE_ONLINE,
-- 
2.7.4

