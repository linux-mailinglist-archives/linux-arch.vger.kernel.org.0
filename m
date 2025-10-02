Return-Path: <linux-arch+bounces-13872-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C2EBB325D
	for <lists+linux-arch@lfdr.de>; Thu, 02 Oct 2025 10:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23598426A45
	for <lists+linux-arch@lfdr.de>; Thu,  2 Oct 2025 08:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9669315D42;
	Thu,  2 Oct 2025 08:14:14 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C22312803;
	Thu,  2 Oct 2025 08:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392854; cv=none; b=gOnjTcq2S5gPYSxVw7x+og+bSwsHmdWoX9CBV0XIHVWR4OvTKy/1YZIF7aiQOHoz+60GqJIx8XREZegyiBZMUynH5kXCOl5nYacEqh3TL5i4Cq9Suxwu55SJa3x61J2q1yDCKzT1Lbmy5TCRP6+HXC5pm63NDetFtcZB92vn3nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392854; c=relaxed/simple;
	bh=w4GNFW0UjCDW9ZGy0n3xLi9llnk6RRuW85yoalh47lE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=D1VP5cG0izMJWJ5hZSwbQCP/98uPmXHQKzvd9DjuAedw8yj66kNtTk1UZzbCb6j9HVhebYSNbYyk+p0jwCcfP5xA0yvaVTrrKwftsGPlLDBe9tW/wTwLWm79lKiblUldtMTce70BVKze4ifpec3hMwFzbdKz58p5R0RP0DYcELs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-b5-68de34186bf8
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
Subject: [PATCH v17 43/47] rcu/update: fix same dept key collision between various types of RCU
Date: Thu,  2 Oct 2025 17:12:43 +0900
Message-Id: <20251002081247.51255-44-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251002081247.51255-1-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRjG++9cNoezw1r0L41iMCJJ09B4C7MLRKcPQVAYdMEOeWhDXbJ5
	LSpLLStKi8zQvLNpzhuTUJfRWhaZXaaWjtJE065eyLbl1KzjxC8vD7/3eZ/nyysh5FepVRKN
	NpHXabk4JS0lpWO+ZUErwz6pQ4xjYui5YCXB5cwm4V59DQ32OhMCp+ejGP49eo4gb3CYhn/9
	X0VgHJ4TwbD1MoJvDcIYyX1AQPewHxQV3kKQUVFPw50iMwkm8z4ozM8QwauKPhKM6SrItrhI
	yP7rRNBtuScUWDso6DLZSWgvuE/CW0stBYbeThE0vn5FgPuGP9hvXqfAkTuCoHa8nAaja0IM
	l37PCTbnOAFt9U0imO5vpmC68hkCUycJebPZNFzLuiPUtLkJaPhVSUNmXzjMTAl9Rc5QqP3b
	g3aEsDXFNYh1GjII9unoBMFmNqawho5Rmp12vafZm6+D2JaCfjHbWBXIVrR+F7Flky6KNVdf
	odm+nlaaHX/zRsy+uDtDsi2DW/bjw9KIGD5Ok8zrNkYel6pL2ruohJrI1FGTm0pHdSFXkY8E
	M2F4tPcisahbap3UvKaZddjh8Hi5glmLG69/8XKC6QjAPZ0b5vUyJhrby21eTjIq/KFzVjSv
	Zcxm/KPUQC5krsGmBqs3x0fg3YMdXi5nwnHWRKbglwqefB889KUKLRysxE+qHGQukpWiJdVI
	rtEmx3OauLBgdZpWkxp84lS8GQkfYjw7e6QZTdoP2BAjQUpfmV3Vr5ZTXLI+Ld6GsIRQKmTH
	q/rUclkMl3aa152K1iXF8Xob8peQyhWyTe6UGDlzkkvkY3k+gdctbkUSn1Xp6Jpf9bq0qQgu
	cMnB6jM7d7m3/vl5rBdXWgcKGnIUSSmWwKTYcOvn85N2nNdejG1Du3Yq9MuiylwzTecP3SgJ
	Pnch0/JwinRvLRMfXX+0Lnl7jud2ALdX1RqpKJB2DXgmEn3HQrUvo1VjEUHbzPtXvxtxLN3z
	ePnzoJwov+aXTbs9SlKv5kIDCZ2e+w+M6BGkHQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTcRTH+93nHE0uS+hiRTGyIMoMLA49xJ5eetEfQRBFjry55ZyxmakV
	uHRkbxvMlbNcC5duy9fMslroJMVMcpkWtaUrUyttUJtizmwa/XP4nM/3cDh/HAEubiCjBXJl
	Jq9SShUSSkgI927IX8XGf5TFWR8sg15NEwHBQCEBpdV2CgrrbpLQVWVD0BcsRDA+acRB2zhN
	wJSulYbAxAcapp2tCIrdOhzs9RoMftX8oeB7y08Eet8ABYavGgL8lssISgaNNHx9ngSjfU9I
	mPYOYfB2bASBZeAPBgNN5xFMFadBmdlBwWTnKxwM+i4Ed3xeHIZrwmF960cEzopzFHwpeoBD
	90AkvAn6KWjXX6Jg1F2KwY8aCkznnCTcMuoQ5N+tpqD4Vh0Bjf2PaXB/D2HgKdZhYKvbA32W
	QQI6isxY+L7wVO18MBrysXAZxkB//wkGExYrDS/vegiw5MWAsbObhE8VJTSEfGtg2pQBrbYh
	GrzX9ARUjb4iE/WIG9deJTirowHjtK+nKM5+2464yd86xAXK83FOWxRuW0b8OFfgOMWVd4xQ
	3O9gD8U5x0wE98LMctc7V3GNJV6aK3j2nt63/qBwYwqvkGfxqtUJyUJZWftr8oQ9IXvENkbm
	oaq4iyhCwDLxbOP9ADnDFLOcffduAp/hKGYJ67gyOOtxpmMh2+teOcPzmCNsl9k16wkmhn3v
	DmEzLGLWsd9M5cS/nYtZW03T7J6IsO/2dcx6MbOW1foLsCIkNKE5VhQlV2alS+WKtbHqNFmO
	Up4dezQjvQ6Fv8lyNnT9EQp0J7kQI0CSuSJ3jFcmJqVZ6px0F2IFuCRKlFzhkYlFKdKcXF6V
	cUR1UsGrXWiBgJDMF+08wCeLmVRpJp/G8yd41f8UE0RE5yGrYLCUnWhwZqbAi56ntfQV3z7F
	ouOsvydyyxlNm8FTldu14+FWRXN7f61v26bzvugy/bJ5y1v2+05fDG4ZbtvdckG5dFeqY3vz
	9rbcA5XpMZ8UkVxStt6TUjlEJ/Zeq7zBZ6sNiXtdhzYf7tccGjcnJKTJjmlC9T/u7aj4TIJT
	Qqhl0jUrcJVa+hfREQpeSQMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The current implementation shares the same dept key for multiple
