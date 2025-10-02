Return-Path: <linux-arch+bounces-13860-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB42BB314F
	for <lists+linux-arch@lfdr.de>; Thu, 02 Oct 2025 10:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E9823ADC58
	for <lists+linux-arch@lfdr.de>; Thu,  2 Oct 2025 08:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33A63126A9;
	Thu,  2 Oct 2025 08:14:06 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB2630EF7B;
	Thu,  2 Oct 2025 08:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392846; cv=none; b=ea+SlzKeuYYVPXaM9tWrB8SbMAk7BALPQ3u5mMjNNfs20WfEjgoFE6FIy42V3dohC8j6K6GgzIHdIamAWU8JgKY7He+XervXQvhdjAJuOqLZlEMzhMGhxyXun8zwwFcj2tNpzKUvSsaOoYZGjioH7uPCXe8LVS7rIgLzL9XMRaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392846; c=relaxed/simple;
	bh=GWWReu+uieKdoNR9LXX0pJ0D/rvvILcUDOdshrqbVYg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=dLhRwWCmnnM8AagviHnbk3B+XB9ypwwD9hufiYznH+0BaSORGvmGsX+yRwKykLmUWuRU6UK4EbP+I7LlmzUwA3t8KyjTHVDS2g53j7FT9QuN0KhSd0BJg1iGxrMbSir7Ce3VDDEnHAnA9blnaegTIuTTBiub+pJfZ/PP8mUXvHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-84-68de3412feb6
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
Subject: [PATCH v17 33/47] dept: make dept aware of lockdep_set_lock_cmp_fn() annotation
Date: Thu,  2 Oct 2025 17:12:33 +0900
Message-Id: <20251002081247.51255-34-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251002081247.51255-1-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0iTYRTHfd7b5nDxNi3fLDBWJoiurBkHsuhD4ENUFPkhMsqXfHEjb0zz
	UlSa05aUWli2TNO84gXXLNJRVpZRmaloa5QuRxcb6UrnBctaW5dvP/7nd/6cD0dMyhaoALE6
	KU3QJPEJckZCSSZ8qsJ8lVbVOltNCMxM6yjQGfU0NN/KIcBp+MXAl0dTCOzdUeAaGSPg9ew4
	gp+Xj8CP3j4SPhvOILjXcJoBh4GB8rKLCDpGTSIoK80l4EX1MAV12UHgqkyGJ01jIhgpukTB
	M6uZBp1phgJ9xTADg6ZrDPQ/6KGhdcxCQJ+phQbbqIUGS/FHBC2OG+4LZutIaJgspeHTq3wC
	aqcdJOTX3CSgUzdKwOPWOwQYm80MfK/vRtA0QEFZTiGC291zIjBM1jOgHY4AR/E0vVWB5/IK
	KTxdm0vivOJmhLVtGfhCbxjuuDoiwtrONyJcaTyKq+/aCVw1NUPjN182Y2PjWQYXTAwR+MNQ
	KYErnu3BHXnv6N3cfklknJCgThc0a7fESlRdrutkytXgTLO1ncxGFYEFyFvMsUruivM0UYDE
	f9hlTvPEDBvMWSzzpIf92JVc2/lPtIdJtmcFZx4I9ei+7D5ON4E8SLFB3MPyDI8hZTdypvdV
	xN/yQK7J8OBPi7c7H7T1UB6WsRFc3let25G4nTJvbqLx7b+FZdzDBgtVjKSVyKsRydRJ6Ym8
	OkGpUGUlqTMVh5MTjcj9E3UnFmLa0VT/3i7EipHcR9ofNKKS0Xx6alZiF+LEpNxPGtswrJJJ
	4/isY4Im+ZDmaIKQ2oWWiym5v3T9bEacjI3n04QjgpAiaP5PCbF3QDYKeR69x+a85rXF5pUp
	ijpwcM3J+ZdPTVU9Oczdc9t6gyPv/5xR2oV3x1bKnY+ck2eUm5au31noGjy+qzNwhyya5xX4
	G4pZZPYzllTbFc+tfuWD27UK/RO7fknoq9YNDl+9decqfyYtfvH86m8pJ8/6+kesHT8VXnJF
	W1Rzb/zSXJScSlXx4SGkJpX/DY8ZQpUPAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTcRTH+917d+91tbgso0v2YiRCpClYnZ5EGV2KIqjoReioixvqjM1M
	g0KbI7E0G01pU1tK03Tp2lS0WJjaoGzYsmaU81G+yi2ptPK5tqB/Dp9zvh8O549D42KbYDkt
	V6TxSoU0WUIKCeGhbepIcWyvLNpsjgZ3dgsBkxO5BJTUmUnItd4RwOvaGgR9k7kIfs8YcNA0
	+wmY0zoomJj6SIHf7kBQ5NLiYK7PxuCnZZ6EsbYfCHQDgyQUf8kmYNx0A4F+2EDBl+f7wNf3
	RAB+zwgG3b+8CEyD8xgMtlxDMFeUBHfLbSTMODtxKNa9RnBvwIPDqCUQ1jt6EdirrpIwVNiA
	Q9fgYng7OU7CC911EnyuEgy+WUgwXrULoNSgRaCuqCOhqNRKQHP/YwpcY7MY9BRpMaixHoQ+
	0zABHYXlWOC+gPVoGRiK1VigjGKge/gEgylTNQWvKnoIMGWFg8HZJYBPVXoKZgdiwG9MBUfN
	CAWemzoCan2dgl06xP3WFBBcta0R4zRv5kjOXGZG3My0FnET99U4pykMtG3ecZzLsV3k7nd4
	SW568h3J2X8ZCe5lOcvdckZyzXoPxeU8/UAd3npKuP0cnyxP55UbdiYIZa3+u/h5fUSGu7cJ
	z0Jlq/MQTbNMLOt3p+WhEJpkItj376fwIIcya1hb/rAgyDjTsYJ1u9YH9SXMCTbXh4JIMOHs
	s9KLQUPEbGIff76HBZllVrM1lpZ/W0IC866BDiLIYmYjqxnPwQqR0IgWVKNQuSI9RSpP3hil
	SpJlKuQZUWdTU6wo8Eqmy7O3mtBE175WxNBIskjkCvfIxAJpuiozpRWxNC4JFSVU9cjEonPS
	zEu8MjVeeSGZV7WiMJqQLBPtP84niJlEaRqfxPPneeX/FKNDlmehT4nT+zPa2e6+trAXZfPR
	tWE2C3Sfadp2c2/OWWuUlzpw+qvBaW48+UB+e01z+4W8HZZVo5VLd6n7j/WPxa6tx2bfxcT5
	OqvX006zMYm80hC3Jd2RXxm/p2DzlD10+kMFDgXfz8S3LNQf/ekuwUa97UMNfxKPeN5WrNxt
	VEREGCWESiaNWYcrVdK/Oib6C0YDAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

