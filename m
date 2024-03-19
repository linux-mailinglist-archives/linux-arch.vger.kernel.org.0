Return-Path: <linux-arch+bounces-3035-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3625B880361
	for <lists+linux-arch@lfdr.de>; Tue, 19 Mar 2024 18:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DC04B214EB
	for <lists+linux-arch@lfdr.de>; Tue, 19 Mar 2024 17:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FB718C22;
	Tue, 19 Mar 2024 17:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfWpJZwv"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oa1-f68.google.com (mail-oa1-f68.google.com [209.85.160.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC6425776;
	Tue, 19 Mar 2024 17:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710869186; cv=none; b=UFdun/kY/GrVrqhMvuo8pC+l+IBCuwJk3InpxEfOEZduGWIvbBfKEhHgKCZvnYflIZCZvSR0jf9TneZHX86jOrZZ6N1fhmDkiN1mPmVroo4fnL4Ox73Ocy8K4Qjz3T0K35fwoje/94InnpyQuXX7TtU0e5JbEWQuX1R4mCXbEyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710869186; c=relaxed/simple;
	bh=qYT9MHaFOgE6lrZ48XEaUc4YveDSVDGuV4lc/tno//I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WFIN2vYzxRJjUVs8MqcI9W7WJuEEaa6VoHK4ApZypMYgfG2iSi46/5SyAPpI2v4ZUNZ9qeRG40UDr5IJwVRZGPhgCwzyiWfogNe3bzbAqrApOwG9i5NWGLXIuAtcLPXb3vKHAD3DNuivDLvXau8MJZrvSReYJycZv+zN1StEHDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfWpJZwv; arc=none smtp.client-ip=209.85.160.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f68.google.com with SMTP id 586e51a60fabf-22195b3a8fbso4203495fac.3;
        Tue, 19 Mar 2024 10:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710869183; x=1711473983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTBDieuF540mEJlMkTXZ9hm5jGiJQwQ7vVCPHWF7qjI=;
        b=ZfWpJZwv6jbdgE0B001kI5sQV4yC/Vr2ck1GEYPZgiGqEqleqXTFXi7BGcgVmtYkAv
         ruQ2iZyRwfvPYE4yVFVBhqEIt3SNLausmaQrC9ZYN3WmIXmOrkNdrzte3v30vzacGJXK
         HNl4tVVhAWqG7KKcqxGfVcBq7ZgbeWEZu8Hqt6N7KECwKm+/MN2YKO25jJjN6FtbqJC8
         bVMWlFYkVj+DOzYyYY0+/5vfoRTi8z8ifi8Ns0LX935ab8FzsXWeuuSwnG5yYWeI37G0
         GBvfFCE65ClqN5atXZPVQ1cn4svtXN5SG1FMJLc9h78VZBFaWkMR1+mtdoij9i/mTCUW
         866g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710869183; x=1711473983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTBDieuF540mEJlMkTXZ9hm5jGiJQwQ7vVCPHWF7qjI=;
        b=TYwME+obtC8ERBw26lYk8pWEhAvg+XEWFTm6Zg50e3OlqVP9DO7VDhu0IUVobt/z8Z
         dZFYtSIVSn52puJUIqFkvXtJpNdLuT7hyti/QJjIrwhHbpb+QUWt0pHmwFIZEitD17AL
         tBVVJKSAdzc+9jPttF0IYPwXyOgk9vwBPSKezaMwp/N3Na6uMsbcH7ulpClzr3P0xFPq
         sL4cIGOV+Ig5vhqWDdkKAvYidmX3nNaEugj2bV8hToyR7RfW5io07ESKooeN1uvslA5R
         dsqyDT95Get3d3La1LlUVQeBT+yDZ29AQhIl7XBHZVZkYly138xkutfYdP2ORoOaDKC0
         VtzA==