synchronization points, which can lead to false positive reports in
dependency tracking and potential confusion in debugging.  For example,
both normal RCU and tasks trace RCU synchronization points use the same
dept key.  Specifically:

   1. synchronize_rcu() uses a dept key embedded in __wait_rcu_gp():

      synchronize_rcu()
         synchronize_rcu_normal()
            _wait_rcu_gp()
               __wait_rcu_gp() <- the key as static variable

   2. synchronize_rcu_tasks_trace() uses the dept key, too:

      synchronize_rcu_tasks_trace()
         synchronize_rcu_tasks_generic()
            _wait_rcu_gp()
               __wait_rcu_gp() <- the key as static variable

Since the both rely on the same dept key, dept may report false positive
circular dependency.  To resolve this, separate dept keys and maps
should be assigned to each struct rcu_synchronize.

   ===================================================
   DEPT: Circular dependency has been detected.
   6.15.0-rc6-00042-ged94bafc6405 #2 Not tainted
   ---------------------------------------------------
   summary
   ---------------------------------------------------
   *** DEADLOCK ***

   context A
      [S] lock(cpu_hotplug_lock:0)
      [W] __wait_rcu_gp(<sched>:0)
      [E] unlock(cpu_hotplug_lock:0)

   context B
      [S] (unknown)(<sched>:0)
      [W] lock(cpu_hotplug_lock:0)
      [E] try_to_wake_up(<sched>:0)

   [S]: start of the event context
   [W]: the wait blocked
   [E]: the event not reachable
   ---------------------------------------------------
   context A's detail
   ---------------------------------------------------
   context A
      [S] lock(cpu_hotplug_lock:0)
      [W] __wait_rcu_gp(<sched>:0)
      [E] unlock(cpu_hotplug_lock:0)

   [S] lock(cpu_hotplug_lock:0):
   [<ffff8000802ce964>] cpus_read_lock+0x14/0x20
   stacktrace:
         percpu_down_read.constprop.0+0x88/0x2ec
         cpus_read_lock+0x14/0x20
         cgroup_procs_write_start+0x164/0x634
         __cgroup_procs_write+0xdc/0x4d0
         cgroup_procs_write+0x34/0x74
         cgroup_file_write+0x25c/0x670
         kernfs_fop_write_iter+0x2ec/0x498
         vfs_write+0x574/0xc30
         ksys_write+0x124/0x244
         __arm64_sys_write+0x70/0xa4
         invoke_syscall+0x88/0x2e0
         el0_svc_common.constprop.0+0xe8/0x2e0
         do_el0_svc+0x44/0x60
         el0_svc+0x50/0x188
         el0t_64_sync_handler+0x10c/0x140
         el0t_64_sync+0x198/0x19c

   [W] __wait_rcu_gp(<sched>:0):
   [<ffff8000804ce88c>] __wait_rcu_gp+0x324/0x498
   stacktrace:
         schedule+0xcc/0x348
         schedule_timeout+0x1a4/0x268
         __wait_for_common+0x1c4/0x3f0
         __wait_for_completion_state+0x20/0x38
         __wait_rcu_gp+0x35c/0x498
         synchronize_rcu_normal+0x200/0x218
         synchronize_rcu+0x234/0x2a0
         rcu_sync_enter+0x11c/0x300
         percpu_down_write+0xb4/0x3e0
         cgroup_procs_write_start+0x174/0x634
         __cgroup_procs_write+0xdc/0x4d0
         cgroup_procs_write+0x34/0x74
         cgroup_file_write+0x25c/0x670
         kernfs_fop_write_iter+0x2ec/0x498
         vfs_write+0x574/0xc30
         ksys_write+0x124/0x244

   [E] unlock(cpu_hotplug_lock:0):
   (N/A)
   ---------------------------------------------------
   context B's detail
   ---------------------------------------------------
   context B
      [S] (unknown)(<sched>:0)
      [W] lock(cpu_hotplug_lock:0)
      [E] try_to_wake_up(<sched>:0)

   [S] (unknown)(<sched>:0):
   (N/A)

   [W] lock(cpu_hotplug_lock:0):
   [<ffff8000802ce964>] cpus_read_lock+0x14/0x20
   stacktrace:
         percpu_down_read.constprop.0+0x6c/0x2ec
         cpus_read_lock+0x14/0x20
         check_all_holdout_tasks_trace+0x90/0xa30
         rcu_tasks_wait_gp+0x47c/0x938
         rcu_tasks_one_gp+0x75c/0xef8
         rcu_tasks_kthread+0x180/0x1dc
         kthread+0x3ac/0x74c
         ret_from_fork+0x10/0x20

   [E] try_to_wake_up(<sched>:0):
   [<ffff8000804233b8>] complete+0xb8/0x1e8
   stacktrace:
         try_to_wake_up+0x374/0x1164
         complete+0xb8/0x1e8
         wakeme_after_rcu+0x14/0x20
         rcu_tasks_invoke_cbs+0x218/0xaa8
         rcu_tasks_one_gp+0x834/0xef8
         rcu_tasks_kthread+0x180/0x1dc
         kthread+0x3ac/0x74c
         ret_from_fork+0x10/0x20
   (wait to wake up)
   stacktrace:
         __schedule+0xf64/0x3614
         schedule+0xcc/0x348
         schedule_timeout+0x1a4/0x268
         __wait_for_common+0x1c4/0x3f0
         __wait_for_completion_state+0x20/0x38
         __wait_rcu_gp+0x35c/0x498
         synchronize_rcu_tasks_generic+0x14c/0x220
         synchronize_rcu_tasks_trace+0x24/0x8c
         rcu_init_tasks_generic+0x168/0x194
         do_one_initcall+0x174/0xa00
         kernel_init_freeable+0x744/0x7dc
         kernel_init+0x78/0x220
         ret_from_fork+0x10/0x20

