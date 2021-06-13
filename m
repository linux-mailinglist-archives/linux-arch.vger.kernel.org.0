Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6164B3A5AEC
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jun 2021 01:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbhFMXSn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 13 Jun 2021 19:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbhFMXSm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 13 Jun 2021 19:18:42 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E76AC061574;
        Sun, 13 Jun 2021 16:16:25 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id l3so12522288qvl.0;
        Sun, 13 Jun 2021 16:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cjTHkIEpJqk5aUrMUgYRpsHx71rKhZcwzOTeKST6Rqw=;
        b=e862F756VO4NyIWUzzGE5k2oSlSvmv4449B2yWjvoQYmTZmc2sXr1dQbBEx49aZm3O
         fo2NL8gLZt9+zgfjNEcm41Mot76fDak5YTGlEev+N/p9jRzZIoigLwvWrRV7uRIHWRAp
         KeuF7CgmbA98Ww22CtABakCxBmDln1ZmPjEbPVAa57eEbmSL9R5+PZdSXQlDTQeBlYYn
         YRvIYxntQvle0++sTX0D/hAu4wlWAQPEwcBQng/mgQOptiCOZFNTUp9k+xPt0KsFYuzo
         GydpoG2yzWOiDiH0Q4e/XQHEQ6IFsCDtS/gbrC3/dIyzPeh4QVLOeTuTZ5tNidZoiX+/
         aNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cjTHkIEpJqk5aUrMUgYRpsHx71rKhZcwzOTeKST6Rqw=;
        b=rtNmPc97nRSOLiE0xFziNR+0DXzYtYFtvU0HM3+tFUkpUzpQbaBj5iKNWbx86O9tks
         oyncQlGQS17PBLE7LJiQWEMDhtEXusXP6AH40mSm8dI/4ZYf5VJz4uPMe4tKwAWJn4SQ
         ZPn/bCSxX2sdGDcWdwdP+7+/NtMcstsJiUJw3gptNgPuRmTpenVHK2lt+/W8NmPUWktM
         QW0LnyaGiwoJfbKTCFcsOGsto746z4vaRVMsV7ZrpNqMwyCreP8g5mkQkVDqQlnv4+w6
         XIFG1Hmfv12wDcxaeacOcm7tj9tGp9Wanj7cNrdFbaUUzrvRzq/PJNSJHNAt82IktOKF
         8Zkg==
X-Gm-Message-State: AOAM532m1BWWh9km+JbbO25yop51tI1voe97TFqOtteSsi1RKXQpZGhY
        bewq5w1v7C9k3RXZiCfI6etsARxGl28twg==
X-Google-Smtp-Source: ABdhPJzZY6yuRUfSWuRRmrdO02OdJXgjm/QZ5nDyadq65x0Km1X2acHl6L7CmSnD+Olo1Mm8pq8+lg==
X-Received: by 2002:ad4:5008:: with SMTP id s8mr15909135qvo.34.1623626184159;
        Sun, 13 Jun 2021 16:16:24 -0700 (PDT)
Received: from localhost ([12.21.13.160])
        by smtp.gmail.com with ESMTPSA id s69sm7445809qke.115.2021.06.13.16.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 16:16:23 -0700 (PDT)
Date:   Sun, 13 Jun 2021 16:16:22 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Brian Cain <bcain@codeaurora.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Rich Felker <dalias@libc.org>,
        David Hildenbrand <david@redhat.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Alexey Klimov <aklimov@redhat.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH] cpumask: replace cpumask_next_* with cpumask_first_* where
 appropriate
Message-ID: <YMaRxsfCOgkc6gjO@yury-ThinkPad>
References: <20210612123639.329047-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210612123639.329047-1-yury.norov@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

cpumask_first() is a more effective analogue of 'next' version if n == -1
(which means start == 0). This patch replaces 'next' with 'first' where
things look trivial.

There's no cpumask_first_zero() function, so create it.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
I found another ~10 spots where people use find_next_bit() instead
of find_first_bit(). This patch should be added to the series.

 arch/powerpc/include/asm/cputhreads.h |  2 +-
 block/blk-mq.c                        |  2 +-
 drivers/net/virtio_net.c              |  2 +-
 drivers/soc/fsl/qbman/bman_portal.c   |  2 +-
 drivers/soc/fsl/qbman/qman_portal.c   |  2 +-
 include/linux/cpumask.h               | 16 ++++++++++++++++
 kernel/time/clocksource.c             |  4 ++--
 7 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/cputhreads.h b/arch/powerpc/include/asm/cputhreads.h
index 98c8bd155bf9..fb5bb080e5cd 100644
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
index 4261adee9964..99644209d693 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2547,7 +2547,7 @@ static bool blk_mq_hctx_has_requests(struct blk_mq_hw_ctx *hctx)
 static inline bool blk_mq_last_cpu_in_hctx(unsigned int cpu,
 		struct blk_mq_hw_ctx *hctx)
 {
-	if (cpumask_next_and(-1, hctx->cpumask, cpu_online_mask) != cpu)
+	if (cpumask_first_and(hctx->cpumask, cpu_online_mask) != cpu)
 		return false;
 	if (cpumask_next_and(cpu, hctx->cpumask, cpu_online_mask) < nr_cpu_ids)
 		return false;
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 21ff7b9e49c2..2608e51fe6e9 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2080,7 +2080,7 @@ static void virtnet_set_affinity(struct virtnet_info *vi)
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
index 6bee58600946..7831f406cad2 100644
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
index 4485635b69f5..61f429fd9c0e 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -256,7 +256,7 @@ static void clocksource_verify_choose_cpus(void)
 		return;
 
 	/* Make sure to select at least one CPU other than the current CPU. */
-	cpu = cpumask_next(-1, cpu_online_mask);
+	cpu = cpumask_first(cpu_online_mask);
 	if (cpu == smp_processor_id())
 		cpu = cpumask_next(cpu, cpu_online_mask);
 	if (WARN_ON_ONCE(cpu >= nr_cpu_ids))
@@ -278,7 +278,7 @@ static void clocksource_verify_choose_cpus(void)
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

