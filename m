Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAAE041F4A3
	for <lists+linux-arch@lfdr.de>; Fri,  1 Oct 2021 20:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355853AbhJASPZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Oct 2021 14:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355846AbhJASO7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Oct 2021 14:14:59 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB63C0613EF;
        Fri,  1 Oct 2021 11:13:15 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id np13so863596pjb.4;
        Fri, 01 Oct 2021 11:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zh0Od5xCCLBTi/Es3M6E1PFym+AJt6Hv/pPvKz4RYiQ=;
        b=Er8SoSog755OkgEbpHl3KYRBETIprMfiwNUgEGzXhJ4VtFbTcR7CyTZRvos3MPbI1H
         rSemc7A4iwA/h6b8a8g8Zer5ZZt2wTsgO+f5qQieL1RCgJynysrjdwzdfDfCAOKYLhv9
         74T4LvwsrPz1bKz8k+5uqQITlwnGEs2KR7TSJGGkbPm38gF0hVFlz1qFVXWQ0zkYEXqC
         z23R/FU/+wfwVJLy+55/Prm8/NgG1nM8uALOkH9OfZEOKYIb3zsuSGB9r3mk+F1rrC2G
         vz2pHbh6bZ+eAWSRm/+2idcp5VRa6N16sSwvur+JJkZUEXxHNGuDptDiAP2NnRTaJJeU
         OrxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zh0Od5xCCLBTi/Es3M6E1PFym+AJt6Hv/pPvKz4RYiQ=;
        b=4dZE3u1MhsGhkUu9jfebJgiYKbAW4edfVY4/SXpJerV/ky6Q0z4lhIZwuNNdwKpzfs
         7i9mZLNKPUo6mYkePRV0zTMGNtSvoEglNW2M/9s07/KHDyogbf5ZQRpNJOAdV3dqLYr1
         KquM0XRtYVMG7rMkJyX5qU2dlGvbiDcJqugJoZkAsiSP9wo2yYZ1wfp9jhwkvtB0mpE7
         1tR9HAIoX9I+OmnmXBW3D2zQ78h/9L6XftnLlIHK55PCBo856458UEFVpMwHbBaaP9PH
         IXcm60NArvjWj4K0Yd4pIdh2sFPu5Gz0QRkXg2EGlDhgdz65fZvnD3YJEmDlNRJlvjyX
         rBYg==
X-Gm-Message-State: AOAM531pCs40r2zJyXnOSwhLpiuDUAZTw/q9WQbCE4VD+v8sA4NqMlsd
        4+4tLuY82U896TK3j8qnDv0=
X-Google-Smtp-Source: ABdhPJzRYOOrxKL9bXyrtB2kKMot5DPX3JcWJPUmIYCbW4PNgBCf+FRKmNgqwtspZOVagPwiwEiB5g==
X-Received: by 2002:a17:902:7c08:b0:13e:77d5:b02c with SMTP id x8-20020a1709027c0800b0013e77d5b02cmr7860594pll.55.1633111994702;
        Fri, 01 Oct 2021 11:13:14 -0700 (PDT)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id x12sm6940155pfa.98.2021.10.01.11.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 11:13:14 -0700 (PDT)
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
Date:   Fri,  1 Oct 2021 11:12:38 -0700
Message-Id: <20211001181245.228419-10-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211001181245.228419-1-yury.norov@gmail.com>
References: <20211001181245.228419-1-yury.norov@gmail.com>
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
index 21bf4c3f0825..5b28d204d7bc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2538,7 +2538,7 @@ static bool blk_mq_hctx_has_requests(struct blk_mq_hw_ctx *hctx)
 static inline bool blk_mq_last_cpu_in_hctx(unsigned int cpu,
 		struct blk_mq_hw_ctx *hctx)
 {
-	if (cpumask_next_and(-1, hctx->cpumask, cpu_online_mask) != cpu)
+	if (cpumask_first_and(hctx->cpumask, cpu_online_mask) != cpu)
 		return false;
 	if (cpumask_next_and(cpu, hctx->cpumask, cpu_online_mask) < nr_cpu_ids)
 		return false;
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 2ed49884565f..986cb7a73a92 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2089,7 +2089,7 @@ static void virtnet_set_affinity(struct virtnet_info *vi)
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
index c4e1b9ea0ba4..64dae70d31f5 100644
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
index b038b81f8d32..2f170383b00a 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -262,7 +262,7 @@ static void clocksource_verify_choose_cpus(void)
 		return;
 
 	/* Make sure to select at least one CPU other than the current CPU. */
-	cpu = cpumask_next(-1, cpu_online_mask);
+	cpu = cpumask_first(cpu_online_mask);
 	if (cpu == smp_processor_id())
 		cpu = cpumask_next(cpu, cpu_online_mask);
 	if (WARN_ON_ONCE(cpu >= nr_cpu_ids))
@@ -284,7 +284,7 @@ static void clocksource_verify_choose_cpus(void)
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

