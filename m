Return-Path: <linux-arch+bounces-13857-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CF4BB30CB
	for <lists+linux-arch@lfdr.de>; Thu, 02 Oct 2025 10:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E2AC38387A
	for <lists+linux-arch@lfdr.de>; Thu,  2 Oct 2025 08:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FD430DEC6;
	Thu,  2 Oct 2025 08:14:00 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3A330BB80;
	Thu,  2 Oct 2025 08:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392840; cv=none; b=UapOkQ/MpTJ+lz2APrCx+Ai9PZMH1mfCzTE++rdp91fX6jKs8wqitzkPPQt0QWP6CQO9cPLX8qV1iUAiyjqe8tQOuu86DdGcCaTq6va8uPhzezC2tx4DcK0PzIy311m4bdM5pvi0GP1+VckKttJwO4J8ZMduOXF1qUoh0hEuGyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392840; c=relaxed/simple;
	bh=uxA2pKVGO15yL5SVbzphFFQl8yPZJWX0XsMIhvQNHQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=hXmjn3WCGdRX9VFtncVuo8/G+Ju9L+tKyEvR8434avZGqJgJCU5v3xDpuNrjbciiUY2Q1ITR2dRdevKhU6Ae1qLWaDOM5xCXM7AwWdG2qO6KqK8LUX2ne9YvXitiWKZZpR4oXtYr/c1ZpKJa6u+8otL8xeiSdUWH6KEYCzdlqjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-b3-68de34115f35
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
Subject: [PATCH v17 27/47] locking/lockdep: prevent various lockdep assertions when lockdep_off()'ed
Date: Thu,  2 Oct 2025 17:12:27 +0900
Message-Id: <20251002081247.51255-28-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251002081247.51255-1-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa1CMYRTHe97r7rLjtcKrzGTWhJFymTJnMJgxpueDTOELZmjHvmNXtZpN
	qWZiVxe5NRWRVrpn1SY2ly4iXQwim8sq2tREqSwzpdBFdjO+/eac//93vhwRKTtLu4nUmiOC
	VqMIlTMSSmKfme8t8+1UrRrI4SGxaoqCyfTHLJhu6wkYbBhCcKlfT0FWr4GFT3UnEUxeDIGc
	/AoGxl+8JCGv20ZCrfEEA59T75CQbUhHEF9QzkBVVzULrYMTBJSaA8BwKZ6AjLIaAop1nnDD
	/pKGe7ouFn686SbAdLaXhOTqEQrMPVYaat97QV5SIQWvq68wYKlrpqG8r42Ap1nXKdA/KqAg
	afgPDUmFtwgoMtppeGYbZuH8q1wGMiaSGTDoUxAkN46ScKfpJwv64Y8IEjr8YPyXQ1c2aUVg
	aOpkN6/CpqsmhMfH0hFu+PqdxGMjbxlcO5pL4bQX3rgqy8biXHMkTmi007jCuBwX3O8ncN7Q
	CI3NJacY3GG9z+CH2SYWVxQeD3TfI9mgFELVUYJ25cZgiUqfaKfC22dHP6sbRDpUPOs0Eot4
	zpePHyim/rOlt4VwMsMt5dvafpNOduUW8RXnemknk1zzQt7ausLJczgl/+DM4HSe4jz5jIka
	1slSbi3/QFfG/nN68KU366Y9Ysf8dXfz9C0Z58cnfk9wdCWOjEHMW1L6iX+FBfwjYxuViqS5
	yKUEydSaqDCFOtTXRxWjUUf7HDgcZkaOHymOm9hbiYYsO+sRJ0LymVKLp00loxVRETFh9YgX
	kXJXabCxQyWTKhUxsYL28H5tZKgQUY/cRZR8vnTN6FGljDuoOCKECEK4oP2/JURiNx0i2nFN
	Y6bVo1yc7RLbU/nuhCV1nvaQfYPm2IVvfZ5u7qXPt+zcFtCXv/V9bc+p9l2u0Snr1n/48icY
	gmzt6s/WuxrZwSzjjIuzTy4+5p7tP7ypr3VuXMvuccYrfEC5ryitROkdFK27vKxlyiOy+an/
	lsAd14gxc3jm3KnAJVFFT7bHy6kIlWL1clIbofgLWj1u2B8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0iTcRTG+7/XuZq9LcmXipLhEsSy6MLJIqovvZVdqA9BRDnzbVtOra1M
	A8HbSOw2F5vlLM1qiFrazMhEEyMhbeWy7Lapq6WFs6Fuijm1rejL4XfO8/DwfDgCXPyYXCxQ
	pp7h1akylYQSEsK9m/JWLljXq1g9+WQR9OS0EuDzFhBQWltDQYHlBgldD6oR9PkKEExMmXDQ
	Ns4SMK1vp8E7+YWG2eZ2BEabHoeaRzkYjNXNUDD0fBSBwemioPhnDgEe8yUEJQMmGn6+2AHD
	fU0kzDoGMfgw7kZgds1g4Gq9gGDamAxlFfUUTFnf4FBs6EJw2+nA4UddQHzU3ouguTKXgu+6
	Bhy6XaHwzueh4KXhIgXDtlIMftVRUJ7bTMJNkx5B3p1aCow3LQQ09j+lwTbkx8Bu1GNQbdkD
	feYBAjp1FVigX8D1MBxMxXlYYPzAwHC/CYNJcxUNr+7YCTBnS8Fk7Sbha2UJDX7nGpgtT4P2
	6kEaHFcNBDwYfkNuNSBuQnuF4KrqH2Oc9u00xdXcqkHc1G894rz38nBOqwusz90enMuvP8fd
	63RT3G/fe4prHi8nuI4KliuyruQaSxw0l9/ymd4fd1i4OYlXKdN5deyWBKEiRztMnPq0IKOj
	dQhlI/P8QhQiYJl1bNfAayzIFBPFfvw4iQc5jIlg6y8PkEHGmc6lbI8tJsgLmSS25eLQXz/B
	SFmDv4kOsojZwLZk36f/ZS5nq+ta/+aEBO7dzk4iyGJmPav15GM6JCxHc6pQmDI1PUWmVK1f
	pUlWZKYqM1YdT0uxoMA3mbP8RU+Qt3tHG2IESDJPZJM6FGJSlq7JTGlDrACXhIkSKu0KsShJ
	lnmeV6cdU59V8Zo2tERASMJFuw7xCWJGLjvDJ/P8KV79X8UEIYuz0dr+I0cfbrX74z06edhI
	TOiYceO4PDdKXjg6o9cXvhYljpSmOYWVB2pN8e4G6bLrDd7Efct2WkczX13LkL7YHjehEj77
	5iuMihTFDmqje8LfFmfN9Z8Yc9uLxLBaXpa+7aQg3rXb6rWsOHj6nHhXmTA69C552JL1LjLi
	Q4SkbUZCaBSyNdG4WiP7A0laOYtJAwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

