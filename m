Return-Path: <linux-arch+bounces-13869-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A52BBB31D9
	for <lists+linux-arch@lfdr.de>; Thu, 02 Oct 2025 10:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF3F819C677B
	for <lists+linux-arch@lfdr.de>; Thu,  2 Oct 2025 08:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D6D315D38;
	Thu,  2 Oct 2025 08:14:14 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F482311957;
	Thu,  2 Oct 2025 08:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392852; cv=none; b=pvctHj1+rC88zLvrrvW61ZrrlKFF8wUbfps/o1o4Lc9DjRnLSRltb3BYX8WJ5TA+XVH8eoljKXi9AVltHz0UhVTeiDRufiaP2TrN/oNWRzv6eZWmHXRWTBARJmFLKElqoBd4/ZGmFDJ2oJjsYXpjE47tYhDxAOdZbnyPFk8xu/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392852; c=relaxed/simple;
	bh=Vg0cL3qHe4cP/WpcIVBPLLHPUcknH8bXkySiCGRbfqw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=OJonL+s7HGUHndmzQGF5ZsATnyaPkF/+Gm5nIIXqSP7a8rQln3fQhpD9sRXPDwUfvpq16vg2AXldz8HassTM/3E01O+B2xtNIP5KWGyiSC0kRaZdiAxteha/UBG8gmikL8E1MyKIven/RkzgT6rMunuC2nfE3rRjvnuhUv+3wKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-3b-68de34143874
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
Subject: [PATCH v17 39/47] dept: add module support for struct dept_event_site and dept_event_site_dep
Date: Thu,  2 Oct 2025 17:12:39 +0900
Message-Id: <20251002081247.51255-40-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251002081247.51255-1-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe2xTZRjG+c75zqXNuhzL1COYqE0W4xAmOpc3cokGkaPRxEQHAUxcXY+0
	ritLC2MTSLalDcsyoCtsc1dLo7OwFms7JnNulm00yDLsNh1F1+FgF7Drio5WgXWzHeG/X573
	ed5L8rKkPECtYjW6faJep9QqaCmWhlNOrU3LGle/dKZuA4yWeTFE71ZgaPrWQUOFu56C69EK
	BKbOJQxxi4+BpW4fAkd7GQHzrkUaaiYmaai7XYYh0lqFoGG6kYHbF7dB+HoXBUvBGQKuxmYR
	THqPIIjX5sOXNk/CX+NHcGoiSEK7bxxBt72chinzORJGJlPh12iEhjkXDdbybgqaGy0Iapvd
	GIZCCwSM1VoIaHO/BwNmG5GYm1jA2UVA4+AIBTfsDQwsTKwHX9sMA8HjNRjOhn+hIDRtoeH7
	0j8ZcF+7iKDihygG981RCupbxhI3xu8i8J2/QUCV6xwFA75LGH5uOI3h66tDBMSOrQZ/9VEK
	AuYpBM45Gw0n5qYRhGKtJLRGIwwMe63E6yrhX9MxLJiG47TgaHEg4cF9CxJM5gT1zUZIweg5
	INyP/kYL3TErFi7beKF6cK3Q2RBkBGPP74xgde8XjP1hSvDYM95/YZd0o0rUaopEfebmXKn6
	p46TdGHoreI/LtykStFXr1UiCctzWXz/7CT9iNt7XCjJNPc8HwjcI5Ocxj3Le45OU0kmuYGn
	+dGhF5O8kvuU73Dal7OYS+dbWjzLfhmXzd8JL6KHPZ/h21zeZV2S0EcmBnCS5dyrvCliJCqR
	NOFplPCeW+Pkw8BT/AV7AJuRzIpWnEFyja6oQKnRZq1Tl+g0xevy9ha4UeLfWg8v7D6P/vF/
	0Is4FilSZP70oFpOKYsMJQW9iGdJRZos1z6mlstUypLPRf3ej/X7taKhF61mseJJ2cuxAyo5
	t0e5T8wXxUJR/6hKsJJVpYgtXxr+qM+2IzjPYafzw5SZ7Vu2VvseXM755u0c47bHsr/z6EhG
	s3F2d9GPfH36E4uFn6hX9Ku+eKdqy+ad9r7SPVdSU+rn28krxue8r0iuZVry7jnyB4s3VR78
	r7dY2/TXZ2lHpGffGE9d46Ie77wUmrPED73LNmdPGeqaNr3pX/l3kwIb1Mr1GaTeoPwfvf03
	E2sDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0iTcRTG+7/XOVq8LMEXi4qZRGE3yjpkVBLUS3SjiKgP5aq3NnS6NrMs
	gnlZSjfnbIoubWmu4SWXM8tEMyOplrm1LqIus5ZlakZ5QZ2urejL4Xee5+HwfDgCXFxLhgrk
	8Ym8Kl4aJ6GEhHBnVNrS4NUfZCtuu4TwLqWJgJHhTAKuV1VQkFmdT4LjTjmC7pFMBGOTRhy0
	dT4CpvQtNAyPd9Lga2hBkOvU41BRk4LBb+s0Bf1PfiEw9HgoyOtLIWDIfBlBQa+Rhr6nW2Gw
	u54En/srBu9HBxCYPdMYeJoyEEzlxsKNYhsFk61tOOQZHAhu9rhx+Gb1mzUtHxA0WFIp+KK7
	h4PLMwvejAxR8NxwiYJB53UMflgpMKU2kFBo1CNIK6miILewmoC6jw9pcPZ7MejK1WNQXr0D
	us29BNh1xZi/nz91NwSMeWmYf3zDwFBZj8G4uYyGlyVdBJg14WBsdZHwyVJAg7dnJfhMCdBS
	/pUGd5aBgDuDbeQmA+LGtFcJrsxWi3Ha11MUV1FUgbjJCT3ihkvTcE6r869PBoZwLt12miu1
	D1DcxMhbimsYNRHci2KWy25dytUVuGkuvbGD3r3uoHD9MT5OnsSrlm+IEcoe1V6jlP1bznQ+
	/kxq0K11F1GQgGVWszWNVhRgilnEtreP4wEOZhawtiu9ZIBxxj6XfeeMCPBs5jhbW2mhAkww
	4WxRke1vXsSsYX8OTqN/N+ez5damv3qQX3f12IkAi5lIVjuUjumQ0IRmlKFgeXySQiqPi1ym
	jpUlx8vPLDuaoKhG/m8yn/dmP0DDrq3NiBEgyUyRM9wtE5PSJHWyohmxAlwSLIqxdMnEomPS
	5LO8KuGw6lQcr25GcwSEJES0bT8fI2ZOSBP5WJ5X8qr/LiYICtWgFyWku+/l/aDoaGPGWOhD
	y4LtTZ1RodGnckwa7bO8+7x80wFx/SFBlpPzeN/uXZu/UbkZ3HMX1vctrorI/vLz3JEsx74w
	ZcdjBdNmdxkSlPnKMYUDT9Ls0YUVjiYul0ZnHBU/L51w+eatWCWLSl14/Dv+tCQn+8LJulfe
	XY5LkRJCLZOuXIKr1NI/6YdU+EkDAAA=
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
index 988aceee36ad..25fdd324614a 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -414,6 +414,11 @@ struct dept_event_site {
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
@@ -430,6 +435,11 @@ struct dept_event_site_dep {
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
@@ -441,6 +451,7 @@ struct dept_event_site_dep {
 	.bfs_gen = 0,							\
 	.bfs_parent = NULL,						\
 	.bfs_node = LIST_HEAD_INIT((es).bfs_node),			\
+	.all_node = LIST_HEAD_INIT((es).all_node),			\
 	.used = false,							\
 }
 
@@ -450,6 +461,7 @@ struct dept_event_site_dep {
 	.recover_site = NULL,						\
 	.dep_node = LIST_HEAD_INIT((esd).dep_node),			\
 	.dep_rev_node = LIST_HEAD_INIT((esd).dep_rev_node),		\
+	.all_node = LIST_HEAD_INIT((esd).all_node),			\
 }
 
 struct dept_event_site_init {
@@ -473,6 +485,7 @@ extern void dept_init(void);
 extern void dept_task_init(struct task_struct *t);
 extern void dept_task_exit(struct task_struct *t);
 extern void dept_free_range(void *start, unsigned int sz);
+extern void dept_mark_event_site_used(void *start, void *end);
 
 extern void dept_map_init(struct dept_map *m, struct dept_key *k, int sub_u, const char *n);
 extern void dept_map_reinit(struct dept_map *m, struct dept_key *k, int sub_u, const char *n);
@@ -536,6 +549,7 @@ struct dept_event_site { };
 #define dept_task_init(t)				do { } while (0)
 #define dept_task_exit(t)				do { } while (0)
 #define dept_free_range(s, sz)				do { } while (0)
+#define dept_mark_event_site_used(s, e)			do { } while (0)
 
 #define dept_map_init(m, k, su, n)			do { (void)(n); (void)(k); } while (0)
 #define dept_map_reinit(m, k, su, n)			do { (void)(n); (void)(k); } while (0)
diff --git a/include/linux/module.h b/include/linux/module.h
index 3319a5269d28..4f360c7c9e96 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -29,6 +29,7 @@
 #include <linux/srcu.h>
 #include <linux/static_call_types.h>
 #include <linux/dynamic_debug.h>
+#include <linux/dept.h>
 
 #include <linux/percpu.h>
 #include <asm/module.h>
@@ -579,6 +580,10 @@ struct module {
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
index 6ad78f0a58b6..fe0b62a45ed2 100644
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


