Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292CE7A6F2E
	for <lists+linux-arch@lfdr.de>; Wed, 20 Sep 2023 01:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbjISXKB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Sep 2023 19:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbjISXJq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Sep 2023 19:09:46 -0400
Received: from mail-yw1-x1142.google.com (mail-yw1-x1142.google.com [IPv6:2607:f8b0:4864:20::1142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A0C1B9;
        Tue, 19 Sep 2023 16:09:29 -0700 (PDT)
Received: by mail-yw1-x1142.google.com with SMTP id 00721157ae682-59bc97d7b3dso4487777b3.1;
        Tue, 19 Sep 2023 16:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695164968; x=1695769768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLouotyXGn65Q/3Hxsys2lst/s1kpw1SClrVTeQFtkc=;
        b=TGptGmlT/N3cQ9n7Jhz7htjuNxuS+DKE1ih2L99YImvZgafvrYWZTfec5VK3M6O7NQ
         LSx9bDe0m1yqFnwaskoXaZTaGJfVKbhbb3D4yHuQE4KnFc8lJHcvuGVWLdLe774f1mYe
         83Zx+knnuHaMrsyIVsvk6VI8rFL2XNv1IrcS6oBK/H/3YiFWZnbUnODfpaXbbdUtR0o9
         X5hGyypUlaYLk0SZB8BVgzZzZQdiaR7mu7P4Xq1mfC8WbUhkxfkZNM8MbHbNUabpY5sk
         skyqQqXjRf4vNrbXuHRN3QuTSRR8v4AJrFnnctUJb2eCxXo4eLVOafX77u8KX+CR1Siq
         /G3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695164968; x=1695769768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLouotyXGn65Q/3Hxsys2lst/s1kpw1SClrVTeQFtkc=;
        b=GdEE6eehsreTyCMlE2C2eCSK0WvD3n+MGXKW/Re2G5Pel6o1aNqHadB1uhiPiIBUYd
         KuOcyGSLA9b09M0p0Ewts+3RDOSbIeeEXfcO9UEuKJkXLYfpzTrCG0AFlThjUWn1OWfF
         YFjx5jBRcPOu3d8MMFLPJo7f0twgwRBa8BySqVC6WMGKdddGRUX8+2shLA6f/HNw9K6u
         sNS5iGgnHVzAX3x9bpw6J6rqigQPelbwAF/S7Nv2UbTtZTzS/OTXL61ArYEbkYV0UHZ1
         SCYs4wRrAZPYBmIVHe05KDjWp1qjCQO2t/rKXBQ120L69JAQODf594Ev7plP7T2vD/7b
         8zng==
X-Gm-Message-State: AOJu0YzR1D31m63x+9FeftBZ9FYIC1Q5d4t6iSzvbJoML2NmD8j4xXa/
        aQKx8pk/RyFDV/H006vcb+kD4Qhsm11X
X-Google-Smtp-Source: AGHT+IF47zIeEsarZk/JZFIFSE3MQxssVw9sGEWuhuP2/NTGCJ+Cj6XHJ/FmmxB/D4g/ZGB8xvzDKw==
X-Received: by 2002:a0d:d4ce:0:b0:56f:fd0a:588d with SMTP id w197-20020a0dd4ce000000b0056ffd0a588dmr5098911ywd.8.1695164968364;
        Tue, 19 Sep 2023 16:09:28 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d128-20020a0df486000000b005925765aa30sm3476327ywf.135.2023.09.19.16.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 16:09:28 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-mm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-cxl@vger.kernel.org,
        luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        arnd@arndb.de, akpm@linux-foundation.org, x86@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [RFC v2 3/5] mm/migrate: refactor add_page_for_migration for code re-use
Date:   Tue, 19 Sep 2023 19:09:06 -0400
Message-Id: <20230919230909.530174-4-gregory.price@memverge.com>
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

add_page_for_migration presently does two actions:
  1) validates the page is present and migratable
  2) isolates the page from LRU and puts it into the migration list

Break add_page_for_migration into 2 functions:
  add_page_for_migration - isolate the page from LUR and add to list
  add_virt_page_for_migration - validate the page and call the above

