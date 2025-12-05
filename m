Return-Path: <linux-arch+bounces-15189-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF27CA72E8
	for <lists+linux-arch@lfdr.de>; Fri, 05 Dec 2025 11:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B23C632AA492
	for <lists+linux-arch@lfdr.de>; Fri,  5 Dec 2025 07:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643383009D4;
	Fri,  5 Dec 2025 07:19:29 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3D3F9C0;
	Fri,  5 Dec 2025 07:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764919168; cv=none; b=t393LZXm0xdWKIgR5IVZc3VLw8cCFKMk4GQofQdJVvGpZNYnaQL95bhjXjPOFACKgwio4ZPhBJrYcl04q59aRMDcm39njKeyifUKzM8iLRCfI8nGOMc/VnY4jjIDN365+M2mX3yP2eeJ5+4ktAvuPb2T2docdaFuwxR5oZNpQXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764919168; c=relaxed/simple;
	bh=7cJmWVs99micLeaeezfT9KwNXKsu4xSXPY3Gxykz100=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=K7k0EOcHnDy3SExat+O2jMaI6tP5kAYi5epLZmK2I9TqL0tyj3TO+n/Yf0Pfq+FfMOK42LcofajTAu8y1nVS8LFdx6+IgOI6j3+t3SafT/KYVIr1LRfMJGD1JHGZ4ZIWBxZzRmo91ZJdtBgkohZTfRYgzMsu5HTHp8yMBvBgArk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-aa-6932876b141b
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
Subject: [PATCH v18 06/42] dept: distinguish each kernel context from another
Date: Fri,  5 Dec 2025 16:18:19 +0900
Message-Id: <20251205071855.72743-7-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251205071855.72743-1-byungchul@sk.com>
References: <20251205071855.72743-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSb0wTdxzG/d3d765t7DyriQdk0zQxLhocEDTfEDMxy9zFuGyJr3Qv9GZv
	o7FULYKiYgpKEYSCmJaMDmkFG1bYNMVFJuAqEkyg1Fq1Fm1TQagQ6VCQPwW3rNb45skneZ7v
	8+KbR0IqQjhZotYeE3VaQaOkZZQsutyWqinLUKctmFZAMDyKwV/somB+yUKCqRhBwPs3CfUR
	CwPRcCcG++h/BIy6yhC8Mr+mwTYcIuHR7BQND9yvEESedhNgbnBSEDTXEhC2RygYqLlCQN0E
	DZa6s0Rcxgkw/d5JQMzuYMDdFKTArl8P74bTIVRtouCP6H0M4XsGDDf1zxloq4yQcP7WLAXO
	F34M3U83gc3QTEFfxwgBess8Bq9rAMOzwWoGhp8HMLQPukmYM6aA92IVhqG6SQbss1MMRB4b
	CPite5CGe1UuAsrGO2kYtHgwXIvcJeFqSxSDs81Pw8v6BgL6QzMMLIY64s+obaRhxBhl4EKp
	mYLzvXMkFM+EESwt/EqD0fMNvG110NnZfKnvX5pvu9yG+NKauFwdmKT57jkrxTeXLxL8X/Uh
	hrc68/lzvVHMt7ds5Ju6JgjeNj2LeaejnOZtS+MkH/R30fw/Hg/z/bp9sm0qUaMuEHVffHlA
	lhMzvsFHmvee6Jm4iPXIt7MCSSUcm8mdbehAH9n3yw3yPdPsBi4QiCV4NbuOa6+K4Aokk5Ds
	w7VcWcyYMFax33IPfZMJptj1XMlYkH7PcnYL13+ukflQupZrve5KZKTsVs70ZDHBinimsWI+
	UcqxFinneeOjPhwkcXdaAlQNklvRMgdSqLUFuYJak7k5p1CrPrH54OFcJ4qPzl707ocONO3d
	04NYCVIul7uOp6sVWCjIK8ztQZyEVK6WT2rS1Aq5Sig8KeoO79fla8S8HpQioZRr5Blzx1UK
	9mfhmHhIFI+Iuo8uIZEm61FS16FgX9aIHAkHNqimDY0VmSWMnuxtBelX27PyU1dK+REZ0/v5
	JRY/qC6pnPiu+H7/2NeVjmnDzCey20OkNUW4cVk4dX33Z14xeao2PVB/tNz6Y3+12/bn/tPS
	8t0ZSJV2sy81e8gdE8z+BXdsR2b+T1NnnKZdRUJDn0z7qZLKyxHSN5K6POF/Vj1mH3ADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0ySYRTHe94bSNHekc139iFjazVbFy3babWuq565bH1r+qWo3iWBVkCa
	bS0RmWbmlA3IyDRTamhpYBdrFLNpF7uolLLS0I0oJmUXzMDMiNaXs9/Z/3fOzocjJCV36ESh
	PFfDq3JlSikjokQ71+qWKkpS5SvqG5KhVH8KBr0+Gvq1LgrGQ6UUXGhpZmDKclsApfZqGh4P
	FFHQc70JgXe8FMHEpIUEffs0BVOGLgGEwm8FYNQimHZ2ITD1Gkjw9DwgoblNS8D31t8MjD78
	hsA44mPAHNBSMGYtR3DebxFAoHM7fPLeo2F66AMBAz+CCKy+3wT4XCUIpkwKqK13RMdNXxiY
	fP6SBLOxB8GlkSESvgWGEbR1vUPgvFrEwPvKmyS4fbPh1fgYA0+MZxj41HuBgM+tDNQVOWno
	fTaKoMZiQOB/4yRAd7mFAVONnYL24bsC6B39RcCgyUBAkz0DvFY/Bd2V9UT03Kh1IwEsZh0R
	LR8JMF67R0DYahNsbER4Ql9BYZvjFoH1fVMMbr7YjPBkxIBwqFFHYn1ltH0YHCNxsSMfN3YH
	GRwZf81g5486Cj+t53DD6QiBq54vxe3nhwS7NmWJ1h3glfI8XrV8/V5RdrjiK32kIfN4R6CK
	LkR928pQnJBjV3F91W3kX2bYRZzHE45xPJvEOc766TIkEpKsez5XEq6IBXPYDM7dF4wxxS7k
	it4PMn9ZzKZxT4trBf+WzueaWl0xJ45dzRkHIjGWRJ3asgm6Eonq0Awbipfn5uXI5Mq0ZWpF
	dkGu/Piy/Ydz7Cj6T9aTv6ruoJB7ewdihUg6S+zKT5FLaFmeuiCnA3FCUhovDipXyCXiA7KC
	E7zq8B7VMSWv7kDzhJQ0QZy+m98rYQ/KNLyC54/wqv8pIYxLLETDRzdoNts/uhbej+SXz2zv
	5A5txSkZs2dGdNJHhft/enTJ/uWDi7I8qVu2JbgP4bTr/O3Msy+SwgvSNdQS27n+tYqk1PSc
	aq1znz0Q1M99lKW51nmwpfuduT/u9ErbmgXk4rfm0Suiyx++Lv5cfGzHq901dv9Ob3ooK3Gk
	nHA8ACmlzpalJJMqtewPiwJt8EsDAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

