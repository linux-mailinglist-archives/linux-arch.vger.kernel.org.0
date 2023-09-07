Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65B7798AD0
	for <lists+linux-arch@lfdr.de>; Fri,  8 Sep 2023 18:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245138AbjIHQoq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Sep 2023 12:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242648AbjIHQok (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Sep 2023 12:44:40 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBFD1FCD;
        Fri,  8 Sep 2023 09:44:36 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id 3f1490d57ef6-d7bbaa8efa7so2118555276.3;
        Fri, 08 Sep 2023 09:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694191475; x=1694796275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pK2+v+bJerZC0QtlWNJlcEIzNzg5GzRuGHa684VAWc=;
        b=joEfwr+uaU3RH5SEOm/0R+Wr1+IFITHnLNM1EISQdOYEXpLkrFFnqvWqkFO79nllXe
         XxelEJUUbt0G+UKxl3JHuaCU9boCSd/VEBbMuWhcCwUpAXBbsyjeXJ3mJj9HQrqahEIj
         syJKprVcLbzk36Ddrl1FWwqtPYG6bYBgSVkHogokHnxUcBIJnKyqLi/yX/MchGSXVJn/
         MxDrs1047IgKLUDxYkcm6VsCEniXbXcrO+RnkR9an3sWd3lnRWAkg6ip7ECD1Xy2Lgz2
         cmRSqziD0VbKy+XGto96aKoDqq7Ecvhh2/RsA52gvZL4cKA4nw+wrdCAFr4EIdhR82hA
         hZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694191475; x=1694796275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6pK2+v+bJerZC0QtlWNJlcEIzNzg5GzRuGHa684VAWc=;
        b=pUojS1Wk0JrAF7yvIdk+3eA0XD8HA1zKQ53OocrDMCgoUsmFs4qE+2pKsrIUfzxmf8
         xvxUnscPaWXXPdR6t42xXh1pfY1lD7OD8susUlJI1X4EVqpo34QLn5yo1Z6XxFIwJyI9
         3yl77AlkM5EU2h+7phO+1ZCNyCw2qyV+XaVQsNKOF+vdgohXT2N1EZ0PzcGAWNiEYIzY
         Ia97kW24ZPNQvi9vwyxUvLLagyLCznL+C/5teT9S2iBeteqdDWNSH8AmQEGU2+VeO90H
         T766380/C5fc3EOOENObxucjH0o1JVsmLNmm28QOenq4Hn5VxZ+5WczVexiEMnKvbdiB
         9NBQ==
X-Gm-Message-State: AOJu0YxzrDPHqKiQNOldOh0vpF0WlgPcRYAZ6BCGz93q9LxAa6Wcppz7
        +bBzD7YfyTo6KhhftvPtIPLVvoOqHLkj
X-Google-Smtp-Source: AGHT+IH8b2tXIVpgN1XyM9kOUwOB6usVT3QdiD3+lKpMNy6cRv1gHeA7bcYf3HIM/r/ufJRyD8H6pA==
X-Received: by 2002:a25:9f87:0:b0:cff:ff4a:8bf with SMTP id u7-20020a259f87000000b00cffff4a08bfmr2469879ybq.36.1694191475316;
        Fri, 08 Sep 2023 09:44:35 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id e66-20020a253745000000b00d7ba7de90casm438858yba.51.2023.09.08.09.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 09:44:35 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-mm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-cxl@vger.kernel.org,
        luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        arnd@arndb.de, akpm@linux-foundation.org, x86@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [RFC PATCH 2/3] mm/migrate: refactor add_page_for_migration for code re-use
Date:   Thu,  7 Sep 2023 03:54:52 -0400
Message-Id: <20230907075453.350554-3-gregory.price@memverge.com>
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
 mm/migrate.c | 79 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 46 insertions(+), 33 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 6ecb1e68c34a..3506b8202937 100644
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
@@ -2110,12 +2091,44 @@ static int add_page_for_migration(struct mm_struct *mm, const void __user *p,
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
+	err = add_page_for_migration(page, node, pagelist, migrate_all);
+
 	put_page(page);
 out:
 	mmap_read_unlock(mm);
@@ -2201,7 +2214,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 		 * Errors in the page lookup or isolation are not fatal and we simply
 		 * report them via status
 		 */
-		err = add_page_for_migration(mm, p, current_node, &pagelist,
+		err = add_virt_page_for_migration(mm, p, current_node, &pagelist,
 					     flags & MPOL_MF_MOVE_ALL);
 
 		if (err > 0) {
-- 
2.39.1

