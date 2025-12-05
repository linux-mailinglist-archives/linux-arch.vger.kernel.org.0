Return-Path: <linux-arch+bounces-15218-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5EFCA7388
	for <lists+linux-arch@lfdr.de>; Fri, 05 Dec 2025 11:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A2C0336E820
	for <lists+linux-arch@lfdr.de>; Fri,  5 Dec 2025 07:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F3C33A709;
	Fri,  5 Dec 2025 07:21:26 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD75314D2B;
	Fri,  5 Dec 2025 07:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764919286; cv=none; b=oSQSOTdK6aE/XXpRRPQwG4jvtc19FKvyApQr2pWHnIakZH8UZAgVXAw+IRWeZ7cTlVD+IqKAcyFCS9FeOMuy/ocZ5WDwoJAXe3ocv9KDlNKKhBPyhytXBAm16MtxtkQYOw2zUwZp3PU/Y9+MDP+ljxEOjlR8RO3Hololv9Hhkak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764919286; c=relaxed/simple;
	bh=5Jei3mC1oxKySaupE8G1izbSrZiqYtdhAhRhaXHSq9c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=YXo+IpWzOR3J9Dnq+erPapX9gzLn8ITUBf/+bXm31H7ApmAFIAB7vCfiKEfkSBl1yBVPFAXl2jUVtIgK2+bKUggNVfYQzvbII6WyOs1RxRauifwuJrPyZxvKD/xcN0kRznFM5YVpgxu4/qy+V4eyCUPiVffTkWwsdtQL7l7gI+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-05-693287734f0f
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
	linux-rt-devel@lists.linux.dev,
	2407018371@qq.com,
	dakr@kernel.org,
	miguel.ojeda.sandonis@gmail.com,
	neilb@ownmail.net,
	bagasdotme@gmail.com,
	wsa+renesas@sang-engineering.com,
	dave.hansen@intel.com,
	geert@linux-m68k.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v18 34/42] dept: add module support for struct dept_event_site and dept_event_site_dep