Separating the dept key and map for each of struct rcu_synchronize,
ensuring proper tracking for each execution context.

Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
[ Rewrote the changelog. ]
Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/rcupdate_wait.h | 13 ++++++++-----
 kernel/rcu/rcu.h              |  1 +
 kernel/rcu/update.c           |  5 +++--
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/linux/rcupdate_wait.h b/include/linux/rcupdate_wait.h
index 4c92d4291cce..ee598e70b4bc 100644
--- a/include/linux/rcupdate_wait.h
+++ b/include/linux/rcupdate_wait.h
@@ -19,17 +19,20 @@ struct rcu_synchronize {
 
 	/* This is for debugging. */
 	struct rcu_gp_oldstate oldstate;
+	struct dept_map dmap;
+	struct dept_key dkey;
 };
 void wakeme_after_rcu(struct rcu_head *head);
 
 void __wait_rcu_gp(bool checktiny, unsigned int state, int n, call_rcu_func_t *crcu_array,
-		   struct rcu_synchronize *rs_array);
+		   struct rcu_synchronize *rs_array, struct dept_key *dkey);
 
 #define _wait_rcu_gp(checktiny, state, ...) \
-do {												\
-	call_rcu_func_t __crcu_array[] = { __VA_ARGS__ };					\
-	struct rcu_synchronize __rs_array[ARRAY_SIZE(__crcu_array)];				\
-	__wait_rcu_gp(checktiny, state, ARRAY_SIZE(__crcu_array), __crcu_array, __rs_array);	\
+do {													\
+	call_rcu_func_t __crcu_array[] = { __VA_ARGS__ };						\
+	static struct dept_key __key;									\
+	struct rcu_synchronize __rs_array[ARRAY_SIZE(__crcu_array)];					\
+	__wait_rcu_gp(checktiny, state, ARRAY_SIZE(__crcu_array), __crcu_array, __rs_array, &__key);	\
 } while (0)
 
 #define wait_rcu_gp(...) _wait_rcu_gp(false, TASK_UNINTERRUPTIBLE, __VA_ARGS__)
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 9cf01832a6c3..c0d8ea139596 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -12,6 +12,7 @@
 
 #include <linux/slab.h>
 #include <trace/events/rcu.h>
+#include <linux/dept_sdt.h>
 
 /*
  * Grace-period counter management.
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index c912b594ba98..82292337d5b0 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -409,7 +409,7 @@ void wakeme_after_rcu(struct rcu_head *head)
 EXPORT_SYMBOL_GPL(wakeme_after_rcu);
 
 void __wait_rcu_gp(bool checktiny, unsigned int state, int n, call_rcu_func_t *crcu_array,
-		   struct rcu_synchronize *rs_array)
+		   struct rcu_synchronize *rs_array, struct dept_key *dkey)
 {
 	int i;
 	int j;
@@ -426,7 +426,8 @@ void __wait_rcu_gp(bool checktiny, unsigned int state, int n, call_rcu_func_t *c
 				break;
 		if (j == i) {
 			init_rcu_head_on_stack(&rs_array[i].head);
-			init_completion(&rs_array[i].completion);
+			sdt_map_init_key(&rs_array[i].dmap, dkey);
+			init_completion_dmap(&rs_array[i].completion, &rs_array[i].dmap);
 			(crcu_array[i])(&rs_array[i].head, wakeme_after_rcu);
 		}
 	}
-- 
2.17.1


