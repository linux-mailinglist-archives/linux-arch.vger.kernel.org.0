Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED6F421E39
	for <lists+linux-arch@lfdr.de>; Tue,  5 Oct 2021 07:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbhJEFnz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Oct 2021 01:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbhJEFnP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Oct 2021 01:43:15 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D03EC061767;
        Mon,  4 Oct 2021 22:41:26 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id v11so6148979pgb.8;
        Mon, 04 Oct 2021 22:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PN1SnsAr5qtcccHhg1TXrsqv+SN4IjsrbS3fnYHlx48=;
        b=nTEY1+qTJaEFsV4dMUSRInRVjU5PmvSR+bq2viqVuFW4zLuYhON05f27dmvEp+Of/v
         PjM0BenijyhPSLUGByu3U14Z323wLir16Z5TPlIvMgTvvs/tKr6FRK4WxBsy6e1A1gE7
         1Nn4aK5V3lHKyMqzdOq5AqRF8rLLQyYb/Sz374i0x6RCqo9avGOlQCNuoR84x9mpifu0
         HDJFQ0xQCETwZ3QeE78H4Q5s0a6tPCB8InTjdgwTnUMy57xuX4k8vucrfDP2LielaV7/
         W5NXQh6iuY/FR0b74ckdzOPXRQ7koZFuijHvtc+OCHwPj22Oe550c26EkXgRpjCHjC/3
         o4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PN1SnsAr5qtcccHhg1TXrsqv+SN4IjsrbS3fnYHlx48=;
        b=lpyjHdEpxTq8lN2MNCIMoG0srDwyndiQnr83G01eh1Um92Vv8Rl15qO28E3tuyefkG
         +nXYwyHvI6UDMSvTOSmIShZORFLpxWJtm/HAZmXY+aXGUMtNYZN1KPakjJA7FDpbMRPg
         srhusnxSI4X6jVGAmVIptmbl9V4aCc1vYKOvJgx6PJipKJ6APAgV95Ox1ABkCLCuC/or
         Wzww+tX2Hz4HrUBz7CElZjTWN6WWekKZoSrMAUYHL1nMbkR6VSskEZH5VKJZa2VEH+2H
         kIKBsiSU0wS00Wsg6tV+6bIRrSOpH6EkjRhLrZuYjtyIgeF7e7/hoXfD5uWluPEfVLmG
         nkGw==
X-Gm-Message-State: AOAM532SePtSwBlcX9HbsP4mgFflq6pNLSsGODH6re0SjiQm4cp6pVSr
        r1Yyq2lqCLTa9xy8StVGee4=
X-Google-Smtp-Source: ABdhPJy4xT5z1reZAEMRl4Zo/gyKf7y4Xhui/F+FUAn6N2CEUOisZ8Bwxqia7dhoUC4OzTnFiC7HCQ==
X-Received: by 2002:aa7:97bc:0:b0:44c:53f:fbd with SMTP id d28-20020aa797bc000000b0044c053f0fbdmr25161717pfq.19.1633412485481;
        Mon, 04 Oct 2021 22:41:25 -0700 (PDT)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id g3sm15719059pgj.66.2021.10.04.22.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 22:41:25 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-perf-users@vger.kernel.org,
        kvm@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Alexander Lobakin <alobakin@pm.me>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Klimov <aklimov@redhat.com>,
        Andrea Merello <andrea.merello@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Ben Gardon <bgardon@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Brian Cain <bcain@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Joe Perches <joe@perches.com>, Jonas Bonn <jonas@southpole.se>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Rich Felker <dalias@libc.org>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        Sean Christopherson <seanjc@google.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Will Deacon <will@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH 09/16] cpumask: replace cpumask_next_* with cpumask_first_* where appropriate
Date:   Mon,  4 Oct 2021 22:40:52 -0700
Message-Id: <20211005054059.475634-10-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211005054059.475634-1-yury.norov@gmail.com>
References: <20211005054059.475634-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

cpumask_first() is a more effective analogue of 'next' version if n == -1
(which means start == 0). This patch replaces 'next' with 'first' where
things look trivial.

There's no cpumask_first_zero() function, so create it.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/powerpc/include/asm/cputhreads.h |  2 +-
 block/blk-mq.c                        |  2 +-
 drivers/net/virtio_net.c              |  2 +-
 drivers/soc/fsl/qbman/bman_portal.c   |  2 +-
 drivers/soc/fsl/qbman/qman_portal.c   |  2 +-
 include/linux/cpumask.h               | 16 ++++++++++++++++
 kernel/time/clocksource.c             |  4 ++--
 7 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/cputhreads.h b/arch/powerpc/include/asm/cputhreads.h