Date: Fri,  5 Dec 2025 16:18:47 +0900
Message-Id: <20251205071855.72743-35-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251205071855.72743-1-byungchul@sk.com>
References: <20251205071855.72743-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0xTZxjG/c7lO6Vac1I1HiVG0mhM8AbEuVdnjJfEHOIlmhmJGi8n9mi7
	FTCtophMC7W0ICA0FiKNK7c2SKtiwURFTAWpkMJWIJNK7JhOKwZQsokICgg1/vPkl+d53uev
	V0LKe+iFEnXKKVGbImgUWEpJB2eVr9SZEtRxdVeWg9l4AcyeqzS0dGdSELjpQtA7bEYw8tlG
	gvHeJAXjFh8D1gwERR0WEv6vmcDw3pmLoCRsY2Cwt56GydAbAl55TQjs5bUY+ouGMBRbAwga
	qjIxvC64Q0LXq9nQar2E4V0NhtLMBho62voRXLNZEIR7GggwVNzC8LzIQoDLsxP8BeUEFL/F
	UHR7PtiKDcSU9BFgvVFPwKizmgFbexcNL6tKGPjyIh58rjcMhC5bKbg5+CcNvU+yaPA8a0bg
	zg2TYL4/TIHn36c0lGVVUmAe/4DAd/clAbk1d2j42z1Jg942QkOnK0CB39dCQWvJdQoc3R0E
	vPgnSENtexsJH/OjIVCYR0Ow4DXapORHjPkUb+wcx7z7dzfiP49ZEP/BYSD5poH3JO/wD2B+
	bPgvzFdmjxF8YftK/l5JiOEvPuxh+FLPab62KpavePCW4D3V2Xh37AHpBqWoUaeJ2tUbj0pV
	rYY8fLJ/29kJexmpR5Xrc1CUhGPXcH1eK/2dc4buM9OM2WVcMDhKTvNcNoarzQtPdaQSku1a
	zJlG8yPBHPY4d72+OMIUu5QLt+RQ0yxj13INf7Tgb6OLOVeNN9KJmvKt3WMRlrM/cPackcgo
	x1ZEcXXdduLbwQLuUVWQKkCyUjSjGsnVKWnJglqzZpUqPUV9dtWx1GQPmvo4529fDt5F/wV+
	bkSsBClmybxn4tVyWkjTpSc3Ik5CKubKBjRxarlMKaSfE7WpR7SnNaKuEUVLKMV8WcLHM0o5
	e0I4Jf4qiidF7feUkEQt1CNVKGNig3DNvrmvos/7vCxZiPY6smyDzkMrMvQx8+KSQv6mStXh
	wztYudJfuDbxqH6RJ9be9mho+R5Dgna/HkU/TrCp9m75lOdLco5md/2C9/243e3YsgtmZi74
	qdkVTFpdZ9mYoby8Ljdu65LEY6IjdXf5BabeaDq/Lq3ThEsVlE4lxMeSWp3wFVPLP2JtAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUhTcRTG+99799/daHFbQhcLqkUEgVb2wsFeqC92LYoIQupLjrzlclrc
	mWX0oq7lWhY62KRmaktX6TJzlpmNREnsVc3KkS/TmkvbTCtNnG9Noy+H3znPcx7Oh0OT8iei
	UFqVlMwLSUq1Aksp6Z5N2jAhM0K15lXeJtDrLkCH2yOCT+m1FIwM6ynIe2DHMGmpEoO+4roI
	GtsyKGguK0XgHtEjGB23kKCrnqZg0tgghuGxdjGY0hFMOxsQmFuMJLian5Ngr0wn4Hf5FAZf
	/S8Eph4Phtz+dAoGbVkIbngtYuh/sQMG3DUimO78RkDbHz8Cm2eKAE9tJoJJcwIUWB3BdfMQ
	hvG3TSTkmpoR3OrpJOFXfzeCyoYuBM67GRh6sx+R0OqZBx9GBjG8NF3BMNCSR8CPcgyFGU4R
	tLzxIbhpMSLwfnYSoL39AIP5ZgUF1d1PxdDimyCgw2wkoLRiN7htXgpeZ1uJ4LlB18OFYMnV
	EsHSR4Dpfg0BY7YS8bZixI3qrlFcieMxweneT2LOnm9H3HjAiLjhYi3J6bKDbb1/kOQuOk5x
	xa/9mAuMfMSc808hxb2yslzR5QDB5bwN46pvdIr3bj8o3RzHq1UpvLB6a6w0/qX2Kj7hizo9
	VXCLTENFkQYkoVlmPWsYeiqeYcysZF2uMXKGQ5ilrOOqV2RAUppkWpewmWPXZoUFzBH2Xk3u
	LFPMCtbbaKBmWMZsZJ3vGvG/0CVsaXntrEcSnJvaArMsZzawBYZRUTaSFqI5JShElZSSqFSp
	N4RrEuJTk1Snww8fT6xAwX+ynZvIeYKGW3fUIYZGirmy2lNrVXKRMkWTmliHWJpUhMj86jUq
	uSxOmXqGF44fEk6qeU0dWkRTioWynTF8rJw5qkzmE3j+BC/8VwlaEpqGPvb2Syamq6KjI0Md
	9d9rnoUcVedcGgqXJfrjti3vlu9yrTpm3dKb9YVbsbgq4mvH1HLj+t6+qJP2S4fzfWf5hmVN
	4+3rstyBsr47+++9ad/8zXj/iOBOLqrskcR0QZTy3HlXjPVTUxlN4fn60vy6iKEDaunPlPl3
	fgvR8o5978oVlCZeuXYVKWiUfwH7Iy72SwMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

struct dept_event_site and struct dept_event_site_dep have been
introduced to track dependencies between multi event sites for a single
wait, that will be loaded to data segment.  Plus, a custom section,
'.dept.event_sites', also has been introduced to keep pointers to the
objects to make sure all the event sites defined exist in code.

dept should work with the section and segment of module.  Add the
support to handle the section and segment properly whenever modules are
loaded and unloaded.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept.h     | 14 +++++++
 include/linux/module.h   |  5 +++
 kernel/dependency/dept.c | 79 +++++++++++++++++++++++++++++++++++-----
 kernel/module/main.c     | 15 ++++++++
 4 files changed, 103 insertions(+), 10 deletions(-)

diff --git a/include/linux/dept.h b/include/linux/dept.h
index 44083e6651ab..c796cdceb04e 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -166,6 +166,11 @@ struct dept_event_site {
 	struct dept_event_site		*bfs_parent;
 	struct list_head		bfs_node;
 
+	/*
+	 * for linking all dept_event_site's
+	 */
+	struct list_head		all_node;
+
 	/*
 	 * flag indicating the event is not only declared but also
 	 * actually used in code
@@ -182,6 +187,11 @@ struct dept_event_site_dep {
 	 */
 	struct list_head		dep_node;
 	struct list_head		dep_rev_node;
+
+	/*
+	 * for linking all dept_event_site_dep's
+	 */
+	struct list_head		all_node;
 };
 
 #define DEPT_EVENT_SITE_INITIALIZER(es)					\
