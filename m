Return-Path: <linux-arch+bounces-3034-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A734F88035D
	for <lists+linux-arch@lfdr.de>; Tue, 19 Mar 2024 18:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4870E1F23033
	for <lists+linux-arch@lfdr.de>; Tue, 19 Mar 2024 17:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4946922EE8;
	Tue, 19 Mar 2024 17:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyFMNJaI"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oa1-f65.google.com (mail-oa1-f65.google.com [209.85.160.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54F120319;
	Tue, 19 Mar 2024 17:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710869183; cv=none; b=TQWn7pWxyN9Wkh6nceDgra8OT1pUKQoFX96k9Jc2ZpFStUXmIBqGBcav/e7ufgd0yj+UcVy638KYfCiUh+RfBNKjWYK9uDgJtitNvW3cpw1kBA5RZexOEfkATyiSm5jBwlqDNiM3i6J84h/FtME7IgiFq6bb0t0O9P8EWMylS9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710869183; c=relaxed/simple;
	bh=Hr5VhpDIzSvZTgKGyGtzp2VwFfNc3smXgyRFyc4NErM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lXjE5eBrXR673M33S4wzjQLcb1+BsqBujSuOiJ8PFZ8wGba/3f0GXSY9EfsXZSPNKwlTtMkwPCR0ZQDT4Lfn8JpDfJQ0LdR6GZOZryZBjkA0VmfoyIqBlmlL34v1/JTXZ2lG9DxKL1uUmtT3/jFJ5vm/rAq30sh3AeKCG4qOobo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eyFMNJaI; arc=none smtp.client-ip=209.85.160.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f65.google.com with SMTP id 586e51a60fabf-22195b3a8fbso4203463fac.3;
        Tue, 19 Mar 2024 10:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710869181; x=1711473981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eAq3HlkJfm7dGuDaSIp3bS27QlX0O1byv2nkTq/4SUQ=;
        b=eyFMNJaIolk6LmbctJRoNNCCo7nsQwYPRZcMeStL+ynXUtRG7HBQAG1YjOpmmF4CpC
         oHhnsG0EkUo756QTl1cp0DVxyoVOTgBGLyxs1HQdCpKAfPhhZOH3+lG2j65sn6Z8H6lT
         nO//UJ8vfCbaI92UBdBoSQOk6D0YpuDqsbNX/jxz6qhx/dLNSf3+lnuvmWZ48zHr0XmE
         oHrN46eTjXcN5FuB16919BaIqh7B8/IE9G5ynm3WEqmoNq2vTIPzMNkeHB2O1SDeUeyT
         3CVCb5WrBcD78JkiADCcstnEcHXfGJN89QFObCjKeCya4z0kE2beTNryHoeqMTYJbtqa
         VYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710869181; x=1711473981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eAq3HlkJfm7dGuDaSIp3bS27QlX0O1byv2nkTq/4SUQ=;
        b=HCDS7RvRU62b0QB6l03G//SxpYGTp9/0vSIorQyKDmpPN1KlBUZVKEQIGHGqSIK1e9
         Mrm6ccA+L6gVGHCCwFUQcuV2SD3eTAHLbsrRJ3FVq1A75ZIpnk5QkvQJRuwQtk5fStOh
         8riX97gQvT4e17o5ubP6JJxFwMVqBPdFTpxJRTo3Jmva5I4039o5W36LKmVyF3e+SR0O
         SbDuqwDrboYRppbsmHyaODLPqXR1Rz+S+gIet2R5QSXzWZG9mURFGetovIEt631R1KXx
         foikb+7Ay+I3ghN+DOUbWzQYJbQQyHp94x+LXVOKMM/bi7yR/IBWzC6ElHrM/QHpIjf3
         u52Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKgLR6tBBE7aru2xOXty0Bb6aMjzKM6RhKmECJojVXTxbQXnbceVEbth/hKe2JmZB3ULIZxk1u/mBxyAEmxGqqI+OHdESjIPJclMOD2GTQsV+go+Uu+IPUD8SY25Hs/aKe/0LvIcktSWb49zohczChlNkcTkeEn9zDmt3e8rJvAvYh1BFEXOUEmg==
X-Gm-Message-State: AOJu0YzMo3Sp6fzzW1A6kBVKXvV5IapO9oMV5ibuClvnElMPT/c4+gu5
	mlvrIfxWFRkmYd8x+h6l0booxYBfJIpwTgm/IyR71It4/lrdPaI=