index b167186aaee4..44286df21d2a 100644
--- a/arch/powerpc/include/asm/cputhreads.h
+++ b/arch/powerpc/include/asm/cputhreads.h
@@ -52,7 +52,7 @@ static inline cpumask_t cpu_thread_mask_to_cores(const struct cpumask *threads)
 	for (i = 0; i < NR_CPUS; i += threads_per_core) {
 		cpumask_shift_left(&tmp, &threads_core_mask, i);
 		if (cpumask_intersects(threads, &tmp)) {
-			cpu = cpumask_next_and(-1, &tmp, cpu_online_mask);
+			cpu = cpumask_first_and(&tmp, cpu_online_mask);
 			if (cpu < nr_cpu_ids)
 				cpumask_set_cpu(cpu, &res);
 		}
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 108a352051be..d4f5a05f4470 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2536,7 +2536,7 @@ static bool blk_mq_hctx_has_requests(struct blk_mq_hw_ctx *hctx)
 static inline bool blk_mq_last_cpu_in_hctx(unsigned int cpu,
 		struct blk_mq_hw_ctx *hctx)
 {
-	if (cpumask_next_and(-1, hctx->cpumask, cpu_online_mask) != cpu)
+	if (cpumask_first_and(hctx->cpumask, cpu_online_mask) != cpu)
 		return false;
 	if (cpumask_next_and(cpu, hctx->cpumask, cpu_online_mask) < nr_cpu_ids)
 		return false;
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 79bd2585ec6b..a3b16790846c 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2085,7 +2085,7 @@ static void virtnet_set_affinity(struct virtnet_info *vi)
 	stragglers = num_cpu >= vi->curr_queue_pairs ?
 			num_cpu % vi->curr_queue_pairs :
 			0;
-	cpu = cpumask_next(-1, cpu_online_mask);
+	cpu = cpumask_first(cpu_online_mask);
 
 	for (i = 0; i < vi->curr_queue_pairs; i++) {
 		group_size = stride + (i < stragglers ? 1 : 0);
diff --git a/drivers/soc/fsl/qbman/bman_portal.c b/drivers/soc/fsl/qbman/bman_portal.c
index acda8a5637c5..4d7b9caee1c4 100644
--- a/drivers/soc/fsl/qbman/bman_portal.c
+++ b/drivers/soc/fsl/qbman/bman_portal.c
@@ -155,7 +155,7 @@ static int bman_portal_probe(struct platform_device *pdev)
 	}
 
 	spin_lock(&bman_lock);
-	cpu = cpumask_next_zero(-1, &portal_cpus);
+	cpu = cpumask_first_zero(&portal_cpus);
 	if (cpu >= nr_cpu_ids) {
 		__bman_portals_probed = 1;
 		/* unassigned portal, skip init */
diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
index 96f74a1dc603..e23b60618c1a 100644
--- a/drivers/soc/fsl/qbman/qman_portal.c
+++ b/drivers/soc/fsl/qbman/qman_portal.c
@@ -248,7 +248,7 @@ static int qman_portal_probe(struct platform_device *pdev)
 	pcfg->pools = qm_get_pools_sdqcr();
 
 	spin_lock(&qman_lock);
-	cpu = cpumask_next_zero(-1, &portal_cpus);
+	cpu = cpumask_first_zero(&portal_cpus);
 	if (cpu >= nr_cpu_ids) {
 		__qman_portals_probed = 1;
 		/* unassigned portal, skip init */
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index c7be6c5b7523..862856fe0056 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -123,6 +123,11 @@ static inline unsigned int cpumask_first(const struct cpumask *srcp)
 	return 0;
 }
 
+static inline unsigned int cpumask_first_zero(const struct cpumask *srcp)
+{
+	return 0;
+}
+
 static inline unsigned int cpumask_first_and(const struct cpumask *srcp1,
 					     const struct cpumask *srcp2)
 {
@@ -201,6 +206,17 @@ static inline unsigned int cpumask_first(const struct cpumask *srcp)
 	return find_first_bit(cpumask_bits(srcp), nr_cpumask_bits);
 }
 
+/**
+ * cpumask_first_zero - get the first unset cpu in a cpumask
+ * @srcp: the cpumask pointer
+ *
+ * Returns >= nr_cpu_ids if all cpus are set.
+ */
+static inline unsigned int cpumask_first_zero(const struct cpumask *srcp)
+{
+	return find_first_zero_bit(cpumask_bits(srcp), nr_cpumask_bits);
+}
+
 /**
  * cpumask_first_and - return the first cpu from *srcp1 & *srcp2
  * @src1p: the first input
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index b8a14d2fb5ba..f29d1a524fa5 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -257,7 +257,7 @@ static void clocksource_verify_choose_cpus(void)
 		return;
 
 	/* Make sure to select at least one CPU other than the current CPU. */
-	cpu = cpumask_next(-1, cpu_online_mask);
+	cpu = cpumask_first(cpu_online_mask);
 	if (cpu == smp_processor_id())
 		cpu = cpumask_next(cpu, cpu_online_mask);
 	if (WARN_ON_ONCE(cpu >= nr_cpu_ids))
@@ -279,7 +279,7 @@ static void clocksource_verify_choose_cpus(void)
 		cpu = prandom_u32() % nr_cpu_ids;
 		cpu = cpumask_next(cpu - 1, cpu_online_mask);
 		if (cpu >= nr_cpu_ids)
-			cpu = cpumask_next(-1, cpu_online_mask);
+			cpu = cpumask_first(cpu_online_mask);
 		if (!WARN_ON_ONCE(cpu >= nr_cpu_ids))
 			cpumask_set_cpu(cpu, &cpus_chosen);
 	}
-- 
2.30.2