@@ -193,6 +203,7 @@ struct dept_event_site_dep {
 	.bfs_gen = 0,							\
 	.bfs_parent = NULL,						\
 	.bfs_node = LIST_HEAD_INIT((es).bfs_node),			\
+	.all_node = LIST_HEAD_INIT((es).all_node),			\
 	.used = false,							\
 }
 
@@ -202,6 +213,7 @@ struct dept_event_site_dep {
 	.recover_site = NULL,						\
 	.dep_node = LIST_HEAD_INIT((esd).dep_node),			\
 	.dep_rev_node = LIST_HEAD_INIT((esd).dep_rev_node),		\
+	.all_node = LIST_HEAD_INIT((esd).all_node),			\
 }
 
 struct dept_event_site_init {
@@ -225,6 +237,7 @@ extern void dept_init(void);
 extern void dept_task_init(struct task_struct *t);
 extern void dept_task_exit(struct task_struct *t);
 extern void dept_free_range(void *start, unsigned int sz);
+extern void dept_mark_event_site_used(void *start, void *end);
 
 extern void dept_map_init(struct dept_map *m, struct dept_key *k, int sub_u, const char *n);
 extern void dept_map_reinit(struct dept_map *m, struct dept_key *k, int sub_u, const char *n);
@@ -288,6 +301,7 @@ struct dept_event_site { };
 #define dept_task_init(t)				do { } while (0)
 #define dept_task_exit(t)				do { } while (0)
 #define dept_free_range(s, sz)				do { } while (0)
+#define dept_mark_event_site_used(s, e)			do { } while (0)
 
 #define dept_map_init(m, k, su, n)			do { (void)(n); (void)(k); } while (0)
 #define dept_map_reinit(m, k, su, n)			do { (void)(n); (void)(k); } while (0)
diff --git a/include/linux/module.h b/include/linux/module.h
index d80c3ea57472..29885ba91951 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -29,6 +29,7 @@
 #include <linux/srcu.h>
 #include <linux/static_call_types.h>
 #include <linux/dynamic_debug.h>
+#include <linux/dept.h>
 
 #include <linux/percpu.h>
 #include <asm/module.h>
@@ -588,6 +589,10 @@ struct module {
 #ifdef CONFIG_DYNAMIC_DEBUG_CORE
 	struct _ddebug_info dyndbg_info;
 #endif
+#ifdef CONFIG_DEPT
+	struct dept_event_site **dept_event_sites;
+	unsigned int num_dept_event_sites;
+#endif
 } ____cacheline_aligned __randomize_layout;
 #ifndef MODULE_ARCH_INIT
 #define MODULE_ARCH_INIT {}
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index b14400c4f83b..07d883579269 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -984,6 +984,9 @@ static void bfs(void *root, struct bfs_ops *ops, void *in, void **out)
  * event sites.
  */
 
+static LIST_HEAD(dept_event_sites);
+static LIST_HEAD(dept_event_site_deps);
+
 /*
  * Print all events in the circle.
  */
@@ -2043,6 +2046,33 @@ static void del_dep_rcu(struct rcu_head *rh)
 	preempt_enable();
 }
 
+/*
+ * NOTE: Must be called with dept_lock held.
+ */
+static void disconnect_event_site_dep(struct dept_event_site_dep *esd)
+{
+	list_del_rcu(&esd->dep_node);
+	list_del_rcu(&esd->dep_rev_node);
+}
+
+/*
+ * NOTE: Must be called with dept_lock held.
+ */
+static void disconnect_event_site(struct dept_event_site *es)
+{
+	struct dept_event_site_dep *esd, *next_esd;
+
+	list_for_each_entry_safe(esd, next_esd, &es->dep_head, dep_node) {
+		list_del_rcu(&esd->dep_node);
+		list_del_rcu(&esd->dep_rev_node);
+	}
+
+	list_for_each_entry_safe(esd, next_esd, &es->dep_rev_head, dep_rev_node) {
+		list_del_rcu(&esd->dep_node);
+		list_del_rcu(&esd->dep_rev_node);
+	}
+}
+
 /*
  * NOTE: Must be called with dept_lock held.
  */
