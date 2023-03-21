Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BA96C26EB
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 02:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjCUBIk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Mar 2023 21:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjCUBII (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2023 21:08:08 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD643770F;
        Mon, 20 Mar 2023 18:06:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C9BB0CE16A5;
        Tue, 21 Mar 2023 01:05:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A2AC433AC;
        Tue, 21 Mar 2023 01:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679360751;
        bh=f6IKxMTaJcICYTISs9nF6sa539njknB8QuXY3B+9jxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BzEo2pxkp8bTVwQTzlbRxIRAaeL9v/YByMGmliGd+fVuZVP1OIxxSY4Yk3h/OUh0a
         9y4J6PvlU00C5eDhS+xUTgYzRVqlfuVft67nKZQeJjzKcPYi4mFX/kXiglTYcqAV4y
         MzSQWD0Fs09v5diigGUnk4/s98BspjsWh658boFd6msiY3qt/HW+IF/4PbDcA7fjXQ
         w5aHpa0VX68FNK+U3nC3gb7t9kysvOCOEoJMJFqwneuD6mvC8zlRhRv6F7doIkQ+0y
         f7REsCg0kSgPOJ7VEtJLXzN9Y0SUpXLhm3Y8if9HWgm/9iKhA0450PIE9CHRoj6N8d
         yMwo+J90Fo6gQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 922FE15403B1; Mon, 20 Mar 2023 18:05:50 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model scripts 13/31] tools/memory-model: Split runlitmus.sh out of checklitmus.sh
Date:   Mon, 20 Mar 2023 18:05:31 -0700
Message-Id: <20230321010549.51296-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <4e5839bb-e980-4931-a550-3548d025a32a@paulmck-laptop>
References: <4e5839bb-e980-4931-a550-3548d025a32a@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This commit prepares for adding --hw capability to github litmus-test
scripts by splitting runlitmus.sh (which simply runs the verification)
out of checklitmus.sh (which also judges the results).

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/scripts/checklitmus.sh | 57 ++-----------------
 tools/memory-model/scripts/runlitmus.sh   | 69 +++++++++++++++++++++++
 2 files changed, 73 insertions(+), 53 deletions(-)
 create mode 100755 tools/memory-model/scripts/runlitmus.sh

diff --git a/tools/memory-model/scripts/checklitmus.sh b/tools/memory-model/scripts/checklitmus.sh
index 42ff11869cd6..4c1d0cf0ddad 100755
--- a/tools/memory-model/scripts/checklitmus.sh
+++ b/tools/memory-model/scripts/checklitmus.sh
@@ -1,15 +1,8 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0+
 #
-# Run a herd7 test and invokes judgelitmus.sh to check the result against
-# a "Result:" comment within the litmus test.  It also outputs verification
-# results to a file whose name is that of the specified litmus test, but
-# with ".out" appended.
-#
-# If the --hw argument is specified, this script translates the .litmus
-# C-language file to the specified type of assembly and verifies that.
-# But in this case, litmus tests using complex synchronization (such as
-# locking, RCU, and SRCU) are cheerfully ignored.
+# Invokes runlitmus.sh and judgelitmus.sh on its arguments to run the
+# specified litmus test and pass judgment on the results.
 #
 # Usage:
 #	checklitmus.sh file.litmus
@@ -22,47 +15,5 @@
 #
 # Author: Paul E. McKenney <paulmck@linux.ibm.com>
 
