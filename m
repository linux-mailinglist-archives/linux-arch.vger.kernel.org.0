Return-Path: <linux-arch+bounces-13874-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 211C9BB331A
	for <lists+linux-arch@lfdr.de>; Thu, 02 Oct 2025 10:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1BE9462D08
	for <lists+linux-arch@lfdr.de>; Thu,  2 Oct 2025 08:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AAC318131;
	Thu,  2 Oct 2025 08:14:17 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC422DC796;
	Thu,  2 Oct 2025 08:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392856; cv=none; b=Xm0staVor/ADmbtxwPpoSU/gTPc/l4JZYIQHvr80QcXfxZyq6shBXIhi3HzLfmdwz9/wIYtY2fcnxTj+GpdkDRbvean5wIf7XUnBSWAjdUGf7LSFH8H7y/x5Fum3sO/8RBYl3GfH467xIqOFf9xbv4u/G5n629eH6iAXNeBAap4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392856; c=relaxed/simple;
	bh=MeohuwxKUYc7+9vQ4C+fi0LgjnyII/mMP+jCKZDgHoI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=URoPYQmQbp+AHvebxF0YSMVtK2Pos6csqvZpvUPwz79IP0gMXeF67imPvjN8wSI5VzerRfNYGLluGSiqeNd7s+gUuRgYGedBMLCYFbS27fKh6qtlz++wuVp4g6XtvWthQn8Z+/FSJOfxAfqZExyvmRSWFc+ZkQs1zkna4f9w5uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-77-68de3414ee79
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org
Cc: kernel_team@skhynix.com,
	torvalds@linux-foundation.org,
	damien.lemoal@opensource.wdc.com,
	linux-ide@vger.kernel.org,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	will@kernel.org,
	tglx@linutronix.de,
	rostedt@goodmis.org,
	joel@joelfernandes.org,
	sashal@kernel.org,
	daniel.vetter@ffwll.ch,
	duyuyang@gmail.com,
	johannes.berg@intel.com,
	tj@kernel.org,
	tytso@mit.edu,
	willy@infradead.org,
	david@fromorbit.com,
	amir73il@gmail.com,
	gregkh@linuxfoundation.org,
	kernel-team@lge.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	mhocko@kernel.org,
	minchan@kernel.org,
	hannes@cmpxchg.org,
	vdavydov.dev@gmail.com,
	sj@kernel.org,
	jglisse@redhat.com,
	dennis@kernel.org,
	cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	vbabka@suse.cz,
	ngupta@vflare.org,
	linux-block@vger.kernel.org,
	josef@toxicpanda.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	dan.j.williams@intel.com,
	hch@infradead.org,
	djwong@kernel.org,
	dri-devel@lists.freedesktop.org,
	rodrigosiqueiramelo@gmail.com,
	melissa.srw@gmail.com,
	hamohammed.sa@gmail.com,
	harry.yoo@oracle.com,
	chris.p.wilson@intel.com,
	gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com,
	boqun.feng@gmail.com,
	longman@redhat.com,
	yunseong.kim@ericsson.com,
	ysk@kzalloc.com,
	yeoreum.yun@arm.com,
	netdev@vger.kernel.org,
	matthew.brost@intel.com,
	her0gyugyu@gmail.com,
	corbet@lwn.net,
	catalin.marinas@arm.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	luto@kernel.org,
	sumit.semwal@linaro.org,
	gustavo@padovan.org,
	christian.koenig@amd.com,
	andi.shyti@kernel.org,
	arnd@arndb.de,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	rppt@kernel.org,
	surenb@google.com,
	mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	urezki@gmail.com,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	chuck.lever@oracle.com,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	trondmy@kernel.org,
	anna@kernel.org,
	kees@kernel.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	mark.rutland@arm.com,
	ada.coupriediaz@arm.com,
	kristina.martsenko@arm.com,
	wangkefeng.wang@huawei.com,
	broonie@kernel.org,
	kevin.brodsky@arm.com,
	dwmw@amazon.co.uk,
	shakeel.butt@linux.dev,
	ast@kernel.org,
	ziy@nvidia.com,
	yuzhao@google.com,
	baolin.wang@linux.alibaba.com,
	usamaarif642@gmail.com,
	joel.granados@kernel.org,
	richard.weiyang@gmail.com,
	geert+renesas@glider.be,
	tim.c.chen@linux.intel.com,
	linux@treblig.org,
	alexander.shishkin@linux.intel.com,
	lillian@star-ark.net,
	chenhuacai@kernel.org,
	francesco@valla.it,
	guoweikang.kernel@gmail.com,
	link@vivo.com,
	jpoimboe@kernel.org,
	masahiroy@kernel.org,
	brauner@kernel.org,
	thomas.weissschuh@linutronix.de,
	oleg@redhat.com,
	mjguzik@gmail.com,
	andrii@kernel.org,
	wangfushuai@baidu.com,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	linux-i2c@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH v17 41/47] dept: implement a basic unit test for dept