@@ -2384,6 +2414,8 @@ void dept_free_range(void *start, unsigned int sz)
 {
 	struct dept_task *dt = dept_task();
 	struct dept_class *c, *n;
+	struct dept_event_site_dep *esd, *next_esd;
+	struct dept_event_site *es, *next_es;
 	unsigned long flags;
 
 	if (unlikely(!dept_working()))
@@ -2405,6 +2437,24 @@ void dept_free_range(void *start, unsigned int sz)
 	while (unlikely(!dept_lock()))
 		cpu_relax();
 
+	list_for_each_entry_safe(esd, next_esd, &dept_event_site_deps, all_node) {
+		if (!within((void *)esd, start, sz))
+			continue;
+
+		disconnect_event_site_dep(esd);
+		list_del(&esd->all_node);
+	}
+
+	list_for_each_entry_safe(es, next_es, &dept_event_sites, all_node) {
+		if (!within((void *)es, start, sz) &&
+		    !within(es->name, start, sz) &&
+		    !within(es->func_name, start, sz))
+			continue;
+
+		disconnect_event_site(es);
+		list_del(&es->all_node);
+	}
+
 	list_for_each_entry_safe(c, n, &dept_classes, all_node) {
 		if (!within((void *)c->key, start, sz) &&
 		    !within(c->name, start, sz))
@@ -3337,6 +3387,7 @@ void __dept_recover_event(struct dept_event_site_dep *esd,
 
 	list_add(&esd->dep_node, &es->dep_head);
 	list_add(&esd->dep_rev_node, &rs->dep_rev_head);
+	list_add(&esd->all_node, &dept_event_site_deps);
 	check_recover_dl_bfs(esd);
 unlock:
 	dept_unlock();
@@ -3347,6 +3398,23 @@ EXPORT_SYMBOL_GPL(__dept_recover_event);
 
 #define B2KB(B) ((B) / 1024)
 
+void dept_mark_event_site_used(void *start, void *end)
+{
+	struct dept_event_site_init **evtinitpp;
+
+	for (evtinitpp = (struct dept_event_site_init **)start;
+	     evtinitpp < (struct dept_event_site_init **)end;
+	     evtinitpp++) {
+		(*evtinitpp)->evt_site->used = true;
+		(*evtinitpp)->evt_site->func_name = (*evtinitpp)->func_name;
+		list_add(&(*evtinitpp)->evt_site->all_node, &dept_event_sites);
+
+		pr_info("dept_event_site %s@%s is initialized.\n",
+				(*evtinitpp)->evt_site->name,
+				(*evtinitpp)->evt_site->func_name);
+	}
+}
+
 extern char __dept_event_sites_start[], __dept_event_sites_end[];
 
 /*
@@ -3356,20 +3424,11 @@ extern char __dept_event_sites_start[], __dept_event_sites_end[];
 void __init dept_init(void)
 {
 	size_t mem_total = 0;
-	struct dept_event_site_init **evtinitpp;
 
 	/*
 	 * dept recover dependency tracking works from now on.
 	 */
-	for (evtinitpp = (struct dept_event_site_init **)__dept_event_sites_start;
-	     evtinitpp < (struct dept_event_site_init **)__dept_event_sites_end;
-	     evtinitpp++) {
-		(*evtinitpp)->evt_site->used = true;
-		(*evtinitpp)->evt_site->func_name = (*evtinitpp)->func_name;
-		pr_info("dept_event %s@%s is initialized.\n",
-				(*evtinitpp)->evt_site->name,
-				(*evtinitpp)->evt_site->func_name);
-	}
+	dept_mark_event_site_used(__dept_event_sites_start, __dept_event_sites_end);
 	dept_recover_ready = true;
 
 	local_irq_disable();
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 03ed63f2adf0..82448cdb8ed7 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2720,6 +2720,11 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 						&mod->dyndbg_info.num_classes);
 #endif
 
+#ifdef CONFIG_DEPT
+	mod->dept_event_sites = section_objs(info, ".dept.event_sites",
+					sizeof(*mod->dept_event_sites),
+					&mod->num_dept_event_sites);
+#endif
 	return 0;
 }
 
@@ -3346,6 +3351,14 @@ static int early_mod_check(struct load_info *info, int flags)
 	return err;
 }
 
+static void dept_mark_event_site_used_module(struct module *mod)
+{
+#ifdef CONFIG_DEPT
+	dept_mark_event_site_used(mod->dept_event_sites,
+			     mod->dept_event_sites + mod->num_dept_event_sites);
+#endif
+}
+
 /*
  * Allocate and load the module: note that size of section 0 is always
  * zero, and we rely on this for optional sections.
@@ -3508,6 +3521,8 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	/* Done! */
 	trace_module_load(mod);
 
+	dept_mark_event_site_used_module(mod);
+
 	return do_init_module(mod);
 
  sysfs_cleanup:
-- 
2.17.1