-litmus=$1
-if test -f "$litmus" -a -r "$litmus"
-then
-	:
-else
-	echo ' --- ' error: \"$litmus\" is not a readable file
-	exit 255
-fi
-
-if test -z "$LKMM_HW_MAP_FILE"
-then
-	# LKMM run
-	herdoptions=${LKMM_HERD_OPTIONS--conf linux-kernel.cfg}
-	echo Herd options: $herdoptions > $LKMM_DESTDIR/$litmus.out
-	/usr/bin/time $LKMM_TIMEOUT_CMD herd7 $herdoptions $litmus >> $LKMM_DESTDIR/$litmus.out 2>&1
-else
-	# Hardware run
-
-	T=/tmp/checklitmushw.sh.$$
-	trap 'rm -rf $T' 0 2
-	mkdir $T
-
-	# Generate filenames
-	catfile="`echo $LKMM_HW_MAP_FILE | tr '[A-Z]' '[a-z]'`.cat"
-	mapfile="Linux2${LKMM_HW_MAP_FILE}.map"
-	themefile="$T/${LKMM_HW_MAP_FILE}.theme"
-	herdoptions="-model $LKMM_HW_CAT_FILE"
-	hwlitmus=`echo $litmus | sed -e 's/\.litmus$/.'${LKMM_HW_MAP_FILE}'.litmus/'`
-	hwlitmusfile=`echo $hwlitmus | sed -e 's,^.*/,,'`
-
-	# Don't run on litmus tests with complex synchronization
-	if ! scripts/simpletest.sh $litmus
-	then
-		echo ' --- ' error: \"$litmus\" contains locking, RCU, or SRCU
-		exit 254
-	fi
-
-	# Generate the assembly code and run herd7 on it.
-	gen_theme7 -n 10 -map $mapfile -call Linux.call > $themefile
-	jingle7 -theme $themefile $litmus > $T/$hwlitmusfile 2> $T/$hwlitmusfile.jingle7.out
-	/usr/bin/time $LKMM_TIMEOUT_CMD herd7 -model $catfile $T/$hwlitmusfile > $LKMM_DESTDIR/$hwlitmus.out 2>&1
-fi
-
-scripts/judgelitmus.sh $litmus
+scripts/runlitmus.sh $1
+scripts/judgelitmus.sh $1
diff --git a/tools/memory-model/scripts/runlitmus.sh b/tools/memory-model/scripts/runlitmus.sh
new file mode 100755
index 000000000000..91af859c0e90
--- /dev/null
+++ b/tools/memory-model/scripts/runlitmus.sh
@@ -0,0 +1,69 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Without the -hw argument, runs a herd7 test and outputs verification
+# results to a file whose name is that of the specified litmus test,
+# but with ".out" appended.
+#
+# If the --hw argument is specified, this script translates the .litmus
+# C-language file to the specified type of assembly and verifies that.
+# But in this case, litmus tests using complex synchronization (such as
+# locking, RCU, and SRCU) are cheerfully ignored.
+#
+# Either way, return the status of the herd7 command.
+#
+# Usage:
+#	runlitmus.sh file.litmus
+#
+# Run this in the directory containing the memory model, specifying the
+# pathname of the litmus test to check.  The caller is expected to have
+# properly set up the LKMM environment variables.
+#
+# Copyright IBM Corporation, 2019
+#
+# Author: Paul E. McKenney <paulmck@linux.ibm.com>
+
+litmus=$1
+if test -f "$litmus" -a -r "$litmus"
+then
+	:
+else
+	echo ' --- ' error: \"$litmus\" is not a readable file
+	exit 255
+fi
+
+if test -z "$LKMM_HW_MAP_FILE"
+then
+	# LKMM run
+	herdoptions=${LKMM_HERD_OPTIONS--conf linux-kernel.cfg}
+	echo Herd options: $herdoptions > $LKMM_DESTDIR/$litmus.out
+	/usr/bin/time $LKMM_TIMEOUT_CMD herd7 $herdoptions $litmus >> $LKMM_DESTDIR/$litmus.out 2>&1
+else
+	# Hardware run
+
+	T=/tmp/checklitmushw.sh.$$
+	trap 'rm -rf $T' 0 2
+	mkdir $T
+
+	# Generate filenames
+	catfile="`echo $LKMM_HW_MAP_FILE | tr '[A-Z]' '[a-z]'`.cat"
+	mapfile="Linux2${LKMM_HW_MAP_FILE}.map"
+	themefile="$T/${LKMM_HW_MAP_FILE}.theme"
+	herdoptions="-model $LKMM_HW_CAT_FILE"
+	hwlitmus=`echo $litmus | sed -e 's/\.litmus$/.'${LKMM_HW_MAP_FILE}'.litmus/'`
+	hwlitmusfile=`echo $hwlitmus | sed -e 's,^.*/,,'`
+
+	# Don't run on litmus tests with complex synchronization
+	if ! scripts/simpletest.sh $litmus
+	then
+		echo ' --- ' error: \"$litmus\" contains locking, RCU, or SRCU
+		exit 254
+	fi
+
+	# Generate the assembly code and run herd on it.
+	gen_theme7 -n 10 -map $mapfile -call Linux.call > $themefile
+	jingle7 -theme $themefile $litmus > $T/$hwlitmusfile 2> $T/$hwlitmusfile.jingle7.out
+	/usr/bin/time $LKMM_TIMEOUT_CMD herd7 -model $catfile $T/$hwlitmusfile > $LKMM_DESTDIR/$hwlitmus.out 2>&1
+fi
+
+exit $?
-- 
2.40.0.rc2

