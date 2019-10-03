Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1181C95AA
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2019 02:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729844AbfJCA10 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Oct 2019 20:27:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729709AbfJCA1B (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Oct 2019 20:27:01 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB6DB22475;
        Thu,  3 Oct 2019 00:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570062421;
        bh=rHGM/QeLCDI7rkRRUfmjmKDuvYnanGLHZxSqrr9JnTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i+FHaQ+ZDRaFIioD/4q2euZme3rELgDr1Q2QoAp0Myc0/yleomK+rNw8WIhfKwIja
         ib8+EQNsCUuKiSFmhi8xESE1t5E8WVI5hgX+gGOkkUy7aHXdSDf3j7weVtOsQrqBUO
         v3S7tQexLYz+iFsxVQaCOJ/jQZKrKoJMhzlzp80o=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 30/32] tools/memory-model: Add data-race capabilities to judgelitmus.sh
Date:   Wed,  2 Oct 2019 17:26:48 -0700
Message-Id: <20191003002650.11249-30-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003001039.GA8027@paulmck-ThinkPad-P72>
References: <20191003001039.GA8027@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.ibm.com>

This commit adds functionality to judgelitmus.sh to allow it to handle
both the "DATARACE" markers in the "Result:" comments in litmus tests
and the "Flag data-race" markers in LKMM output.  For C-language tests,
if either marker is present, the other must also be as well, at least for
litmus tests having a "Result:" comment.  If the LKMM output indicates
a data race, then failures of the Always/Sometimes/Never portion of the
"Result:" prediction are forgiven.

The reason for forgiving "Result:" mispredictions is that data races can
result in "interesting" compiler optimizations, so that all bets are off
in the data-race case.

[ paulmck: Apply Akira Yokosawa feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/judgelitmus.sh | 40 ++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/tools/memory-model/scripts/judgelitmus.sh b/tools/memory-model/scripts/judgelitmus.sh
index 9abda72..2700481 100755
--- a/tools/memory-model/scripts/judgelitmus.sh
+++ b/tools/memory-model/scripts/judgelitmus.sh
@@ -4,13 +4,19 @@
 # Given a .litmus test and the corresponding litmus output file, check
 # the .litmus.out file against the "Result:" comment to judge whether the
 # test ran correctly.  If the --hw argument is omitted, check against the
-# LKMM output, which is assumed to be in file.litmus.out.  If this argument
-# is provided, this is assumed to be a hardware test, and the output is
-# assumed to be in file.litmus.HW.out, where "HW" is the --hw argument.
-# In addition, non-Sometimes verification results will be noted, but
-# forgiven.  Furthermore, if there is no "Result:" comment but there is
-# an LKMM .litmus.out file, the observation in that file will be used
-# to judge the assembly-language verification.
+# LKMM output, which is assumed to be in file.litmus.out. If either a
+# "DATARACE" marker in the "Result:" comment or a "Flag data-race" marker
+# in the LKMM output is present, the other must also be as well, at least
+# for litmus tests having a "Result:" comment. In this case, a failure of
+# the Always/Sometimes/Never portion of the "Result:" prediction will be
+# noted, but forgiven.
+#
+# If the --hw argument is provided, this is assumed to be a hardware
+# test, and the output is assumed to be in file.litmus.HW.out, where
+# "HW" is the --hw argument. In addition, non-Sometimes verification
+# results will be noted, but forgiven.  Furthermore, if there is no
+# "Result:" comment but there is an LKMM .litmus.out file, the observation
+# in that file will be used to judge the assembly-language verification.
 #
 # Usage:
 #	judgelitmus.sh file.litmus
@@ -47,9 +53,27 @@ else
 	echo ' --- ' error: \"$LKMM_DESTDIR/$litmusout is not a readable file
 	exit 255
 fi
+if grep -q '^Flag data-race$' "$LKMM_DESTDIR/$litmusout"
+then
+	datarace_modeled=1
+fi
 if grep -q '^ \* Result: ' $litmus
 then
 	outcome=`grep -m 1 '^ \* Result: ' $litmus | awk '{ print $3 }'`
+	if grep -m1 '^ \* Result: .* DATARACE' $litmus
+	then
+		datarace_predicted=1
+	fi
+	if test -n "$datarace_predicted" -a -z "$datarace_modeled" -a -z "$LKMM_HW_MAP_FILE"
+	then
+		echo '!!! Predicted data race not modeled' $litmus
+		exit 252
+	elif test -z "$datarace_predicted" -a -n "$datarace_modeled"
+	then
+		# Note that hardware models currently don't model data races
+		echo '!!! Unexpected data race modeled' $litmus
+		exit 253
+	fi
 elif test -n "$LKMM_HW_MAP_FILE" && grep -q '^Observation' $LKMM_DESTDIR/$lkmmout > /dev/null 2>&1
 then
 	outcome=`grep -m 1 '^Observation ' $LKMM_DESTDIR/$lkmmout | awk '{ print $3 }'`
@@ -114,7 +138,7 @@ elif grep '^Observation' $LKMM_DESTDIR/$litmusout | grep -q $outcome || test "$o
 then
 	ret=0
 else
-	if test -n "$LKMM_HW_MAP_FILE" -a "$outcome" = Sometimes
+	if test \( -n "$LKMM_HW_MAP_FILE" -a "$outcome" = Sometimes \) -o -n "$datarace_modeled"
 	then
 		flag="--- Forgiven"
 		ret=0
-- 
2.9.5