Date: Thu,  2 Oct 2025 17:12:41 +0900
Message-Id: <20251002081247.51255-42-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251002081247.51255-1-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0xTdxjG/Z87nTUnFcPRzUuaoAYFwbD5Go2aqPEki8lEvyjeTuyJbSxg
	WkTxEhsFBQIKVdiQi0WEVFqgljgGWIdlNJqOWQS1EgoUy0WlkqCoQ6G2Gr/93ud93ufDk5fB
	Zc/JBYwqOVXUJAtqOSUhJP7ZFdHz4vuUscaBCCitN1OQZS0mwVVnQtA/mYVgWu+gIWBzICjq
	1OPw1jJDweu2CQSFXh8F49W5CF62bwN/fwsJAc8IBtW+GQx8rRcRfOp4hEOF14PDqCU42ozn
	KBjKv4NDl28OdE+OU+DvLMXgjYUCwzkbCWUlegTnK+spKCqzEtA00ExDb5EeA5N1Ozjzb2BQ
	dDsCSn4fxaCwtgWDfyt7CajWRUJJRxcJg8ZrNHz2xkHAkAIO0wgNnsuFBNT5H5HwsO8pCa+H
	9RQ06gZosD5vR/Cu24uBOXcYh6zmSQKsL4KWigs3CSgu76Wgq7mUglzLHRL6zIFgH61OEh6b
	XATUj7gxcDoeEFD1rBMD74Cb3KTgP2ReIviahj8xPvPxNMWby82I/zSlR/y7qvM43zY2jvNT
	k08o3vbeQPAFHdF80zUPzWfc66F5g/UYn/GPn+QbjFF85d2X2G9xeyTrFaJalSZqVm04KFF2
	Xxykj17ddsI1dpfSofZ1OSiM4dh47o/RLOo7F1wdxkNMscs4t/v/rxzOLuEa8obJEOOs8yfu
	aefKEM9lt3K+KT+dgxiGYCM5f//mkCxlf+EGZ4rJb5GLOZOl9WtMWFDv8jqJEMvYn7nM8Qws
	B0mCHlMYZ/To0LeD+dx9o5vIR1IDmlWDZKrktCRBpY6PUaYnq07EHEpJsqLgw1Wf+Zz4F5pw
	7bQjlkHy2VJXpEcpI4U0bXqSHXEMLg+XHjT2KmVShZB+UtSkHNAcU4taO/qRIeQR0tXvjytk
	7GEhVTwiikdFzfctxoQt0KElS2812ucO1enssbXKhdlq5Whew87jaz2BljbfaTSxcpduKEHz
	VhubuO/Qwx3LHe3b1dc3WWKeZPywNrtqOnVNz2HzKXPTikWXj9y7sD+h35699G/1rY3Cx8T7
	CUJVTwEX7pIrfp2Hl2+w/vdqd3H02cY3V2Q23Vj0/si97poPecIWOaFVCnFRuEYrfAFnHhDB
	bAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0yTdxTG93/vdFbfVBJfYcatCc4sgpKgnpRpSBbGuyUz84OpwWyjkVfb
	UMC0gGCyDSyNDNkGnQWhXgqEjlCmXREVtYpcmiig1KISoWCxVm4Vo1TD3dZlX05+53lOnjwf
	DoNLWskoRpWVI2iyFGopJSJEexJ1sZEJI8pt5/7eBI+K2gkIzpYQcOZiMwUl9moS+i9YEYwG
	SxC8WzDhoG9bIWDJ4KRhdm6IhhWHE0Gly4BD86UiDN7YlimY6nyNwOj1UVA1UUTAjKUMQY3f
	RMNEdwoERq+TsOJ5gcHjt9MILL5lDHztJxAsVWbA+boWChb67uNQZexHUOv14DBuC5mXnCMI
	HI3HKXhe3oqD27caBoIzFNwxnqQg4DqDwUsbBebjDhLOmgwIdPUXKag8ayeg7ek1GlxTixgM
	VxowsNq/g1GLn4Ce8jos1C909e86MFXpsNAYx8D4z3UM5ixNNPTWDxNgKYwBU5+bhLHGGhoW
	vfGwYs4Gp/UFDZ4/jQRcCNwnk4yIf6f/g+CbWi5jvP7BEsU3n2tG/MK8AfGzDTqc15eH1s7p
	GZwvbjnKN/RMU/x88CHFO96aCf5uHcdX9MXybTUemi+++YT+XpYq+jJdUKvyBM3W3Wki5cCJ
	MfrIqZT8/ukbVCHqTixFEQzHJnAVp/x4mCn2c25wcO4DR7Kfci2/+8kw42zPJ9wj15Ywr2WT
	Od98gC5FDEOwMVxg9KuwLGZ3cGPL1eR/kRs5q639Q0xESHd7e4gwS9jtnH6mGCtHIjP6qAlF
	qrLyMhUq9fY4bYayIEuVH3cwO9OOQs9k+Xmx4iqadad0IJZB0lViV4xHKSEVedqCzA7EMbg0
	UpzWOKyUiNMVBccETfZPmly1oO1A0QwhXSf+Vi6kSdjDihwhQxCOCJr/XYyJiCpEubJffm3f
	/NtkF8h3x97xynpLac221P2bFw17T8uGfliz45Z7fWfr7T3UePrO3isVDidLDKXmPzt/71VS
	8ONDth+rd61O6JRtralSl3Ul1xbK36wflPuiJxW5ZZ+d3qc71nfAbo3+2rhRkyNOH/tGHjcS
	58nsmBpwxPsb2KYDf4k2SAmtUhH/Ba7RKt4Dd+Nw7EgDAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