add_page_for_migration does not require the mm_struct and so can be
re-used for a physical addressing version of move_pages

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 mm/migrate.c | 83 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 50 insertions(+), 33 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index dbe436163d65..1123d841a7f1 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2042,52 +2042,33 @@ static int do_move_pages_to_node(struct list_head *pagelist, int node)
 }
 
 /*
- * Resolves the given address to a struct page, isolates it from the LRU and
- * puts it to the given pagelist.
+ * Isolates the page from the LRU and puts it into the given pagelist
  * Returns:
  *     errno - if the page cannot be found/isolated
  *     0 - when it doesn't have to be migrated because it is already on the
  *         target node
  *     1 - when it has been queued
  */
-static int add_page_for_migration(struct mm_struct *mm, const void __user *p,
-		int node, struct list_head *pagelist, bool migrate_all)
+static int add_page_for_migration(struct page *page, int node,
+		struct list_head *pagelist, bool migrate_all)
 {
-	struct vm_area_struct *vma;
-	unsigned long addr;
-	struct page *page;
 	int err;
 	bool isolated;
 
-	mmap_read_lock(mm);
-	addr = (unsigned long)untagged_addr_remote(mm, p);
-
-	err = -EFAULT;
-	vma = vma_lookup(mm, addr);
-	if (!vma || !vma_migratable(vma))
-		goto out;
-
-	/* FOLL_DUMP to ignore special (like zero) pages */
-	page = follow_page(vma, addr, FOLL_GET | FOLL_DUMP);
-
-	err = PTR_ERR(page);
-	if (IS_ERR(page))
-		goto out;
-
 	err = -ENOENT;
 	if (!page)
 		goto out;
 
 	if (is_zone_device_page(page))
-		goto out_putpage;
+		goto out;
 
 	err = 0;
 	if (page_to_nid(page) == node)
-		goto out_putpage;
+		goto out;
 
 	err = -EACCES;
 	if (page_mapcount(page) > 1 && !migrate_all)
-		goto out_putpage;
+		goto out;
 
 	if (PageHuge(page)) {
 		if (PageHead(page)) {
@@ -2101,7 +2082,7 @@ static int add_page_for_migration(struct mm_struct *mm, const void __user *p,
 		isolated = isolate_lru_page(head);
 		if (!isolated) {
 			err = -EBUSY;
-			goto out_putpage;
+			goto out;
 		}
 
 		err = 1;
@@ -2110,12 +2091,48 @@ static int add_page_for_migration(struct mm_struct *mm, const void __user *p,
 			NR_ISOLATED_ANON + page_is_file_lru(head),
 			thp_nr_pages(head));
 	}
-out_putpage:
-	/*
-	 * Either remove the duplicate refcount from
-	 * isolate_lru_page() or drop the page ref if it was
-	 * not isolated.
-	 */
+out:
+	return err;
+}
+
+/*
+ * Resolves the given address to a struct page, isolates it from the LRU and
+ * puts it to the given pagelist.
+ * Returns:
+ *     errno - if the page cannot be found/isolated
+ *     0 - when it doesn't have to be migrated because it is already on the
+ *         target node
+ *     1 - when it has been queued
+ */
+static int add_virt_page_for_migration(struct mm_struct *mm,
+		const void __user *p, int node, struct list_head *pagelist,
+		bool migrate_all)
+{
+	struct vm_area_struct *vma;
+	unsigned long addr;
+	struct page *page;
+	int err = -EFAULT;
+
+	mmap_read_lock(mm);
+	addr = (unsigned long)untagged_addr_remote(mm, p);
+
+	vma = vma_lookup(mm, addr);
+	if (!vma || !vma_migratable(vma))
+		goto out;
+
+	/* FOLL_DUMP to ignore special (like zero) pages */
+	page = follow_page(vma, addr, FOLL_GET | FOLL_DUMP);
+
+	err = PTR_ERR(page);
+	if (IS_ERR(page))
+		goto out;
+
+	err = -ENOENT;
+	if (!page)
+		goto out;
+
+	err = add_page_for_migration(page, node, pagelist, migrate_all);
+
 	put_page(page);
 out:
 	mmap_read_unlock(mm);
@@ -2211,7 +2228,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 		 * Errors in the page lookup or isolation are not fatal and we simply
 		 * report them via status
 		 */
-		err = add_page_for_migration(mm, p, current_node, &pagelist,
+		err = add_virt_page_for_migration(mm, p, current_node, &pagelist,
 					     flags & MPOL_MF_MOVE_ALL);
 
 		if (err > 0) {
-- 
2.39.1