X-Forwarded-Encrypted: i=1; AJvYcCXgAGi9msfYeU7f6i5QlZ7SbblCVwuM2ex6vHXo4z1ojdMsL2RSE2q0tvc5H32fYf9TTVmrrITvyt7pjItLxKXbpe/oAuZUBuJ7aJc9tAcT0Ka7VS9JB5HGw87upPqNlF29HRly2MT897KDc4Lnw7ReppNY7H5pb3zc3mKj10SH2aDp9y/f4c2uNg==
X-Gm-Message-State: AOJu0YykAbinMYXsGBqLVYGEP7zbPPGHFnt1jtddy2u/rVA2kskd71o4
	QS+P4bJT2qzBNlxz0Rcc2p+47BGD75Daa7q54pdRQYbbkw6x67E=
X-Google-Smtp-Source: AGHT+IGaf/uHJ6L5pUMmTCczrFA7c5N7kDE89UuogEKnPmdGioB4eNgXxXmIIaoScGX6cDBDJfl0cw==
X-Received: by 2002:a05:6871:33a8:b0:222:1353:ad0f with SMTP id ng40-20020a05687133a800b002221353ad0fmr19460724oac.24.1710869183545;
        Tue, 19 Mar 2024 10:26:23 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id i20-20020aa787d4000000b006e57247f4e5sm10038173pfo.8.2024.03.19.10.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 10:26:23 -0700 (PDT)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-mm@kvack.org
Cc: linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ying.huang@intel.com,
	dan.j.williams@intel.com,
	honggyu.kim@sk.com,
	corbet@lwn.net,
	arnd@arndb.de,
	luto@kernel.org,
	akpm@linux-foundation.org,
	shuah@kernel.org,
	Gregory Price <gregory.price@memverge.com>
Subject: [RFC v3 2/3] mm/migrate: Create move_phys_pages syscall
Date: Tue, 19 Mar 2024 13:26:08 -0400
Message-Id: <20240319172609.332900-3-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240319172609.332900-1-gregory.price@memverge.com>
References: <20240319172609.332900-1-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

The remaining logic is the same as the move_pages syscall. One
change to do_pages_move is made (to check whether an mm_struct is
passed) in order to re-use the existing migration code.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 arch/x86/entry/syscalls/syscall_32.tbl  |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl  |   1 +
 include/linux/syscalls.h                |   5 +
 include/uapi/asm-generic/unistd.h       |   8 +-
 kernel/sys_ni.c                         |   1 +
 mm/migrate.c                            | 206 +++++++++++++++++++++++-
 tools/include/uapi/asm-generic/unistd.h |   8 +-
 7 files changed, 222 insertions(+), 8 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 5f8591ce7f25..250c00281029 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -466,3 +466,4 @@
 459	i386	lsm_get_self_attr	sys_lsm_get_self_attr
 460	i386	lsm_set_self_attr	sys_lsm_set_self_attr
 461	i386	lsm_list_modules	sys_lsm_list_modules
+462	i386	move_phys_pages		sys_move_phys_pages
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 7e8d46f4147f..a928df7c6f52 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -383,6 +383,7 @@
 459	common	lsm_get_self_attr	sys_lsm_get_self_attr
 460	common	lsm_set_self_attr	sys_lsm_set_self_attr
 461	common	lsm_list_modules	sys_lsm_list_modules