Implement CONFIG_DEPT_UNIT_TEST introducing a kernel module that runs
basic unit test for dept.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept_unit_test.h     |  67 +++++++++++
 kernel/dependency/Makefile         |   1 +
 kernel/dependency/dept.c           |  12 ++
 kernel/dependency/dept_unit_test.c | 173 +++++++++++++++++++++++++++++
 lib/Kconfig.debug                  |  12 ++
 5 files changed, 265 insertions(+)
 create mode 100644 include/linux/dept_unit_test.h
 create mode 100644 kernel/dependency/dept_unit_test.c

diff --git a/include/linux/dept_unit_test.h b/include/linux/dept_unit_test.h
new file mode 100644
index 000000000000..7612b4e97e69
--- /dev/null
+++ b/include/linux/dept_unit_test.h
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * DEPT unit test
+ *
+ * Started by Byungchul Park <max.byungchul.park@gmail.com>:
+ *
+ *  Copyright (c) 2025 SK hynix, Inc., Byungchul Park
+ */
+
+#ifndef __LINUX_DEPT_UNIT_TEST_H
+#define __LINUX_DEPT_UNIT_TEST_H
+
+#if defined(CONFIG_DEPT_UNIT_TEST) || defined(CONFIG_DEPT_UNIT_TEST_MODULE)
+struct dept_ut {
+	bool circle_detected;
+	bool recover_circle_detected;
+
+	int ecxt_stack_total_cnt;
+	int wait_stack_total_cnt;
+	int evnt_stack_total_cnt;
+	int ecxt_stack_valid_cnt;
+	int wait_stack_valid_cnt;
+	int evnt_stack_valid_cnt;
+};
+
+extern struct dept_ut dept_ut_results;
+
+static inline void dept_ut_circle_detect(void)
+{
+	dept_ut_results.circle_detected = true;
+}
+static inline void dept_ut_recover_circle_detect(void)
+{
+	dept_ut_results.recover_circle_detected = true;
+}
+static inline void dept_ut_ecxt_stack_account(bool valid)
+{
+	dept_ut_results.ecxt_stack_total_cnt++;
+
+	if (valid)
+		dept_ut_results.ecxt_stack_valid_cnt++;
+}
+static inline void dept_ut_wait_stack_account(bool valid)
+{
+	dept_ut_results.wait_stack_total_cnt++;
+
+	if (valid)
+		dept_ut_results.wait_stack_valid_cnt++;
+}
+static inline void dept_ut_evnt_stack_account(bool valid)
+{
+	dept_ut_results.evnt_stack_total_cnt++;
+
+	if (valid)
+		dept_ut_results.evnt_stack_valid_cnt++;
+}
+#else
+struct dept_ut {};
+
+#define dept_ut_circle_detect() do { } while (0)
+#define dept_ut_recover_circle_detect() do { } while (0)
+#define dept_ut_ecxt_stack_account(v) do { } while (0)
+#define dept_ut_wait_stack_account(v) do { } while (0)
+#define dept_ut_evnt_stack_account(v) do { } while (0)
+
+#endif
+#endif /* __LINUX_DEPT_UNIT_TEST_H */
diff --git a/kernel/dependency/Makefile b/kernel/dependency/Makefile
index 92f165400187..fc584ca87124 100644
--- a/kernel/dependency/Makefile
+++ b/kernel/dependency/Makefile
@@ -2,3 +2,4 @@
 
 obj-$(CONFIG_DEPT) += dept.o
 obj-$(CONFIG_DEPT) += dept_proc.o