commit eb1cfd09f788e ("lockdep: Add lock_set_cmp_fn() annotation") has
been added to address the issue that lockdep was not able to detect a
true deadlock like the following:

   https://lore.kernel.org/lkml/20220510232633.GA18445@X58A-UD3R/

The approach is only for lockdep but dept should work being aware of it
because the new annotation is already used to avoid false positive of
lockdep in the code.

Make dept aware of the new lockdep annotation.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept.h     | 10 +++++++++
 kernel/dependency/dept.c | 48 +++++++++++++++++++++++++++++++++++-----
 kernel/locking/lockdep.c |  1 +
 3 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/include/linux/dept.h b/include/linux/dept.h
index b6dc4ff19537..8b4d97fc4627 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -130,6 +130,11 @@ struct dept_map {
 	const char			*name;
 	struct dept_key			*keys;
 
+	/*
+	 * keep lockdep map to handle lockdep_set_lock_cmp_fn().
+	 */
+	void				*lockdep_map;
+
 	/*
 	 * subclass that can be set from user
 	 */
@@ -156,6 +161,7 @@ struct dept_map {
 {									\
 	.name = #n,							\
 	.keys = (struct dept_key *)(k),					\
+	.lockdep_map = NULL,						\
 	.sub_u = 0,							\
 	.map_key = { .classes = { NULL, } },				\
 	.wgen = 0U,							\
@@ -427,6 +433,8 @@ extern void dept_softirqs_on_ip(unsigned long ip);
 extern void dept_hardirqs_on(void);
 extern void dept_softirqs_off(void);
 extern void dept_hardirqs_off(void);
+
+#define dept_set_lockdep_map(m, lockdep_m) ({ (m)->lockdep_map = lockdep_m; })
 #else /* !CONFIG_DEPT */
 struct dept_key { };
 struct dept_map { };
@@ -469,5 +477,7 @@ struct dept_ext_wgen { };
 #define dept_hardirqs_on()				do { } while (0)
 #define dept_softirqs_off()				do { } while (0)
 #define dept_hardirqs_off()				do { } while (0)
+
+#define dept_set_lockdep_map(m, lockdep_m)		do { } while (0)
 #endif
 #endif /* __LINUX_DEPT_H */
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index 1c6eb0a6d0a6..a0eb4b108de0 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -1615,9 +1615,39 @@ static int next_wgen(void)
 	return atomic_inc_return(&wgen) ?: atomic_inc_return(&wgen);
 }
 
-static void add_wait(struct dept_class *c, unsigned long ip,
-		     const char *w_fn, int sub_l, bool sched_sleep,
-		     bool timeout)
+/*
+ * XXX: This is a temporary patch needed until lockdep stops tracking
+ * dependency in wrong way.  lockdep has added an annotation to specify
+ * a callback to determin whether the given lock aquisition order is
+ * okay or not in its own way.  Even though dept is already working
+ * correctly with sub class on that issue, it needs to be aware of the
+ * annotation anyway.
+ */
+static bool lockdep_cmp_fn(struct dept_map *prev, struct dept_map *next)
+{
+	/*
+	 * Assumes the cmp_fn thing comes from struct lockdep_map.
+	 */
+	struct lockdep_map *p_lock = (struct lockdep_map *)prev->lockdep_map;
+	struct lockdep_map *n_lock = (struct lockdep_map *)next->lockdep_map;
+	struct lock_class *p_class = p_lock ? p_lock->class_cache[0] : NULL;
+	struct lock_class *n_class = n_lock ? n_lock->class_cache[0] : NULL;
+
+	if (!p_class || !n_class)
+		return false;
+
+	if (p_class != n_class)
+		return false;
+
+	if (!p_class->cmp_fn)
+		return false;
+
+	return p_class->cmp_fn(p_lock, n_lock) < 0;
+}
+
+static void add_wait(struct dept_map *m, struct dept_class *c,
+		unsigned long ip, const char *w_fn, int sub_l,
+		bool sched_sleep, bool timeout)
 {
 	struct dept_task *dt = dept_task();
 	struct dept_wait *w;
@@ -1658,8 +1688,13 @@ static void add_wait(struct dept_class *c, unsigned long ip,
 		if (!eh->ecxt)
 			continue;
 
-		if (eh->ecxt->class != c || eh->sub_l == sub_l)
-			add_dep(eh->ecxt, w);
+		if (eh->ecxt->class == c && eh->sub_l != sub_l)
+			continue;
+
+		if (i == dt->ecxt_held_pos - 1 && lockdep_cmp_fn(eh->map, m))
+			continue;
+
+		add_dep(eh->ecxt, w);
 	}
 
 	wg = next_wgen();
@@ -2145,6 +2180,7 @@ void dept_map_init(struct dept_map *m, struct dept_key *k, int sub_u,
 	m->name = n;
 	m->wgen = 0U;
 	m->nocheck = !valid_key(k);
+	m->lockdep_map = NULL;
 
 	dept_exit_recursive(flags);
 }
@@ -2366,7 +2402,7 @@ static void __dept_wait(struct dept_map *m, unsigned long w_f,
 		if (!c)
 			continue;
 
-		add_wait(c, ip, w_fn, sub_l, sched_sleep, timeout);
+		add_wait(m, c, ip, w_fn, sub_l, sched_sleep, timeout);
 	}
 }
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 39b9e3e27c0b..c99f91f7a54d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5035,6 +5035,7 @@ void lockdep_set_lock_cmp_fn(struct lockdep_map *lock, lock_cmp_fn cmp_fn,
 		class->print_fn = print_fn;
 	}
 
+	dept_set_lockdep_map(&lock->dmap, lock);
 	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
 }
-- 
2.17.1


