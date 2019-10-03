Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A964C95AB
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2019 02:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbfJCA10 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Oct 2019 20:27:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729702AbfJCA1B (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Oct 2019 20:27:01 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95D962246F;
        Thu,  3 Oct 2019 00:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570062420;
        bh=FfO6o851stvX75j11btJLPmWekyUxBuBi1K1Skf4MyU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L2NS6kOawUIYKuNhf5L28d1q6Id8e3jEwzaS8bd7pTkD3PozWmyWIA2x4wZLgZF56
         sfSfKrQGetHO7ro8smT8YlcA4Wm0uLYKVpbRcy0C1WQdfh6LuQdOU7YKrwj7SzRUUv
         7px+FV8MDP7dt5h6iKUwwNSeHZrM3QnLc3JgNyFg=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 29/32] tools/memory-model: Add checktheselitmus.sh to run specified litmus tests
Date:   Wed,  2 Oct 2019 17:26:47 -0700
Message-Id: <20191003002650.11249-29-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003001039.GA8027@paulmck-ThinkPad-P72>
References: <20191003001039.GA8027@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.ibm.com>

This commit adds a checktheselitmus.sh script that runs the litmus tests
specified on the command line.  This is useful for verifying fixes to
specific litmus tests.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/README              |  8 +++++
 tools/memory-model/scripts/checktheselitmus.sh | 43 ++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)
 create mode 100755 tools/memory-model/scripts/checktheselitmus.sh

diff --git a/tools/memory-model/scripts/README b/tools/memory-model/scripts/README
index 0e29a52..cc2c4e5 100644
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
index 0000000..10eeb5ec
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
2.9.5