X-Google-Smtp-Source: AGHT+IHdLRRa8DiGq1l36i5KjGkKjNLCmYs8Ature6S/Na71QQXF8/ejewsK7UtTnQzrrFmuDArAMw==
X-Received: by 2002:a05:6870:82a4:b0:222:12e4:f5e with SMTP id q36-20020a05687082a400b0022212e40f5emr16795849oae.58.1710869180782;
        Tue, 19 Mar 2024 10:26:20 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id i20-20020aa787d4000000b006e57247f4e5sm10038173pfo.8.2024.03.19.10.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 10:26:20 -0700 (PDT)
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
Subject: [RFC v3 1/3] mm/migrate: refactor add_page_for_migration for code re-use
Date: Tue, 19 Mar 2024 13:26:07 -0400
Message-Id: <20240319172609.332900-2-gregory.price@memverge.com>
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
 mm/migrate.c | 84 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 50 insertions(+), 34 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index c27b1f8097d4..27071a07ffbb 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2066,6 +2066,46 @@ static int do_move_pages_to_node(struct list_head *pagelist, int node)
 	return err;
 }
 
+/*
+ * Isolates the page from the LRU and puts it into the given pagelist
+ * Returns:
+ *     errno - if the page cannot be isolated
+ *     0 - when it doesn't have to be migrated because it is already on the
+ *         target node
+ *     1 - when it has been queued
+ */
+static int add_page_for_migration(struct page *page,
+				  struct folio *folio,
+				  int node,
+				  struct list_head *pagelist,
+				  bool migrate_all)
+{
+	if (folio_is_zone_device(folio))
+		return -ENOENT;
+
+	if (folio_nid(folio) == node)
+		return 0;
+
+	if (page_mapcount(page) > 1 && !migrate_all)
+		return -EACCES;
+
+	if (folio_test_hugetlb(folio)) {
+		if (isolate_hugetlb(folio, pagelist))
+			return 1;
+		return -EBUSY;
+	}
+
+	if (!folio_isolate_lru(folio))
+		return -EBUSY;
+
+	list_add_tail(&folio->lru, pagelist);
+	node_stat_mod_folio(folio,
+		NR_ISOLATED_ANON + folio_is_file_lru(folio),
+		folio_nr_pages(folio));
+
+	return 1;
+}
+
 /*
  * Resolves the given address to a struct page, isolates it from the LRU and
  * puts it to the given pagelist.
@@ -2075,19 +2115,19 @@ static int do_move_pages_to_node(struct list_head *pagelist, int node)
  *         target node
  *     1 - when it has been queued
  */
-static int add_page_for_migration(struct mm_struct *mm, const void __user *p,
-		int node, struct list_head *pagelist, bool migrate_all)
+static int add_virt_page_for_migration(struct mm_struct *mm,
+		const void __user *p, int node, struct list_head *pagelist,
+		bool migrate_all)
 {
 	struct vm_area_struct *vma;
 	unsigned long addr;
 	struct page *page;
 	struct folio *folio;
-	int err;
+	int err = -EFAULT;
 
 	mmap_read_lock(mm);
 	addr = (unsigned long)untagged_addr_remote(mm, p);
 
-	err = -EFAULT;
 	vma = vma_lookup(mm, addr);
 	if (!vma || !vma_migratable(vma))
 		goto out;
@@ -2095,41 +2135,17 @@ static int add_page_for_migration(struct mm_struct *mm, const void __user *p,
 	/* FOLL_DUMP to ignore special (like zero) pages */
 	page = follow_page(vma, addr, FOLL_GET | FOLL_DUMP);
 
-	err = PTR_ERR(page);
-	if (IS_ERR(page))
-		goto out;
-
 	err = -ENOENT;
 	if (!page)
 		goto out;
 
-	folio = page_folio(page);
-	if (folio_is_zone_device(folio))
-		goto out_putfolio;
-
-	err = 0;
-	if (folio_nid(folio) == node)
-		goto out_putfolio;
+	err = PTR_ERR(page);
+	if (IS_ERR(page))
+		goto out;
 
-	err = -EACCES;
-	if (page_mapcount(page) > 1 && !migrate_all)
-		goto out_putfolio;
+	folio = page_folio(page);
+	err = add_page_for_migration(page, folio, node, pagelist, migrate_all);
 
-	err = -EBUSY;
-	if (folio_test_hugetlb(folio)) {
-		if (isolate_hugetlb(folio, pagelist))
-			err = 1;
-	} else {
-		if (!folio_isolate_lru(folio))
-			goto out_putfolio;
-
-		err = 1;
-		list_add_tail(&folio->lru, pagelist);
-		node_stat_mod_folio(folio,
-			NR_ISOLATED_ANON + folio_is_file_lru(folio),
-			folio_nr_pages(folio));
-	}
-out_putfolio:
 	/*
 	 * Either remove the duplicate refcount from folio_isolate_lru()
 	 * or drop the folio ref if it was not isolated.
@@ -2229,7 +2245,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 		 * Errors in the page lookup or isolation are not fatal and we simply
 		 * report them via status
 		 */
-		err = add_page_for_migration(mm, p, current_node, &pagelist,
+		err = add_virt_page_for_migration(mm, p, current_node, &pagelist,
 					     flags & MPOL_MF_MOVE_ALL);
 
 		if (err > 0) {
-- 
2.39.1