+462	common	move_phys_pages		sys_move_phys_pages
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 77eb9b0e7685..575ba9d26e30 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -840,6 +840,11 @@ asmlinkage long sys_move_pages(pid_t pid, unsigned long nr_pages,
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
index 75f00965ab15..13bc8dd16d6b 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -842,8 +842,14 @@ __SYSCALL(__NR_lsm_set_self_attr, sys_lsm_set_self_attr)
 #define __NR_lsm_list_modules 461
 __SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
 
+/* CONFIG_MMU only */
+#ifndef __ARCH_NOMMU
+#define __NR_move_phys_pages 462
+__SYSCALL(__NR_move_phys_pages, sys_move_phys_pages)
+#endif
+
 #undef __NR_syscalls
-#define __NR_syscalls 462
+#define __NR_syscalls 463
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index faad00cce269..254915fd1e2c 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -196,6 +196,7 @@ COND_SYSCALL(migrate_pages);
 COND_SYSCALL(move_pages);
 COND_SYSCALL(set_mempolicy_home_node);
 COND_SYSCALL(cachestat);
+COND_SYSCALL(move_phys_pages);
 
 COND_SYSCALL(perf_event_open);
 COND_SYSCALL(accept4);
diff --git a/mm/migrate.c b/mm/migrate.c
index 27071a07ffbb..7213703441f8 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2182,9 +2182,119 @@ static int move_pages_and_store_status(int node,
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
+	struct rmap_page_ctxt *ctxt = arg;
+#ifdef CONFIG_MEMCG
+	struct task_struct *owner = vma->vm_mm->owner;
+	nodemask_t task_nodes = cpuset_mems_allowed(owner);
+#else
+	nodemask_t task_nodes = node_possible_map;
+#endif
+
+	ctxt->found = true;
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
+	if (!folio)
+		return -ENOENT;
+
+	rmap_walk(folio, &rwc);
+
+	if (!rmctxt.found)
+		err = -ENOENT;
+	else if (!rmctxt.migratable)
+		err = -EFAULT;
+	else if (!rmctxt.node_allowed)
+		err = -EACCES;
+	else
+		err = add_page_for_migration(page, folio, node, pagelist,
+					     migrate_all);
+
+	folio_put(folio);
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
@@ -2226,7 +2336,14 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
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
@@ -2243,10 +2360,17 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 
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
+							  flags & MPOL_MF_MOVE_ALL);
+		else
+			err = add_phys_page_for_migration(p, current_node, &pagelist,
+							  flags & MPOL_MF_MOVE_ALL);
+
 
 		if (err > 0) {
 			/* The page is successfully queued for migration */
@@ -2334,6 +2458,37 @@ static void do_pages_stat_array(struct mm_struct *mm, unsigned long nr_pages,
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
@@ -2376,7 +2531,10 @@ static int do_pages_stat(struct mm_struct *mm, unsigned long nr_pages,
 				break;
 		}
 
-		do_pages_stat_array(mm, chunk_nr, chunk_pages, chunk_status);
+		if (mm)
+			do_pages_stat_array(mm, chunk_nr, chunk_pages, chunk_status);
+		else
+			do_phys_pages_stat_array(chunk_nr, chunk_pages, chunk_status);
 
 		if (copy_to_user(status, chunk_status, chunk_nr * sizeof(*status)))
 			break;
@@ -2449,7 +2607,7 @@ static int kernel_move_pages(pid_t pid, unsigned long nr_pages,
 	nodemask_t task_nodes;
 
 	/* Check flags */
-	if (flags & ~(MPOL_MF_MOVE|MPOL_MF_MOVE_ALL))
+	if (flags & ~(MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
 		return -EINVAL;
 
 	if ((flags & MPOL_MF_MOVE_ALL) && !capable(CAP_SYS_NICE))
@@ -2477,6 +2635,42 @@ SYSCALL_DEFINE6(move_pages, pid_t, pid, unsigned long, nr_pages,
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
+	nodemask_t dummy_nodes;
+
+	if (flags & ~(MPOL_MF_MOVE|MPOL_MF_MOVE_ALL))
+		return -EINVAL;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (!nodes)
+		return do_pages_stat(NULL, nr_pages, pages, status);
+
+	/*
+	 * When the mm argument to do_pages_move is null, the task_nodes
+	 * argument is ignored, so pass in an empty nodemask as a dummy.
+	 */
+	nodes_clear(dummy_nodes);
+	return do_pages_move(NULL, dummy_nodes, nr_pages, pages, nodes, status,
+			     flags);
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
 #ifdef CONFIG_NUMA_BALANCING
 /*
  * Returns true if this is a safe migration target node for misplaced NUMA
diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index 75f00965ab15..13bc8dd16d6b 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -842,8 +842,14 @@ __SYSCALL(__NR_lsm_set_self_attr, sys_lsm_set_self_attr)
 #define __NR_lsm_list_modules 461
 __SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
 
+/* CONFIG_MMU only */
+#ifndef __ARCH_NOMMU
+#define __NR_move_phys_pages 462
+__SYSCALL(__NR_move_phys_pages, sys_move_phys_pages)
+#endif
+
 #undef __NR_syscalls
-#define __NR_syscalls 462
+#define __NR_syscalls 463
 
 /*
  * 32 bit systems traditionally used different
-- 
2.39.1