Each unique kernel context, in dept's point of view, should be
identified on every entrance to kernel mode e.g. system call or user
oriented fault.  Otherwise, dept may track meaningless dependencies
across different kernel context.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept.h              | 17 +++++---
 include/linux/irq-entry-common.h  |  4 ++
 include/linux/sched.h             | 10 ++---
 kernel/dependency/dept.c          | 67 ++++++++++++++++---------------
 kernel/dependency/dept_internal.h | 12 +++---
 5 files changed, 61 insertions(+), 49 deletions(-)

diff --git a/include/linux/dept.h b/include/linux/dept.h
index a6d14b585a8d..2343d8c392d7 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -24,11 +24,16 @@ struct task_struct;
 #define DEPT_MAX_SUBCLASSES_USR		(DEPT_MAX_SUBCLASSES / DEPT_MAX_SUBCLASSES_EVT)
 #define DEPT_MAX_SUBCLASSES_CACHE	2
 
-#define DEPT_SIRQ			0
-#define DEPT_HIRQ			1
-#define DEPT_IRQS_NR			2
-#define DEPT_SIRQF			(1UL << DEPT_SIRQ)
-#define DEPT_HIRQF			(1UL << DEPT_HIRQ)
+enum {
+	DEPT_CXT_SIRQ = 0,
+	DEPT_CXT_HIRQ,
+	DEPT_CXT_IRQS_NR,
+	DEPT_CXT_PROCESS = DEPT_CXT_IRQS_NR,
+	DEPT_CXTS_NR
+};
+
+#define DEPT_SIRQF			(1UL << DEPT_CXT_SIRQ)
+#define DEPT_HIRQF			(1UL << DEPT_CXT_HIRQ)
 
 struct dept_key {
 	union {
@@ -146,6 +151,7 @@ extern void dept_event(struct dept_map *m, unsigned long e_f, unsigned long ip,
 extern void dept_ecxt_exit(struct dept_map *m, unsigned long e_f, unsigned long ip);
 extern void dept_sched_enter(void);
 extern void dept_sched_exit(void);
+extern void dept_update_cxt(void);
 
 static inline void dept_ecxt_enter_nokeep(struct dept_map *m)
 {
@@ -193,6 +199,7 @@ struct dept_map { };
 #define dept_ecxt_exit(m, e_f, ip)			do { } while (0)
 #define dept_sched_enter()				do { } while (0)
 #define dept_sched_exit()				do { } while (0)
+#define dept_update_cxt()				do { } while (0)
 #define dept_ecxt_enter_nokeep(m)			do { } while (0)
 #define dept_key_init(k)				do { (void)(k); } while (0)
 #define dept_key_destroy(k)				do { (void)(k); } while (0)
diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-common.h
index 6ab913e57da0..126bac5806a3 100644
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -9,6 +9,7 @@
 #include <linux/syscalls.h>
 #include <linux/tick.h>
 #include <linux/unwind_deferred.h>
+#include <linux/dept.h>
 
 #include <asm/entry-common.h>
 
@@ -88,6 +89,9 @@ static __always_inline bool arch_in_rcu_eqs(void) { return false; }
  */
 static __always_inline void enter_from_user_mode(struct pt_regs *regs)
 {
+	/* Make dept work with a new context. */
+	dept_update_cxt();
+
 	arch_enter_from_user_mode(regs);
 	lockdep_hardirqs_off(CALLER_ADDR0);
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 33e713c3ba70..1cd0e78f3323 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -833,19 +833,19 @@ struct dept_task {
 	int				wait_hist_pos;
 
 	/*
-	 * sequential id to identify each IRQ context
+	 * sequential id to identify each context
 	 */
-	unsigned int			irq_id[DEPT_IRQS_NR];
+	unsigned int			cxt_id[DEPT_CXTS_NR];
 
 	/*
 	 * for tracking IRQ-enabled points with cross-event
 	 */
-	unsigned int			wgen_enirq[DEPT_IRQS_NR];
+	unsigned int			wgen_enirq[DEPT_CXT_IRQS_NR];
 
 	/*
 	 * for keeping up-to-date IRQ-enabled points
 	 */
-	unsigned long			enirq_ip[DEPT_IRQS_NR];
+	unsigned long			enirq_ip[DEPT_CXT_IRQS_NR];
 
 	/*
 	 * for reserving a current stack instance at each operation
@@ -899,7 +899,7 @@ struct dept_task {
 	.wait_hist = { { .wait = NULL, } },			\
 	.ecxt_held_pos = 0,					\
 	.wait_hist_pos = 0,					\
-	.irq_id = { 0U },					\
+	.cxt_id = { 0U },					\
 	.wgen_enirq = { 0U },					\
 	.enirq_ip = { 0UL },					\
 	.stack = NULL,						\
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index dfe9dfdb6991..953e1b81a81f 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -230,9 +230,9 @@ static struct dept_class *dep_tc(struct dept_dep *d)
 
 static const char *irq_str(int irq)
 {
-	if (irq == DEPT_SIRQ)
+	if (irq == DEPT_CXT_SIRQ)
 		return "softirq";
-	if (irq == DEPT_HIRQ)
+	if (irq == DEPT_CXT_HIRQ)
 		return "hardirq";
 	return "(unknown)";
 }
@@ -410,7 +410,7 @@ static void initialize_class(struct dept_class *c)
 {
 	int i;
 
-	for (i = 0; i < DEPT_IRQS_NR; i++) {
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++) {
 		struct dept_iecxt *ie = &c->iecxt[i];
 		struct dept_iwait *iw = &c->iwait[i];
 
@@ -436,7 +436,7 @@ static void initialize_ecxt(struct dept_ecxt *e)
 {
 	int i;
 
-	for (i = 0; i < DEPT_IRQS_NR; i++) {
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++) {
 		e->enirq_stack[i] = NULL;
 		e->enirq_ip[i] = 0UL;
 	}
@@ -452,7 +452,7 @@ static void initialize_wait(struct dept_wait *w)
 {
 	int i;
 
-	for (i = 0; i < DEPT_IRQS_NR; i++) {
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++) {
 		w->irq_stack[i] = NULL;
 		w->irq_ip[i] = 0UL;
 	}
@@ -491,7 +491,7 @@ static void destroy_ecxt(struct dept_ecxt *e)
 {
 	int i;
 
-	for (i = 0; i < DEPT_IRQS_NR; i++)
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++)
 		if (e->enirq_stack[i])
 			put_stack(e->enirq_stack[i]);
 	if (e->class)
@@ -507,7 +507,7 @@ static void destroy_wait(struct dept_wait *w)
 {
 	int i;
 
-	for (i = 0; i < DEPT_IRQS_NR; i++)
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++)
 		if (w->irq_stack[i])
 			put_stack(w->irq_stack[i]);
 	if (w->class)
@@ -665,7 +665,7 @@ static void print_diagram(struct dept_dep *d)
 	const char *tc_n = tc->sched_map ? "<sched>" : (tc->name ?: "(unknown)");
 
 	irqf = e->enirqf & w->irqf;
-	for_each_set_bit(irq, &irqf, DEPT_IRQS_NR) {
+	for_each_set_bit(irq, &irqf, DEPT_CXT_IRQS_NR) {
 		if (!firstline)
 			pr_warn("\nor\n\n");
 		firstline = false;
@@ -698,7 +698,7 @@ static void print_dep(struct dept_dep *d)
 	const char *tc_n = tc->sched_map ? "<sched>" : (tc->name ?: "(unknown)");
 
 	irqf = e->enirqf & w->irqf;
-	for_each_set_bit(irq, &irqf, DEPT_IRQS_NR) {
+	for_each_set_bit(irq, &irqf, DEPT_CXT_IRQS_NR) {
 		pr_warn("%s has been enabled:\n", irq_str(irq));
 		print_ip_stack(e->enirq_ip[irq], e->enirq_stack[irq]);
 		pr_warn("\n");
@@ -866,7 +866,7 @@ static void bfs(void *root, struct bfs_ops *ops, void *in, void **out)
  */
 
 static unsigned long cur_enirqf(void);
-static int cur_irq(void);
+static int cur_cxt(void);
 static unsigned int cur_ctxt_id(void);
 
 static struct dept_iecxt *iecxt(struct dept_class *c, int irq)
@@ -1443,7 +1443,7 @@ static void add_dep(struct dept_ecxt *e, struct dept_wait *w)
 	if (d) {
 		check_dl_bfs(d);
 
-		for (i = 0; i < DEPT_IRQS_NR; i++) {
+		for (i = 0; i < DEPT_CXT_IRQS_NR; i++) {
 			struct dept_iwait *fiw = iwait(fc, i);
 			struct dept_iecxt *found_ie;
 			struct dept_iwait *found_iw;
@@ -1487,7 +1487,7 @@ static void add_wait(struct dept_class *c, unsigned long ip,
 	struct dept_task *dt = dept_task();
 	struct dept_wait *w;
 	unsigned int wg;
-	int irq;
+	int cxt;
 	int i;
 
 	if (DEPT_WARN_ON(!valid_class(c)))
@@ -1503,9 +1503,9 @@ static void add_wait(struct dept_class *c, unsigned long ip,
 	w->wait_stack = get_current_stack();
 	w->sched_sleep = sched_sleep;
 
-	irq = cur_irq();
-	if (irq < DEPT_IRQS_NR)
-		add_iwait(c, irq, w);
+	cxt = cur_cxt();
+	if (cxt == DEPT_CXT_HIRQ || cxt == DEPT_CXT_SIRQ)
+		add_iwait(c, cxt, w);
 
 	/*
 	 * Avoid adding dependency between user aware nested ecxt and
@@ -1579,7 +1579,7 @@ static struct dept_ecxt_held *add_ecxt(struct dept_map *m,
 	eh->sub_l = sub_l;
 
 	irqf = cur_enirqf();
-	for_each_set_bit(irq, &irqf, DEPT_IRQS_NR)
+	for_each_set_bit(irq, &irqf, DEPT_CXT_IRQS_NR)
 		add_iecxt(c, irq, e, false);
 
 	del_ecxt(e);
@@ -1728,7 +1728,7 @@ static void do_event(struct dept_map *m, struct dept_map *real_m,
 			add_dep(eh->ecxt, wh->wait);
 	}
 
-	for (i = 0; i < DEPT_IRQS_NR; i++) {
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++) {
 		struct dept_ecxt *e;
 
 		if (before(dt->wgen_enirq[i], wg))
@@ -1775,7 +1775,7 @@ static void disconnect_class(struct dept_class *c)
 		call_rcu(&d->rh, del_dep_rcu);
 	}
 
-	for (i = 0; i < DEPT_IRQS_NR; i++) {
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++) {
 		stale_iecxt(iecxt(c, i));
 		stale_iwait(iwait(c, i));
 	}
@@ -1800,27 +1800,21 @@ static unsigned long cur_enirqf(void)
 	return 0UL;
 }
 
-static int cur_irq(void)
+static int cur_cxt(void)
 {
 	if (lockdep_softirq_context(current))
-		return DEPT_SIRQ;
+		return DEPT_CXT_SIRQ;
 	if (lockdep_hardirq_context())
-		return DEPT_HIRQ;
-	return DEPT_IRQS_NR;
+		return DEPT_CXT_HIRQ;
+	return DEPT_CXT_PROCESS;
 }
 
 static unsigned int cur_ctxt_id(void)
 {
 	struct dept_task *dt = dept_task();
-	int irq = cur_irq();
+	int cxt = cur_cxt();
 
-	/*
-	 * Normal process context
-	 */
-	if (irq == DEPT_IRQS_NR)
-		return 0U;
-
-	return dt->irq_id[irq] | (1UL << irq);
+	return dt->cxt_id[cxt] | (1UL << cxt);
 }
 
 static void enirq_transition(int irq)
@@ -1877,7 +1871,7 @@ static void dept_enirq(unsigned long ip)
 
 	flags = dept_enter();
 
-	for_each_set_bit(irq, &irqf, DEPT_IRQS_NR) {
+	for_each_set_bit(irq, &irqf, DEPT_CXT_IRQS_NR) {
 		dt->enirq_ip[irq] = ip;
 		enirq_transition(irq);
 	}
@@ -1923,6 +1917,13 @@ void noinstr dept_hardirqs_off(void)
 	dept_task()->hardirqs_enabled = false;
 }
 
+void noinstr dept_update_cxt(void)
+{
+	struct dept_task *dt = dept_task();
+
+	dt->cxt_id[DEPT_CXT_PROCESS] += 1UL << DEPT_CXTS_NR;
+}
+
 /*
  * Ensure it's the outmost softirq context.
  */
@@ -1930,7 +1931,7 @@ void dept_softirq_enter(void)
 {
 	struct dept_task *dt = dept_task();
 
-	dt->irq_id[DEPT_SIRQ] += 1UL << DEPT_IRQS_NR;
+	dt->cxt_id[DEPT_CXT_SIRQ] += 1UL << DEPT_CXTS_NR;
 }
 
 /*
@@ -1940,7 +1941,7 @@ void noinstr dept_hardirq_enter(void)
 {
 	struct dept_task *dt = dept_task();
 
-	dt->irq_id[DEPT_HIRQ] += 1UL << DEPT_IRQS_NR;
+	dt->cxt_id[DEPT_CXT_HIRQ] += 1UL << DEPT_CXTS_NR;
 }
 
 void dept_sched_enter(void)
diff --git a/kernel/dependency/dept_internal.h b/kernel/dependency/dept_internal.h
index a1eb1ed647a7..262114a0110c 100644
--- a/kernel/dependency/dept_internal.h
+++ b/kernel/dependency/dept_internal.h
@@ -106,8 +106,8 @@ struct dept_class {
 			/*
 			 * for tracking IRQ dependencies
 			 */
-			struct dept_iecxt iecxt[DEPT_IRQS_NR];
-			struct dept_iwait iwait[DEPT_IRQS_NR];
+			struct dept_iecxt iecxt[DEPT_CXT_IRQS_NR];
+			struct dept_iwait iwait[DEPT_CXT_IRQS_NR];
 
 			/*
 			 * classified by a map embedded in task_struct,
@@ -169,8 +169,8 @@ struct dept_ecxt {
 			/*
 			 * where the IRQ-enabled happened
 			 */
-			unsigned long	enirq_ip[DEPT_IRQS_NR];
-			struct dept_stack *enirq_stack[DEPT_IRQS_NR];
+			unsigned long	enirq_ip[DEPT_CXT_IRQS_NR];
+			struct dept_stack *enirq_stack[DEPT_CXT_IRQS_NR];
 
 			/*
 			 * where the event context started
@@ -214,8 +214,8 @@ struct dept_wait {
 			/*
 			 * where the IRQ wait happened
 			 */
-			unsigned long	irq_ip[DEPT_IRQS_NR];
-			struct dept_stack *irq_stack[DEPT_IRQS_NR];
+			unsigned long	irq_ip[DEPT_CXT_IRQS_NR];
+			struct dept_stack *irq_stack[DEPT_CXT_IRQS_NR];
 
 			/*
 			 * where the wait happened
-- 
2.17.1


