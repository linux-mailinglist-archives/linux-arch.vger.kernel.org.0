Return-Path: <linux-arch+bounces-15216-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD25CA6958
	for <lists+linux-arch@lfdr.de>; Fri, 05 Dec 2025 09:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88E8D33E42D4
	for <lists+linux-arch@lfdr.de>; Fri,  5 Dec 2025 07:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B590133C1B1;
	Fri,  5 Dec 2025 07:21:31 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5510D327C19;
	Fri,  5 Dec 2025 07:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764919284; cv=none; b=n7AwQmfqhSdqkYbqA1hixagoivR0b9IH1pxgrapD7R1HJGcv7dmVA3uS73KnAxF4OF1LcT84dj2DP+iRAHuzDWuIWYpNUsWEB3SJmLVpPkEikZqGtz890bMGKaaXoPFLW4Yf+qSCb6mx6pIzJL7ALmf1cm+Vf698iEzhz61xODM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764919284; c=relaxed/simple;
	bh=Vj5gFQhrZ6G/CwdWvsAMyxS9WmcbVQk6wQ8WAinYldk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=FZE8RX7lm4ZyJk6bGwq43rkrAfQ5Ob2AeDDQN+sXO03txUIDlaHpqH6lUfH/46Drw8j7e5jgPrBBG0PApQVcnvPfZgshk8CMUY0SaX4/0Z8MAEaM7JgmjFJx98f24S3NQoU2uHxiqWVYvFuX4jRWLc6rNO/50M2QmD+LGayih0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-23-69328773bf67
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
Subject: [PATCH v18 35/42] dept: introduce event_site() to disable event tracking if it's recoverable
Date: Fri,  5 Dec 2025 16:18:48 +0900
Message-Id: <20251205071855.72743-36-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251205071855.72743-1-byungchul@sk.com>
References: <20251205071855.72743-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUwTdxzG/d397npUGi8dZCdkovUtcZvzfV+RLMYZc4m6zLgYoi5yg5tc
	LOBa5EVdBghSmCASC9o2UIdikVYIVcM0zK5qAwNikUyaDsE3ujmoRmYlFgpCp/9888nz5Hm+
	/zwMqfyLimGk9ExRky6oVbQcy/2R5z7VFq+SVox0rQdd0U9wP9+BIfBKh8HUZKWhva8Ag/ty
	I4LBgA7B2LiRhFClSwZVPZUkWK/kE/Bf8yQN1c/yMRh8Rhn4B29QUP90koCnjmIEoaoDMN59
	l4RqvRvB6LOHCK64BhC0WQpoGKq4SkKH/mca/D0mAp4302AuaKOgp2sYgc/bRsCxuiYaeoYn
	COivqiSgsWU7DNb78PQ/GozVx4jp8w8BetsNArrq+jEYu3speGwxyGDKnAEPTuoxXPbfpaBj
	4D4F1hM+EnTXAxjOHT+P4WxNPw260CsEvddNNJxovkrBgHWKgjzjGAX3Gt0Ymv72ENDpasfQ
	YWjA8OihhwJ7dxcJr8tjwX2qjAJPxRDamMKPFZVj/pL9GsEX3QvRvLXGivjxYCXib428IPlC
	ezZ/oXOE5oOBP2n+j184/nxJkOB/NTyQ8YW/eWW8ueUQX3jbT/F2y7KvP94tT0gR1VKWqPns
	iyR5am8oSB18Mi/nxUAZzkMXuFIUwXDsGu7m6Gn6PdtKamQzTLNLOY/nDTnDUex8zl7mo0qR
	nCHZ3jiu+E152PiAFTnT6X/DAcwu5gJ9w2Fdwa7jXl70viuN4xqbHWE9YlrX9wXDrGTXcrWl
	Y+FSjq2N4Nprq9D/gbnc7xYPrkAKM5p1CSml9Kw0QVKvWZ6amy7lLE/OSGtB05Or/3FiTysa
	de90IpZBqkiFI3ulpKSELG1umhNxDKmKUoyoV0hKRYqQe1jUZOzTHFKLWieKZbDqQ8Wq19kp
	Sna/kCkeEMWDoua9SzARMXlI+51l0RKVtClo0x1vNczPa1195/vtXxqir8lMs7NMnwi+BT8Q
	sbP33JmIjk+K+WbW55lbmKH49tXOts0Lv+p05G9d6/h235zEyaKkI7uiPrqZsMO0IOfohm0b
	CqgjLkVJ6aMzHlukvc660ZWc6Cy0xYY6vd5h8954XT0hHE1uiL4lqbA2VVi5jNRohbcR2gwh
	bgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTcRTH+93XrqPlZQldCixGkfS0JweSyCi6BEX0TyH0GHbJi5vKZj6i
	h9OGZvlotWlOzayt8FGmVpqMhpFkZW6tmlhLpWXZNMuctum0teifw/d8vud7OH8cGpe2kAtp
	ISmVVyXJFTJKTIj3bslZrc5dL0R/tc6DPO1Z+NDnJuGdxkqAdzyPgPK7dRQEjA9FkNd4lYRn
	zmwCbHdqEfR58xBMThlx0LbOEhDQdYhg3PdeBHoNgllLBwKDXYdDj+0xDnXNGgx+NcxQ4Hky
	hkA/4KagZEhDwKj5IoKyQaMIhp7ugpG+NhJmXV8wcE4MIzC7ZzBwW3MRBAyJcK26KRg3/KBg
	qqsbhxK9DcH1ARcOY0P9CJo7PiKw3M6m4HPxfRwc7nnwxjtKQaf+AgUj9nIMvjdQUJVtIcH+
	0oOgwqhDMNhrwSDnxl0KDBWNBLT2PxKB3TONwQeDDoPaxj3QZx4k4EVxNRY8Nzh1bwEYS3Kw
	YPmKgb6+DQOfuUa0zYS4SW0hwdU0PcA47esAxdVV1iFuyq9D3LgpB+e0xcH2yfAozp1rSudM
	L4Ypzu99S3GWiSqCe17NcjfP+zHuUtdqrrXMJdoXGyeOOcYrhDRetXbrUXGCI+AnUz5FZox+
	LCCykInNR2E0y2xk689Xiv5qilnO9vT48L86glnCNhUMkvlITOOMYzGb6ysMGfMZni2/8i0U
	IJhlrNfpCXEJs5n9eauX+rd0MVvbYA3xsCDXO/0hLWU2sdfyJ8liJK5Cc2pQhJCUppQLik1r
	1IkJmUlCxpr4ZGUjCv6T+fT0pRY07tjVjhgayeZKrOnrBCkpT1NnKtsRS+OyCMmwIlqQSo7J
	M0/yquQjqhMKXt2OFtGEbIFk9wH+qJQ5Lk/lE3k+hVf9dzE6bGEWshzOmLDEHhcKpk/cj+l+
	WFi2YYcp+/ISl+9df1T4mbiE3wM7iqoziravOjIWV7T0YvNkVn1vvG95aaTnW+erzfG/04Sd
	j1qe3oq64kgdGslvO5B50KSMfnNopsu0Ni71qnlamRxT2qI2O7u9tm7XfqMmnV6199TKiMdE
	zA17abgtUUaoE+TrVuAqtfwPz1lkY0sDAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

