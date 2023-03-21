Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6F56C26F5
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 02:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjCUBJI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Mar 2023 21:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjCUBI1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2023 21:08:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C323803F;
        Mon, 20 Mar 2023 18:07:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEC586192C;
        Tue, 21 Mar 2023 01:05:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC5AC433A0;
        Tue, 21 Mar 2023 01:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679360751;
        bh=bB0eL5KNMURkMUPp20sEmFSXSRxd5RWy7LGzvhcBn0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EiYb4dum4txHGwuDwlRtR5qm6u9idg+abQi9yZjyrd7m9q40HlHZDl7e+0kCJHxCi
         5lFo68logJ/cQIJ6U9voelpn3n+OY098NLsFkKBDP/Sr7GL/4sy0QrGLO/59FeV5Yx
         N4VNau2TMpQZ+/3I+jB05ePqoFMJ2rkAAQJPjx1vhv6hhVpUlmOxZG7pKoFCsF1vgt
         OM97ceNFSP8aZlUT2mO5Ah+7ISjcAvokM1Dy5yoIpiGZyTlwXuZeTd9p+J1te88iaK
         5309qV406DOyadjpOCLZnG1wrAiBWJfe2t4xGSXye5awiEgsQU/UXFI0yH6NkaQLgC
         LLszCNEb6Bnlw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D38FA15403C9; Mon, 20 Mar 2023 18:05:50 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model scripts 26/31] tools/memory-model: Add checktheselitmus.sh to run specified litmus tests
Date:   Mon, 20 Mar 2023 18:05:44 -0700
Message-Id: <20230321010549.51296-26-paulmck@kernel.org>
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

This commit adds a checktheselitmus.sh script that runs the litmus tests
specified on the command line.  This is useful for verifying fixes to
specific litmus tests.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/scripts/README             |  8 ++++
 .../memory-model/scripts/checktheselitmus.sh  | 43 +++++++++++++++++++
 2 files changed, 51 insertions(+)
 create mode 100755 tools/memory-model/scripts/checktheselitmus.sh

diff --git a/tools/memory-model/scripts/README b/tools/memory-model/scripts/README
index 0e29a52044c1..cc2c4e5be9ec 100644
--- a/tools/memory-model/scripts/README
+++ b/tools/memory-model/scripts/README
@@ -27,6 +27,14 @@ checklitmushist.sh
 checklitmus.sh
 
 	Check a single litmus test against its "Result:" expected result.
+	Not intended to for manual use.
+
+checktheselitmus.sh
+
+	Check the specified list of litmus tests against their "Result:"
+	expected results.  This takes optional parseargs.sh arguments,
+	followed by "--" followed by pathnames starting from the current
+	directory.
 
 cmplitmushist.sh
 
diff --git a/tools/memory-model/scripts/checktheselitmus.sh b/tools/memory-model/scripts/checktheselitmus.sh
new file mode 100755
index 000000000000..10eeb5ecea6d
--- /dev/null
+++ b/tools/memory-model/scripts/checktheselitmus.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Invokes checklitmus.sh on its arguments to run the specified litmus
+# test and pass judgment on the results.
+#
+# Usage:
+#	checktheselitmus.sh -- [ file1.litmus [ file2.litmus ... ] ]
+#
+# Run this in the directory containing the memory model, specifying the
+# pathname of the litmus test to check.  The usual parseargs.sh arguments
+# can be specified prior to the "--".
+#
+# This script is intended for use with pathnames that start from the
+# tools/memory-model directory.  If some of the pathnames instead start at
+# the root directory, they all must do so and the "--destdir /" parseargs.sh
+# argument must be specified prior to the "--".  Alternatively, some other
+# "--destdir" argument can be supplied as long as the needed subdirectories
+# are populated.
+#
+# Copyright IBM Corporation, 2018
+#
+# Author: Paul E. McKenney <paulmck@linux.ibm.com>
+
+. scripts/parseargs.sh
+
+ret=0
+for i in "$@"
+do
+	if scripts/checklitmus.sh $i
+	then
+		:
+	else
+		ret=1
+	fi
+done
+if test "$ret" -ne 0
+then
+	echo " ^^^ VERIFICATION MISMATCHES" 1>&2
+else
+	echo All litmus tests verified as was expected. 1>&2
+fi
+exit $ret
-- 
2.40.0.rc2

