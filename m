Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12FF7A6F5A
	for <lists+linux-arch@lfdr.de>; Wed, 20 Sep 2023 01:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjISXU3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Sep 2023 19:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbjISXJo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Sep 2023 19:09:44 -0400
Received: from mail-yw1-x1142.google.com (mail-yw1-x1142.google.com [IPv6:2607:f8b0:4864:20::1142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6EC1AD;
        Tue, 19 Sep 2023 16:09:28 -0700 (PDT)
Received: by mail-yw1-x1142.google.com with SMTP id 00721157ae682-59bdad64411so63541537b3.3;
        Tue, 19 Sep 2023 16:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695164967; x=1695769767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pa2Q4AVd0DaDLynzk11Wz6VXixHJPHsc2evKc7fSPcw=;
        b=ZeM3ElQ1HzVqwFGCEyA0SUPPF9ZYdWj2/KiyTpGR+/UFzkU4LNFrJ4UeJcZw4jZ/kI
         igtg8I7bc8Pw+vIE4aXADggMmcp47VST0Ie3r003trGperGCoHDPxMVEN6cq2+YWO/Wp
         3gKXLFRk2fEmn5SEVtCeBqTVrZc7szn2ceOkrT//IJKQAh5pxx9x0MJ0n7smnpnWV/cK
         5YJutzbePLuCjdLMyJu9+thlyky8hBM+R6fDrDT8iKwQ79UwuEB/Q8HAJ1fHzaSfHs0s
         gsOiYKxHHEOUbv40maSdHWk4jWc5f641aA5KTfytv1Igs9yomtJu/zcRWhavcvoRdCoZ
         eOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695164967; x=1695769767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pa2Q4AVd0DaDLynzk11Wz6VXixHJPHsc2evKc7fSPcw=;
        b=MwHLsg/CWyH78bT9ux0laxU/bg5PRoGSaCDdLDYNK2LyxGa6QsXGm0In3EDyRW6dhG
         T7HlFp1nFLvtpX4F78dWHjERzuY3BFuv0byqo1qxckga32CDlirwyfRXW3wteAev3Lja
         GYvidzhuTRrEFEuUJnftghhneXTzZIyAOxmVT9Y7LhoMTjcx+hhUy1+8U51szv5f3h64
         72Q94qK+xLcnuHFBdTe5VeqsLM/tOB34E0iE2nxkgAhTxierNBshBRUdXKdFnaiFTT6i
         eSh+Z5EKOE8l1ufARXq1qMz7EAq/45Z1WSZyjimoc38SocN+UNRLQDZl8/vAM4h2Iso1
         +qhg==
X-Gm-Message-State: AOJu0YwKxkYOS6zY1F+SEa+POy4fkSV+dlVJ+Yj65BM72Ky0UeF2v1Bp
        18BIj9OGl7YTfVq/HCnY5l2ZYwY8nS9y
X-Google-Smtp-Source: AGHT+IGV77ydPvrd8A2C/TIshOrtA5AnbkhQb1go4Fx2aV9oB3tXj2vcrD4ihARZeHawWvBSBWBMXQ==
X-Received: by 2002:a81:9106:0:b0:59e:7f14:4b48 with SMTP id i6-20020a819106000000b0059e7f144b48mr878908ywg.41.1695164966663;
        Tue, 19 Sep 2023 16:09:26 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d128-20020a0df486000000b005925765aa30sm3476327ywf.135.2023.09.19.16.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 16:09:26 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-mm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-cxl@vger.kernel.org,
        luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        arnd@arndb.de, akpm@linux-foundation.org, x86@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [RFC v2 2/5] mm/migrate: remove unused mm argument from do_move_pages_to_node
Date:   Tue, 19 Sep 2023 19:09:05 -0400
Message-Id: <20230919230909.530174-3-gregory.price@memverge.com>
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

preparatory work to re-use do_move_pages_to_node with a physical
address instead of virtual address.  This function does not actively
use the mm_struct, so it can be removed.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 mm/migrate.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index a0b0c5a7f8a5..dbe436163d65 100644
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
@@ -2200,7 +2199,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 			current_node = node;
 			start = i;
 		} else if (node != current_node) {
-			err = move_pages_and_store_status(mm, current_node,
+			err = move_pages_and_store_status(current_node,
 					&pagelist, status, start, i, nr_pages);
 			if (err)
 				goto out;
@@ -2235,7 +2234,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 		if (err)
 			goto out_flush;
 
-		err = move_pages_and_store_status(mm, current_node, &pagelist,
+		err = move_pages_and_store_status(current_node, &pagelist,
 				status, start, i, nr_pages);
 		if (err) {
 			/* We have accounted for page i */
@@ -2247,7 +2246,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
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

