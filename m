Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979446C26D0
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 02:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjCUBGr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Mar 2023 21:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjCUBGl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2023 21:06:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B2E14E8F;
        Mon, 20 Mar 2023 18:06:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 002B3618FF;
        Tue, 21 Mar 2023 01:05:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D62C433A4;
        Tue, 21 Mar 2023 01:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679360751;
        bh=7pEQrOhNcu3wqlvdXQU+oZMNW/oN3RZB/RgwhFCuORI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hplD/jZ5c53bYUq+Va4ebP06sIodznegbn6PLGl5HL26jEwlEDqWqglx9cqVz49k+
         TqpdW3oGBpzbWUKx7oiahcQBG2JUj3it3AEal/hn70yEOMhGM03adpx73dmyzr9gYz
         PNZUmkyEN9YRiHedybItmM/dp96eJXO+igUexO9+hzuyzTCk3NJ9o5OdrmqjeItgzO
         kYKDGbzChSqMlS6o/D2qugoVwYjE6DLIYsmOdaKxs9CcQ3jGb9Q9mQYWxvfiVUvH6U
         Qhl1zt9Z1O2YoRNb/UebXo1cuwfmD1XalXUhzJ5AruQ2jKrgg32613Lu8JEj1yXqri
         7g3DeeRNfifqw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7652E15403A3; Mon, 20 Mar 2023 18:05:50 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model scripts 06/31] tools/memory-model: Fix paulmck email address on pre-existing scripts
Date:   Mon, 20 Mar 2023 18:05:24 -0700
Message-Id: <20230321010549.51296-6-paulmck@kernel.org>
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

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/scripts/checkalllitmus.sh  | 2 +-
 tools/memory-model/scripts/checklitmus.sh     | 2 +-
 tools/memory-model/scripts/checklitmushist.sh | 2 +-
 tools/memory-model/scripts/judgelitmus.sh     | 2 +-
 tools/memory-model/scripts/newlitmushist.sh   | 2 +-
 tools/memory-model/scripts/parseargs.sh       | 2 +-
 tools/memory-model/scripts/runlitmushist.sh   | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/memory-model/scripts/checkalllitmus.sh b/tools/memory-model/scripts/checkalllitmus.sh
index 3c0c7fbbd223..10e14d94acee 100755
--- a/tools/memory-model/scripts/checkalllitmus.sh
+++ b/tools/memory-model/scripts/checkalllitmus.sh
@@ -17,7 +17,7 @@
 #
 # Copyright IBM Corporation, 2018
 #
-# Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+# Author: Paul E. McKenney <paulmck@linux.ibm.com>
 
 . scripts/parseargs.sh
 
diff --git a/tools/memory-model/scripts/checklitmus.sh b/tools/memory-model/scripts/checklitmus.sh
index 11461ed40b5e..638b8c610894 100755
--- a/tools/memory-model/scripts/checklitmus.sh
+++ b/tools/memory-model/scripts/checklitmus.sh
@@ -15,7 +15,7 @@
 #
 # Copyright IBM Corporation, 2018
 #
-# Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+# Author: Paul E. McKenney <paulmck@linux.ibm.com>
 
 litmus=$1
 herdoptions=${LKMM_HERD_OPTIONS--conf linux-kernel.cfg}
diff --git a/tools/memory-model/scripts/checklitmushist.sh b/tools/memory-model/scripts/checklitmushist.sh
index 1d210ffb7c8a..406ecfc0aee4 100755
--- a/tools/memory-model/scripts/checklitmushist.sh
+++ b/tools/memory-model/scripts/checklitmushist.sh
@@ -12,7 +12,7 @@
 #
 # Copyright IBM Corporation, 2018
 #
-# Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+# Author: Paul E. McKenney <paulmck@linux.ibm.com>
 
 . scripts/parseargs.sh
 
diff --git a/tools/memory-model/scripts/judgelitmus.sh b/tools/memory-model/scripts/judgelitmus.sh
index 84c62eee321b..d82133e75580 100755
--- a/tools/memory-model/scripts/judgelitmus.sh
+++ b/tools/memory-model/scripts/judgelitmus.sh
@@ -13,7 +13,7 @@
 #
 # Copyright IBM Corporation, 2018
 #
-# Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+# Author: Paul E. McKenney <paulmck@linux.ibm.com>
 
 litmus=$1
 
diff --git a/tools/memory-model/scripts/newlitmushist.sh b/tools/memory-model/scripts/newlitmushist.sh
index 991f8f814881..3f4b06e29988 100755
--- a/tools/memory-model/scripts/newlitmushist.sh
+++ b/tools/memory-model/scripts/newlitmushist.sh
@@ -12,7 +12,7 @@
 #
 # Copyright IBM Corporation, 2018
 #
-# Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+# Author: Paul E. McKenney <paulmck@linux.ibm.com>
 
 . scripts/parseargs.sh
 
diff --git a/tools/memory-model/scripts/parseargs.sh b/tools/memory-model/scripts/parseargs.sh
index 40f52080fdbd..afe7bd23de6b 100755
--- a/tools/memory-model/scripts/parseargs.sh
+++ b/tools/memory-model/scripts/parseargs.sh
@@ -9,7 +9,7 @@
 #
 # Copyright IBM Corporation, 2018
 #
-# Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+# Author: Paul E. McKenney <paulmck@linux.ibm.com>
 
 T=/tmp/parseargs.sh.$$
 mkdir $T
diff --git a/tools/memory-model/scripts/runlitmushist.sh b/tools/memory-model/scripts/runlitmushist.sh
index 6ed376f495bb..852786fef179 100755
--- a/tools/memory-model/scripts/runlitmushist.sh
+++ b/tools/memory-model/scripts/runlitmushist.sh
@@ -13,7 +13,7 @@
 #
 # Copyright IBM Corporation, 2018
 #
-# Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+# Author: Paul E. McKenney <paulmck@linux.ibm.com>
 
 T=/tmp/runlitmushist.sh.$$
 trap 'rm -rf $T' 0
-- 
2.40.0.rc2

