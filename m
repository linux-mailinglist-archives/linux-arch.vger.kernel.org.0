Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5B47A6F39
	for <lists+linux-arch@lfdr.de>; Wed, 20 Sep 2023 01:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbjISXKG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Sep 2023 19:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233808AbjISXJr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Sep 2023 19:09:47 -0400
Received: from mail-yw1-x1141.google.com (mail-yw1-x1141.google.com [IPv6:2607:f8b0:4864:20::1141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A804CC1;
        Tue, 19 Sep 2023 16:09:31 -0700 (PDT)
Received: by mail-yw1-x1141.google.com with SMTP id 00721157ae682-59ed7094255so10861117b3.3;
        Tue, 19 Sep 2023 16:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695164970; x=1695769770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAAOThTNxxDaTKwUuAmUnX6Mus9LanSm8SFJZWT7NOE=;
        b=MniXeIXa2vGRodt2lyRPhgEyTzQTJ9S/TazdGdRy5rjehN+lcqr1+A7mGLz8XnR6l3
         nqvrnjGy1r7hAkQDypQZHVyyEu/WenzXBVaf6b5n55A4832OmwjoKQFr0og75L30cjOJ
         InnfrElw7jMdNv4QRFHAcc2ws4qVPk1yNPr/daXPjwBjyMLdx5k3NZZrr5rCaYs0k25u
         lPriksmkkHgjFJM/pGMSazY5eBlDFYMd4Dr9ZewCKUP0Dtgj1gTjanddGDFH/bIfFHt6
         hXLVZt8tyc4DsBZyiEZ5c/fC4PrISzJZ4V//cXxM5cA+TnpGHsFQ0NvwvxarVRb54QEv
         e7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695164970; x=1695769770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAAOThTNxxDaTKwUuAmUnX6Mus9LanSm8SFJZWT7NOE=;
        b=dLeOzqM+cVdoN+ok52R7m8vm42v4OLu/JdG5wEmMguAVtVpioP2TYFFwKvxtoO25z6
         eaTy92i8zmfyhmjgJIT1C0XSm7bqSKgNx0bx4/4QMXgq1grXGPQYqIp9A1kmj1ye7uQB
         da8/0aNDhGiiXrq4Mp16yKABctIX3FAsHEiouYNLMOFs9E5QTmMeyNEx1humgZ841sR0
         R04X88z8LL4YiTxRK8dFSkB78bPwDpNiC+Kjztxh+8HrLKO2o0l4cbGoX+Z3Y94dUVtp
         tGKkaaLxt1KNn7LFb/X8Ya1xwuH5xDxAXyjdSFtpRS4FAWoqBp9x4eeu62iY1g+L4bzT
         RA5Q==
X-Gm-Message-State: AOJu0Yw+Y61FxQYdtKL1zOzRod7/WWFgvuB99u2y312StTIeoQv5dJ8T
        gbrOdVe96HeVMvFUG+Hf6JPL0u/gxg3b
X-Google-Smtp-Source: AGHT+IELpSbTtQSw9aZCtbMiiRQh32UaN2P3kHIm7eNXHSkBJQ5NEDVRLaBPyt36f3ZrhXNFGHjsxQ==
X-Received: by 2002:a81:d243:0:b0:59b:cde8:fc32 with SMTP id m3-20020a81d243000000b0059bcde8fc32mr939034ywl.46.1695164970047;
        Tue, 19 Sep 2023 16:09:30 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d128-20020a0df486000000b005925765aa30sm3476327ywf.135.2023.09.19.16.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 16:09:29 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-mm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-cxl@vger.kernel.org,
        luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        arnd@arndb.de, akpm@linux-foundation.org, x86@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [RFC v2 4/5] mm/migrate: Create move_phys_pages syscall
Date:   Tue, 19 Sep 2023 19:09:07 -0400
Message-Id: <20230919230909.530174-5-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230919230909.530174-1-gregory.price@memverge.com>
References: <20230919230909.530174-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Similar to the move_pages system call, instead of taking a pid and
list of virtual addresses, this system call takes a list of physical
addresses.

Because there is no task to validate the memory policy against, each
page needs to be interrogated to determine whether the migration is
valid, and all tasks that map it need to be interrogated.

This is accomplished in via a rmap_walk on the folio containing
the page, and an interrogation of all tasks that map the page (by
way of each task's vma).

Each page must be interrogated individually, which should be
considered when using this to migrate shared regions.

The remaining logic is the same as the move_pages syscall. Some
minor changes to do_pages_move are made (to check whether an
mm_struct is passed) in order to re-use the existing migration code.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 arch/x86/entry/syscalls/syscall_32.tbl  |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl  |   1 +
 include/linux/syscalls.h                |   5 +
 include/uapi/asm-generic/unistd.h       |   8 +-
 kernel/sys_ni.c                         |   1 +
 mm/migrate.c                            | 211 +++++++++++++++++++++++-
 tools/include/uapi/asm-generic/unistd.h |   8 +-
 7 files changed, 228 insertions(+), 7 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 2d0b1bd866ea..25db6d71af0c 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -457,3 +457,4 @@
 450	i386	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	i386	cachestat		sys_cachestat
 452	i386	fchmodat2		sys_fchmodat2
+454	i386	move_phys_pages		sys_move_phys_pages
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 1d6eee30eceb..9676f2e7698c 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -375,6 +375,7 @@
 451	common	cachestat		sys_cachestat
 452	common	fchmodat2		sys_fchmodat2
 453	64	map_shadow_stack	sys_map_shadow_stack
+454	common	move_phys_pages		sys_move_phys_pages
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 22bc6bc147f8..6860675a942f 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -821,6 +821,11 @@ asmlinkage long sys_move_pages(pid_t pid, unsigned long nr_pages,
 				const int __user *nodes,
 				int __user *status,
 				int flags);
+asmlinkage long sys_move_phys_pages(unsigned long nr_pages,
+				    const void __user * __user *pages,
+				    const int __user *nodes,
+				    int __user *status,
+				    int flags);
 asmlinkage long sys_rt_tgsigqueueinfo(pid_t tgid, pid_t  pid, int sig,
 		siginfo_t __user *uinfo);
 asmlinkage long sys_perf_event_open(
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index abe087c53b4b..8838fcfaf261 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -823,8 +823,14 @@ __SYSCALL(__NR_cachestat, sys_cachestat)
 #define __NR_fchmodat2 452
 __SYSCALL(__NR_fchmodat2, sys_fchmodat2)
 
+/* CONFIG_MMU only */
+#ifndef __ARCH_NOMMU
+#define __NR_move_phys_pages 454
+__SYSCALL(__NR_move_phys_pages, sys_move_phys_pages)
+#endif
+
 #undef __NR_syscalls
-#define __NR_syscalls 453
+#define __NR_syscalls 455
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index e137c1385c56..07441b10f92a 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -192,6 +192,7 @@ COND_SYSCALL(migrate_pages);
 COND_SYSCALL(move_pages);
 COND_SYSCALL(set_mempolicy_home_node);
 COND_SYSCALL(cachestat);
+COND_SYSCALL(move_phys_pages);
 
 COND_SYSCALL(perf_event_open);
 COND_SYSCALL(accept4);
diff --git a/mm/migrate.c b/mm/migrate.c
index 1123d841a7f1..2d06557c0b80 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2165,9 +2165,118 @@ static int move_pages_and_store_status(int node,
 	return store_status(status, start, node, i - start);
 }
 
+struct rmap_page_ctxt {
+	bool found;
+	bool migratable;
+	bool node_allowed;
+	int node;
+};
+
+/*
+ * Walks each vma mapping a given page and determines if those
+ * vma's are both migratable, and that the target node is within
+ * the allowed cpuset of the owning task.
+ */
+static bool phys_page_migratable(struct folio *folio,
+				 struct vm_area_struct *vma,
+				 unsigned long address,
+				 void *arg)
+{
+	struct rmap_page_ctxt *ctxt = (struct rmap_page_ctxt *)arg;
+	struct task_struct *owner = vma->vm_mm->owner;
+	/* On non-memcg systems, the allowed set is the possible set */
+#ifdef CONFIG_MEMCG
+	nodemask_t task_nodes = cpuset_mems_allowed(owner);
+#else
+	nodemask_t task_nodes = node_possible_map;
+#endif
+
+	ctxt->found |= true;
+	ctxt->migratable &= vma_migratable(vma);
+	ctxt->node_allowed &= node_isset(ctxt->node, task_nodes);
+
+	return ctxt->migratable && ctxt->node_allowed;
+}
+
+static struct folio *phys_migrate_get_folio(struct page *page)
+{
+	struct folio *folio;
+
+	folio = page_folio(page);
+	if (!folio_test_lru(folio) || !folio_try_get(folio))
+		return NULL;
+	if (unlikely(page_folio(page) != folio || !folio_test_lru(folio))) {
+		folio_put(folio);
+		folio = NULL;
+	}
+	return folio;
+}
+
+/*
+ * Validates the physical address is online and migratable.  Walks the folio
+ * containing the page to validate the vma is migratable and the cpuset node
+ * restrictions.  Then calls add_page_for_migration to isolate it from the
+ * LRU and place it into the given pagelist.
+ * Returns:
+ *     errno - if the page is not online, migratable, or can't be isolated
+ *     0 - when it doesn't have to be migrated because it is already on the
+ *         target node
+ *     1 - when it has been queued
+ */
+static int add_phys_page_for_migration(const void __user *p, int node,
+				       struct list_head *pagelist,
+				       bool migrate_all)
+{
+	unsigned long pfn;
+	struct page *page;
+	struct folio *folio;
+	int err;
+	struct rmap_page_ctxt rmctxt = {
+		.found = false,
+		.migratable = true,
+		.node_allowed = true,
+		.node = node
+	};
+	struct rmap_walk_control rwc = {
+		.rmap_one = phys_page_migratable,
+		.arg = &rmctxt
+	};
+
+	pfn = ((unsigned long)p) >> PAGE_SHIFT;
+	page = pfn_to_online_page(pfn);
+	if (!page || PageTail(page))
+		return -ENOENT;
+
+	folio = phys_migrate_get_folio(page);
+	if (folio)
+		rmap_walk(folio, &rwc);
+
+	if (!rmctxt.found)
+		err = -ENOENT;
+	else if (!rmctxt.migratable)
+		err = -EFAULT;
+	else if (!rmctxt.node_allowed)
+		err = -EACCES;
+	else
+		err = add_page_for_migration(page, node, pagelist, migrate_all);
+
+	if (folio)
+		folio_put(folio);
+
+	return err;
+}
+
 /*
  * Migrate an array of page address onto an array of nodes and fill
  * the corresponding array of status.
+ *
+ * When the mm argument is not NULL, task_nodes is expected to be the
+ * cpuset nodemask for the task which owns the mm_struct, and the
+ * values located in (*pages) are expected to be virtual addresses.
+ *
+ * When the mm argument is NULL, the values located at (*pages) are
+ * expected to be physical addresses, and task_nodes is expected to
+ * be empty.
  */
 static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 			 unsigned long nr_pages,
@@ -2181,6 +2290,10 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 	int start, i;
 	int err = 0, err1;
 
+	/* This should never occur in regular operation */
+	if (!mm && nodes_weight(task_nodes) > 0)
+		return -EINVAL;
+
 	lru_cache_disable();
 
 	for (i = start = 0; i < nr_pages; i++) {
@@ -2209,7 +2322,14 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 			goto out_flush;
 
 		err = -EACCES;
-		if (!node_isset(node, task_nodes))
+		/*
+		 * if mm is NULL, then the pages are addressed via physical
+		 * address and the task_nodes structure is empty. Validation
+		 * of migratability is deferred to add_phys_page_for_migration
+		 * where vma's that map the address will have their node_mask
+		 * checked to ensure the requested node bit is set.
+		 */
+		if (mm && !node_isset(node, task_nodes))
 			goto out_flush;
 
 		if (current_node == NUMA_NO_NODE) {
@@ -2226,10 +2346,17 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 
 		/*
 		 * Errors in the page lookup or isolation are not fatal and we simply
-		 * report them via status
+		 * report them via status.
+		 *
+		 * If mm is NULL, then p treated as is a physical address.
 		 */
-		err = add_virt_page_for_migration(mm, p, current_node, &pagelist,
-					     flags & MPOL_MF_MOVE_ALL);
+		if (mm)
+			err = add_virt_page_for_migration(mm, p, current_node, &pagelist,
+						     flags & MPOL_MF_MOVE_ALL);
+		else
+			err = add_phys_page_for_migration(p, current_node, &pagelist,
+					flags & MPOL_MF_MOVE_ALL);
+
 
 		if (err > 0) {
 			/* The page is successfully queued for migration */
@@ -2317,6 +2444,37 @@ static void do_pages_stat_array(struct mm_struct *mm, unsigned long nr_pages,
 	mmap_read_unlock(mm);
 }
 
+/*
+ * Determine the nodes pages pointed to by the physical addresses in the
+ * pages array, and store those node values in the status array
+ */
+static void do_phys_pages_stat_array(unsigned long nr_pages,
+				     const void __user **pages, int *status)
+{
+	unsigned long i;
+
+	for (i = 0; i < nr_pages; i++) {
+		unsigned long pfn = (unsigned long)(*pages) >> PAGE_SHIFT;
+		struct page *page = pfn_to_online_page(pfn);
+		int err = -ENOENT;
+
+		if (!page)
+			goto set_status;
+
+		get_page(page);
+
+		if (!is_zone_device_page(page))
+			err = page_to_nid(page);
+
+		put_page(page);
+set_status:
+		*status = err;
+
+		pages++;
+		status++;
+	}
+}
+
 static int get_compat_pages_array(const void __user *chunk_pages[],
 				  const void __user * __user *pages,
 				  unsigned long chunk_nr)
@@ -2359,7 +2517,10 @@ static int do_pages_stat(struct mm_struct *mm, unsigned long nr_pages,
 				break;
 		}
 
-		do_pages_stat_array(mm, chunk_nr, chunk_pages, chunk_status);
+		if (mm)
+			do_pages_stat_array(mm, chunk_nr, chunk_pages, chunk_status);
+		else
+			do_phys_pages_stat_array(chunk_nr, chunk_pages, chunk_status);
 
 		if (copy_to_user(status, chunk_status, chunk_nr * sizeof(*status)))
 			break;
@@ -2460,6 +2621,46 @@ SYSCALL_DEFINE6(move_pages, pid_t, pid, unsigned long, nr_pages,
 	return kernel_move_pages(pid, nr_pages, pages, nodes, status, flags);
 }
 
+/*
+ * Move a list of physically-addressed pages to the list of target nodes
+ */
+static int kernel_move_phys_pages(unsigned long nr_pages,
+				  const void __user * __user *pages,
+				  const int __user *nodes,
+				  int __user *status, int flags)
+{
+	int err;
+	nodemask_t dummy_nodes;
+
+	if (flags & ~(MPOL_MF_MOVE|MPOL_MF_MOVE_ALL))
+		return -EINVAL;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	/*
+	 * When the mm argument to do_pages_move is null, the task_nodes
+	 * argument is ignored, so pass in an empty nodemask as a dummy.
+	 */
+	nodes_clear(dummy_nodes);
+	if (nodes)
+		err = do_pages_move(NULL, dummy_nodes, nr_pages, pages,
+			nodes, status, flags);
+	else
+		err = do_pages_stat(NULL, nr_pages, pages, status);
+
+	return err;
+}
+
+SYSCALL_DEFINE5(move_phys_pages, unsigned long, nr_pages,
+		const void __user * __user *, pages,
+		const int __user *, nodes,
+		int __user *, status, int, flags)
+{
+	return kernel_move_phys_pages(nr_pages, pages, nodes, status, flags);
+}
+
+
 #ifdef CONFIG_NUMA_BALANCING
 /*
  * Returns true if this is a safe migration target node for misplaced NUMA
diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index fd6c1cb585db..b140ad444946 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -820,8 +820,14 @@ __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
 #define __NR_cachestat 451
 __SYSCALL(__NR_cachestat, sys_cachestat)
 
+/* CONFIG_MMU only */
+#ifndef __ARCH_NOMMU
+#define __NR_move_phys_pages 454
+__SYSCALL(__NR_move_phys_pages, sys_move_phys_pages)
+#endif
+
 #undef __NR_syscalls
-#define __NR_syscalls 452
+#define __NR_syscalls 455
 
 /*
  * 32 bit systems traditionally used different
-- 
2.39.1

