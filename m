Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BED6C26E1
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 02:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjCUBH5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Mar 2023 21:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjCUBHQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2023 21:07:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A92235243;
        Mon, 20 Mar 2023 18:06:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 472B261912;
        Tue, 21 Mar 2023 01:05:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D1DDC433B0;
        Tue, 21 Mar 2023 01:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679360751;
        bh=VGCA+C0ef8eZmvBaYJ92neS/iUXCg6LsBghMzQBbpPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YY/DmIoYUbhumK+97XG71aS+6NywVzT49eNz5WQ46VIuWTq3pdQ8yaQztDxjKanXF
         ovIDbvi/JS+BOuMgPgxFk6rMyNu3ZDYEsWXeTffamw5q7ETxB1BowdmvKzvDvPcjMi
         ARyaFTWZU0L4qa0uPYSJ8NtPQNyX+DMkQQVUHFu/Z93YCtn2LmEx1DRxTdEJj0FddJ
         gfcTr9zPp0iWjhOAM43/97HLW3MSeVrXecigO7zAzuNuD0uUabImJpmBUghdjhavXB
         c1lVBRMsCMKoa6Je2KJL8AzNYyc0LgwMeyIyoC6PvEITPpqdDH6h/KWs/3SJqwB13/
         S84bCLaN7K75g==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 9A00815403B5; Mon, 20 Mar 2023 18:05:50 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model scripts 15/31] tools/memory-model: Move from .AArch64.litmus.out to .litmus.AArch.out
Date:   Mon, 20 Mar 2023 18:05:33 -0700
Message-Id: <20230321010549.51296-15-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <4e5839bb-e980-4931-a550-3548d025a32a@paulmck-laptop>
References: <4e5839bb-e980-4931-a550-3548d025a32a@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When the github scripts see ".litmus.out", they assume that there must be
a corresponding C-language ".litmus" file.  Won't they be disappointed
when they instead see nothing, or, worse yet, the corresponding
assembly-language litmus test?  This commit therefore swaps the hardware
tag with the "litmus" to avoid this sort of disappointment.

This commit also adjusts the .gitignore file so as to avoid adding these
new ".out" files to git.

[ paulmck: Apply Akira Yokosawa feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/litmus-tests/.gitignore | 2 +-
 tools/memory-model/scripts/judgelitmus.sh  | 4 ++--
 tools/memory-model/scripts/runlitmus.sh    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/memory-model/litmus-tests/.gitignore b/tools/memory-model/litmus-tests/.gitignore
index c492a1ddad91..d65462d64816 100644
--- a/tools/memory-model/litmus-tests/.gitignore
+++ b/tools/memory-model/litmus-tests/.gitignore
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-*.litmus.out
+*.out
diff --git a/tools/memory-model/scripts/judgelitmus.sh b/tools/memory-model/scripts/judgelitmus.sh
index fe9131f8eb96..9abda72fe013 100755
--- a/tools/memory-model/scripts/judgelitmus.sh
+++ b/tools/memory-model/scripts/judgelitmus.sh
@@ -6,7 +6,7 @@
 # test ran correctly.  If the --hw argument is omitted, check against the
 # LKMM output, which is assumed to be in file.litmus.out.  If this argument
 # is provided, this is assumed to be a hardware test, and the output is
-# assumed to be in file.HW.litmus.out, where "HW" is the --hw argument.
+# assumed to be in file.litmus.HW.out, where "HW" is the --hw argument.
 # In addition, non-Sometimes verification results will be noted, but
 # forgiven.  Furthermore, if there is no "Result:" comment but there is
 # an LKMM .litmus.out file, the observation in that file will be used
@@ -37,7 +37,7 @@ then
 	lkmmout=
 else
 	litmusout="`echo $litmus |
-		sed -e 's/\.litmus$/.'${LKMM_HW_MAP_FILE}'.litmus/'`.out"
+		sed -e 's/\.litmus$/.litmus.'${LKMM_HW_MAP_FILE}'/'`.out"
 	lkmmout=$litmus.out
 fi
 if test -f "$LKMM_DESTDIR/$litmusout" -a -r "$LKMM_DESTDIR/$litmusout"
diff --git a/tools/memory-model/scripts/runlitmus.sh b/tools/memory-model/scripts/runlitmus.sh
index 2865a9661b07..c84124b32bee 100755
--- a/tools/memory-model/scripts/runlitmus.sh
+++ b/tools/memory-model/scripts/runlitmus.sh
@@ -57,7 +57,7 @@ catfile="`echo $LKMM_HW_MAP_FILE | tr '[A-Z]' '[a-z]'`.cat"
 mapfile="Linux2${LKMM_HW_MAP_FILE}.map"
 themefile="$T/${LKMM_HW_MAP_FILE}.theme"
 herdoptions="-model $LKMM_HW_CAT_FILE"
-hwlitmus=`echo $litmus | sed -e 's/\.litmus$/.'${LKMM_HW_MAP_FILE}'.litmus/'`
+hwlitmus=`echo $litmus | sed -e 's/\.litmus$/.litmus.'${LKMM_HW_MAP_FILE}'/'`
 hwlitmusfile=`echo $hwlitmus | sed -e 's,^.*/,,'`
 
 # Don't run on litmus tests with complex synchronization
-- 
2.40.0.rc2