With multi event sites for a single wait, dept allows to skip tracking
an event that is recoverable by other recover paths.

Introduce an API, event_site(), to skip tracking the event in the case.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept.h     | 30 ++++++++++++++++++++++++++++++
 include/linux/sched.h    |  6 ++++++
 kernel/dependency/dept.c | 20 ++++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/include/linux/dept.h b/include/linux/dept.h
index c796cdceb04e..7b822caee874 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -239,6 +239,31 @@ extern void dept_task_exit(struct task_struct *t);
 extern void dept_free_range(void *start, unsigned int sz);
 extern void dept_mark_event_site_used(void *start, void *end);
 
+extern void disable_event_track(void);
+extern void enable_event_track(void);
+
+#define event_site(es, evt_func, ...)					\
+do {									\
+	unsigned long _flags;						\
+	bool _disable;							\
+									\
+	local_irq_save(_flags);						\
+	dept_event_site_used(es);					\
+	/*								\
+	 * If !list_empty(&(es)->dept_head), the event site can be	\
+	 * recovered by others.  Do not track event dependency if so.	\
+	 */								\
+	_disable = !list_empty(&(es)->dep_head);			\
+	if (_disable)							\
+		disable_event_track();					\
+									\
+	evt_func(__VA_ARGS__);						\
+									\
+	if (_disable)							\
+		enable_event_track();					\
+	local_irq_restore(_flags);					\
+} while (0)
+
 extern void dept_map_init(struct dept_map *m, struct dept_key *k, int sub_u, const char *n);
 extern void dept_map_reinit(struct dept_map *m, struct dept_key *k, int sub_u, const char *n);
 extern void dept_ext_wgen_init(struct dept_ext_wgen *ewg);
@@ -302,6 +327,11 @@ struct dept_event_site { };
 #define dept_task_exit(t)				do { } while (0)
 #define dept_free_range(s, sz)				do { } while (0)
 #define dept_mark_event_site_used(s, e)			do { } while (0)
+#define event_site(es, evt_func, ...)					\
+do {									\
+	(void)(es);							\
+	evt_func(__VA_ARGS__);						\
+} while (0)
 
 #define dept_map_init(m, k, su, n)			do { (void)(n); (void)(k); } while (0)
 #define dept_map_reinit(m, k, su, n)			do { (void)(n); (void)(k); } while (0)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 5834555a3d09..a1737631ff54 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -879,6 +879,11 @@ struct dept_task {
 	 */
 	int				missing_ecxt;
 
+	/*
+	 * not to track events
+	 */
+	int				disable_event_track_cnt;
+
 	/*
 	 * for tracking IRQ-enable state
 	 */
@@ -916,6 +921,7 @@ struct dept_task {
 	.stage_wait_stack = NULL,				\
 	.stage_lock = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED,\
 	.missing_ecxt = 0,					\
+	.disable_event_track_cnt = 0,				\
 	.hardirqs_enabled = false,				\
 	.softirqs_enabled = false,				\
 	.task_exit = false,					\
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index 07d883579269..3c3ec2701bd6 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -2573,6 +2573,23 @@ static void __dept_wait(struct dept_map *m, unsigned long w_f,
 	}
 }
 
+void disable_event_track(void)
+{
+	dept_task()->disable_event_track_cnt++;
+}
+EXPORT_SYMBOL_GPL(disable_event_track);
+
+void enable_event_track(void)
+{
+	dept_task()->disable_event_track_cnt--;
+}
+EXPORT_SYMBOL_GPL(enable_event_track);
+
+static bool event_track_disabled(void)
+{
+	return !!dept_task()->disable_event_track_cnt;
+}
+
 /*
  * Called between dept_enter() and dept_exit().
  */
@@ -2585,6 +2602,9 @@ static void __dept_event(struct dept_map *m, struct dept_map *real_m,
 	struct dept_key *k;
 	int e;
 
+	if (event_track_disabled())
+		return;
+
 	e = find_first_bit(&e_f, DEPT_MAX_SUBCLASSES_EVT);
 
 	if (DEPT_WARN_ON(e >= DEPT_MAX_SUBCLASSES_EVT))
-- 
2.17.1


