Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40616C2702
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 02:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjCUBKJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Mar 2023 21:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjCUBJh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2023 21:09:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5D040F9;
        Mon, 20 Mar 2023 18:08:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB37261932;
        Tue, 21 Mar 2023 01:05:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7F5C4331D;
        Tue, 21 Mar 2023 01:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679360751;
        bh=gpI70LyYK1MnsBJ+dsCexmKpKV1wtgzABQ+Cyr1rAL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kvWuUUYY+Wje1nZaPRVENUQX0GuLAdbDstDVnIm43zSOmxfjOswZsWG/xvLJUcSg2
         zVdb9O+cTOo9jLNyZHS3W06FfagnL0B4pBWFChUtcUpqeVq7zyAYLMz9yX5I4GN/pM
         ghSKJYszu2BDs0m4oobMTzCY7rWyU6iHHlPjTu8eqAP9kfCbBmqgpwVol/3Qb0zWHT
         47dIfWXppSK2VEengygfFp+gNxVrdgdZEB+A7MZNLd4AxLk8crRK9zClGhBwdF4OkS
         BL7PStRy6PoKaAjCUMUx/FMyNsPQV6TFHsCMIzD4cZudTp+FLDo+RO8p7P+YTInWfh
         QTSV28MQ+iIcg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D783F15403CB; Mon, 20 Mar 2023 18:05:50 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model scripts 27/31] tools/memory-model: Add data-race capabilities to judgelitmus.sh
Date:   Mon, 20 Mar 2023 18:05:45 -0700
Message-Id: <20230321010549.51296-27-paulmck@kernel.org>
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
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/scripts/judgelitmus.sh | 40 ++++++++++++++++++-----
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/tools/memory-model/scripts/judgelitmus.sh b/tools/memory-model/scripts/judgelitmus.sh
index 9abda72fe013..2700481d20f0 100755
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
2.40.0.rc2

