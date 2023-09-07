Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA593798ACE
	for <lists+linux-arch@lfdr.de>; Fri,  8 Sep 2023 18:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245133AbjIHQoj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Sep 2023 12:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244653AbjIHQoi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Sep 2023 12:44:38 -0400
Received: from mail-yw1-x1144.google.com (mail-yw1-x1144.google.com [IPv6:2607:f8b0:4864:20::1144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9250B1FCD;
        Fri,  8 Sep 2023 09:44:34 -0700 (PDT)
Received: by mail-yw1-x1144.google.com with SMTP id 00721157ae682-592976e5b6dso22338147b3.2;
        Fri, 08 Sep 2023 09:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694191473; x=1694796273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qh5+IZUz/0Kl8GWQ4GoTY9C99F+VOAz3Glaap/hxJSs=;
        b=qzoqfQuSJ+ubNrlYZszBj6NvPzgvAB7e6pGF3KTDwEEuXOpN0DDUi5MHIWWaq0ML0p
         gHJtvbTSHnRurBgmyerA2fa00hOSrGBWpvkgDoAagWvpQsTHgdcS7qPeDp3+zylJxOe9
         jQ0+ji8LlgAeZuvhL9YBo3dRwMEl0z5qAPsfYESGday8Vy1z2v16DnQawEO+qyQ4qhJR
         xfZX1Kp15ZLaKJEoLHNhyTHK6NYvzPie8KF6jUJfx7yGTDHMsvegIpo0f8cHU+ANemud
         q9CS5qLqzw+Zmr9SQRbqqa0qLDnHiMpps/FZ+P/Xtgh7CAtAvxFB9Fn9/3oV0EY18xz6
         APSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694191473; x=1694796273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qh5+IZUz/0Kl8GWQ4GoTY9C99F+VOAz3Glaap/hxJSs=;
        b=Qsn+4ChlCi5sJOtRSs1k1eD5jKJ0sUTBQe7Nu9iL3TpWRgkXcc3s0NPH1tXEC9cFpS
         /Hi8TAi5w3CUTgLWJMVtgncE9VAY5UqfZLHbVnqFNmdsCZTY6xngodaUXmZHSmbH2zXL
         GeNVxDe8lTmRQt/s2W+0bJCF13I/hCaaABmba1VMMMmgonyxlRhASqaFJsRTJa7rk2g6
         e5/z2I3zZ/s+pWToGO+PcumPovg0iA060iRoSWJ/qRrVu/Y/tBj5cdi4qHi8UgKCaNN/
         hr4qFmjXWVy9yf7+heVpoAjQNoRWZQseYTQusD7TESmcBnT+VnXQAQSemsqs6ww+78fC
         QsMA==
X-Gm-Message-State: AOJu0Yy+nMu8ZoHqWqy7XqJM7DcKm7TVbeszdRgjHz78kYxa67THyo14
        Ulg0itueTy5I58AdYPS7YtfpKStWel+y
X-Google-Smtp-Source: AGHT+IEsl4emTVdfg2hwUVzyyr8JweQ/Dx4686fO//LivaIWYzDbNvsFc4vVR8EJIa6+NkoJUUa40g==
X-Received: by 2002:a25:aa09:0:b0:d7e:dd21:9b16 with SMTP id s9-20020a25aa09000000b00d7edd219b16mr2747749ybi.8.1694191473598;
        Fri, 08 Sep 2023 09:44:33 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id e66-20020a253745000000b00d7ba7de90casm438858yba.51.2023.09.08.09.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 09:44:33 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-mm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-cxl@vger.kernel.org,
        luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        arnd@arndb.de, akpm@linux-foundation.org, x86@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [RFC PATCH 1/3] mm/migrate: remove unused mm argument from do_move_pages_to_node
Date:   Thu,  7 Sep 2023 03:54:51 -0400
Message-Id: <20230907075453.350554-2-gregory.price@memverge.com>
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

preparatory work to re-use do_move_pages_to_node with a physical
address instead of virtual address.  This function does not actively
use the mm_struct, so it can be removed.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 mm/migrate.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index b7fa020003f3..6ecb1e68c34a 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2026,8 +2026,7 @@ static int store_status(int __user *status, int start, int value, int nr)
 	return 0;
 }
 
-static int do_move_pages_to_node(struct mm_struct *mm,
-		struct list_head *pagelist, int node)
+static int do_move_pages_to_node(struct list_head *pagelist, int node)
 {
 	int err;
 	struct migration_target_control mtc = {
@@ -2123,7 +2122,7 @@ static int add_page_for_migration(struct mm_struct *mm, const void __user *p,
 	return err;
 }
 
-static int move_pages_and_store_status(struct mm_struct *mm, int node,
+static int move_pages_and_store_status(int node,
 		struct list_head *pagelist, int __user *status,
 		int start, int i, unsigned long nr_pages)
 {
@@ -2132,7 +2131,7 @@ static int move_pages_and_store_status(struct mm_struct *mm, int node,
 	if (list_empty(pagelist))
 		return 0;
 
-	err = do_move_pages_to_node(mm, pagelist, node);
+	err = do_move_pages_to_node(pagelist, node);
 	if (err) {
 		/*
 		 * Positive err means the number of failed
@@ -2190,7 +2189,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 			current_node = node;
 			start = i;
 		} else if (node != current_node) {
-			err = move_pages_and_store_status(mm, current_node,
+			err = move_pages_and_store_status(current_node,
 					&pagelist, status, start, i, nr_pages);
 			if (err)
 				goto out;
@@ -2225,7 +2224,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 		if (err)
 			goto out_flush;
 
-		err = move_pages_and_store_status(mm, current_node, &pagelist,
+		err = move_pages_and_store_status(current_node, &pagelist,
 				status, start, i, nr_pages);
 		if (err) {
 			/* We have accounted for page i */
@@ -2237,7 +2236,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 	}
 out_flush:
 	/* Make sure we do not overwrite the existing error */
-	err1 = move_pages_and_store_status(mm, current_node, &pagelist,
+	err1 = move_pages_and_store_status(current_node, &pagelist,
 				status, start, i, nr_pages);
 	if (err >= 0)
 		err = err1;
-- 
2.39.1