lockdep provides APIs for assertion only if lockdep is enabled at the
moment asserting to avoid unnecessary confusion, using the following
condition, debug_locks && !this_cpu_read(lockdep_recursion).

However, lockdep_{off,on}() are also used for disabling and enabling
lockdep for a simular purpose.  Add !lockdep_recursing(current) that is
updated by lockdep_{off,on}() to the condition so that the assertions
are aware of !__lockdep_enabled if lockdep_off()'ed.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/lockdep.h  |  3 ++-
 kernel/locking/lockdep.c | 10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index ef03d8808c10..c83fe95199db 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -303,6 +303,7 @@ extern void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie);
 	lockdep_assert_once(!current->lockdep_depth)
 
 #define lockdep_recursing(tsk)	((tsk)->lockdep_recursion)
+extern bool lockdep_recursing_current(void);
 
 #define lockdep_pin_lock(l)	lock_pin_lock(&(l)->dep_map)
 #define lockdep_repin_lock(l,c)	lock_repin_lock(&(l)->dep_map, (c))
@@ -630,7 +631,7 @@ DECLARE_PER_CPU(int, hardirqs_enabled);
 DECLARE_PER_CPU(int, hardirq_context);
 DECLARE_PER_CPU(unsigned int, lockdep_recursion);
 
-#define __lockdep_enabled	(debug_locks && !this_cpu_read(lockdep_recursion))
+#define __lockdep_enabled	(debug_locks && !this_cpu_read(lockdep_recursion) && !lockdep_recursing_current())
 
 #define lockdep_assert_irqs_enabled()					\
 do {									\
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index dc97f2753ef8..39b9e3e27c0b 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -6900,3 +6900,13 @@ void lockdep_rcu_suspicious(const char *file, const int line, const char *s)
 	warn_rcu_exit(rcu);
 }
 EXPORT_SYMBOL_GPL(lockdep_rcu_suspicious);
+
+/*
+ * For avoiding header dependency when using (struct task_struct *)current
+ * and lockdep_recursing() at the same time.
+ */
+noinstr bool lockdep_recursing_current(void)
+{
+	return lockdep_recursing(current);
+}
+EXPORT_SYMBOL_GPL(lockdep_recursing_current);
-- 
2.17.1


