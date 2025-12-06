Return-Path: <linux-arch+bounces-15293-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B75BCA98E3
	for <lists+linux-arch@lfdr.de>; Fri, 05 Dec 2025 23:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7BA1300AC5E
	for <lists+linux-arch@lfdr.de>; Fri,  5 Dec 2025 22:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB772F532F;
	Fri,  5 Dec 2025 22:58:23 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487902F0686;
	Fri,  5 Dec 2025 22:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764975503; cv=none; b=OHzs1FwkZmPzeeQMlaEIz+/Ei6i56yxMLwYgYgOKDQQTov1n/5GeZFcT9pQcAt+08c4Z5KzfH8Dh+QEdHj0nXCMGNHXep6rQig14VG7xoZ3azB1PZlUdJMrK2W6V4dHnt11I2e0eWke3i+5o/GDLGb8jwjjxf75XjMvq08S9TfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764975503; c=relaxed/simple;
	bh=f7DggEDyOr0Hvgy8XNaD4mspXM9hIMXiTx0EDoOudE8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k31OGswQ5L5NE4Dq4L+HT+NB/E+L58SKCJS2NrI+kpL8wwEf3RS0AuIbpTMGFPD7SBfH9rym1gk5ozyAlb9eV9hpe06/GELiQf4vLx8tLTDKLFgPfV7LyOT1orXDSF2eyL2f/u19yA9XhtNTjQFKIjFidsENyEb47bA3a+TFbao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dNRBg1FQczHnGfH;
	Sat,  6 Dec 2025 06:39:23 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 8F89840539;
	Sat,  6 Dec 2025 06:39:25 +0800 (CST)
Received: from localhost.localdomain (10.123.70.40) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 6 Dec 2025 01:39:25 +0300
From: Anatoly Stepanov <stepanov.anatoly@huawei.com>
To: <peterz@infradead.org>, <boqun.feng@gmail.com>, <longman@redhat.com>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <arnd@arndb.de>, <dvhart@infradead.org>,
	<dave@stgolabs.net>, <andrealmeid@igalia.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<guohanjun@huawei.com>, <wangkefeng.wang@huawei.com>,
	<weiyongjun1@huawei.com>, <yusongping@huawei.com>, <leijitang@huawei.com>,
	<artem.kuzin@huawei.com>, <fedorov.nikita@h-partners.com>,
	<kang.sun@huawei.com>, Anatoly Stepanov <stepanov.anatoly@huawei.com>
Subject: [RFC PATCH v2 2/5] hq-spinlock: proc tunables and debug stats
Date: Sat, 6 Dec 2025 14:21:03 +0800
Message-ID: <20251206062106.2109014-3-stepanov.anatoly@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251206062106.2109014-1-stepanov.anatoly@huawei.com>
References: <aad84044-a9d3-4806-a966-4770a3634b03@redhat.com>
 <20251206062106.2109014-1-stepanov.anatoly@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500003.china.huawei.com (7.188.49.51)

- tunable for handoff threshold
- tunable for lock-mode switching
- debug stats

Signed-off-by: Anatoly Stepanov <stepanov.anatoly@huawei.com>

Co-authored-by: Stepanov Anatoly <stepanov.anatoly@huawei.com>
Co-authored-by: Fedorov Nikita <fedorov.nikita@h-partners.com>
---
 kernel/locking/hqlock_proc.h | 88 ++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 kernel/locking/hqlock_proc.h

diff --git a/kernel/locking/hqlock_proc.h b/kernel/locking/hqlock_proc.h
new file mode 100644
index 000000000..5e9ed0446
--- /dev/null
+++ b/kernel/locking/hqlock_proc.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _GEN_HQ_SPINLOCK_SLOWPATH
+#error "Do not include this file!"
+#endif
+
+#include <linux/sysctl.h>
+
+/*
+ * Local handoffs threshold to maintain global fairness,
+ * perform remote handoff if it's reached
+ */
+unsigned long hqlock_fairness_threshold = 1000;
+
+/*
+ * Minimal amount of handoffs in LOCK_MODE_QSPINLOCK
+ * to enable NUMA-awareness
+ */
+unsigned long hqlock_general_handoffs_turn_numa = 50;
+
+static unsigned long long_zero;
+static unsigned long long_max = LONG_MAX;
+
+static const struct ctl_table hqlock_settings[] = {
+	{
+		.procname		= "hqlock_fairness_threshold",
+		.data			= &hqlock_fairness_threshold,
+		.maxlen			= sizeof(hqlock_fairness_threshold),
+		.mode			= 0644,
+		.proc_handler	= proc_doulongvec_minmax
+	},
+	{
+		.procname		= "hqlock_general_handoffs_turn_numa",
+		.data			= &hqlock_general_handoffs_turn_numa,
+		.maxlen			= sizeof(hqlock_general_handoffs_turn_numa),
+		.mode			= 0644,
+		.proc_handler	= proc_doulongvec_minmax,
+		.extra1		= &long_zero,
+		.extra2		= &long_max,
+	},
+};
+static int __init init_numa_spinlock_sysctl(void)
+{
+	if (!register_sysctl("kernel", hqlock_settings))
+		return -EINVAL;
+	return 0;
+}
+core_initcall(init_numa_spinlock_sysctl);
+
+
+#ifdef CONFIG_HQSPINLOCKS_DEBUG
+static int max_buckets_in_use;
+static int max_general_handoffs;
+static atomic_t cur_buckets_in_use = ATOMIC_INIT(0);
+
+static int print_hqlock_stats(struct seq_file *file, void *v)
+{
+	seq_printf(file, "Max dynamic metada in use after previous print: %d\n",
+		   READ_ONCE(max_buckets_in_use));
+	WRITE_ONCE(max_buckets_in_use, 0);
+
+	seq_printf(file, "Max MCS handoffs after previous print: %d\n",
+		   READ_ONCE(max_general_handoffs));
+	WRITE_ONCE(max_general_handoffs, 0);
+
+	return 0;
+}
+
+
+static int stats_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, print_hqlock_stats, NULL);
+}
+
+static const struct proc_ops stats_ops = {
+	.proc_open  = stats_open,
+	.proc_read  = seq_read,
+	.proc_lseek = seq_lseek,
+};
+
+static int __init stats_init(void)
+{
+	proc_create("hqlock_stats", 0444, NULL, &stats_ops);
+	return 0;
+}
+
+core_initcall(stats_init);
+
+#endif // HQSPINLOCKS_DEBUG
-- 
2.34.1