+obj-$(CONFIG_DEPT_UNIT_TEST) += dept_unit_test.o
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index 3c3ec2701bd6..0f4464657288 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -78,8 +78,12 @@
 #include <linux/workqueue.h>
 #include <linux/irq_work.h>
 #include <linux/vmalloc.h>
+#include <linux/dept_unit_test.h>
 #include "dept_internal.h"
 
+struct dept_ut dept_ut_results;
+EXPORT_SYMBOL_GPL(dept_ut_results);
+
 static int dept_stop;
 static int dept_per_cpu_ready;
 
@@ -826,6 +830,10 @@ static void print_dep(struct dept_dep *d)
 			pr_warn("(wait to wake up)\n");
 			print_ip_stack(0, e->ewait_stack);
 		}
+
+		dept_ut_ecxt_stack_account(valid_stack(e->ecxt_stack));
+		dept_ut_wait_stack_account(valid_stack(w->wait_stack));
+		dept_ut_evnt_stack_account(valid_stack(e->event_stack));
 	}
 }
 
@@ -920,6 +928,8 @@ static void print_circle(struct dept_class *c)
 	dump_stack();
 
 	dept_outworld_exit();
+
+	dept_ut_circle_detect();
 }
 
 /*
@@ -1021,6 +1031,8 @@ static void print_recover_circle(struct dept_event_site *es)
 	dump_stack();
 
 	dept_outworld_exit();
+
+	dept_ut_recover_circle_detect();
 }
 
 static void bfs_init_recover(void *node, void *in, void **out)
diff --git a/kernel/dependency/dept_unit_test.c b/kernel/dependency/dept_unit_test.c
new file mode 100644
index 000000000000..88e846b9f876
--- /dev/null
+++ b/kernel/dependency/dept_unit_test.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * DEPT unit test
+ *
+ * Started by Byungchul Park <max.byungchul.park@gmail.com>:
+ *
+ *  Copyright (c) 2025 SK hynix, Inc., Byungchul Park
+ */
+
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/mutex.h>
+#include <linux/dept.h>
+#include <linux/dept_unit_test.h>
+
+MODULE_DESCRIPTION("DEPT unit test");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Byungchul Park <max.byungchul.park@sk.com>");
+
+struct unit {
+	const char *name;
+	bool (*func)(void);
+	bool result;
+};
+
+static DEFINE_SPINLOCK(s1);
+static DEFINE_SPINLOCK(s2);
+static bool test_spin_lock_deadlock(void)
+{
+	dept_ut_results.circle_detected = false;
+
+	spin_lock(&s1);
+	spin_lock(&s2);
+	spin_unlock(&s2);
+	spin_unlock(&s1);
+
+	spin_lock(&s2);
+	spin_lock(&s1);
+	spin_unlock(&s1);
+	spin_unlock(&s2);
+
+	return dept_ut_results.circle_detected;
+}
+
+static DEFINE_MUTEX(m1);
+static DEFINE_MUTEX(m2);
+static bool test_mutex_lock_deadlock(void)
+{
+	dept_ut_results.circle_detected = false;
+
+	mutex_lock(&m1);
+	mutex_lock(&m2);
+	mutex_unlock(&m2);
+	mutex_unlock(&m1);
+
+	mutex_lock(&m2);
+	mutex_lock(&m1);
+	mutex_unlock(&m1);
+	mutex_unlock(&m2);
+
+	return dept_ut_results.circle_detected;
+}
+
+static bool test_wait_event_deadlock(void)
+{
+	struct dept_map dmap1;
+	struct dept_map dmap2;
+
+	sdt_map_init(&dmap1);
+	sdt_map_init(&dmap2);
+
+	dept_ut_results.circle_detected = false;
+
+	sdt_request_event(&dmap1); /* [S] */
+	sdt_wait(&dmap2); /* [W] */
+	sdt_event(&dmap1); /* [E] */
+
+	sdt_request_event(&dmap2); /* [S] */
+	sdt_wait(&dmap1); /* [W] */
+	sdt_event(&dmap2); /* [E] */
+
+	return dept_ut_results.circle_detected;
+}
+
+static void dummy_event(void)
+{
+	/* Do nothing. */
+}
+
+static DEFINE_DEPT_EVENT_SITE(es1);
+static DEFINE_DEPT_EVENT_SITE(es2);
+static bool test_recover_deadlock(void)
+{
+	dept_ut_results.recover_circle_detected = false;
+
+	dept_recover_event(&es1, &es2);
+	dept_recover_event(&es2, &es1);
+
+	event_site(&es1, dummy_event);
+	event_site(&es2, dummy_event);
+
+	return dept_ut_results.recover_circle_detected;
+}
+
+static struct unit units[] = {
+	{
+		.name = "spin lock deadlock test",
+		.func = test_spin_lock_deadlock,
+	},
+	{
+		.name = "mutex lock deadlock test",
+		.func = test_mutex_lock_deadlock,
+	},
+	{
+		.name = "wait event deadlock test",
+		.func = test_wait_event_deadlock,
+	},
+	{
+		.name = "event recover deadlock test",
+		.func = test_recover_deadlock,
+	},
+};
+
+static int __init dept_ut_init(void)
+{
+	int i;
+
+	lockdep_off();
+
+	dept_ut_results.ecxt_stack_valid_cnt = 0;
+	dept_ut_results.ecxt_stack_total_cnt = 0;
+	dept_ut_results.wait_stack_valid_cnt = 0;
+	dept_ut_results.wait_stack_total_cnt = 0;
+	dept_ut_results.evnt_stack_valid_cnt = 0;
+	dept_ut_results.evnt_stack_total_cnt = 0;
+
+	for (i = 0; i < ARRAY_SIZE(units); i++)
+		units[i].result = units[i].func();
+
+	pr_info("\n");
+	pr_info("******************************************\n");
+	pr_info("DEPT unit test results\n");
+	pr_info("******************************************\n");
+	for (i = 0; i < ARRAY_SIZE(units); i++) {
+		pr_info("(%s) %s\n", units[i].result ? "pass" : "fail",
+				units[i].name);
+	}
+	pr_info("ecxt stack valid count = %d/%d\n",
+			dept_ut_results.ecxt_stack_valid_cnt,
+			dept_ut_results.ecxt_stack_total_cnt);
+	pr_info("wait stack valid count = %d/%d\n",
+			dept_ut_results.wait_stack_valid_cnt,
+			dept_ut_results.wait_stack_total_cnt);
+	pr_info("event stack valid count = %d/%d\n",
+			dept_ut_results.evnt_stack_valid_cnt,
+			dept_ut_results.evnt_stack_total_cnt);
+	pr_info("******************************************\n");
+	pr_info("\n");
+
+	lockdep_on();
+
+	return 0;
+}
+
+static void dept_ut_cleanup(void)
+{
+	/*
+	 * Do nothing for now.
+	 */
+}
+
+module_init(dept_ut_init);
+module_exit(dept_ut_cleanup);
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 290563fa8b58..f0c58bee263a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1404,6 +1404,18 @@ config DEPT_AGGRESSIVE_TIMEOUT_WAIT
 	  that timeout is used to avoid a deadlock. Say N if you'd like
 	  to avoid verbose reports.
 
+config DEPT_UNIT_TEST
+	tristate "unit test for DEPT"
+	depends on DEBUG_KERNEL && DEPT
+	default n
+	help
+	  This option provides a kernel module that runs unit test for
+	  DEPT.
+
+	  Say Y if you want DEPT unit test to be built into the kernel.
+	  Say M if you want DEPT unit test to build as a module.
+	  Say N if you are unsure.
+
 config LOCK_DEBUGGING_SUPPORT
 	bool
 	depends on TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
-- 
2.17.1


