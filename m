Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F0C798AD3
	for <lists+linux-arch@lfdr.de>; Fri,  8 Sep 2023 18:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245167AbjIHQoq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Sep 2023 12:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244177AbjIHQom (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Sep 2023 12:44:42 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDA41FD5;
        Fri,  8 Sep 2023 09:44:37 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id 3f1490d57ef6-d801c83325fso975244276.0;
        Fri, 08 Sep 2023 09:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694191477; x=1694796277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94ZndJQXH4f0WPgl5UOmwjlTxLPyJ6bAw+ixqralC30=;
        b=UhtWvjt9cWI29CWsGiwVYNmScgrBCratVDNO4R8fwlkqrbpNnYQ75UwqB6P/nozVTB
         GtJlLwgQB66L6AxRNGCp1ZlpG/RiydQrAFVNGmcI9HyQgdvY70c0UgQ8Gl4KFM8RcTH5
         zbjE4MIbWWy4zG2Z3MoWztLb81pPnmXE2ZYmBOnz/EvGPgTEBZ0jeo8fZzAnOCGB8F+r
         QLLSVTxEXlkq0VqHVf4mUGq3ofDvxieaVMt6aW6a3WCaad/MThwehFSDTDfrklqXk9nR
         qVlIkXJmJdy+j7NGTeKpBAF2QWBnrzJG1nL9H84aN9i2gC0uxB+7VtWrVMVEDbwrViPJ
         Fxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694191477; x=1694796277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=94ZndJQXH4f0WPgl5UOmwjlTxLPyJ6bAw+ixqralC30=;
        b=Wet/ArkHIBjlTQZS2ez+VqybGgHUZFvb3NEcwT9+0ZvpXSTQWZQl63gQGqrBifm1w8
         2/KvdkOdeattANlbP21cv8W4gnj68+9abZxvC33MUwEptR1hxGDAglCAGcxLVxRhTU9U
         6vTZQdo3IejE+YxP+DH6/KlMYZewXqY9FDaZ3Qt8qEdy8ru/NIB48oHkKiCC97+S8hB5
         +zrMOmfJ84eCW0jEJ84E/V4uK3YsCCknhxbLlWO3D3MV57XHVPVxfG6Yv7E4+u0kmnKp
         rfbnmebGTys+ea9ErAJ3rjSRcrLiPP5IJYI1MpA3CaEl43Zfj4YNkqzDGDkyOB9Xdo8T
         61bw==
X-Gm-Message-State: AOJu0Yxlqr82x9rq/7AwNz0m+HVtZmyGvPRDI557lqGFq7gOYQwj6/ej
        9Pm/U2+arUdTlagFdBr23pVNaQ+6/JV6
X-Google-Smtp-Source: AGHT+IEXVPPbY0ZtvYADM/uaCH+HzpzYokt21eT1sYJm7VNHWg4hLx78Q2VNg1Q4YeCEVBm/zsZ43g==
X-Received: by 2002:a25:aea1:0:b0:cfe:8cbf:5d28 with SMTP id b33-20020a25aea1000000b00cfe8cbf5d28mr2784936ybj.31.1694191476849;
        Fri, 08 Sep 2023 09:44:36 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id e66-20020a253745000000b00d7ba7de90casm438858yba.51.2023.09.08.09.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 09:44:36 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-mm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-cxl@vger.kernel.org,
        luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        arnd@arndb.de, akpm@linux-foundation.org, x86@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [RFC PATCH 3/3] mm/migrate: Create move_phys_pages syscall
Date:   Thu,  7 Sep 2023 03:54:53 -0400
Message-Id: <20230907075453.350554-4-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230907075453.350554-1-gregory.price@memverge.com>
References: <20230907075453.350554-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
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

This is accomplished via an rmap_walk on the folio containing
the page, and interrogating all tasks that map the page.

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
 mm/migrate.c                            | 178 +++++++++++++++++++++++-
 tools/include/uapi/asm-generic/unistd.h |   8 +-
 7 files changed, 197 insertions(+), 5 deletions(-)

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
index 3506b8202937..8a6f1eb6e512 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2161,6 +2161,101 @@ static int move_pages_and_store_status(int node,
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
+	nodemask_t task_nodes = cpuset_mems_allowed(owner);
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
+	if (folio) {
+		rmap_walk(folio, &rwc);
+		folio_put(folio);
+	}
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
+	return err;
+}
+
 /*
  * Migrate an array of page address onto an array of nodes and fill
  * the corresponding array of status.
@@ -2214,8 +2309,13 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 		 * Errors in the page lookup or isolation are not fatal and we simply
 		 * report them via status
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
@@ -2303,6 +2403,36 @@ static void do_pages_stat_array(struct mm_struct *mm, unsigned long nr_pages,
 	mmap_read_unlock(mm);
 }
 
+/*
+ * Determine the nodes of an array of pages and store it in an array of status.
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
@@ -2345,7 +2475,10 @@ static int do_pages_stat(struct mm_struct *mm, unsigned long nr_pages,
 				break;
 		}
 
-		do_pages_stat_array(mm, chunk_nr, chunk_pages, chunk_status);
+		if (mm)
+			do_pages_stat_array(mm, chunk_nr, chunk_pages, chunk_status);
+		else
+			do_phys_pages_stat_array(chunk_nr, chunk_pages, chunk_status);
 
 		if (copy_to_user(status, chunk_status, chunk_nr * sizeof(*status)))
 			break;
@@ -2446,6 +2579,45 @@ SYSCALL_DEFINE6(move_pages, pid_t, pid, unsigned long, nr_pages,
 	return kernel_move_pages(pid, nr_pages, pages, nodes, status, flags);
 }
 
+/*
+ * Move a list of pages in the address space of the currently executing
+ * process.
+ */
+static int kernel_move_phys_pages(unsigned long nr_pages,
+				  const void __user * __user *pages,
+				  const int __user *nodes,
+				  int __user *status, int flags)
+{
+	int err;
+	nodemask_t target_nodes;
+
+	/* Check flags */
+	if (flags & ~(MPOL_MF_MOVE|MPOL_MF_MOVE_ALL))
+		return -EINVAL;
+
+	if ((flags & MPOL_MF_MOVE_ALL) && !capable(CAP_SYS_NICE))
+		return -EPERM;
+
+	/* All tasks mapping each page is checked in phys_page_migratable */
+	nodes_setall(target_nodes);
+	if (nodes)
+		err = do_pages_move(NULL, target_nodes, nr_pages, pages,
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

